object FrmPesqImp: TFrmPesqImp
  Left = 183
  Top = 194
  ActiveControl = ScrollBox1
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Impress'#227'o de Relat'#243'rios'
  ClientHeight = 243
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poDesktopCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 425
    Height = 243
    HorzScrollBar.Range = 403
    VertScrollBar.Range = 181
    Align = alClient
    AutoScroll = False
    Color = 16704412
    ParentColor = False
    TabOrder = 0
    object Panel5: TPanel
      Left = 11
      Top = 32
      Width = 90
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Data Inicial'
      TabOrder = 7
    end
    object Panel9: TPanel
      Left = 207
      Top = 32
      Width = 90
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Data Final'
      TabOrder = 8
    end
    object BtnFechar: TBitBtn
      Left = 215
      Top = 178
      Width = 115
      Height = 35
      Caption = '&Sair'
      TabOrder = 6
      OnClick = BtnFecharClick
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
    object Btn_Salvar: TBitBtn
      Left = 82
      Top = 178
      Width = 115
      Height = 35
      Caption = '&Imprimir'
      TabOrder = 5
      OnClick = Btn_SalvarClick
      Glyph.Data = {
        E6080000424DE6080000000000003604000028000000250000001E0000000100
        080000000000B0040000120B0000120B000000010000780000004C4B4B00D5DC
        D800B7BAB800B29A8E0085898700CCCCCC00FFE2C00078767600EFEEEE00E2CE
        B900A7B1AC00DAD1D300E2E4E600CCC0B600E6DDD7006C6A6A00939F9800B0A9
        A000DBB5A100DCBAAD00FAF7F700FFDEBD00C1C4C200A2A3A0005F5D5D008583
        8300D5D2D4009D908100BAB6B700FED6B500FFECD600ECE2E400EEE5E800FEE9
        D300A9B0B000CFC4C500C3BCB900FFF5E700ECC7B800F5D0BB00AEA39F00E4DF
        E30098A29B00595E5900A19C9D00D7DFDE00D5CFCD00B6B5B500DDD9DB008B92
        8D0075737300EFCEBA0094959500BAADA600C6B6AB00C2B3B500FCFCF6007C7C
        7A00D2C3B500BEBDBD00FAE6D100AEB0B200CABDC000FEF1E300666666009999
        99008C8B8B00EDDCC80089848600B5A2A400E5DEDF00E9EAEB00DFDEDE00DED6
        D7009FA2A500CFD2D000ACACAE00C5C3C40054515200AB989500F6EAE100C7BB
        BD00F0D3C800C5B5BD00A4ADA700FED9BD00FDF7EE00B0B3B100FCF9F900FFFF
        FF00DCC5C000E6E5E500D5D5D600B5B5BD00E3D6D800A5A4A400D1C7CA007E82
        7F00737B7500E5D8DB0064696500DEDED600FFE5C600FAD4BB00D0C4BD00B6BA
        BA00CDC2B8008E919200FEEFE100AAA4A500D1B7AF00878D890096999B00E0C5
        AE009F9389009BA39E00CEB5B500FFE7CB00ADADA50000000000000000000000
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
        00000000000000000000000000000000000000000000000000005B4646464646
        4646464646464646464646464646464646464646464646464646464646465B00
        00005B4646464646464646464646464646464646464646464646464646464646
        4646464646465B0000005B464646464646464646464646464646292929292929
        29292929464646464646464646465B0000001F46464646464646464646464646
        46202020202020202020205B464646464646464646465B0000001F4646464646
        4646464646465B475B056D2C1C1A491C414C2E5B474729464646464646461F00
        00001F4646464646464646465B5B5B052C6140004E321919393207341C5C5B5B
        4646464646461F0000001F46464646464646465B5B232C19425757420F184044
        2F2F41070F616D054646464646461F0000001F464646464646465B2E2C44343B
        5B14303B4C611840196D3B4D2F413244055B464646461F0000005B4646464646
        46462E6D1705085958481C5F4C17443907074217020261074D20464646461F00
        00005B464646464646463B1C085914301654421942415F4C4C5F730461343239
        0520464646465B0000005B464646464646463B3B485C2F5F4C02572C6B6F6F6B
        704A22222A3164390520464646465B0000005B464646464646462F3454570223
        1A30481A4D3B3D5F416B6B1031622B39055B464646465B0000005B4646464646
        46464C41053030303048305C5C5C5C05054D2F54736F18392E1F464646465B00
        00005B464646464646461C1C5B5B491A1A1A3047470C30301A2E2E2E01020734
        305B464646465B0000005B464646464646461A02023B4D4D2F3D4D30480C0C0C
        0C48484B165F41055B5B464646465B0000005B46464646464646461A1C76021A
        4D4C176D57693B164B2D01021717055B5B46464646465B0000005B4646464646
        4646465B463B240E0E680D0D0D0D0D4D57733D2F3B495B5B4848464646465B00
        00005B4646464646464646465B497413262627272727525A45456030295B5B48
        4646464646465B0000005B46464646464646464646466E1267551D1D1D553303
        4F5E2020294646464646464646465B0000005B464646464646464646465E3671
        666606060675091B115B5B46464646464646464646465B0000005B4646464648
        484848481F2336431E1E1E3C1E1E3A72681F2946464646464646464646465B00
        00005B46464646464646461F6337683F256C6C6C255035285E1F464646464646
        4646464646465B0000005B4646464646464646463E5120385656565656497623
        5B292946464646464646464646465B0000005B46464646464646463051235B46
        304646463023234646464646464646464646464646465B0000005B4646464646
        464646465E0B0B0B0B0B0B0B2E49292929294646464646464646464646465B00
        00005B4646464646464646464646464646464646464646464646464646464646
        4646464646465B0000005B464646464646464646464646464646464646464646
        46464646464646464646464646465B0000005B46464646464646464646464646
        464646464646464646464646464646464646464646465B0000005B4646464646
        4646464646464646464648484848484848484646464646464646464646465B00
        00005B4646464646464646464646464646292929292948484848464646464646
        4646464646465B000000}
    end
    object MkEdDtIni: TMaskEdit
      Left = 103
      Top = 33
      Width = 99
      Height = 21
      BiDiMode = bdLeftToRight
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 0
      Text = '  /  /    '
    end
    object MkEdDtFin: TMaskEdit
      Left = 300
      Top = 33
      Width = 99
      Height = 21
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
    end
    object ChePlanilia: TCheckBox
      Left = 152
      Top = 119
      Width = 125
      Height = 19
      BiDiMode = bdLeftToRight
      Caption = 'Gerar Planilha Excel'
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 4
      Visible = False
    end
    object Panel1: TPanel
      Left = 10
      Top = 62
      Width = 91
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Ag Ini'
      TabOrder = 9
    end
    object Panel2: TPanel
      Left = 207
      Top = 62
      Width = 90
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Ag Fin'
      TabOrder = 10
    end
    object EdAgIni: TEdit
      Left = 103
      Top = 63
      Width = 99
      Height = 21
      BiDiMode = bdRightToLeft
      Enabled = False
      MaxLength = 5
      ParentBiDiMode = False
      TabOrder = 2
      Text = '0'
    end
    object EdAgFin: TEdit
      Left = 300
      Top = 63
      Width = 99
      Height = 21
      BiDiMode = bdRightToLeft
      Enabled = False
      MaxLength = 5
      ParentBiDiMode = False
      TabOrder = 3
      Text = '999999'
    end
    object MkEdDtTIni: TMaskEdit
      Left = 103
      Top = 94
      Width = 99
      Height = 21
      CharCase = ecUpperCase
      Enabled = False
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 11
      Text = '  /  /    '
      Visible = False
    end
    object MkEdDtTFin: TMaskEdit
      Left = 300
      Top = 94
      Width = 99
      Height = 21
      CharCase = ecUpperCase
      Enabled = False
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 12
      Text = '  /  /    '
      Visible = False
    end
    object Panel3: TPanel
      Left = 10
      Top = 92
      Width = 91
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Transmitido'
      Enabled = False
      TabOrder = 13
      Visible = False
    end
    object Panel4: TPanel
      Left = 207
      Top = 92
      Width = 90
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Transmitido'
      Enabled = False
      TabOrder = 14
      Visible = False
    end
    object RdGrpTipo: TComboBox
      Left = 103
      Top = 140
      Width = 99
      Height = 21
      CharCase = ecUpperCase
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 15
      Text = '0 - PF'
      Items.Strings = (
        '0 - PF'
        '1 - PJ'
        '2 - TODOS')
    end
    object Panel6: TPanel
      Left = 11
      Top = 140
      Width = 90
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Op'#231#227'o'
      Enabled = False
      TabOrder = 16
      Visible = False
    end
    object Panel7: TPanel
      Left = 207
      Top = 140
      Width = 90
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'N'#186' Lote'
      TabOrder = 17
    end
    object EdNumlote: TEdit
      Left = 300
      Top = 140
      Width = 99
      Height = 21
      BiDiMode = bdRightToLeft
      Enabled = False
      MaxLength = 5
      ParentBiDiMode = False
      TabOrder = 18
      Text = '0'
    end
  end
end
