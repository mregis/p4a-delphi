unit U_CadCaixaPrevidenciaBrasdesco;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, DBCtrls;

type
  TFrmCadCaixaPrevidenciaBrasdesco = class(TForm)
    ScrollBox1: TScrollBox;
    Bevel1: TBevel;
    EdDtb: TEdit;
    BtnIncluir: TBitBtn;
    BtnSalvar: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnDeletar: TBitBtn;
    BtnSair: TBitBtn;
    DBGrid1: TDBGrid;
    Panel5: TPanel;
    Panel1: TPanel;
    DBLkSucursal: TDBLookupComboBox;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    EdQtDtb: TEdit;
    procedure atualiza;
    procedure deletar;
    procedure alterar;
    procedure Salvar;
    procedure limpa;
    procedure BtnSairClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnDeletarClick(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn1Click(Sender: TObject);
  private
   cod : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadCaixaPrevidenciaBrasdesco: TFrmCadCaixaPrevidenciaBrasdesco;

implementation

uses DmDados, U_Dig_Previdencia_Bradesco;

{$R *.dfm}

procedure TFrmCadCaixaPrevidenciaBrasdesco.atualiza;
begin
  EdDtb.Text   := Dm.SqlCga42cg42_ncont.AsString;
  EdQtDtb.Text := Dm.SqlCga42cg42_qtdtb.AsString;
  DBLkSucursal.KeyValue := Dm.SqlCga41cg41_codsuc.Value;
  cod := Dm.SqlCga42cg42_ncont.AsString;
end;

procedure TFrmCadCaixaPrevidenciaBrasdesco.BtnSairClick(Sender: TObject);
begin
  close;
end;

procedure TFrmCadCaixaPrevidenciaBrasdesco.limpa;
begin
  EdDtb.Clear;
  EdQtDtb.Clear;
  DBLkSucursal.KeyValue := null;
  cod := 'x';
  EdDtb.SetFocus;
end;

procedure TFrmCadCaixaPrevidenciaBrasdesco.BtnIncluirClick(
  Sender: TObject);
begin
  limpa;
end;

procedure TFrmCadCaixaPrevidenciaBrasdesco.BtnSalvarClick(Sender: TObject);
begin
  salvar;
end;

procedure TFrmCadCaixaPrevidenciaBrasdesco.Salvar;
begin
  if (EdDtb.Text <> '') and (DBLkSucursal.KeyValue <> null) then
    begin
      with dm do
        begin
          SqlAux1.close;
          SqlAux1.sql.Clear;
          SqlAux1.sql.Add('insert into cga42 (cg42_qtdtb,cg42_ncont,cg42_codsuc) values (:cg42_qtdtb,:cg42_ncont,:cg42_codsuc)');
          if Trim(EdQtDtb.Text) = '' then
            EdQtDtb.Text := '0';
          SqlAux1.Params[0].Value := Trim(EdQtDtb.Text);
          SqlAux1.Params[1].Value := Trim(EdDtb.Text);
          SqlAux1.Params[2].Value := Dm.SqlCga41cg41_codsuc.Value;
          try
            SqlAux1.ExecSql;
            SqlCga42.Refresh;
            application.MessageBox('Inclusão feita com sucesso','Ads',MB_OK+MB_ICONINFORMATION);
            limpa;
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

procedure TFrmCadCaixaPrevidenciaBrasdesco.alterar;
begin
 if cod = Dm.SqlCga42cg42_ncont.Value then
   begin
     with dm do
       begin
         SqlAux1.Close;
         SqlAux1.Sql.Clear;
         SqlAux1.Sql.Add('update cga42 set cg42_qtdtb=:cg42_qtdtb,cg42_ncont=:cg42_ncont,cg42_codsuc=:cg42_codsuc where cg42_ncont = :cg42_ncontx');
         SqlAux1.Params[0].Value := Trim(EdQtDtb.Text);
         SqlAux1.Params[1].Value := Trim(EdDtb.Text);
         SqlAux1.Params[2].Value := Dm.SqlCga41cg41_codsuc.Value;
         SqlAux1.Params[3].Value := cod;
         try
           SqlAux1.ExecSql;
           SqlCga42.Refresh;
           application.MessageBox('Alteração concluida com sucesso!!!','Ads',MB_OK+MB_ICONINFORMATION);
           limpa;
         except on e: exception do
           begin
             application.MessageBox(PChar('Ocorreu um erro falta: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
           end;
         end;
       end;
   end
 else
   begin
     application.MessageBox('Selecione uma sucursal para depois alterala','Ads',MB_OK+MB_ICONERROR);
   end;
end;

procedure TFrmCadCaixaPrevidenciaBrasdesco.deletar;
begin
 if cod = Dm.SqlCga42cg42_ncont.Value then
   begin
     with dm do
       begin
         SqlAux1.Close;
         SqlAux1.Sql.Clear;
         SqlAux1.Sql.Add('delete from  cga42 where cg42_ncont = :cg42_ncontx');
         SqlAux1.Params[0].Value := cod;
         try
           SqlAux1.ExecSql;
           SqlCga42.Refresh;
           application.MessageBox('Alteração concluida com sucesso!!!','Ads',MB_OK+MB_ICONINFORMATION);
           limpa;
         except on e: exception do
           begin
             application.MessageBox(PChar('Ocorreu um erro falta: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
           end;
         end;
       end;
   end
 else
   begin
     application.MessageBox('Selecione uma sucursal para depois alterala','Ads',MB_OK+MB_ICONERROR);
   end;
end;

procedure TFrmCadCaixaPrevidenciaBrasdesco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := cafree;
  Dm.SqlCga41.close;
  Dm.SqlCga42.close;
end;

procedure TFrmCadCaixaPrevidenciaBrasdesco.BtnAlterarClick(
  Sender: TObject);
begin
  alterar;
end;

procedure TFrmCadCaixaPrevidenciaBrasdesco.BtnDeletarClick(
  Sender: TObject);
begin
  deletar;
end;

procedure TFrmCadCaixaPrevidenciaBrasdesco.DBGrid1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  atualiza;
end;

procedure TFrmCadCaixaPrevidenciaBrasdesco.DBGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  atualiza;
end;

procedure TFrmCadCaixaPrevidenciaBrasdesco.BitBtn1Click(Sender: TObject);
begin
 Application.CreateForm(TFrm_Dig_Previdencia_Bradesco,Frm_Dig_Previdencia_Bradesco);
 Dm.SqlCga40.Close;
 Dm.SqlCga40.Sql.Clear;
 Dm.SqlCga40.Sql.Add('select * from cga40 where cg40_ncont=:ncont');
 Dm.SqlCga40.Params[0].Value := Dm.SqlCga42cg42_ncont.Value;
 Dm.SqlCga40.Open;
 Frm_Dig_Previdencia_Bradesco.EdQt.Text := inttostr(Dm.SqlCga40.RecordCount);
 Frm_Dig_Previdencia_Bradesco.dtb    := Dm.SqlCga42cg42_ncont.AsString;
 Frm_Dig_Previdencia_Bradesco.qtdig  := Dm.SqlCga42cg42_qtdig.AsLargeInt;
 Frm_Dig_Previdencia_Bradesco.qterro := Dm.SqlCga42cg42_erros.AsLargeInt;
 Frm_Dig_Previdencia_Bradesco.EdNome.SetFocus;
 Frm_Dig_Previdencia_Bradesco.ShowModal;
 setfocus;
end;

end.
