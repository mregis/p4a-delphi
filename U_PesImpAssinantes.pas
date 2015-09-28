unit U_PesImpAssinantes;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Mask, Buttons, ExtCtrls, ComCtrls;

type
  TFrmPesImpAssinantes = class(TForm)
    ScrollBox1: TScrollBox;
    Panel5: TPanel;
    Panel9: TPanel;
    BtnFechar: TBitBtn;
    Btn_Salvar: TBitBtn;
    EdEdicao: TEdit;
    EdHPo: TEdit;
    CboEnviados: TComboBox;
    Panel1: TPanel;
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Btn_SalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPesImpAssinantes: TFrmPesImpAssinantes;

implementation

uses DmDados, DB, U_FrmFrEtiqueta;

{$R *.dfm}

procedure TFrmPesImpAssinantes.BtnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFrmPesImpAssinantes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := cafree;
  FrmPesImpAssinantes := nil;
end;

procedure TFrmPesImpAssinantes.Btn_SalvarClick(Sender: TObject);
begin
  Btn_Salvar.Enabled := false;
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('insert into cga08 (');
      SqlAux1.Sql.Add('select  cga10.cg10_codcli,  cga07.cg07_codedicao');
      SqlAux1.Sql.Add(' from  cga10,  cga07 where (cga07.cg07_codedicao =:CodEdi) AND');
      SqlAux1.Sql.Add(' (cga10.cg10_assinante =:Assinante ) and cga10.cg10_codcli not in');
      SqlAux1.Sql.Add(' (select cga08.cg08_codcli from cga08 where (cga08.cg08_codedicao = cga07.cg07_codedicao)');
      SqlAux1.Sql.Add(' and (cga08.cg08_codcli =  cga10.cg10_codcli)))');
      SqlAux1.Params[0].Value := strtoint(Trim(EdEdicao.Text));
      SqlAux1.Params[1].Value := 'S';
      SqlAux1.ExecSql;
      SqlRel.Close;
      SqlRel.Sql.Clear;
      SqlRel.Sql.Add('select cg10_pnome,cg10_snome,cg10_endereco,');
      SqlRel.Sql.Add('cg10_bairro,cg10_cidade,cg10_uf,cg10_cep,cg10_codcli from cga10 ');
      case CboEnviados.ItemIndex of
        0: SqlRel.Sql.Add(' where cg10_codcli in (select cga08.cg08_codcli from cga08 where cga08.cg08_dtimp is not null)');
        1: SqlRel.Sql.Add(' where cg10_codcli in (select cga08.cg08_codcli from cga08 where cga08.cg08_dtimp is null)');
      end;
      if Trim(EdHPo.Text) <> '' then
        begin
          SqlRel.Sql.Add(' and (cg10_codcli =:codcli)');
          SqlRel.ParamByName('codcli').Value := strtoint(Trim(EdHPo.Text));
        end;
      SqlRel.Sql.Add(' order by cga10.cg10_codcli');
      SqlRel.Open;
      case SqlRel.RecordCount of
        0:
          begin
            Application.MessageBox('Não foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
          end;
      else
        begin
          case CboEnviados.ItemIndex of
            0:
              begin
                SqlAux1.Close;
                SqlAux1.Sql.Clear;
                SqlAux1.Sql.Add('update cga08 set cg08_dtimp =:dtimp where cg08_dtimp is not null');
                SqlAux1.Params[0].AsString := formatdatetime('dd-mm-yyyy',date);
                SqlAux1.ExecSql;
              end;
            1:
              begin
                SqlAux1.Close;
                SqlAux1.Sql.Clear;
                SqlAux1.Sql.Add('update cga08 set cg08_dtimp =:dtimp where cg08_dtimp is null');
                SqlAux1.Params[0].AsString := formatdatetime('dd-mm-yyyy',date);
                SqlAux1.ExecSql;
              end;
          end;
          Application.CreateForm(TFrmFrEtiqueta,FrmFrEtiqueta);
          FrmFrEtiqueta.RLReport1.PreviewModal;
          FrmFrEtiqueta.RLReport1.Destroy;

        end;
      end;
    end;
  Btn_Salvar.Enabled := true;
  setfocus;
end;

end.
