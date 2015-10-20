object FrmGeraListaPostagem: TFrmGeraListaPostagem
  Left = 0
  Top = 0
  Caption = 'Lista de Postagem'
  ClientHeight = 489
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
    Left = 79
    Top = 96
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
  object BitBtnGerar: TBitBtn
    Left = 139
    Top = 272
    Width = 97
    Height = 34
    Caption = 'Gerar Arquivo'
    TabOrder = 0
    OnClick = BitBtnGerarClick
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
    Left = 139
    Top = 91
    Width = 322
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
    Top = 312
    Width = 687
    Height = 177
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
end
