object FrmRlErroBxaArSdx: TFrmRlErroBxaArSdx
  Left = 0
  Top = 0
  Caption = 'FrmRlErroBxaArSdx'
  ClientHeight = 266
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLErroBxaArSdx: TRLReport
    Left = -16
    Top = 48
    Width = 1123
    Height = 794
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    PageSetup.Orientation = poLandscape
    OnNeedData = RLErroBxaArSdxNeedData
    object DetLin: TRLBand
      Left = 38
      Top = 38
      Width = 1047
      Height = 20
      object RLLin: TRLLabel
        Left = 4
        Top = 1
        Width = 42
        Height = 15
      end
    end
  end
end
