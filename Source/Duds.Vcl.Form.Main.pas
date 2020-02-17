// -----------------------------------------------------------------------------
//
// The contents of this file are subject to the Mozilla Public License
// Version 2.0 (the "License"); you may not use this file except in compliance
// with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/
//
// Alternatively, you may redistribute this library, use and/or modify it under
// the terms of the GNU Lesser General Public License as published by the
// Free Software Foundation; either version 2.1 of the License, or (at your
// option) any later version. You may obtain a copy of the LGPL at
// http://www.gnu.org/copyleft/.
//
// Software distributed under the License is distributed on an "AS IS" basis,
// WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
// the specific language governing rights and limitations under the License.
//
// Orginally released as freeware then open sourced in July 2017.
//
// The initial developer of the original code is Easy-IP AS
// (Oslo, Norway, www.easy-ip.net), written by Paul Spencer Thornton -
// paul.thornton@easy-ip.net.
//
// (C) 2017 Easy-IP AS. All Rights Reserved.
//
// -----------------------------------------------------------------------------

unit Duds.Vcl.Form.Main;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.ImageList,
  System.Actions, System.DateUtils, System.RegularExpressions,
  System.Generics.Collections, System.UITypes, System.IOUtils,

  Xml.XMLDoc, Xml.XMLIntf,

  Winapi.Windows, Winapi.Messages, Winapi.ShellAPI,
  System.Win.Registry,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.ActnList, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ImgList, Vcl.ActnCtrls, Vcl.PlatformDefaultStyleActnCtrls, Vcl.Mask,
  Vcl.Menus,

  VirtualTrees,

  SynEditHighlighter, SynHighlighterPas, SynEdit,

  Duds.Common.Types,
  Duds.Common.Classes,
  Duds.Common.Files,
  Duds.Common.Strings,
  Duds.Common.Utils,
  Duds.Common.Interfaces,
  Duds.Common.Parser.Pascal,
  Duds.Common.Refactoring,
  Duds.Common.Language,
  Duds.Common.Log,
  Duds.Model,
  Duds.Export.Gephi,
  Duds.Export.GraphML,
  Duds.FileScanner,

  Duds.Vcl.HourGlass,
  Duds.Vcl.Utils,
  Duds.Vcl.VirtualTreeview;

type
  TfrmMain = class(TForm)
    SynPasSyn1: TSynPasSyn;
    ActionManager1: TActionManager;
    actStartScan: TAction;
    actShowUnitsNotInPath: TAction;
    actSaveChanges: TAction;
    actRename: TAction;
    actApplyRenameList: TAction;
    popTree: TPopupMenu;
    Rename1: TMenuItem;
    ShowUnitsnotinPath1: TMenuItem;
    N1: TMenuItem;
    actExpandAll: TAction;
    actExpand: TAction;
    actCollapseAll: TAction;
    actCollapse: TAction;
    N3: TMenuItem;
    Expand1: TMenuItem;
    ExpandAll1: TMenuItem;
    Collapse1: TMenuItem;
    CollapseAll1: TMenuItem;
    N4: TMenuItem;
    actStopScan: TAction;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    actSettings: TAction;
    Settings1: TMenuItem;
    N5: TMenuItem;
    actExit: TAction;
    Exit1: TMenuItem;
    Scan1: TMenuItem;
    View1: TMenuItem;
    Scan2: TMenuItem;
    Stop1: TMenuItem;
    ShowUnitsnotinPath2: TMenuItem;
    N6: TMenuItem;
    ExpandAll2: TMenuItem;
    CollapseAll2: TMenuItem;
    Edit1: TMenuItem;
    Rename2: TMenuItem;
    SaveChanges1: TMenuItem;
    N7: TMenuItem;
    actLoadProject: TAction;
    actSaveProject: TAction;
    actSaveProjectAs: TAction;
    LoadProject1: TMenuItem;
    SaveProject1: TMenuItem;
    SaveProjectAs1: TMenuItem;
    N2: TMenuItem;
    N8: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    OpenDialogMultipleRenames: TOpenDialog;
    ActionToolBar1: TActionToolBar;
    pnlBackground: TPanel;
    pnlMain: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    pcView: TPageControl;
    tabTree: TTabSheet;
    Splitter2: TSplitter;
    pnlTree: TPanel;
    Panel5: TPanel;
    pcSource: TPageControl;
    tabParentFile: TTabSheet;
    memParentFile: TSynEdit;
    tabSelectedFile: TTabSheet;
    memSelectedFile: TSynEdit;
    tabList: TTabSheet;
    Splitter3: TSplitter;
    pnlList: TPanel;
    Panel10: TPanel;
    pnlLog: TPanel;
    Panel9: TPanel;
    pcList: TPageControl;
    tabUsedBy: TTabSheet;
    tabSource: TTabSheet;
    memListFile: TSynEdit;
    tmrClose: TTimer;
    tabUsesList: TTabSheet;
    actNewProject: TAction;
    actCloseProject: TAction;
    New1: TMenuItem;
    N10: TMenuItem;
    Close1: TMenuItem;
    N9: TMenuItem;
    actSearchAndReplace: TAction;
    SearchandReplace1: TMenuItem;
    tmrLoaded: TTimer;
    actShowFile: TAction;
    ShowfileinWindowsExplorer1: TMenuItem;
    N11: TMenuItem;
    actSaveToXML: TAction;
    SaveDialog2: TSaveDialog;
    actSaveToGephiCSV: TAction;
    N12: TMenuItem;
    SavetoXML1: TMenuItem;
    SavetoGephiCSV1: TMenuItem;
    SaveDialogGephiCSV: TSaveDialog;
    actSaveToGraphML: TAction;
    SaveDialog4: TSaveDialog;
    edtSearch: TEdit;
    edtListSearch: TEdit;
    edtSearchUsedByList: TEdit;
    edtSearchUsesList: TEdit;
    vtUnitsList: TVirtualStringTree;
    vtUnitsTree: TVirtualStringTree;
    vtUsedByUnits: TVirtualStringTree;
    vtUsesUnits: TVirtualStringTree;
    vtStats: TVirtualStringTree;
    ImageList1: TImageList;
    vtLog: TVirtualStringTree;
    SearchandReplace2: TMenuItem;
    N13: TMenuItem;
    ActionSaveCirRefs: TAction;
    Savecircularreference1: TMenuItem;
    RichEditUnitPath: TRichEdit;
    PanelFooter: TPanel;
    Splitter4: TSplitter;
    actAddUnitToUses: TAction;
    Applymultiplerenamesdefinedincsv1: TMenuItem;
    Addunittouseslistinallfilesthatcurrentlyusethisunit1: TMenuItem;
    N14: TMenuItem;
    Addunittouseslistinallfilesthatcurrentlyusethisunit2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vtUnitsTreeGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure vtUnitsTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure edtSearchEditChange(Sender: TObject);
    procedure vtUnitsTreePaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vtUnitsTreeBeforeItemErase(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
      ItemRect: TRect; var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure vtUnitsTreeFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure vtUnitsTreeGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
      Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: TImageIndex);
    procedure vtUnitsTreeDblClick(Sender: TObject);
    procedure actStartScanExecute(Sender: TObject);
    procedure actShowUnitsNotInPathExecute(Sender: TObject);
    procedure ActionManager1Update(Action: TBasicAction; var Handled: Boolean);
    procedure vtUnitsTreeFocusChanging(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode;
      OldColumn, NewColumn: TColumnIndex; var Allowed: Boolean);
    procedure memParentFileChange(Sender: TObject);
    procedure memSelectedFileChange(Sender: TObject);
    procedure actSaveChangesExecute(Sender: TObject);
    procedure actRenameExecute(Sender: TObject);
    procedure edtSearchEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtSearchEditKeyPress(Sender: TObject; var Key: Char);
    procedure actExpandAllExecute(Sender: TObject);
    procedure actExpandExecute(Sender: TObject);
    procedure actCollapseAllExecute(Sender: TObject);
    procedure actCollapseExecute(Sender: TObject);
    procedure vtUnitsListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: string);
    procedure vtStatsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure vtStatsPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vtUnitsListFocusChanging(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode;
      OldColumn, NewColumn: TColumnIndex; var Allowed: Boolean);
    procedure vtUnitsListFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure vtUnitsListSearchComparison(Sender: TObject; Node: PVirtualNode; const SearchTerms: TStrings;
      var IsMatch: Boolean);
    procedure edtListSearchEditChange(Sender: TObject);
    procedure vtUnitsListDblClick(Sender: TObject);
    procedure vtUnitsListPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure actStopScanExecute(Sender: TObject);
    procedure memListFileChange(Sender: TObject);
    procedure vtUnitsListCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
      var Result: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure vtUnitsTreeCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
      var Result: Integer);
    procedure actExitExecute(Sender: TObject);
    procedure actSettingsExecute(Sender: TObject);
    procedure actLoadProjectExecute(Sender: TObject);
    procedure actSaveProjectExecute(Sender: TObject);
    procedure actSaveProjectAsExecute(Sender: TObject);
    procedure tmrCloseTimer(Sender: TObject);
    procedure edtSearchUsedByListEditChange(Sender: TObject);
    procedure edtSearchUsesListEditChange(Sender: TObject);
    procedure actNewProjectExecute(Sender: TObject);
    procedure actCloseProjectExecute(Sender: TObject);
    procedure actSearchAndReplaceExecute(Sender: TObject);
    procedure edtSearchSearchClick(Sender: TObject);
    procedure tmrLoadedTimer(Sender: TObject);
    procedure actShowFileExecute(Sender: TObject);
    procedure actSaveToXMLExecute(Sender: TObject);
    procedure actSaveToGephiCSVExecute(Sender: TObject);
    procedure actSaveToGraphMLExecute(Sender: TObject);
    procedure vtLogGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure vtCommonHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure vtLogGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: TImageIndex);
    procedure vtCommonGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
      Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: TImageIndex);
    procedure ActionSaveCirRefsExecute(Sender: TObject);
    procedure actApplyRenameListExecute(Sender: TObject);
    procedure actAddUnitToUsesExecute(Sender: TObject);    
  private
    FModel: TDudsModel;
    FNodeObjects: TObjectList<TNodeObject>;
    FSearchText: String;
    FPascalUnitExtractor: TPascalUnitExtractor;
    FLineCount: Integer;
    FStats: TStringList;
    FScannedFiles: Integer;
    FSemiCircularFiles: Integer;
    FCircularFiles: Integer;
    FScanDepth: Integer;
    FCancelled: Boolean;
    FStartTime: TDateTime;
    FBusy: Boolean;
    FpnlLogHeight: Integer;
    FEnvironmentSettings: TEnvironmentSettings;
    FProjectSettings: TProjectSettings;
    FProjectFilename: String;
    FLoadLastProject: Boolean;
    FModified: Boolean;
    FParsedFileCount: Integer;
    FFMXFormCount: Integer;
    FVCLFormCount: Integer;
    FNextStatusUpdate: TDateTime;
    FDeppestScanDepth: Integer;
    FLastScanNode: PVirtualNode;
    FClosing: Boolean;
    FShowTermParents: Boolean;
    FRunScanOnLoad: Boolean;

    procedure BuildDependencyTree(NoLog: Boolean = FALSE);
    procedure SearchTree(const SearchText: String; FromFirstNode: Boolean);
    function IsSearchHitNode(Node: PVirtualNode): Boolean;
    function GetNodePath(Node: PVirtualNode): String;
    procedure SetNodePathRichEdit(Node: PVirtualNode; ARichEdit: TRichEdit);
    procedure ShowUnitsNotInPath;
    procedure SetNodeVisibility(VT: TVirtualStringTree; Node: PVirtualNode; DelphiFile: TDelphiFile);
    function GetLinkedNode(Node: PVirtualNode): PVirtualNode;
    procedure UpdateTreeControls(Node: PVirtualNode);
    procedure RenameDelphiFile(const aClearLog: Boolean; const SearchString, ReplaceString: String;
      PromptBeforeUpdate: Boolean; const DummyRun, RenameHistoryFiles, ExactMatch, InsertOldNameComment,
      LowerCaseExtension: Boolean);
    procedure UpdateStats(ForceUpdate: Boolean);
    procedure UpdateListControls(Node: PVirtualNode);
    procedure ShowHideControls;
    procedure LoadSettings;
    procedure SaveSettings;
    function LoadProjectSettings(const Filename: String = ''; RunScanAfterLoad: Boolean = TRUE): Boolean;
    procedure SaveProjectSettings(const Filename: String = '');
    function GetSettingsFilename: String;
    procedure ExpandAll;
    procedure UpdateControls;
    procedure SetFormCaption;
    procedure SetModified(const Value: Boolean);
    function CheckSaveProject: Boolean;
    function SaveProject: Boolean;
    function SaveProjectAs: Boolean;
    function RenameDelphiFileWithDialog(RenameType: TRenameType): Boolean; overload;
    function RenameDelphiFileWithDialog(const DelphiFile: TDelphiFile; RenameType: TRenameType): Boolean; overload;
    procedure ApplyMultipleRenames(aCsvFilename: String; DummyRun, RenameHistoryFiles, InsertOldNameComment,
      RenameLowerCaseExtension: Boolean);
    procedure SearchList(VT: TVirtualStringTree; const SearchText: String);
    procedure SearchUnitsListChildList(VT: TVirtualStringTree; const SearchText: String; UsedBy: Boolean);
    procedure CloseControls;
    function CheckNotRunning: Boolean;
    procedure ResetSettings;
    procedure ClearStats;
    function GetFocusedDelphiFile: TDelphiFile;
    procedure ExportToXML(const VT: TVirtualStringTree; const Filename: String);

    procedure Log(const Msg: String; const Severity: Integer = LogInfo); overload;
    procedure Log(const Msg: String; const Args: array of const; const Severity: Integer = LogInfo); overload;

    function GetID(const Node: PVirtualNode): Integer;
    procedure SetID(const Node: PVirtualNode; const ID: Integer);
    function GetFocusedID(const VT: TVirtualStringTree): Integer;
    function GetNodeIndex(const Node: PVirtualNode): Integer;
    procedure UpdateLogEntries;
    procedure ClearLog;
    procedure FixDPI;
    procedure AddUnitToUses(DummyRun: Boolean; DelphiFile: TDelphiFile; NewUnitName: String);

    property Modified: Boolean read FModified write SetModified;
  end;

var
  frmMain: TfrmMain;

implementation

uses
  Duds.Vcl.Form.Rename,
  Duds.Vcl.Form.Settings,
  Duds.Vcl.Form.FindReplace,
  Duds.Vcl.Form.AddNewUnitWhereThisUnitIsUsed;

{$R *.dfm}

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if FClosing then
  begin
    CloseControls;
  end
  else
  begin
    CanClose := FALSE;

    if CheckSaveProject then
    begin
      actStopScan.Execute;

      tmrClose.Enabled := TRUE;
    end;
  end;
end;

function TfrmMain.CheckSaveProject: Boolean;
begin
  Result := not Modified;

  if not Result then
  begin
    case MessageDlg(StrTheProjectHasBeen, mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        Result := SaveProject;
      mrNo:
        Result := TRUE;
      mrCancel:
        Abort;
    end;
  end;
end;

function TfrmMain.GetID(const Node: PVirtualNode): Integer;
var
  NodeData: PNodeData;
begin
  NodeData := Node.GetData;

  if Assigned(NodeData) then
  begin
    Result := NodeData.ID;
  end
  else
  begin
    raise Exception.Create('No node data found');
  end;
end;

procedure TfrmMain.SetID(const Node: PVirtualNode; const ID: Integer);
var
  NodeData: PNodeData;
begin
  NodeData := Node.GetData;

  if Assigned(NodeData) then
  begin
    NodeData.ID := ID;
    NodeData.Index := Node.Index;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  pcSource.ActivePageIndex := 0;
  pcView.ActivePageIndex := 0;
  pcList.ActivePageIndex := 0;

  vtUnitsList.NodeDataSize := SizeOf(TNodeData);
  vtUnitsTree.NodeDataSize := SizeOf(TNodeData);
  vtUsedByUnits.NodeDataSize := SizeOf(TNodeData);
  vtUsesUnits.NodeDataSize := SizeOf(TNodeData);
  vtStats.NodeDataSize := SizeOf(TNodeData);

  FModel := TDudsModel.Create;
  FNodeObjects := TObjectList<TNodeObject>.Create(TRUE);
  FStats := TStringList.Create;

  FEnvironmentSettings := TEnvironmentSettings.Create;
  FProjectSettings := TProjectSettings.Create;

  FPascalUnitExtractor := TPascalUnitExtractor.Create(Self);

  UpdateTreeControls(nil);
  UpdateListControls(nil);

  FLoadLastProject := TRUE;
  FShowTermParents := FALSE;
  FRunScanOnLoad := TRUE;

  FixDPI;

  LoadSettings;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  SaveSettings;

  FreeAndNil(FModel);
  FreeAndNil(FStats);
  FreeAndNil(FEnvironmentSettings);
  FreeAndNil(FProjectSettings);
  FreeAndNil(FNodeObjects);
end;

procedure TfrmMain.Log(const Msg: String; const Severity: Integer);
begin
  TDudsLogger.GetInstance.Log(Msg, Severity);
  UpdateLogEntries;
end;

procedure TfrmMain.Log(const Msg: String; const Args: array of const; const Severity: Integer);
begin
  Log(Format(Msg, Args), Severity);
end;

function TfrmMain.LoadProjectSettings(const Filename: String; RunScanAfterLoad: Boolean): Boolean;
begin
  Result := FALSE;

  if FProjectSettings.LoadFromFile(Filename) then
  begin
    if (FProjectFilename <> '') and (RunScanAfterLoad) and (FRunScanOnLoad) and (FProjectSettings.RootFiles.Count > 0)
    then
      actStartScan.Execute;

    SetFormCaption;

    Result := TRUE;
  end;
end;

function TfrmMain.GetSettingsFilename: String;
begin
  Result := IncludeTrailingPathDelimiter(TPath.GetDocumentsPath) + 'DUDS\config.ini';
end;

procedure TfrmMain.LoadSettings;
begin
  if FEnvironmentSettings.LoadFromFile(GetSettingsFilename) then
  begin
    pnlLog.Height := FEnvironmentSettings.StatusLogHeight;
    pnlTree.Width := FEnvironmentSettings.TreeWidth;
    pnlList.Width := FEnvironmentSettings.ListWidth;
    actShowUnitsNotInPath.Checked := FEnvironmentSettings.ShowUnitsNotInPath;
    FLoadLastProject := FEnvironmentSettings.LoadLastProject;
    FProjectFilename := FEnvironmentSettings.ProjectFilename;
    FRunScanOnLoad := FEnvironmentSettings.RunScanOnLoad;

    Left := FEnvironmentSettings.WindowLeft;
    Top := FEnvironmentSettings.WindowTop;
    Width := FEnvironmentSettings.WindowWidth;
    Height := FEnvironmentSettings.WindowHeight;
    PanelFooter.Height := FEnvironmentSettings.UnitPatchHeight;

    WindowState := TWindowState(FEnvironmentSettings.WindowState);
  end;
end;

procedure TfrmMain.memListFileChange(Sender: TObject);
begin
  memListFile.Modified := TRUE;
end;

procedure TfrmMain.memParentFileChange(Sender: TObject);
begin
  memParentFile.Modified := TRUE;
end;

procedure TfrmMain.memSelectedFileChange(Sender: TObject);
begin
  memSelectedFile.Modified := TRUE;
end;

procedure TfrmMain.edtListSearchEditChange(Sender: TObject);
begin
  SearchList(vtUnitsList, edtListSearch.Text);
end;

procedure TfrmMain.edtSearchEditChange(Sender: TObject);
begin
  SearchTree(edtSearch.Text, TRUE);
end;

procedure TfrmMain.edtSearchEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 00;

    if edtSearch.Text <> '' then
      SearchTree(edtSearch.Text, FALSE);
  end;
end;

procedure TfrmMain.ClearLog;
begin
  TDudsLogger.GetInstance.Clear;
  UpdateLogEntries;
end;

procedure TfrmMain.edtSearchEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Key := #00;
end;

procedure TfrmMain.edtSearchSearchClick(Sender: TObject);
begin
  SearchTree(edtSearch.Text, FALSE);
end;

procedure TfrmMain.edtSearchUsedByListEditChange(Sender: TObject);
begin
  SearchUnitsListChildList(vtUsedByUnits, edtSearchUsedByList.Text, TRUE);
end;

procedure TfrmMain.edtSearchUsesListEditChange(Sender: TObject);
begin
  SearchUnitsListChildList(vtUsesUnits, edtSearchUsesList.Text, FALSE);
end;

function TfrmMain.GetFocusedID(const VT: TVirtualStringTree): Integer;
begin
  Result := GetID(VT.FocusedNode);
end;

// search detail-list "Uses Unit" or "Used by Unit"
procedure TfrmMain.SearchUnitsListChildList(VT: TVirtualStringTree; const SearchText: String; UsedBy: Boolean);
var
  Node: PVirtualNode;
  LowerSearchText, UsesOrUsedUnitName: String;
  UsesOrUsedDelphiFile, DelphiFile: TDelphiFile;
  InSearchPathOrShowAll,
  UnitMatchesList, UnitMatchesSearchTerm: Boolean;
begin
  VT.BeginUpdate;
  try
    LowerSearchText := LowerCase(SearchText);

    Node := VT.GetFirst;

    while Node <> nil do
    begin
      DelphiFile := FModel.DelphiFileList[GetID(Node)];

      if UsedBy then
        UnitMatchesList := FModel.IsUnitUsed(
          FModel.DelphiFileList[GetFocusedID(vtUnitsList)].UnitInfo.DelphiUnitName,
          DelphiFile)
      else
        UnitMatchesList := FModel.IsUnitUsed(
          DelphiFile.UnitInfo.DelphiUnitName,
          FModel.DelphiFileList[GetFocusedID(vtUnitsList)]);

      InSearchPathOrShowAll := DelphiFile.InSearchPath or (not DelphiFile.InSearchPath and
        actShowUnitsNotInPath.Checked);
      UnitMatchesSearchTerm := ((LowerSearchText = '') or ((pos(LowerSearchText, LowerCase(DelphiFile.UnitInfo.DelphiUnitName)) <> 0)));

      VT.IsVisible[Node] := UnitMatchesSearchTerm and InSearchPathOrShowAll and UnitMatchesList;

      Node := Node.NextSibling;
    end;

    VT.Invalidate;
  finally
    VT.EndUpdate;
  end;
end;

procedure TfrmMain.SaveProjectSettings(const Filename: String);
begin
  if Filename <> '' then
  begin
    FProjectSettings.SaveToFile(Filename);

    Modified := FALSE;
  end;
end;

procedure TfrmMain.SaveSettings;
begin
  FEnvironmentSettings.StatusLogHeight := pnlLog.Height;
  FEnvironmentSettings.TreeWidth := pnlTree.Width;
  FEnvironmentSettings.ListWidth := pnlList.Width;
  FEnvironmentSettings.ShowUnitsNotInPath := actShowUnitsNotInPath.Checked;
  FEnvironmentSettings.LoadLastProject := FLoadLastProject;
  FEnvironmentSettings.ProjectFilename := FProjectFilename;
  FEnvironmentSettings.RunScanOnLoad := FRunScanOnLoad;

  FEnvironmentSettings.WindowLeft := Left;
  FEnvironmentSettings.WindowTop := Top;
  FEnvironmentSettings.WindowWidth := Width;
  FEnvironmentSettings.WindowHeight := Height;
  FEnvironmentSettings.UnitPatchHeight := PanelFooter.Height;

  FEnvironmentSettings.WindowState := Integer(WindowState);

  ForceDirectories(ExtractFileDir(GetSettingsFilename));
  FEnvironmentSettings.SaveToFile(GetSettingsFilename);
end;

// search list "Unit list"
procedure TfrmMain.SearchList(VT: TVirtualStringTree; const SearchText: String);
var
  Node: PVirtualNode;
  LowerSearchText: String;
  DelphiFile: TDelphiFile;
  InSearchPathOrShowAll,
  UnitMatchesSearchTerm: Boolean;
begin
  VT.BeginUpdate;
  try
    LowerSearchText := LowerCase(SearchText);

    Node := VT.GetFirst;

    while Node <> nil do
    begin
      DelphiFile := FModel.DelphiFileList[GetID(Node)];

      InSearchPathOrShowAll := DelphiFile.InSearchPath or (not DelphiFile.InSearchPath and actShowUnitsNotInPath.Checked);
      UnitMatchesSearchTerm := ((LowerSearchText = '') or ((pos(LowerSearchText, LowerCase(DelphiFile.UnitInfo.DelphiUnitName)) <> 0)));

      VT.IsVisible[Node] :=  UnitMatchesSearchTerm and InSearchPathOrShowAll;

      Node := Node.NextSibling;
    end;

    VT.Invalidate;
  finally
    VT.EndUpdate;
  end;
end;

procedure TfrmMain.SearchTree(const SearchText: String; FromFirstNode: Boolean);
var
  Node, EndNode, ParentStepNode: PVirtualNode;
begin
  vtUnitsTree.BeginUpdate;
  try
    FSearchText := LowerCase(SearchText);

    if (vtUnitsTree.FocusedNode = nil) or (FromFirstNode) then
    begin
      Node := vtUnitsTree.GetFirst;

      EndNode := nil;
    end
    else
    begin
      Node := vtUnitsTree.GetNext(vtUnitsTree.FocusedNode);

      if Node = nil then
        Node := vtUnitsTree.GetFirst;

      EndNode := vtUnitsTree.GetPrevious(Node);
    end;

    while Node <> EndNode do
    begin
      if IsSearchHitNode(Node) then
      begin
        if vtUnitsTree.IsVisible[Node] then
        begin
          vtUnitsTree.SelectNodeEx(Node, TRUE, TRUE);

          if not FShowTermParents then
            Break;
        end;

        if FShowTermParents then
        begin
          ParentStepNode := Node.Parent;

          while ParentStepNode <> vtUnitsTree.RootNode do
          begin
            if FNodeObjects[GetID(ParentStepNode)].SearchTermInChildren then
              Break
            else
              FNodeObjects[GetID(ParentStepNode)].SearchTermInChildren := TRUE;

            ParentStepNode := ParentStepNode.Parent;
          end;
        end;
      end
      else
        FNodeObjects[GetID(Node)].SearchTermInChildren := FALSE;

      Node := vtUnitsTree.GetNext(Node);

      if (Node = nil) and (EndNode <> nil) then
        Node := vtUnitsTree.GetFirst;
    end;

    vtUnitsTree.Invalidate;
  finally
    vtUnitsTree.EndUpdate;
  end;
end;

procedure TfrmMain.vtLogGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: TImageIndex);
begin
  if (Kind in [ikNormal, ikSelected]) and (Column <= 0) then
  begin
    case TDudsLogger.GetInstance.LogEntries[Node.Index].Severity of
      LogWarning:
        ImageIndex := 4;
      LogError:
        ImageIndex := 5;
    else
      ImageIndex := 3;
    end;
  end;
end;

procedure TfrmMain.vtLogGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
begin
  CellText := TDudsLogger.GetInstance.LogEntries[Node.Index].Text;
end;

procedure TfrmMain.vtStatsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  Stat: String;
begin
  Stat := FStats[Node.Index];

  case Column of
    0:
      CellText := Copy(Stat, 1, pos('=', Stat) - 1);
    1:
      CellText := Copy(Stat, pos('=', Stat) + 1, MaxInt);
  end;
end;

procedure TfrmMain.vtStatsPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType);
begin
  if Column = 0 then
    TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsBold];
end;

procedure TfrmMain.vtUnitsTreeBeforeItemErase(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  ItemRect: TRect; var ItemColor: TColor; var EraseAction: TItemEraseAction);
begin
  if IsSearchHitNode(Node) then
  begin
    EraseAction := eaColor;
    ItemColor := $008CFFFF;
  end
  else if (FNodeObjects[GetID(Node)].SearchTermInChildren) or
    ((Node.Parent <> Sender.RootNode) and (FNodeObjects[GetID(Node.Parent)].SearchTermInChildren)) then
  begin
    EraseAction := eaColor;
    ItemColor := $00CCFFCC;
  end;
end;

procedure TfrmMain.vtUnitsTreeCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
  var Result: Integer);
var
  NodeObject1, NodeObject2: TNodeObject;
begin
  NodeObject1 := FNodeObjects[GetID(Node1)];
  NodeObject2 := FNodeObjects[GetID(Node2)];

  case Column of
    0:
      Result := CompareStr(NodeObject1.DelphiFile.UnitInfo.DelphiUnitName,
        NodeObject2.DelphiFile.UnitInfo.DelphiUnitName);
    1:
      Result := CompareStr(NodeObject1.DelphiFile.UnitInfo.PreviousUnitName,
        NodeObject2.DelphiFile.UnitInfo.PreviousUnitName);
    2:
      Result := CompareStr(DelphiFileTypeStrings[NodeObject1.DelphiFile.UnitInfo.DelphiFileType],
        DelphiFileTypeStrings[NodeObject2.DelphiFile.UnitInfo.DelphiFileType]);
    3:
      Result := CompareInteger(NodeObject1.DelphiFile.UnitInfo.LineCount, NodeObject2.DelphiFile.UnitInfo.LineCount);
    4:
      Result := CompareInteger(NodeObject1.DelphiFile.UsedCount, NodeObject2.DelphiFile.UsedCount);
    5:
      Result := CompareInteger(NodeObject1.DelphiFile.UnitInfo.UsedUnits.Count,
        NodeObject2.DelphiFile.UnitInfo.UsedUnits.Count);
    6:
      Result := 0;
    7:
      Result := CompareInteger(Integer(FNodeObjects[GetID(Node1)].CircularReference),
        Integer(FNodeObjects[GetID(Node2)].CircularReference));
    8:
      Result := CompareBoolean(FNodeObjects[GetID(Node1)].Link <> nil, FNodeObjects[GetID(Node2)].Link <> nil);
    9:
      Result := CompareStr(NodeObject1.DelphiFile.UnitInfo.Filename, NodeObject2.DelphiFile.UnitInfo.Filename);
  end;

end;

procedure TfrmMain.vtUnitsTreeDblClick(Sender: TObject);
begin
  if vtUnitsTree.FocusedNode <> nil then
    vtUnitsTree.SelectNodeEx(GetLinkedNode(vtUnitsTree.FocusedNode));
end;

procedure TfrmMain.vtUnitsTreeFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
begin
  UpdateTreeControls(Node);
end;

procedure TfrmMain.vtUnitsTreeFocusChanging(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode;
  OldColumn, NewColumn: TColumnIndex; var Allowed: Boolean);
begin
  if memParentFile.Modified then
    case MessageDlg(Format(StrSHasBeenModifi, [tabParentFile.Caption]), mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        memParentFile.Lines.SaveToFile(FNodeObjects[GetID(OldNode.Parent)].DelphiFile.UnitInfo.Filename);
      mrCancel:
        begin
          Allowed := FALSE;

          Exit;
        end;
    end;

  if memSelectedFile.Modified then
    case MessageDlg(Format(StrSHasBeenModifi, [tabSelectedFile.Caption]), mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        memSelectedFile.Lines.SaveToFile(FNodeObjects[GetID(OldNode)].DelphiFile.UnitInfo.Filename);
      mrCancel:
        Allowed := FALSE;
    end;
end;

procedure TfrmMain.UpdateTreeControls(Node: PVirtualNode);
var
  ParentFileInfo: IUnitInfo;
  UsedUnitInfo: IUsedUnitInfo;
begin
  SetNodePathRichEdit(Node, RichEditUnitPath);

  tabParentFile.TabVisible := (Node <> nil) and (Node.Parent <> vtUnitsTree.RootNode);
  tabSelectedFile.TabVisible := (Node <> nil) and (FNodeObjects[GetID(Node)].DelphiFile.InSearchPath);

  if Node <> nil then
  begin
    pcSource.Visible := TRUE;

    if (FNodeObjects[GetID(Node)].DelphiFile.InSearchPath) and
      (FileExists(FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.Filename)) then
    begin
      tabSelectedFile.Caption := ExtractFileName(FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.Filename);
      memSelectedFile.Lines.LoadFromFile(FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.Filename);
      memSelectedFile.Modified := FALSE;
    end;

    if (Node.Parent <> vtUnitsTree.RootNode) and (FileExists(FNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.Filename))
    then
    begin
      ParentFileInfo := FNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo;
      UsedUnitInfo := ParentFileInfo.UsedUnits[GetNodeIndex(Node)];

      tabParentFile.Caption := ExtractFileName(ParentFileInfo.Filename);

      memParentFile.Lines.LoadFromFile(ParentFileInfo.Filename);

      memParentFile.SelStart := UsedUnitInfo.Position;
      if UsedUnitInfo.InFilePosition > 0 then
      begin
        // memParentFile.SelStart  := UsedUnitInfo.InFilePosition; // uncomment this line to visualize unitname recognition in the "in file" part
      end;
      memParentFile.SelLength := Length(UsedUnitInfo.DelphiUnitName);

      memParentFile.Modified := FALSE;

      pcSource.ActivePageIndex := 0;
    end;
  end
  else
    pcSource.Visible := FALSE;
end;

function TfrmMain.GetNodePath(Node: PVirtualNode): String;
begin
  Result := '';

  while (Node <> nil) and (Node <> vtUnitsTree.RootNode) do
  begin
    if Result <> '' then
      Result := ' -> ' + Result;

    Result := FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.DelphiUnitName + Result;

    Node := Node.Parent;
  end;
end;

procedure TfrmMain.SetNodePathRichEdit(Node: PVirtualNode; ARichEdit: TRichEdit);
var
  LStartNodeFile: string;
  LParentNodeFile: string;
  LArrow: string;
begin
  ARichEdit.Clear;

  if Node <> nil then
    LStartNodeFile := FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.DelphiUnitName;

  LArrow := '';

  while (Node <> nil) and (Node <> vtUnitsTree.RootNode) do
  begin
    LParentNodeFile := FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.DelphiUnitName;

    RichEditUnitPath.SelStart := 0;

    if AnsiSameText(LStartNodeFile, LParentNodeFile) then
      RichEditUnitPath.SelAttributes.Style := [fsBold]
    else
      RichEditUnitPath.SelAttributes.Style := [];

    RichEditUnitPath.SelText := LParentNodeFile + LArrow;
    LArrow := ' -> ';

    Node := Node.Parent;
  end;
end;

procedure TfrmMain.vtUnitsTreeGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: TImageIndex);
begin
  if (Kind in [ikNormal, ikSelected]) and (Column = 0) then
  begin
    case FNodeObjects[GetID(Node)].CircularReference of
      crNone:
        ImageIndex := 0;
      crSemiCircular:
        ImageIndex := 1;
      crCircular:
        ImageIndex := 2;
    end;
  end;
end;

procedure TfrmMain.vtUnitsTreeGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TNodeData);
end;

function TfrmMain.GetLinkedNode(Node: PVirtualNode): PVirtualNode;
begin
  if Node = nil then
    Result := nil
  else
  begin
    Result := FNodeObjects[GetID(Node)].Link;

    if Result = nil then
      Result := Node;
  end;
end;

function TfrmMain.GetNodeIndex(const Node: PVirtualNode): Integer;
var
  NodeData: PNodeData;
begin
  NodeData := Node.GetData;

  if Assigned(NodeData) then
  begin
    Result := NodeData.Index;
  end
  else
  begin
    raise Exception.Create('No node data found');
  end;
end;

procedure TfrmMain.vtUnitsTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  UnitInfo: IUnitInfo;
  DelphiFile: TDelphiFile;
  ParentUnitFilename: String;
begin
  DelphiFile := FNodeObjects[GetID(Node)].DelphiFile;
  UnitInfo := DelphiFile.UnitInfo;

  if TextType = ttStatic then
  begin
    CellText := '';

    if (Node.Parent <> Sender.RootNode) and (Column = 0) and
      (GetNodeIndex(Node) < FNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.UsedUnits.Count) then
    begin
      ParentUnitFilename := FNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.UsedUnits[GetNodeIndex(Node)
        ].DelphiUnitName;

      if not SameText(ParentUnitFilename, UnitInfo.DelphiUnitName) then
        CellText := '(' + ParentUnitFilename + ')';
    end;
  end
  else
  begin
    CellText := '-';

    case Column of
      0:
        CellText := UnitInfo.DelphiUnitName;

      1:
        CellText := UnitInfo.PreviousUnitName;

      2:
        if DelphiFile.InSearchPath then
          CellText := DelphiFileTypeStrings[UnitInfo.DelphiFileType];

      3:
        if UnitInfo.LineCount > 0 then
          CellText := IntToStr(UnitInfo.LineCount);

      4:
        CellText := IntToStr(DelphiFile.UsedCount);

      5:
        if DelphiFile.UnitInfo.UsedUnits.Count > 0 then
          CellText := IntToStr(DelphiFile.UnitInfo.UsedUnits.Count);

      6:
        if (DelphiFile.InSearchPath) and (Sender.GetNodeLevel(Node) > 0) and (FNodeObjects[GetID(Node)] <> nil) and
          (GetNodeIndex(Node) < FNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.UsedUnits.Count) then
          CellText := UsesTypeStrings[FNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.UsedUnits[GetNodeIndex(Node)
            ].UsesType];

      7:
        CellText := CircularRelationshipTypeDescriptions[FNodeObjects[GetID(Node)].CircularReference];

      8:
        if FNodeObjects[GetID(Node)].Link <> nil then
          CellText := StrYes
        else
          CellText := StrNo;

      9:
        CellText := UnitInfo.Filename;
    end;
  end;
end;

procedure TfrmMain.vtCommonHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
begin
  inherited;

  // Sort the list
  ShowHourGlass;
  try
    if Sender.SortColumn = HitInfo.Column then
    Begin
      if Sender.SortDirection = sdAscending then
        Sender.SortDirection := sdDescending
      else
        Sender.SortDirection := sdAscending;
    end
    else
    begin
      Sender.SortColumn := HitInfo.Column;
      Sender.SortDirection := sdAscending;
    end;

    Sender.Treeview.Sort(nil, Sender.SortColumn, Sender.SortDirection);

    Sender.Treeview.Invalidate;
  finally
    HideHourGlass;
  end;
end;

procedure TfrmMain.vtUnitsListCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
  var Result: Integer);
var
  idx1, idx2: Integer;
  DelphiFile1, DelphiFile2: TDelphiFile;
begin
  idx1 := GetID(Node1);
  idx2 := GetID(Node2);

  if (idx1 <> -1) and (idx2 <> -1) then
  begin
    DelphiFile1 := FModel.DelphiFileList[idx1];
    DelphiFile2 := FModel.DelphiFileList[idx2];

    case Column of
      0:
        Result := CompareStr(DelphiFile1.UnitInfo.DelphiUnitName, DelphiFile2.UnitInfo.DelphiUnitName);
      1:
        Result := CompareStr(DelphiFileTypeStrings[DelphiFile1.UnitInfo.DelphiFileType],
          DelphiFileTypeStrings[DelphiFile2.UnitInfo.DelphiFileType]);
      2:
        Result := CompareInteger(DelphiFile1.UnitInfo.LineCount, DelphiFile2.UnitInfo.LineCount);
      3:
        Result := CompareInteger(DelphiFile1.UsedCount, DelphiFile2.UsedCount);
      4:
        Result := CompareInteger(DelphiFile1.UnitInfo.UsedUnits.Count, DelphiFile2.UnitInfo.UsedUnits.Count);
      5:
        Result := CompareStr(DelphiFile1.UnitInfo.Filename, DelphiFile2.UnitInfo.Filename);
    end;
  end;
end;

procedure TfrmMain.vtUnitsListDblClick(Sender: TObject);
begin
  if TVirtualStringTree(Sender).FocusedNode <> nil then
  begin
    pcView.ActivePage := tabTree;

    vtUnitsTree.SelectNodeEx(FModel.DelphiFileList[GetFocusedID(TVirtualStringTree(Sender))].BaseNode);
    vtUnitsTree.SetFocus;
  end;
end;

procedure TfrmMain.vtUnitsListFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
begin
  UpdateListControls(Node);
end;

procedure TfrmMain.UpdateListControls(Node: PVirtualNode);
var
  DelphiFile: TDelphiFile;
begin
  pcList.Visible := vtUnitsList.FocusedNode <> nil;

  if Node <> nil then
  begin
    DelphiFile := FModel.DelphiFileList[GetFocusedID(vtUnitsList)];

    if (DelphiFile.InSearchPath) and (FileExists(DelphiFile.UnitInfo.Filename)) then
    begin
      memListFile.Lines.LoadFromFile(DelphiFile.UnitInfo.Filename);
      memListFile.Modified := FALSE;
    end;

    SearchUnitsListChildList(vtUsedByUnits, edtSearchUsedByList.Text, TRUE);
    SearchUnitsListChildList(vtUsesUnits, edtSearchUsesList.Text, FALSE);
  end;
end;

procedure TfrmMain.vtUnitsListFocusChanging(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode;
  OldColumn, NewColumn: TColumnIndex; var Allowed: Boolean);
begin
  if memListFile.Modified then
    case MessageDlg(Format(StrSHasBeenModifi, [FModel.DelphiFileList[GetFocusedID(vtUnitsList)].UnitInfo.Filename]),
      mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        memListFile.Lines.SaveToFile(FModel.DelphiFileList[GetFocusedID(vtUnitsList)].UnitInfo.Filename);
      mrCancel:
        Allowed := FALSE;
    end;
end;

procedure TfrmMain.vtCommonGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: TImageIndex);
begin
  if (Kind in [ikNormal, ikSelected]) and (Column = 0) then
  begin
    ImageIndex := 0;
  end;
end;

procedure TfrmMain.vtUnitsListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  UnitInfo: IUnitInfo;
  DelphiFile: TDelphiFile;
begin
  CellText := '-';

  DelphiFile := FModel.DelphiFileList[GetID(Node)];
  UnitInfo   := DelphiFile.UnitInfo;

  case Column of
    0:
      CellText := UnitInfo.DelphiUnitName;
    1:
      if DelphiFile.InSearchPath then
        CellText := DelphiFileTypeStrings[UnitInfo.DelphiFileType];
    2:
      CellText := IntToStr(UnitInfo.LineCount);
    3:
      CellText := IntToStr(DelphiFile.UsedCount);
    4:
      CellText := IntToStr(DelphiFile.UnitInfo.UsedUnits.Count);
    5:
      CellText := UnitInfo.Filename;
  end;
end;

procedure TfrmMain.vtUnitsListPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType);
begin
  if (not Sender.Selected[Node]) and (not FModel.DelphiFileList[GetID(Node)].InSearchPath) then
    TargetCanvas.Font.Color := clGray;
end;

procedure TfrmMain.vtUnitsListSearchComparison(Sender: TObject; Node: PVirtualNode; const SearchTerms: TStrings;
  var IsMatch: Boolean);
var
  i: Integer;
begin
  IsMatch := TRUE;

  for i := 0 to pred(SearchTerms.Count) do
    if (pos(LowerCase(SearchTerms[i]), LowerCase(FModel.DelphiFileList[GetID(Node)].UnitInfo.DelphiUnitName)) = 0) or
      ((not actShowUnitsNotInPath.Checked) and (not FModel.DelphiFileList[GetID(Node)].InSearchPath)) then
    begin
      IsMatch := FALSE;

      Break;
    end;
end;

procedure TfrmMain.vtUnitsTreePaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType);
begin
  if TextType = ttStatic then
  begin
    if not Sender.Selected[Node] then
      TargetCanvas.Font.Color := clGray;
  end
  else
  begin
    if (Column = 0) and (Sender.FocusedNode = Node) and (IsSearchHitNode(Node)) then
      TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsBold];

    if not Sender.Selected[Node] then
    begin
      if not FNodeObjects[GetID(Node)].DelphiFile.InSearchPath then
        TargetCanvas.Font.Color := clGray
      else if FNodeObjects[GetID(GetLinkedNode(Node))].DelphiFile.UnitInfo.DelphiFileType = ftUnknown then
        TargetCanvas.Font.Color := clRed;
    end;

    if Column = 0 then
    begin
      if FNodeObjects[GetID(Node)].Link <> nil then
      begin
        if not Sender.Selected[Node] then
        begin
          if FNodeObjects[GetID(Node)].DelphiFile.InSearchPath then
            TargetCanvas.Font.Color := clBlue
          else
            TargetCanvas.Font.Color := $00FEC9B1;
        end;

        TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsUnderline];
      end;
    end;
  end;
end;

function TfrmMain.IsSearchHitNode(Node: PVirtualNode): Boolean;
begin
  Result := (Node <> nil) and
    (pos(FSearchText, LowerCase(FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.DelphiUnitName)) > 0);
end;

procedure TfrmMain.actCloseProjectExecute(Sender: TObject);
begin
  if (CheckNotRunning) and (CheckSaveProject) then
  begin
    FProjectFilename := '';

    CloseControls;
  end;
end;

procedure TfrmMain.actCollapseAllExecute(Sender: TObject);
begin
  vtUnitsTree.CollapseAll(nil);
end;

procedure TfrmMain.actCollapseExecute(Sender: TObject);
begin
  vtUnitsTree.Expanded[vtUnitsTree.FocusedNode] := FALSE;
end;

procedure TfrmMain.actExpandExecute(Sender: TObject);
begin
  vtUnitsTree.ExpandAll(vtUnitsTree.FocusedNode);
end;

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.actExpandAllExecute(Sender: TObject);
begin
  ExpandAll;
end;

procedure TfrmMain.ExpandAll;
begin
  vtUnitsTree.ExpandAll(nil);

  vtUnitsTree.AutoFitColumns
end;

procedure TfrmMain.ActionManager1Update(Action: TBasicAction; var Handled: Boolean);
begin
  UpdateControls;

  Handled := TRUE;
end;

procedure TfrmMain.ActionSaveCirRefsExecute(Sender: TObject);
var
  Node: PVirtualNode;
  LStrs: TStringList;
begin
  vtUnitsTree.BeginUpdate;
  LStrs := TStringList.Create;
  try
    LStrs.Add('Kind;Unit;Ref');
    Node := vtUnitsTree.GetFirst;

    while Node <> nil do
    begin
      if FNodeObjects[GetID(Node)].DelphiFile.InSearchPath then
      begin
        if FNodeObjects[GetID(Node)].CircularReference in [crSemiCircular, crCircular] then
        begin
          LStrs.Add(CircularRelationshipTypeDescriptions[FNodeObjects[GetID(Node)].CircularReference] + ';' +
            FNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.DelphiUnitName + ';' + FNodeObjects[GetID(Node)
            ].DelphiFile.UnitInfo.DelphiUnitName);
        end;
      end;

      Node := vtUnitsTree.GetNext(Node);
    end;

    if vtUnitsTree.FocusedNode <> nil then
      vtUnitsTree.ScrollIntoView(vtUnitsTree.FocusedNode, TRUE);
  finally
    if SaveDialogGephiCSV.Execute then
      LStrs.SaveToFile(SaveDialogGephiCSV.Filename);
    LStrs.Free;
    vtUnitsTree.EndUpdate;
  end;
end;

procedure TfrmMain.UpdateControls;
var
  DelphiFile: TDelphiFile;
begin
  DelphiFile := GetFocusedDelphiFile;

  actShowUnitsNotInPath.Enabled := (not FBusy) and (vtUnitsTree.RootNodeCount > 0);
  actSaveChanges.Enabled := (not FBusy) and ((memParentFile.Modified) or (memSelectedFile.Modified) or
    (memListFile.Modified));

  actRename.Enabled := (not FBusy) and (DelphiFile <> nil) and (DelphiFile.InSearchPath);

  actApplyRenameList.Enabled := actRename.Enabled;
  actAddUnitToUses.Enabled := actRename.Enabled;

  actSearchAndReplace.Enabled := (not FBusy) and (vtUnitsTree.RootNodeCount > 0);

  actExpandAll.Enabled := (not FBusy) and (pcView.ActivePage = tabTree) and (vtUnitsTree.RootNodeCount > 0);
  actCollapseAll.Enabled := (not FBusy) and (pcView.ActivePage = tabTree) and (vtUnitsTree.RootNodeCount > 0);
  actExpand.Enabled := (not FBusy) and (vtUnitsTree.FocusedNode <> nil);
  actCollapse.Enabled := (not FBusy) and (vtUnitsTree.FocusedNode <> nil);
  actLoadProject.Enabled := not FBusy;
  actSaveProject.Enabled := (not FBusy) and (FProjectFilename <> '');
  actSaveProjectAs.Enabled := not FBusy;
  actSettings.Enabled := not FBusy;
  actCloseProject.Enabled := (pnlMain.Visible) or (FProjectFilename <> '');
  actShowFile.Enabled := DelphiFile <> nil;
  actSaveToXML.Enabled := not FBusy;
  actSaveToGephiCSV.Enabled := not FBusy;
  actSaveToGraphML.Enabled := not FBusy;
  ActionSaveCirRefs.Enabled := not FBusy;
end;

procedure TfrmMain.actLoadProjectExecute(Sender: TObject);
begin
  if (OpenDialog1.Execute) and (CheckSaveProject) then
  begin
    if LoadProjectSettings(OpenDialog1.Filename) then
    begin
      FProjectFilename := OpenDialog1.Filename;

      SetFormCaption;
    end;
  end;
end;

procedure TfrmMain.actNewProjectExecute(Sender: TObject);
begin
  if (CheckNotRunning) and (CheckSaveProject) then
  begin
    FProjectFilename := '';

    CloseControls;

    ResetSettings;

    actSettings.Execute;
  end;
end;

procedure TfrmMain.ResetSettings;
begin
  FProjectFilename := '';
  FProjectSettings.RootFiles.Clear;
  FProjectSettings.SearchPaths.Clear;
  FProjectSettings.UnitScopeNames.Clear;
  FProjectSettings.LinkUnits := TRUE;
end;

function TfrmMain.CheckNotRunning: Boolean;
begin
  Result := not FBusy;

  if not Result then
    MessageDlg(StrPleaseStopTheCurr, mtInformation, [mbOK], 0);
end;

procedure TfrmMain.UpdateLogEntries;
begin
  vtLog.RootNodeCount := TDudsLogger.GetInstance.Count;
  vtLog.Invalidate;

  if not vtLog.Focused then
    vtLog.ScrollIntoView(vtLog.GetLast, FALSE);
end;

procedure TfrmMain.CloseControls;
begin
  vtUnitsTree.Clear;
  vtUnitsList.Clear;
  vtUsedByUnits.Clear;
  vtUsesUnits.Clear;
  vtStats.Clear;

  vtUnitsTree.Header.Columns[1].Options := vtUnitsTree.Header.Columns[1].Options - [coVisible];

  FModel.DelphiFileList.Clear;
  FModel.DelphiFiles.Clear;
  FStats.Clear;
  TDudsLogger.GetInstance.Clear;
  UpdateLogEntries;

  pnlMain.Visible := FALSE;

  SetFormCaption;
end;

procedure TfrmMain.SetFormCaption;
begin
  Caption := StrUnitDependencyScan;

  if FProjectFilename <> '' then
    Caption := Caption + ' - ' + ExtractFilenameNoExt(FProjectFilename);

  if Modified then
    Caption := Caption + '*';
end;

procedure TfrmMain.SetModified(const Value: Boolean);
begin
  FModified := Value;

  SetFormCaption;
end;

procedure TfrmMain.actRenameExecute(Sender: TObject);
begin
  RenameDelphiFileWithDialog(rtRename);
end;

procedure TfrmMain.actApplyRenameListExecute(Sender: TObject);
var
  aFileName: String;
  ShowDlgResult: Boolean;
begin
  if (OpenDialogMultipleRenames.Execute) then
  begin
    aFileName := OpenDialogMultipleRenames.Filename;

    with TfrmRenameUnit.Create(Self) do
      try
        Width := Width + 300;
        Label1.Caption := 'Selected file';
        edtNewName.Text := aFileName;
        edtNewName.Enabled := FALSE;
        Caption := 'Rename multiple files';
        infoRenameCSV.Visible := TRUE;

        chkPromptBeforeUpdate.Checked := FALSE;
        chkPromptBeforeUpdate.Enabled := FALSE;
        chkDummyRun.Checked := FEnvironmentSettings.DummyRun;
        chkRenameHistoryFiles.Checked := FEnvironmentSettings.RenameHistoryFiles;
        chkInsertOldNameComment.Checked := FEnvironmentSettings.RenameInsertOldNameComment;
        chkInsertOldNameComment.Caption := 'Insert "{renamed from ' + 'oldname' + '.pas} comment"';
        chkRenameLowerCaseExtension.Checked := FEnvironmentSettings.RenameLowerCaseExtension;

        ShowDlgResult := ShowModal = mrOK;

        if ShowDlgResult then
        begin

          FEnvironmentSettings.DummyRun := chkDummyRun.Checked;
          FEnvironmentSettings.RenameHistoryFiles := chkRenameHistoryFiles.Checked;
          FEnvironmentSettings.RenameInsertOldNameComment := chkInsertOldNameComment.Checked;
          FEnvironmentSettings.RenameLowerCaseExtension := chkRenameLowerCaseExtension.Checked;

          ApplyMultipleRenames(aFileName, chkDummyRun.Checked, chkRenameHistoryFiles.Checked,
            chkInsertOldNameComment.Checked, chkRenameLowerCaseExtension.Checked);
        end;
      finally
        Release;
      end;
  end;
end;

procedure TfrmMain.actAddUnitToUsesExecute(Sender: TObject);
var
  ShowDlgResult: Boolean;
begin
  if GetFocusedDelphiFile <> nil then
  begin
    with TfrmAddNewUnit.Create(Self) do
      try
        edtNewName.Text := '';
        edtNewName.Enabled := TRUE;
        Label1.Caption := 'Add uses to all units that currently use "' +
          GetFocusedDelphiFile.UnitInfo.DelphiUnitName + '"';
        Caption := Label1.Caption;

        ShowDlgResult := ShowModal = mrOK;

        if ShowDlgResult then
          AddUnitToUses(chkDummyRun.Checked, GetFocusedDelphiFile, edtNewName.Text);
      finally
        Free;
      end;
  end;
end;

function TfrmMain.GetFocusedDelphiFile: TDelphiFile;
begin
  if (vtUnitsTree.Focused) and (vtUnitsTree.FocusedNode <> nil) then
    Result := FNodeObjects[GetID(vtUnitsTree.FocusedNode)].DelphiFile
  else

    if (vtUnitsList.Focused) and (vtUnitsList.FocusedNode <> nil) then
    Result := FModel.DelphiFileList[GetFocusedID(vtUnitsList)]
  else

    if (vtUsedByUnits.Focused) and (vtUsedByUnits.FocusedNode <> nil) then
    Result := FModel.DelphiFileList[GetFocusedID(vtUsedByUnits)]
  else

    if (vtUsesUnits.Focused) and (vtUsesUnits.FocusedNode <> nil) then
    Result := FModel.DelphiFileList[GetFocusedID(vtUsesUnits)]
  else
    Result := nil;
end;

function TfrmMain.RenameDelphiFileWithDialog(RenameType: TRenameType): Boolean;
begin
  Result := RenameDelphiFileWithDialog(GetFocusedDelphiFile, RenameType);
end;

function TfrmMain.RenameDelphiFileWithDialog(const DelphiFile: TDelphiFile; RenameType: TRenameType): Boolean;
begin
  Result := FALSE;

  case RenameType of
    rtRename:
      begin
        if DelphiFile <> nil then
        begin
          With TfrmRenameUnit.Create(Self) do
            try
              edtNewName.Text := DelphiFile.UnitInfo.DelphiUnitName;
              Caption := Format(StrRenameS, [edtNewName.Text]);

              chkPromptBeforeUpdate.Checked := FEnvironmentSettings.PromptBeforeUpdate;
              chkDummyRun.Checked := FEnvironmentSettings.DummyRun;
              chkRenameHistoryFiles.Checked := FEnvironmentSettings.RenameHistoryFiles;
              chkInsertOldNameComment.Checked := FEnvironmentSettings.RenameInsertOldNameComment;
              chkInsertOldNameComment.Caption := 'Insert "{renamed from ' + DelphiFile.UnitInfo.DelphiUnitName +
                '.pas} comment"';
              chkRenameLowerCaseExtension.Checked := FEnvironmentSettings.RenameLowerCaseExtension;

              Result := ShowModal = mrOK;

              if Result then
              begin
                FEnvironmentSettings.PromptBeforeUpdate := chkPromptBeforeUpdate.Checked;
                FEnvironmentSettings.DummyRun := chkDummyRun.Checked;
                FEnvironmentSettings.RenameHistoryFiles := chkRenameHistoryFiles.Checked;
                FEnvironmentSettings.RenameInsertOldNameComment := chkInsertOldNameComment.Checked;
                FEnvironmentSettings.RenameLowerCaseExtension := chkRenameLowerCaseExtension.Checked;

                RenameDelphiFile(TRUE, DelphiFile.UnitInfo.DelphiUnitName, edtNewName.Text,
                  chkPromptBeforeUpdate.Checked, chkDummyRun.Checked, chkRenameHistoryFiles.Checked, TRUE,
                  chkInsertOldNameComment.Checked, chkRenameLowerCaseExtension.Checked);
              end;
            finally
              Release;
            end;
        end;
      end;

    rtSearchAndReplace:
      begin
        With TfrmSearchAndReplace.Create(Self) do
          try
            if DelphiFile <> nil then
            begin
              edtSearch.Text := DelphiFile.UnitInfo.DelphiUnitName;
              edtReplace.Text := DelphiFile.UnitInfo.DelphiUnitName;
              edtTest.Text := DelphiFile.UnitInfo.DelphiUnitName;
            end;

            chkPromptBeforeUpdate.Checked := FEnvironmentSettings.PromptBeforeUpdate;
            chkDummyRun.Checked := FEnvironmentSettings.DummyRun;
            chkRenameHistoryFiles.Checked := FEnvironmentSettings.RenameHistoryFiles;

            Result := ShowModal = mrOK;

            if Result then
            begin
              FEnvironmentSettings.PromptBeforeUpdate := chkPromptBeforeUpdate.Checked;
              FEnvironmentSettings.DummyRun := chkDummyRun.Checked;
              FEnvironmentSettings.RenameHistoryFiles := chkRenameHistoryFiles.Checked;

              RenameDelphiFile(TRUE, edtSearch.Text, edtReplace.Text, chkPromptBeforeUpdate.Checked,
                chkDummyRun.Checked, chkRenameHistoryFiles.Checked, FALSE, FALSE, FALSE);
            end;
          finally
            Release;
          end;
      end;
  end;

  if Result then
    vtUnitsTree.Header.Columns[1].Options := vtUnitsTree.Header.Columns[1].Options + [coVisible];
end;

procedure TfrmMain.ApplyMultipleRenames(aCsvFilename: String; DummyRun, RenameHistoryFiles, InsertOldNameComment,
  RenameLowerCaseExtension: Boolean);
var
  aRenameFileStrings: TStringList;
  i: Integer;
  semicolonPos: Integer;
  aLine: String;
  OldUnitName, NewUnitName: String;
  renameCount: Integer;
  OldFile, NewFile: TDelphiFile;
  PreCheckOk: Boolean;
  aRenameUnitsList: TDictionary<String, String>;
begin

  aRenameUnitsList := TDictionary<String, String>.Create;
  try
    if FileExists(aCsvFilename) then
    begin
      ClearLog;

      PreCheckOk := TRUE;

      aRenameFileStrings := TStringList.Create;
      try
        aRenameFileStrings.LoadFromFile(aCsvFilename);
        for i := 0 to pred(aRenameFileStrings.Count) do
        begin
          aLine := aRenameFileStrings[i];
          semicolonPos := pos(';', aLine);
          OldUnitName := Copy(aLine, 1, semicolonPos - 1);
          NewUnitName := Copy(aLine, semicolonPos + 1, Length(aLine));

          // "old name" Unit exists?
          OldFile := FModel.FindParsedDelphiUnit(OldUnitName);
          if not Assigned(OldFile) then
          begin
            Log(StrUnableToRenameS, [OldUnitName], LogError);
            PreCheckOk := FALSE;
          end;

          // "new name" unit does NOT exist already?
          NewFile := FModel.FindParsedDelphiUnit(NewUnitName);
          if Assigned(NewFile) then
          begin
            Log(StrUnableToRenameToNewName, [OldUnitName, NewUnitName], LogError);
            PreCheckOk := FALSE;
          end;

          aRenameUnitsList.Add(OldUnitName, NewUnitName);
        end;
      finally
        FreeAndNil(aRenameFileStrings);
      end;

      renameCount := 0;
      if PreCheckOk then
      begin
        for OldUnitName in aRenameUnitsList.Keys do
        begin
          NewUnitName := aRenameUnitsList[OldUnitName];

          Log(StrStartBatchRename, [OldUnitName, NewUnitName], LogInfo);
          Application.ProcessMessages;

          RenameDelphiFile(FALSE, OldUnitName, NewUnitName, FALSE, DummyRun, RenameHistoryFiles, TRUE,
            InsertOldNameComment, RenameLowerCaseExtension);
          Inc(renameCount);
        end;
      end;

      Log(StrBatchRenameResult, [renameCount], LogInfo);
    end
    else
      Log(StrUnableToFindFile, [aCsvFilename], LogWarning);
  finally
    FreeAndNil(aRenameUnitsList);
  end;
end;

procedure TfrmMain.RenameDelphiFile(const aClearLog: Boolean; const SearchString, ReplaceString: String;
  PromptBeforeUpdate: Boolean; const DummyRun, RenameHistoryFiles, ExactMatch, InsertOldNameComment,
  LowerCaseExtension: Boolean);

var
  UpdatedCount: Integer;

  function GetDelphiUnitName(Node: PVirtualNode): String;
  begin
    if FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.PreviousUnitName <> '' then
      Result := FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.PreviousUnitName
    else
      Result := FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.DelphiUnitName;
  end;

  function IsUnitNameMatch(const UnitName: String): Boolean;
  begin
    if ExactMatch then
      Result := SameText(SearchString, UnitName)
    else
      Result := TRegEx.IsMatch(UnitName, SearchString);
  end;

  function SearchAndReplaceUnitName(const UnitName: String): String;
  begin
    if IsUnitNameMatch(UnitName) then
    begin
      if ExactMatch then
        Result := StringReplace(UnitName, SearchString, ReplaceString, [rfReplaceAll, rfIgnoreCase])
      else
        Result := TRegEx.Replace(UnitName, SearchString, ReplaceString);
    end
    else
      Result := UnitName;
  end;

  function RenameMatchingFiles(const OldFilename, NewUnitName: String; const IsHistory: Boolean;
    LowerCaseExtension: Boolean): Boolean;
  var
    ScanFilenames: TObjectList<TFileInfo>;
    i: Integer;
    Filter: String;
    NewFilename, LogMsg: String;
    NewFileExtension: String;
  begin
    Result := FALSE;

    if IsHistory then
      Filter := ExtractFileName(OldFilename) + '.*'
    else
      Filter := ExtractFilenameNoExt(OldFilename) + '.*';

    ScanFilenames := ScanFiles(ExtractFileDir(OldFilename), Filter, FALSE, FALSE, TRUE);
    try
      for i := 0 to pred(ScanFilenames.Count) do
      begin
        if (not ScanFilenames[i].IsDir) and
          (SameText(ExtractFilenameNoExt(OldFilename), ExtractFilenameNoExt(ScanFilenames[i].Filename))) then
        begin
          NewFileExtension := ExtractFileExt(ScanFilenames[i].Filename);
          if LowerCaseExtension then
            NewFileExtension := LowerCase(NewFileExtension);
          NewFilename := IncludeTrailingPathDelimiter(ExtractFileDir(ScanFilenames[i].Filename)) + NewUnitName +
            NewFileExtension;

          if DummyRun then
            Result := TRUE
          else
            Result := RenameFile(ScanFilenames[i].Filename, NewFilename);

          LogMsg := StrFileSRenamedTo;

          if IsHistory then
            LogMsg := StrHistory + LogMsg;

          Log(LogMsg, [ScanFilenames[i].Filename, NewFilename]);

          if (not IsHistory) and (RenameHistoryFiles) then
            RenameMatchingFiles(IncludeTrailingPathDelimiter(ExtractFileDir(OldFilename)) + '__history\' +
              ExtractFileName(ScanFilenames[i].Filename), NewUnitName + ExtractFileExt(ScanFilenames[i].Filename), TRUE,
              LowerCaseExtension);
        end;
      end;
    finally
      FreeAndNil(ScanFilenames);
    end;
  end;

  procedure UpdateUsesClause(UpdateNode: PVirtualNode);
  var
    StepNode: PVirtualNode;
    PosOffset: Integer;
    FileUsingTheUnit: IUnitInfo;
    UsedUnitIndex: Integer;
    UsedUnitInfo: IUsedUnitInfo;
    OldUnitName, NewUnitName: String;
    SomethingChanged: Boolean;
  begin
    OldUnitName := GetDelphiUnitName(UpdateNode);
    NewUnitName := SearchAndReplaceUnitName(OldUnitName);

    FileUsingTheUnit := FNodeObjects[GetID(UpdateNode.Parent)].DelphiFile.UnitInfo;
    // file to update (using the unit to rename)

    UsedUnitIndex := GetNodeIndex(UpdateNode);
    // Index of the unit in the uses list of the file to update
    UsedUnitInfo := FileUsingTheUnit.UsedUnits[UsedUnitIndex];
    // detail info about the used unit we are renaming

    // step 1: apply the rename in the file
    SomethingChanged := FALSE;

    // replace text occurence for <OldUnitName in '....\OldUnitName.pas'>
    // ->                                               ^^^^^^^^^^^
    if UsedUnitInfo.InFilePosition > 0 then
      SomethingChanged := SafeReplaceTextInFile(DummyRun, FileUsingTheUnit.Filename, OldUnitName, NewUnitName,
        UsedUnitInfo.InFilePosition);

    // replace text occurence for <OldUnitName in '....\OldUnitName.pas'>
    // ->                          ^^^^^^^^^^^
    SomethingChanged := SafeReplaceTextInFile(DummyRun, FileUsingTheUnit.Filename, OldUnitName, NewUnitName,
      UsedUnitInfo.Position) or SomethingChanged;

    if SomethingChanged then
    begin
      Log(StrUpdatedUsesClause, [OldUnitName, NewUnitName, FileUsingTheUnit.Filename]);

      if not DummyRun then
      begin
        PosOffset := Length(NewUnitName) - Length(OldUnitName);

        // step 2: update the recently changed uses in the meta data
        UsedUnitInfo.DelphiUnitName := NewUnitName;
        if UsedUnitInfo.InFilePosition > 0 then
        begin
          if UsedUnitInfo.Position > 0 then
            UsedUnitInfo.InFilePosition := UsedUnitInfo.InFilePosition + PosOffset;

          PosOffset := PosOffset * 2;
        end;

        // step 3: update position of all following uses in the meta data
        StepNode := UpdateNode.NextSibling;

        while StepNode <> nil do
        begin
          FileUsingTheUnit.UsedUnits[GetNodeIndex(StepNode)].UpdatePosition(PosOffset);

          StepNode := StepNode.NextSibling;
        end;

      end;

      Inc(UpdatedCount);
    end;
  end;

  function RenameDelphiFile(DelphiFile: TDelphiFile): Boolean;
  var
    NewUnitName, NewUnitFilename, NewUnitFilenameExt, OldUnitNameComment, OldUnitName, OldFilename: String;
    i: Integer;
    PosOffset: Integer;
    UnitInfo: IUnitInfo;
  begin
    Result := FALSE;

    UnitInfo := DelphiFile.UnitInfo;

    // Store the name of the old unit
    OldFilename := UnitInfo.Filename;
    OldUnitName := UnitInfo.DelphiUnitName;
    if InsertOldNameComment then
      OldUnitNameComment := ' {renamed from ' + OldUnitName + '.pas}'
    else
      OldUnitNameComment := '';

    // Generate the new unit name and filename
    NewUnitName := SearchAndReplaceUnitName(UnitInfo.DelphiUnitName);
    NewUnitFilenameExt := ExtractFileExt(UnitInfo.Filename);
    if LowerCaseExtension then
      NewUnitFilenameExt := LowerCase(NewUnitFilenameExt);
    NewUnitFilename := IncludeTrailingPathDelimiter(ExtractFileDir(UnitInfo.Filename)) + NewUnitName +
      NewUnitFilenameExt;

    // Update the unit name in the file to be renamed
    if UnitInfo.DelphiUnitNamePosition = 0 then
    begin
      // We have no info about the position of the unit name in the source code.
      // Most likely due to a bug in the tokeniser.
      Log(StrUnableToRenameS, [UnitInfo.DelphiUnitName]);
    end
    else

      // Try to rename the file
      if RenameMatchingFiles(UnitInfo.Filename, NewUnitName, FALSE, LowerCaseExtension) then
      begin
        Result := TRUE;

        // If the file was renamed, update the local file info
        if not DummyRun then
          UnitInfo.Filename := NewUnitFilename;

        // Update the unitname clause
        if DummyRun or (SafeReplaceTextInFile(DummyRun, UnitInfo.Filename, UnitInfo.DelphiUnitName,
          NewUnitName + OldUnitNameComment, UnitInfo.DelphiUnitNamePosition)) then
        begin
          Log(StrUpdatedDelphiUnitNameIn, [UnitInfo.Filename, OldUnitName, NewUnitName]);

          if not DummyRun then
          begin
            UnitInfo.DelphiUnitName := NewUnitName;

            // Calculate the offset for the units in the uses clauses
            PosOffset := Length(NewUnitName + OldUnitNameComment) - Length(OldUnitName);

            // Update the position of all the used units
            for i := 0 to pred(UnitInfo.UsedUnits.Count) do
              UnitInfo.UsedUnits[i].UpdatePosition(PosOffset);
          end;
        end;
      end;
  end;

var
  StepNode: PVirtualNode;
  NodeDelphiUnitName, UpdateFilename: String;
  PreviousUnitName: String;
  FocusedNode: PVirtualNode;
begin
  if aClearLog then
    ClearLog();

  // Clear PreviousUnitNames
  StepNode := vtUnitsTree.GetFirst;

  while StepNode <> nil do
  begin
    FNodeObjects[GetID(StepNode)].DelphiFile.UnitInfo.PreviousUnitName := '';

    StepNode := vtUnitsTree.GetNext(StepNode);
  end;

  if PromptBeforeUpdate then
  begin
    pcView.ActivePage := tabTree;

    FocusedNode := vtUnitsTree.FocusedNode;
  end
  else
    FocusedNode := nil;
  try
    UpdatedCount := 0;

    if DummyRun then
      Log(StrTHISISADUMMYRUN, LogWarning);

    // Update all the uses clauses in the files
    StepNode := vtUnitsTree.GetFirst;

    while StepNode <> nil do
    begin
      NodeDelphiUnitName := GetDelphiUnitName(StepNode);

      // Does this name unit match?
      if IsUnitNameMatch(NodeDelphiUnitName) then
      begin
        // Get the filename for the unit
        UpdateFilename := FNodeObjects[GetID(StepNode)].DelphiFile.UnitInfo.Filename;

        // Update the filename if this is the original file node
        if FNodeObjects[GetID(StepNode)].DelphiFile.BaseNode = StepNode then
        begin
          PreviousUnitName := FNodeObjects[GetID(StepNode)].DelphiFile.UnitInfo.DelphiUnitName;

          if RenameDelphiFile(FNodeObjects[GetID(StepNode)].DelphiFile) then
            FNodeObjects[GetID(StepNode)].DelphiFile.UnitInfo.PreviousUnitName := PreviousUnitName;
        end;

        // Only update the uses clasuses for non root nodes
        if vtUnitsTree.GetNodeLevel(StepNode) > 0 then
        begin
          // This is a node that needs changing
          if PromptBeforeUpdate then
          begin
            vtUnitsTree.SelectNodeEx(StepNode);

            case MessageDlg(Format(StrUpdateTheUsesClauseIn, [UpdateFilename]), mtWarning,
              [mbYes, mbNo, mbCancel, mbYesToAll], 0) of
              mrYes:
                UpdateUsesClause(StepNode);
              mrYesToAll:
                begin
                  UpdateUsesClause(StepNode);

                  PromptBeforeUpdate := FALSE;
                end;
              mrCancel:
                Exit;
            end;
          end
          else
            UpdateUsesClause(StepNode);
        end;
      end;

      StepNode := vtUnitsTree.GetNext(StepNode);
    end;

    Log(StrFinishedUpdated, [UpdatedCount]);

    if DummyRun then
      Log(StrTHISWASADUMMYRUN, LogWarning);
  finally
    if FocusedNode <> nil then
      vtUnitsTree.SelectNodeEx(FocusedNode);

    UpdateTreeControls(vtUnitsTree.FocusedNode);
    UpdateListControls(vtUnitsList.FocusedNode);

    SearchList(vtUnitsList, edtListSearch.Text);

    vtUsedByUnits.Invalidate;
  end;
end;

procedure TfrmMain.AddUnitToUses(DummyRun: Boolean; DelphiFile: TDelphiFile; NewUnitName: String);
var
  ReferencedUnitName: string;
  UpdatedCount, AlreadyReferencedCount: Integer;
  CurrentDelphiFile: TDelphiFile;
begin
  ClearLog();

  try
    UpdatedCount := 0;
    AlreadyReferencedCount := 0;

    if DummyRun then
      Log(StrTHISISADUMMYRUN, LogWarning);

    ReferencedUnitName := DelphiFile.UnitInfo.DelphiUnitName;

    Log('Adding unit <%s> to all uses clauses that already reference unit <%s>.', [NewUnitName, ReferencedUnitName]);

    // Walk through all units
    for CurrentDelphiFile in FModel.DelphiFileList do
    begin
      // Only update .pas files, not project files
      if CurrentDelphiFile.UnitInfo.DelphiFileType = ftPAS then
      begin
        if FModel.IsUnitUsed(ReferencedUnitName, CurrentDelphiFile) then
          if FModel.IsUnitUsed(NewUnitName, CurrentDelphiFile) then
          begin
            Log('Unit <%s> already references unit <%s>. No update needed.', [CurrentDelphiFile.UnitInfo.DelphiUnitName,
              NewUnitName]);
            Inc(AlreadyReferencedCount);
          end else
          begin
            Log('Adding unit <%s> to uses clause of unit <%s>.',
              [NewUnitName, CurrentDelphiFile.UnitInfo.DelphiUnitName]);

            AddUnitToUsesInFile(DummyRun, CurrentDelphiFile, ReferencedUnitName, NewUnitName);

            Inc(UpdatedCount);
          end;
      end;
    end;

    if AlreadyReferencedCount > 0 then
       Log(StrNumberOfAlreadyReferencingUnits, [AlreadyReferencedCount]);
    Log(StrFinishedUpdated, [UpdatedCount]);

    if DummyRun then
      Log(StrTHISWASADUMMYRUN, LogWarning);
  finally

  end;
end;

procedure TfrmMain.ExportToXML(const VT: TVirtualStringTree; const Filename: String);
var
  XMLDoc: TXMLDocument;
  Count: Integer;

  procedure ProcessTreeItem(const ParentNode: PVirtualNode; const ParentXMLNode: IXMLNode);
  var
    Node: PVirtualNode;
    XMLNode: IXMLNode;
    NodeObject: TNodeObject;
    DelphiFile: TDelphiFile;
  begin
    if ParentNode <> nil then
    begin
      Node := ParentNode;

      while Node <> nil do
      begin
        if VT.IsVisible[Node] then
        begin
          DelphiFile := nil;

          if VT = vtUnitsList then
          begin
            DelphiFile := FModel.DelphiFileList[GetID(Node)];

            NodeObject := nil;
          end
          else
          begin
            NodeObject := FNodeObjects[GetID(Node)];

            if NodeObject <> nil then
              DelphiFile := NodeObject.DelphiFile;
          end;

          if DelphiFile <> nil then
          begin
            XMLNode := ParentXMLNode.AddChild('Unit');
            XMLNode.Attributes['Name'] := DelphiFile.UnitInfo.DelphiUnitName;
            XMLNode.Attributes['UsedCount'] := DelphiFile.UsedCount.ToString;
            XMLNode.Attributes['InSearchPath'] := DelphiFile.InSearchPath;
            XMLNode.Attributes['LineCount'] := DelphiFile.UnitInfo.LineCount;
            XMLNode.Attributes['UnitNameCharPosition'] := DelphiFile.UnitInfo.DelphiUnitNamePosition;
            XMLNode.Attributes['FileType'] := DelphiFileTypeStrings[DelphiFile.UnitInfo.DelphiFileType];

            if NodeObject <> nil then
            begin
              XMLNode.Attributes['IsLink'] := NodeObject.Link <> nil;
              XMLNode.Attributes['CircularReferenceType'] := CircularRelationshipTypeDescriptions
                [NodeObject.CircularReference];
            end;

            XMLNode.Attributes['Filename'] := DelphiFile.UnitInfo.Filename;

            Inc(Count);
          end;

          if Node.FirstChild <> nil then
            ProcessTreeItem(Node.FirstChild, XMLNode);
        end;

        Node := Node.NextSibling;
      end;
    end;
  end;

begin
  ShowHourGlass;
  try
    Count := 0;

    XMLDoc := TXMLDocument.Create(nil);

    XMLDoc.Active := TRUE;

    ProcessTreeItem(VT.GetFirst, XMLDoc.AddChild('DUDS'));

    XMLDoc.SaveToFile(Filename);
  finally
    HideHourGlass;
  end;
end;

procedure TfrmMain.actStartScanExecute(Sender: TObject);
var
  FileScanner: TDudsFileScanner;
begin
  if FProjectSettings.RootFiles.Count = 0 then
  begin
    if MessageDlg(StrYouNeedToAddAtLeastOne, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      actSettings.Execute
  end
  else
  begin
    ClearLog;
    FModel.Files.Clear;
    FModel.DelphiFiles.Clear;
    ClearStats;
    FStartTime := now;
    FCancelled := FALSE;

    actStartScan.Visible := FALSE;
    actStopScan.Visible := TRUE;
    actStopScan.Enabled := TRUE;

    FBusy := TRUE;
    try
      UpdateControls;
      ShowHideControls;
      pnlMain.Visible := TRUE;

      RichEditUnitPath.Clear;
      RichEditUnitPath.SelText := 'Loading...';
      UpdateStats(TRUE);
      Refresh;

      FileScanner := TDudsFileScanner.Create;
      try
        FileScanner.LoadFilesInSearchPaths(FModel, FProjectSettings);
        Log(StrDFilesFound, [FModel.Files.Count]);
      finally
        FreeAndNil(FileScanner);
      end;

      if not FCancelled then
        BuildDependencyTree;
    finally
      FBusy := FALSE;

      actStartScan.Visible := TRUE;
      actStopScan.Visible := FALSE;

      ShowHideControls;

      UpdateStats(TRUE);
      UpdateTreeControls(vtUnitsTree.FocusedNode);
    end;
  end;
end;

procedure TfrmMain.ShowHideControls;
begin
  pcView.Visible := not FBusy;
  Splitter1.Visible := not FBusy;

  if FBusy then
  begin
    FpnlLogHeight := pnlLog.Height;
    pnlLog.Align := alClient;
  end
  else
  begin
    pnlLog.Align := alBottom;
    pnlLog.Height := FpnlLogHeight;
    Splitter1.Top := pnlLog.Top - 1;
  end;
end;

procedure TfrmMain.actStopScanExecute(Sender: TObject);
begin
  FCancelled := TRUE;

  actStopScan.Enabled := FALSE;
end;

procedure TfrmMain.actSaveChangesExecute(Sender: TObject);
begin
  if memParentFile.Modified then
    memParentFile.Lines.SaveToFile(FNodeObjects[GetID(vtUnitsTree.FocusedNode.Parent)].DelphiFile.UnitInfo.Filename);

  if memSelectedFile.Modified then
    memSelectedFile.Lines.SaveToFile(FNodeObjects[GetID(vtUnitsTree.FocusedNode.Parent)].DelphiFile.UnitInfo.Filename);

  if memListFile.Modified then
    memListFile.Lines.SaveToFile(FModel.DelphiFileList[GetFocusedID(vtUnitsList)].UnitInfo.Filename);

  memParentFile.Modified := FALSE;
  memSelectedFile.Modified := FALSE;
  memListFile.Modified := FALSE;
end;

procedure TfrmMain.actSaveProjectAsExecute(Sender: TObject);
begin
  SaveProjectAs;
end;

procedure TfrmMain.actSaveProjectExecute(Sender: TObject);
begin
  SaveProject;
end;

procedure TfrmMain.actSaveToGephiCSVExecute(Sender: TObject);
begin
  if SaveDialogGephiCSV.Execute then
    ExportToGephi(FModel, actShowUnitsNotInPath.Checked, SaveDialogGephiCSV.Filename);
end;

procedure TfrmMain.actSaveToGraphMLExecute(Sender: TObject);
begin
  if SaveDialog4.Execute then
    ExportToGraphML(FModel, actShowUnitsNotInPath.Checked, SaveDialog4.Filename);
end;



procedure TfrmMain.actSaveToXMLExecute(Sender: TObject);
begin
  if SaveDialog2.Execute then
  begin
    if pcView.ActivePage = tabTree then
      ExportToXML(vtUnitsTree, SaveDialog2.Filename)
    else
      ExportToXML(vtUnitsList, SaveDialog2.Filename)
  end;
end;

function TfrmMain.SaveProject: Boolean;
begin
  if FProjectFilename = '' then
    Result := SaveProjectAs
  else
  begin
    SaveProjectSettings(FProjectFilename);

    Result := TRUE;
  end;
end;

function TfrmMain.SaveProjectAs: Boolean;
begin
  Result := SaveDialog1.Execute;

  if Result then
  begin
    FProjectFilename := SaveDialog1.Filename;

    SaveProjectSettings(FProjectFilename);
  end;
end;

procedure TfrmMain.actSearchAndReplaceExecute(Sender: TObject);
begin
  RenameDelphiFileWithDialog(rtSearchAndReplace);
end;

procedure TfrmMain.actSettingsExecute(Sender: TObject);
begin
  With TfrmDependencyScannerSetting.Create(Self) do
    try
      SaveProjectSettings;

      if Execute(FEnvironmentSettings, FProjectSettings) then
      begin
        LoadProjectSettings('', FALSE);

        Modified := TRUE;
      end;
    finally
      Release;
    end;
end;

procedure TfrmMain.actShowFileExecute(Sender: TObject);
var
  DelphiFile: TDelphiFile;
begin
  DelphiFile := GetFocusedDelphiFile;

  if DelphiFile <> nil then
    ShellExecute(Handle, 'OPEN', PChar('explorer.exe'), PChar('/select, "' + DelphiFile.UnitInfo.Filename + '"'), nil,
      SW_NORMAL);
end;

procedure TfrmMain.actShowUnitsNotInPathExecute(Sender: TObject);
begin
  ShowUnitsNotInPath;
end;

procedure TfrmMain.SetNodeVisibility(VT: TVirtualStringTree; Node: PVirtualNode; DelphiFile: TDelphiFile);
begin
  if (Node <> nil) and (DelphiFile <> nil) then
    VT.IsVisible[Node] := (DelphiFile.InSearchPath) or
      ((not DelphiFile.InSearchPath) and (actShowUnitsNotInPath.Checked));
end;

procedure TfrmMain.ShowUnitsNotInPath;
var
  Node: PVirtualNode;
begin
  vtUnitsTree.BeginUpdate;
  try
    Node := vtUnitsTree.GetFirst;

    while Node <> nil do
    begin
      SetNodeVisibility(vtUnitsTree, Node, FNodeObjects[GetID(Node)].DelphiFile);

      Node := vtUnitsTree.GetNext(Node);
    end;

    if vtUnitsTree.FocusedNode <> nil then
      vtUnitsTree.ScrollIntoView(vtUnitsTree.FocusedNode, TRUE);
  finally
    vtUnitsTree.EndUpdate;
  end;

  vtUnitsList.BeginUpdate;
  try
    Node := vtUnitsList.GetFirst;

    while Node <> nil do
    begin
      SetNodeVisibility(vtUnitsList, Node, FModel.DelphiFileList[GetID(Node)]);

      Node := Node.NextSibling;
    end;

    if vtUnitsList.FocusedNode <> nil then
      vtUnitsList.ScrollIntoView(vtUnitsList.FocusedNode, TRUE);
  finally
    vtUnitsList.EndUpdate;
  end;
end;

procedure TfrmMain.tmrCloseTimer(Sender: TObject);
begin
  tmrClose.Enabled := FALSE;

  if not FBusy then
  begin
    FClosing := TRUE;

    Close;
  end;
end;

procedure TfrmMain.tmrLoadedTimer(Sender: TObject);
begin
  tmrLoaded.Enabled := FALSE;

  if FLoadLastProject then
  begin
    if not LoadProjectSettings(FProjectFilename) then
    begin
      FProjectFilename := '';

      CloseControls;
    end;
  end;

  Show;
end;

procedure TfrmMain.FixDPI;

  procedure ScaleVT(const VT: TVirtualStringTree);
  begin
    VT.DefaultNodeHeight := ScaleDimension(VT.DefaultNodeHeight, PixelsPerInch);
    VT.Header.Height := ScaleDimension(VT.Header.Height, PixelsPerInch);
    VT.Header.Font.Size := ScaleDimension(VT.Header.Font.Size, PixelsPerInch);
  end;

begin
  ScaleVT(vtUnitsTree);
  ScaleVT(vtUnitsList);
  ScaleVT(vtUsedByUnits);
  ScaleVT(vtUsesUnits);

  RichEditUnitPath.Height := ScaleDimension(RichEditUnitPath.Height, PixelsPerInch);
end;

procedure TfrmMain.BuildDependencyTree(NoLog: Boolean);

  procedure ExtractUnits(var UnitString: String; Units: TStringList);
  var
    UnitList: String;
  begin
    UnitList := NextBlock(UnitString, ';');

    while UnitList <> '' do
      Units.Add(NextBlock(UnitList, ','));
  end;

  function GetParentCircularRelationship(TreeNode: PVirtualNode; const DelphiUnitName: String)
    : TCircularRelationshipType;
  var
    i: Integer;
    UsedUnitType: TUsedUnitType;
  begin
    Result := crNone;

    if TreeNode <> nil then
    begin
      TreeNode := TreeNode.Parent;

      if (TreeNode <> nil) and (TreeNode <> vtUnitsTree.RootNode) then
      begin
        UsedUnitType := utImplementation;

        if FNodeObjects[GetID(TreeNode)] <> nil then
        begin
          for i := 0 to pred(FNodeObjects[GetID(TreeNode)].DelphiFile.UnitInfo.UsedUnits.Count) do
          begin
            if SameText(FNodeObjects[GetID(TreeNode)].DelphiFile.UnitInfo.UsedUnits[i].DelphiUnitName, DelphiUnitName)
            then
            begin
              UsedUnitType := FNodeObjects[GetID(TreeNode)].DelphiFile.UnitInfo.UsedUnits[i].UsesType;

              Break;
            end;
          end;
        end;

        while (TreeNode <> nil) and (TreeNode <> vtUnitsTree.RootNode) do
        begin
          if SameText(FNodeObjects[GetID(TreeNode)].DelphiFile.UnitInfo.DelphiUnitName, DelphiUnitName) then
          begin
            if UsedUnitType = utInterface then
              Result := crCircular
            else
              Result := crSemiCircular;

            Break;
          end
          else
            TreeNode := TreeNode.Parent;
        end;
      end;
    end;
  end;

  function AddUnitNode(Parent: PVirtualNode; UnitInfo: IUnitInfo; InPath: Boolean): PVirtualNode;
  var
    DelphiFile: TDelphiFile;
    ListNode, NewNode: PVirtualNode;
    NodeObject: TNodeObject;
  begin
    NodeObject := TNodeObject.Create;
    Result := vtUnitsTree.AddChild(Parent);
    SetID(Result, FNodeObjects.Add(NodeObject));

    ListNode := nil;

    DelphiFile := FModel.FindParsedDelphiUnit(UnitInfo.DelphiUnitName);

    if DelphiFile = nil then
    begin
      DelphiFile := FModel.CreateDelphiFile(UnitInfo.DelphiUnitName);

      DelphiFile.UnitInfo := UnitInfo;

      if FScanDepth = 1 then
        DelphiFile.UsedCount := 0
      else
        DelphiFile.UsedCount := 1;

      DelphiFile.InSearchPath := InPath;
      DelphiFile.BaseNode := Result;

      ListNode := vtUnitsList.AddChild(nil);
      SetID(ListNode, pred(FModel.DelphiFiles.Count));

      NewNode := vtUsedByUnits.AddChild(nil);
      SetID(NewNode, pred(FModel.DelphiFiles.Count));

      NewNode := vtUsesUnits.AddChild(nil);
      SetID(NewNode, pred(FModel.DelphiFiles.Count));

      FLineCount := FLineCount + UnitInfo.LineCount;
    end
    else
    begin
      DelphiFile.UsedCount := DelphiFile.UsedCount + 1;

      if FProjectSettings.LinkUnits then
        FNodeObjects[GetID(Result)].Link := DelphiFile.BaseNode;
    end;

    FNodeObjects[GetID(Result)].DelphiFile := DelphiFile;
    FNodeObjects[GetID(Result)].CircularReference := GetParentCircularRelationship(Result, UnitInfo.DelphiUnitName);

    case FNodeObjects[GetID(Result)].CircularReference of
      crSemiCircular:
        Inc(FSemiCircularFiles);
      crCircular:
        Inc(FCircularFiles);
    end;

    SetNodeVisibility(vtUnitsTree, Result, DelphiFile);

    if ListNode <> nil then
      SetNodeVisibility(vtUnitsList, ListNode, DelphiFile);
  end;

  procedure BuildDependencyTreeRec(Parent: PVirtualNode; UsedUnitInfo: IUsedUnitInfo);
  var
    i: Integer;
    Node: PVirtualNode;
    UnitFilename: String;
    InPath: Boolean;
    Parsed: Boolean;
    UnitInfo: IUnitInfo;
    DelphiFile: TDelphiFile;
  begin
    Application.ProcessMessages;

    if not FCancelled then
    begin
      UpdateStats(FALSE);

      Inc(FScannedFiles);
      Inc(FScanDepth);

      if FScanDepth > FDeppestScanDepth then
        FDeppestScanDepth := FScanDepth;

      FModel.SearchUnitByNameWithScopes(UsedUnitInfo.DelphiUnitName, UnitFilename, FProjectSettings.UnitScopeNames);
      InPath := UnitFilename <> '';
      Parsed := FALSE;

      // Parse the unit
      if InPath then
      begin
        DelphiFile := FModel.FindParsedDelphiUnit(UsedUnitInfo.DelphiUnitName);

        if DelphiFile = nil then
        begin
          try
            Parsed := FPascalUnitExtractor.GetUsedUnits(UnitFilename, UnitInfo);

            for i := 0 to pred(UnitInfo.UsedUnits.Count) do
              if UnitInfo.UsedUnits[i].Filename <> '' then
                FModel.Files.AddOrSetValue(UpperCase(UnitInfo.UsedUnits[i].DelphiUnitName), UnitInfo.UsedUnits[i].Filename);

            Inc(FParsedFileCount);

            if FileExists(ChangeFileExt(UnitInfo.Filename, '.dfm')) then
              Inc(FVCLFormCount)
            else if FileExists(ChangeFileExt(UnitInfo.Filename, '.fmx')) then
              Inc(FFMXFormCount);
          except
            on e: Exception do
            begin
              Log(StrUnableToParseS, [UnitFilename, e.Message], LogError);
            end;
          end;
        end
        else
          UnitInfo := DelphiFile.UnitInfo;
      end
      else
      begin
        UnitInfo := TUnitInfo.Create;
        UnitInfo.DelphiUnitName := UsedUnitInfo.DelphiUnitName;
      end;

      Node := AddUnitNode(Parent, UnitInfo, InPath);

      FLastScanNode := Node;

      if (not FCancelled) and (Parsed) and (InPath) and (FNodeObjects[GetID(Node)].CircularReference = crNone) and
        (FNodeObjects[GetID(Node)].Link = nil) then
      begin
        for i := 0 to pred(UnitInfo.UsedUnits.Count) do
          BuildDependencyTreeRec(Node, UnitInfo.UsedUnits[i]);
      end;
    end;

    if FScanDepth > 0 then
      Dec(FScanDepth);
  end;

var
  RootUnitInfo: IUsedUnitInfo;
  i: Integer;
  RootFile: String;
begin
  vtUnitsTree.Clear;
  vtUnitsList.Clear;
  vtUsedByUnits.Clear;
  vtUsesUnits.Clear;
  memParentFile.Clear;
  memSelectedFile.Clear;

  Log(StrParsingFiles);

  vtUnitsTree.BeginUpdate;
  vtUnitsList.BeginUpdate;
  vtUsedByUnits.BeginUpdate;
  vtUsesUnits.BeginUpdate;
  try
    FModel.DelphiFiles.Clear;
    FModel.DelphiFileList.Clear;

    for i := 0 to pred(FProjectSettings.RootFiles.Count) do
    begin
      if FCancelled then
        Break;

      RootFile := FProjectSettings.RootFiles[i];

      if not RootFile.IsEmpty then // allow empty definition lines (e.g. for visual structuring)
      begin
        if not FileExists(RootFile) then
          Log(StrRootFileNotFound, [RootFile], LogWarning)
        else
        begin
          RootUnitInfo := TUsedUnitInfo.Create;
          RootUnitInfo.DelphiUnitName := ExtractFilenameNoExt(RootFile);

          BuildDependencyTreeRec(nil, RootUnitInfo);
        end;
      end;
    end;

    if vtUnitsTree.FocusedNode = nil then
      vtUnitsTree.SelectNodeEx(vtUnitsTree.GetFirst);

    if vtUnitsList.FocusedNode = nil then
      vtUnitsList.SelectNodeEx(vtUnitsList.GetFirst);

    Log(StrDFilesWithATo, [FModel.DelphiFiles.Count, FLineCount]);
  finally
    ExpandAll;

    vtUnitsTree.EndUpdate;
    vtUnitsList.EndUpdate;
    vtUsedByUnits.EndUpdate;
    vtUsesUnits.EndUpdate;

    FLastScanNode := nil;

    UpdateListControls(vtUnitsList.FocusedNode);

    UpdateStats(TRUE);
  end;
end;

procedure TfrmMain.ClearStats;
begin
  FScannedFiles := 0;
  FSemiCircularFiles := 0;
  FCircularFiles := 0;
  FParsedFileCount := 0;
  FLineCount := 0;
  FDeppestScanDepth := 0;
  FScanDepth := 0;
  FFMXFormCount := 0;
  FVCLFormCount := 0;
  FLastScanNode := nil;
end;

procedure TfrmMain.UpdateStats(ForceUpdate: Boolean);

var
  Index: Integer;

  procedure AddStat(const StatName: String; StatValue: Variant);
  begin
    if Index > FStats.Count - 1 then
      FStats.Add('');

    FStats[Index] := StatName + '=' + VarToStr(StatValue);

    Inc(Index);
  end;

begin
  if (not(FClosing)) and ((ForceUpdate) or (FNextStatusUpdate = 0) or (now > FNextStatusUpdate)) then
  begin
    FNextStatusUpdate := now + (50 * OneMilliSecond);

    Index := 0;

    AddStat(StrTime, SecondsToTimeString(SecondsBetween(now, FStartTime)));
    AddStat(StrScannedFiles, FormatCardinal(FScannedFiles));
    AddStat(StrSemiCircularFiles, FormatCardinal(FSemiCircularFiles));
    AddStat(StrFCircularFiles, FormatCardinal(FCircularFiles));
    AddStat(StrFilesFound, FormatCardinal(FModel.DelphiFiles.Count));
    AddStat(StrParsedFiles, FormatCardinal(FParsedFileCount));
    AddStat(StrVCLFormCount, FormatCardinal(FVCLFormCount));
    AddStat(StrFMXFormCount, FormatCardinal(FFMXFormCount));
    AddStat(StrTotalLines, FormatCardinal(FLineCount));
    AddStat(StrSearchPathFiles, FormatCardinal(FModel.Files.Count));
    AddStat(StrDeepestScanDepth, FDeppestScanDepth);

    if FBusy then
    begin
      AddStat(StrScanDepth, FScanDepth);
    end;

    while Index < FStats.Count do
      FStats.Delete(pred(FStats.Count));

    vtStats.RootNodeCount := FStats.Count;
    vtStats.Invalidate;
  end;
end;

end.
