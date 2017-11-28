unit U_NovaBalanca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CPort, Buttons, CPortCtl, Mask, Math, ComCtrls, IniFiles;

type
  TFormNovaBalanca = class(TForm)
    LabelNomeBalanca: TLabel;
    EditNomeBalanca: TEdit;
    ComPort: TComPort;
    BitBtnIncluir: TBitBtn;
    GroupBoxPortConfig: TGroupBox;
    LabelBaudRate: TLabel;
    LabelBitsParada: TLabel;
    LabelParidade: TLabel;
    LabelFlowControl: TLabel;
    LabelStopBits: TLabel;
    BitBtnFechar: TBitBtn;
    GroupBoxReadConfig: TGroupBox;
    MemoPortReturn: TMemo;
    BitBtnTestConn: TBitBtn;
    LabelModo: TLabel;
    CBModo: TComboBox;
    LabelComando: TLabel;
    EditCommand: TEdit;
    ComComboBoxBaudRate: TComComboBox;
    ComComboBoxDataBits: TComComboBox;
    ComComboBoxParity: TComComboBox;
    ComComboBoxStopBits: TComComboBox;
    ComComboBoxFlowControl: TComComboBox;
    ComComboBoxPort: TComComboBox;
    LabelComPort: TLabel;
    LabelMask: TLabel;
    LabelEndRead: TLabel;
    LabelStartRead: TLabel;
    EditWeightReturn: TEdit;
    LabelWeightReturn: TLabel;
    BitBtnReadWeight: TBitBtn;
    StatusBarAddBalanca: TStatusBar;
    ComboBoxDecimalSeparator: TComboBox;
    Label1: TLabel;
    EditStartRead: TEdit;
    EditEndRead: TEdit;
    EditReturnedString: TEdit;
    CBUnidadeMedida: TComboBox;
    Label2: TLabel;
    BitBtnReset: TBitBtn;
    procedure EditNomeBalancaKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtnResetClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CBUnidadeMedidaChange(Sender: TObject);
    procedure BitBtnIncluirClick(Sender: TObject);
    procedure ComboBoxDecimalSeparatorChange(Sender: TObject);
    procedure EditReturnedStringKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditReturnedStringClick(Sender: TObject);
    procedure EditReturnedStringChange(Sender: TObject);
    procedure MemoPortReturnClick(Sender: TObject);
    procedure EditEndReadChange(Sender: TObject);
    procedure EditStartReadChange(Sender: TObject);
    procedure ComPortAfterOpen(Sender: TObject);
    procedure ComPortAfterClose(Sender: TObject);
    procedure BitBtnReadWeightClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComComboBoxPortChange(Sender: TObject);
    procedure BitBtnTestConnClick(Sender: TObject);
    procedure CBModoChange(Sender: TObject);
    procedure BitBtnFecharClick(Sender: TObject);
    procedure ComPortRxChar(Sender: TObject; Count: Integer);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNovaBalanca: TFormNovaBalanca;

implementation

uses U_Func, U_FrmConfig;
{$R *.dfm}

procedure TFormNovaBalanca.BitBtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormNovaBalanca.BitBtnReadWeightClick(Sender: TObject);
var   i_ini, i_fim: integer;
str, strcopy : String;
peso: Double;
foreing_dec_separator: Char;
begin
  BitBtnIncluir.Enabled := false;
  if (ComboBoxDecimalSeparator.ItemIndex = -1) then
    begin
      Application.MessageBox(PChar('Por favor selecione qual separador de ' +
        'decimal esta balança retorna.'), 'ADS', MB_OK + MB_ICONWARNING);
      exit;
    end;

  if (CBUnidadeMedida.ItemIndex = -1) then
    begin
      Application.MessageBox(PChar('Por favor selecione a unidade de medida que ' +
        'esta balança retorna.'), 'ADS', MB_OK + MB_ICONWARNING);
      exit;
    end;

  if (Length(EditReturnedString.Text) < 1) then
    begin
      Application.MessageBox(PChar('OPA! Curioso como estamos tentando ler o peso '
            + 'sem que a balança tenha retornado alguma coisa.'),
        'ADS', MB_OK + MB_ICONWARNING);
      exit;
    end;
  if (ComboBoxDecimalSeparator.ItemIndex = 0) then
    foreing_dec_separator := ','
  else
    foreing_dec_separator := '.';

  peso := 0.00;

  // Lendo a ultima linha retornada

  if (CBModo.ItemIndex = 0) then
    begin
      i_ini := 0;
      i_fim := 0;
      if (not TryStrToInt(EditStartRead.Text, i_ini) or
          not TryStrToInt(EditEndRead.Text, i_fim)) then
        begin
          Application.MessageBox(PChar('Valores inválidos para ''início'' e ''fim'' de leitura '),
                      'ADS', MB_OK + MB_ICONERROR);
          EditStartRead.SetFocus;
          exit;
        end;

      if ( (i_ini = 0) or (i_fim = 0) or (i_fim < i_ini)) then
        begin
          Application.MessageBox(PChar('O valor de ''início'' e ''fim'' de leitura ' +
                    ' não podem ser 0 (zero) e o valor de ''fim'' deve ser maior que ''inicio'''),
                      'ADS', MB_OK + MB_ICONERROR);
          EditEndRead.SetFocus;
          exit;
        end;
      // Garantindo que i_fim jamais seja maior que a string
      i_fim := Min(i_fim, Length(EditReturnedString.Text));
      str := copy(EditReturnedString.Text, i_ini, i_fim - i_ini);
    end
  else
    str := EditReturnedString.Text;

    peso := StrToPeso(str, foreing_dec_separator);

    if (peso > 0) then
      begin
        if (CBUnidadeMedida.ItemIndex = 1) then
          peso := peso / 1000;

        EditWeightReturn.Text := FormatFloat('0.000', peso) + ' Kg';
        BitBtnIncluir.Enabled := true;
      end
    else
      begin
        StatusBarAddBalanca.Panels[1].Text := str;
        StatusBarAddBalanca.Panels[0].Text := DecimalSeparator;
        StatusBarAddBalanca.Refresh;
      end;

end;


procedure TFormNovaBalanca.BitBtnResetClick(Sender: TObject);
var i: Integer;
begin
  if ComPort.Connected then
      ComPort.Close;
  // Desbloqueando a edição após conexão
  for i := 0 to GroupBoxReadConfig.ComponentCount - 1 do
    begin
      if GroupBoxReadConfig.Components[i] is TComComboBox then
        begin
          (GroupBoxPortConfig.Components[i] as TComComboBox).Enabled := true;
          (GroupBoxPortConfig.Components[i] as TComComboBox).ItemIndex := -1;
        end;
      if GroupBoxReadConfig.Components[i] is TEdit then
        (GroupBoxPortConfig.Components[i] as TEdit).Clear;
    end;

  MemoPortReturn.Clear;
  EditWeightReturn.Text := '----------';
  BitBtnIncluir.Enabled := false;

end;

procedure TFormNovaBalanca.BitBtnIncluirClick(Sender: TObject);
var i: Integer;
  iniBalanca : TIniFile;
begin

  // Verificando o nome da Balança
  if (Length(EditNomeBalanca.Text) < 1) then
    begin
      Application.MessageBox(PChar('Indique um nome para esta balança!'),
          'ADS', MB_OK + MB_ICONERROR);
      EditNomeBalanca.SetFocus;
      exit;
    end;

  for i := 0 to FrmConfig.BalancaList.Count - 1 do
    begin
      if (LowerCase(FrmConfig.BalancaList[i] ) = LowerCase(EditNomeBalanca.Text)) then
        begin
          Application.MessageBox(PChar('Já existe uma balança com este nome!'),
              'ADS', MB_OK + MB_ICONERROR);
          EditNomeBalanca.SetFocus;
          exit;
        end;

    end;

  Try
    ComPort.StoreSettings(stIniFile, EditNomeBalanca.Text);
    iniBalanca:= TIniFile.Create(EditNomeBalanca.Text);
    iniBalanca.WriteString('ConfigLeituraPeso', 'Modo', CBModo.Text);
    iniBalanca.WriteString('ConfigLeituraPeso', 'Comando', EditCommand.Text);
    iniBalanca.WriteString('ConfigLeituraPeso', 'InicioLeitura', EditStartRead.Text);
    iniBalanca.WriteString('ConfigLeituraPeso', 'FimLeitura', EditEndRead.Text);
    iniBalanca.WriteString('ConfigLeituraPeso', 'SeparadorDecimal', ComboBoxDecimalSeparator.Text);

    iniBalanca.WriteString('ConfigLeituraPeso', 'UnidadeMedida',
      IntToStr(Max(1, CBUnidadeMedida.ItemIndex * 1000))
    );
    iniBalanca.UpdateFile;
    iniBalanca.Free;
    FrmConfig.BalancaList.Add(EditNomeBalanca.Text + '=0');
  Except
    Application.MessageBox(PChar('Não foi possível armazer as configurações. ' +
        'Verifique o nome dado a balança e tente novamente.'),
              'ADS', MB_OK + MB_ICONERROR);
    EditNomeBalanca.SetFocus;
  end;

end;

procedure TFormNovaBalanca.BitBtnTestConnClick(Sender: TObject);
var
  Str: String;
  i: Integer;
begin
  if ComPort.Connected then
      ComPort.Close
  else
    begin
      if ComComboBoxPort.ItemIndex = -1  then
        begin
          Application.MessageBox(PChar('Selecione uma porta!'),
          'ADS', MB_OK + MB_ICONERROR);
          ComComboBoxPort.SetFocus;
          exit;
        end;

      if (CBModo.ItemIndex = 1) then
        begin
          if (Length(Trim(EditCommand.Text)) < 1) then
            begin
              Application.MessageBox(PChar('O campo ''Comando'' não pode ficar em branco!'),
              'ADS', MB_OK + MB_ICONERROR);
              EditCommand.SetFocus;
              exit;
            end;

          // Modo de envio de comando
          ComPort.WriteStr(EditCommand.Text);
          ComPort.Close;
        end;

      MemoPortReturn.Clear;
      ComPort.Open;

       // Lendo...
    end;

end;

procedure TFormNovaBalanca.CBModoChange(Sender: TObject);
var st : boolean;
begin
  // Modo Comando
{  st := CBModo.ItemIndex = 1;

  EditCommand.Enabled := st;
  LabelComando.Enabled := st;
  EditCommand.Enabled := st;

  // Moco Continuo
  LabelMask.Visible := not st;
  LabelStartRead.Visible := not st;
  LabelEndRead.Visible := not st;
  MaskEditStartRead.Visible := not st;
  MaskEditEndRead.Visible := not st;
  }
end;

procedure TFormNovaBalanca.CBUnidadeMedidaChange(Sender: TObject);
begin
BitBtnReadWeight.Enabled := ((Length(EditReturnedString.Text) > 0) and
      (ComboBoxDecimalSeparator.ItemIndex > -1) and
      (CBUnidadeMedida.ItemIndex > -1) );
end;

procedure TFormNovaBalanca.ComboBoxDecimalSeparatorChange(Sender: TObject);
begin
BitBtnReadWeight.Enabled := ((Length(EditReturnedString.Text) > 0) and
      (ComboBoxDecimalSeparator.ItemIndex > -1) and
      (CBUnidadeMedida.ItemIndex > -1) );
end;

procedure TFormNovaBalanca.ComComboBoxPortChange(Sender: TObject);
begin
  BitBtnTestConn.Enabled := ComComboBoxPort.ItemIndex > -1;
end;

procedure TFormNovaBalanca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ComPort.Connected then
    ComPort.Close;

end;

procedure TFormNovaBalanca.FormShow(Sender: TObject);
begin
  ComComboBoxPort.Items := getAvailableCOMPorts;
end;

procedure TFormNovaBalanca.MemoPortReturnClick(Sender: TObject);
begin
  EditReturnedString.Text := MemoPortReturn.Lines[MemoPortReturn.CaretPos.Y];
end;

procedure TFormNovaBalanca.ComPortAfterClose(Sender: TObject);
var i: Integer;
begin
  BitBtnTestConn.Caption := '&Conectar';
  // Desbloqueando a edição após conexão
  for i := 0 to GroupBoxPortConfig.ComponentCount - 1 do
    if GroupBoxPortConfig.Components[i] is TComComboBox then
          (GroupBoxPortConfig.Components[i] as TComComboBox).Enabled := true;

end;

procedure TFormNovaBalanca.ComPortAfterOpen(Sender: TObject);
var i: Integer;
begin
  BitBtnTestConn.Caption := 'Des&conectar';
  // Desbloqueando a edição após conexão
  for i := 0 to GroupBoxPortConfig.ComponentCount - 1 do
    if GroupBoxPortConfig.Components[i] is TComComboBox then
          (GroupBoxPortConfig.Components[i] as TComComboBox).Enabled := false;
end;

procedure TFormNovaBalanca.ComPortRxChar(Sender: TObject; Count: Integer);
var
  Str: String;
  i, i_ini, i_fim: integer;
  peso: Real;
begin
  ComPort.ReadStr(Str, Count);
  MemoPortReturn.Text := MemoPortReturn.Text + Str;
end;

procedure TFormNovaBalanca.EditEndReadChange(Sender: TObject);
var I: Integer;
str, strclean: String;
begin
  str := EditEndRead.Text;
  strclean := '';
  for I := 1 to Length(str) do
    if AnsiPos(str[i], '0123456789') > 0 then
        strclean := strclean + str[i];
  EditEndRead.Text := strclean;
end;

procedure TFormNovaBalanca.EditNomeBalancaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in['0'..'9', 'a'..'z', 'A'..'Z', #8..#20, #32, '[',']', '_', '.']) then
    begin
      beep;
      key := #0;
    end;
end;

procedure TFormNovaBalanca.EditReturnedStringChange(Sender: TObject);
begin
  BitBtnReadWeight.Enabled := ((Length(EditReturnedString.Text) > 0) and
      (ComboBoxDecimalSeparator.ItemIndex > -1))
end;

procedure TFormNovaBalanca.EditReturnedStringClick(Sender: TObject);
begin
  EditStartRead.Text := IntToStr(EditReturnedString.SelStart + 1);
  EditEndRead.Text := IntToStr(EditReturnedString.SelStart + EditReturnedString.SelLength + 1);
end;

procedure TFormNovaBalanca.EditReturnedStringKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  EditReturnedStringClick(Sender);
end;

procedure TFormNovaBalanca.EditStartReadChange(Sender: TObject);
var I: Integer;
str, strclean: String;
begin
  str := EditStartRead.Text;
  strclean := '';
  for I := 1 to Length(str) do
    if AnsiPos(str[i], '0123456789') > 0 then
        strclean := strclean + str[i];
  EditStartRead.Text := strclean;
end;

end.
