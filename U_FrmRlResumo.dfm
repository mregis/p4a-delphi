object FrmRlResumo: TFrmRlResumo
  Left = 0
  Top = 0
  Caption = 'Form'
  ClientHeight = 382
  ClientWidth = 982
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
    Left = -125
    Top = 0
    Width = 1123
    Height = 794
    Margins.LeftMargin = 5.000000000000000000
    Margins.RightMargin = 7.000000000000000000
    DataSource = Dm.DtSResumo
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    PageSetup.Orientation = poLandscape
    object RLBand1: TRLBand
      Left = 19
      Top = 38
      Width = 1078
      Height = 57
      BandType = btTitle
      object RLLabel1: TRLLabel
        Left = 5
        Top = 0
        Width = 378
        Height = 23
        Caption = 'Resumo Produ'#231#227'o de Leitura Extratos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial Black'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw2: TRLDraw
        Left = 0
        Top = 37
        Width = 1078
        Height = 20
      end
      object RLLabel2: TRLLabel
        Left = 2
        Top = 39
        Width = 104
        Height = 14
        AutoSize = False
        Caption = 'Motivo da Devolu'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw3: TRLDraw
        Left = 233
        Top = 37
        Width = 1
        Height = 20
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw4: TRLDraw
        Left = 171
        Top = 37
        Width = 1
        Height = 20
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw5: TRLDraw
        Left = 295
        Top = 37
        Width = 1
        Height = 20
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw6: TRLDraw
        Left = 356
        Top = 37
        Width = 1
        Height = 20
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw7: TRLDraw
        Left = 481
        Top = 37
        Width = 1
        Height = 20
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw8: TRLDraw
        Left = 543
        Top = 37
        Width = 1
        Height = 20
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw9: TRLDraw
        Left = 618
        Top = 37
        Width = 1
        Height = 20
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw10: TRLDraw
        Left = 700
        Top = 37
        Width = 1
        Height = 20
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw11: TRLDraw
        Left = 771
        Top = 37
        Width = 1
        Height = 20
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw12: TRLDraw
        Left = 833
        Top = 37
        Width = 1
        Height = 20
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw13: TRLDraw
        Left = 903
        Top = 37
        Width = 1
        Height = 20
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw14: TRLDraw
        Left = 1017
        Top = 37
        Width = 1
        Height = 20
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw44: TRLDraw
        Left = 109
        Top = 37
        Width = 1
        Height = 20
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLLabel4: TRLLabel
        Left = 114
        Top = 41
        Width = 54
        Height = 12
        Caption = 'Consolidado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel5: TRLLabel
        Left = 172
        Top = 41
        Width = 48
        Height = 12
        AutoSize = False
        Caption = 'Unificado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel6: TRLLabel
        Left = 244
        Top = 41
        Width = 29
        Height = 12
        AutoSize = False
        Caption = 'CCP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel7: TRLLabel
        Left = 304
        Top = 41
        Width = 28
        Height = 12
        AutoSize = False
        Caption = 'CVM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel8: TRLLabel
        Left = 360
        Top = 39
        Width = 46
        Height = 14
        Caption = 'TanCode'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel9: TRLLabel
        Left = 485
        Top = 41
        Width = 47
        Height = 12
        Caption = 'DRC Cobr'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel10: TRLLabel
        Left = 546
        Top = 41
        Width = 70
        Height = 12
        Caption = 'DRC C.Convite'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel11: TRLLabel
        Left = 622
        Top = 41
        Width = 74
        Height = 12
        Caption = 'DRC-Aviso Cobr'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel12: TRLLabel
        Left = 704
        Top = 39
        Width = 63
        Height = 14
        Caption = 'Fat. C. Cred.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel14: TRLLabel
        Left = 775
        Top = 38
        Width = 54
        Height = 14
        Caption = 'Token Entr'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel15: TRLLabel
        Left = 906
        Top = 39
        Width = 54
        Height = 14
        Caption = 'Bco Postal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel16: TRLLabel
        Left = 1039
        Top = 39
        Width = 36
        Height = 14
        Caption = 'Outros'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel13: TRLLabel
        Left = 837
        Top = 39
        Width = 62
        Height = 14
        Caption = 'Token Saida'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel31: TRLLabel
        Left = 4
        Top = 22
        Width = 64
        Height = 15
      end
      object RLDraw102: TRLDraw
        Left = 419
        Top = 37
        Width = 1
        Height = 20
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLLabel63: TRLLabel
        Left = 423
        Top = 41
        Width = 56
        Height = 12
        AutoSize = False
        Caption = 'Carta Senha'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw92: TRLDraw
        Left = 963
        Top = 38
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLLabel64: TRLLabel
        Left = 966
        Top = 39
        Width = 50
        Height = 14
        AutoSize = False
        Caption = 'R.E.Cons.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
    object RLBand2: TRLBand
      Left = 19
      Top = 95
      Width = 1078
      Height = 21
      object RLDraw1: TRLDraw
        Left = 0
        Top = 20
        Width = 1078
        Height = 1
        DrawData.Strings = (
          '0 0'
          '1 0')
        DrawKind = dkCustom
      end
      object RLDraw15: TRLDraw
        Left = 0
        Top = 0
        Width = 1
        Height = 20
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw16: TRLDraw
        Left = 171
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw17: TRLDraw
        Left = 233
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw18: TRLDraw
        Left = 295
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw19: TRLDraw
        Left = 356
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw20: TRLDraw
        Left = 481
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw21: TRLDraw
        Left = 543
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw22: TRLDraw
        Left = 618
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw23: TRLDraw
        Left = 700
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw24: TRLDraw
        Left = 771
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw25: TRLDraw
        Left = 833
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw26: TRLDraw
        Left = 903
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw27: TRLDraw
        Left = 1017
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw28: TRLDraw
        Left = 1077
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDBText1: TRLDBText
        Left = 3
        Top = 2
        Width = 34
        Height = 14
        DataField = 'motivo'
        DataSource = Dm.DtSResumo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDBText2: TRLDBText
        Left = 113
        Top = 3
        Width = 50
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_03'
        DataSource = Dm.DtSResumo
      end
      object RLDBText3: TRLDBText
        Left = 175
        Top = 2
        Width = 50
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_02'
        DataSource = Dm.DtSResumo
      end
      object RLDBText4: TRLDBText
        Left = 237
        Top = 2
        Width = 50
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_01'
        DataSource = Dm.DtSResumo
      end
      object RLDBText5: TRLDBText
        Left = 298
        Top = 1
        Width = 50
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_12'
        DataSource = Dm.DtSResumo
      end
      object RLDBText6: TRLDBText
        Left = 360
        Top = 1
        Width = 50
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_09'
        DataSource = Dm.DtSResumo
      end
      object RLDBText7: TRLDBText
        Left = 485
        Top = 2
        Width = 50
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_07'
        DataSource = Dm.DtSResumo
      end
      object RLDBText8: TRLDBText
        Left = 566
        Top = 2
        Width = 50
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_08'
        DataSource = Dm.DtSResumo
      end
      object RLDBText9: TRLDBText
        Left = 647
        Top = 0
        Width = 50
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_06'
        DataSource = Dm.DtSResumo
      end
      object RLDBText10: TRLDBText
        Left = 715
        Top = 1
        Width = 50
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_13'
        DataSource = Dm.DtSResumo
      end
      object RLDBText11: TRLDBText
        Left = 779
        Top = 2
        Width = 50
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_04'
        DataSource = Dm.DtSResumo
      end
      object RLDBText12: TRLDBText
        Left = 849
        Top = 2
        Width = 50
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_05'
        DataSource = Dm.DtSResumo
      end
      object RLDBText13: TRLDBText
        Left = 910
        Top = 2
        Width = 50
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_11'
        DataSource = Dm.DtSResumo
      end
      object RLDraw45: TRLDraw
        Left = 109
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDBText14: TRLDBText
        Left = 1024
        Top = 2
        Width = 52
        Height = 15
        Alignment = taCenter
        AutoSize = False
        DataField = 'tipo_serv_10'
        DataSource = Dm.DtSResumo
      end
      object RLDraw101: TRLDraw
        Left = 419
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDBText15: TRLDBText
        Left = 424
        Top = 2
        Width = 54
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_14'
        DataSource = Dm.DtSResumo
      end
      object RLDraw103: TRLDraw
        Left = 963
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDBText16: TRLDBText
        Left = 966
        Top = 6
        Width = 50
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_15'
        DataSource = Dm.DtSResumo
      end
    end
    object RLBand3: TRLBand
      Left = 19
      Top = 116
      Width = 1078
      Height = 21
      BandType = btSummary
      object RLDraw29: TRLDraw
        Left = 0
        Top = 20
        Width = 1078
        Height = 1
        DrawData.Strings = (
          '0 0'
          '1 0')
        DrawKind = dkCustom
      end
      object RLDraw30: TRLDraw
        Left = 0
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw31: TRLDraw
        Left = 171
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw32: TRLDraw
        Left = 233
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw33: TRLDraw
        Left = 295
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw34: TRLDraw
        Left = 356
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw35: TRLDraw
        Left = 481
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw36: TRLDraw
        Left = 543
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw37: TRLDraw
        Left = 618
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw38: TRLDraw
        Left = 700
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw39: TRLDraw
        Left = 771
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw40: TRLDraw
        Left = 833
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw41: TRLDraw
        Left = 903
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw42: TRLDraw
        Left = 1017
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw43: TRLDraw
        Left = 1077
        Top = -1
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLLabel3: TRLLabel
        Left = 3
        Top = 4
        Width = 55
        Height = 14
        Caption = 'Total Lidos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw46: TRLDraw
        Left = 109
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDBResult1: TRLDBResult
        Left = 113
        Top = 3
        Width = 55
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_03'
        DataSource = Dm.DtSResumo
        Info = riSum
      end
      object RLDBResult2: TRLDBResult
        Left = 175
        Top = 3
        Width = 55
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_02'
        DataSource = Dm.DtSResumo
        Info = riSum
      end
      object RLDBResult3: TRLDBResult
        Left = 237
        Top = 3
        Width = 55
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_01'
        DataSource = Dm.DtSResumo
        Info = riSum
      end
      object RLDBResult4: TRLDBResult
        Left = 298
        Top = 3
        Width = 55
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_12'
        DataSource = Dm.DtSResumo
        Info = riSum
      end
      object RLDBResult5: TRLDBResult
        Left = 360
        Top = 3
        Width = 55
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_09'
        DataSource = Dm.DtSResumo
        Info = riSum
      end
      object RLDBResult6: TRLDBResult
        Left = 485
        Top = 3
        Width = 55
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_07'
        DataSource = Dm.DtSResumo
        Info = riSum
      end
      object RLDBResult7: TRLDBResult
        Left = 561
        Top = 3
        Width = 55
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_08'
        DataSource = Dm.DtSResumo
        Info = riSum
      end
      object RLDBResult8: TRLDBResult
        Left = 642
        Top = 3
        Width = 55
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_06'
        DataSource = Dm.DtSResumo
        Info = riSum
      end
      object RLDBResult9: TRLDBResult
        Left = 712
        Top = 3
        Width = 55
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_13'
        DataSource = Dm.DtSResumo
        Info = riSum
      end
      object RLDBResult10: TRLDBResult
        Left = 774
        Top = 3
        Width = 55
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_04'
        DataSource = Dm.DtSResumo
        Info = riSum
      end
      object RLDBResult11: TRLDBResult
        Left = 844
        Top = 3
        Width = 55
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_05'
        DataSource = Dm.DtSResumo
        Info = riSum
      end
      object RLDBResult12: TRLDBResult
        Left = 905
        Top = 3
        Width = 55
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_11'
        DataSource = Dm.DtSResumo
        Info = riSum
      end
      object RLDBResult13: TRLDBResult
        Left = 1020
        Top = 3
        Width = 56
        Height = 15
        Alignment = taCenter
        AutoSize = False
        DataField = 'tipo_serv_10'
        DataSource = Dm.DtSResumo
        Info = riSum
      end
      object RLDraw100: TRLDraw
        Left = 419
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDBResult14: TRLDBResult
        Left = 423
        Top = 6
        Width = 55
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_14'
        DataSource = Dm.DtSResumo
        Info = riSum
      end
      object RLDraw104: TRLDraw
        Left = 963
        Top = 0
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDBResult15: TRLDBResult
        Left = 966
        Top = 3
        Width = 50
        Height = 15
        AutoSize = False
        DataField = 'tipo_serv_15'
        DataSource = Dm.DtSResumo
        Info = riSum
      end
    end
    object RLBand4: TRLBand
      Left = 19
      Top = 137
      Width = 1078
      Height = 62
      BandType = btSummary
      BeforePrint = RLBand4BeforePrint
      object RLLabel17: TRLLabel
        Left = 3
        Top = 3
        Width = 106
        Height = 15
        Caption = 'Total Transmitidos'
      end
      object RLLabel18: TRLLabel
        Left = 113
        Top = 3
        Width = 55
        Height = 15
      end
      object RLLabel19: TRLLabel
        Left = 174
        Top = 3
        Width = 55
        Height = 15
      end
      object RLLabel20: TRLLabel
        Left = 237
        Top = 3
        Width = 55
        Height = 15
      end
      object RLLabel21: TRLLabel
        Left = 298
        Top = 3
        Width = 55
        Height = 15
      end
      object RLLabel22: TRLLabel
        Left = 360
        Top = 3
        Width = 55
        Height = 15
      end
      object RLLabel23: TRLLabel
        Left = 485
        Top = 3
        Width = 55
        Height = 15
      end
      object RLLabel24: TRLLabel
        Left = 561
        Top = 3
        Width = 55
        Height = 15
      end
      object RLLabel25: TRLLabel
        Left = 642
        Top = 3
        Width = 55
        Height = 15
      end
      object RLLabel26: TRLLabel
        Left = 712
        Top = 3
        Width = 55
        Height = 15
      end
      object RLLabel27: TRLLabel
        Left = 774
        Top = 3
        Width = 55
        Height = 15
      end
      object RLLabel28: TRLLabel
        Left = 844
        Top = 3
        Width = 55
        Height = 15
      end
      object RLLabel29: TRLLabel
        Left = 905
        Top = 3
        Width = 55
        Height = 15
      end
      object RLLabel30: TRLLabel
        Left = 1020
        Top = 2
        Width = 55
        Height = 15
        Alignment = taCenter
      end
      object RLDraw47: TRLDraw
        Left = 109
        Top = -2
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw48: TRLDraw
        Left = 171
        Top = -2
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw49: TRLDraw
        Left = 233
        Top = -2
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw50: TRLDraw
        Left = 295
        Top = -2
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw51: TRLDraw
        Left = 356
        Top = -2
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw52: TRLDraw
        Left = 481
        Top = -2
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw53: TRLDraw
        Left = 543
        Top = -2
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw54: TRLDraw
        Left = 618
        Top = -2
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw55: TRLDraw
        Left = 700
        Top = -2
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw56: TRLDraw
        Left = 771
        Top = -2
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw57: TRLDraw
        Left = 833
        Top = -2
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw58: TRLDraw
        Left = 903
        Top = -2
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw59: TRLDraw
        Left = 1017
        Top = -2
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw60: TRLDraw
        Left = 1077
        Top = -2
        Width = 1
        Height = 22
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw61: TRLDraw
        Left = 0
        Top = -2
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw62: TRLDraw
        Left = 0
        Top = 18
        Width = 1078
        Height = 1
        DrawData.Strings = (
          '0 0'
          '1 0')
        DrawKind = dkCustom
      end
      object RLLabel32: TRLLabel
        Left = 5
        Top = 21
        Width = 90
        Height = 15
        Caption = 'Total N'#227'o Lidos'
      end
      object RLLabel33: TRLLabel
        Left = 113
        Top = 21
        Width = 55
        Height = 15
      end
      object RLLabel34: TRLLabel
        Left = 175
        Top = 21
        Width = 55
        Height = 15
      end
      object RLLabel35: TRLLabel
        Left = 237
        Top = 21
        Width = 55
        Height = 15
      end
      object RLLabel36: TRLLabel
        Left = 298
        Top = 21
        Width = 55
        Height = 15
      end
      object RLLabel37: TRLLabel
        Left = 359
        Top = 21
        Width = 55
        Height = 15
      end
      object RLLabel38: TRLLabel
        Left = 485
        Top = 21
        Width = 55
        Height = 15
      end
      object RLLabel39: TRLLabel
        Left = 561
        Top = 21
        Width = 55
        Height = 15
      end
      object RLLabel40: TRLLabel
        Left = 642
        Top = 21
        Width = 55
        Height = 15
      end
      object RLLabel41: TRLLabel
        Left = 712
        Top = 21
        Width = 55
        Height = 15
        AutoSize = False
      end
      object RLLabel42: TRLLabel
        Left = 774
        Top = 21
        Width = 55
        Height = 15
        AutoSize = False
      end
      object RLLabel43: TRLLabel
        Left = 844
        Top = 21
        Width = 55
        Height = 15
        AutoSize = False
      end
      object RLLabel44: TRLLabel
        Left = 905
        Top = 21
        Width = 55
        Height = 15
        AutoSize = False
      end
      object RLLabel45: TRLLabel
        Left = 1020
        Top = 24
        Width = 55
        Height = 15
        Alignment = taCenter
        AutoSize = False
      end
      object RLDraw63: TRLDraw
        Left = 0
        Top = 19
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw64: TRLDraw
        Left = 109
        Top = 19
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw65: TRLDraw
        Left = 171
        Top = 19
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw66: TRLDraw
        Left = 233
        Top = 19
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw67: TRLDraw
        Left = 295
        Top = 19
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw68: TRLDraw
        Left = 356
        Top = 19
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw69: TRLDraw
        Left = 481
        Top = 19
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw70: TRLDraw
        Left = 543
        Top = 19
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw71: TRLDraw
        Left = 618
        Top = 19
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw72: TRLDraw
        Left = 700
        Top = 19
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw73: TRLDraw
        Left = 771
        Top = 19
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw74: TRLDraw
        Left = 833
        Top = 19
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw75: TRLDraw
        Left = 903
        Top = 19
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw76: TRLDraw
        Left = 1017
        Top = 19
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw77: TRLDraw
        Left = 1077
        Top = 19
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw78: TRLDraw
        Left = -1
        Top = 39
        Width = 1079
        Height = 1
        DrawData.Strings = (
          '0 0'
          '1 0')
        DrawKind = dkCustom
      end
      object RLLabel46: TRLLabel
        Left = 4
        Top = 42
        Width = 63
        Height = 15
        Caption = 'Total Geral'
      end
      object RLLabel47: TRLLabel
        Left = 114
        Top = 42
        Width = 55
        Height = 15
      end
      object RLLabel48: TRLLabel
        Left = 175
        Top = 42
        Width = 55
        Height = 15
      end
      object RLLabel49: TRLLabel
        Left = 237
        Top = 42
        Width = 55
        Height = 15
      end
      object RLLabel50: TRLLabel
        Left = 298
        Top = 42
        Width = 55
        Height = 15
      end
      object RLLabel51: TRLLabel
        Left = 359
        Top = 42
        Width = 55
        Height = 15
      end
      object RLLabel52: TRLLabel
        Left = 485
        Top = 42
        Width = 55
        Height = 15
      end
      object RLLabel53: TRLLabel
        Left = 561
        Top = 42
        Width = 55
        Height = 15
      end
      object RLLabel54: TRLLabel
        Left = 642
        Top = 42
        Width = 55
        Height = 15
      end
      object RLLabel55: TRLLabel
        Left = 712
        Top = 43
        Width = 55
        Height = 15
        AutoSize = False
      end
      object RLLabel56: TRLLabel
        Left = 774
        Top = 43
        Width = 55
        Height = 15
        AutoSize = False
      end
      object RLLabel57: TRLLabel
        Left = 844
        Top = 43
        Width = 55
        Height = 15
        AutoSize = False
      end
      object RLLabel58: TRLLabel
        Left = 905
        Top = 43
        Width = 55
        Height = 15
        AutoSize = False
      end
      object RLLabel59: TRLLabel
        Left = 1020
        Top = 42
        Width = 55
        Height = 15
        Alignment = taCenter
        AutoSize = False
      end
      object RLDraw79: TRLDraw
        Left = 1077
        Top = 38
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw80: TRLDraw
        Left = 1017
        Top = 38
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw81: TRLDraw
        Left = 903
        Top = 39
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw82: TRLDraw
        Left = 833
        Top = 38
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw83: TRLDraw
        Left = 771
        Top = 38
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw84: TRLDraw
        Left = 700
        Top = 38
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw85: TRLDraw
        Left = 618
        Top = 38
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw86: TRLDraw
        Left = 543
        Top = 38
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw87: TRLDraw
        Left = 481
        Top = 38
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw88: TRLDraw
        Left = 356
        Top = 38
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw89: TRLDraw
        Left = 295
        Top = 38
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw90: TRLDraw
        Left = 233
        Top = 38
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw93: TRLDraw
        Left = 172
        Top = 38
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw94: TRLDraw
        Left = 109
        Top = 38
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw95: TRLDraw
        Left = 0
        Top = 38
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw96: TRLDraw
        Left = -1
        Top = 58
        Width = 1079
        Height = 1
        DrawData.Strings = (
          '0 0'
          '1 0')
        DrawKind = dkCustom
      end
      object RLDraw97: TRLDraw
        Left = 419
        Top = 40
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw98: TRLDraw
        Left = 419
        Top = 17
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw99: TRLDraw
        Left = 419
        Top = -1
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLLabel60: TRLLabel
        Left = 423
        Top = 3
        Width = 55
        Height = 15
      end
      object RLLabel61: TRLLabel
        Left = 423
        Top = 23
        Width = 55
        Height = 15
      end
      object RLLabel62: TRLLabel
        Left = 423
        Top = 41
        Width = 55
        Height = 15
      end
      object RLDraw105: TRLDraw
        Left = 963
        Top = 38
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw106: TRLDraw
        Left = 963
        Top = 17
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLDraw107: TRLDraw
        Left = 963
        Top = -2
        Width = 1
        Height = 21
        DrawData.Strings = (
          '0 0'
          '0 1')
        DrawKind = dkCustom
        HoldStyle = hsVertically
      end
      object RLLabel65: TRLLabel
        Left = 966
        Top = 3
        Width = 50
        Height = 15
      end
      object RLLabel66: TRLLabel
        Left = 966
        Top = 25
        Width = 50
        Height = 15
      end
      object RLLabel67: TRLLabel
        Left = 966
        Top = 43
        Width = 50
        Height = 15
      end
    end
    object RLDraw91: TRLDraw
      Left = 179
      Top = 38
      Width = 1
      Height = 21
      DrawData.Strings = (
        '0 0'
        '0 1')
      DrawKind = dkCustom
      HoldStyle = hsVertically
    end
  end
end
