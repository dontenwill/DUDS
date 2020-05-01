unit Duds.Scan.DependencyAnalyzer;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,

  Vcl.Forms, // for "Application.ProcessMessages"

  Duds.Common.Utils,
  Duds.Common.Files,
  Duds.Common.Types,
  Duds.Common.Interfaces,
  Duds.Common.Classes,
  Duds.Common.Log,
  Duds.Common.Language,
  Duds.Scan.Model,

  Duds.Common.UnitInfo,
  Duds.Common.UsedUnitInfo,
  Duds.Common.UsesParser;

type
  TDudsDependencyAnalyzer = class(TObject)
  private
    FModel: TDudsModel;
    FOnLog: TLogProcedure;
    fAlreadyLoggedMissingIncludes: TStringList;
    FProjectSettings: TProjectSettings;
    FParsedFileCount: Integer;
    FFMXFormCount: Integer;
    FVCLFormCount: Integer;
    FScannedUsesCount: Integer;
    FScanDepth: Integer;
    FDeepestScanDepth: Integer;
    fLinesOfCode: Integer;
    FSemiCircularFiles: Integer;
    FCircularFiles: Integer;
    FFilesNotInPath: Integer;

    FCancelled: Boolean;

    procedure Log(const Msg: String; const Severity: Integer = LogInfo); overload;
    procedure Log(const Msg: String; const Args: array of const; const Severity: Integer); overload;

    procedure AnalyzeUnitOrProjectFile(Unitname: string; IsRootFile: Boolean);
    procedure AddParsedDelphiFile(UnitInfo: IUnitInfo; IsRootFile: Boolean; InPath: Boolean);
  public
    constructor Create;
    destructor Destroy; override;

    procedure ScanRootFilesAndBuildUsesLists;

    property Model: TDudsModel read FModel write FModel;
    property OnLog: TLogProcedure read FOnLog    write FOnLog;
    property ProjectSettings: TProjectSettings read FProjectSettings write FProjectSettings;

    property ParsedFileCount: Integer read FParsedFileCount;
    property FMXFormCount: Integer read FFMXFormCount;
    property VCLFormCount: Integer read FVCLFormCount;
    property ScannedUsesCount: Integer read FScannedUsesCount;
    property DeepestScanDepth: Integer read FDeepestScanDepth;
    property LinesOfCode: Integer read fLinesOfCode;
    property SemiCircularFiles: Integer read FSemiCircularFiles;
    property CircularFiles: Integer read FCircularFiles;
    property FilesNotInPath: Integer read FFilesNotInPath;

    property Cancelled: Boolean read FCancelled write FCancelled;

  end;

implementation

{ TDudsDependencyAnalyzer }

constructor TDudsDependencyAnalyzer.Create;
begin
  FParsedFileCount   := 0;
  FFMXFormCount      := 0;
  FVCLFormCount      := 0;
  FScannedUsesCount  := 0;
  FScanDepth         := 0;
  FDeepestScanDepth  := 0;
  fLinesOfCode       := 0;
  FSemiCircularFiles := 0;
  FCircularFiles     := 0;
  FFilesNotInPath    := 0;
  fAlreadyLoggedMissingIncludes := TStringList.Create(TDuplicates.dupError, true, false);
end;

destructor TDudsDependencyAnalyzer.Destroy;
begin
  fAlreadyLoggedMissingIncludes.Free;
  inherited;
end;

procedure TDudsDependencyAnalyzer.Log(const Msg: String; const Severity: Integer);
begin
  if Assigned(FOnLog) then
    FOnLog('Dependency Analyzer: ' + Msg, Severity);
end;

procedure TDudsDependencyAnalyzer.Log(const Msg: String; const Args: array of const; const Severity: Integer);
begin
  Log(Format(Msg, Args), Severity);
end;

procedure TDudsDependencyAnalyzer.AddParsedDelphiFile(UnitInfo: IUnitInfo; IsRootFile: Boolean; InPath: Boolean);
var
  DelphiFile: TDelphiFile;
begin
  DelphiFile := FModel.CreateDelphiFile(UnitInfo.DelphiUnitName, IsRootFile);

  DelphiFile.UnitInfo := UnitInfo;

  if FScanDepth = 1 then // this is for "root" files
    DelphiFile.UsedCount := 0
  else
    DelphiFile.UsedCount := 1;

  DelphiFile.InSearchPath := InPath;
end;

procedure TDudsDependencyAnalyzer.AnalyzeUnitOrProjectFile(Unitname: string; IsRootFile: Boolean);
var
  Filename: String;
  FoundFileInPaths: Boolean;
  Parsed: Boolean;
  UnitInfo: IUnitInfo;
  UsedUnitInfo: IUsedUnitInfo;
  DelphiFile: TDelphiFile;
  aUsesParser : TUsesParser;
begin
  Application.ProcessMessages;

  if not FCancelled then
  begin
    Inc(FScannedUsesCount);
    Inc(FScanDepth);

    if FScanDepth > FDeepestScanDepth then
      FDeepestScanDepth := FScanDepth;

    // Did we already parse this file? (also try unit scopes, so that we e.g. find `System.Classes` when
    // we search for `Classes` and already parsed `System.Classes` before
    DelphiFile := FModel.FindParsedDelphiUnit(Unitname, FProjectSettings.UnitScopeNames);

    // File was not parsed already -> try to find it on disk and parse it
    if not Assigned(DelphiFile) then
    begin
      // Do we have the file on disk? (also try unit scopes here)
      FoundFileInPaths := FModel.SearchUnitByNameWithScopes(Unitname, Filename, FProjectSettings.UnitScopeNames);

      // Parse the unit
      if FoundFileInPaths then
      begin
        Parsed := FALSE;
        try
          // parse the file (.pas, .dpr, .dpk, ...) and extract the used units into `UnitInfo`
          // -> this returns `FALSE` e.g. when it is an unknown file type
          aUsesParser := TUsesParser.Create;
          try
            aUsesParser.OnLog := fOnLog;
            aUsesParser.AlreadyLoggedMissingIncludes := fAlreadyLoggedMissingIncludes;
            Parsed := aUsesParser.GetUsedUnitsFromFile(Filename, UnitInfo);
          finally
            FreeAndNil(aUsesParser);
          end;

          // when used unit have a "in '..filename.pas'" part, then those files might not be part of the
          // "known" files in the model yet => add them
          for UsedUnitInfo in UnitInfo.UsedUnits do
            if UsedUnitInfo.Filename <> '' then
              FModel.Files.AddOrSetValue(UpperCase(UsedUnitInfo.DelphiUnitName), UsedUnitInfo.Filename);

          AddParsedDelphiFile(UnitInfo, IsRootFile, TRUE);

          fLinesOfCode := fLinesOfCode + UnitInfo.LinesOfCode;
          Inc(FParsedFileCount);

          if FileExists(ChangeFileExt(UnitInfo.Filename, '.dfm')) then
            Inc(FVCLFormCount)
          else if FileExists(ChangeFileExt(UnitInfo.Filename, '.fmx')) then
            Inc(FFMXFormCount);
        except
          on e: Exception do
            TDudsLogger.GetInstance.Log(StrUnableToParseS, [Filename, e.Message], LogError);
        end;

        if Parsed then
          for UsedUnitInfo in UnitInfo.UsedUnits do
            if not FCancelled then
              AnalyzeUnitOrProjectFile(UsedUnitInfo.DelphiUnitName, FALSE);

      end else
      // we don't have the file on disk...
      begin
        Inc(FFilesNotInPath);

        // create an empty "parsed file" for the file that was not found on disk (still needed for the "UsedCount" counter)
        UnitInfo := TUnitInfo.Create;
        UnitInfo.DelphiUnitName := Unitname;
        AddParsedDelphiFile(UnitInfo, IsRootFile, FALSE);
      end;
    end
    // the File was already parsed -> only increase the usage counter
    else
      DelphiFile.UsedCount := DelphiFile.UsedCount + 1;

  end;

  if FScanDepth > 0 then
    Dec(FScanDepth);
end;

procedure TDudsDependencyAnalyzer.ScanRootFilesAndBuildUsesLists;
var
  RootFile: string;
begin
  TDudsLogger.GetInstance.Log(StrParsingFiles);

  for RootFile in fModel.RootFiles do
    AnalyzeUnitOrProjectFile(ExtractFilenameNoExt(RootFile), True);

  TDudsLogger.GetInstance.Log(StrDFilesWithATo, [FormatCardinal(FModel.ParsedDelphiFiles.Count), FormatCardinal(fLinesOfCode)]);
end;

end.
