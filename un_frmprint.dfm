object frmMKPrint: TfrmMKPrint
  Left = 160
  Top = 194
  Width = 484
  Height = 168
  HorzScrollBar.Range = 472
  VertScrollBar.Range = 129
  ActiveControl = btnPrint
  BorderIcons = []
  Caption = 'Imprime'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 3
    Top = 91
    Width = 469
    Height = 38
    BevelOuter = bvLowered
    TabOrder = 7
  end
  object Panel1: TPanel
    Left = 3
    Top = 1
    Width = 469
    Height = 86
    BevelOuter = bvLowered
    TabOrder = 6
    object Bevel1: TBevel
      Left = 7
      Top = 31
      Width = 455
      Height = 3
    end
    object Label1: TLabel
      Left = 7
      Top = 7
      Width = 57
      Height = 15
      Caption = 'Impressora'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Century Gothic'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 5
      Top = 37
      Width = 22
      Height = 15
      Caption = 'Loja'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Century Gothic'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 160
      Top = 37
      Width = 39
      Height = 15
      Caption = 'Divis'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Century Gothic'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 319
      Top = 37
      Width = 37
      Height = 15
      Caption = 'Edi'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Century Gothic'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object btnPrint: TBitBtn
    Left = 38
    Top = 98
    Width = 178
    Height = 25
    Caption = 'Imprimir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Century Gothic'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnPrintClick
  end
  object btnclose: TBitBtn
    Left = 259
    Top = 98
    Width = 178
    Height = 25
    Caption = 'Fechar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Century Gothic'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btncloseClick
  end
  object cmbprinter: TComboBox
    Left = 73
    Top = 6
    Width = 144
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 2
    Text = 'Laser'
    Items.Strings = (
      'Laser'
      'Matricial')
  end
  object dblcloja: TDBLookupComboBox
    Left = 8
    Top = 55
    Width = 145
    Height = 21
    KeyField = 'codloja'
    ListField = 'descricao'
    ListSource = Dm.DtsCga109
    TabOrder = 3
    OnClick = dblclojaClick
  end
  object dblcdivisao: TDBLookupComboBox
    Left = 163
    Top = 55
    Width = 145
    Height = 21
    KeyField = 'coddiv'
    ListField = 'coddiv'
    ListSource = Dm.DtsCgaLojadivi
    TabOrder = 4
  end
  object dblcedicao: TDBLookupComboBox
    Left = 321
    Top = 55
    Width = 145
    Height = 21
    KeyField = 'numedi'
    ListField = 'numedi'
    ListSource = Dm.DtsCga105
    TabOrder = 5
  end
end
