object FrmCadAssinantes: TFrmCadAssinantes
  Left = 224
  Top = 250
  ActiveControl = ScrollBox1
  BorderIcons = []
  Caption = 'Cadastro de  Assinantes'
  ClientHeight = 146
  ClientWidth = 311
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
    Width = 311
    Height = 146
    HorzScrollBar.Range = 285
    VertScrollBar.Range = 132
    Align = alClient
    AutoScroll = False
    TabOrder = 0
    ExplicitHeight = 139
    object Panel5: TPanel
      Left = 12
      Top = 16
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Codigo HPO'
      TabOrder = 5
    end
    object EdCod: TEdit
      Left = 101
      Top = 17
      Width = 183
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 6
      TabOrder = 0
    end
    object Btn_Salvar: TBitBtn
      Left = 11
      Top = 88
      Width = 75
      Height = 25
      Caption = '&Salvar'
      TabOrder = 2
      OnClick = Btn_SalvarClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000BFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF00000000000000000000000000000000
        0000000000000000000000000000000000000000000000BFBFBFBFBFBF000000
        007F7F007F7F000000000000000000000000000000000000BFBFBFBFBFBF0000
        00007F7F000000BFBFBFBFBFBF000000007F7F007F7F00000000000000000000
        0000000000000000BFBFBFBFBFBF000000007F7F000000BFBFBFBFBFBF000000
        007F7F007F7F000000000000000000000000000000000000BFBFBFBFBFBF0000
        00007F7F000000BFBFBFBFBFBF000000007F7F007F7F00000000000000000000
        0000000000000000000000000000000000007F7F000000BFBFBFBFBFBF000000
        007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
        7F007F7F000000BFBFBFBFBFBF000000007F7F007F7F00000000000000000000
        0000000000000000000000000000007F7F007F7F000000BFBFBFBFBFBF000000
        007F7F000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000
        00007F7F000000BFBFBFBFBFBF000000007F7F000000BFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBF000000007F7F000000BFBFBFBFBFBF000000
        007F7F000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000
        00007F7F000000BFBFBFBFBFBF000000007F7F000000BFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBF000000007F7F000000BFBFBFBFBFBF000000
        007F7F000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF0000
        00000000000000BFBFBFBFBFBF000000007F7F000000BFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBF000000BFBFBF000000BFBFBFBFBFBF000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF}
    end
    object BtnAlterar: TBitBtn
      Left = 110
      Top = 88
      Width = 75
      Height = 25
      Caption = '&Extornar'
      TabOrder = 3
      OnClick = BtnAlterarClick
      Glyph.Data = {
        FE050000424DFE05000000000000360400002800000018000000130000000100
        080000000000C8010000C40E0000C40E00000001000000000000000000004000
        00006000000080000000A0000000C0000000E0000000FF000000008000004080
        00006080000080800000A0800000C0800000E0800000FF80000000C0000040C0
        000060C0000080C00000A0C00000C0C00000E0C00000FFC0000000FF000040FF
        000060FF000080FF0000A0FF0000C0FF0000E0FF0000FFFF0000000040004000
        40006000400080004000A0004000C0004000E0004000FF004000008040004080
        40006080400080804000A0804000C0804000E0804000FF80400000C0400040C0
        400060C0400080C04000A0C04000C0C04000E0C04000FFC0400000FF400040FF
        400060FF400080FF4000A0FF4000C0FF4000E0FF4000FFFF4000000060004000
        60006000600080006000A0006000C0006000E0006000FF006000008060004080
        60006080600080806000A0806000C0806000E0806000FF80600000C0600040C0
        600060C0600080C06000A0C06000C0C06000E0C06000FFC0600000FF600040FF
        600060FF600080FF6000A0FF6000C0FF6000E0FF6000FFFF6000000080004000
        80006000800080008000A0008000C0008000E0008000FF008000008080004080
        80006080800080808000A0808000C0808000E0808000FF80800000C0800040C0
        800060C0800080C08000A0C08000C0C08000E0C08000FFC0800000FF800040FF
        800060FF800080FF8000A0FF8000C0FF8000E0FF8000FFFF80000000A0004000
        A0006000A0008000A000A000A000C000A000E000A000FF00A0000080A0004080
        A0006080A0008080A000A080A000C080A000E080A000FF80A00000C0A00040C0
        A00060C0A00080C0A000A0C0A000C0C0A000E0C0A000FFC0A00000FFA00040FF
        A00060FFA00080FFA000A0FFA000C0FFA000E0FFA000FFFFA0000000C0004000
        C0006000C0008000C000A000C000C000C000E000C000FF00C0000080C0004080
        C0006080C0008080C000A080C000C080C000E080C000FF80C00000C0C00040C0
        C00060C0C00080C0C000A0C0C000C0C0C000E0C0C000FFC0C00000FFC00040FF
        C00060FFC00080FFC000A0FFC000C0FFC000E0FFC000FFFFC0000000E0004000
        E0006000E0008000E000A000E000C000E000E000E000FF00E0000080E0004080
        E0006080E0008080E000A080E000C080E000E080E000FF80E00000C0E00040C0
        E00060C0E00080C0E000A0C0E000C0C0E000E0C0E000FFC0E00000FFE00040FF
        E00060FFE00080FFE000A0FFE000C0FFE000E0FFE000FFFFE0000000FF004000
        FF006000FF008000FF00A000FF00C000FF00E000FF00FF00FF000080FF004080
        FF006080FF008080FF00A080FF00C080FF00E080FF00FF80FF0000C0FF0040C0
        FF0060C0FF0080C0FF00A0C0FF00C0C0FF00E0C0FF00FFC0FF0000FFFF0040FF
        FF0060FFFF0080FFFF00A0FFFF00C0FFFF00E0FFFF00FFFFFF00B5B5B5B5B5B5
        B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5
        B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5
        B5B5B50000000000000000000000000000B5B5B5B5B5B5B5B5B5B500F8F8F8F8
        F8F8F8F8F8F8F8F800B5B5B5B5B5B5B5B5B5B500F8F8F8F8F8F8F8F8F8F8F8F8
        00B5B5B5B5B5B5B5B5B5B500F807070707070707070707F800B5B5B5B5B5B504
        0404B500F8F8F8F8F8F8F8F8F8F8F8F800000000000000000707B500F8070707
        070794949494949094909094949490940007B500F8F8F8F81F00000000000094
        90949094909494940007B500F8070707F8001F0400DE00949490949094949094
        0007B5B500F8F8F80000901F0400009490949094909494000004B5B5B5000000
        B500DEDE1F04049494949490940000B5B5B5B5B5B5B5B5B5B5000090901F0400
        9490909400B5B5B5B5B5B5B5B5B5B5B5B5B5B500DE901F0400949400B5B5B5B5
        B5B5B5B5B5B5B5B5B5B5B5B500DE901F040400B5B5B5B5B5B5B5B5B5B5B5B5B5
        B5B5B5B5B50000001F0404B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5
        B51F04B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5
        B5B5}
    end
    object BtnFechar: TBitBtn
      Left = 210
      Top = 88
      Width = 75
      Height = 25
      Caption = '&Fechar'
      TabOrder = 4
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
    object StatusBar1: TStatusBar
      Left = 0
      Top = 116
      Width = 307
      Height = 19
      Panels = <>
    end
    object Panel1: TPanel
      Left = 12
      Top = 48
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Data de Ass.'
      TabOrder = 7
    end
    object MkEdDtAssinatura: TMaskEdit
      Left = 101
      Top = 49
      Width = 101
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
    end
  end
end
