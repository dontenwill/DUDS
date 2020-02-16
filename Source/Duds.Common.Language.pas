unit Duds.Common.Language;

interface

resourcestring
  StrYes = 'Yes';
  StrNo = 'No';
  StrSHasBeenModifi = '"%s" has been modified. Would you like to save the changes?';
  StrScanningDSearchRootFiles = 'Scanning %d root files';
  StrScanningDSearchSearchPaths = 'Scanning %d search paths (expanded from %d defined paths)';
  StrDFilesFound = '%d matching file(s) found in the search paths';
  StrParsingFiles = 'Parsing files';
  StrDFilesWithATo = '%d used unit(s) found and a total of %d lines parsed';
  StrUpdateTheUsesClauseIn = 'Update the uses clause in "%s"?';
  StrUnableToFindFile = 'Unable to find file "%s"';
  StrUsesClauseIn = '"%s" not updated as the text has been changed from "%s" to "%s"';
  StrTHISISADUMMYRUN = 'THIS IS A DUMMY RUN. NO FILES WILL BE UPDATED!';
  StrTHISWASADUMMYRUN = 'THIS WAS A DUMMY RUN. NO FILES WERE UPDATED!';
  StrFinishedUpdated = 'Finished - Updated %d uses clauses';
  StrUnableToRenameS = 'Unable to rename "%s" as the unit name was not found';
  StrUpdatedDelphiUnitNameIn = 'Updated unit name in "%s" from "%s" to "%s"';
  StrUpdatedUsesClause = 'Replaced "%s" with "%s" in the uses clause of "%s"';
  StrScannedFiles = 'Processed Files';
  StrSemiCircularFiles = 'Semi Circular references';
  StrFCircularFiles = 'Circular references';
  StrParsedFiles = 'Unique Parsed Files';
  StrFilesFound = 'Total Used Units';
  StrTotalLines = 'Total Lines of Code';
  StrSearchPathFiles = 'Search Path Files';
  StrScanDepth = 'Current Scan Depth';
  StrSFoundInMultip = '"%s" found in multiple search paths. "%s" will be used and "%s" ignored';
  StrTime = 'Elapsed Time';
  StrUnitDependencyScan = 'Delphi Unit Dependency Scanner';
  StrHistory = 'History ';
  StrTheProjectHasBeen = 'The project has been modified. Would you like to save it now?';
  StrYouNeedToAddAtLeastOne =
    'You need to add at least one root file before you can scan the dependencies. Would you like to add a root file now?';
  StrDeepestScanDepth = 'Deepest Scan Depth';
  StrRenameS = 'Rename "%s"';
  StrPleaseStopTheCurr = 'Please stop the current scan first.';
  StrFileSRenamedTo = 'File "%s" renamed to "%s"';
  StrRootFileNotFound = 'Root file not found: "%s"';
  StrUnableToParseS = 'Unable to parse "%s": %s';
  StrVCLFormCount = 'VCL Form Count';
  StrFMXFormCount = 'FMX Form Count';
  StrStartBatchRename = 'Batch-Rename from CSV: Renaming unit "%s" to "%s"';
  StrBatchRenameResult = 'Batch-Rename finished. Renamed %d units.';
  StrUnableToRenameToNewName = 'Unable to rename "%s" because "%s" already exists.';
  StrNumberOfAlreadyReferencingUnits = '%d units were not updated because the new unit was already referenced in the uses clause.';

implementation

end.