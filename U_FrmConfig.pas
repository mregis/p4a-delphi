unit U_FrmConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IniFiles;

type
  TFrmConfig = class(TForm)
    BitBtnFechar: TBitBtn;
    BitBtnSalvar: TBitBtn;
    GroupBox1: TGroupBox;
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
    GroupBox2: TGroupBox;
    LabelDirDest: TLabel;
    EditDirDest: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnSalvarClick(Sender: TObject);
    procedure BitBtnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConfig: TFrmConfig;
  iniFile : TIniFile;

implementation

{$R *.dfm}

procedure TFrmConfig.BitBtnSalvarClick(Sender: TObject);
var i : Integer;
begin
  // Necess�rio validar campos
  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TEdit) and ((Components[i] as TEdit).Text = '') then
      Begin
        Application.MessageBox(PChar('O campo "' + (Components[i] as TEdit).Hint +
          '"' + #13#10 + 'n�o pode ficar em branco.'),
          'ADS', MB_OK + MB_ICONERROR);
        (Components[i] as TEdit).SetFocus;
        exit;
      end;

  // Todos os campos preenchidos
  IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  Try
      // Nome do Servidor onde se encontra a Base de Dados Postgres
    iniFile.WriteString('BD', 'Host', EditDBHost.Text);;
    // Nome da base de Dados que a aplica��o utilizar�
    iniFile.WriteString('BD', 'Banco', EditDBName.Text);
    // Porta de conex�o ao banco de Dados
    iniFile.WriteInteger('BD', 'Porta', StrToInt(EditDBPort.Text));
    // Nome de usuario para conex�o ao BD
    iniFile.WriteString('BD', 'Usuario', EditDBUsername.Text);
    // Senha de acesso ao Bando de Dados
    iniFile.WriteString('BD', 'Senha', EditDBPassword.Text);
    // Diret�rio de destino dos arquivos gerados
    iniFile.WriteString('Arquivos', 'Local', EditDirDest.Text);

  finally
    iniFile.Free;
  end;
end;

procedure TFrmConfig.BitBtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
  FrmConfig := Nil;
end;

procedure TFrmConfig.FormShow(Sender: TObject);
begin
  IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    // Nome do Servidor onde se encontra a Base de Dados Postgres
    EditDBHost.Text := iniFile.ReadString('BD', 'Host', '10.1.1.10');;
    // Nome da base de Dados que a aplica��o utilizar�
    EditDBName.Text := iniFile.ReadString('BD', 'Banco', 'dbads');
    // Porta de conex�o ao banco de Dados
    EditDBPort.Text := IntToStr(iniFile.ReadInteger('BD', 'Porta', 5432));
    // Nome de usuario para conex�o ao BD
    EditDBUsername.Text := iniFile.ReadString('BD', 'Usuario', 'ads');
    // Senha de acesso ao Bando de Dados
    EditDBPassword.Text := iniFile.ReadString('BD', 'Senha', 'ads!.!');
    // Diret�rio de destino dos arquivos gerados
    EditDirDest.Text := iniFile.ReadString('Arquivos', 'Local', GetCurrentDir);

  finally
    iniFile.Free;
  end;

end;

end.
