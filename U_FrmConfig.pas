unit U_FrmConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IniFiles, OleServer, CmAdmCtl, Grids;

type
  TFrmConfig = class(TForm)
    BitBtnFechar: TBitBtn;
    BitBtnSalvar: TBitBtn;
    GroupBoxConexaoBD: TGroupBox;
    LabelDBHost: TLabel;
    EditDBHost: TEdit;
    LabelDBName: TLabel;
    EditDBName: TEdit;
    Label1: TLabel;
    EditDBPort: TEdit;
    LabelDBUsername: TLabel;
    EditDBUsername: TEdit;
    EditDBPassword: TEdit;
    LabelDBPassword: TLabel;
    GrpBoxArqDir: TGroupBox;
    LabelDirDest: TLabel;
    EditDirDest: TEdit;
    GroupBoxBalanca: TGroupBox;
    Label4: TLabel;
    StringGridBalancas: TStringGrid;
    BitBtnAddBalanca: TBitBtn;
    BitBtnDelBalanca: TBitBtn;
    BitBtnMakeDefaultBalanca: TBitBtn;
    procedure BitBtnMakeDefaultBalancaClick(Sender: TObject);
    procedure BitBtnDelBalancaClick(Sender: TObject);
    procedure StringGridBalancasSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BitBtnAddBalancaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnSalvarClick(Sender: TObject);
    procedure BitBtnFecharClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    BalancaList : TStringList;
    procedure DeleteRow(Grid: TStringGrid; ARow: Integer);
  end;

var
  FrmConfig: TFrmConfig;
  iniFile: TIniFile;


implementation

uses U_NovaBalanca;
{$R *.dfm}

procedure TFrmConfig.BitBtnSalvarClick(Sender: TObject);
var i : Integer;
begin
  // Necessário validar campos
  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TEdit) and ((Components[i] as TEdit).Text = '') then
      Begin
        Application.MessageBox(PChar('O campo "' + (Components[i] as TEdit).Hint +
          '"' + #13#10 + 'não pode ficar em branco.'),
          'ADS', MB_OK + MB_ICONERROR);
        (Components[i] as TEdit).SetFocus;
        exit;
      end;

  // Todos os campos preenchidos
  IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  Try
      // Nome do Servidor onde se encontra a Base de Dados Postgres
    iniFile.WriteString('BD', 'Host', EditDBHost.Text);;
    // Nome da base de Dados que a aplicação utilizará
    iniFile.WriteString('BD', 'Banco', EditDBName.Text);
    // Porta de conexão ao banco de Dados
    iniFile.WriteInteger('BD', 'Porta', StrToInt(EditDBPort.Text));
    // Nome de usuario para conexão ao BD
    iniFile.WriteString('BD', 'Usuario', EditDBUsername.Text);
    // Senha de acesso ao Bando de Dados
    iniFile.WriteString('BD', 'Senha', EditDBPassword.Text);
    // Diretório de destino dos arquivos gerados
    iniFile.WriteString('Arquivos', 'Local', EditDirDest.Text);

    if StringGridBalancas.RowCount > 1 then
      begin
//        Balancas:= TStringList.Create;
        for i := 1 to StringGridBalancas.RowCount do
          begin
            if FileExists(GetCurrentDir + PathDelim + StringGridBalancas.Cells[0, i] + '.ini') then
              // Adicionando a balanca configurada
              iniFile.WriteString('Balancas', StringGridBalancas.Cells[0, i],
                StringGridBalancas.Cells[1, i]);
          end;
      end;

  finally
    iniFile.Free;
  end;
end;

procedure TFrmConfig.BitBtnAddBalancaClick(Sender: TObject);
var i: Integer;
begin
  BalancaList:= TStringList.Create;
  Application.CreateForm(TFormNovaBalanca, FormNovaBalanca);
  for i := 1 to StringGridBalancas.RowCount - 1 do
    BalancaList.Add(StringGridBalancas.Cells[0, i] +
      '='+StringGridBalancas.Cells[1, i]);

  FormNovaBalanca.ShowModal;
  SetFocus;
  // Renovando a lista de Balancas exibidas
  StringGridBalancas.RowCount := BalancaList.Count + 1;
  for i := 0 to BalancaList.Count - 1 do
    begin
      StringGridBalancas.Cells[0, i + 1] := BalancaList.Names[i];
      StringGridBalancas.Cells[1, i + 1] := BalancaList.ValueFromIndex[i];
    end;
  BalancaList.Free;

end;

procedure TFrmConfig.BitBtnDelBalancaClick(Sender: TObject);
var is_default: boolean;
begin
  if (StringGridBalancas.Row > 0) then
    begin
      is_default := StringGridBalancas.Cells[1, StringGridBalancas.Row] = '1';
      DeleteRow(StringGridBalancas, StringGridBalancas.Row);
      if (is_default = true) OR (StringGridBalancas.RowCount= 2) then
          BitBtnMakeDefaultBalancaClick(Self); // Forçando a selecionar outra balança como default
    end;

end;

procedure TFrmConfig.BitBtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmConfig.BitBtnMakeDefaultBalancaClick(Sender: TObject);
var i: Integer;
begin
  if (StringGridBalancas.Row > 0) then
    for i := 1 to StringGridBalancas.RowCount - 1 do
      if i = StringGridBalancas.Row then
          StringGridBalancas.Cells[1, i] := '1'
      else
          StringGridBalancas.Cells[1, i] := '0';

end;

procedure TFrmConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
  FrmConfig := Nil;
end;

procedure TFrmConfig.FormCreate(Sender: TObject);
var  i: Integer;
Balancas: TStringList;
s: String;
begin
  // Nomeando as colunas da lista de balanças configuradas
  StringGridBalancas.Cells[0, 0] := 'Nome da Balança';
  StringGridBalancas.Cells[1, 0] := 'Status';
  Balancas := TStringList.Create;

  IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    // Nome do Servidor onde se encontra a Base de Dados Postgres
    EditDBHost.Text := iniFile.ReadString('BD', 'Host', '10.1.1.10');;
    // Nome da base de Dados que a aplicação utilizará
    EditDBName.Text := iniFile.ReadString('BD', 'Banco', 'dbads');
    // Porta de conexão ao banco de Dados
    EditDBPort.Text := IntToStr(iniFile.ReadInteger('BD', 'Porta', 5432));
    // Nome de usuario para conexão ao BD
    EditDBUsername.Text := iniFile.ReadString('BD', 'Usuario', 'ads');
    // Senha de acesso ao Bando de Dados
    EditDBPassword.Text := iniFile.ReadString('BD', 'Senha', 'ads!.!');
    // Diretório de destino dos arquivos gerados
    EditDirDest.Text := iniFile.ReadString('Arquivos', 'Local', GetCurrentDir);
    // Balanças configuradas
    if iniFile.SectionExists('Balancas') then
      begin
        iniFile.ReadSection('Balancas', Balancas);
        StringGridBalancas.RowCount := Balancas.Count + 1;
        for i:= 0 to Balancas.Count -1 do
          begin
            s:= iniFile.ReadString ('Balancas', Balancas[i], Balancas[i]);
            StringGridBalancas.Cells[0, i + 1] := Balancas[i];
            StringGridBalancas.Cells[1, i + 1] := s;
          end;

      end;

  finally
    iniFile.Free;
    Balancas.Free;
  end;


end;


procedure TFrmConfig.StringGridBalancasSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  BitBtnDelBalanca.Enabled := ARow > 0;
  BitBtnMakeDefaultBalanca.Enabled := ARow > 0;
end;


procedure TFrmConfig.DeleteRow(Grid: TStringGrid; ARow: Integer);
var
  i: Integer;
begin
  for i := ARow to Grid.RowCount - 2 do
    Grid.Rows[i].Assign(Grid.Rows[i + 1]);
  Grid.RowCount := Grid.RowCount - 1;
end;

end.
