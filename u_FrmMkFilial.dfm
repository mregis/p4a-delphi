object frmMkcadfilial: TfrmMkcadfilial
  Left = 231
  Top = 110
  ActiveControl = ScrollBoxmk
  BorderIcons = []
  Caption = 'Cadastro de Filial'
  ClientHeight = 317
  ClientWidth = 465
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
  object ScrollBoxmk: TScrollBox
    Left = 0
    Top = 0
    Width = 465
    Height = 317
    HorzScrollBar.Range = 446
    VertScrollBar.Range = 299
    Align = alClient
    AutoScroll = False
    TabOrder = 0
    TabStop = True
    ExplicitHeight = 310
    object Panel5mk: TPanel
      Left = 15
      Top = 27
      Width = 60
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'C'#243'digo'
      TabOrder = 7
    end
    object edcodigo: TEdit
      Left = 85
      Top = 28
      Width = 62
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 0
      OnKeyUp = edcodigoKeyUp
      OnMouseUp = edcodigoMouseUp
    end
    object Panel7mk: TPanel
      Left = 159
      Top = 27
      Width = 100
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Filial'
      TabOrder = 9
    end
    object edFilial: TEdit
      Left = 267
      Top = 28
      Width = 175
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 30
      TabOrder = 1
    end
    object Btn_Salvarmk: TBitBtn
      Left = 106
      Top = 66
      Width = 75
      Height = 25
      Caption = '&Incluir'
      TabOrder = 3
      OnClick = Btn_SalvarmkClick
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
    object BtnAlterarmk: TBitBtn
      Left = 194
      Top = 66
      Width = 75
      Height = 25
      Caption = '&Alterar'
      TabOrder = 4
      OnClick = BtnAlterarmkClick
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
    object BtnDeletarmk: TBitBtn
      Left = 282
      Top = 66
      Width = 75
      Height = 25
      Caption = '&Deletar'
      TabOrder = 5
      OnClick = BtnDeletarmkClick
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F0000000120B0000120B00001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888888800008888888888888888889800008898888888888888898800008899
        88777777777798880000889990000000000998880000888990BFFFBFFF998888
        0000888899FCCCCCCF97888800008888999FBFFFB9978888000088888999CCC9
        990788880000888880999FB99F0788880000888880FC9999CF07888800008888
        80FF9999BF0788880000888880FC9999000788880000888880B99F099F078888
        0000888880999F099998888800008888999FBF0F089988880000889999000000
        8889988800008899988888888888898800008888888888888888889800008888
        88888888888888880000}
    end
    object BtnFecharmk: TBitBtn
      Left = 369
      Top = 66
      Width = 75
      Height = 25
      Caption = '&Fechar'
      TabOrder = 6
      OnClick = BtnFecharmkClick
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
    object DBGridfili: TDBGrid
      Left = 15
      Top = 98
      Width = 431
      Height = 201
      Ctl3D = False
      DataSource = Dm.dtsCga107
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ParentCtl3D = False
      TabOrder = 8
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnKeyUp = DBGridfiliKeyUp
      OnMouseUp = DBGridfiliMouseUp
      Columns = <
        item
          Expanded = False
          FieldName = 'codfilial'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nomefilial'
          Title.Caption = 'Filial'
          Visible = True
        end>
    end
    object Btlimpa: TBitBtn
      Left = 14
      Top = 66
      Width = 82
      Height = 25
      Caption = '&Limpar'
      TabOrder = 2
      OnClick = BtlimpaClick
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
  end
end
