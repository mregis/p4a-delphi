object FrmDigExtratoUnificado: TFrmDigExtratoUnificado
  Left = 97
  Top = 151
  Width = 696
  Height = 195
  Caption = 'Digita'#231#227'o de Extratos - Extrato Unificado'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object StBr: TStatusBar
    Left = 0
    Top = 139
    Width = 688
    Height = 29
    Panels = <
      item
        Alignment = taCenter
        Width = 50
      end>
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 688
    Height = 139
    Align = alClient
    Color = 16704412
    ParentColor = False
    TabOrder = 1
    object Label1: TLabel
      Left = 473
      Top = 55
      Width = 167
      Height = 13
      Caption = '- Digite sem pontos ou tra'#231'os'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DbLkBaixa: TDBLookupComboBox
      Left = 413
      Top = 18
      Width = 257
      Height = 21
      KeyField = 'cg20_codbaixa'
      ListField = 'cg20_descricao'
      ListSource = Dm.DtsCga20
      TabOrder = 1
      OnKeyPress = EdControleKeyPress
    end
    object Panel2: TPanel
      Left = 312
      Top = 16
      Width = 95
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Baixa'
      TabOrder = 6
    end
    object EdCaixa: TEdit
      Left = 117
      Top = 18
      Width = 163
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object Panel1: TPanel
      Left = 16
      Top = 16
      Width = 95
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Caixa'
      TabOrder = 7
    end
    object MskAgencia: TMaskEdit
      Left = 117
      Top = 51
      Width = 60
      Height = 21
      EditMask = '9999-9;0; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 6
      ParentFont = False
      TabOrder = 2
      OnExit = MskAgenciaExit
      OnKeyPress = EdControleKeyPress
    end
    object Panel3: TPanel
      Left = 16
      Top = 49
      Width = 95
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Ag'#234'ncia'
      TabOrder = 8
    end
    object Panel4: TPanel
      Left = 312
      Top = 49
      Width = 95
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Conta Corrente'
      TabOrder = 9
    end
    object BtnFechar: TBitBtn
      Left = 585
      Top = 105
      Width = 93
      Height = 24
      Caption = '&Fechar'
      TabOrder = 5
      OnClick = BtnFecharClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
        0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
        0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
        0333337F777FFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
    end
    object Panel7: TPanel
      Left = 16
      Top = 85
      Width = 95
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Quantidade'
      TabOrder = 10
    end
    object EdQt: TEdit
      Left = 117
      Top = 87
      Width = 164
      Height = 21
      TabStop = False
      ReadOnly = True
      TabOrder = 4
      Text = '0'
    end
    object MskContaCorrente: TEdit
      Left = 413
      Top = 51
      Width = 56
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 3
      OnExit = MskContaCorrenteExit
      OnKeyPress = MskContaCorrenteKeyPress
    end
  end
end
