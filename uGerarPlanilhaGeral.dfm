object fGerarPlanilhaGeral: TfGerarPlanilhaGeral
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Planilha Geral'
  ClientHeight = 112
  ClientWidth = 370
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object group: TGroupBox
    Left = 2
    Top = -3
    Width = 367
    Height = 97
    TabOrder = 0
    object lbldata: TLabel
      Left = 8
      Top = 16
      Width = 127
      Height = 16
      Caption = 'Informar o Per'#237'odo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnGerar: TBitBtn
      Left = 208
      Top = 35
      Width = 149
      Height = 24
      Caption = 'Gerar Planilha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnGerarClick
    end
    object cbdtini: TDateTimePicker
      Left = 8
      Top = 35
      Width = 94
      Height = 22
      Date = 41240.611727731480000000
      Time = 41240.611727731480000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object cbdtfim: TDateTimePicker
      Left = 107
      Top = 35
      Width = 94
      Height = 22
      Date = 0.611727731477003500
      Time = 0.611727731477003500
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object panelBarra: TPanel
      Left = 5
      Top = 17
      Width = 357
      Height = 71
      TabOrder = 0
      Visible = False
      object lblPlanilha: TLabel
        Left = 1
        Top = 4
        Width = 355
        Height = 23
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object ProgressBar: TProgressBar
        Left = 8
        Top = 31
        Width = 342
        Height = 28
        Step = 1
        TabOrder = 0
      end
    end
  end
  object Status: TStatusBar
    Left = 0
    Top = 93
    Width = 370
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object CGA035: TZQuery
    Connection = Dm.Ads
    Params = <>
    Left = 16
    Top = 8
  end
  object CGA036: TZQuery
    Connection = Dm.Ads
    Params = <>
    Left = 24
    Top = 8
  end
  object CGA039: TZQuery
    Connection = Dm.Ads
    Params = <>
    Left = 40
    Top = 8
  end
  object CGA040: TZQuery
    Connection = Dm.Ads
    Params = <>
    Left = 56
    Top = 64
  end
  object CGA038: TZQuery
    Connection = Dm.Ads
    Params = <>
    Left = 56
    Top = 8
  end
  object CGA120: TZQuery
    Connection = Dm.Ads
    Params = <>
    Left = 8
    Top = 64
  end
  object CGA100: TZQuery
    Connection = Dm.Ads
    SQL.Strings = (
      'SELECT'
      '   COALESCE(OM.POSICAO, 0) AS POSICAO, M.*'
      'FROM'
      '   IBI_MOTIVO_DEVOLUCOES M'
      '   LEFT JOIN ORDEM_MOTIVOS OM ON OM.CD_MOTIVO = M.CD_MOTIVO'
      'ORDER BY'
      '   1, M.DS_MOTIVO')
    Params = <>
    Left = 24
    Top = 64
  end
  object CGA044: TZQuery
    Connection = Dm.Ads
    Params = <>
    Left = 40
    Top = 64
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'xls'
    FileName = 'planilha_geral'
    Title = 'Salvar planilha...'
    Left = 224
    Top = 8
  end
  object CGA78: TZQuery
    Connection = Dm.Ads
    Params = <>
    Left = 144
    Top = 64
  end
  object CGA043: TZQuery
    Connection = Dm.Ads
    Params = <>
    Left = 96
    Top = 8
  end
  object CGA042: TZQuery
    Connection = Dm.Ads
    Params = <>
    Left = 120
    Top = 8
  end
  object CGA041: TZQuery
    Connection = Dm.Ads
    Params = <>
    Left = 136
    Top = 8
  end
  object CGA130: TZQuery
    Connection = Dm.Ads
    Params = <>
    Left = 200
    Top = 72
  end
  object CGA69: TZQuery
    Connection = Dm.Ads
    Params = <>
    Left = 184
    Top = 64
  end
  object CGA68: TZQuery
    Connection = Dm.Ads
    Params = <>
    Left = 128
    Top = 64
  end
  object CGA33: TZQuery
    Connection = Dm.Ads
    Params = <>
    Left = 120
    Top = 64
  end
  object CGA75: TZQuery
    Connection = Dm.Ads
    Params = <>
    Left = 112
    Top = 64
  end
end
