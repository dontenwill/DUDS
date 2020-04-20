unit Duds.Modules.Export.CSV;

interface

uses
  System.SysUtils, System.Classes,

  Xml.XMLDoc, Xml.XMLIntf,

  Duds.Common.Types,
  Duds.Common.Strings,
  Duds.Common.Classes,
  Duds.Common.Files,
  Duds.Common.Language,
  Duds.Common.Log,
  Duds.Common.Interfaces,
  Duds.Modules.Classes,
  Duds.Scan.Model;

type
  TExportModulesToCSV = class
  private
    FModel: TDudsModel;
    fProjectSettings: TProjectSettings;
    FOnLog: TLogProcedure;
    fFileName: string;

  public
    procedure ExportModules;

    property Model: TDudsModel    read FModel    write FModel;
    property OnLog: TLogProcedure read FOnLog    write FOnLog;
    property ProjectSettings: TProjectSettings read fProjectSettings write fProjectSettings;
    property FileName: string read fFileName write fFileName;
  end;

implementation

{ TExportModulesToCSV }

procedure TExportModulesToCSV.ExportModules;
var
  Lines: TStringList;
  CurrentLine: String;
  aModule: TModule;
const
  cCSVSep = ';';
begin
  Lines := TStringList.Create;
  try
    Lines.Add('module_name;origin;usage;files;files_not_in_path;lines_of_code');

    for aModule in fModel.Modules.OrderedModules do
    begin
      CurrentLine := '';
      AddToken(CurrentLine, aModule.Name, cCSVSep);
      AddToken(CurrentLine, TModulesSerializer.cModuleOriginJSONEnumValues[aModule.Origin], cCSVSep);
      AddToken(CurrentLine, TModulesSerializer.cModuleUsageJSONEnumValues[aModule.Usage],   cCSVSep);
      AddToken(CurrentLine, IntToStr(aModule.AnalysisData.NumberOfFiles),                   cCSVSep);
      AddToken(CurrentLine, IntToStr(aModule.AnalysisData.NumberOfFilesNotInPath),          cCSVSep);
      AddToken(CurrentLine, IntToStr(aModule.AnalysisData.LinesOfCode),                     cCSVSep);

      Lines.Add(CurrentLine);
    end;

    Lines.SaveToFile(Filename);
  finally
    FreeAndNil(Lines);
  end;
end;

end.
