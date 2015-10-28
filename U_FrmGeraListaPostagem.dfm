object FrmGeraListaPostagem: TFrmGeraListaPostagem
  Left = 0
  Top = 0
  Caption = 'Lista de Postagem'
  ClientHeight = 378
  ClientWidth = 687
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object LabelProd: TLabel
    Left = 28
    Top = 102
    Width = 54
    Height = 16
    BiDiMode = bdRightToLeft
    Caption = 'Pagante:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
  end
  object LabelLote: TLabel
    Left = 341
    Top = 102
    Width = 36
    Height = 16
    BiDiMode = bdRightToLeft
    Caption = 'Lotes:'
    FocusControl = EditLotes
    ParentBiDiMode = False
  end
  object Label1: TLabel
    Left = 31
    Top = 141
    Width = 49
    Height = 16
    BiDiMode = bdRightToLeft
    Caption = 'Destino:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
  end
  object GroupBoxPeridoPostagem: TGroupBox
    Left = 28
    Top = 9
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
    TabOrder = 1
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
      ParseInput = True
      ParentFont = False
      TabOrder = 0
      OnCloseUp = DtPickerDtIniCloseUp
      OnUserInput = DtPickerDtIniUserInput
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
      ParseInput = True
      ParentFont = False
      TabOrder = 1
      OnCloseUp = DtPickerDtFinCloseUp
      OnUserInput = DtPickerDtFinUserInput
    end
  end
  object CboPagante: TDBLookupComboBox
    Left = 88
    Top = 97
    Width = 230
    Height = 26
    Ctl3D = True
    DropDownRows = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    KeyField = 'tbsdxserv_prod'
    ListField = 'tbsdxserv_dsc'
    ListFieldIndex = -1
    ListSource = Dm.DtSSdxServ
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
  end
  object DBGridPostagem: TDBGrid
    Left = 0
    Top = 224
    Width = 687
    Height = 154
    Align = alBottom
    Ctl3D = False
    DataSource = Dm.DtSSdx7
    FixedColor = 16764262
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = DBGridPostagemCellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'tbsdxserv_dsc'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 157
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tbsdxserv_crtpst'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 136
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tbsdxserv_sigla'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 39
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'qtobjs'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'lote'
        Title.Caption = 'Lote'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 99
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'mindt'
        Title.Caption = 'Data Inicial'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'maxdt'
        Title.Caption = 'Data Final'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  object EditLotes: TEdit
    Left = 383
    Top = 97
    Width = 126
    Height = 26
    Hint = 'Voc'#234' pode digitar mais de um lote separando-os por v'#237'rgula'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object BitBtnGerar: TBitBtn
    Left = 183
    Top = 187
    Width = 97
    Height = 34
    Caption = 'Gerar Arquivo'
    TabOrder = 0
    OnClick = BitBtnGerarClick
  end
  object BtnFechar: TBitBtn
    Left = 332
    Top = 187
    Width = 100
    Height = 32
    Caption = '&Fechar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
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
  object BtnAbrir: TBitBtn
    Left = 515
    Top = 137
    Width = 107
    Height = 26
    Caption = '&Selecionar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = BtnAbrirClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FF0274AC
      0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274
      ACFF00FFFF00FFFF00FF0274AC138AC456B6E16ACBF84BBFF74ABFF74ABFF74A
      BFF74ABFF64ABFF74ABFF64BC0F72398CC0C81BAFF00FFFF00FF0274AC33AAE0
      2392C489D9FA54C7F854C7F753C7F854C7F754C7F854C7F854C7F853C7F7279D
      CEBAEBEF0274ACFF00FF0274AC57CAF80274AC99E2FB5ED1FA5ED1FA5ED1FA5E
      D1FA5ED1FA5FD1FA5ED1F85ED1F82CA1CEBAEBEF0274ACFF00FF0274AC5ED3FA
      0B81B782D5EF79E0FB6ADCFA69DCFB69DCFB6ADCFB69DCFB69DCFA6ADDFB2FA6
      CFBAEBEF097EB4FF00FF0274AC68DAFB2BA4D14AB1D796EBFB74E5FB74E5FB74
      E5FC74E5FC74E5FB74E5FC74E5FB33A9CFBAEBEFBAEBEF0274AC0274AC70E3FB
      5CD1EF1184B7FEFFFFB8F4FCBAF4FCBAF4FCBAF4FEB8F4FEBAF4FCB8F4FE83C9
      DEE3FEFEC5EFF60274AC0274AC7AEBFE7AEBFC0A7FB50274AC0274AC0274AC02
      74AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC83F2FE
      82F3FE82F3FE83F2FC83F3FE82F3FE83F2FE82F3FC83F2FE82F3FE82F3FE036F
      A7FF00FFFF00FFFF00FF0274ACFEFEFE89FAFF89FAFE89FAFE8AF8FE8AFAFE89
      F8FE8AFAFE8AFAFF89FAFF8AFAFF036FA7FF00FFFF00FFFF00FFFF00FF0274AC
      FEFEFE8FFEFF8FFEFF8FFEFF0274AC0274AC0274AC0274AC0274AC0274ACFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF0274AC0274AC0274AC0274ACFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
  end
  object EdDirDestinoListagem: TEdit
    Left = 88
    Top = 136
    Width = 421
    Height = 26
    BevelInner = bvNone
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 255
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
    OnDblClick = BtnAbrirClick
  end
  object PanelProgress: TPanel
    AlignWithMargins = True
    Left = 165
    Top = 297
    Width = 315
    Height = 73
    BevelInner = bvRaised
    BevelOuter = bvNone
    BorderWidth = 1
    BorderStyle = bsSingle
    Caption = 'Executando a opera'#231#227'o. Aguarde...'
    UseDockManager = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    VerticalAlignment = taAlignTop
    Visible = False
    object ProgBar: TProgressBar
      AlignWithMargins = True
      Left = 24
      Top = 26
      Width = 265
      Height = 23
      BorderWidth = 2
      Smooth = True
      TabOrder = 0
    end
  end
end
