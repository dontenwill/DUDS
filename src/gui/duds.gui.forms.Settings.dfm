object frmSettings: TfrmSettings
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Settings'
  ClientHeight = 551
  ClientWidth = 953
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 400
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pcSettings: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 947
    Height = 517
    ActivePage = tabRootFiles
    Align = alClient
    TabOrder = 0
    object tabRootFiles: TTabSheet
      Caption = 'Root Files'
      object Panel4: TPanel
        Left = 826
        Top = 0
        Width = 113
        Height = 365
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object btnAddFile: TButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 107
          Height = 25
          Align = alTop
          Caption = 'Add Root Files'
          TabOrder = 0
          OnClick = btnAddFileClick
        end
        object chkIncludeProjectSearchPaths: TCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 65
          Width = 107
          Height = 40
          Align = alTop
          Caption = 'Automatically add Project Search Paths'
          Checked = True
          State = cbChecked
          TabOrder = 2
          WordWrap = True
        end
        object btnScanForProjects: TButton
          AlignWithMargins = True
          Left = 3
          Top = 34
          Width = 107
          Height = 25
          Align = alTop
          Caption = 'Scan for Projects'
          TabOrder = 1
          OnClick = btnScanForProjectsClick
        end
      end
      object pnlFTSInfo: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 368
        Width = 933
        Height = 118
        Align = alBottom
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 2
        object Panel14: TPanel
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 931
          Height = 116
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alClient
          BevelOuter = bvNone
          Color = 12910591
          ParentBackground = False
          TabOrder = 0
          object lnkFTSInfo: TLabel
            AlignWithMargins = True
            Left = 1
            Top = 1
            Width = 929
            Height = 114
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alClient
            Caption = 
              'Enter at least one root file. The following files types are supp' +
              'orted:'#13#10'-  Pascal Files (.pas)'#13#10'-  Delphi Projects (.dpr)'#13#10'-  De' +
              'lphi Packages (.dpk)'#13#10'-  Group Projects(.groupproj).  '#13#10'Each of ' +
              'the root file directories will be searched for matching units. A' +
              'dd additional paths under the Search Paths tab.'#13#10#13#10'Empty lines w' +
              'ill be ignored. "//" Comments will be ignored.'
            Color = 14548991
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
            WordWrap = True
            ExplicitWidth = 603
            ExplicitHeight = 104
          end
        end
      end
      object memRootFiles: TRichEdit
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 820
        Height = 359
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        PlainText = True
        ScrollBars = ssBoth
        TabOrder = 1
        WordWrap = False
        Zoom = 100
        OnChange = OnSettingChange
      end
    end
    object tabSearchPaths: TTabSheet
      Caption = 'Search Paths'
      ImageIndex = 1
      object Panel2: TPanel
        Left = 779
        Top = 0
        Width = 160
        Height = 436
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitLeft = 600
        ExplicitHeight = 334
        object btnAddPath: TButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 154
          Height = 25
          Align = alTop
          Caption = 'Add Search Paths'
          TabOrder = 0
          OnClick = btnAddPathClick
        end
        object chkRecursive: TCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 34
          Width = 154
          Height = 15
          Hint = 
            'This will add also subfolders when you pick a path with "Add Sea' +
            'rch Paths".'#13#10#13#10'If you want to perform recursion at scan-time, ad' +
            'd <+> behind the path.'
          Align = alTop
          Caption = 'Add recursive to settings'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          WordWrap = True
        end
      end
      object memSearchPaths: TRichEdit
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 773
        Height = 430
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        PlainText = True
        ScrollBars = ssBoth
        TabOrder = 1
        WordWrap = False
        Zoom = 100
        OnChange = OnSettingChange
      end
      object Panel3: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 439
        Width = 933
        Height = 47
        Align = alBottom
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 2
        ExplicitTop = 337
        ExplicitWidth = 754
        object Panel5: TPanel
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 931
          Height = 45
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alClient
          BevelOuter = bvNone
          Color = 12910591
          ParentBackground = False
          TabOrder = 0
          ExplicitWidth = 752
          object Label1: TLabel
            AlignWithMargins = True
            Left = 1
            Top = 1
            Width = 402
            Height = 39
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alClient
            Caption = 
              'Each of the directories will be searched for matching files (*.p' +
              'as, *.dpr, *.dpk). '#13#10'Add <+> behind a search path to perform a r' +
              'ecusive search in subdirectories. '#13#10'E.g. C:\MyProject\source<+>'
            Color = 14548991
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
        end
      end
    end
    object tabModules: TTabSheet
      Caption = 'Modules'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 760
      ExplicitHeight = 387
      object edt_ModulesDefinitionFile: TLabeledEdit
        Left = 136
        Top = 17
        Width = 585
        Height = 21
        EditLabel.Width = 121
        EditLabel.Height = 13
        EditLabel.Caption = 'Modules Definition File'
        LabelPosition = lpLeft
        LabelSpacing = 5
        TabOrder = 0
        OnChange = edt_ModulesDefinitionFileChange
      end
    end
    object tabUnitScopes: TTabSheet
      Caption = 'Unit Scope Names'
      ImageIndex = 4
      object memUnitScopeNames: TRichEdit
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 933
        Height = 483
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'Winapi'
          'System.Win'
          'Data.Win'
          'Datasnap.Win'
          'Web.Win'
          'Soap.Win'
          'Xml.Win'
          'Bde'
          'System'
          'Xml'
          'Data'
          'Datasnap'
          'Web'
          'Soap'
          'Vcl'
          'Vcl.Imaging'
          'Vcl.Touch'
          'Vcl.Samples'
          'Vcl.Shell')
        ParentFont = False
        PlainText = True
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
        Zoom = 100
        OnChange = OnSettingChange
      end
    end
    object tabScan: TTabSheet
      Caption = 'Scan'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 760
      ExplicitHeight = 387
      object chkLinkUnits: TCheckBox
        Left = 16
        Top = 16
        Width = 233
        Height = 17
        Caption = 'Link Units that are found multiple times'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = OnSettingChange
      end
      object chkRunScanOnLoad: TCheckBox
        Left = 16
        Top = 39
        Width = 233
        Height = 17
        Caption = 'Start the scan when a project is loaded'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
    object tabEnvironment: TTabSheet
      Caption = 'Environment'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 760
      ExplicitHeight = 387
      object chkLoadLastProject: TCheckBox
        Left = 16
        Top = 16
        Width = 233
        Height = 17
        Caption = 'Open last Project on Startup'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 523
    Width = 953
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object lblStatus: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 5
      Width = 788
      Height = 20
      Margins.Top = 5
      Align = alClient
      AutoSize = False
      EllipsisPosition = epPathEllipsis
      ExplicitLeft = 112
      ExplicitTop = 8
      ExplicitWidth = 33
      ExplicitHeight = 13
    end
    object btnOK: TButton
      AlignWithMargins = True
      Left = 797
      Top = 0
      Width = 75
      Height = 25
      Margins.Top = 0
      Margins.Right = 0
      Align = alRight
      Caption = '&OK'
      Default = True
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 875
      Top = 0
      Width = 75
      Height = 25
      Margins.Top = 0
      Align = alRight
      Cancel = True
      Caption = '&Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.pas'
    Filter = 
      'Delphi Files (*.pas;*.dpr;*.dpk;*.groupproj)|*.pas;*.dpr;*.dpk;*' +
      '.groupproj|All Files (*.*)|*.*'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Title = 'Select Root File'
    Left = 120
    Top = 168
  end
  object popDelphiPaths: TPopupMenu
    Left = 209
    Top = 168
    object miWindowsPaths: TMenuItem
      Caption = 'Browse for Path...'
      OnClick = miWindowsPathsClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object miDelphiXE1: TMenuItem
      Tag = 15
      Caption = 'Delphi XE'
      OnClick = miDelphiXE3Click
    end
    object miDelphiXE2: TMenuItem
      Tag = 16
      Caption = 'Delphi XE2'
      OnClick = miDelphiXE3Click
    end
    object miDelphiXE3: TMenuItem
      Tag = 17
      Caption = 'Delphi XE3'
      OnClick = miDelphiXE3Click
    end
    object miDelphiXE41: TMenuItem
      Tag = 18
      Caption = 'Delphi XE4'
      OnClick = miDelphiXE3Click
    end
    object DelphiXE51: TMenuItem
      Tag = 19
      Caption = 'Delphi XE5'
      OnClick = miDelphiXE3Click
    end
    object DelphiXE61: TMenuItem
      Tag = 20
      Caption = 'Delphi XE6'
      OnClick = miDelphiXE3Click
    end
    object DelphiXE71: TMenuItem
      Tag = 21
      Caption = 'Delphi XE7'
      OnClick = miDelphiXE3Click
    end
  end
end