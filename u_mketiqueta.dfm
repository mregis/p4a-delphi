object frmmketiqueta: Tfrmmketiqueta
  Left = 35
  Top = 104
  Width = 724
  Height = 473
  HorzScrollBar.Range = 794
  VertScrollBar.Range = 1123
  Caption = 'Impress'#227'o de Etiquetas - Laser'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object Rlmketiqueta: TRLReport
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    DataSource = Dm.DtsCgaMakro
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    AfterPrint = RlmketiquetaAfterPrint
    object RLDetailGrid1: TRLDetailGrid
      Left = 38
      Top = 38
      Width = 718
      Height = 96
      ColCount = 2
      Organization = goInColumns
      object RLSystemInfo1: TRLSystemInfo
        Left = 304
        Top = 8
        Width = 38
        Height = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Info = itRecNo
        ParentFont = False
      end
      object rldbcodigo: TRLDBText
        Left = 24
        Top = 16
        Width = 31
        Height = 12
        DataField = 'mkcod'
        DataSource = Dm.DtsCgaMakro
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object rldbempresa: TRLDBText
        Left = 23
        Top = 35
        Width = 52
        Height = 12
        DataField = 'mkempresa'
        DataSource = Dm.DtsCgaMakro
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object rldbendereco: TRLDBText
        Left = 23
        Top = 53
        Width = 54
        Height = 12
        DataField = 'mkendereco'
        DataSource = Dm.DtsCgaMakro
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object rldbcep: TRLDBText
        Left = 23
        Top = 72
        Width = 31
        Height = 12
        DataField = 'mkcep'
        DataSource = Dm.DtsCgaMakro
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object rldbcomplem: TRLDBText
        Left = 223
        Top = 52
        Width = 72
        Height = 12
        DataField = 'mkcomplemento'
        DataSource = Dm.DtsCgaMakro
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
    end
  end
end
