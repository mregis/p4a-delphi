object FrmFrEtiqueta: TFrmFrEtiqueta
  Left = 57
  Top = 107
  Width = 569
  Height = 404
  HorzScrollBar.Range = 816
  VertScrollBar.Range = 1055
  Caption = 'FrmMkEtiqueta'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport
    Left = 0
    Top = -1
    Width = 816
    Height = 1056
    Margins.LeftMargin = 4.000000000000000000
    Margins.TopMargin = 13.000000000000000000
    Margins.BottomMargin = 0.000000000000000000
    DataSource = Dm.DtsRel
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    PageSetup.PaperSize = fpLetter
    object RLDetailGrid1: TRLDetailGrid
      Left = 15
      Top = 49
      Width = 763
      Height = 96
      ColCount = 2
      ColSpacing = 8.000000000000000000
      BeforePrint = RLDetailGrid1BeforePrint
      object RlNome: TRLLabel
        Left = 8
        Top = 9
        Width = 39
        Height = 14
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object RlEndNumComp: TRLLabel
        Left = 8
        Top = 23
        Width = 78
        Height = 14
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object RlBaiMuni: TRLLabel
        Left = 8
        Top = 37
        Width = 47
        Height = 14
        Caption = 'RlBaiMun'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object RlUfCep: TRLLabel
        Left = 8
        Top = 51
        Width = 42
        Height = 14
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object RlHPO: TRLLabel
        Left = 312
        Top = 9
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'HPO-1000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
    end
  end
end
