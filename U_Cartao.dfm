object frm_cartao: Tfrm_cartao
  Left = 205
  Top = 174
  ActiveControl = ScrollBox1
  BorderIcons = []
  Caption = 'Bater Cart'#227'o'
  ClientHeight = 180
  ClientWidth = 473
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 473
    Height = 180
    HorzScrollBar.Range = 465
    VertScrollBar.Range = 168
    Align = alClient
    AutoScroll = False
    TabOrder = 0
    ExplicitHeight = 173
    object BtnIni: TButton
      Left = 96
      Top = 143
      Width = 75
      Height = 25
      Caption = 'Inicio'
      TabOrder = 0
      OnClick = BtnIniClick
    end
    object BtnFim: TButton
      Left = 200
      Top = 143
      Width = 75
      Height = 25
      Caption = 'Fim'
      TabOrder = 1
      OnClick = BtnFimClick
    end
    object Button3: TButton
      Left = 304
      Top = 143
      Width = 75
      Height = 25
      Caption = 'Sair'
      TabOrder = 2
      OnClick = Button3Click
    end
    object ScrollBox2: TScrollBox
      Left = 4
      Top = 8
      Width = 221
      Height = 121
      HorzScrollBar.Range = 185
      VertScrollBar.Range = 103
      AutoScroll = False
      TabOrder = 3
      object Label1: TLabel
        Left = 2
        Top = 2
        Width = 92
        Height = 13
        Caption = 'Informa'#231#245'es Locais'
      end
      object Label2: TLabel
        Left = 2
        Top = 58
        Width = 52
        Height = 13
        Caption = 'Hora Local'
      end
      object RLData: TLabel
        Left = 2
        Top = 26
        Width = 37
        Height = 13
        Caption = 'RLData'
      end
      object Usuario: TLabel
        Left = 2
        Top = 90
        Width = 36
        Height = 13
        Caption = 'Usuario'
      end
      object HoraLocal: TStaticText
        Left = 76
        Top = 51
        Width = 96
        Height = 28
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvSpace
        BevelKind = bkSoft
        BevelOuter = bvRaised
        BorderStyle = sbsSingle
        Caption = '1'
        Color = clBtnHighlight
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial Narrow'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 0
      end
    end
    object ScrollBox3: TScrollBox
      Left = 244
      Top = 8
      Width = 221
      Height = 121
      HorzScrollBar.Range = 193
      VertScrollBar.Range = 103
      AutoScroll = False
      TabOrder = 4
      object Label3: TLabel
        Left = 2
        Top = 2
        Width = 115
        Height = 13
        Caption = 'Informa'#231#245'es do Servidor'
      end
      object Label4: TLabel
        Left = 2
        Top = 58
        Width = 65
        Height = 13
        Caption = 'Hora Servidor'
      end
      object RLDataServ: TLabel
        Left = 2
        Top = 26
        Width = 37
        Height = 13
        Caption = 'RLData'
      end
      object Usuario1: TLabel
        Left = 2
        Top = 90
        Width = 36
        Height = 13
        Caption = 'Usuario'
      end
      object HoraServidor: TStaticText
        Left = 88
        Top = 51
        Width = 101
        Height = 28
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvNone
        BevelKind = bkSoft
        BevelOuter = bvRaised
        BorderStyle = sbsSingle
        Caption = '1'
        Color = clWindow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial Narrow'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 195
    Top = 18
  end
  object Timer2: TTimer
    OnTimer = Timer2Timer
    Left = 255
    Top = 18
  end
end
