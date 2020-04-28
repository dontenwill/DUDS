unit Duds.Modules.Analyzer;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
  System.JSON, IOUtils,

  Duds.Common.Interfaces,
  Duds.Common.Language,
  Duds.Common.Types,
  Duds.Common.Log,
  Duds.Scan.Model,
  Duds.Common.Classes,
  Duds.Modules.Classes;

type
  TModulesAnalyzer = class
  public
    class procedure MapUnitsToModules(Model: TDudsModel; out UnitsTotal, UnitsMapped: Integer);

  end;

implementation

{ TModulesAnalyzer }

class procedure TModulesAnalyzer.MapUnitsToModules(Model: TDudsModel; out UnitsTotal, UnitsMapped: Integer);
var
  aDelphiFile: TDelphiFile;
  i: integer;
  aModule: TModule;
begin
  Model.Modules.ClearModulesAnalysisData;
  Model.Modules.ReBuildFastSearchList;
  Model.Modules.CreateUnknownModule;

  UnitsTotal := 0;
  UnitsMapped := 0;
  for i := 0 to pred(Model.DelphiFileList.Count) do
  begin
    aDelphiFile := Model.DelphiFileList[i];
    if (aDelphiFile.UnitInfo.DelphiFileType = ftPAS) or (not aDelphiFile.InSearchPath) then  // files that are not in search path do not get a filetype but should be '.pas'...
    begin
      Inc(UnitsTotal);

      // try to find a matching module
      if Model.Modules.FindModuleForUnit(aDelphiFile.UnitInfo, aModule) then
        Inc(UnitsMapped)
      else
        aModule := Model.Modules.UnknownModule;

      aDelphiFile.UnitInfo.Module := aModule;

      // update the modules analysis data
      aModule.AnalysisData.NumberOfFiles := aModule.AnalysisData.NumberOfFiles + 1;
      if not aDelphiFile.InSearchPath then
        aModule.AnalysisData.NumberOfFilesNotInPath := aModule.AnalysisData.NumberOfFilesNotInPath + 1;
      aModule.AnalysisData.LinesOfCode   := aModule.AnalysisData.LinesOfCode   + aDelphiFile.UnitInfo.LinesOfCode;
    end;
  end;
end;

end.