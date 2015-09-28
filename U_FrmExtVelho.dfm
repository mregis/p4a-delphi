object FrmBxaArqSdx: TFrmBxaArqSdx
  Left = 0
  Top = 0
  Caption = 'FrmBxaArqSdx'
  ClientHeight = 395
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 16
    Top = 8
    Width = 385
    Height = 177
  end
  object Label5: TLabel
    Left = 18
    Top = 265
    Width = 35
    Height = 13
    Caption = 'Servi'#231'o'
  end
  object captot: TLabel
    Left = 296
    Top = 327
    Width = 29
    Height = 13
    Caption = 'Total'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DriveComboBox1: TDriveComboBox
    Left = 24
    Top = 16
    Width = 176
    Height = 19
    DirList = diretorio
    TabOrder = 0
  end
  object diretorio: TDirectoryListBox
    Left = 25
    Top = 53
    Width = 176
    Height = 119
    FileList = FileListBox1
    ItemHeight = 16
    TabOrder = 1
  end
  object FileListBox1: TFileListBox
    Left = 207
    Top = 16
    Width = 188
    Height = 157
    Hint = 'Escolha um Arquivo'
    FileType = [ftArchive, ftNormal]
    ItemHeight = 16
    Mask = '*.csv'
    ParentShowHint = False
    ShowGlyphs = True
    ShowHint = True
    TabOrder = 2
  end
  object Edarq: TEdit
    Left = 16
    Top = 202
    Width = 213
    Height = 21
    AutoSize = False
    ReadOnly = True
    TabOrder = 3
  end
  object DBCboSdxServ: TDBLookupComboBox
    Left = 16
    Top = 280
    Width = 121
    Height = 21
    KeyField = 'tbsdxserv_prod'
    ListField = 'tbsdxserv_dsc'
    ListSource = Dm.DtSSdxServ
    TabOrder = 4
  end
  object BtnLerArq: TBitBtn
    Left = 16
    Top = 320
    Width = 121
    Height = 25
    Caption = 'Carregar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object edTot: TEdit
    Left = 330
    Top = 322
    Width = 71
    Height = 21
    AutoSize = False
    BiDiMode = bdRightToLeft
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 6
  end
  object Painel: TPanel
    Left = 16
    Top = 354
    Width = 385
    Height = 41
    TabOrder = 7
  end
  object ExcelApp: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 116
    Top = 369
  end
end
