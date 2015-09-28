object FrmExtUnificado: TFrmExtUnificado
  Left = 184
  Top = 240
  Width = 661
  Height = 133
  BorderIcons = []
  Caption = 'Cadastro de Extrato Unificado'
  Color = clBtnFace
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13

  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 661
    Height = 133
    VertScrollBar.Range = 119
    HorzScrollBar.Range = 634
    Align = alClient
    TabOrder = 0
    object DbLkBaixa: TDBLookupComboBox
      Left = 365
      Top = 16
      Width = 269
      Height = 23
      KeyField = 'cg20_codbaixa'
      ListField = 'cg20_descricao'
      ListSource = Dm.DtsCga20
      TabOrder = 0
    end
    object EdCaixa: TEdit
      Left = 101
      Top = 18
      Width = 164
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object EdQt: TEdit
      Left = 101
      Top = 51
      Width = 164
      Height = 21
      ReadOnly = True
      TabOrder = 2
      Text = '0'
    end
    object Panel1: TPanel
      Left = 16
      Top = 16
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Caixa'
      TabOrder = 3
    end
    object Panel2: TPanel
      Left = 280
      Top = 16
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Baixa'
      TabOrder = 4
    end
    object Panel3: TPanel
      Left = 15
      Top = 48
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Quantidade'
      TabOrder = 5
    end
    object EdRemessa: TEdit
      Left = 364
      Top = 52
      Width = 269
      Height = 21
      MaxLength = 22
      TabOrder = 6
      OnKeyPress = EdRemessaKeyPress
    end
    object Panel4: TPanel
      Left = 280
      Top = 50
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Remessa'
      TabOrder = 7
    end
    object BtnFechar: TBitBtn
      Left = 263
      Top = 94
      Width = 75
      Height = 25
      Caption = '&Fechar'
      TabOrder = 8
      OnClick = BtnFecharClick
      Glyph.Data = {
        7A010000424D7601000000000000760000002800000020000000100000000100
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
  end
end
