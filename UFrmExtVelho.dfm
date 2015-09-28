object FrmExtVelho: TFrmExtVelho
  Left = 15
  Top = 141
  Width = 777
  Height = 460
  AutoSize = True
  Caption = 'FrmExtVelho'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 769
    Height = 433
    TabOrder = 0
    object Label1: TLabel
      Left = 17
      Top = 74
      Width = 39
      Height = 19
      Caption = 'Baixa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 17
      Top = 42
      Width = 39
      Height = 19
      Caption = 'Caixa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 2
      Top = 134
      Width = 762
      Height = 5
      kind = bsFrame
      Style = bsRaised
    end
    object LblMot: TLabel
      Left = 221
      Top = 105
      Width = 4
      Height = 17
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 17
      Top = 107
      Width = 45
      Height = 19
      Caption = 'Quant.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 17
      Top = 10
      Width = 78
      Height = 19
      Caption = 'Funcionário'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EdBaixa: TEdit
      Left = 115
      Top = 73
      Width = 89
      Height = 23
      TabStop = False
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnKeyPress = EdBaixaKeyPress
    end
    object EdCaixa: TEdit
      Left = 115
      Top = 42
      Width = 89
      Height = 23
      TabStop = False
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnKeyPress = EdCaixaKeyPress
    end
    object EdRem: TEdit
      Left = 333
      Top = 5
      Width = 430
      Height = 55
      TabStop = False
      Anchors = [akLeft, akBottom]
      AutoSize = False
      BiDiMode = bdRightToLeftNoAlign
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 2
      OnKeyPress = EdRemKeyPress
    end
    object DbgExt: TDBGrid
      Left = 2
      Top = 162
      Width = 762
      Height = 263
      TabStop = False
      Color = clSilver
      {DataSource} = DmDados.DtsCga33
      Options = [dgTitles, dgIndicator, dgRowLines, dgRowSelect, dgCancelOnExit]
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'CG33_REMES'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Title.Caption = 'Remessa'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 266
          Visible = True
        end
        item
          Alignment = taLeftJustify
          Expanded = False
          FieldName = 'CG33_DUP'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Title.Caption = 'Dupl.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 139
          Visible = True
        end
        item
          DropDownRows = 4
          Expanded = False
          FieldName = 'CG33_DTBAIXA'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Title.Caption = 'info Baixa'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 339
          Visible = True
        end>
    end
    object EdQt: TEdit
      Left = 115
      Top = 105
      Width = 89
      Height = 23
      TabStop = False
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object EdCodFun: TEdit
      Left = 114
      Top = 10
      Width = 89
      Height = 23
      TabStop = False
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnKeyPress = EdCodFunKeyPress
    end
  end
end
