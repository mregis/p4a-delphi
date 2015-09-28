object FrmRelSedex: TFrmRelSedex
  Left = 0
  Top = 0
  Caption = 'FrmRelSedex'
  ClientHeight = 266
  ClientWidth = 549
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLSedex: TRLReport
    Left = 0
    Top = 8
    Width = 794
    Height = 1123
    DataSource = Dm.DtsSdx3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 224
      object RLDBBarcode1: TRLDBBarcode
        Left = 3
        Top = 64
        Width = 214
        Height = 34
        Margins.LeftMargin = 1.000000000000000000
        Margins.RightMargin = 1.000000000000000000
        AutoSize = False
        BarcodeType = bcCode39
        DataField = 'sdx_cep'
        DataSource = Dm.DtsSdx3
      end
    end
  end
end
