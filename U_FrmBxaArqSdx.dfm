object FrmBxaArqSdx: TFrmBxaArqSdx
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'FrmBxaArqSdx'
  ClientHeight = 383
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel: TBevel
    Left = 16
    Top = 8
    Width = 385
    Height = 177
  end
  object Label5: TLabel
    Left = 18
    Top = 225
    Width = 35
    Height = 13
    Caption = 'Servi'#231'o'
  end
  object RegTotal: TLabel
    Left = 274
    Top = 282
    Width = 54
    Height = 13
    Caption = 'Gravados'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 18
    Top = 187
    Width = 37
    Height = 13
    Caption = 'Arquivo'
  end
  object Label2: TLabel
    Left = 297
    Top = 247
    Width = 30
    Height = 13
    Caption = 'Lidos'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DriveCboBox: TDriveComboBox
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
    FileList = FileListBox
    ItemHeight = 16
    TabOrder = 1
  end
  object FileListBox: TFileListBox
    Left = 207
    Top = 16
    Width = 188
    Height = 157
    Hint = 'Escolha um Arquivo'
    FileType = [ftArchive, ftNormal]
    ItemHeight = 16
    ParentShowHint = False
    ShowGlyphs = True
    ShowHint = True
    TabOrder = 2
    OnChange = FileListBoxChange
  end
  object Edarq: TEdit
    Left = 16
    Top = 202
    Width = 385
    Height = 21
    AutoSize = False
    ReadOnly = True
    TabOrder = 3
  end
  object DBCboSdxServ: TDBLookupComboBox
    Left = 16
    Top = 240
    Width = 131
    Height = 21
    KeyField = 'tbsdxserv_prod'
    ListField = 'tbsdxserv_dsc'
    ListSource = Dm.DtSSdxServ
    TabOrder = 4
  end
  object BtnLerArq: TBitBtn
    Left = 16
    Top = 275
    Width = 131
    Height = 25
    Caption = 'Proc.Baixa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = BtnLerArqClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FF0274AC
      0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC046B0B0274AC0274
      AC0274ACFF00FFFF00FF0274AC138AC457B7E06BCBF84BBFF74ABFF74ABFF74A
      BFF74ABFF64ABFF7046B0B046B0B2398CC0274ACFF00FFFF00FF0274AC33AAE0
      2392C489D9FA54C7F854C7F753C7F854C7F754C7F854C7F8046B0B15A128046B
      0B6ACBE50274ACFF00FF0274AC57CAF80274AC99E3FB5ED1FA046B0B046B0B04
      6B0B046B0B046B0B046B0B1AAA3115A128046B0B0274ACFF00FF0274AC5ED3FA
      1173A39CB0BCA6A0A3046B0B46E57D41DE743AD56832CA5A29BF4B22B53E1AAA
      3214A128046B0BFF00FF0274AC68DAFB43728E67BAD8E3FEFE046B0B46E57D46
      E57D41DE743AD56832CB5929C04B21B53E1AAA3114A028046B0B0274AC70E3FB
      8770781586B6FFFFFF046B0B46E57D46E57D46E57D41DE753AD56832CB5A29C0
      4B21B43D046B0B0274AC0274AC7AEBFEA56F6F1180B40274AC046B0B046B0B04
      6B0B046B0B046B0B046B0B3AD56732CA59046B0B0274AC0274AC0274AC83F2FE
      A56F6FFEF3E7FEEEE0FFF2E6FFF3EAFEF6EEFEF8F2FEF3E7046B0B41DE74046B
      0BFF00FFFF00FFFF00FF0274ACFEFEFEA56F6FFFEBDAFFEBDAFFEDDDFFEEDEFF
      EFE2FFF2E5FFEBDA046B0B046B0B036FA7FF00FFFF00FFFF00FFFF00FF0274AC
      A56F6FFFE7D3FFE7D3FFE7D3FFE7D3E2C9BAE0CABACBB5A7046B0B0274ACFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFA56F6FFFE5CCFFE3CBFFE5CCFFE5CCB4
      9591B59692BFA19CBF8181FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      A56F6FFFE1C5FFE1C5FFE1C5FADCC1B69793FEFEFEBF8181FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFA56F6FFFDEC1FFDEC1FFDEC1E2C1ADC5
      A7A0BF8181FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      A56F6FA56F6FA56F6FA56F6FA56F6FBF8181FF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
  end
  object edGrava: TEdit
    Left = 330
    Top = 277
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
    Top = 315
    Width = 385
    Height = 41
    TabOrder = 7
  end
  object EdLido: TEdit
    Left = 330
    Top = 240
    Width = 71
    Height = 21
    AutoSize = False
    BiDiMode = bdRightToLeft
    CharCase = ecUpperCase
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 8
  end
  object ExcelApp: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 156
    Top = 276
  end
end
