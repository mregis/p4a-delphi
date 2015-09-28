object FrmRelProtocolos: TFrmRelProtocolos
  Left = 102
  Top = 184
  Width = 865
  Height = 480
  HorzScrollBar.Range = 802
  VertScrollBar.Range = 1131
  Caption = 'FrmRelProtocolos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Relatorio: TRLReport
    Left = 8
    Top = 8
    Width = 794
    Height = 1123
    DataSource = Dm.DtsRel
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    object RLDetailGrid1: TRLDetailGrid
      Left = 38
      Top = 65
      Width = 718
      Height = 28
      BeforePrint = RLDetailGrid1BeforePrint
      object Nome: TRLLabel
        Left = 24
        Top = 6
        Width = 665
        Height = 16
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Endere: TRLLabel
        Left = 24
        Top = 17
        Width = 665
        Height = 16
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 27
      BandType = btHeader
      object RLLabel1: TRLLabel
        Left = 261
        Top = 6
        Width = 153
        Height = 16
        Caption = 'Relat'#243'rio de Protocolos'
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
