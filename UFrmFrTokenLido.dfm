object FrmRlTokenLidos: TFrmRlTokenLidos
  Left = 0
  Top = 0
  Caption = 'FrmRlTokenLidos'
  ClientHeight = 397
  ClientWidth = 582
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
    Left = 24
    Top = 8
    Width = 794
    Height = 1123
    DataSource = Dm.DtSTokenLido
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLGroup1: TRLGroup
      Left = 38
      Top = 38
      Width = 718
      Height = 159
      DataFields = 'Caixa;Lido'
      object RLBand1: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 41
        BandType = btHeader
        object RLLabel1: TRLLabel
          Left = 2
          Top = 2
          Width = 177
          Height = 22
          Caption = 'ADS - Token Lidos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel2: TRLLabel
          Left = 3
          Top = 24
          Width = 41
          Height = 16
          Caption = 'Caixa:'
        end
        object RLDBText1: TRLDBText
          Left = 44
          Top = 24
          Width = 221
          Height = 16
          AutoSize = False
          DataField = 'Caixa'
          DataSource = Dm.DtSTokenLido
        end
        object RLLabel3: TRLLabel
          Left = 285
          Top = 24
          Width = 39
          Height = 16
          Caption = 'Data: '
        end
        object RLDBText2: TRLDBText
          Left = 324
          Top = 24
          Width = 28
          Height = 16
          DataField = 'Lido'
          DataSource = Dm.DtSTokenLido
        end
      end
      object RLGroup2: TRLGroup
        Left = 0
        Top = 41
        Width = 718
        Height = 80
        DataFields = 'Caixa;Lido;Usu'#225'rio'
        object RLBand2: TRLBand
          Left = 0
          Top = 0
          Width = 718
          Height = 37
          BandType = btHeader
          object RLLabel4: TRLLabel
            Left = 4
            Top = 4
            Width = 56
            Height = 16
            Caption = 'Usu'#225'rio: '
          end
          object RLDBText3: TRLDBText
            Left = 60
            Top = 4
            Width = 48
            Height = 16
            DataField = 'Usu'#225'rio'
            DataSource = Dm.DtSTokenLido
          end
          object RLLabel5: TRLLabel
            Left = 60
            Top = 19
            Width = 74
            Height = 16
            Caption = 'Token Lidos'
          end
          object RLDraw1: TRLDraw
            Left = 61
            Top = 34
            Width = 241
            Height = 1
            DrawKind = dkLine
            Pen.Style = psDot
          end
        end
        object RLBand3: TRLBand
          Left = 0
          Top = 37
          Width = 718
          Height = 19
          object RLDraw2: TRLDraw
            Left = 58
            Top = 16
            Width = 241
            Height = 1
            DrawKind = dkLine
            Pen.Style = psDot
          end
          object RLDBText4: TRLDBText
            Left = 61
            Top = 1
            Width = 39
            Height = 16
            DataField = 'Token'
            DataSource = Dm.DtSTokenLido
          end
        end
        object RLBand4: TRLBand
          Left = 0
          Top = 56
          Width = 718
          Height = 20
          BandType = btSummary
          object RLLabel6: TRLLabel
            Left = 4
            Top = 1
            Width = 44
            Height = 16
            Caption = 'Total : '
          end
          object RLDBResult1: TRLDBResult
            Left = 62
            Top = 1
            Width = 46
            Height = 16
            DataField = 'Token'
            DataSource = Dm.DtSTokenLido
            Info = riCount
          end
        end
      end
      object RLBand5: TRLBand
        Left = 0
        Top = 121
        Width = 718
        Height = 21
        BandType = btSummary
        object RLLabel7: TRLLabel
          Left = 4
          Top = 0
          Width = 75
          Height = 16
          Caption = 'Total Geral: '
        end
        object RLDBResult2: TRLDBResult
          Left = 77
          Top = 0
          Width = 46
          Height = 16
          DataField = 'Token'
          DataSource = Dm.DtSTokenLido
          Info = riCount
        end
      end
      object RLBand6: TRLBand
        Left = 0
        Top = 142
        Width = 718
        Height = 16
        BandType = btFooter
      end
    end
  end
end
