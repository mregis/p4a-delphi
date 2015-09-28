object FrmRelArSedexLista: TFrmRelArSedexLista
  Left = 235
  Top = 140
  Caption = 'FrmRelArSedexLista'
  ClientHeight = 453
  ClientWidth = 994
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport
    Left = 0
    Top = 8
    Width = 1123
    Height = 794
    DataSource = Dm.DtsSdx2
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    NextReport = FrmRlTotalRa.RLRTotalRa
    PageSetup.Orientation = poLandscape
    PageSetup.ForceEmulation = True
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 1047
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
        Left = 662
        Top = 102
        Width = 21
        Height = 15
        Caption = '01'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object ltotfol: TRLLabel
        Left = 493
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
        Left = 963
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
      object RLLabel3: TRLLabel
        Left = 99
        Top = 147
        Width = 70
        Height = 15
        Caption = 'BRADESCO '
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
        Left = 485
        Top = 147
        Width = 245
        Height = 15
        Caption = '4312 BDN- INTERNET CX POSTAL 66012'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel7: TRLLabel
        Left = 736
        Top = 147
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
        Left = 778
        Top = 147
        Width = 77
        Height = 15
        Caption = '05311-970 '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel9: TRLLabel
        Left = 8
        Top = 188
        Width = 91
        Height = 16
        Caption = 'DESTINAT'#193'RIO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel10: TRLLabel
        Left = 396
        Top = 188
        Width = 54
        Height = 16
        AutoSize = False
        Caption = 'CIDADE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel11: TRLLabel
        Left = 663
        Top = 188
        Width = 28
        Height = 16
        Caption = 'UF '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel12: TRLLabel
        Left = 703
        Top = 188
        Width = 36
        Height = 16
        AutoSize = False
        Caption = 'TIPO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel13: TRLLabel
        Left = 760
        Top = 188
        Width = 55
        Height = 16
        AutoSize = False
        Caption = 'ORDEM'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel14: TRLLabel
        Left = 850
        Top = 188
        Width = 49
        Height = 16
        Caption = 'OBJETO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
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
        Width = 70
        Height = 15
        Caption = '7262500-7'
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
        Width = 35
        Height = 15
        Caption = 'PESO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel21: TRLLabel
        Left = 468
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
        Left = 662
        Top = 66
        Width = 21
        Height = 15
        Caption = 'AR'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel25: TRLLabel
        Left = 963
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
        Left = 963
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
        Caption = '120 gramas'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel29: TRLLabel
        Left = 544
        Top = 102
        Width = 112
        Height = 15
        Caption = '9912232238/2009'
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
        Caption = '61215600'
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
      object RLLabel35: TRLLabel
        Left = 662
        Top = 84
        Width = 56
        Height = 15
        Caption = 'DIGITAL'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 402
        Top = 102
        Width = 91
        Height = 15
        Alignment = taRightJustify
        Info = itPageNumber
        Layout = tlJustify
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 507
        Top = 102
        Width = 119
        Height = 15
        Info = itLastPageNumber
        Layout = tlJustify
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 243
      Width = 1047
      Height = 32
      AfterPrint = RLBand2AfterPrint
      BeforePrint = RLBand2BeforePrint
      object RLDBText1: TRLDBText
        Left = 8
        Top = 2
        Width = 383
        Height = 15
        AutoSize = False
        DataField = 'sdx_nomdest'
        DataSource = Dm.DtsSdx2
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLDBText2: TRLDBText
        Left = 9
        Top = 17
        Width = 381
        Height = 16
        AutoSize = False
        DataField = 'sdx_endedest'
        DataSource = Dm.DtsSdx2
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLDBText3: TRLDBText
        Left = 398
        Top = 2
        Width = 259
        Height = 15
        AutoSize = False
        DataField = 'sdx_cidade'
        DataSource = Dm.DtsSdx2
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLDBText4: TRLDBText
        Left = 663
        Top = 3
        Width = 24
        Height = 15
        AutoSize = False
        DataField = 'sdx_uf'
        DataSource = Dm.DtsSdx2
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLDBText5: TRLDBText
        Left = 703
        Top = 2
        Width = 44
        Height = 15
        AutoSize = False
        DataField = 'sdx_paisorigem'
        DataSource = Dm.DtsSdx2
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object RLDBText7: TRLDBText
        Left = 851
        Top = 2
        Width = 95
        Height = 16
        AutoSize = False
        DataField = 'sdx_numobj5'
        DataSource = Dm.DtsSdx2
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLDBText8: TRLDBText
        Left = 964
        Top = 0
        Width = 80
        Height = 15
        AutoSize = False
        DataField = 'sdx_cep'
        DataSource = Dm.DtsSdx2
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object ordem: TRLLabel
        Left = 760
        Top = 1
        Width = 42
        Height = 15
      end
      object RLLabel42: TRLLabel
        Left = 703
        Top = 3
        Width = 44
        Height = 15
        AutoSize = False
        Caption = 'DB'
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 275
      Width = 1047
      Height = 86
      BandType = btSummary
      object RLLabel22: TRLLabel
        Left = 197
        Top = 8
        Width = 315
        Height = 15
        Caption = 'FAIXA DB INICIAL............................'
      end
      object RLLabel23: TRLLabel
        Left = 197
        Top = 25
        Width = 315
        Height = 15
        Caption = 'FAIXA DB FINAL..............................'
      end
      object RLLabel36: TRLLabel
        Left = 197
        Top = 43
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
        Top = 3
        Width = 70
        Height = 15
      end
      object RLLabel40: TRLLabel
        Left = 390
        Top = 20
        Width = 70
        Height = 15
      end
      object RLLabel41: TRLLabel
        Left = 390
        Top = 37
        Width = 70
        Height = 15
      end
    end
  end
end
