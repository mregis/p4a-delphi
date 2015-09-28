object Form1: TForm1
  Left = 33
  Top = 115
  Width = 755
  Height = 375
  VertScrollBar.Range = 102
  HorzScrollBar.Range = 1249
  Caption = 'Form1'
  Color = clBtnFace
  PixelsPerInch = 96
  TextHeight = 13

  object RLReport1: TRLReport
    Left = 40
    Top = 8
    Width = 1209
    Height = 94
    DataSource = Dm.DtsCgaMakro
    DefaultFilter = RLDraftFilter1
    Font.Color = clBlack
    Font.Height = 11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []

    Margins.LeftMargin = 0.000000000000000000
    Margins.TopMargin = 0.000000000000000000
    Margins.RightMargin = 0.000000000000000000
    Margins.BottomMargin = 0.000000000000000000
    PageSetup.PaperSize = fpCustom
    PageSetup.PaperWidth = 320.000000000000000000
    PageSetup.PaperHeight = 25.000000000000000000
    object RLDetailGrid1: TRLDetailGrid
      Left = 0
      Top = 0
      Width = 1209
      Height = 91
      ColCount = 4
      ColWidth = 80.000000000000000000
      BeforePrint = RLDetailGrid1BeforePrint
      object RLDBText1: TRLDBText
        Left = 24
        Top = 8
        Width = 43
        Height = 16
        DataField = 'mkcod'
        DataSource = Dm.DtsCgaMakro
      end
      object RLDBText2: TRLDBText
        Left = 24
        Top = 24
        Width = 72
        Height = 16
        DataField = 'mkempresa'
        DataSource = Dm.DtsCgaMakro
      end
      object RLDBText3: TRLDBText
        Left = 24
        Top = 56
        Width = 100
        Height = 16
        DataField = 'mkcomplemento'
        DataSource = Dm.DtsCgaMakro
      end
      object RLDBText4: TRLDBText
        Left = 136
        Top = 16
        Width = 70
        Height = 16
        DataSource = Dm.DtsCgaMakro
      end
      object RLDBText5: TRLDBText
        Left = 24
        Top = 40
        Width = 75
        Height = 16
        DataField = 'mkendereco'
        DataSource = Dm.DtsCgaMakro
      end
      object RLDBText6: TRLDBText
        Left = 136
        Top = 64
        Width = 70
        Height = 16
        DataSource = Dm.DtsCgaMakro
      end
      object RLDBText7: TRLDBText
        Left = 224
        Top = 32
        Width = 70
        Height = 16
      end
    end
  end
  object RLDraftFilter1: TRLDraftFilter
    LineDrawMethod = ldGraphicCharset
    FillArtMethod = fmGraphicCharset
    FormSelection = fs132Cols
    TextDecoration = ddCustomized
    TextStyles = []
    CPPSelection = csFixed20CPP
    Left = 5
    Top = 24
  end
end
