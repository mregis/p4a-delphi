object FrmRetornoExtratos: TFrmRetornoExtratos
  Left = 138
  Top = 139
  BorderIcons = []
  Caption = 'Retorno'
  ClientHeight = 500
  ClientWidth = 489
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelTotal: TLabel
    Left = 86
    Top = 122
    Width = 36
    Height = 17
    Alignment = taRightJustify
    Caption = 'Total:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object LabelGravados: TLabel
    Left = 55
    Top = 163
    Width = 67
    Height = 17
    Alignment = taRightJustify
    Caption = 'Gravados:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object LabelLidos: TLabel
    Left = 299
    Top = 122
    Width = 39
    Height = 17
    Alignment = taRightJustify
    Caption = 'Lidos:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object LabelErros: TLabel
    Left = 298
    Top = 163
    Width = 40
    Height = 17
    Alignment = taRightJustify
    Caption = 'Erros:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object LabelProcessados: TLabel
    Left = 15
    Top = 280
    Width = 91
    Height = 17
    Alignment = taRightJustify
    Caption = 'Processados:'
    FocusControl = PbProgresso
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 17
    Top = 316
    Width = 89
    Height = 17
    Alignment = taRightJustify
    Caption = 'Consist'#234'ncia:'
    FocusControl = PBConsistencia
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object LabelLCDArquivo: TLabel
    Left = 54
    Top = 351
    Width = 52
    Height = 17
    Alignment = taRightJustify
    Caption = 'Arquivo:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object LabelCaminho: TLabel
    Left = 67
    Top = 387
    Width = 39
    Height = 17
    Alignment = taRightJustify
    Caption = 'Local:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object GroupBoxPeridoCarga: TGroupBox
    Left = 16
    Top = 27
    Width = 452
    Height = 73
    Hint = 'Per'#237'odo em que os objetos foram cadastrados '
    Caption = 'Per'#237'odo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object LabelDtIni: TLabel
      Left = 39
      Top = 28
      Width = 66
      Height = 16
      BiDiMode = bdRightToLeft
      Caption = 'Data Inicial'
      FocusControl = DtPickerDtIni
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object LabelDtFin: TLabel
      Left = 261
      Top = 28
      Width = 61
      Height = 16
      BiDiMode = bdRightToLeft
      Caption = 'Data Final'
      FocusControl = DtPickerDtFin
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object DtPickerDtIni: TDateTimePicker
      Left = 112
      Top = 23
      Width = 107
      Height = 26
      Date = 42283.000000000000000000
      Time = 42283.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object DtPickerDtFin: TDateTimePicker
      Left = 328
      Top = 23
      Width = 105
      Height = 26
      Date = 42290.000000000000000000
      Time = 42290.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object LCDTot: TStaticText
    Left = 128
    Top = 119
    Width = 100
    Height = 23
    Alignment = taRightJustify
    AutoSize = False
    BevelInner = bvSpace
    BevelKind = bkSoft
    BevelOuter = bvRaised
    BorderStyle = sbsSingle
    Caption = '0'
    Color = clBtnHighlight
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 1
  end
  object LCDLidos: TStaticText
    Left = 344
    Top = 119
    Width = 100
    Height = 23
    Alignment = taRightJustify
    AutoSize = False
    BevelInner = bvSpace
    BevelKind = bkSoft
    BevelOuter = bvRaised
    BorderStyle = sbsSingle
    Caption = '0'
    Color = clBtnHighlight
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 2
  end
  object LCDGrav: TStaticText
    Left = 128
    Top = 160
    Width = 100
    Height = 23
    Alignment = taRightJustify
    AutoSize = False
    BevelInner = bvSpace
    BevelKind = bkSoft
    BevelOuter = bvRaised
    BorderStyle = sbsSingle
    Caption = '0'
    Color = clBtnHighlight
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 3
  end
  object LCDErros: TStaticText
    Left = 344
    Top = 160
    Width = 100
    Height = 23
    Alignment = taRightJustify
    AutoSize = False
    BevelInner = bvSpace
    BevelKind = bkSoft
    BevelOuter = bvRaised
    BorderStyle = sbsSingle
    Caption = '0'
    Color = clBtnHighlight
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 4
  end
  object EdNumeroSeparador: TEdit
    Left = 299
    Top = 204
    Width = 147
    Height = 26
    Hint = 'Voc'#234' pode digitar mais de um lote separando-os por v'#237'rgula'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object ChkGerarSeparado: TCheckBox
    Left = 16
    Top = 208
    Width = 269
    Height = 17
    Caption = 'Gerar em separado a partir do n'#250'mero'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Visible = False
    OnClick = ChkGerarSeparadoClick
  end
  object ChkSepCodigoLeitura: TCheckBox
    Left = 16
    Top = 235
    Width = 269
    Height = 17
    Caption = 'Separar por C'#243'digo de Remessa'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    Visible = False
  end
  object PbProgresso: TProgressBar
    Left = 112
    Top = 277
    Width = 364
    Height = 22
    TabOrder = 8
  end
  object PBConsistencia: TProgressBar
    Left = 112
    Top = 313
    Width = 364
    Height = 22
    TabOrder = 9
  end
  object BtnFechar: TBitBtn
    Left = 267
    Top = 423
    Width = 100
    Height = 32
    Caption = '&Fechar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    OnClick = BtnFecharClick
    Glyph.Data = {
      12090000424D120900000000000036000000280000001C0000001B0000000100
      180000000000DC080000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFC00
      FCF100F2F100F2FC00FCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFD201D99303C15806C80B0BCA0B0BCD0B0BCD0B0BCA5806
      C89303C1D201D9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD101D90808A10A0ACA
      0A0AC20A0ABB0A0ABB0A0ABB0A0ABB0A0ABB0A0ABB0A0AC20A0ACA0808A1D101
      D9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFD00FD9403C00A0ACB0A0AC00A0ABD0A0AC50B0BD40B0BDD0B0BE2
      0B0BE20B0BDD0B0BD40A0AC50A0ABD0A0AC00A0ACB9403C0FD00FDFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFB00FB08088F0A0AC80A
      0AC10C0CD80F0FF20F0FFD0F0FFD0F0FFD0F0FFD0F0FFD0F0FFD0F0FFD0F0FFD
      0F0FF20C0CD80A0AC10A0AC808088FFB00FBFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FF8703BF0A0AC70D0DD01313F41414FC1414FC1313F614
      14FC1414FC1414FC1414FC1414FC1414FC1313F61414FC1414FC1313F40D0DD0
      0A0AC78703BFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB501CA0A0A
      CA1010D91818F91818FA1818FA1A1AE36767D71414EB1818FA1818FA1818FA18
      18FA1414EB6666D71919E31818FA1818FA1818F91010D90A0ACAB501CAFF00FF
      FF00FFFF00FFFF00FFFF00FFF700F70A0AB61111D81D1DF81D1DF91D1DF91C1C
      E4B8B8ECFFFFFF8E8EE31818EB1D1DF91D1DF91818EA8E8EE2FFFFFFB5B5EB1B
      1BE31D1DF91D1DF91D1DF81111D80A0AB6F700F7FF00FFFF00FFFF00FFFF00FF
      A702C50D0DCE2020F42121F72121F71F1FE5B8B8EEFFFFFFFFFFFFFFFFFF8F8F
      E41C1CEA1B1BEA8D8DE3FFFFFFFFFFFFFFFFFFB5B5EB1E1EE32121F72121F720
      20F40D0DCEA702C5FF00FFFF00FFFF00FFFF00FF6506C31919E12626F62A2AF6
      2E2EF26C6CE0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9090E68D8DE5FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF6565DB2424F22626F62626F61919E16506C3FF00FFFF
      00FFFF00FFEA00EC0B0BC92929EF4646F55454F65454F64343EB9595EAFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8C8CE62323
      E92B2BF42B2BF42B2BF42828EF0B0BC9EA00ECFF00FFFF00FFC301D10C0CCC50
      50F56060F66060F66060F66060F64C4CEC9595EBFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF8D8DE82727E92F2FF32F2FF32F2FF33A3AF35555
      F50D0DCCC301D1FF00FFFF00FFAE02C71818D06B6BF56B6BF56B6BF56B6BF56B
      6BF56B6BF55454EC9595ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8E8EEA
      2B2BE93434F13434F13434F13535F15D5DF46B6BF51919D0AE02C7FF00FFFF00
      FFA902C51717CE7575F47676F57676F57676F57676F57676F55D5DEE9292EDFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9393EC3636E94343F14141F14B4BF1
      6868F37676F57575F41919CFA902C5FF00FFFF00FFB201C90C0CCC7474EE8080
      F48080F48080F48080F46565EF9292EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFF9696EE6363ED8080F48080F48080F48080F47676EE0E0ECD
      B201C9FF00FFFF00FFCD01D60A0ACA5B5BE48A8AF48A8AF48A8AF46D6DEF9292
      F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF97
      97EF6A6AEE8989F48989F48989F45E5EE50A0ACACD01D6FF00FFFF00FFF600F6
      0A0ABF3030DB8A8AF09494F48989F26C6CEFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF9393F29696F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7171EC8888F19494F48A
      8AF03737DC0A0ABFF600F6FF00FFFF00FFFF00FF7C04BF0E0ED47373E89797F1
      9D9DF46C6CEEB7B7F7FFFFFFFFFFFFFFFFFF9494F37B7BF07B7BF09696F3FFFF
      FFFFFFFFFFFFFFBABAF76C6CED9D9DF49797F17676E81111D47C04BFFF00FFFF
      00FFFF00FFFF00FFC301D10B0BCA3F3FE18686EC9D9DF1A6A6F47272EEB7B7F7
      FFFFFF9595F38181F0A6A6F4A6A6F48181F09696F3FFFFFFBABAF77171EEA6A6
      F49D9DF18686EC4040E10B0BCAC301D1FF00FFFF00FFFF00FFFF00FFFE00FE08
      08950D0DD67070E98D8DED9A9AF0AAAAF37878EE7070EE8888F0AFAFF4AFAFF4
      AFAFF4AFAFF48888F07171EF7676EEAAAAF39A9AF08D8DED7070E80E0ED60808
      95FE00FEFF00FFFF00FFFF00FFFF00FFFF00FFD800DE0A0ABD1C1CDD8888ED96
      96F09696F0A0A0F19D9DF1B2B2F3B6B6F4B7B7F4B7B7F4B6B6F4B2B2F39C9CF1
      A0A0F19696F09696F08888ED1C1CDD0A0ABDD800DEFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFBB01CD0A0AC72424E08F8FF0A0A0F2A0A0F2A0A0F2A0
      A0F2A0A0F2A1A1F2A1A1F2A0A0F2A0A0F2A0A0F2A0A0F2A0A0F29090F02626E0
      0A0AC7BB01CDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFB202C80A0AC11A1ADE7979EDA4A4F3A4A4F3A4A4F3A4A4F3A4A4F3A4A4F3A4
      A4F3A4A4F3A4A4F3A4A4F37D7DEE1D1DDE0A0AC1B202C8FF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE01D70909AB0B0B
      D13737E67878EEA0A0F3A4A4F4A4A4F4A4A4F4A4A4F4A3A3F38282EF3E3EE70C
      0CD10909ABCE01D7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFF700F7A602C40909B20B0BCC1111D92F2F
      E43D3DE94242E93535E51818DA0B0BCC0909B2A602C4F700F7FF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFB00FBD001D89A02C27D04BF6F05C16F05C17D04BF9A02
      C2D001D8FB00FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
  end
  object BtnGerar: TBitBtn
    Left = 128
    Top = 423
    Width = 100
    Height = 32
    Caption = '&Gerar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    OnClick = BtnGerarClick
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
  object StsRemSdx: TStatusBar
    Left = 0
    Top = 471
    Width = 489
    Height = 29
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
  object EdNomeArquivo: TEdit
    Left = 112
    Top = 346
    Width = 363
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
  end
  object EdCaminho: TEdit
    Left = 112
    Top = 382
    Width = 363
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 14
  end
end
