object FrmCadSucursal: TFrmCadSucursal
  Left = 107
  Top = 143
  ActiveControl = ScrollBox1
  BorderIcons = []
  Caption = 'Cadastro de Sucursal'
  ClientHeight = 452
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 592
    Height = 452
    HorzScrollBar.Range = 577
    VertScrollBar.Range = 441
    Align = alClient
    AutoScroll = False
    TabOrder = 0
    object Bevel1: TBevel
      Left = 12
      Top = 197
      Width = 562
      Height = 42
    end
    object BtnIncluir: TBitBtn
      Left = 28
      Top = 206
      Width = 94
      Height = 25
      Caption = '&Limpar'
      TabOrder = 8
      OnClick = BtnIncluirClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        0800000000000001000000000000000000000001000000010000000000009C8B
        7E00FF00FF00B1908E00B09E9000B2A09200B5A19300BAA69700D3C1B100D5C0
        B700DECFCE00FFDEC200FFE1C600FFE3CB00FFE6CF00FFE9D400FFEBD900FFED
        DD00FEEFE200FEF2E600FEF4EB00FAF6F000FEF7F000FEFAF400FEFBFA000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000020203030303
        0303030303030303020202020318181818181818181818030202020203181818
        1818181818181803020202020317171717171717171717030202020203161616
        1616161616161603020202020314141414141414141414030202020203131313
        1313131313131303020202020312121212121212121212030202020203111111
        1111111111111103020202020311101110111008080808030202020203100E10
        0E1010060504040302020202030E0E0E0E0E0E010101010302020202030E0C0E
        0C0E0614140A030202020202030C0C0C0C0C07170803020202020202030B0B0B
        0B0B060803020202020202020303030303030303020202020202}
    end
    object BtnSalvar: TBitBtn
      Left = 139
      Top = 206
      Width = 94
      Height = 25
      Caption = '&Salvar'
      TabOrder = 6
      OnClick = BtnSalvarClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF7F2B287F2B28A18283A18283A18283A1
        8283A18283A18283A182837A1C1C7F2B28FF00FFFF00FFFF00FFFF00FF7F2B28
        CA4D4DB64545DDD4D5791617791617DCE0E0D7DADECED5D7BDBABD76100F9A2D
        2D7F2B28FF00FFFF00FFFF00FF7F2B28C24A4BB14444E2D9D9791617791617D9
        D8DAD9DEE1D3D9DCC1BDC1761111982D2D7F2B28FF00FFFF00FFFF00FF7F2B28
        C24A4AB04242E6DCDC791617791617D5D3D5D8DEE1D7DDE0C6C2C5700F0F962C
        2C7F2B28FF00FFFF00FFFF00FF7F2B28C24A4AB04141EADEDEE7DDDDDDD4D5D7
        D3D5D5D7D9D7D8DACAC2C57E17179E31317F2B28FF00FFFF00FFFF00FF7F2B28
        BF4748B84545BA4C4CBD5757BB5756B64E4EB44949BD5251BB4B4CB54242BF4A
        4A7F2B28FF00FFFF00FFFF00FF7F2B28A33B39B1605DC68684CB918FCC9190CC
        908FCB8988C98988CB9391CC9696BD4B4C7F2B28FF00FFFF00FFFF00FF7F2B28
        BD4B4CF7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7BD4B
        4C7F2B28FF00FFFF00FFFF00FF7F2B28BD4B4CF7F7F7F7F7F7F7F7F7F7F7F7F7
        F7F7F7F7F7F7F7F7F7F7F7F7F7F7BD4B4C7F2B28FF00FFFF00FFFF00FF7F2B28
        BD4B4CF7F7F7BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFF7F7F7BD4B
        4C7F2B28FF00FFFF00FFFF00FF7F2B28BD4B4CF7F7F7F7F7F7F7F7F7F7F7F7F7
        F7F7F7F7F7F7F7F7F7F7F7F7F7F7BD4B4C7F2B28FF00FFFF00FFFF00FF7F2B28
        BD4B4CF7F7F7BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFF7F7F7BD4B
        4C7F2B28FF00FFFF00FFFF00FF7F2B28BD4B4CF7F7F7F7F7F7F7F7F7F7F7F7F7
        F7F7F7F7F7F7F7F7F7F7F7F7F7F7BD4B4C7F2B28FF00FFFF00FFFF00FFFF00FF
        7F2B28F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F77F2B
        28FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
    object BtnAlterar: TBitBtn
      Left = 239
      Top = 206
      Width = 94
      Height = 25
      Caption = '&Alterar'
      TabOrder = 7
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
    object BtnDeletar: TBitBtn
      Left = 346
      Top = 206
      Width = 94
      Height = 25
      Caption = '&Deletar'
      Enabled = False
      TabOrder = 17
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
    object BtnSair: TBitBtn
      Left = 455
      Top = 206
      Width = 94
      Height = 25
      Caption = '&Sair'
      TabOrder = 9
      OnClick = BtnSairClick
      Glyph.Data = {
        B60D0000424DB60D000000000000360000002800000030000000180000000100
        180000000000800D0000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFF
        FFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
        FFFFCCFFFFCCFFFFCCFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
        FFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFF
        CCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8C6363424242424242FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFE8E0E0DADADA
        DADADAFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
        FFFFCCFFFFCCFFFFCCFFFF00FFFF00FFFF00FFFF00FFFF00FF8C636342424242
        4242B55A00B55A004242428C63638C63638C63638C63638C63638C63638C6363
        8C63638C6363FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
        FFE8E0E0DADADADADADAF1DECCF1DECCDADADAE8E0E0E8E0E0E8E0E0E8E0E0E8
        E0E0E8E0E0E8E0E0E8E0E0E8E0E0FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
        FF00FF8C6363424242B55A00B55A00A55208B55A00C65A0042424210AD8410AD
        8410AD8410AD8410AD8410AD8410AD8410AD848C6363FF00FFFF00FFFF00FFFF
        00FFFFCCFFFFCCFFFFCCFFE8E0E0DADADAF1DECCF1DECCEDDDCEF1DECCF4DECC
        DADADAD0EFE7D0EFE7D0EFE7D0EFE7D0EFE7D0EFE7D0EFE7D0EFE7E8E0E0FFCC
        FFFFCCFFFFCCFFFFCCFFFF00FFFF00FF8C6363B55A00B55A00B55A00C65A00C6
        5A00C65A00C65A0042424210AD8410AD8410AD8410AD8410AD8418A57B18A57B
        18A57B8C6363FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFE8E0E0F1DECCF1DE
        CCF1DECCF4DECCF4DECCF4DECCF4DECCDADADAD0EFE7D0EFE7D0EFE7D0EFE7D0
        EFE7D1EDE5D1EDE5D1EDE5E8E0E0FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
        8C6363C65A00C65A00C65A00C65A00C65A00CE6300CE630042424210AD8418A5
        7B18A57B18A57B189C7B189C73219473398C6B8C6363FF00FFFF00FFFF00FFFF
        00FFFFCCFFFFCCFFE8E0E0F4DECCF4DECCF4DECCF4DECCF4DECCF6E0CCF6E0CC
        DADADAD0EFE7D1EDE5D1EDE5D1EDE5D1ECE5D1ECE3D3EAE3D8E8E2E8E0E0FFCC
        FFFFCCFFFFCCFFFFCCFFFF00FFFF00FF8C6363C65A00CE6300CE6300CE6300CE
        6300CE6300CE630042424229846321947321947321947321946B218C6B298C6B
        42846B8C6363FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFE8E0E0F4DECCF6E0
        CCF6E0CCF6E0CCF6E0CCF6E0CCF6E0CCDADADAD5E7E0D3EAE3D3EAE3D3EAE3D3
        EAE2D3E8E2D5E8E2DAE7E2E8E0E0FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
        8C6363CE6300CE6300CE6300CE6B00CE6B00CE6B00CE630042424229735A218C
        6B298C6B298C63298C6B298463298463298C6B8C6363FF00FFFF00FFFF00FFFF
        00FFFFCCFFFFCCFFE8E0E0F6E0CCF6E0CCF6E0CCF6E2CCF6E2CCF6E2CCF6E0CC
        DADADAD5E3DED3E8E2D5E8E2D5E8E0D5E8E2D5E7E0D5E7E0D5E8E2E8E0E0FFCC
        FFFFCCFFFFCCFFFFCCFFFF00FFFF00FF8C6363CE6300CE6B00CE6B00CE6B00CE
        6B00CE6B00D67300424242298C6B29846329845A317B5A317B52317B5A39845A
        427B638C6363FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFE8E0E0F6E0CCF6E2
        CCF6E2CCF6E2CCF6E2CCF6E2CCF7E3CCDADADAD5E8E2D5E7E0D5E7DED6E5DED6
        E5DDD6E5DED8E7DEDAE5E0E8E0E0FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
        8C6363CE6B00CE6B00CE6B00D67300D67300FFBD6BD67300424242316B4A397B
        52397B5231734A397B524A7B5A5A6B525A6B528C6363FF00FFFF00FFFF00FFFF
        00FFFFCCFFFFCCFFE8E0E0F6E2CCF6E2CCF6E2CCF7E3CCF7E3CCFFF2E2F7E3CC
        DADADAD6E2DBD8E5DDD8E5DDD6E3DBD8E5DDDBE5DEDEE2DDDEE2DDE8E0E0FFCC
        FFFFCCFFFFCCFFFFCCFFFF00FFFF00FF8C6363D67300D67300D67300D67300FF
        D6A5FFE7C6FFBD6B4242425A6B525A6B5231734A637B52637B5294946BB59C73
        F7B5848C6363FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFE8E0E0F7E3CCF7E3
        CCF7E3CCF7E3CCFFF7EDFFFBF4FFF2E2DADADADEE2DDDEE2DDD6E3DBE0E5DDE0
        E5DDEAEAE2F1ECE3FEF1E7E8E0E0FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
        8C6363D67300D67300D67300D67300D67300FFD6A5D67300424242F7B584F7B5
        84F7B584F7B584F7B584F7B584F7B584F7B5848C6363FF00FFFF00FFFF00FFFF
        00FFFFCCFFFFCCFFE8E0E0F7E3CCF7E3CCF7E3CCF7E3CCF7E3CCFFF7EDF7E3CC
        DADADAFEF1E7FEF1E7FEF1E7FEF1E7FEF1E7FEF1E7FEF1E7FEF1E7E8E0E0FFCC
        FFFFCCFFFFCCFFFFCCFFFF00FFFF00FF8C6363D67300D67300DE7B00DE7B00DE
        7B00DE7B00DE7B00424242F7B584F7B584F7B584F7B584F7B584F7B584F7B584
        F7B5848C6363FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFE8E0E0F7E3CCF7E3
        CCF9E5CCF9E5CCF9E5CCF9E5CCF9E5CCDADADAFEF1E7FEF1E7FEF1E7FEF1E7FE
        F1E7FEF1E7FEF1E7FEF1E7E8E0E0FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
        8C6363DE7B00DE7B00DE7B00DE7B00DE7B00DE7B00DE7B00424242F7B584F7B5
        84FFE7DEFFE7DEFFE7DEFFDECEF7B584F7B5848C6363FF00FFFF00FFFF00FFFF
        00FFFFCCFFFFCCFFE8E0E0F9E5CCF9E5CCF9E5CCF9E5CCF9E5CCF9E5CCF9E5CC
        DADADAFEF1E7FEF1E7FFFBF9FFFBF9FFFBF9FFF9F6FEF1E7FEF1E7E8E0E0FFCC
        FFFFCCFFFFCCFFFFCCFFFF00FFFF00FF8C6363DE7B00E77B00E77B00DE7B00DE
        7B00EF7B00EF7B00424242EFCEBDFFE7DEFFE7DEFFDECEF7D6CEEFCEBDFFE7DE
        F7B5848C6363FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFE8E0E0F9E5CCFBE5
        CCFBE5CCF9E5CCF9E5CCFCE5CCFCE5CCDADADAFCF6F2FFFBF9FFFBF9FFF9F6FE
        F7F6FCF6F2FFFBF9FEF1E7E8E0E0FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
        8C6363FF8400EF7B00EF7B00EF7B00EF7B00EF7B00EF7B00424242F7B584F7C6
        A5F7CEBDFFE7DEF7D6CEF7CEBDF7C6A5F7B5848C6363FF00FFFF00FFFF00FFFF
        00FFFFCCFFFFCCFFE8E0E0FFE7CCFCE5CCFCE5CCFCE5CCFCE5CCFCE5CCFCE5CC
        DADADAFEF1E7FEF4EDFEF6F2FFFBF9FEF7F6FEF6F2FEF4EDFEF1E7E8E0E0FFCC
        FFFFCCFFFFCCFFFFCCFFFF00FFFF00FF8C6363D67300FF8400FF8400F78400F7
        7B00EF7B00EF7B00424242F7B584F7B584F7B584EFCEBDEFCEBDEFCEBDF7B584
        F7B5848C6363FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFE8E0E0F7E3CCFFE7
        CCFFE7CCFEE7CCFEE5CCFCE5CCFCE5CCDADADAFEF1E7FEF1E7FEF1E7FCF6F2FC
        F6F2FCF6F2FEF1E7FEF1E7E8E0E0FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
        FF00FFAD6B63AD6B63D67300FF8400EF7B00F78400FF8400424242F7B584F7B5
        84F7B584F7B584F7B584F7B584F7B584F7B5848C6363FF00FFFF00FFFF00FFFF
        00FFFFCCFFFFCCFFFFCCFFEFE2E0EFE2E0F7E3CCFFE7CCFCE5CCFEE7CCFFE7CC
        DADADAFEF1E7FEF1E7FEF1E7FEF1E7FEF1E7FEF1E7FEF1E7FEF1E7E8E0E0FFCC
        FFFFCCFFFFCCFFFFCCFFFF00FFFF00FFFF00FFFF00FFFF00FFAD6B63AD6B63D6
        7300FF8400FF8400424242848484848484848484848484848484848484848484
        848484848484FF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
        FFEFE2E0EFE2E0F7E3CCFFE7CCFFE7CCDADADAE7E7E7E7E7E7E7E7E7E7E7E7E7
        E7E7E7E7E7E7E7E7E7E7E7E7E7E7FFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFAD6B63AD6B63AD6B63AD6B63FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFEFE2E0EFE2E0EFE2E0
        EFE2E0FFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
        FFFFCCFFFFCCFFFFCCFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
        FFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFF
        CCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFF
        FFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
        FFFFCCFFFFCCFFFFCCFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFFCCFFFFCCFFFFCCFFFFCCFFFFCC
        FFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFF
        CCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFF}
      NumGlyphs = 2
    end
    object DBGridAg: TDBGrid
      Left = 14
      Top = 246
      Width = 563
      Height = 196
      Ctl3D = False
      DataSource = Dm.DtSTbBradDeptos
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect]
      ParentCtl3D = False
      TabOrder = 10
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = DBGridAgCellClick
      OnKeyDown = DBGridAgKeyDown
      OnKeyPress = DBGridAgKeyPress
      OnKeyUp = DBGridAgKeyUp
      Columns = <
        item
          Expanded = False
          FieldName = 'juncao'
          Title.Caption = 'Jun'#231#227'o'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'depto'
          Title.Caption = 'Ag'#234'ncia'
          Width = 160
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ender'
          Title.Caption = 'Endere'#231'o'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cidade'
          Width = 155
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'uf'
          Visible = True
        end>
    end
    object Panel2: TPanel
      Left = 232
      Top = 15
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Ag'#234'ncia'
      TabOrder = 11
    end
    object Panel3: TPanel
      Left = 13
      Top = 15
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'C'#243'digo'
      TabOrder = 12
    end
    object EdCod: TEdit
      Left = 99
      Top = 18
      Width = 127
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 0
      OnKeyPress = EdCodKeyPress
    end
    object EdAgencia: TEdit
      Left = 316
      Top = 18
      Width = 222
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 1
    end
    object Panel1: TPanel
      Left = 13
      Top = 47
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Endere'#231'o'
      TabOrder = 13
    end
    object EdEnd: TEdit
      Left = 99
      Top = 52
      Width = 439
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 2
    end
    object EdCid: TEdit
      Left = 316
      Top = 80
      Width = 127
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 30
      TabOrder = 4
    end
    object EdUf: TEdit
      Left = 492
      Top = 80
      Width = 46
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 5
    end
    object Panel4: TPanel
      Left = 13
      Top = 79
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Cep'
      TabOrder = 14
    end
    object MkEdCep: TMaskEdit
      Left = 99
      Top = 80
      Width = 125
      Height = 21
      CharCase = ecUpperCase
      EditMask = '00000\-999;0;_'
      MaxLength = 9
      TabOrder = 3
    end
    object Panel5: TPanel
      Left = 232
      Top = 79
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Cidade'
      TabOrder = 15
    end
    object Panel6: TPanel
      Left = 456
      Top = 79
      Width = 32
      Height = 27
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'UF'
      TabOrder = 16
    end
  end
end
