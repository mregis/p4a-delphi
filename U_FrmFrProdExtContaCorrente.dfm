object FrmFrProdExtContaCorrente: TFrmFrProdExtContaCorrente
  Left = 1
  Top = 92
  Width = 812
  Height = 495
  HorzScrollBar.Range = 794
  VertScrollBar.Range = 1139
  Caption = 'FrmFrProdExtContaCorrente'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport
    Left = 0
    Top = 24
    Width = 794
    Height = 1123
    DataSource = Dm.DtsRel
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 95
      BandType = btTitle
      object RLLabel1: TRLLabel
        Left = 251
        Top = 8
        Width = 216
        Height = 23
        Alignment = taCenter
        Caption = 'Relat'#243'rio de Produ'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object RlTipoRelat: TRLLabel
        Left = 313
        Top = 37
        Width = 94
        Height = 19
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RlPeriodo: TRLLabel
        Left = 321
        Top = 67
        Width = 76
        Height = 18
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLGroup1: TRLGroup
      Left = 38
      Top = 133
      Width = 718
      Height = 93
      BeforePrint = RLGroup1BeforePrint
      object RLBand2: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 43
        BandType = btHeader
        object RLDraw1: TRLDraw
          Left = 7
          Top = 3
          Width = 698
          Height = 34
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
        end
        object RlBaixa: TRLLabel
          Left = 16
          Top = 12
          Width = 54
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLBand3: TRLBand
        Left = 0
        Top = 43
        Width = 718
        Height = 20
        BeforePrint = RLBand3BeforePrint
        object Rldata: TRLLabel
          Left = 20
          Top = 2
          Width = 41
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Rlqt: TRLLabel
          Left = 174
          Top = 2
          Width = 27
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object RlRetorno: TRLLabel
          Left = 279
          Top = 2
          Width = 61
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object RlEnvio: TRLLabel
          Left = 456
          Top = 2
          Width = 47
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
      end
      object RLBand4: TRLBand
        Left = 0
        Top = 63
        Width = 718
        Height = 26
        BandType = btSummary
        AfterPrint = RLBand4AfterPrint
        object RLLabel2: TRLLabel
          Left = 7
          Top = 6
          Width = 61
          Height = 16
          Caption = 'SubTotal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel4: TRLLabel
          Left = 96
          Top = 5
          Width = 11
          Height = 16
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    object RLBand5: TRLBand
      Left = 38
      Top = 226
      Width = 718
      Height = 72
      BandType = btSummary
      BeforePrint = RLBand5BeforePrint
      object RLMemRet: TRLMemo
        Left = 7
        Top = 46
        Width = 699
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object RLDraw2: TRLDraw
        Left = 7
        Top = 4
        Width = 698
        Height = 34
      end
      object RLLabel3: TRLLabel
        Left = 15
        Top = 13
        Width = 156
        Height = 16
        Caption = 'Resumo de Trasmiss'#245'es'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLBand6: TRLBand
      Left = 38
      Top = 298
      Width = 718
      Height = 111
      BandType = btSummary
      BeforePrint = RLBand6BeforePrint
      object RLDraw3: TRLDraw
        Left = 7
        Top = 4
        Width = 698
        Height = 34
      end
      object RLLabel6: TRLLabel
        Left = 15
        Top = 13
        Width = 75
        Height = 16
        Caption = 'Total Geral'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel5: TRLLabel
        Left = 96
        Top = 13
        Width = 11
        Height = 16
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLMemo1: TRLMemo
        Left = 15
        Top = 61
        Width = 524
        Height = 16
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
    end
    object RLBand7: TRLBand
      Left = 38
      Top = 409
      Width = 718
      Height = 22
      BandType = btFooter
      BeforePrint = RLBand7BeforePrint
      object RLLabel7: TRLLabel
        Left = 3
        Top = 8
        Width = 34
        Height = 10
      end
    end
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport(Open Source) v3.24(BETA10) \251 Copyright '#169' 1999-20' +
      '06 Fortes Inform'#225'tica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    Left = 696
    Top = 8
  end
end
