unit U_Dig_Christian_Science;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Mask,
  DBCtrls;

type
  TFrmDigChristianSciense = class(TForm)
    ScrollBox1: TScrollBox;
    Panel5: TPanel;
    EdCaixa: TEdit;
    Panel6: TPanel;
    DbLkVeiculo: TDBLookupComboBox;
    Panel7: TPanel;
    EdQt: TEdit;
    Panel8: TPanel;
    EdSegundoNome: TEdit;
    Panel9: TPanel;
    EdPrimeiroNome: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    EdEnd: TEdit;
    EdBairro: TEdit;
    EdCidade: TEdit;
    MkedCep: TMaskEdit;
    EdSexo: TEdit;
    EdUf: TEdit;
    DBGrid1: TDBGrid;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Panel12: TPanel;
    EdOutros: TEdit;
    procedure deleta;
    procedure altera;
    procedure atualiza;
    procedure limpa;
    procedure Salvar;
    function  consistencia:boolean;
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure EdCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1KeyPress(Sender: TObject; var Key: Char);
    procedure MkedCepKeyPress(Sender: TObject; var Key: Char);
    procedure EdSexoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DbLkVeiculoClick(Sender: TObject);
  private
    codcli : integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDigChristianSciense: TFrmDigChristianSciense;

implementation

uses DmDados, DB;

{$R *.dfm}

procedure TFrmDigChristianSciense.BitBtn5Click(Sender: TObject);
begin
  close;
end;

procedure TFrmDigChristianSciense.limpa;
var i:integer;
begin
  EdPrimeiroNome.Clear;
  EdSegundoNome.Clear;
  MkedCep.Clear;
  EdEnd.Clear;
  EdBairro.Clear;
  EdCidade.Clear;
  EdUf.Clear;
  EdSexo.Clear;
  EdOutros.Clear;
  EdPrimeiroNome.SetFocus;
  codcli := -1;
end;

procedure TFrmDigChristianSciense.atualiza;
begin
  DbLkVeiculo.KeyValue := dm.SqlCga10cg10_codveiculo.Value;
  EdPrimeiroNome.Text  := dm.SqlCga10cg10_pnome.Value;
  EdSegundoNome.Text   := dm.SqlCga10cg10_snome.Value;
  mkedcep.Text         := dm.SqlCga10cg10_cep.Value;
  EdEnd.Text           := dm.SqlCga10cg10_endereco.Value;
  EdBairro.Text        := dm.SqlCga10cg10_bairro.Value;
  EdCidade.Text        := dm.SqlCga10cg10_cidade.Value;
  EdUf.Text            := dm.SqlCga10cg10_uf.Value;
  EdSexo.Text          := dm.SqlCga10cg10_sexo.Value;
  codcli               := dm.SqlCga10cg10_codcli.Value;
end;

procedure TFrmDigChristianSciense.Salvar;
begin
  if consistencia = false then
    begin
      application.MessageBox('Operação cancelada','Ads',MB_OK+MB_ICONERROR);
      exit;
    end
  else
    begin
      with dm do
        begin
          SqlAux1.Close;
          SqlAux1.Sql.Clear;
          SqlAux1.Sql.Add('insert into cga10');
          SqlAux1.Sql.Add('(cg10_codveiculo,cg10_pnome,cg10_snome,');
          SqlAux1.Sql.Add('cg10_endereco,cg10_bairro,cg10_cidade,cg10_uf,cg10_cep,');
          SqlAux1.Sql.Add('cg10_pais,cg10_sexo,cg10_codusu,cg10_dtdig,cg10_caixa,cg10_internet,cg10_outros)');
          SqlAux1.Sql.Add('values');
          SqlAux1.Sql.Add('(:cg10_codveiculo,:cg10_pnome,:cg10_snome,');
          SqlAux1.Sql.Add(':cg10_endereco,:cg10_bairro,:cg10_cidade,:cg10_uf,:cg10_cep,');
          SqlAux1.Sql.Add(':cg10_pais,:cg10_sexo,:cg10_codusu,:cg10_dtdig,:cg10_caixa,:cg10_internet,:cg10_outros)');
          SqlAux1.Params[0].Value  := dm.SqlCga11cg11_cod.Value;
          SqlAux1.Params[1].Value  := Trim(EdPrimeiroNome.Text);
          SqlAux1.Params[2].Value  := Trim(EdSegundoNome.Text);
          SqlAux1.Params[3].Value  := Trim(EdEnd.Text);
          SqlAux1.Params[4].Value  := Trim(EdBairro.Text);
          SqlAux1.Params[5].Value  := Trim(EdCidade.Text);
          SqlAux1.Params[6].Value  := EdUf.Text;
          SqlAux1.Params[7].Value  := MkedCep.Text;
          SqlAux1.Params[8].Value  := 'Brasil';
          SqlAux1.Params[9].Value  := EdSexo.Text;
          SqlAux1.Params[10].Value := Dm.sqlcga_acessocodigo.Value;
          SqlAux1.Params[11].Value := formatdatetime('mm-dd-yyyy',date);
          SqlAux1.Params[12].Value := EdCaixa.Text;
          SqlAux1.Params[13].Value := 'N';
          SqlAux1.Params[14].Value := Trim(EdOutros.Text);
          try
           SqlAux1.ExecSql;
           EdQt.Text := inttostr(1+strtoint(EdQt.Text));
           limpa;
           SqlCga10.Refresh;
          except on e: exception do
            begin
              application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
              exit;
            end;
          end;
        end;
    end;
end;

Function TFrmDigChristianSciense.consistencia;
var
  ok: boolean;
begin
  ok := true;
  if DbLkVeiculo.KeyValue = null then
    begin
      ok := false;
      application.MessageBox('Preencha o campo Veiculo','Ads',MB_OK+MB_ICONERROR);
      DbLkVeiculo.SetFocus;
      exit;
    end;
  if EdPrimeiroNome.Text = '' then
    begin
      ok := false;
      application.MessageBox('Preencha o campo Primeiro nome','Ads',MB_OK+MB_ICONERROR);
      EdPrimeiroNome.SetFocus;
      exit;
    end;
  if EdSegundoNome.Text = '' then
    begin
      ok := false;
      application.MessageBox('Preencha o campo Segundo nome','Ads',MB_OK+MB_ICONERROR);
      EdSegundoNome.SetFocus;
      exit;
    end;
  if MkedCep.Text = '' then
    begin
      ok := false;
      application.MessageBox('Preencha o campo Cep','Ads',MB_OK+MB_ICONERROR);
      MkedCep.SetFocus;
      exit;
    end;
  if EdEnd.Text = '' then
    begin
      ok := false;
      application.MessageBox('Preencha o campo Endereço','Ads',MB_OK+MB_ICONERROR);
      EdEnd.SetFocus;
      exit;
    end;
  if EdBairro.Text = '' then
    begin
      ok := false;
      application.MessageBox('Preencha o campo Bairro','Ads',MB_OK+MB_ICONERROR);
      EdBairro.SetFocus;
      exit;
    end;
  if EdCidade.Text = '' then
    begin
      ok := false;
      application.MessageBox('Preencha o campo Cidade','Ads',MB_OK+MB_ICONERROR);
      EdCidade.SetFocus;
      exit;
    end;
  if EdUf.Text = '' then
    begin
      ok := false;
      application.MessageBox('Preencha o campo UF','Ads',MB_OK+MB_ICONERROR);
      EdUf.SetFocus;
      exit;
    end;
  if (EdSexo.Text = '')or( (EdSexo.Text <> 'F') and (EdSexo.Text <> 'M'))then
    begin
      ok := false;
      application.MessageBox('Preencha o campo Sexo','Ads',MB_OK+MB_ICONERROR);
      EdSexo.SetFocus;
      exit;
    end;
  result := ok;
end;

procedure TFrmDigChristianSciense.BitBtn1Click(Sender: TObject);
begin
  limpa;
end;

procedure TFrmDigChristianSciense.BitBtn2Click(Sender: TObject);
begin
  salvar;
end;

procedure TFrmDigChristianSciense.DBGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  atualiza;
end;

procedure TFrmDigChristianSciense.DBGrid1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  atualiza;
end;

procedure TFrmDigChristianSciense.FormShow(Sender: TObject);
begin
  dm.SqlCga10.Close;
  dm.SqlCga10.sql.Clear;
  dm.SqlCga10.sql.Add('select * from cga10 where cg10_caixa =:caixa');
  dm.SqlCga10.Params[0].Value := Trim(EdCaixa.Text);
  dm.SqlCga10.Open;
  EdQt.Text := inttostr(dm.SqlCga10.RecordCount);
  Dm.SqlCga11.Open;
end;

procedure TFrmDigChristianSciense.EdCaixaKeyPress(Sender: TObject;
  var Key: Char);
begin
 if key = #13 then
   begin
     dm.SqlCga10.Close;
     dm.SqlCga10.sql.Clear;
     dm.SqlCga10.sql.Add('select * from cga10 where cg10_caixa =:caixa order by cg10_codcli');
     dm.SqlCga10.Params[0].Value := Trim(EdCaixa.Text);
     dm.SqlCga10.Open;
     EdQt.Text := inttostr(dm.SqlCga10.RecordCount);
     Dm.SqlCga11.Open;
   end;
end;

procedure TFrmDigChristianSciense.altera;
begin
 if codcli <> Dm.SqlCga10cg10_codcli.Value then
   begin
     application.MessageBox('Selecione um registro para altera-lo','Ads',MB_OK+MB_ICONERROR);
     exit;
   end;
 if consistencia = false then
    begin
      application.MessageBox('Operação cancelada','Ads',MB_OK+MB_ICONERROR);
      exit;
    end;
 with dm do
   begin
     SqlAux1.Close;
     SqlAux1.Sql.Clear;
     SqlAux1.Sql.Add('update cga10 set');
     SqlAux1.Sql.Add('cg10_codveiculo = :cg10_codveiculo,cg10_pnome = :cg10_pnome,');
     SqlAux1.Sql.Add('cg10_snome=:cg10_snome,cg10_endereco=:cg10_endereco,cg10_bairro=:cg10_bairro,');
     SqlAux1.Sql.Add('cg10_cidade=:cg10_cidade,cg10_uf=:cg10_uf,cg10_cep=:cg10_cep,cg10_pais=:cg10_pais,');
     SqlAux1.Sql.Add('cg10_sexo=:cg10_sexo,cg10_outros=:cg10_outros');
     SqlAux1.Sql.Add('where');
     SqlAux1.Sql.Add('cg10_codcli=:cg10_codcli');
     SqlAux1.Params[0].Value  := dm.SqlCga11cg11_cod.Value;
     SqlAux1.Params[1].Value  := Trim(EdPrimeiroNome.Text);
     SqlAux1.Params[2].Value  := Trim(EdSegundoNome.Text);
     SqlAux1.Params[3].Value  := Trim(EdEnd.Text);
     SqlAux1.Params[4].Value  := Trim(EdBairro.Text);
     SqlAux1.Params[5].Value  := Trim(EdCidade.Text);
     SqlAux1.Params[6].Value  := EdUf.Text;
     SqlAux1.Params[7].Value  := MkedCep.Text;
     SqlAux1.Params[8].Value  := 'Brasil';
     SqlAux1.Params[9].Value  := EdSexo.Text;
     SqlAux1.Params[10].Value := Trim(EdOutros.Text);
     SqlAux1.Params[11].Value := codcli;
     try
       SqlAux1.ExecSql;
       SqlCga10.Refresh;
       application.MessageBox('Alteração efetuada com sucesso','Ads',MB_OK+MB_ICONINFORMATION);
       limpa;
     except on e: exception do
       begin
         application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
         exit;
       end;
     end;
   end;
end;

procedure TFrmDigChristianSciense.BitBtn3Click(Sender: TObject);
begin
  altera;
end;

procedure TFrmDigChristianSciense.deleta;
begin
  if codcli <> Dm.SqlCga10cg10_codcli.Value then
    begin
      application.MessageBox('Selecione um registro para Deleta-lo','Ads',MB_OK+MB_ICONERROR);
      exit;
    end;
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('delete from cga10');
      SqlAux1.Sql.Add('where');
      SqlAux1.Sql.Add('cg10_codcli = :cg10_codcli');
      SqlAux1.Params[0].Value := SqlCga10cg10_codcli.Value;
      try
        SqlAux1.ExecSql;
        SqlCga10.Refresh;
        application.MessageBox('Registro deletado com sucesso','Ads',MB_OK+MB_ICONINFORMATION);
        limpa;
      except on e: exception do
        begin
          application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONINFORMATION);
        end;
      end;
    end;
end;

procedure TFrmDigChristianSciense.BitBtn4Click(Sender: TObject);
begin
  deleta;
end;

procedure TFrmDigChristianSciense.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
    begin
      SelectNext(ActiveControl,true,true);
    end;
end;

procedure TFrmDigChristianSciense.BitBtn1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
    begin
      SelectNext(ActiveControl,false,false);
      EdPrimeiroNome.SetFocus;
    end;
end;

procedure TFrmDigChristianSciense.MkedCepKeyPress(Sender: TObject;
  var Key: Char);
begin
  case key of
    #13:
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
              SqlCep.Params[0].Value := copy(MkedCep.Text,1,5)+copy(MkedCep.Text,7,3);
              SqlCep.Open;
              case SqlCep.RecordCount of
                0:
                  begin
                    EdEnd.SetFocus;
                    application.messagebox('Cep não encontrado','Ads',MB_OK+MB_ICONERROR);
                  end;
                1:
                  begin
                    EdEnd.Text    := SqlCeplogradouro.AsString +', N° ' ;
                    EdBairro.Text := SqlCepbairro.AsString;
                    EdCidade.Text := SqlCeplocalidade.AsString;
                    EdUf.Text     := SqlCepuf.AsString;
                    EdEnd.SetFocus;
                  end;
               else
                 begin
                   application.MessageBox('Inconsistencia digite o endereço','Ads',MB_OK+MB_ICONERROR);
                 end;
               end;  
            end;
        end;
  end;
end;

procedure TFrmDigChristianSciense.EdSexoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 4152 then
    salvar;
end;

procedure TFrmDigChristianSciense.DbLkVeiculoClick(Sender: TObject);
begin
  if Dm.SqlCga11cg11_sigla.Value = 'OU' then
    begin
      EdOutros.Enabled := true;
    end
  else
    begin
      EdOutros.Enabled := false;
    end;
end;

end.
