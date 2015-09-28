object FrmPesqImpProdTk: TFrmPesqImpProdTk
  Left = 206
  Top = 241
  Width = 430
  Height = 224
  Caption = 'Pesquisa Dados Produ'#231#227'o Tokens'
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
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 422
    Height = 197
    HorzScrollBar.Range = 403
    VertScrollBar.Range = 181
    Align = alClient
    AutoScroll = False
    TabOrder = 0
    object Bevel1: TBevel
      Left = 115
      Top = 148
      Width = 179
      Height = 28
    end
    object Panel5: TPanel
      Left = 16
      Top = 32
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Data Inicial'
      TabOrder = 4
    end
    object Panel9: TPanel
      Left = 213
      Top = 32
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Data Final'
      TabOrder = 5
    end
    object BtnFechar: TBitBtn
      Left = 215
      Top = 150
      Width = 75
      Height = 25
      Caption = '&Fechar'
      TabOrder = 3
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
    object Btn_Salvar: TBitBtn
      Left = 120
      Top = 150
      Width = 75
      Height = 25
      Caption = '&Imprimir'
      TabOrder = 2
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        0003377777777777777308888888888888807F33333333333337088888888888
        88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
        8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
        8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
    end
    object MkEdDtIni: TMaskEdit
      Left = 103
      Top = 33
      Width = 101
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
    end
    object MkEdDtFin: TMaskEdit
      Left = 300
      Top = 33
      Width = 101
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
    end
    object Panel1: TPanel
      Left = 16
      Top = 67
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Ag Ini'
      TabOrder = 6
    end
    object Panel2: TPanel
      Left = 216
      Top = 67
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Ag Fin'
      TabOrder = 7
    end
    object EdAgIni: TEdit
      Left = 104
      Top = 68
      Width = 101
      Height = 21
      Enabled = False
      TabOrder = 8
      Text = '0'
    end
    object EdAgFin: TEdit
      Left = 302
      Top = 68
      Width = 101
      Height = 21
      Enabled = False
      TabOrder = 9
      Text = '999999'
    end
    object RdGrpTipo: TRadioGroup
      Left = 22
      Top = 103
      Width = 383
      Height = 30
      Caption = 'Tipo'
      Columns = 3
      Items.Strings = (
        '0 - CPF'
        '1 - CNPJ'
        '2 - Todos')
      TabOrder = 10
    end
  end
end
