object FrmRelArSedexListaOl: TFrmRelArSedexListaOl
  Left = 0
  Top = 0
  Caption = 'FrmRelArSedexListaOl'
  ClientHeight = 578
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
    Left = -436
    Top = 32
    Width = 1123
    Height = 794
    Margins.LeftMargin = 5.000000000000000000
    Margins.TopMargin = 5.000000000000000000
    Margins.RightMargin = 5.000000000000000000
    Margins.BottomMargin = 5.000000000000000000
    DataSource = Dm.DtsSdx3
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    PageSetup.Orientation = poLandscape
    PageSetup.ForceEmulation = True
    object RLBand1: TRLBand
      Left = 19
      Top = 19
      Width = 1085
      Height = 205
      BandType = btHeader
      BeforePrint = RLBand1BeforePrint
      object Lista: TRLLabel
        Left = 342
        Top = 18
        Width = 322
        Height = 16
        Caption = 'LISTA DE POSTAGEM - CONTRATO ESPECIAL - SEDEX'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cabsedex: TRLLabel
        Left = 8
        Top = 66
        Width = 56
        Height = 15
        Caption = 'SERVI'#199'O'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Codigo: TRLLabel
        Left = 390
        Top = 66
        Width = 49
        Height = 15
        Caption = 'CART'#195'O'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Numero: TRLLabel
        Left = 544
        Top = 66
        Width = 70
        Height = 15
        Caption = 'N'#218'MERO DO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel1: TRLLabel
        Left = 680
        Top = 102
        Width = 38
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = '01'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object ltotfol: TRLLabel
        Left = 495
        Top = 102
        Width = 14
        Height = 15
        Alignment = taCenter
        Caption = '/'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel4: TRLLabel
        Left = 943
        Top = 102
        Width = 70
        Height = 15
        Caption = '05311-970'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel2: TRLLabel
        Left = 8
        Top = 147
        Width = 84
        Height = 15
        Caption = 'REMETENTE: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel5: TRLLabel
        Left = 396
        Top = 147
        Width = 77
        Height = 15
        Caption = 'ENDERE'#199'O: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel6: TRLLabel
        Left = 98
        Top = 147
        Width = 238
        Height = 15
        Caption = 'ADDRESS LOGISTICA E SERVI'#199'OS LTDA'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel7: TRLLabel
        Left = 597
        Top = 163
        Width = 42
        Height = 15
        Caption = 'CEP: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel8: TRLLabel
        Left = 639
        Top = 163
        Width = 77
        Height = 15
        Caption = '05311-030 '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel9: TRLLabel
        Left = 72
        Top = 187
        Width = 91
        Height = 14
        Caption = 'DESTINAT'#193'RIO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel10: TRLLabel
        Left = 452
        Top = 187
        Width = 54
        Height = 16
        AutoSize = False
        Caption = 'CIDADE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel11: TRLLabel
        Left = 667
        Top = 187
        Width = 28
        Height = 14
        Caption = 'UF '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel12: TRLLabel
        Left = 767
        Top = 187
        Width = 34
        Height = 16
        AutoSize = False
        Caption = 'TIPO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel13: TRLLabel
        Left = 9
        Top = 187
        Width = 55
        Height = 16
        AutoSize = False
        Caption = 'ORDEM'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel14: TRLLabel
        Left = 809
        Top = 187
        Width = 49
        Height = 14
        Caption = 'OBJETO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel15: TRLLabel
        Left = 963
        Top = 206
        Width = 37
        Height = 16
        AutoSize = False
        Caption = 'CEP'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel16: TRLLabel
        Left = 152
        Top = 66
        Width = 21
        Height = 15
        Caption = 'DR'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel17: TRLLabel
        Left = 197
        Top = 66
        Width = 56
        Height = 15
        Caption = 'UNIDADE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel18: TRLLabel
        Left = 197
        Top = 83
        Width = 63
        Height = 15
        Caption = 'POSTAGEM'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel19: TRLLabel
        Left = 197
        Top = 102
        Width = 67
        Height = 15
        AutoSize = False
        Caption = '72618060'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel20: TRLLabel
        Left = 736
        Top = 66
        Width = 36
        Height = 15
        AutoSize = False
        Caption = 'PESO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel21: TRLLabel
        Left = 482
        Top = 66
        Width = 42
        Height = 15
        Caption = 'FOLHA'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel24: TRLLabel
        Left = 680
        Top = 66
        Width = 38
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'COL'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel25: TRLLabel
        Left = 943
        Top = 66
        Width = 28
        Height = 15
        Caption = 'CEP'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel26: TRLLabel
        Left = 943
        Top = 83
        Width = 49
        Height = 15
        Caption = 'ORIGEM'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel27: TRLLabel
        Left = 297
        Top = 66
        Width = 35
        Height = 15
        Caption = 'DATA'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel28: TRLLabel
        Left = 297
        Top = 82
        Width = 63
        Height = 15
        Caption = 'POSTAGEM'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object QTDE: TRLLabel
        Left = 736
        Top = 102
        Width = 77
        Height = 15
        Caption = '240 gramas'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel29: TRLLabel
        Left = 545
        Top = 103
        Width = 81
        Height = 15
        AutoSize = False
        Caption = '9912232238'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel30: TRLLabel
        Left = 544
        Top = 82
        Width = 63
        Height = 15
        Caption = 'CONTRATO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel31: TRLLabel
        Left = 152
        Top = 102
        Width = 21
        Height = 15
        Caption = '72'
      end
      object RLLabel32: TRLLabel
        Left = 390
        Top = 102
        Width = 63
        Height = 15
        Caption = '58552553'
      end
      object RLLabel33: TRLLabel
        Left = 297
        Top = 102
        Width = 70
        Height = 15
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object Label34: TRLLabel
        Left = 8
        Top = 83
        Width = 42
        Height = 15
        Caption = 'SEDEX'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel34: TRLLabel
        Left = 390
        Top = 83
        Width = 63
        Height = 15
        Caption = 'POSTAGEM'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 459
        Top = 102
        Width = 36
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Info = itPageNumber
        Layout = tlJustify
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 509
        Top = 102
        Width = 33
        Height = 15
        AutoSize = False
        Info = itLastPageNumber
        Layout = tlJustify
      end
      object RLLabel43: TRLLabel
        Left = 696
        Top = 187
        Width = 28
        Height = 14
        Caption = 'CEP'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel44: TRLLabel
        Left = 893
        Top = 187
        Width = 35
        Height = 16
        AutoSize = False
        Caption = 'PESO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel45: TRLLabel
        Left = 947
        Top = 187
        Width = 98
        Height = 16
        AutoSize = False
        Caption = 'VL. DECLARADO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel46: TRLLabel
        Left = 479
        Top = 147
        Width = 266
        Height = 15
        Caption = 'R. MERGENTHALER,1177 - VL. LEOPOLDINA'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel3: TRLLabel
        Left = 479
        Top = 163
        Width = 112
        Height = 15
        Caption = 'S'#195'O PAULO -  SP'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel47: TRLLabel
        Left = 829
        Top = 66
        Width = 98
        Height = 15
        AutoSize = False
        Caption = 'VL. DECLARADO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object valdec: TRLLabel
        Left = 829
        Top = 103
        Width = 98
        Height = 15
        AutoSize = False
        Caption = 'Valor Dec'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel35: TRLLabel
        Left = 643
        Top = 65
        Width = 26
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'AR'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel48: TRLLabel
        Left = 643
        Top = 102
        Width = 26
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = '01'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel49: TRLLabel
        Left = 1020
        Top = 66
        Width = 42
        Height = 15
        Caption = 'SIGLA'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLDBText5: TRLDBText
        Left = 1025
        Top = 83
        Width = 20
        Height = 15
        AutoSize = False
        DataField = 'sdx_siglaobj'
        DataSource = Dm.DtsSdx3
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
    end
    object RLBand2: TRLBand
      Left = 19
      Top = 224
      Width = 1085
      Height = 32
      AfterPrint = RLBand2AfterPrint
      BeforePrint = RLBand2BeforePrint
      object RLDBText1: TRLDBText
        Left = 72
        Top = 2
        Width = 373
        Height = 15
        AutoSize = False
        DataField = 'sdx_nomdest'
        DataSource = Dm.DtsSdx3
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLDBText2: TRLDBText
        Left = 73
        Top = 17
        Width = 372
        Height = 16
        AutoSize = False
        DataField = 'sdx_endedest'
        DataSource = Dm.DtsSdx3
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLDBText3: TRLDBText
        Left = 452
        Top = 3
        Width = 208
        Height = 15
        AutoSize = False
        DataField = 'sdx_cidade'
        DataSource = Dm.DtsSdx3
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLDBText4: TRLDBText
        Left = 667
        Top = 3
        Width = 20
        Height = 15
        AutoSize = False
        DataField = 'sdx_uf'
        DataSource = Dm.DtsSdx3
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLDBText7: TRLDBText
        Left = 809
        Top = 2
        Width = 76
        Height = 16
        AutoSize = False
        DataField = 'sdx_numobj'
        DataSource = Dm.DtsSdx3
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLDBText8: TRLDBText
        Left = 696
        Top = 2
        Width = 63
        Height = 15
        AutoSize = False
        DataField = 'sdx_cep'
        DataSource = Dm.DtsSdx3
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object ordem: TRLLabel
        Left = 9
        Top = 6
        Width = 42
        Height = 15
      end
      object RLLabel42: TRLLabel
        Left = 771
        Top = 2
        Width = 23
        Height = 15
        AutoSize = False
        Caption = 'DG'
      end
      object LblPeso: TRLLabel
        Left = 890
        Top = 2
        Width = 52
        Height = 15
        AutoSize = False
      end
      object LblValor: TRLLabel
        Left = 948
        Top = 2
        Width = 97
        Height = 15
        AutoSize = False
      end
      object RLDraw4: TRLDraw
        Left = 0
        Top = 2
        Width = 1047
        Height = 1
        DrawKind = dkLine
        Pen.Style = psDot
      end
    end
    object RLBand3: TRLBand
      Left = 19
      Top = 256
      Width = 1085
      Height = 86
      BandType = btSummary
      object RLLabel22: TRLLabel
        Left = 197
        Top = 6
        Width = 315
        Height = 15
        Caption = 'FAIXA SL INICIAL............................'
      end
      object RLLabel23: TRLLabel
        Left = 197
        Top = 23
        Width = 315
        Height = 15
        Caption = 'FAIXA SL FINAL..............................'
      end
      object RLLabel36: TRLLabel
        Left = 197
        Top = 41
        Width = 315
        Height = 15
        Caption = 'TOTAL DA FAIXA..............................'
      end
      object RLLabel37: TRLLabel
        Left = 197
        Top = 69
        Width = 154
        Height = 15
        Caption = 'assinat. e matric ECT'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel38: TRLLabel
        Left = 489
        Top = 69
        Width = 133
        Height = 15
        Caption = 'assinat. remetente'
      end
      object RLDraw1: TRLDraw
        Left = 197
        Top = 69
        Width = 239
        Height = 1
        DrawKind = dkLine
      end
      object RLDraw2: TRLDraw
        Left = 489
        Top = 69
        Width = 239
        Height = 1
        DrawKind = dkLine
      end
      object RLLabel39: TRLLabel
        Left = 390
        Top = 1
        Width = 70
        Height = 15
      end
      object RLLabel40: TRLLabel
        Left = 390
        Top = 18
        Width = 70
        Height = 15
      end
      object RLLabel41: TRLLabel
        Left = 390
        Top = 35
        Width = 70
        Height = 15
      end
      object RLDraw3: TRLDraw
        Left = 0
        Top = 2
        Width = 1047
        Height = 1
        DrawKind = dkLine
        Pen.Style = psDot
      end
    end
  end
end
