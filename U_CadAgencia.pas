unit U_CadAgencia;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Mask;

type
  TFrmCadAgBrad = class(TForm)
    ff: TScrollBox;
    Panel5: TPanel;
    EdCod: TEdit;
    Panel7: TPanel;
    EdUf: TEdit;
    Panel8: TPanel;
    EdNomeAg: TEdit;
    Btn_Salvar: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnDeletar: TBitBtn;
    BtnFechar: TBitBtn;
    DBGrid1: TDBGrid;
    BtnIncluir: TBitBtn;
    Panel1: TPanel;
    EdEnd: TEdit;
    Panel2: TPanel;
    Edcid: TEdit;
    Panel3: TPanel;
    MkEdCep: TMaskEdit;
    procedure EdCodChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure atualiza;
    procedure deletar;
    procedure alterar;
    procedure salvar;
    procedure limpa(tipo:Integer);
    procedure Btn_SalvarClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnDeletarClick(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnIncluirClick(Sender: TObject);
    procedure EdCodKeyPress(Sender: TObject; var Key: Char);
    procedure alttbsdx02;
    procedure selagbrad(tipo:Integer);
  private
   cod,numobj  : string;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadAgBrad: TFrmCadAgBrad;

implementation

uses DmDados, U_FrmRemessaSedex;

{$R *.dfm}

procedure TFrmCadAgBrad.limpa(tipo:Integer);
begin
  EdUf.Clear;
  EdNomeAg.Clear;
  EdEnd.Clear;
  Edcid.Clear;
  MkEdCep.Clear;
  case tipo of
    1:   EdCod.Clear;
  end;
end;
procedure TFrmCadAgBrad.alttbsdx02;
var cepalt:string;
begin
  with Dm do
    begin
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('update tbsdx02 set sdx_nomdest = :nome,sdx_endedest = :end, sdx_cidade = :cid,sdx_uf  = :uf,sdx_cep = :cep  ');
      SqlAux2.SQL.Add('where (substr(sdx_nomdest,1,4) = '+chr(39)+Format('%4.4d',[StrToInt(trim(EdCod.Text))])+chr(39)+') and (sdx_dtentrega is Null)');
      SqlAux2.Params[0].AsString  :=  Format('%4.4d',[StrToInt(trim(EdCod.Text))])+': '+trim(EdNomeAg.Text);
      SqlAux2.Params[1].AsString  :=  trim(EdEnd.Text);
      SqlAux2.Params[2].AsString  :=  trim(Edcid.Text);
      SqlAux2.Params[3].AsString  :=  trim(EdUf.Text);
//      cepalt  :=  StringReplace(MkEdCep.Text,'-','',[rfReplaceAll,rfIgnoreCase]);
      SqlAux2.Params[4].AsString  :=  StringReplace(MkEdCep.Text,'-','',[rfReplaceAll,rfIgnoreCase]);
//      SqlAux2.Params[5].AsString  :=  Format('%4.4d',[StrToInt(trim(EdCod.Text))]);
      try
        SqlAux2.ExecSQL;
        case  SqlAux2.RowsAffected of
          0:
            begin
            Application.MessageBox(PChar(IntToStr( SqlAux2.RowsAffected)),'ADS',IDOK);
            exit;
            end;
        end;

      except on e: exception do
        application.MessageBox(PChar(e.Message),'ADS',ID_OK);
      end;
    end;
    MkEdCep.EditMask  :=  '09999\-000;0;_';

end;

procedure TFrmCadAgBrad.salvar;
begin
  if (EdCod.Text <> '') and (trim(EdNomeAg.Text) <> '') and (trim(EdUf.Text) <> '') and (trim(Edcid.Text) <> '')  and
      (Trim(MkEdCep.Text) <> '')  and (trim(EdEnd.Text)<> '') and (length(trim(MkEdCep.Text)) > 6) then
    begin
      with dm do
        begin
          SqlAux1.close;
          SqlAux1.sql.Clear;
          SqlAux1.sql.Add('insert into tbbraddptos (juncao,depto,ender,cep,cidade,uf) values (');
          SqlAux1.sql.Add('                   :codag,:nome,:end,:cep,:cid,:uf)');
          SqlAux1.Params[0].AsString := trim(EdCod.Text);
          SqlAux1.Params[1].AsString := Trim(EdNomeAg.Text);
          SqlAux1.Params[2].AsString := trim(EdEnd.Text);
          SqlAux1.Params[3].AsString := MkEdCep.Text;
          SqlAux1.Params[4].AsString := trim(Edcid.Text);
          SqlAux1.Params[5].AsString := trim(EdUf.Text);
          try
            SqlAux1.ExecSql;
            SqlTbBradDeptos.Refresh;
            application.MessageBox('Inclus�o feita com sucesso','Ads',MB_OK+MB_ICONINFORMATION);
            alttbsdx02;
            limpa(1);
          except on e: exception do
            begin
              application.MessageBox(PChar('Ocorreu um erro falta: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
            end;
          end;
        end;
    end
  else
    begin
      application.MessageBox('Preencha todos os campos','Ads',MB_OK+MB_ICONERROR);
      exit;
    end;
end;

procedure TFrmCadAgBrad.Btn_SalvarClick(Sender: TObject);
begin
  salvar;
end;

procedure TFrmCadAgBrad.alterar;
begin
  if (StrToInt(cod) = Dm.SqlTbBradDeptosjuncao.AsInteger) then
    begin
      if (EdCod.Text <> '') and (trim(EdNomeAg.Text) <> '') and (trim(EdUf.Text) <> '') and (trim(Edcid.Text) <> '')  and
          (Trim(MkEdCep.Text) <> '')  and (trim(EdEnd.Text)<> '') and (length(trim(MkEdCep.Text)) >6) then
        begin
          with dm do
            begin
              SqlAux1.close;
              SqlAux1.sql.Clear;
              SqlAux1.sql.Add('update tbbraddptos set depto=:nome,uf=:uf,cidade=:cid,cep=:cep,ender=:end where (tbbraddptos.juncao =:codag)');
              SqlAux1.Params[0].Value := Trim(EdNomeAg.Text);
              SqlAux1.Params[1].Value := Trim(EdUf.Text);
              SqlAux1.Params[2].Value := Trim(Edcid.Text);
              SqlAux1.Params[3].Value := Trim(MkEdCep.Text);
              SqlAux1.Params[4].Value := trim(EdEnd.Text);
              SqlAux1.Params[5].Value := SqlTbBradDeptosjuncao.Value;
              try
                SqlAux1.ExecSql;
                SqlTbBradDeptos.Refresh;
                application.MessageBox('Altera��o feita com sucesso','Ads',MB_OK+MB_ICONINFORMATION);
                alttbsdx02;
                limpa(1);
              except on e: exception do
                begin
                  application.MessageBox(PChar('Ocorreu um erro faltal: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
                end;
              end;
            end;
        end
      else
        begin
          application.MessageBox('Preencha todos os campos','Ads',MB_OK+MB_ICONERROR);
          exit;
        end;
    end
  else
    begin
      application.MessageBox('Selecione uma Agencia para depois altera-la','Ads',MB_OK+MB_ICONERROR);
      exit;
    end;
end;

procedure TFrmCadAgBrad.BtnAlterarClick(Sender: TObject);
begin
  alterar;
end;

procedure TFrmCadAgBrad.deletar;
begin
  with dm do
    begin
      SqlAux2.close;
      SqlAux2.sql.Clear;
      SqlAux2.sql.Add('select sdx_numobj from  tbsdx02 where (substr(sdx_nomdest,1,4) = :codag) limit 1');
      SqlAux2.Params[0].AsString :=Dm.SqlTbBradDeptosjuncao.AsString;
      SqlAux2.Open;
      case SqlAux2.RecordCount of
        0:
          begin
            if (StrToInt(cod) = Dm.SqlTbBradDeptosjuncao.Value) then
              begin
                SqlAux1.close;
                SqlAux1.sql.Clear;
                SqlAux1.sql.Add('delete from  SqlTbBradDeptos where (SqlTbBradDeptosjuncao = :codag');
                SqlAux1.Params[0].Value :=  SqlTbBradDeptosjuncao.Value ;
                try
                  SqlAux1.ExecSql;
                  SqlCga14.Refresh;
                  application.MessageBox('Agencia deletada','Ads',MB_OK+MB_ICONINFORMATION);
                  limpa(1);
                except on e: exception do
                    application.MessageBox(PChar('Ocorreu um erro faltal: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
                end;
              end
            else
              begin
                application.MessageBox('Selecione uma Agencia para depois deleta-la','Ads',MB_OK+MB_ICONERROR);
                exit;
              end;
          end;
        else
          application.MessageBox(PChar('N�o � poss�vel excluir ag�ncia, '+chr(10)+'existe registro com rela��o no AR'),'ADS',IDOK);
      end;
    end;
end;

procedure TFrmCadAgBrad.BtnDeletarClick(Sender: TObject);
begin
  case Dm.sqlcga_acessocodigo.AsInteger of
    200: deletar;
    else
      Application.MessageBox(Pchar('Sem Permiss�o'),'ADS',IDOK);
  end;
end;

procedure TFrmCadAgBrad.atualiza;
begin
  EdCod.Text    := Dm.SqlTbBradDeptosjuncao.AsString;
  EdNomeAg.Text := Dm.SqlTbBradDeptosdepto.AsString;
  EdEnd.Text    := Dm.SqlTbBradDeptosender.AsString;
  Edcid.Text    := Dm.SqlTbBradDeptoscidade.AsString;
  EdUf.Text     := Dm.SqlTbBradDeptosuf.AsString;
  MkEdCep.Text  := Dm.SqlTbBradDeptoscep.AsString;
  cod           := Dm.SqlTbBradDeptosjuncao.AsString;
end;

procedure TFrmCadAgBrad.DBGrid1DblClick(Sender: TObject);
begin
  case dm.SqlTbBradDeptos.RecordCount of
    0:  limpa(0);//
    else
    atualiza;
  end;
end;

procedure TFrmCadAgBrad.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case dm.SqlTbBradDeptos.RecordCount of
    0:  limpa(0);//
    else
    atualiza;
  end;
end;

procedure TFrmCadAgBrad.DBGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  case dm.SqlTbBradDeptos.RecordCount of
    0:  limpa(0);//
    else
    atualiza;
  end;
end;

procedure TFrmCadAgBrad.BtnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFrmCadAgBrad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Dm.SqlCga14.Close;
  action := cafree;
end;

procedure TFrmCadAgBrad.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
  FrmCadAgBrad.SelectNext(ActiveControl,true,true);

end;
procedure TFrmCadAgBrad.selagbrad(tipo:Integer);
begin
  Dm.SqlTbBradDeptos.Close;
  Dm.SqlTbBradDeptos.Sql.Clear;
  Dm.SqlTbBradDeptos.Sql.Add('select * from tbbraddptos ');
  case tipo of
    1 :   Dm.SqlTbBradDeptos.Sql.Add('where (juncao Ilike'+chr(39)+Edcod.Text+'%'+chr(39)+')');
  end;
  Dm.SqlTbBradDeptos.Sql.Add('order by juncao');
  Dm.SqlTbBradDeptos.Open;
  case dm.SqlTbBradDeptos.RecordCount of
    0:  limpa(0);//
    else
    atualiza;

  end;
end;


procedure TFrmCadAgBrad.FormShow(Sender: TObject);
begin
  selagbrad(0);
end;

procedure TFrmCadAgBrad.BtnIncluirClick(Sender: TObject);
begin
  limpa(1);
end;

procedure TFrmCadAgBrad.EdCodChange(Sender: TObject);
begin
  selagbrad(1);
end;

procedure TFrmCadAgBrad.EdCodKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) then
    selagbrad(1);
//  Dm.SqlCga14.Sql.Clear;
//  Dm.SqlCga14.Sql.Add('select * from cga14 where cg14_codag =:codag');
//  Dm.SqlCga14.Params[0].Value := Trim(EdCod.Text+key);
//  Dm.SqlCga14.Open;
//  Dm.SqlCga14.Refresh;
end;

end.

