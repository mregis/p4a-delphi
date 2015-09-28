object FrFrmImpEtiqueta: TFrFrmImpEtiqueta
  Left = 158
  Top = -10
  Width = 328
  Height = 314
  HorzScrollBar.Range = 319
  VertScrollBar.Range = 151
  Caption = 'FrFrmImpEtiqueta'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport
    Left = 2
    Top = 0
    Width = 317
    Height = 151
    Margins.LeftMargin = 0.000000000000000000
    Margins.TopMargin = 0.000000000000000000
    Margins.RightMargin = 0.000000000000000000
    Margins.BottomMargin = 0.000000000000000000
    DataSource = Dm.DtsCga44
    DefaultFilter = RLDraftFilter1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    PageSetup.PaperSize = fpCustom
    PageSetup.Orientation = poLandscape
    PageSetup.PaperWidth = 40.000000000000000000
    PageSetup.PaperHeight = 84.000000000000000000
    PageSetup.ForceEmulation = True
    object RLDetailGrid1: TRLDetailGrid
      Left = 0
      Top = 0
      Width = 317
      Height = 89
      ColCount = 4
      ColSpacing = 60.000000000000000000
      ColWidth = 84.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 11
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      InsideMargins.LeftMargin = 2.000000000000000000
      InsideMargins.TopMargin = 3.000000000000000000
      ParentFont = False
      BeforePrint = RLDetailGrid1BeforePrint
      object RLDBText1: TRLDBText
        Left = 7
        Top = 10
        Width = 70
        Height = 15
        DataField = 'cg40_nome'
        DataSource = Dm.DtsCga44
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object RLDBText3: TRLDBText
        Left = 7
        Top = 47
        Width = 84
        Height = 15
        DataField = 'cg40_bairro'
        DataSource = Dm.DtsCga44
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object RLDBText4: TRLDBText
        Left = 7
        Top = 65
        Width = 63
        Height = 15
        DataField = 'cg40_cep'
        DataSource = Dm.DtsCga44
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object RLDBText5: TRLDBText
        Left = 206
        Top = 65
        Width = 70
        Height = 15
        DataField = 'cg40_nsuc'
        DataSource = Dm.DtsCga44
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object RLDBText6: TRLDBText
        Left = 176
        Top = 46
        Width = 63
        Height = 15
        DataField = 'cg40_cid'
        DataSource = Dm.DtsCga44
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object RLDBText7: TRLDBText
        Left = 84
        Top = 65
        Width = 56
        Height = 15
        DataField = 'cg40_uf'
        DataSource = Dm.DtsCga44
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object RLEnd: TRLLabel
        Left = 8
        Top = 28
        Width = 42
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object RLDraftFilter1: TRLDraftFilter
    FontSizeReal = False
    EjectMethod = ejLeavePage
    FormSelection = fs80Cols
    Left = 288
  end
end
