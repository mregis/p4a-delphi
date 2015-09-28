unit U_CadSucursal;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, Mask;

type
  TFrmCadSucursal = class(TForm)
    ScrollBox1: TScrollBox;
    Bevel1: TBevel;
    BtnIncluir: TBitBtn;
    BtnSalvar: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnDeletar: TBitBtn;
    BtnSair: TBitBtn;
    DBGridAg: TDBGrid;
    Panel2: TPanel;
    Panel3: TPanel;
    EdCod: TEdit;
    EdAgencia: TEdit;
    Panel1: TPanel;
    EdEnd: TEdit;
    EdCid: TEdit;
    EdUf: TEdit;
    Panel4: TPanel;
    MkEdCep: TMaskEdit;
    Panel5: TPanel;
    Panel6: TPanel;
    procedure EdCodKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure DBGridAgKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridAgKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridAgCellClick(Column: TColumn);
    procedure altera;
    procedure atualiza;
    procedure salvar;
    procedure limpa;
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure DBGridAgKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure selagencia;
  private
    cod : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadSucursal: TFrmCadSucursal;

implementation

uses DmDados, ZAbstractDataset, ZDataset, U_Func;

{$R *.dfm}
procedure TFrmCadSucursal.limpa;
begin
  MkEdCep.Clear;
  EdAgencia.Clear;
  EdCod.Clear;
  EdEnd.Clear;
  EdCid.Clear;
  EdUf.Clear;
  EdCod.SetFocus;
  cod := 'x';
end;

procedure TFrmCadSucursal.BtnIncluirClick(Sender: TObject);
begin
  limpa;
end;

procedure TFrmCadSucursal.BtnSalvarClick(Sender: TObject);
begin
  salvar;
end;

procedure TFrmCadSucursal.salvar;
begin
  if (trim(EdCod.Text) = '') then
    begin
      Application.MessageBox('Digite o Código da Agência','ADS',ID_OK);
      EdCod.SetFocus;
      Exit;
    end;
  if (vernum(trim(EdCod.Text)) = false ) then
    begin
      Application.MessageBox('Digite Somente Nº','ADS',ID_OK);
      EdCod.SetFocus;
      Exit;
    end;
  with dm do
    begin
      SqlAux1.close;
      SqlAux1.sql.Clear;
      SqlAux1.sql.Add('insert into tbbraddptos (juncao,depto,ender,cep,cidade,uf) values (:ag,:dpto,:end,:cep,:cid,:uf)');
      SqlAux1.Params[0].Text  :=  Trim(EdCod.Text);
      SqlAux1.Params[1].Text  :=  Trim(EdAgencia.Text);
      SqlAux1.Params[2].Text  :=  trim(EdEnd.Text);
      SqlAux1.Params[3].Text  :=  trim(MkEdCep.Text);
      SqlAux1.Params[4].Text  :=  trim(EdCid.Text);
      SqlAux1.Params[5].Text  :=  trim(EdUf.Text);
      try
        SqlAux1.ExecSql;
        SqlTbBradDeptos.Refresh;
        application.MessageBox('Inclusão feita com sucesso','Ads',MB_OK+MB_ICONINFORMATION);
        limpa;
      except on e: exception do
        begin
          application.MessageBox(PChar('Ocorreu um erro falta: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
        end;
      end;
    end;
end;


procedure TFrmCadSucursal.altera;
begin
  with dm do
   begin
     SqlAux1.Close;
     SqlAux1.Sql.Clear;
     SqlAux1.Sql.Add('update TbBradDptos set depto = :ag, ender = :end,cep = :cep,cidade = :cid,uf = :uf where (juncao = :cod)');
     SqlAux1.Params[0].Text := Trim(EdAgencia.Text);
     SqlAux1.Params[1].Text := trim(EdEnd.Text);
     SqlAux1.Params[2].Text := trim(MkEdCep.Text);
     SqlAux1.Params[3].Text := trim(EdCid.Text);
     SqlAux1.Params[4].Text := trim(EdUf.Text);
     SqlAux1.Params[5].Text := Trim(EdCod.Text);
     try
       SqlAux1.ExecSql;
       SqlTbBradDeptos.Refresh;
       application.MessageBox('Alteração concluída com sucesso!!!','Ads',MB_OK+MB_ICONINFORMATION);
       limpa;
     except on e: exception do
       begin
         application.MessageBox(PChar(e.Message),'Ads',MB_OK+MB_ICONERROR);
       end;
     end;
   end;
end;

procedure TFrmCadSucursal.EdCodKeyPress(Sender: TObject; var Key: Char);
begin
  if KEY = #13 then
    SelectNext(ActiveControl , true,true);
  selagencia;
end;

procedure TFrmCadSucursal.Atualiza;
begin
  with Dm do
    begin
      MkEdCep.Text        := copy(SqlTbBradDeptoscep.Text,1,9);//+copy(SqlTbBradDeptoscep.Text,7,3);
      EdAgencia.Text      := SqlTbBradDeptosdepto.Text;
      EdCod.Text          := SqlTbBradDeptosjuncao.Text;
      cod                 := SqlTbBradDeptosjuncao.Text;
      EdEnd.Text          := SqlTbBradDeptosender.Text;
      EdCid.Text          := SqlTbBradDeptoscidade.Text;
      EdUf.Text           := SqlTbBradDeptosuf.Text;
    end;
end;

procedure TFrmCadSucursal.DBGridAgCellClick(Column: TColumn);
begin
  atualiza;
end;

procedure TFrmCadSucursal.DBGridAgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  atualiza
end;

procedure TFrmCadSucursal.DBGridAgKeyPress(Sender: TObject; var Key: Char);
begin
  atualiza
end;

procedure TFrmCadSucursal.DBGridAgKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  atualiza;
end;


procedure TFrmCadSucursal.BtnSairClick(Sender: TObject);
begin
  close;
end;

procedure TFrmCadSucursal.BtnAlterarClick(Sender: TObject);
begin
  altera;
end;

procedure TFrmCadSucursal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := cafree;
  Dm.SqlTbBradDeptos.Close;
end;



procedure TFrmCadSucursal.FormShow(Sender: TObject);
begin
  Dm.SqlTbBradDeptos.Refresh;
  DBGridAg.Refresh;
end;

procedure TFrmCadSucursal.selagencia;
begin
with Dm do
begin
  SqlTbBradDeptos.Close;
  SqlTbBradDeptos.SQL.Clear;
  SqlTbBradDeptos.SQL.Add('select * from tbbraddptos where (juncao like '''+EdCod.Text+'%'') order by to_number(juncao,''9999'')');
//  inputbox('','',SqlTbBradDeptos.SQL.Text);
  SqlTbBradDeptos.Open;
  DBGridAg.Refresh;
end;
end;
end.
