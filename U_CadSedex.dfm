object FrmCadSedex: TFrmCadSedex
  Left = 393
  Top = 220
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Sedex'
  ClientHeight = 357
  ClientWidth = 416
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
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
  object Bevel1: TBevel
    Left = 16
    Top = 8
    Width = 385
    Height = 177
  end
  object Label1: TLabel
    Left = 18
    Top = 225
    Width = 62
    Height = 13
    Caption = 'Range Inicial'
  end
  object Label2: TLabel
    Left = 280
    Top = 224
    Width = 57
    Height = 13
    Caption = 'Range Final'
  end
  object Label3: TLabel
    Left = 20
    Top = 188
    Width = 36
    Height = 13
    Caption = 'Arquivo'
  end
  object Label4: TLabel
    Left = 281
    Top = 188
    Width = 113
    Height = 13
    Caption = 'Sequ'#234'ncia da Remessa'
  end
  object Label5: TLabel
    Left = 18
    Top = 265
    Width = 36
    Height = 13
    Caption = 'Servi'#231'o'
  end
  object edTot: TEdit
    Left = 330
    Top = 322
    Width = 71
    Height = 21
    BiDiMode = bdRightToLeft
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
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
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object diretorio: TDirectoryListBox
    Left = 25
    Top = 53
    Width = 176
    Height = 119
    FileList = FileListBox1
    ItemHeight = 16
    TabOrder = 2
    OnClick = diretorioClick
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
    TabOrder = 3
    OnChange = FileListBox1Change
    OnClick = FileListBox1Click
  end
  object DriveComboBox1: TDriveComboBox
    Left = 24
    Top = 16
    Width = 176
    Height = 19
    DirList = diretorio
    TabOrder = 4
  end
  object EdRangeIni: TEdit
    Left = 16
    Top = 240
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object EdRangeFin: TEdit
    Left = 280
    Top = 240
    Width = 121
    Height = 21
    TabOrder = 6
    OnEnter = EdRangeFinEnter
    OnKeyPress = EdRangeFinKeyPress
  end
  object BtnCarrega: TBitBtn
    Left = 161
    Top = 320
    Width = 121
    Height = 25
    Caption = 'Carregar Layout'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Century Gothic'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    Visible = False
    OnClick = BtnCarregaClick
  end
  object Edarq: TEdit
    Left = 16
    Top = 202
    Width = 213
    Height = 21
    ReadOnly = True
    TabOrder = 8
  end
  object EdSeqArq: TEdit
    Left = 280
    Top = 201
    Width = 121
    Height = 21
    BiDiMode = bdRightToLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 9
  end
  object DBCboSdxServ: TDBLookupComboBox
    Left = 16
    Top = 280
    Width = 121
    Height = 21
    KeyField = 'tbsdxserv_prod'
    ListField = 'tbsdxserv_dsc'
    ListSource = Dm.DtSSdxServ
    TabOrder = 10
  end
end
