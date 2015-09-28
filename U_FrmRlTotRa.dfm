object FrmRlTotalRa: TFrmRlTotalRa
  Left = 281
  Top = 183
  Caption = 'FrmRlTotalRa'
  ClientHeight = 745
  ClientWidth = 1188
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLRTotalRa: TRLReport
    Left = 32
    Top = 8
    Width = 1123
    Height = 794
    Margins.TopMargin = 6.000000000000000000
    Margins.BottomMargin = 6.000000000000000000
    DataSource = Dm.DtsSdx2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    PageSetup.Orientation = poLandscape
    object RLBand1: TRLBand
      Left = 38
      Top = 23
      Width = 1047
      Height = 748
      BandType = btHeader
      BeforePrint = RLBand1BeforePrint
      object Lista: TRLLabel
        Left = 342
        Top = 3
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
        Top = 24
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
        Left = 394
        Top = 24
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
        Top = 24
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
        Left = 664
        Top = 52
        Width = 28
        Height = 15
        Caption = 'SIM'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object GRAMAS: TRLLabel
        Left = 732
        Top = 52
        Width = 35
        Height = 15
        Caption = '120G'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel2: TRLLabel
        Left = 8
        Top = 76
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
        Left = 98
        Top = 78
        Width = 63
        Height = 15
        Caption = 'BRADESCO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel5: TRLLabel
        Left = 396
        Top = 76
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
        Top = 76
        Width = 133
        Height = 15
        Caption = '4312 BDN- INTERNET'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel7: TRLLabel
        Left = 794
        Top = 24
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
        Left = 795
        Top = 52
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
        Left = 196
        Top = 99
        Width = 182
        Height = 16
        Caption = 'RESUMO DA COLETA DO DIA: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel16: TRLLabel
        Left = 151
        Top = 24
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
        Top = 24
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
        Top = 38
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
        Top = 52
        Width = 63
        Height = 15
        Caption = '72625007'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel21: TRLLabel
        Left = 732
        Top = 24
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
      object RLLabel24: TRLLabel
        Left = 664
        Top = 24
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
      object RLLabel27: TRLLabel
        Left = 297
        Top = 24
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
        Top = 37
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
      object RLLabel29: TRLLabel
        Left = 545
        Top = 52
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
        Top = 37
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
      object RLLabel40: TRLLabel
        Left = 152
        Top = 52
        Width = 21
        Height = 15
        Caption = '72'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel41: TRLLabel
        Left = 394
        Top = 52
        Width = 63
        Height = 15
        Caption = '61215600'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel10: TRLLabel
        Left = 195
        Top = 119
        Width = 77
        Height = 16
        Caption = 'LOCAL - SP'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel11: TRLLabel
        Left = 195
        Top = 135
        Width = 148
        Height = 15
        AutoSize = False
        Caption = 'QUANTIDADE DE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel12: TRLLabel
        Left = 195
        Top = 150
        Width = 210
        Height = 15
        AutoSize = False
        Caption = 'OBJETOS..................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel13: TRLLabel
        Left = 195
        Top = 165
        Width = 98
        Height = 16
        Caption = 'ESTADUAL - SP'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel14: TRLLabel
        Left = 195
        Top = 181
        Width = 145
        Height = 15
        AutoSize = False
        Caption = 'QUANTIDADE DE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel15: TRLLabel
        Left = 195
        Top = 196
        Width = 210
        Height = 15
        AutoSize = False
        Caption = 'OBJETOS..................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel31: TRLLabel
        Left = 195
        Top = 211
        Width = 182
        Height = 16
        Caption = 'Estados RJ, MG, PR e  SC)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel32: TRLLabel
        Left = 195
        Top = 227
        Width = 145
        Height = 15
        AutoSize = False
        Caption = 'QUANTIDADE DE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel33: TRLLabel
        Left = 195
        Top = 242
        Width = 210
        Height = 15
        AutoSize = False
        Caption = 'OBJETOS..................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel34: TRLLabel
        Left = 195
        Top = 257
        Width = 175
        Height = 16
        Caption = '(Estados ES,DF,MS e  RS)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel35: TRLLabel
        Left = 195
        Top = 273
        Width = 146
        Height = 15
        AutoSize = False
        Caption = 'QUANTIDADE DE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel36: TRLLabel
        Left = 195
        Top = 288
        Width = 210
        Height = 15
        AutoSize = False
        Caption = 'OBJETOS..................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel37: TRLLabel
        Left = 195
        Top = 584
        Width = 469
        Height = 15
        Caption = 
          'FOLHAS DE N'#218'MERO................................................' +
          '..'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel38: TRLLabel
        Left = 195
        Top = 600
        Width = 469
        Height = 15
        Caption = 
          'NUMERO SEDEX INICIAL............................................' +
          '..'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel39: TRLLabel
        Left = 195
        Top = 617
        Width = 469
        Height = 15
        Caption = 
          'NUMERO SEDEX FINAL..............................................' +
          '..'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel42: TRLLabel
        Left = 680
        Top = 586
        Width = 363
        Height = 15
        AutoSize = False
        Caption = 'TOTAL....................TOTAL.....................     '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object RLLabel43: TRLLabel
        Left = 491
        Top = 150
        Width = 301
        Height = 15
        AutoSize = False
        Caption = 'EXCLU'#205'DOS.................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel44: TRLLabel
        Left = 491
        Top = 196
        Width = 301
        Height = 15
        AutoSize = False
        Caption = 'EXCLU'#205'DOS.................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel45: TRLLabel
        Left = 491
        Top = 242
        Width = 301
        Height = 15
        AutoSize = False
        Caption = 'EXCLU'#205'DOS.................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel46: TRLLabel
        Left = 491
        Top = 288
        Width = 301
        Height = 15
        AutoSize = False
        Caption = 'EXCLU'#205'DOS.................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel47: TRLLabel
        Left = 792
        Top = 150
        Width = 252
        Height = 15
        AutoSize = False
        Caption = 'COLETADOS..........................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel48: TRLLabel
        Left = 792
        Top = 196
        Width = 252
        Height = 15
        AutoSize = False
        Caption = 'COLETADOS..........................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel49: TRLLabel
        Left = 792
        Top = 242
        Width = 252
        Height = 15
        AutoSize = False
        Caption = 'COLETADOS..........................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel50: TRLLabel
        Left = 792
        Top = 288
        Width = 252
        Height = 15
        AutoSize = False
        Caption = 'COLETADOS..........................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel51: TRLLabel
        Left = 196
        Top = 633
        Width = 469
        Height = 15
        Caption = 
          'TOTAL DA FAIXA..................................................' +
          '..'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel52: TRLLabel
        Left = 194
        Top = 702
        Width = 161
        Height = 15
        AutoSize = False
        Caption = 'assinat. e matric. ECT'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel53: TRLLabel
        Left = 546
        Top = 703
        Width = 133
        Height = 15
        AutoSize = False
        Caption = 'assinat. remetente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel54: TRLLabel
        Left = 297
        Top = 51
        Width = 64
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel55: TRLLabel
        Left = 378
        Top = 99
        Width = 63
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel56: TRLLabel
        Left = 405
        Top = 150
        Width = 64
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel57: TRLLabel
        Left = 405
        Top = 196
        Width = 64
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel58: TRLLabel
        Left = 405
        Top = 242
        Width = 64
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel59: TRLLabel
        Left = 405
        Top = 288
        Width = 64
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel60: TRLLabel
        Left = 8
        Top = 38
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
      object RLLabel61: TRLLabel
        Left = 394
        Top = 38
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
      object RLLabel62: TRLLabel
        Left = 664
        Top = 38
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
      object RLLabel23: TRLLabel
        Left = 487
        Top = 24
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
      object NUM: TRLLabel
        Left = 487
        Top = 52
        Width = 49
        Height = 15
        Caption = '01/001'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel20: TRLLabel
        Left = 795
        Top = 38
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
      object RLLabel67: TRLLabel
        Left = 405
        Top = 380
        Width = 64
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel66: TRLLabel
        Left = 405
        Top = 334
        Width = 64
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel68: TRLLabel
        Left = 405
        Top = 426
        Width = 64
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel69: TRLLabel
        Left = 405
        Top = 472
        Width = 64
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel70: TRLLabel
        Left = 405
        Top = 518
        Width = 64
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel71: TRLLabel
        Left = 405
        Top = 563
        Width = 64
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel72: TRLLabel
        Left = 195
        Top = 303
        Width = 126
        Height = 16
        Caption = '(Estados GO e TO)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel73: TRLLabel
        Left = 195
        Top = 349
        Width = 126
        Height = 16
        Caption = '(Estados BA e MT)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel74: TRLLabel
        Left = 195
        Top = 395
        Width = 112
        Height = 16
        Caption = '(Estados SE,AL)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel75: TRLLabel
        Left = 195
        Top = 441
        Width = 161
        Height = 16
        Caption = '(EstadosPE,PB,PI e RO)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel76: TRLLabel
        Left = 195
        Top = 487
        Width = 231
        Height = 16
        Caption = '(Estados AC,RN,CE,AP,MA,PA e AM)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel77: TRLLabel
        Left = 195
        Top = 533
        Width = 84
        Height = 16
        Caption = '(Estado RR)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel78: TRLLabel
        Left = 195
        Top = 319
        Width = 146
        Height = 15
        AutoSize = False
        Caption = 'QUANTIDADE DE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel79: TRLLabel
        Left = 195
        Top = 365
        Width = 146
        Height = 15
        AutoSize = False
        Caption = 'QUANTIDADE DE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel80: TRLLabel
        Left = 195
        Top = 411
        Width = 146
        Height = 15
        AutoSize = False
        Caption = 'QUANTIDADE DE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel81: TRLLabel
        Left = 195
        Top = 457
        Width = 146
        Height = 15
        AutoSize = False
        Caption = 'QUANTIDADE DE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel82: TRLLabel
        Left = 195
        Top = 503
        Width = 146
        Height = 15
        AutoSize = False
        Caption = 'QUANTIDADE DE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel84: TRLLabel
        Left = 195
        Top = 334
        Width = 210
        Height = 15
        AutoSize = False
        Caption = 'OBJETOS..................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel85: TRLLabel
        Left = 195
        Top = 380
        Width = 210
        Height = 15
        AutoSize = False
        Caption = 'OBJETOS..................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel86: TRLLabel
        Left = 195
        Top = 426
        Width = 210
        Height = 15
        AutoSize = False
        Caption = 'OBJETOS..................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel87: TRLLabel
        Left = 195
        Top = 472
        Width = 210
        Height = 15
        AutoSize = False
        Caption = 'OBJETOS..................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel88: TRLLabel
        Left = 195
        Top = 518
        Width = 210
        Height = 15
        AutoSize = False
        Caption = 'OBJETOS..................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel89: TRLLabel
        Left = 491
        Top = 336
        Width = 301
        Height = 15
        AutoSize = False
        Caption = 'EXCLU'#205'DOS.................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel90: TRLLabel
        Left = 491
        Top = 380
        Width = 301
        Height = 15
        AutoSize = False
        Caption = 'EXCLU'#205'DOS.................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel91: TRLLabel
        Left = 491
        Top = 426
        Width = 301
        Height = 15
        AutoSize = False
        Caption = 'EXCLU'#205'DOS.................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel92: TRLLabel
        Left = 491
        Top = 472
        Width = 301
        Height = 15
        AutoSize = False
        Caption = 'EXCLU'#205'DOS.................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel93: TRLLabel
        Left = 491
        Top = 518
        Width = 301
        Height = 15
        AutoSize = False
        Caption = 'EXCLU'#205'DOS.................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel94: TRLLabel
        Left = 491
        Top = 563
        Width = 301
        Height = 15
        AutoSize = False
        Caption = 'EXCLU'#205'DOS.................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel95: TRLLabel
        Left = 792
        Top = 336
        Width = 252
        Height = 15
        AutoSize = False
        Caption = 'COLETADOS..........................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel96: TRLLabel
        Left = 792
        Top = 380
        Width = 252
        Height = 15
        AutoSize = False
        Caption = 'COLETADOS..........................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel97: TRLLabel
        Left = 792
        Top = 472
        Width = 252
        Height = 15
        AutoSize = False
        Caption = 'COLETADOS..........................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel98: TRLLabel
        Left = 792
        Top = 426
        Width = 252
        Height = 15
        AutoSize = False
        Caption = 'COLETADOS..........................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel99: TRLLabel
        Left = 792
        Top = 518
        Width = 252
        Height = 15
        AutoSize = False
        Caption = 'COLETADOS..........................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel22: TRLLabel
        Left = 195
        Top = 549
        Width = 146
        Height = 15
        AutoSize = False
        Caption = 'QUANTIDADE DE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel63: TRLLabel
        Left = 195
        Top = 564
        Width = 210
        Height = 15
        AutoSize = False
        Caption = 'OBJETOS..................................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel64: TRLLabel
        Left = 792
        Top = 563
        Width = 252
        Height = 15
        AutoSize = False
        Caption = 'COLETADOS..........................'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel83: TRLLabel
        Left = 489
        Top = 579
        Width = 80
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel100: TRLLabel
        Left = 489
        Top = 595
        Width = 88
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel101: TRLLabel
        Left = 489
        Top = 612
        Width = 88
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel102: TRLLabel
        Left = 489
        Top = 629
        Width = 88
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel4: TRLLabel
        Left = 8
        Top = 93
        Width = 112
        Height = 15
        Caption = 'GR'#193'FICA ADDRESS'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
    end
  end
end
