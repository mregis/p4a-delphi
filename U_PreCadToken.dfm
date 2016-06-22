object FrmPreCadToken: TFrmPreCadToken
  Left = 265
  Top = 177
  BorderStyle = bsDialog
  Caption = 'FrmPreCadToken'
  ClientHeight = 495
  ClientWidth = 790
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 790
    Height = 495
    HorzScrollBar.Range = 634
    VertScrollBar.Range = 156
    Align = alClient
    AutoScroll = False
    Color = clSkyBlue
    ParentColor = False
    TabOrder = 0
    object lblLotesCriado: TLabel
      Left = 91
      Top = 106
      Width = 470
      Height = 17
      AutoSize = False
      Caption = 'Lote[s] criados:'
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Visible = False
      WordWrap = True
    end
    object Bevel1: TBevel
      Left = 219
      Top = 424
      Width = 348
      Height = 42
    end
    object LabelLote: TLabel
      Left = 60
      Top = 46
      Width = 32
      Height = 17
      Caption = 'Lote:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object LabelErros: TLabel
      Left = 593
      Top = 45
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
    object LabelGravados: TLabel
      Left = 566
      Top = 13
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
      Left = 350
      Top = 45
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
    object Label38: TLabel
      Left = 37
      Top = 78
      Width = 55
      Height = 18
      Alignment = taRightJustify
      Caption = 'Produto:'
      FocusControl = CboProdutoServSedex
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Panel5: TPanel
      Left = 9
      Top = 119
      Width = 76
      Height = 20
      BevelInner = bvLowered
      BevelOuter = bvNone
      Caption = 'Leitura'
      Color = clBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpFixed
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
    end
    object StrGridDados: TStringGrid
      Left = 0
      Top = 142
      Width = 786
      Height = 274
      BevelInner = bvNone
      BevelOuter = bvNone
      BiDiMode = bdLeftToRight
      Color = clWhite
      ColCount = 11
      Ctl3D = False
      DefaultRowHeight = 18
      FixedColor = clSilver
      FixedCols = 0
      RowCount = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
      ParentBiDiMode = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 5
      ColWidths = (
        34
        56
        144
        42
        64
        64
        45
        74
        70
        79
        83)
    end
    object DBGridRelObjetos: TDBGrid
      Left = 0
      Top = 105
      Width = 785
      Height = 313
      Color = clWhite
      DataSource = Dm.DtSAux4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 16
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
      OnDrawColumnCell = DBGridRelObjetosDrawColumnCell
      Columns = <
        item
          DropDownRows = 10
          Expanded = False
          FieldName = 'sigla'
          Title.Caption = 'SIGLA'
          Title.Color = clNavy
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clCream
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Width = 35
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cod'
          Title.Caption = 'COD'
          Title.Color = clNavy
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clCream
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'pagante'
          Title.Caption = 'PAGANTE'
          Title.Color = clNavy
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clCream
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Width = 225
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cartao'
          Title.Caption = 'CARTAO'
          Title.Color = clNavy
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clCream
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'lote'
          Title.Caption = 'LOTE'
          Title.Color = clNavy
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clCream
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dtvencto'
          Title.Caption = 'VENCIMENTO'
          Title.Color = clNavy
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clCream
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Width = 72
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'carga'
          Title.Alignment = taRightJustify
          Title.Caption = 'TOTAL'
          Title.Color = clNavy
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clCream
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'usado'
          Title.Alignment = taRightJustify
          Title.Caption = 'UTILIZADO'
          Title.Color = clNavy
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clCream
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'livre'
          Title.Alignment = taRightJustify
          Title.Caption = 'DISPONIVEL'
          Title.Color = clNavy
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clCream
          Title.Font.Height = -11
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Width = 73
          Visible = True
        end>
    end
    object EdErro: TEdit
      Left = 637
      Top = 40
      Width = 117
      Height = 27
      BevelInner = bvNone
      BevelOuter = bvNone
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      MaxLength = 4
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      Text = '0'
    end
    object StBr: TStatusBar
      Left = 0
      Top = 474
      Width = 786
      Height = 17
      Panels = <
        item
          Alignment = taCenter
          Width = 50
        end>
    end
    object Ednumlote: TEdit
      Left = 94
      Top = 41
      Width = 117
      Height = 26
      Align = alCustom
      BevelInner = bvNone
      BevelOuter = bvNone
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 1
    end
    object EdLocal: TEdit
      Left = 94
      Top = 8
      Width = 387
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
      TabOrder = 6
    end
    object BtnAbrir: TBitBtn
      Left = 18
      Top = 8
      Width = 74
      Height = 32
      Caption = '&Abrir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
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
    object EdQtdreg: TEdit
      Left = 393
      Top = 40
      Width = 88
      Height = 27
      BevelInner = bvNone
      BevelOuter = bvNone
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      MaxLength = 4
      ParentFont = False
      TabOrder = 7
      Text = '0'
    end
    object EdGrava: TEdit
      Left = 637
      Top = 8
      Width = 117
      Height = 27
      BevelInner = bvNone
      BevelOuter = bvNone
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      MaxLength = 4
      ParentFont = False
      TabOrder = 8
      Text = '0'
    end
    object NovoLoteChkBox: TCheckBox
      Left = 220
      Top = 47
      Width = 97
      Height = 17
      Caption = 'Novo Lote'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 2
      OnClick = NovoLoteChkBoxClick
    end
    object CboProdutoServSedex: TDBLookupComboBox
      Left = 94
      Top = 73
      Width = 387
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
      TabOrder = 10
    end
    object PanelProgress: TPanel
      AlignWithMargins = True
      Left = 254
      Top = 227
      Width = 315
      Height = 68
      Align = alCustom
      Anchors = []
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
      TabOrder = 11
      VerticalAlignment = taAlignTop
      Visible = False
      ExplicitLeft = 251
      ExplicitTop = 224
      object PanelProgressBar: TProgressBar
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
    object BtnFechar: TBitBtn
      Left = 459
      Top = 430
      Width = 100
      Height = 32
      Caption = '&Fechar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
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
    object BtnSalvar: TBitBtn
      Left = 342
      Top = 430
      Width = 99
      Height = 32
      Caption = '&Salvar'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      OnClick = BtnSalvarClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF004B00004B00A18283A18283A18283A1
        8283A18283A18283A18283004B00004B00FF00FFFF00FFFF00FFFF00FF004B00
        008100008100DDD4D5004B00004B00DCE0E0D7DADECED5D7BDBABD004B000163
        01004B00FF00FFFF00FFFF00FF004B00008100008100E2D9D9004B00004B00D9
        D8DAD9DEE1D3D9DCC1BDC1004B00016301004B00FF00FFFF00FFFF00FF004B00
        008100008100E6DCDC004B00004B00D5D3D5D8DEE1D7DDE0C6C2C5004B000163
        01004B00FF00FFFF00FFFF00FF004B00008100008100EADEDEE7DDDDDDD4D5D7
        D3D5D5D7D9D7D8DACAC2C5004B00016301004B00FF00FFFF00FFFF00FF004B00
        0081000081000081000081000081000081000081000081000081000081000081
        00004B00FF00FFFF00FFFF00FF004B000081009DC29D9DC29D9DC29D9DC29D9D
        C29D9DC29D9DC29D9DC29D9DC29D008100004B00FF00FFFF00FFFF00FF004B00
        008100F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F70081
        00004B00FF00FFFF00FFFF00FF004B00008100F7F7F7F7F7F7F7F7F7F7F7F7F7
        F7F7F7F7F7F7F7F7F7F7F7F7F7F7008100004B00FF00FFFF00FFFF00FF004B00
        008100F7F7F7BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFF7F7F70081
        00004B00FF00FFFF00FFFF00FF004B00008100F7F7F7F7F7F7F7F7F7F7F7F7F7
        F7F7F7F7F7F7F7F7F7F7F7F7F7F7008100004B00FF00FFFF00FFFF00FF004B00
        008100F7F7F7BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFF7F7F70081
        00004B00FF00FFFF00FFFF00FF004B00008100F7F7F7F7F7F7F7F7F7F7F7F7F7
        F7F7F7F7F7F7F7F7F7F7F7F7F7F7008100004B00FF00FFFF00FFFF00FFFF00FF
        004B00F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7004B
        00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
    object BtnLeitura: TBitBtn
      Left = 226
      Top = 430
      Width = 99
      Height = 32
      Caption = '&Leitura'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      OnClick = BtnLeituraClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FF0274AC
        0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274AC0274
        AC0274ACFF00FFFF00FF0274AC138AC457B7E06BCBF84BBFF74ABFF74ABFF74A
        BFF74ABFF64ABFF74ABFF64BC0F72398CC0274ACFF00FFFF00FF0274AC33AAE0
        2392C489D9FA54C7F854C7F753C7F854C7F754C7F854C7F854C7F853C7F7279D
        CE6ACBE50274ACFF00FF0274AC57CAF80274AC99E3FB5ED1FA5ED1FA5ED1FA5E
        D1FA5ED1FA5FD1FA5ED1F85ED1F82CA1CE99EDF70274ACFF00FF0274AC5ED3FA
        0B81B782D5EF79E0FA6ADCFA69DCFB69DCFB6ADCFB69DCFB69DCFA6ADDFB2FA6
        CF9FF0F70274ACFF00FF0274AC68DAFB2BA4D14AB2D797EBFC74E5FB74E5FB74
        E5FC74E5FC74E5FB74E5FC046B0B33A9CFA3F4F752BBD70274AC0274AC70E3FB
        5CD1EF1184B6FCFFFFB8F4FEBAF4FEBAF4FEBAF4FEB8F4FE046B0B25AA42046B
        0BD4F7FACAF3F70274AC0274AC7AEBFE7AEBFC0A7FB50274AC0274AC0274AC02
        74AC0274AC046B0B38CE6547E77F29B44A046B0B0274AC0274AC0274AC83F2FE
        82F3FE82F3FE83F2FC83F3FE82F3FE83F2FE046B0B2DC0513FDC6E3ED86E46E5
        7B28B04A046B0BFF00FF0274ACFEFEFE89FAFF89FAFE89FAFE8AF8FE8AFAFE04
        6B0B046B0B046B0B046B0B3CD86A2EBF53046B0B046B0B046B0BFF00FF0274AC
        FEFEFE8FFEFF8FFEFF8FFEFF0273A32BA4D12BA4D12BA4D1046B0B35D35E20A7
        3A046B0BFF00FFFF00FFFF00FFFF00FF0274AC0274AC0274AC0274ACFF00FFFF
        00FFFF00FFFF00FF046B0B28C24A046B0BFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF046B0B17A42B19A730046B
        0BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF046B0B11A122046B0BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF046B0B046B0B046B0B046B0BFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF046B0B046B0B04
        6B0B046B0BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
    object BitBtnImprimeARs: TBitBtn
      Left = 599
      Top = 110
      Width = 155
      Height = 28
      Caption = '&Imprimir ARs'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      Visible = False
      OnClick = BitBtnImprimeARsClick
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAEABACCCCACB
        B1AFAFA09D9EFF00FFFF00FFACAAABD3D3D3DBDADAC0BEBEADAAABFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAEABACC7
        C5C6F4F3F3F7F6F6BCBABAB1AFAF5D5C5D615F60888687AEACACCBCACAE3E2E2
        E7E7E7D5D4D4B6B4B5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFADAB
        ACBBB8B9EAE9E9FFFEFEFDFCFCF3F2F2BAB8B8B2B0B04C4B4D23232530303242
        4244626062878486AFADADD2D1D1E9E8E8DEDDDDAAA7A8FF00FFFF00FFFF00FF
        FF00FFAFADAEE1DFDFFDFCFCFCFBFBFAF9F9FCFBFBEDEBECB6B4B4B6B4B49897
        986F6E6F4C4B4D33333528282A2E2E30414143605F608C898AA7A5A5FF00FFFF
        00FFFF00FFA4A1A2D1CFCFF8F7F7FBFAFAF7F6F6F7F6F6EAE9E9C8C7C7ADABAC
        A09D9EA3A1A1AFACADB8B5B6B3B1B19E9D9D7B7A7B57565738383A2627294342
        44A19E9FFF00FFFF00FFFF00FFA4A1A2F0F0F0F4F4F4F1F0F0E2E1E1C1BFBFAB
        A8A9B9B7B7D4D3D3B7B5B5A8A5A5A29FA09F9C9DA2A0A0ABA8A9B5B3B2B5B3B3
        A7A5A68483846C6C6DA2A0A0FF00FFFF00FFFF00FFA4A1A2E6E5E5DBDADABAB8
        B8A9A6A7BAB8B8D6D5D6DFE0DFE4E3E3E8E7E7D8D6D6C9C7C7BAB8B8AFACADA5
        A2A3A19E9FA09D9EA7A4A4B1AEAEB6B4B4A7A5A5FF00FFFF00FFFF00FFA4A1A2
        B2B0B1A9A7A7BBBABAD4D4D4DCDDDDD9D9D9D5D5D5ECEBEBF8F7F7F6F6F6F1F0
        F0E7E6E6DAD9D9CDCCCCC0BEBEB5B3B3AAA8A8A3A1A1A19E9F9D9A9BFF00FFFF
        00FFFF00FFA4A1A2BCBABBD5D4D4DADADAD7D7D7D6D6D6D3D3D3E3E3E3F7F6F6
        C5C3C4C6BCC4D1CFD0E1E0E0E8E8E8E9E9E9E2E2E2D9D9D9CFCECEC4C3C3BCBA
        BAA8A5A6FF00FFFF00FFFF00FFA4A1A2D6D6D6D8D8D8D6D6D6D6D6D6D4D4D4E0
        E0E0F7F6F6C0BCBEAEB2AD80C184B2B6B1AEAAACB0AFAFBCBBBBCAC9C9D8D7D7
        DCDCDCDCDCDCDADADAAFAEAEFF00FFFF00FFFF00FFFF00FFBFBDBEDBDBDBD8D9
        D9D9D9D9E6E6E6EAE9E9B7B5B5BDBBBCF2F2F1D4F1D5EBEEEBE7E5E6FAC0AFC1
        BFC0B3B1B1AAA7A8AFACADBDBBBBBDBBBCB6B3B4FF00FFFF00FFFF00FFFF00FF
        FF00FFB5B3B4CAC9C9D6D5D5C6C4C4AEACACCCCACAF7F6F6F7F6F6F7F2F6EFED
        EDEBEAEAE9E9E9E8E8E8E2E2E2D9D9D9CDCDCDAAA8A9A5A2A3FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFA19E9FBBBABADCDCDCCDCDCDADAEAE
        C9C9C9DDDCDCE6E5E5E8E7E7E6E6E6E4E4E4E5E5E5E0E0E0C5C5C5BAB7B8FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1AFB0F6F7F7F7
        F6F5E2DFDEBCBABABABBBBC4C7C8D4D7D8D5D8D8D8D9D9D8D8D8C6C5C6ADABAC
        BAB7B8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFEED9D8FFEAE2FFE5DAFEDFD4FADDD3F6DCD3F1DCD6ECDEDAE6E1DFDB
        DBDBC8C7C8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFE5C4C1FFE7DDFFE1D5FFDACEFFD4C5FFCEBCFFC9
        B7FFC7B3FDC1AEEBD2CFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE6C5C1FFEBE1FFE1D5FFDACE
        FFD5C7FECFBFFECAB8FFC4B0F9B9A7FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFECCDC8FF
        EBE1FFE1D5FFDACEFFD5C7FECFBFFECAB8FFC5B1F0B4A5FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFE8CCC8FFE9DFFFE1D5FFDACEFFD5C7FECFBFFECAB8FFC5B1FAC0AFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFE8CCC8FFE7DDFFE1D5FFDACEFFD5C7FECFBFFFCA
        B8FAC0AFFAC0AFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFE7C9C5FFF1E9FFE7DDFFE1D5FFDACE
        FED5C7FED0BFFFCCB9FAC0AFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE8CCC8FFF4EBFF
        EBE1FFE6D9FFDFD2FFD9CAFFD4C3F1BDB0FAC0AFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD9B3
        B1E8CCC8E7C7C3E7C5BFE7C2BBE7BEB8E7BCB4E5B6AFFAC0AFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
  end
  object OpenArq: TOpenDialog
    Filter = 'Excel|*.xls'
    Left = 11
    Top = 425
  end
  object ExcelApplication1: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 78
    Top = 426
  end
end
