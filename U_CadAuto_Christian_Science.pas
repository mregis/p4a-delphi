unit U_CadAuto_Christian_Science;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, ShellCtrls;

type
  TFrmCadAutoChristianSciense = class(TForm)
    ScrollBox1: TScrollBox;
    Bevel1: TBevel;
    BitBtn2: TBitBtn;
    BitBtn5: TBitBtn;
    Panel6: TPanel;
    DbLkVeiculo: TDBLookupComboBox;
    Panel9: TPanel;
    EdPrimeiroNome: TEdit;
    Panel8: TPanel;
    EdSegundoNome: TEdit;
    Panel4: TPanel;
    MkedCep: TMaskEdit;
    Panel7: TPanel;
    EdEnd: TEdit;
    Panel1: TPanel;
    EdBairro: TEdit;
    Panel2: TPanel;
    EdCidade: TEdit;
    Panel3: TPanel;
    EdUf: TEdit;
    Panel10: TPanel;
    EdSexo: TEdit;
    EdQt: TEdit;
    Panel11: TPanel;
    EdCaixa: TEdit;
    Panel5: TPanel;
    ListEmail: TListBox;
    Panel12: TPanel;
    EdEmail: TEdit;
    BtnPrepara: TBitBtn;
    procedure buscacep(cepx:string);
    procedure consistir;
    procedure limpa;
    procedure salvar;
    procedure BitBtn5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure BtnPreparaClick(Sender: TObject);
    procedure FileArquivosClick(Sender: TObject);
    procedure MkedCepKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FileArquivosAddFolder(Sender: TObject; AFolder: TShellFolder;
      var CanAdd: Boolean);
  private
    email : textfile;
    antigo,novo : string;
    indice : integer;
    caption : string;
    codemail : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadAutoChristianSciense: TFrmCadAutoChristianSciense;

  
implementation

uses DmDados, DB, UPrepCarregAut, U_Func;

{$R *.dfm}

procedure TFrmCadAutoChristianSciense.BitBtn5Click(Sender: TObject);
begin
  close;
end;

procedure TFrmCadAutoChristianSciense.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := cafree;
end;

procedure TFrmCadAutoChristianSciense.limpa;
begin
  EdPrimeiroNome.Clear;
  EdSegundoNome.Clear;
  MkedCep.Clear;
  EdEnd.Clear;
  EdBairro.Clear;
  EdCidade.Clear;
  EdUf.Clear;
  EdSexo.Clear;
  EdEmail.Clear;
  EdPrimeiroNome.SetFocus;
end;

procedure TFrmCadAutoChristianSciense.buscacep(cepx:string);
begin
  with dm do
    begin
      SqlCep.Close;
      SqlCep.Sql.Clear;
      SqlCep.Sql.Add('select logradouros.logradouro,');
      SqlCep.Sql.Add('bairros.bairro,');
      SqlCep.Sql.Add('localidades.localidade,');
      SqlCep.Sql.Add('ufs.uf');
      SqlCep.Sql.Add('from logradouros');
      SqlCep.Sql.Add('inner join bairros on bairros.dne = logradouros.dnebairroinicial');
      SqlCep.Sql.Add('inner join localidades on bairros.dnelocalidade = localidades.dne');
      SqlCep.Sql.Add('inner join  ufs on ufs.dne = localidades.dneuf');
      SqlCep.Sql.Add('where logradouros.cep = :cep');
      SqlCep.Params[0].Value := cepx;
      SqlCep.Open;
      case SqlCep.RecordCount of
        0:
          begin
            EdEnd.SetFocus;
            application.messagebox('Cep não encontrado','Ads',MB_OK+MB_ICONERROR);
          end;
        1:
          begin
            EdBairro.Text := SqlCepbairro.AsString;
            EdCidade.Text := SqlCeplocalidade.AsString;
            EdUf.Text     := SqlCepuf.AsString;
          end;
       else
         begin
           application.MessageBox('Inconsistencia digite o endereço','Ads',MB_OK+MB_ICONERROR);
         end;
       end;
    end;
end;

procedure TFrmCadAutoChristianSciense.consistir;
var
  local,pnome,snome : string;
  endereco,municipio,pais,uf,cep : string;
  emailx,veiculo : string;
  bairro  : string;
  aux : string;
begin
  {local := FileArquivos.Root+FileArquivos.Selected.Caption;}
  AssignFile(email,local);
  reset(email);
 { antigo := FileArquivos.Root+FileArquivos.Selected.Caption;}
  while not eof(email) do
    begin
      readln(email,local);
      codemail := AnsiUpperCase(copy(local,1,61));
      while 'FIRST NAME:'<> ansiuppercase(copy(local,1,11)) do
        begin
          readln(email,local);
        end;
      pnome := Trim(copy(local,12,100));
      readln(email,local);
      snome := Trim(copy(local,12,100));
      readln(email,local);
      endereco := Trim(copy(local,12,100));
      readln(email,local);
      bairro := Trim(copy(local,12,100));
      readln(email,local);
      municipio := Trim(copy(local,12,100));
      readln(email,local);
      pais  := Trim(copy(local,12,100));
      readln(email,local);
      uf    := Trim(copy(local,12,100));
      readln(email,local);
      cep     := Trim(copy(local,13,100));
      readln(email,local);
      emailx   := Trim(copy(local,12,100));
      readln(email,local);
      veiculo := Trim(copy(local,13,100));
      Dm.Sqlcga11.Close;
      Dm.Sqlcga11.Sql.Clear;
      Dm.Sqlcga11.Sql.Add('select * from cga11 where upper(cg11_descricao) = :descricao');
      aux := acerta(veiculo);
      if ('REVISTA TVA/CANBRE1S' = aux) or ('REVISTA TVA/CANBRÁ1S' = aux)or ('REVISTA TVA/CANBRÁS' = aux)then
        begin
          Dm.Sqlcga11.Params[0].AsString := 'CAMBRAS MAGAZINE';
        end else
      if 'JORNAL' = aux then
        begin
          Dm.Sqlcga11.Params[0].AsString := uppercase('Diario do Grande ABC');
        end else
      if 'DISTRIBUIÇÃO EM DOMICÍLIO' =  aux  then
        begin
          Dm.Sqlcga11.Params[0].AsString := uppercase('Porta a Porta');
        end else
      if ('QUIOSQUE MULTIMIDIA' = aux) or ('QUIOSQUE MULTIMÍDIA' = aux) then
        begin
          Dm.Sqlcga11.Params[0].AsString := uppercase('Quiosque Digital');
        end else
          Dm.Sqlcga11.Params[0].AsString := aux;
      Dm.Sqlcga11.Open;
      if Dm.Sqlcga11.RecordCount <> 1 then
        begin
          Dm.Sqlcga11.Close;
          Dm.Sqlcga11.Sql.Clear;
          Dm.Sqlcga11.Sql.Add('select * from cga11');
          Dm.Sqlcga11.Open;
          application.MessageBox('Inconsistencia nos dados do Veiculo','Ads',MB_OK+MB_ICONERROR);
        end
      else
        begin
          DbLkVeiculo.KeyValue := null;
          DbLkVeiculo.KeyValue := Dm.SqlCga11cg11_descricao.Value;
          DbLkVeiculo.Refresh;
        end;
      EdPrimeiroNome.Text := pnome;
      EdSegundoNome.Text  := snome;
      if length(cep) = 9 then
        MkedCep.Text      := copy(cep,1,5) + copy(cep,7,9)
      else
        MkedCep.Text      := cep;
      EdEmail.Text        := emailx;
      buscacep(MkedCep.Text);
      if (endereco = bairro) or (EdBairro.Text = bairro) then
        EdEnd.Text := endereco
      else
        EdEnd.Text          := endereco+' '+bairro;
      exit;
    end;
end;

procedure TFrmCadAutoChristianSciense.salvar;
var
 resultado : integer;
begin
 if (Trim(EdSexo.Text) = '') or ((EdSexo.Text <> 'F') and (EdSexo.Text <> 'M'))then
    begin
      Application.MessageBox('Preecha o Sexo','Ads',MB_OK+MB_ICONWARNING);
      EdSexo.SetFocus;
      exit;
    end;
  with dm do
    begin
//      Trans.NewStyleTransactions := true;
//      Trans.AutoCommit := false;
//      Trans.StartTransaction;
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('insert into cga10');
      SqlAux1.Sql.Add('(cg10_codveiculo,cg10_pnome,cg10_snome,');
      SqlAux1.Sql.Add('cg10_endereco,cg10_bairro,cg10_cidade,cg10_uf,cg10_cep,');
      SqlAux1.Sql.Add('cg10_pais,cg10_sexo,cg10_codusu,cg10_dtdig,cg10_caixa,cg10_internet,cg10_email)');
      SqlAux1.Sql.Add('values');
      SqlAux1.Sql.Add('(:cg10_codveiculo,:cg10_pnome,:cg10_snome,');
      SqlAux1.Sql.Add(':cg10_endereco,:cg10_bairro,:cg10_cidade,:cg10_uf,:cg10_cep,');
      SqlAux1.Sql.Add(':cg10_pais,:cg10_sexo,:cg10_codusu,:cg10_dtdig,:cg10_caixa,:cg10_internet,:cg10_email)');
      SqlAux1.Params[0].Value  := dm.SqlCga11cg11_cod.Value;
      SqlAux1.Params[1].Value  := Trim(EdPrimeiroNome.Text);
      SqlAux1.Params[2].Value  := Trim(EdSegundoNome.Text);
      SqlAux1.Params[3].Value  := Trim(EdEnd.Text);
      SqlAux1.Params[4].Value  := Trim(EdBairro.Text);
      SqlAux1.Params[5].Value  := Trim(EdCidade.Text);
      SqlAux1.Params[6].Value  := EdUf.Text;
      SqlAux1.Params[7].Value  := COPY(MkedCep.Text,1,5)+'-'+COPY(MkedCep.Text,6,3);
      SqlAux1.Params[8].Value  := 'Brasil';
      SqlAux1.Params[9].Value  := EdSexo.Text;
      SqlAux1.Params[10].Value := Dm.sqlcga_acessocodigo.Value;
      SqlAux1.Params[11].Value := formatdatetime('mm-dd-yyyy',date);
      SqlAux1.Params[12].Value := EdCaixa.Text;
      SqlAux1.Params[13].Value := 'S';
      SqlAux1.Params[14].Value := Trim(EdEmail.Text);
      SqlAux1.ExecSql;
      try
       SqlAux2.Close;
       SqlAux2.Sql.Clear;
       SqlAux2.Sql.Add('insert into cga13 (cg13_codemail) values (:cg13_codemail)');
       SqlAux2.Params[0].Value := codemail;
       try
         SqlAux2.ExecSql;
//         Trans.Commit;
       except
         begin
           application.MessageBox('Registro já cadastrado','Ads',MB_OK+MB_ICONWARNING);
//           Trans.Rollback;
         end;
       end;
       EdQt.Text := inttostr(1+strtoint(EdQt.Text));
       limpa;
       CloseFile(email);
       {FileArquivos.Items.Delete(indice);}

       // As linhas abaixo não foram possíveis de portar para VCL

       {resultado := FileArquivos.DeleteSelected.[caption];
       case resultado of
        -1: showmessage('RESULT_ACCESS_DENIED');
        -2: showmessage('RESULT_DIR_NOT_EMPTY');
        -3: showmessage('RESULT_FILE_NOT_FOUND');
        -4: showmessage('RESULT_ALREADY_EXISTS');
       end;}
//       if FileExists() then
//         DeleteFile(antigo);
      // FileArquivos.Update;
      except on e: exception do
        begin
          application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
          exit;
        end;
      end;
    end;
end;

procedure TFrmCadAutoChristianSciense.BitBtn2Click(Sender: TObject);
begin
  salvar;
end;

procedure TFrmCadAutoChristianSciense.BtnPreparaClick(Sender: TObject);
begin
  Application.CreateForm(TFrmPrepCarregAut,FrmPrepCarregAut);
  FrmPrepCarregAut.ShowModal;
  setfocus;
end;

procedure TFrmCadAutoChristianSciense.FileArquivosClick(Sender: TObject);
begin
  {indice  := FileArquivos.Selected.Index;
  caption := FileArquivos.Selected.Caption;}

  // Não foi possível converter a linha abaixo para VCL
  //ListEmail.Items.LoadFromFile(FileArquivos.Directory.Location+FileArquivos.Selected.Caption);
  consistir;
  ListEmail.ScrollBy(-1000,-1000);
  ListEmail.Refresh;
  ListEmail.ScrollBy(20,205);
  ListEmail.Refresh;
  EdSexo.SetFocus;
end;

procedure TFrmCadAutoChristianSciense.MkedCepKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
    buscacep(MkedCep.Text);
end;

procedure TFrmCadAutoChristianSciense.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 4152 then
    salvar;
end;

procedure TFrmCadAutoChristianSciense.FileArquivosAddFolder(
  Sender: TObject; AFolder: TShellFolder; var CanAdd: Boolean);
var
XFilterExt, XExt: string;

begin
XFilterExt := ExtractFileExt('*.txt');
XExt := ExtractFileExt(AFolder.PathName);
if (CompareText(XExt, XFilterExt) = 0) or AFolder.IsFolder then
CanAdd := True
else
CanAdd := False;
end;

end.
