object FrmGeraRelatToken: TFrmGeraRelatToken
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rios de Tokens'
  ClientHeight = 297
  ClientWidth = 471
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBoxPeridoCarga: TGroupBox
    Left = 8
    Top = 8
    Width = 452
    Height = 73
    Hint = 'Per'#237'odo em que os objetos foram cadastrados '
    Caption = ' Per'#237'odo '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
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
    object Label1: TLabel
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
    object DtPickerDtIni: TDateTimePicker
      Left = 112
      Top = 23
      Width = 107
      Height = 26
      Date = 42339.000000000000000000
      Time = 42339.000000000000000000
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
      Date = 42339.000000000000000000
      Time = 42339.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object BtnImprime: TBitBtn
    Left = 106
    Top = 232
    Width = 100
    Height = 32
    Caption = '&Imprimir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = BtnImprimeClick
    Glyph.Data = {
      76060000424D7606000000000000360400002800000018000000180000000100
      08000000000040020000220B0000220B00000001000000010000212121002121
      290029292900292931003131310039393900424242004A4A4A00525252005A5A
      5A00635A6300636363006B6B6B007B7B7B00848484008C84840084C684008C8C
      8C009C949C009C9C9C00A59C9C00A59CA500A5A5A500ADA5A500F7B5A500FFBD
      A500ADA5AD00ADADAD00B5ADAD00ADB5AD00E7B5AD00FFC6AD00B5ADB500B5B5
      B500BDB5B500DEB5B500E7BDB500F7BDB500FFC6B500FFCEB500BDB5BD00BDBD
      BD00C6BDBD00E7BDBD00E7C6BD00FFCEBD00FFD6BD00C6BDC600C6C6C600CEC6
      C600E7C6C600E7CEC600FFD6C600C6C6CE00CEC6CE00CECECE00D6CECE00EFCE
      CE00EFD6CE00FFDECE00D6CED600D6D6D600DED6D600F7DED600FFDED600FFE7
      D600D6F7D600D6D6DE00D6DEDE00DEDEDE00E7DEDE00EFDEDE00DEE7DE00E7E7
      DE00FFE7DE00FFEFDE00E7E7E700EFE7E700FFEFE700EFEFEF00FFF7EF00F7F7
      F700FFF7F700FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00535353535353
      53535353535353535353535353535353535353535353535353531B361B135353
      1B3D3E291B53535353535353535353531B305151291B090B0E1B31464C3D2153
      5353535353531B224C54544F221C070004060B0E1B374C4517535353531B4554
      5251524F2121120C07040204060B11165353531637515151514C301B13161B21
      1C130D0905020614535353164F514F452917213D2116141314172121160E0C14
      535353164C3E2216223D454C4C3D30221B161413161B2116535353161C16293D
      453D3D4D51514F4C3D3729211716141353535316293D3D3D3D3D4C51302F3745
      4C4C453D37302916535353163D3D3D3D3D4551291D10211B1B29303D45453D1B
      5353535329453D3D4C4C21294F424F4C25291C171B292921535353535321303D
      301B315151514F4C4C4C453D3717165353535353535353142945371B30454C4C
      4C4C4C4530225353535353535353531B5151452929303D3D3D3D301B22535353
      5353535353535353474A41403F3F3F4746453053535353535353535353535353
      2C4A403B342D26261F3953535353535353535353535353532C4A403B342D261F
      18535353535353535353535353535353334A403B342D261F1853535353535353
      5353535353535353334A403B342D261F25535353535353535353535353535353
      334A403B342D2625255353535353535353535353535353324E4A403B342D2725
      53535353535353535353535353535333504A413B343425255353535353535353
      5353535353532333322C2C24241E255353535353535353535353}
  end
  object BtnFechar: TBitBtn
    Left = 264
    Top = 232
    Width = 100
    Height = 32
    Caption = '&Fechar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 93
    Width = 452
    Height = 115
    Hint = 'Per'#237'odo em que os objetos foram cadastrados '
    Caption = ' Origem '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object LabelDtIni: TLabel
      Left = 33
      Top = 30
      Width = 53
      Height = 16
      BiDiMode = bdRightToLeft
      Caption = 'Ag'#234'ncia:'
      FocusControl = EdAgencia
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object Label2: TLabel
      Left = 250
      Top = 30
      Width = 34
      Height = 16
      BiDiMode = bdRightToLeft
      Caption = 'GRM:'
      FocusControl = EdGrm
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object Label3: TLabel
      Left = 39
      Top = 69
      Width = 47
      Height = 16
      BiDiMode = bdRightToLeft
      Caption = 'N'#186' Lote:'
      FocusControl = EdLote
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object EdAgencia: TEdit
      Left = 93
      Top = 20
      Width = 126
      Height = 26
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object EdGrm: TEdit
      Left = 291
      Top = 25
      Width = 126
      Height = 26
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object EdLote: TEdit
      Left = 93
      Top = 64
      Width = 126
      Height = 26
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object StsRemSdx: TStatusBar
    Left = 0
    Top = 276
    Width = 471
    Height = 21
    Color = clActiveBorder
    Panels = <
      item
        Text = 'Ads - Address SA'
        Width = 230
      end
      item
        Width = 100
      end>
    ExplicitTop = 304
  end
end
