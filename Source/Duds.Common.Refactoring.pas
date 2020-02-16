unit Duds.Common.Refactoring;

interface

uses
  SysUtils, System.Classes, System.Generics.Collections,

  Duds.Common.Classes,
  Duds.Common.Language,
  Duds.Common.Log,
  Duds.Common.Interfaces;

function SafeReplaceTextInFile(DummyRun: Boolean; Filename, OldUnitName, NewUnitName: String;
  Position: Integer): Boolean;

procedure AddUnitToUsesInFile(DummyRun: Boolean; DelphiFile: TDelphiFile; InsertAtUsesUnitName: string;
  NewUnitName: String);

implementation

function SafeReplaceTextInString(var FileText: String; const Filename, OldText, NewText: String; Position: Integer): Boolean;
var
  CurrentText: String;
begin
  Result := FALSE;

  CurrentText := Copy(FileText, Position + 1, Length(OldText));

  if not SameText(CurrentText, OldText) then
    TDudsLogger.GetInstance.Log(StrUsesClauseIn, [Filename, OldText, CurrentText], LogWarning)
  else
  begin
    Delete(FileText, Position + 1, Length(OldText));

    Insert(NewText, FileText, Position + 1);

    Result := TRUE;
  end;
end;

function SafeReplaceTextInFile(DummyRun: Boolean; Filename, OldUnitName, NewUnitName: String; Position: Integer): Boolean;
var
  UpdateStrings: TStringList;
  FileText: String;
begin
  Result := FALSE;

  if Position <= 0 then
     raise Exception.CreateFmt('invalid usage: Position must be > 0 but is %d', [Position]);

  UpdateStrings := TStringList.Create;
  try
    if FileExists(Filename) then
    begin
      UpdateStrings.LoadFromFile(Filename);

      FileText := UpdateStrings.Text;

      Result := SafeReplaceTextInString(FileText, Filename, OldUnitName, NewUnitName, Position);

      UpdateStrings.Text := FileText;

      if not DummyRun then
        UpdateStrings.SaveToFile(Filename);
    end
    else
      TDudsLogger.GetInstance.Log(StrUnableToFindFile, [Filename], LogWarning);
  finally
    FreeAndNil(UpdateStrings);
  end;
end;

procedure AddUnitToUsesInFile(DummyRun: Boolean; DelphiFile: TDelphiFile; InsertAtUsesUnitName: string;
  NewUnitName: String);
var
  InsertAtUnit: IUsedUnitInfo;
  usedUnit: IUsedUnitInfo;
  ReplacementText: string;
begin
  InsertAtUnit := nil;
  for usedUnit in DelphiFile.UnitInfo.UsedUnits do
    if usedUnit.DelphiUnitName.Equals(InsertAtUsesUnitName) then
       InsertAtUnit := usedUnit;

  if InsertAtUnit = nil then
     raise Exception.Create('internal error - referenced unit not found in uses clause');  


  ReplacementText := NewUnitName + ', ' + InsertAtUsesUnitName;

  SafeReplaceTextInFile(DummyRun, DelphiFile.UnitInfo.Filename, InsertAtUsesUnitName, ReplacementText, InsertAtUnit.Position);
end;

end.