object FrRelFaturamentoEtica: TFrRelFaturamentoEtica
  Left = 205
  Top = 173
  Width = 696
  Height = 480
  Caption = 'FrRelFaturamentoEtica'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport
    Left = 8
    Top = 8
    Width = 794
    Height = 1123
    DataSource = Dm.DtsRel
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 120
      BandType = btTitle
      object RLLabel1: TRLLabel
        Left = 238
        Top = 8
        Width = 244
        Height = 23
        Alignment = taCenter
        Caption = 'Relatorio de Faturamento'
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
        Top = 36
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
        Left = 322
        Top = 64
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
      object RlValorUnitario: TRLLabel
        Left = 304
        Top = 92
        Width = 112
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
      Top = 158
      Width = 718
      Height = 22
      object RLBand3: TRLBand
        Left = 0
        Top = 0
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
          Left = 110
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
        object RlValor: TRLLabel
          Left = 307
          Top = 2
          Width = 46
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
    end
    object RLBand5: TRLBand
      Left = 38
      Top = 180
      Width = 718
      Height = 45
      BandType = btSummary
      object RLDraw2: TRLDraw
        Left = 7
        Top = 4
        Width = 698
        Height = 34
      end
      object RLLabel3: TRLLabel
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
      object RLLabel2: TRLLabel
        Left = 205
        Top = 13
        Width = 120
        Height = 16
        Caption = 'Valor a Faturar R$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RlValorFin: TRLDBResult
        Left = 327
        Top = 13
        Width = 45
        Height = 16
        DataSource = Dm.DtsRel
        DisplayMask = ',0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        Info = riSum
        ParentFont = False
      end
      object RLLabel5: TRLLabel
        Left = 111
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
    end
  end
end
