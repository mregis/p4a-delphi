object FrmRelCons: TFrmRelCons
  Left = 0
  Top = 0
  Caption = 'FrmRelCons'
  ClientHeight = 400
  ClientWidth = 804
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport
    Left = 32
    Top = 8
    Width = 794
    Height = 1123
    DataSource = Dm.DtsRel
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLGroup1: TRLGroup
      Left = 38
      Top = 54
      Width = 718
      Height = 76
      BeforePrint = RLGroup1BeforePrint
      object RLGroup2: TRLGroup
        Left = 0
        Top = 32
        Width = 718
        Height = 20
        BeforePrint = RLGroup2BeforePrint
        object RLBand1: TRLBand
          Left = 0
          Top = 0
          Width = 718
          Height = 1
          BandType = btHeader
          BeforePrint = RLBand1BeforePrint
          object RLLabel2: TRLLabel
            Left = 268
            Top = 1
            Width = 58
            Height = 16
          end
        end
        object RLBand2: TRLBand
          Left = 0
          Top = 1
          Width = 718
          Height = 17
          BeforePrint = RLBand2BeforePrint
          object RLLabel3: TRLLabel
            Left = 4
            Top = 1
            Width = 57
            Height = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object RLLabel4: TRLLabel
            Left = 229
            Top = 0
            Width = 57
            Height = 15
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object RLLabel5: TRLLabel
            Left = 368
            Top = 1
            Width = 57
            Height = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
        end
        object RLLabel6: TRLLabel
          Left = 80
          Top = -24
          Width = 58
          Height = 16
        end
        object RLLabel7: TRLLabel
          Left = 296
          Top = -24
          Width = 58
          Height = 16
        end
      end
      object RLBand4: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 32
        BandType = btHeader
        BeforePrint = RLBand4BeforePrint
        object RLLabel8: TRLLabel
          Left = 4
          Top = 18
          Width = 90
          Height = 15
          Caption = 'Tipo de Servi'#231'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel9: TRLLabel
          Left = 256
          Top = 18
          Width = 30
          Height = 15
          Caption = 'Qtde'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel10: TRLLabel
          Left = 368
          Top = 18
          Width = 29
          Height = 15
          Caption = 'Data'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel1: TRLLabel
          Left = 3
          Top = 1
          Width = 56
          Height = 15
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLBand3: TRLBand
        Left = 0
        Top = 52
        Width = 718
        Height = 19
        BandType = btSummary
        object RLDBResult1: TRLDBResult
          Left = 163
          Top = 3
          Width = 125
          Height = 15
          Alignment = taRightJustify
          DataField = 'qtde'
          DataSource = Dm.DtsRel
          DisplayMask = '###.###.###'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'ADMUI3Lg'
          Font.Style = [fsBold]
          Info = riSum
          ParentFont = False
          ResetAfterPrint = True
          Text = 'Sub-Total: '
        end
        object RLDraw1: TRLDraw
          Left = 0
          Top = 15
          Width = 718
          Height = 1
          DrawKind = dkLine
          Pen.Style = psDot
        end
      end
    end
    object RLBand5: TRLBand
      Left = 38
      Top = 130
      Width = 718
      Height = 21
      BandType = btSummary
      object RLDBResult2: TRLDBResult
        Left = 187
        Top = 3
        Width = 99
        Height = 15
        Alignment = taRightJustify
        DataField = 'qtde'
        DataSource = Dm.DtsRel
        DisplayMask = '##.###.###.###'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Info = riSum
        ParentFont = False
        Text = 'Total: '
      end
    end
    object RLBand6: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 16
      BandType = btHeader
      AfterPrint = RLBand6AfterPrint
      BeforePrint = RLBand6BeforePrint
      object RLLabel11: TRLLabel
        Left = 3
        Top = 1
        Width = 136
        Height = 15
        Caption = 'Produ'#231#227'o Ref. Per'#237'odo: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object RLReport2: TRLReport
    Left = 32
    Top = 178
    Width = 794
    Height = 1123
    DataSource = Dm.DtsRel
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLBand11: TRLBand
      Left = 38
      Top = 92
      Width = 718
      Height = 18
      BandType = btSummary
      object RLDBResult3: TRLDBResult
        Left = 165
        Top = 2
        Width = 123
        Height = 15
        Alignment = taRightJustify
        DataField = 'qtde'
        DataSource = Dm.DtsRel
        DisplayMask = '##.###.###'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Info = riSum
        ParentFont = False
        Text = 'Total: ==> '
      end
    end
    object RLBand9: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 33
      BandType = btHeader
      BeforePrint = RLBand9BeforePrint
      object RLLabel18: TRLLabel
        Left = 3
        Top = 15
        Width = 46
        Height = 15
        Caption = 'Servi'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel19: TRLLabel
        Left = 256
        Top = 15
        Width = 30
        Height = 15
        Caption = 'Qtde'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel21: TRLLabel
        Left = 3
        Top = 1
        Width = 136
        Height = 15
        Caption = 'Produ'#231#227'o Ref. Per'#237'odo: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw2: TRLDraw
        Left = 0
        Top = 30
        Width = 718
        Height = 1
        DrawKind = dkLine
        Pen.Style = psDot
      end
      object RLDraw3: TRLDraw
        Left = 0
        Top = 36
        Width = 718
        Height = 1
        DrawKind = dkLine
        Pen.Style = psDot
      end
    end
    object RLBand8: TRLBand
      Left = 38
      Top = 71
      Width = 718
      Height = 21
      object RLDBText1: TRLDBText
        Left = 5
        Top = 1
        Width = 44
        Height = 16
        DataField = 'servico'
        DataSource = Dm.DtsRel
      end
      object RLDBText2: TRLDBText
        Left = 256
        Top = 1
        Width = 29
        Height = 16
        Alignment = taRightJustify
        DataField = 'qtde'
        DataSource = Dm.DtsRel
      end
      object RLDraw4: TRLDraw
        Left = 0
        Top = 17
        Width = 718
        Height = 5
        DrawKind = dkLine
        Pen.Style = psDot
      end
    end
  end
end
