object FrmFrRelAgExtCons: TFrmFrRelAgExtCons
  Left = -1
  Top = 96
  Width = 996
  Height = 612
  HorzScrollBar.Range = 882
  VertScrollBar.Position = 450
  VertScrollBar.Range = 1131
  Caption = 'FrmFrRelAgExtCons'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport
    Left = 88
    Top = -442
    Width = 794
    Height = 1123
    DataSource = Dm.DtsRel
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 1045
      BeforePrint = RLBand1BeforePrint
      object RLLabel1: TRLLabel
        Left = 24
        Top = 24
        Width = 189
        Height = 55
        Caption = 'Bradesco'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -48
        Font.Name = 'Times New Roman'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object RLLabel2: TRLLabel
        Left = 24
        Top = 104
        Width = 15
        Height = 19
        Caption = #192
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object RLLabel3: TRLLabel
        Left = 24
        Top = 127
        Width = 74
        Height = 19
        Caption = 'AG'#202'NCIA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Rldata: TRLLabel
        Left = 523
        Top = 85
        Width = 191
        Height = 17
        Alignment = taRightJustify
        Caption = 'Matriz, 04 de Fevereiro de 2004'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Times New Roman'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object RLLabel5: TRLLabel
        Left = 309
        Top = 280
        Width = 100
        Height = 22
        Caption = 'URGENTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel6: TRLLabel
        Left = 221
        Top = 309
        Width = 269
        Height = 22
        Caption = 'ATEN'#199#195'O DO SR. GERENTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel7: TRLLabel
        Left = 24
        Top = 369
        Width = 488
        Height = 22
        Caption = 'REF.:DEMONSTRATIVO CONSOLIDADO BRADESCO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel8: TRLLabel
        Left = 24
        Top = 394
        Width = 516
        Height = 22
        Caption = '         DEVOLU'#199#195'O POR INSUFICI'#202'NCIA DE ENDERE'#199'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLMemo1: TRLMemo
        Left = 24
        Top = 464
        Width = 666
        Height = 63
        Alignment = taJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Pitch = fpVariable
        Font.Style = []
        Lines.Strings = (
          
            '                                             Anexamos demonstrat' +
            'ivos consolidados de clientes dessa'
          
            'Ag'#234'ncia, que foram devolvidos pelo Correio, por erro ou insufici' +
            #234'ncia  de dados do'
          'endere'#231'o, ou ainda por mudan'#231'a do destinat'#225'rio.')
        ParentFont = False
      end
      object RLMemo2: TRLMemo
        Left = 24
        Top = 551
        Width = 666
        Height = 63
        Alignment = taJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Pitch = fpVariable
        Font.Style = [fsItalic]
        Lines.Strings = (
          
            '                                             Considerando que a ' +
            'tarifa destes extratos '#233'  debitada na conta corrente, solicitamo' +
            's confirmar esta cobran'#231'a e estorn'#225'-la em caso positivo mediante' +
            ' d'#233'bito na conta 1/9, raz'#227'o 93-55.  ')
        ParentFont = False
      end
      object RLMemo3: TRLMemo
        Left = 24
        Top = 632
        Width = 666
        Height = 84
        Alignment = taJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Pitch = fpVariable
        Font.Style = []
        Lines.Strings = (
          
            '                                            Solicitamos o empenh' +
            'o dessa  administra'#231#227'o, visando a regulariza'#231#227'o do endere'#231'o dess' +
            'es clientes para evitar reincid'#234'ncia. Enquanto persistir a irreg' +
            'ularidade, solicitamos bloquear a emiss'#227'o do extrato acessando a' +
            ' Rotina SCCE, Op'#231#227'o 04 - Item altera'#231#227'o.')
        ParentFont = False
      end
      object RLMemo4: TRLMemo
        Left = 24
        Top = 759
        Width = 666
        Height = 21
        Alignment = taJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Pitch = fpVariable
        Font.Style = []
        Lines.Strings = (
          
            '                                            Estaremos acompanhan' +
            'do as pr'#243'ximas emiss'#245'es.')
        ParentFont = False
      end
      object RLMemo5: TRLMemo
        Left = 19
        Top = 864
        Width = 682
        Height = 19
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Times New Roman'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        Lines.Strings = (
          '4510-1/DPTO DE CONTROLE OPERACIONAL.')
        ParentFont = False
      end
      object RlAg: TRLLabel
        Left = 24
        Top = 151
        Width = 74
        Height = 19
        Caption = 'AG'#202'NCIA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
    end
  end
end
