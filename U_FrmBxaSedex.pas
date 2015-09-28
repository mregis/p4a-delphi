unit U_FrmBxaSedex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, Mask;

type
  TFrmBxaSedex = class(TForm)
    Label14: TLabel;
    EdObjeto: TEdit;
    Label1: TLabel;
    EdJuncao: TEdit;
    Label4: TLabel;
    EdDpto: TEdit;
    Label5: TLabel;
    EdEnd: TEdit;
    Label6: TLabel;
    EdBairro: TEdit;
    Label7: TLabel;
    EdCid: TEdit;
    Label8: TLabel;
    EdUF: TEdit;
    Label9: TLabel;
    MkEdCep: TMaskEdit;
    Label2: TLabel;
    EdVol: TEdit;
    EdPeso: TEdit;
    Label11: TLabel;
    EdValor: TEdit;
    Label13: TLabel;
    EdVvalor: TEdit;
    Label15: TLabel;
    Edvaldec: TEdit;
    Label10: TLabel;
    EdNome: TEdit;
    Label12: TLabel;
    DBGridDados: TDBGrid;
    DBCboBxa: TDBLookupComboBox;
    Label3: TLabel;
    MkEdDtEntrega: TMaskEdit;
    Label16: TLabel;
    procedure MkEdDtEntregaKeyPress(Sender: TObject; var Key: Char);
    procedure EdNomeEnter(Sender: TObject);
    procedure MkEdDtEntregaEnter(Sender: TObject);
    procedure EdObjetoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure objtbsdx02;
    procedure atuddsag;
    procedure atudds;
    procedure bxaobj;
    procedure limpa;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBxaSedex: TFrmBxaSedex;

implementation

uses DmDados, U_Func;

{$R *.dfm}

procedure TFrmBxaSedex.BtnSairClick(Sender: TObject);
begin
  close;
end;

procedure TFrmBxaSedex.EdNomeEnter(Sender: TObject);
begin
  if EdObjeto.Text = '' then
    EdObjeto.SetFocus;
end;

procedure TFrmBxaSedex.EdObjetoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      if vernum(copy(EdObjeto.Text,3,9)) =  true then
          objtbsdx02
      else
        begin
          Application.MessageBox(PChar('Erro Ler Ou Digite Novamente'),'ADS',ID_OK);
          EdObjeto.Clear;
          EdObjeto.SetFocus;
          Exit;
        end;
    end;

end;

procedure TFrmBxaSedex.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action  :=  caFree;
end;

procedure TFrmBxaSedex.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    SelectNext(ActiveControl,true,true);

end;

procedure TFrmBxaSedex.FormShow(Sender: TObject);
begin
  Dm.Sqltbbxasdx.Close;
  Dm.Sqltbbxasdx.SQL.Clear;
  dm.Sqltbbxasdx.SQL.Add('Select * from tbbxasdx order by bxasdx_codbxa desc');
  Dm.Sqltbbxasdx.Open;
  DBCboBxa.KeyValue :=  Dm.Sqltbbxasdxbxasdx_codbxa.Value;
  DBCboBxa.Refresh;
  atudds;
end;
procedure TFrmBxaSedex.MkEdDtEntregaEnter(Sender: TObject);
begin
  if EdNome.Text = '' then
    EdNome.SetFocus;

end;

procedure TFrmBxaSedex.MkEdDtEntregaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      if MkEdDtEntrega.Text = '  /  /    ' then
        begin
          Application.MessageBox('Digite um Data Válida','ADS',IDOK);
          MkEdDtEntrega.SetFocus;
        end
      else
        bxaobj;
    end;

end;

procedure TFrmBxaSedex.objtbsdx02;
begin
  with dm do
    begin
//      selcga77 :=  'select cg77_ag,cg77_qtd from cga77 where (cg77_dtb = :dtb) limit 1';
      SqlAux4.Close;
      SqlAux4.SQL.Clear;
      SqlAux4.SQL.Add('select * from tbsdx02 where (sdx_numobj = :numobj)');
      SqlAux4.Params[0].AsString  :=  copy(EdObjeto.Text,3,9);
      SqlAux4.Open;
      if SqlAux4.RecordCount = 0 then
        Begin
          Application.MessageBox(PChar('Nenhum registro Encontrado'+chr(10)+EdObjeto.Text),'ADS',IDOK);
          EdObjeto.Clear;
          EdObjeto.SetFocus;
          Exit;
        end
      else
        atuddsag;
      //DBGridDados.Refresh;
//      verag;
    end;
end;
procedure TFrmBxaSedex.atuddsag;
begin
  with dm do
    begin
      EdJuncao.Text      :=  copy(SqlAux4.Fields[8].Text,1,4);
      EdDpto.Text        :=  SqlAux4.Fields[8].Text;
      EdEnd.Text         :=  SqlAux4.Fields[9].Text;
      EdCid.Text         :=  SqlAux4.Fields[10].Text;
      EdUF.Text          :=  SqlAux4.Fields[11].Text;
      MkEdCep.Text       :=  SqlAux4.Fields[12].AsString;
      EdVol.Text         :=  SqlAux4.Fields[25].AsString;
      EdPeso.Text        :=  FormatFloat('#,##0.000;;',SqlAux4.Fields[22].AsFloat);
      EdValor.Text       :=  FormatFloat('#,##0.00;;',SqlAux4.Fields[21].AsFloat);
      EdVvalor.Text      :=  FormatFloat('#,##0.00;;',SqlAux4.Fields[26].AsFloat);
      Edvaldec.Text      :=  FormatFloat('#,##0.00;;',SqlAux4.Fields[27].AsFloat);
    end;
end;
procedure TFrmBxaSedex.atudds;
begin
  Dm.SqlSdx4.Close;
  Dm.SqlSdx4.SQL.Clear;
  Dm.SqlSdx4.SQL.Add('Select * from tbsdx02 where (sdx_dtbaixa = :dt)');
  Dm.SqlSdx4.Params[0].Value  :=  Date;
  Dm.SqlSdx4.Open;
  DBGridDados.Refresh;
end;
procedure TFrmBxaSedex.bxaobj;
begin
  with dm do
    begin
    SqlAux4.Close;
    SqlAux4.SQL.Clear;
    SqlAux4.SQL.Add('update tbsdx02 set sdx_nomrecebe = :nome,sdx_dtentrega = :dt1,sdx_codbxa = :codbxa,sdx_codusu_bxa = :usuario,sdx_dtbaixa = (select current_date) where (sdx_numobj4 = :obj) and (sdx_dtbaixa is null)');
    SqlAux4.Params[0].Text  :=  trim(EdNome.Text);
    SqlAux4.Params[1].Text  :=  FormatDateTime('mm/dd/yyyy',StrToDate(MkEdDtEntrega.Text));
    SqlAux4.Params[2].Value :=  DBCboBxa.KeyValue;
    SqlAux4.Params[3].Value :=  sqlcga_acessocodigo.Value;
    SqlAux4.Params[4].Text  :=  trim(EdObjeto.Text);
    try
    SqlAux4.ExecSQL;
    atudds;
    limpa;
    EdObjeto.SetFocus;
    except on e: exception do
      begin
        Application.MessageBox(Pchar('Erro: '+e.Message+chr(10)+'Guarde o Protocolo e Informe o CPD'),'ADS',IDOK);
        EdObjeto.SetFocus;
      end;

    end;
    end;
end;
procedure TFrmBxaSedex.limpa;
begin
  EdObjeto.Clear;
  EdJuncao.Clear;
  EdDpto.Clear;
  EdEnd.Clear;
  EdBairro.Clear;
  EdCid.Clear;
  EdUF.Clear;
  EdVol.Clear;
  EdPeso.Clear;
  EdValor.Clear;
  EdVvalor.Clear;
  Edvaldec.Clear;
  MkEdCep.Clear;
end;
end.
