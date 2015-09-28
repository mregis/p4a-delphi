object FrmExtContaCorrentePoupanca: TFrmExtContaCorrentePoupanca
  Left = 58
  Top = 192
  Width = 650
  Height = 98
  Caption = 'Baixa de extratos Conta Corrente Poupan'#231'a'
  Color = clBtnFace
  PixelsPerInch = 96
  TextHeight = 13

  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 650
    Height = 98
    VertScrollBar.Range = 76
    HorzScrollBar.Range = 634
    Align = alClient
    TabOrder = 0
    object DbLkBaixa: TDBLookupComboBox
      Left = 365
      Top = 16
      Width = 269
      Height = 23
      TabOrder = 0
    end
    object EdCaixa: TEdit
      Left = 101
      Top = 18
      Width = 164
      Height = 21
      TabOrder = 1
    end
    object EdQt: TEdit
      Left = 101
      Top = 51
      Width = 164
      Height = 21
      ReadOnly = True
      TabOrder = 2
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
      TabOrder = 3
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
      TabOrder = 4
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
      TabOrder = 5
    end
    object EdRemessa: TEdit
      Left = 364
      Top = 51
      Width = 269
      Height = 21
      TabOrder = 6
    end
    object Panel4: TPanel
      Left = 280
      Top = 50
      Width = 80
      Height = 26
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BevelWidth = 3
      Caption = 'Remessa'
      TabOrder = 7
    end
  end
end
