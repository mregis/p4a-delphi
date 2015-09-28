unit U_ImpPrev;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TFrmImpPrevidencia = class(TForm)
    ScrollBox1: TScrollBox;
    Panel1: TPanel;
    Panel11: TPanel;
    EdDtb: TEdit;
    BitBtn1: TBitBtn;
    BitBtn5: TBitBtn;
    Bevel1: TBevel;
    ChkIntervalo: TCheckBox;
    Panel2: TPanel;
    EdIni: TEdit;
    EdFin: TEdit;
    Panel3: TPanel;
    procedure imprimir;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure ChkIntervaloClick(Sender: TObject);
  private
    select : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmImpPrevidencia: TFrmImpPrevidencia;

implementation

uses DmDados, U_FrRel_Etiqueta;

{$R *.dfm}

procedure TFrmImpPrevidencia.imprimir;
begin
  with dm do
    begin
      ////// limpa cga44 ////////
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('delete from cga44');
      SqlAux1.ExecSql;
      /////// reinicia a sequencia /////
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('select setval (''"cga44_cg40_remes_seq"'',1,false)');
      SqlAux1.ExecSql;
      /////// prepara registros para serem impressos /////
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('insert into cga44(select cga40.cg40_nome,');
      SqlAux1.Sql.Add('cga40.cg40_ende,cga40.cg40_compl,');
      SqlAux1.Sql.Add('cga40.cg40_num,cga40.cg40_bairro,cga40.cg40_cid,');
      SqlAux1.Sql.Add('cga40.cg40_uf,cga40.cg40_cep,cga40.cg40_nsuc');
      SqlAux1.Sql.Add('from cga40 where (cga40.cg40_ncont = :cg40_ncont) and (cga40.cg40_coderro = -1) order by cga40.cg40_remes)');
      SqlAux1.Params[0].Value := Trim(EdDtb.Text);
      SqlAux1.ExecSql;
      //////// abre tabela ////////////
      SqlCga44.Close;
      SqlCga44.Sql.Clear;
      SqlCga44.Sql.Add(select);
      SqlCga44.Open;
      case SqlCga44.RecordCount of
        0: application.MessageBox('Não foram encontrados registros com este numero de DTB','Ads',MB_OK+MB_ICONWARNING);
      else
        begin
          application.CreateForm(TFrFrmImpEtiqueta,FrFrmImpEtiqueta);
         //FrFrmImpEtiqueta.RLReport1.PreviewModal;
         FrFrmImpEtiqueta.RLReport1.Print;
        end;
      end;
    end;
end;

procedure TFrmImpPrevidencia.BitBtn1Click(Sender: TObject);
begin
  if ChkIntervalo.Checked = true then
    select := 'select * from cga44 where ( cga44.cg40_remes between '+EdIni.Text+' and '+Edfin.Text+')'+' order by cga44.cg40_remes'
  else
    select := 'select * from cga44 order by cga44.cg40_remes';
  imprimir;
  setfocus;
end;

procedure TFrmImpPrevidencia.BitBtn5Click(Sender: TObject);
begin
  close;
end;

procedure TFrmImpPrevidencia.ChkIntervaloClick(Sender: TObject);
begin
  if ChkIntervalo.Checked = true then
    begin
      EdIni.Enabled := true;
      EdFin.Enabled := true;
    end
  else
    begin
      EdIni.Clear;
      EdIni.Enabled := false;
      EdFin.Clear;
      EdFin.Enabled := false;
    end;
end;

end.
