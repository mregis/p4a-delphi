object FrmRemessaSedex: TFrmRemessaSedex
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Remessa de Sedex'
  ClientHeight = 657
  ClientWidth = 681
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label14: TLabel
    Left = 12
    Top = 17
    Width = 61
    Height = 16
    Alignment = taRightJustify
    Caption = 'N'#186' Objeto:'
    FocusControl = EdObjeto
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label38: TLabel
    Left = 368
    Top = 17
    Width = 49
    Height = 16
    Alignment = taRightJustify
    Caption = 'Produto:'
    FocusControl = CboProdutoServSedex
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 236
    Top = 17
    Width = 48
    Height = 16
    Alignment = taRightJustify
    Caption = 'Jun'#231#227'o: '
    FocusControl = EdJuncao
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 50
    Top = 526
    Width = 535
    Height = 34
  end
  object DBGrid001: TDBGrid
    Left = 0
    Top = 448
    Width = 681
    Height = 190
    Align = alBottom
    Ctl3D = False
    DataSource = Dm.DtSSdx4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnCellClick = DBGrid001CellClick
    OnDblClick = DBGrid001DblClick
    OnDragDrop = DBGrid001DragDrop
    OnKeyDown = DBGrid001KeyDown
    OnKeyPress = DBGrid001KeyPress
    OnKeyUp = DBGrid001KeyUp
    Columns = <
      item
        Expanded = False
        FieldName = 'sdx_numobj2'
        Title.Caption = 'N'#186' Objeto'
        Title.Color = 16764262
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sdx_nomdest'
        Title.Caption = 'Destino'
        Title.Color = 16764262
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 263
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tbsdxserv_dsc'
        Title.Caption = 'Produto'
        Title.Color = 16764262
        Width = 166
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sdx_dtmov'
        Title.Caption = 'Dt Mov'
        Title.Color = 16764262
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'bxasdx_dscbxa'
        Title.Caption = 'Estado'
        Title.Color = 16764262
        Visible = True
      end>
  end
  object BtnLimpa: TBitBtn
    Left = 124
    Top = 415
    Width = 75
    Height = 32
    Caption = '&Nova Seq.'
    Enabled = False
    TabOrder = 4
    OnClick = BtnLimpaClick
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
  object BtnSalva: TBitBtn
    Left = 205
    Top = 415
    Width = 75
    Height = 32
    Caption = '&Salvar'
    Enabled = False
    TabOrder = 2
    OnClick = BtnSalvaClick
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
  object BtnReenv: TBitBtn
    Left = 286
    Top = 415
    Width = 75
    Height = 32
    Caption = '&Reenvio'
    Enabled = False
    TabOrder = 5
    OnClick = BtnReenvClick
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
  object BtnSair: TBitBtn
    Left = 448
    Top = 415
    Width = 75
    Height = 32
    Caption = 'Sai&r'
    TabOrder = 7
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
  object EdJuncao: TEdit
    Left = 285
    Top = 12
    Width = 57
    Height = 26
    CharCase = ecUpperCase
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    MaxLength = 4
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    OnKeyPress = EdJuncaoKeyPress
  end
  object EdObjeto: TEdit
    Left = 75
    Top = 12
    Width = 120
    Height = 26
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 13
    ParentFont = False
    TabOrder = 0
    OnKeyPress = EdObjetoKeyPress
  end
  object BtnAltera: TBitBtn
    Left = 367
    Top = 415
    Width = 75
    Height = 32
    Caption = '&Alterar'
    Enabled = False
    TabOrder = 6
    OnClick = BtnAlteraClick
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
  object StsRemSdx: TStatusBar
    Left = 0
    Top = 638
    Width = 681
    Height = 19
    Color = 16776697
    Panels = <
      item
        Text = 'Ads - Address SA'
        Width = 230
      end
      item
        Width = 100
      end>
  end
  object CboProdutoServSedex: TDBLookupComboBox
    Left = 419
    Top = 12
    Width = 256
    Height = 26
    Hint = 'Produto atribu'#237'do ao Cart'#227'o de Postagem'
    DropDownRows = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    KeyField = 'tbsdxserv_prod'
    ListField = 'tbsdxserv_dsc'
    ListSource = Dm.DtSSdxServ
    ParentFont = False
    TabOrder = 9
  end
  object GroupBox1: TGroupBox
    Left = 1
    Top = 39
    Width = 679
    Height = 98
    Align = alCustom
    Caption = 'Destino'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    object Label5: TLabel
      Left = 16
      Top = 45
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Endere'#231'o:'
      Color = clBtnFace
      FocusControl = EdEnd
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 404
      Top = 45
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Bairro:'
      Color = clBtnFace
      FocusControl = EdBairro
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 25
      Top = 17
      Width = 47
      Height = 14
      Caption = 'Ag'#234'ncia:'
      FocusControl = EdDpto
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 32
      Top = 73
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
      FocusControl = EdCid
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 420
      Top = 73
      Width = 18
      Height = 14
      Alignment = taRightJustify
      Caption = 'UF:'
      FocusControl = EdUF
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 550
      Top = 17
      Width = 29
      Height = 14
      Alignment = taRightJustify
      Caption = 'CEP: '
      FocusControl = MkEdCep
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object EdEnd: TEdit
      Left = 74
      Top = 40
      Width = 303
      Height = 24
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      OnKeyPress = EdJuncaoKeyPress
    end
    object EdBairro: TEdit
      Left = 439
      Top = 40
      Width = 235
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      OnKeyPress = EdJuncaoKeyPress
    end
    object EdDpto: TEdit
      Left = 74
      Top = 12
      Width = 419
      Height = 24
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      OnKeyPress = EdJuncaoKeyPress
    end
    object EdCid: TEdit
      Left = 74
      Top = 68
      Width = 304
      Height = 24
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      OnKeyPress = EdJuncaoKeyPress
    end
    object EdUF: TEdit
      Left = 439
      Top = 68
      Width = 27
      Height = 24
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      OnKeyPress = EdJuncaoKeyPress
    end
    object MkEdCep: TMaskEdit
      Left = 581
      Top = 13
      Width = 93
      Height = 24
      BiDiMode = bdLeftToRight
      Enabled = False
      EditMask = '00000\-000;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      MaxLength = 9
      ParentBiDiMode = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
  end
  object GroupBox2: TGroupBox
    Left = 1
    Top = 138
    Width = 679
    Height = 46
    Caption = 'Informa'#231#245'es do Volume'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    object Label33: TLabel
      Left = 12
      Top = 19
      Width = 60
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'd. Caixa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label35: TLabel
      Left = 330
      Top = 20
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Largura:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label36: TLabel
      Left = 450
      Top = 21
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Comp:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label37: TLabel
      Left = 568
      Top = 19
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Altura:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 116
      Top = 18
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Volume:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 201
      Top = 20
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Ednrocxa: TEdit
      Left = 74
      Top = 17
      Width = 27
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnKeyPress = EdnrocxaKeyPress
    end
    object Edbas: TEdit
      Left = 377
      Top = 16
      Width = 61
      Height = 24
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 1
      OnEnter = EdbasEnter
      OnKeyPress = EdbasKeyPress
    end
    object Edcpm: TEdit
      Left = 488
      Top = 17
      Width = 67
      Height = 24
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 2
      OnKeyPress = EdcpmKeyPress
    end
    object Edalt: TEdit
      Left = 607
      Top = 16
      Width = 67
      Height = 24
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 3
      OnKeyPress = EdaltKeyPress
    end
    object EdVol: TEdit
      Left = 163
      Top = 18
      Width = 27
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnEnter = EdVolEnter
    end
    object EdPeso: TEdit
      Left = 234
      Top = 16
      Width = 85
      Height = 24
      BiDiMode = bdRightToLeft
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 5
      OnEnter = EdPesoEnter
      OnKeyPress = EdPesoKeyPress
    end
  end
  object GroupBox3: TGroupBox
    Left = 1
    Top = 185
    Width = 679
    Height = 127
    Caption = 'Informa'#231#245'es do Envio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    object Label15: TLabel
      Left = 14
      Top = 47
      Width = 88
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Declarado:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 53
      Top = 20
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor R$:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 398
      Top = 20
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total R$:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 227
      Top = 20
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor AR:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label17: TLabel
      Left = 567
      Top = 47
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Porc.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label19: TLabel
      Left = 391
      Top = 47
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Min.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 206
      Top = 47
      Width = 71
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ad Valorem.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label28: TLabel
      Left = 38
      Top = 75
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qtde Itens:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 230
      Top = 75
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#186' Lote:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 438
      Top = 75
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#186' Reg.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label32: TLabel
      Left = 539
      Top = 106
      Width = 60
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Baixa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label30: TLabel
      Left = 371
      Top = 106
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Envio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label31: TLabel
      Left = 205
      Top = 102
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Carga:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label29: TLabel
      Left = 9
      Top = 102
      Width = 93
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Movimento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Edvaldec: TEdit
      Left = 106
      Top = 42
      Width = 89
      Height = 24
      BiDiMode = bdRightToLeft
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object EdValor: TEdit
      Left = 106
      Top = 15
      Width = 89
      Height = 24
      BiDiMode = bdRightToLeft
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 1
    end
    object EdVvalor: TEdit
      Left = 450
      Top = 15
      Width = 89
      Height = 24
      BiDiMode = bdRightToLeft
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 2
    end
    object EdValAr: TEdit
      Left = 280
      Top = 15
      Width = 89
      Height = 24
      BiDiMode = bdRightToLeft
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object EdPorc: TEdit
      Left = 601
      Top = 40
      Width = 73
      Height = 24
      BiDiMode = bdRightToLeft
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 4
    end
    object EdValMin: TEdit
      Left = 450
      Top = 42
      Width = 89
      Height = 24
      BiDiMode = bdRightToLeft
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 5
    end
    object EdAdVal: TEdit
      Left = 280
      Top = 42
      Width = 89
      Height = 24
      BiDiMode = bdRightToLeft
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 6
    end
    object EdQtde: TEdit
      Left = 106
      Top = 70
      Width = 55
      Height = 24
      BiDiMode = bdRightToLeft
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 7
    end
    object EdSeqCarga: TEdit
      Left = 280
      Top = 70
      Width = 113
      Height = 24
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 8
      OnKeyPress = EdJuncaoKeyPress
    end
    object EdReg: TEdit
      Left = 489
      Top = 70
      Width = 185
      Height = 24
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 9
    end
    object MkEdBaixa: TMaskEdit
      Left = 601
      Top = 101
      Width = 73
      Height = 24
      CharCase = ecUpperCase
      Enabled = False
      EditMask = '!99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 10
      Text = '  /  /    '
    end
    object MkEdDtEnvio: TMaskEdit
      Left = 435
      Top = 98
      Width = 75
      Height = 24
      Enabled = False
      EditMask = '!99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 11
      Text = '  /  /    '
    end
    object MkEdCarga: TMaskEdit
      Left = 270
      Top = 97
      Width = 77
      Height = 24
      Enabled = False
      EditMask = '!99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 12
      Text = '  /  /    '
    end
    object MkEdDtMov: TMaskEdit
      Left = 106
      Top = 96
      Width = 79
      Height = 24
      Enabled = False
      EditMask = '!99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 13
      Text = '  /  /    '
    end
  end
  object GroupBox4: TGroupBox
    Left = 1
    Top = 312
    Width = 679
    Height = 101
    Caption = 'Informa'#231#245'es para Reenvio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    object Label20: TLabel
      Left = 311
      Top = 22
      Width = 64
      Height = 14
      Caption = 'N'#186' Objeto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label21: TLabel
      Left = 521
      Top = 22
      Width = 50
      Height = 14
      Caption = 'N'#186' Lote:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label22: TLabel
      Left = 521
      Top = 49
      Width = 50
      Height = 14
      Caption = 'N'#186' Reg.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label23: TLabel
      Left = 6
      Top = 73
      Width = 60
      Height = 14
      Caption = 'Endere'#231'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label24: TLabel
      Left = 14
      Top = 49
      Width = 52
      Height = 14
      Caption = 'Ag'#234'ncia:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label25: TLabel
      Left = 368
      Top = 76
      Width = 45
      Height = 14
      Caption = 'Cidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label26: TLabel
      Left = 456
      Top = 49
      Width = 22
      Height = 14
      Caption = 'UF: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label27: TLabel
      Left = 330
      Top = 49
      Width = 27
      Height = 14
      Caption = 'CEP:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label34: TLabel
      Left = 19
      Top = 22
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EdNovoAr: TEdit
      Left = 378
      Top = 18
      Width = 120
      Height = 22
      BiDiMode = bdRightToLeft
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object EdNovoLote: TEdit
      Left = 574
      Top = 18
      Width = 102
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      OnKeyPress = EdJuncaoKeyPress
    end
    object EdNovReg: TEdit
      Left = 574
      Top = 45
      Width = 102
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object EdNovoEnd: TEdit
      Left = 68
      Top = 70
      Width = 287
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnKeyPress = EdJuncaoKeyPress
    end
    object EdNovaAg: TEdit
      Left = 68
      Top = 45
      Width = 252
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnKeyPress = EdJuncaoKeyPress
    end
    object EdNovaCid: TEdit
      Left = 415
      Top = 73
      Width = 261
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnKeyPress = EdJuncaoKeyPress
    end
    object EdNovaUf: TEdit
      Left = 478
      Top = 45
      Width = 28
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnKeyPress = EdJuncaoKeyPress
    end
    object MkEdNovoCep: TMaskEdit
      Left = 358
      Top = 45
      Width = 90
      Height = 22
      BiDiMode = bdLeftToRight
      CharCase = ecUpperCase
      Enabled = False
      EditMask = '00000\-999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      MaxLength = 9
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 7
    end
    object DBCboBaixa: TDBLookupComboBox
      Left = 68
      Top = 16
      Width = 229
      Height = 26
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      KeyField = 'bxasdx_codbxa'
      ListField = 'bxasdx_dscbxa'
      ListSource = Dm.DtStbbxasdx
      ParentFont = False
      TabOrder = 8
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer1Timer
    Left = 644
    Top = 200
  end
end
