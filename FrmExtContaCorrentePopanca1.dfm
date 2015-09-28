object FrmExtContaCorrentePoupanca: TFrmExtContaCorrentePoupanca
  Left = 227
  Top = 220
  Width = 667
  Height = 227
  ActiveControl = ScrollBox1
  BorderIcons = []
  Caption = 'Baixa de extratos Conta Corrente Poupan'#231'a'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 659
    Height = 200
    HorzScrollBar.Range = 634
    VertScrollBar.Range = 156
    Align = alClient
    AutoScroll = False
    Color = 16704412
    ParentColor = False
    TabOrder = 0
    object DbLkBaixa: TDBLookupComboBox
      Left = 365
      Top = 16
      Width = 269
      Height = 21
      KeyField = 'cg20_codbaixa'
      ListField = 'cg20_descricao'
      ListSource = Dm.DtsCga20
      TabOrder = 2
    end
    object EdCaixa: TEdit
      Left = 101
      Top = 18
      Width = 164
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object EdQt: TEdit
      Left = 101
      Top = 51
      Width = 164
      Height = 21
      ReadOnly = True
      TabOrder = 1
      Text = '0'
    end
    object Panel1: TPanel
      Left = 16
      Top = 16
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Caixa'
      TabOrder = 6
    end
    object Panel2: TPanel
      Left = 280
      Top = 16
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Baixa'
      TabOrder = 7
    end
    object Panel3: TPanel
      Left = 15
      Top = 48
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Quantidade'
      TabOrder = 8
    end
    object Panel4: TPanel
      Left = 280
      Top = 48
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Remessa'
      TabOrder = 9
    end
    object BtnFechar: TBitBtn
      Left = 279
      Top = 126
      Width = 75
      Height = 25
      Caption = '&Fechar'
      TabOrder = 10
      OnClick = BtnFecharClick
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
    object StBr: TStatusBar
      Left = 0
      Top = 167
      Width = 655
      Height = 29
      Panels = <
        item
          Alignment = taCenter
          Width = 50
        end>
    end
    object GroupTipo: TGroupBox
      Left = 88
      Top = 80
      Width = 174
      Height = 28
      TabOrder = 3
      Visible = False
      object ChkLeitura: TRadioButton
        Left = 18
        Top = 9
        Width = 63
        Height = 16
        Caption = 'Leitura'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = ChkLeituraClick
      end
      object ChkDigita: TRadioButton
        Left = 101
        Top = 9
        Width = 71
        Height = 16
        Caption = 'Digita'#231#227'o'
        TabOrder = 1
        OnClick = ChkDigitaClick
      end
    end
    object EdRemessa: TMaskEdit
      Left = 365
      Top = 49
      Width = 269
      Height = 21
      MaxLength = 22
      TabOrder = 4
      OnKeyPress = EdRemessaKeyPress
    end
    object Edremessa2: TMaskEdit
      Left = 365
      Top = 83
      Width = 269
      Height = 21
      MaxLength = 22
      TabOrder = 5
      OnExit = Edremessa2Exit
      OnKeyPress = Edremessa2KeyPress
    end
    object Panel5: TPanel
      Left = 280
      Top = 82
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Remessa2'
      TabOrder = 12
    end
    object RdGrptipocli: TRadioGroup
      Left = 88
      Top = 112
      Width = 173
      Height = 35
      Caption = 'Tipo Cliente'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        '0 - PF'
        '1 - PJ')
      TabOrder = 13
    end
  end
end
