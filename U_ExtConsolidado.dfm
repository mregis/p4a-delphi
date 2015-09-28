object FrmExtConsolidado: TFrmExtConsolidado
  Left = 299
  Top = 193
  ActiveControl = ScrollBox1
  BorderIcons = []
  Caption = 'Baixa de Extrato Consolidado'
  ClientHeight = 252
  ClientWidth = 389
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 389
    Height = 252
    HorzScrollBar.Range = 369
    VertScrollBar.Range = 237
    Align = alClient
    AutoScroll = False
    TabOrder = 0
    object Panel5: TPanel
      Left = 16
      Top = 16
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Caixa'
      TabOrder = 0
    end
    object EdCaixa: TEdit
      Left = 101
      Top = 16
      Width = 266
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object Panel6: TPanel
      Left = 16
      Top = 47
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Baixa'
      TabOrder = 2
    end
    object DbLkbaixa: TDBLookupComboBox
      Left = 100
      Top = 47
      Width = 269
      Height = 21
      KeyField = 'cg20_codbaixa'
      ListField = 'cg20_descricao'
      ListSource = Dm.DtsCga20
      TabOrder = 3
    end
    object Panel7: TPanel
      Left = 16
      Top = 177
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Quantidade'
      TabOrder = 4
    end
    object EdQt: TEdit
      Left = 101
      Top = 180
      Width = 266
      Height = 21
      ReadOnly = True
      TabOrder = 5
      Text = '0'
    end
    object Panel8: TPanel
      Left = 16
      Top = 147
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Remessa'
      TabOrder = 6
    end
    object EdRemes: TEdit
      Left = 101
      Top = 148
      Width = 267
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Microsoft Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnKeyPress = EdRemesKeyPress
    end
    object Panel9: TPanel
      Left = 16
      Top = 101
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Agencia'
      TabOrder = 8
    end
    object EdAgencia: TEdit
      Left = 101
      Top = 79
      Width = 267
      Height = 56
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 48
      Font.Name = 'Microsoft Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 9
    end
    object BtnFechar: TBitBtn
      Left = 159
      Top = 212
      Width = 75
      Height = 25
      Caption = '&Fechar'
      TabOrder = 10
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
  end
end
