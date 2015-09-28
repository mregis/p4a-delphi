object FrmPesImpAssinantes: TFrmPesImpAssinantes
  Left = 264
  Top = 220
  ActiveControl = ScrollBox1
  BorderIcons = []
  Caption = 'Impress'#227'o para Assinantes'
  ClientHeight = 161
  ClientWidth = 256
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 256
    Height = 161
    HorzScrollBar.Range = 195
    VertScrollBar.Range = 137
    Align = alClient
    AutoScroll = False
    TabOrder = 0
    ExplicitHeight = 154
    object Panel5: TPanel
      Left = 14
      Top = 46
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Cod Cliente'
      TabOrder = 2
    end
    object Panel9: TPanel
      Left = 14
      Top = 18
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Edi'#231#227'o'
      TabOrder = 3
    end
    object BtnFechar: TBitBtn
      Left = 124
      Top = 120
      Width = 75
      Height = 25
      Caption = '&Fechar'
      TabOrder = 1
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
      Left = 45
      Top = 120
      Width = 75
      Height = 25
      Caption = '&Imprimir'
      TabOrder = 0
      OnClick = Btn_SalvarClick
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
    object EdEdicao: TEdit
      Left = 100
      Top = 19
      Width = 141
      Height = 21
      TabOrder = 4
    end
    object EdHPo: TEdit
      Left = 100
      Top = 47
      Width = 141
      Height = 21
      TabOrder = 5
    end
    object CboEnviados: TComboBox
      Left = 100
      Top = 76
      Width = 102
      Height = 21
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 6
      Text = 'N'#227'o'
      Items.Strings = (
        'Sim'
        'N'#227'o')
    end
    object Panel1: TPanel
      Left = 14
      Top = 75
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'J'#225' Enviados'
      TabOrder = 7
    end
  end
end
