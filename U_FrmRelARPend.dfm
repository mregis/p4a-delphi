object FrmRelARPend: TFrmRelARPend
  Left = 0
  Top = 0
  Caption = 'FrmRelARPend'
  ClientHeight = 466
  ClientWidth = 690
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLARPend: TRLReport
    Left = 8
    Top = 32
    Width = 794
    Height = 1123
    DataSource = Dm.DtSSdx4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLGrpDtCarga: TRLGroup
      Left = 38
      Top = 56
      Width = 718
      Height = 117
      DataFields = 'sdx_dtcarga'
      object RLGrpDtCarga_SiglaObj: TRLGroup
        Left = 0
        Top = 0
        Width = 718
        Height = 95
        DataFields = 'sdx_dtcarga;sdx_siglaobj'
        PageBreaking = pbBeforePrint
        object RLBand1: TRLBand
          Left = 0
          Top = 0
          Width = 718
          Height = 21
          BandType = btHeader
          object RLLabel1: TRLLabel
            Left = 1
            Top = 3
            Width = 68
            Height = 15
            Caption = 'Movimento: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object RLDBText1: TRLDBText
            Left = 75
            Top = 3
            Width = 70
            Height = 15
            DataField = 'sdx_dtcarga'
            DataSource = Dm.DtSSdx4
            DisplayMask = 'dd/mm/yyyy'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
        end
        object RLBand2: TRLBand
          Left = 0
          Top = 21
          Width = 718
          Height = 33
          BandType = btHeader
          object RLLabel2: TRLLabel
            Left = 1
            Top = 0
            Width = 52
            Height = 15
            Caption = 'Produto: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object RLDBText2: TRLDBText
            Left = 75
            Top = 0
            Width = 73
            Height = 15
            DataField = 'sdx_siglaobj'
            DataSource = Dm.DtSSdx4
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object RLLabel3: TRLLabel
            Left = 1
            Top = 15
            Width = 109
            Height = 16
            AutoSize = False
            Caption = 'Objeto'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object RLLabel4: TRLLabel
            Left = 110
            Top = 15
            Width = 374
            Height = 16
            AutoSize = False
            Caption = 'Destino'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object Envio: TRLLabel
            Left = 491
            Top = 15
            Width = 75
            Height = 16
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object RLDraw1: TRLDraw
            Left = 1
            Top = 30
            Width = 717
            Height = 1
            DrawKind = dkLine
            Pen.Style = psDot
          end
        end
        object RLBand3: TRLBand
          Left = 0
          Top = 54
          Width = 718
          Height = 20
          object RLDBText3: TRLDBText
            Left = 1
            Top = 0
            Width = 108
            Height = 16
            AutoSize = False
            DataField = 'sdx_numobj4'
            DataSource = Dm.DtSSdx4
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object RLDBText4: TRLDBText
            Left = 109
            Top = 0
            Width = 375
            Height = 16
            AutoSize = False
            DataField = 'sdx_nomdest'
            DataSource = Dm.DtSSdx4
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object RLDBText5: TRLDBText
            Left = 491
            Top = 0
            Width = 75
            Height = 16
            AutoSize = False
            DataField = 'sdx_dtenvio'
            DataSource = Dm.DtSSdx4
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object RLDraw2: TRLDraw
            Left = 1
            Top = 17
            Width = 717
            Height = 1
            DrawKind = dkLine
            Pen.Style = psDot
          end
        end
        object RLBand4: TRLBand
          Left = 0
          Top = 74
          Width = 718
          Height = 18
          BandType = btSummary
          object RLLabel5: TRLLabel
            Left = 1
            Top = 0
            Width = 106
            Height = 16
            AutoSize = False
            Caption = 'Total Produto: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object RLDBResult1: TRLDBResult
            Left = 108
            Top = 0
            Width = 56
            Height = 16
            AutoSize = False
            DataField = 'sdx_numseqreg'
            DataSource = Dm.DtSSdx4
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Info = riCount
            ParentFont = False
          end
        end
      end
      object RLBand5: TRLBand
        Left = 0
        Top = 95
        Width = 718
        Height = 19
        BandType = btSummary
        object RLLabel6: TRLLabel
          Left = 1
          Top = 0
          Width = 106
          Height = 16
          AutoSize = False
          Caption = 'Total Movimento: '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object RLDBResult2: TRLDBResult
          Left = 108
          Top = 0
          Width = 56
          Height = 16
          AutoSize = False
          DataField = 'sdx_numseqreg'
          DataSource = Dm.DtSSdx4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Info = riCount
          ParentFont = False
        end
        object RLDraw3: TRLDraw
          Left = 1
          Top = 16
          Width = 717
          Height = 1
          DrawKind = dkLine
          Pen.Style = psDot
        end
      end
    end
    object RLBand6: TRLBand
      Left = 38
      Top = 173
      Width = 718
      Height = 18
      BandType = btSummary
      object RLLabel7: TRLLabel
        Left = 8
        Top = 0
        Width = 106
        Height = 16
        AutoSize = False
        Caption = 'Total Geral: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDBResult3: TRLDBResult
        Left = 108
        Top = 0
        Width = 56
        Height = 16
        AutoSize = False
        DataField = 'sdx_numseqreg'
        DataSource = Dm.DtSSdx4
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Info = riCount
        ParentFont = False
      end
      object RLDraw4: TRLDraw
        Left = 1
        Top = 15
        Width = 717
        Height = 1
        DrawKind = dkLine
        Pen.Style = psDot
      end
    end
    object RLBand7: TRLBand
      Left = 38
      Top = 191
      Width = 718
      Height = 16
      BandType = btFooter
      object RLLabel8: TRLLabel
        Left = 1
        Top = 0
        Width = 30
        Height = 14
        Caption = 'P'#225'g.: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 40
        Top = 0
        Width = 25
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Info = itPageNumber
        ParentFont = False
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 73
        Top = 0
        Width = 35
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Info = itPageNumber
        ParentFont = False
      end
      object RLLabel9: TRLLabel
        Left = 65
        Top = 0
        Width = 8
        Height = 16
        Caption = '/'
      end
    end
    object RLBand8: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 18
      BandType = btHeader
      object RLLabel10: TRLLabel
        Left = 1
        Top = 1
        Width = 158
        Height = 15
        Caption = 'Ar-Pendentes N'#227'o Baixados'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
  end
end
