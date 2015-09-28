object FrmBxaSedex: TFrmBxaSedex
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Baixa Sedex Manual'
  ClientHeight = 454
  ClientWidth = 644
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label14: TLabel
    Left = 8
    Top = 46
    Width = 58
    Height = 13
    Caption = 'AR-Objeto: '
  end
  object Label1: TLabel
    Left = 181
    Top = 46
    Width = 41
    Height = 13
    Caption = 'Jun'#231#227'o: '
  end
  object Label4: TLabel
    Left = 324
    Top = 46
    Width = 45
    Height = 13
    Caption = 'Ag'#234'ncia: '
  end
  object Label5: TLabel
    Left = 8
    Top = 68
    Width = 29
    Height = 13
    Caption = 'End.: '
  end
  object Label6: TLabel
    Left = 461
    Top = 73
    Width = 35
    Height = 13
    Caption = 'Bairro: '
  end
  object Label7: TLabel
    Left = 10
    Top = 98
    Width = 40
    Height = 13
    Caption = 'Cidade: '
  end
  object Label8: TLabel
    Left = 407
    Top = 97
    Width = 20
    Height = 13
    Caption = 'UF: '
  end
  object Label9: TLabel
    Left = 461
    Top = 98
    Width = 26
    Height = 13
    Caption = 'Cep: '
  end
  object Label2: TLabel
    Left = 10
    Top = 130
    Width = 41
    Height = 13
    Caption = 'Volume: '
  end
  object Label11: TLabel
    Left = 319
    Top = 129
    Width = 47
    Height = 13
    Caption = 'Valor R$: '
  end
  object Label13: TLabel
    Left = 461
    Top = 129
    Width = 47
    Height = 13
    Caption = 'Total R$: '
  end
  object Label15: TLabel
    Left = 10
    Top = 157
    Width = 51
    Height = 13
    Caption = 'Valor Decl.'
  end
  object Label10: TLabel
    Left = 180
    Top = 157
    Width = 34
    Height = 13
    Caption = 'Nome: '
  end
  object Label12: TLabel
    Left = 461
    Top = 157
    Width = 45
    Height = 13
    Caption = 'Entrega: '
  end
  object Label3: TLabel
    Left = 10
    Top = 18
    Width = 39
    Height = 13
    Caption = 'Motivo: '
  end
  object Label16: TLabel
    Left = 181
    Top = 129
    Width = 30
    Height = 13
    Caption = 'Peso: '
  end
  object EdObjeto: TEdit
    Left = 74
    Top = 38
    Width = 99
    Height = 22
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 13
    ParentFont = False
    TabOrder = 0
    OnKeyPress = EdObjetoKeyPress
  end
  object EdJuncao: TEdit
    Left = 223
    Top = 38
    Width = 90
    Height = 22
    CharCase = ecUpperCase
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    MaxLength = 4
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
  object EdDpto: TEdit
    Left = 368
    Top = 38
    Width = 256
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
    TabOrder = 2
  end
  object EdEnd: TEdit
    Left = 74
    Top = 66
    Width = 379
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
    TabOrder = 3
  end
  object EdBairro: TEdit
    Left = 513
    Top = 66
    Width = 111
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
    TabOrder = 4
  end
  object EdCid: TEdit
    Left = 74
    Top = 93
    Width = 327
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
    TabOrder = 5
  end
  object EdUF: TEdit
    Left = 429
    Top = 93
    Width = 24
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
    TabOrder = 6
  end
  object MkEdCep: TMaskEdit
    Left = 513
    Top = 93
    Width = 112
    Height = 22
    BiDiMode = bdLeftToRight
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
    ReadOnly = True
    TabOrder = 7
  end
  object EdVol: TEdit
    Left = 74
    Top = 120
    Width = 100
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
    TabOrder = 8
  end
  object EdPeso: TEdit
    Left = 223
    Top = 121
    Width = 91
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
    TabOrder = 9
  end
  object EdValor: TEdit
    Left = 366
    Top = 120
    Width = 88
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
    TabOrder = 10
  end
  object EdVvalor: TEdit
    Left = 514
    Top = 120
    Width = 111
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
    TabOrder = 11
  end
  object Edvaldec: TEdit
    Left = 74
    Top = 149
    Width = 100
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
    TabOrder = 12
  end
  object EdNome: TEdit
    Left = 223
    Top = 148
    Width = 232
    Height = 22
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    OnEnter = EdNomeEnter
  end
  object DBGridDados: TDBGrid
    Left = 8
    Top = 186
    Width = 624
    Height = 246
    Ctl3D = False
    DataSource = Dm.DtSSdx4
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 15
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'sdx_siglaobj'
        Title.Caption = 'Sigla'
        Title.Color = 16764262
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sdx_numobj'
        Title.Caption = 'Ar-Sedex'
        Title.Color = 16764262
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sdx_nomdest'
        Title.Caption = 'Ag.Destino'
        Title.Color = 16764262
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sdx_endedest'
        Title.Caption = 'Endere'#231'o'
        Title.Color = 16764262
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sdx_cep'
        Title.Caption = 'Cep'
        Title.Color = 16764262
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 65
        Visible = True
      end>
  end
  object DBCboBxa: TDBLookupComboBox
    Left = 74
    Top = 12
    Width = 240
    Height = 21
    KeyField = 'bxasdx_codbxa'
    ListField = 'bxasdx_dscbxa;bxasdx_codbxa'
    ListSource = Dm.DtStbbxasdx
    TabOrder = 16
  end
  object MkEdDtEntrega: TMaskEdit
    Left = 512
    Top = 148
    Width = 112
    Height = 22
    BiDiMode = bdLeftToRight
    EditMask = '!99/99/0000;1;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    MaxLength = 10
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 14
    Text = '  /  /    '
    OnEnter = MkEdDtEntregaEnter
    OnKeyPress = MkEdDtEntregaKeyPress
  end
end
