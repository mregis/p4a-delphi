unit U_Dig_Previdencia_Bradesco;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, DBCtrls, Buttons, Grids, DBGrids, Mask,
  ExtCtrls;

type
  TFrm_Dig_Previdencia_Bradesco = class(TForm)
    ScrollBox1: TScrollBox;
    Bevel1: TBevel;
    Panel7: TPanel;
    EdQt: TEdit;
    Panel8: TPanel;
    EdNome: TEdit;
    Panel9: TPanel;
    EdComplemento: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel11: TPanel;
    EdEnd: TEdit;
    EdBairro: TEdit;
    EdCidade: TEdit;
    MkedCep: TMaskEdit;
    EdUf: TEdit;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Panel5: TPanel;
    EdNumero: TEdit;
    EdErro: TEdit;
    Panel12: TPanel;
    procedure consistencia(tipo:integer);
    procedure deletar;
    procedure alterar;
    procedure salvar;
    procedure limpa;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure MkedCepKeyPress(Sender: TObject; var Key: Char);
    procedure atualiza;
    procedure BitBtn5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    cod : string;
    testa : boolean;
    { Private declarations }
  public
   dtb : string;
   qtdig,qterro : integer;
    { Public declarations }
  end;

var
  Frm_Dig_Previdencia_Bradesco: TFrm_Dig_Previdencia_Bradesco;

implementation

uses DmDados, DB, Math;

{$R *.dfm}

procedure TFrm_Dig_Previdencia_Bradesco.limpa;
begin
  MkedCep.Clear;
  EdNome.Clear;
  EdEnd.Clear;
  EdNumero.Clear;
  EdComplemento.Clear;
  EdBairro.Clear;
  EdCidade.Clear;
  EdUf.Clear;
  EdErro.Clear;
  cod := 'x';
  EdNome.SetFocus;
end;

procedure TFrm_Dig_Previdencia_Bradesco.consistencia(tipo:integer);
begin
  testa := false;
  case tipo of
    1:
      begin
        if Trim(EdNome.Text) = '' then
          begin
            testa := true;
            Application.MessageBox('Digite o nome','Ads',MB_OK+MB_ICONWARNING);
            EdNome.SetFocus;
            exit;
          end;
        if Trim(MkedCep.Text) = '' then
          begin
            testa := true;
            application.MessageBox('Digite o cep','Ads',MB_OK+MB_ICONWARNING);
            MkedCep.SetFocus;
            exit;
          end;
        if Trim(EdEnd.Text) = '' then
          begin
            testa := true;
            application.MessageBox('Digite o nome','Ads',MB_OK+MB_ICONWARNING);
            EdEnd.SetFocus;
            exit;
          end;
        if Trim(EdNumero.Text) = '' then
          begin
            testa := true;
            application.MessageBox('Digite o numero','Ads',MB_OK+MB_ICONWARNING);
            EdNumero.SetFocus;
            exit;
          end;
        if Trim(EdBairro.Text) = '' then
          begin
            testa := true;
            application.MessageBox('Digite o bairro','Ads',MB_OK+MB_ICONWARNING);
            EdBairro.SetFocus;
            exit;
          end;
        if Trim(EdCidade.Text) = '' then
          begin
            testa := true;
            application.MessageBox('Digite o cidade','Ads',MB_OK+MB_ICONWARNING);
            EdCidade.SetFocus;
            exit;
          end;
        if Trim(EdUf.Text) = '' then
          begin
            testa := true;
            application.MessageBox('Digite a UF','Ads',MB_OK+MB_ICONWARNING);
            EdUf.SetFocus;
            exit;
          end;
      end;
    2:
      begin
        if Trim(EdErro.Text) = '' then
          begin
            testa := true;
            application.MessageBox('Digite o Erro','Ads',MB_OK+MB_ICONWARNING);
            EdErro.SetFocus;
            exit;
          end;
      end;
   end;
end;

procedure TFrm_Dig_Previdencia_Bradesco.atualiza;
begin
  EdNome.Text         := Dm.SqlCga40cg40_nome.AsString;
  MkedCep.Text        := Dm.SqlCga40cg40_cep.AsString;
  EdEnd.Text          := Dm.SqlCga40cg40_ende.AsString;
  EdNumero.Text       := Dm.SqlCga40cg40_num.AsString;
  EdComplemento.Text  := Dm.SqlCga40cg40_compl.AsString;
  EdBairro.Text       := Dm.SqlCga40cg40_bairro.AsString;
  EdCidade.Text       := Dm.SqlCga40cg40_cid.AsString;
  EdUf.Text           := Dm.SqlCga40cg40_uf.AsString;
  if Dm.SqlCga40cg40_coderro.AsString <> '-1' then
    EdErro.Text         := Dm.SqlCga40cg40_coderro.AsString;
  cod                 := Dm.SqlCga40cg40_remes.AsString;
end;

procedure TFrm_Dig_Previdencia_Bradesco.BitBtn1Click(Sender: TObject);
begin
  limpa;
end;

procedure TFrm_Dig_Previdencia_Bradesco.salvar;
begin
  if Trim(EdErro.Text) = '' then
    begin
      consistencia(1);
      if testa = true then
        exit;
      Dm.SqlAux1.Close;
      Dm.SqlAux1.Sql.Clear;
      Dm.SqlAux1.Sql.Add('insert into cga40 (');
      Dm.SqlAux1.Sql.Add('cg40_bairro,cg40_cep,cg40_cid,');
      Dm.SqlAux1.Sql.Add('cg40_codusu,cg40_compl,cg40_data,cg40_ende,');
      Dm.SqlAux1.Sql.Add('cg40_ncont,cg40_nome,cg40_nsuc,cg40_num,cg40_uf,cg40_ordimp)');
      Dm.SqlAux1.Sql.Add(' values ');
      Dm.SqlAux1.Sql.Add('(:cg40_bairro,:cg40_cep,:cg40_cid,');
      Dm.SqlAux1.Sql.Add(':cg40_codusu,:cg40_compl,:cg40_data,:cg40_ende,');
      Dm.SqlAux1.Sql.Add(':cg40_ncont,:cg40_nome,:cg40_nsuc,:cg40_num,:cg40_uf,:cg40_ordimp)');
      Dm.SqlAux1.Params[0].Value  := Trim(EdBairro.Text);
      Dm.SqlAux1.Params[1].Value  := Trim(MkedCep.Text);
      Dm.SqlAux1.Params[2].Value  := Trim(EdCidade.Text);
      Dm.SqlAux1.Params[3].Value  := Dm.sqlcga_acessocodigo.Value;
      Dm.SqlAux1.Params[4].Value  := Trim(EdComplemento.Text);
      Dm.SqlAux1.Params[5].AsString :=  formatdatetime('mm-dd-yyyy',date);
      Dm.SqlAux1.Params[6].Value  := Trim(EdEnd.Text);
      Dm.SqlAux1.Params[7].Value  := Dm.SqlCga42cg42_ncont.Value;
      Dm.SqlAux1.Params[8].Value  := Trim(EdNome.Text);
      Dm.SqlAux1.Params[9].Value  := Dm.SqlCga42cg42_codsuc.Value;
      Dm.SqlAux1.Params[10].Value := Trim(EdNumero.Text);
      Dm.SqlAux1.Params[11].Value := EdUf.Text;
      if qtdig = null then
        Dm.SqlAux1.Params[12].Value := 1
      else
        qtdig := qtdig + 1;
        Dm.SqlAux1.Params[12].Value := qtdig ;
      try
        Dm.SqlAux1.ExecSql;
        EdQt.Text := inttostr(1+strtoint(EdQt.Text));
        Dm.SqlAux1.Close;
        Dm.SqlAux1.Sql.Clear;
        Dm.SqlAux1.Sql.Add('update cga42 set cg42_qtdig =:qtdig where cg42_ncont=:cg42_ncont');
        Dm.SqlAux1.Params[0].Value := qtdig;
        Dm.SqlAux1.Params[1].Value := dtb;
        Dm.SqlAux1.ExecSql;
        Dm.SqlCga40.Refresh;
        limpa;
      except on e: exception do
        begin
          application.MessageBox(PChar('Ocorreu um erro faltal: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
        end;
      end;
    end
  else
    begin
      if application.MessageBox('Deseja realmente incluir um erro?','Ads',MB_YESNO+MB_ICONQUESTION) = idyes  then
        begin
          consistencia(2);
          if testa = true then
            exit;
          Dm.SqlAux1.Close;
          Dm.SqlAux1.Sql.Clear;
          Dm.SqlAux1.Sql.Add('insert into cga40 (');
          Dm.SqlAux1.Sql.Add('cg40_coderro,cg40_codusu,cg40_ncont,cg40_nsuc)');
          Dm.SqlAux1.Sql.Add(' values ');
          Dm.SqlAux1.Sql.Add('(:cg40_coderro,:cg40_codusu,:cg40_ncont,:cg40_nsuc)');
          Dm.SqlAux1.Params[0].Value  := strtoint(EdErro.Text);
          Dm.SqlAux1.Params[1].Value  := Dm.sqlcga_acessocodigo.Value;
          Dm.SqlAux1.Params[2].Value  := Dm.SqlCga42cg42_ncont.Value;
          Dm.SqlAux1.Params[3].Value  := Dm.SqlCga42cg42_codsuc.Value;
          try
            Dm.SqlAux1.ExecSql;
            EdQt.Text := inttostr(1+strtoint(EdQt.Text));
            Dm.SqlAux1.Close;
            Dm.SqlAux1.Sql.Clear;
            Dm.SqlAux1.Sql.Add('update cga42 set cg42_erros =:erros where cg42_ncont=:cg42_ncont');
            qterro := qterro + 1;
            Dm.SqlAux1.Params[0].Value := qterro;
            Dm.SqlAux1.Params[1].Value := dtb;
            Dm.SqlAux1.ExecSql;
            Dm.SqlCga40.Refresh;
            limpa;
          except on e: exception do
            begin
              application.MessageBox(PChar('Ocorreu um erro faltal: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
            end;
          end;
        end;
    end;
end;

procedure TFrm_Dig_Previdencia_Bradesco.BitBtn2Click(Sender: TObject);
begin
  salvar;
end;

procedure TFrm_Dig_Previdencia_Bradesco.MkedCepKeyPress(Sender: TObject;
  var Key: Char);
begin
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
              SqlCep.Params[0].Value := MkedCep.Text;
              SqlCep.Open;
              case SqlCep.RecordCount of
                0:
                  begin
                    EdEnd.SetFocus;
                    application.messagebox('Cep não encontrado','Ads',MB_OK+MB_ICONERROR);
                  end;
                1:
                  begin
                    EdEnd.Text    := SqlCeplogradouro.AsString;
                    EdBairro.Text := SqlCepbairro.AsString;
                    EdCidade.Text := SqlCeplocalidade.AsString;
                    EdUf.Text     := SqlCepuf.AsString;
                    EdNumero.SetFocus;
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

end;

procedure TFrm_Dig_Previdencia_Bradesco.BitBtn5Click(Sender: TObject);
begin
  close;
end;

procedure TFrm_Dig_Previdencia_Bradesco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := cafree;
  Dm.SqlCga40.Close;
  Dm.SqlCga42.Refresh;
end;

procedure TFrm_Dig_Previdencia_Bradesco.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 4152 then
    salvar;
end;

procedure TFrm_Dig_Previdencia_Bradesco.DBGrid1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  atualiza;
end;

procedure TFrm_Dig_Previdencia_Bradesco.DBGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  atualiza;
end;

procedure TFrm_Dig_Previdencia_Bradesco.deletar;
var
  erro : integer;
begin
  erro := 0; //sem erro
  if Trim(Dm.SqlCga40cg40_coderro.AsString) <> '' then
    erro := 1; //com erro
  case Dm.SqlCga40.RecordCount of
    0: exit;
  end;
  if cod = Dm.SqlCga40cg40_remes.AsString then
    begin
      Dm.SqlAux1.Close;
      Dm.SqlAux1.Sql.Clear;
      Dm.SqlAux1.Sql.Add('delete from cga40 where cg40_remes=:cg40_remes');
      Dm.SqlAux1.Params[0].Value := Dm.SqlCga40cg40_remes.Value;
      Dm.SqlAux1.ExecSql;
      limpa;
      Dm.SqlCga40.Refresh;
      case erro of
       0:
         begin
           EdQt.Text := inttostr(strtoint(EdQt.Text)-1);
           Dm.SqlAux1.Close;
           Dm.SqlAux1.Sql.Clear;
           Dm.SqlAux1.Sql.Add('update cga42 set cg42_qtdig =:qtdig where cg42_ncont=:cg42_ncont');
           qtdig := qtdig - 1;
           Dm.SqlAux1.Params[0].Value := qtdig;
           Dm.SqlAux1.Params[1].Value := dtb;
         end;
       1:
         begin
            EdQt.Text := inttostr(strtoint(EdQt.Text)-1);
            Dm.SqlAux1.Close;
            Dm.SqlAux1.Sql.Clear;
            Dm.SqlAux1.Sql.Add('update cga42 set cg42_erros =:erros where cg42_ncont=:cg42_ncont');
            qterro := qterro - 1;
            Dm.SqlAux1.Params[0].Value := qterro;
            Dm.SqlAux1.Params[1].Value := dtb;
         end;
      end;
      Dm.SqlAux1.ExecSql;
    end
  else
    begin
      application.MessageBox('Selecione um registro para depois deletalo','Ads',MB_OK+MB_ICONERROR);
      exit;
    end;
end;

procedure TFrm_Dig_Previdencia_Bradesco.alterar;
begin
  if Trim(EdErro.Text) = '' then
    begin
      consistencia(1);
      if testa = true then
        exit;
      Dm.SqlAux1.Close;
      Dm.SqlAux1.Sql.Clear;
      Dm.SqlAux1.Sql.Add('update cga40 set');
      Dm.SqlAux1.Sql.Add('cg40_bairro=:cg40_bairro,cg40_cep=:cg40_cep,cg40_cid=:cg40_cid,');
      Dm.SqlAux1.Sql.Add('cg40_compl=:cg40_compl,cg40_ende=:cg40_ende,');
      Dm.SqlAux1.Sql.Add('cg40_nome=:cg40_nome,cg40_num=:cg40_num,cg40_uf=:cg40_uf');
      Dm.SqlAux1.Sql.Add(' where ');
      Dm.SqlAux1.Sql.Add('cg40_remes =:cg40_remes');
      Dm.SqlAux1.Params[0].Value  := Trim(EdBairro.Text);
      Dm.SqlAux1.Params[1].Value  := Trim(MkedCep.Text);
      Dm.SqlAux1.Params[2].Value  := Trim(EdCidade.Text);
      Dm.SqlAux1.Params[3].Value  := Trim(EdComplemento.Text);
      Dm.SqlAux1.Params[4].Value  := Trim(EdEnd.Text);
      Dm.SqlAux1.Params[5].Value  := Trim(EdNome.Text);
      Dm.SqlAux1.Params[6].Value  := Trim(EdNumero.Text);
      Dm.SqlAux1.Params[7].Value  := EdUf.Text;
      Dm.SqlAux1.Params[8].Value  := cod;
      try
        Dm.SqlAux1.ExecSql;
        Dm.SqlCga40.Refresh;
        limpa;
      except on e: exception do
        begin
          application.MessageBox(PChar('Ocorreu um erro faltal: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
        end;
      end;
    end
  else
    begin
      if application.MessageBox('Deseja realmente alterar o erro?','Ads',MB_YESNO+MB_ICONQUESTION) = idyes then
        begin
          consistencia(2);
          if testa = true then
            exit;
          Dm.SqlAux1.Close;
          Dm.SqlAux1.Sql.Clear;
          Dm.SqlAux1.Sql.Add('update cga40 set');
          Dm.SqlAux1.Sql.Add('cg40_coderro =:cg40_coderro ');
          Dm.SqlAux1.Sql.Add(' where ');
          Dm.SqlAux1.Sql.Add('cg40_remes=:cg40_remes');
          Dm.SqlAux1.Params[0].Value  := strtoint(EdErro.Text);
          Dm.SqlAux1.Params[1].Value  := cod;
          try
            Dm.SqlAux1.ExecSql;
            Dm.SqlCga40.Refresh;
            limpa;
          except on e: exception do
            begin
              application.MessageBox(PChar('Ocorreu um erro faltal: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
            end;
          end;
        end;
    end;
end;

procedure TFrm_Dig_Previdencia_Bradesco.BitBtn4Click(Sender: TObject);
begin
  deletar;
end;

procedure TFrm_Dig_Previdencia_Bradesco.BitBtn3Click(Sender: TObject);
begin
  alterar;
end;

end.
