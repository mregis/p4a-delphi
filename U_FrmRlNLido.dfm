object FrmRlNLido: TFrmRlNLido
  Left = 0
  Top = 0
  Caption = 'FrmRlNLido'
  ClientHeight = 388
  ClientWidth = 541
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
    Left = 8
    Top = 24
    Width = 794
    Height = 1123
    DataSource = Dm.DtSTotNLido
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    object RLGroup1: TRLGroup
      Left = 38
      Top = 69
      Width = 718
      Height = 40
      DataFields = 'Data'
      object RLBand2: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 16
        BandType = btColumnHeader
        object RLDBText1: TRLDBText
          Left = 3
          Top = 0
          Width = 29
          Height = 15
          DataField = 'Data'
          DataSource = Dm.DtSqlAux2
          DisplayMask = 'dd/mm/yyyy'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel3: TRLLabel
          Left = 236
          Top = 0
          Width = 30
          Height = 15
          Alignment = taRightJustify
          Caption = 'Qtde'
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
        Top = 16
        Width = 718
        Height = 20
        object RLDBText2: TRLDBText
          Left = 3
          Top = 0
          Width = 43
          Height = 15
          DataField = 'Servi'#231'o'
          DataSource = Dm.DtSqlAux2
        end
        object RLDBText3: TRLDBText
          Left = 237
          Top = 0
          Width = 29
          Height = 15
          Alignment = taRightJustify
          DataField = 'Qtde'
          DataSource = Dm.DtSqlAux2
        end
      end
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 31
      BandType = btTitle
      BeforePrint = RLBand1BeforePrint
      object RLLabel1: TRLLabel
        Left = 3
        Top = 0
        Width = 112
        Height = 15
        Caption = 'Servi'#231'os N'#227'o Lidos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel2: TRLLabel
        Left = 3
        Top = 15
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
  end
end
