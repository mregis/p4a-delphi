object FrmPrepCarregAut: TFrmPrepCarregAut
  Left = 29
  Top = 17
  ActiveControl = ScrollBox1
  BorderIcons = []
  Caption = 'Prepara Arquivos Para o Carregamento Automatico'
  ClientHeight = 482
  ClientWidth = 721
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 721
    Height = 482
    HorzScrollBar.Range = 715
    VertScrollBar.Range = 459
    Align = alClient
    AutoScroll = False
    TabOrder = 0
    object Bevel1: TBevel
      Left = 8
      Top = 409
      Width = 707
      Height = 50
    end
    object prog: TProgressBar
      Left = 8
      Top = 376
      Width = 705
      Height = 18
      TabOrder = 1
    end
    object BitBtn5: TBitBtn
      Left = 400
      Top = 425
      Width = 113
      Height = 25
      Caption = 'Sair'
      TabOrder = 0
      OnClick = BitBtn5Click
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
    object EdQt: TEdit
      Left = 92
      Top = 340
      Width = 104
      Height = 21
      ReadOnly = True
      TabOrder = 2
      Text = '0'
    end
    object Panel11: TPanel
      Left = 7
      Top = 339
      Width = 82
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Quantidade'
      TabOrder = 3
    end
    object BitBtn3: TBitBtn
      Left = 240
      Top = 425
      Width = 113
      Height = 25
      Caption = 'Criar Arquivos'
      TabOrder = 4
      OnClick = BitBtn3Click
      Glyph.Data = {
        EE000000424DEE000000000000007600000028000000100000000F0000000100
        04000000000078000000120B0000120B00001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        888888800000000000888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFFFF
        F0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFFFF
        F0888880FFFFFFFFF0888880FFFFFF0000888880FFFFFF0F08888880FFFFFF00
        888888800000000888888888888888888888}
    end
    object ListEmail: TListBox
      Left = 8
      Top = 184
      Width = 698
      Height = 145
      ItemHeight = 13
      TabOrder = 5
    end
  end
end
