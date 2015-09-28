unit U_CadEdicao;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Mask, Grids, DBGrids, Buttons, ExtCtrls;

type
  TFrmCadEdicao = class(TForm)
    ScrollBox1: TScrollBox;
    Panel1: TPanel;
    EdCodEdicao: TEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    EdDesc: TEdit;
    DBGrid2: TDBGrid;
    MkEdDtEdi: TMaskEdit;
    Btn_Salvar: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnDeletar: TBitBtn;
    BtnFechar: TBitBtn;
    BtnIncluir: TBitBtn;
    procedure atualizar;
    procedure alterar;
    procedure salvar;
    procedure limpa;
    procedure deletar;
    procedure BtnIncluirClick(Sender: TObject);
    procedure Btn_SalvarClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnDeletarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    cod : string;
   { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadEdicao: TFrmCadEdicao;

implementation

uses DmDados;

{$R *.dfm}

procedure TFrmCadEdicao.limpa;
begin
  EdDesc.Clear;
  MkEdDtEdi.Clear;
  EdCodEdicao.Clear;
  cod := 'x';
end;

procedure TFrmCadEdicao.BtnIncluirClick(Sender: TObject);
begin
  limpa;
end;

procedure TFrmCadEdicao.salvar;
begin
  if (EdCodEdicao.Text <> '') and (EdDesc.Text <> '') and (MkEdDtEdi.Text <> '  /  /    ') then
    begin
      with dm do
        begin
          SqlAux1.close;
          SqlAux1.sql.Clear;
          SqlAux1.sql.Add('insert into cga07 (cg07_edicao,cg07_codedicao,cg07_dtedicao) values (:cg07_edicao,:cg07_codedicao,:cg07_dtedicao)');
          SqlAux1.Params[0].Value := Trim(EdDesc.Text);
          SqlAux1.Params[1].Value := Trim(EdCodEdicao.Text);
          SqlAux1.Params[2].Value := FormatDateTime('yyyy-mm-dd',StrToDate(MkEdDtEdi.Text));
          try
            SqlAux1.ExecSql;
            SqlCga07.Refresh;
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

procedure TFrmCadEdicao.Btn_SalvarClick(Sender: TObject);
begin
  salvar;
end;

procedure TFrmCadEdicao.alterar;
begin
  if cod = Dm.SqlCga07cg07_codedicao.AsString then
    begin
      if (EdCodEdicao.Text <> '') and (EdDesc.Text <> '') and (MkEdDtEdi.Text <> '') then
        begin
          with dm do
            begin
              SqlAux1.close;
              SqlAux1.sql.Clear;
              SqlAux1.sql.Add('update cga07 set cg07_edicao=:cg07_edicao,cg07_codedicao=:cg07_codedicao,cg07_dtedicao=:cg07_dtedicao where cg07_dtedicao=:cg07_dtedicaox and cg07_codedicao=:cg07_codedicaox');
              SqlAux1.Params[0].Value := Trim(EdDesc.Text);
              SqlAux1.Params[1].Value := Trim(EdCodEdicao.Text);
              SqlAux1.Params[2].Value := FormatDateTime('yyyy-mm-dd',StrToDate(MkEdDtEdi.Text));
              SqlAux1.Params[3].Value := Dm.SqlCga07cg07_dtedicao.Value;
              SqlAux1.Params[4].Value := Dm.SqlCga07cg07_codedicao.Value;
              try
                SqlAux1.ExecSql;
                SqlCga07.Refresh;
                application.MessageBox('Alteração feita com sucesso','Ads',MB_OK+MB_ICONINFORMATION);
                limpa;
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
      application.MessageBox('Selecione uma edição para depois altera-la','Ads',MB_OK+MB_ICONERROR);
      exit;
    end;
end;


procedure TFrmCadEdicao.BtnAlterarClick(Sender: TObject);
begin
  alterar;
end;

procedure TFrmCadEdicao.deletar;
begin
  if cod = Dm.SqlCga07cg07_codedicao.AsString then
    begin
      if (EdCodEdicao.Text <> '') and (EdDesc.Text <> '') and (MkEdDtEdi.Text <> '  /  /    ') then
        begin
          with dm do
            begin
              SqlAux1.close;
              SqlAux1.sql.Clear;
              SqlAux1.sql.Add('delete from  cga07 where cg07_dtedicao=:cg07_dtedicao and cg07_codedicao=:cg07_codedicao');
              SqlAux1.Params[0].Value := Dm.SqlCga07cg07_dtedicao.Value;
              SqlAux1.Params[1].Value := Dm.SqlCga07cg07_codedicao.Value;
              try
                SqlAux1.ExecSql;
                SqlCga07.Refresh;
                application.MessageBox('Edição deletada','Ads',MB_OK+MB_ICONINFORMATION);
                limpa;
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
      application.MessageBox('Selecione uma Edição para depois deleta-la','Ads',MB_OK+MB_ICONERROR);
      exit;
    end;
end;

procedure TFrmCadEdicao.BtnDeletarClick(Sender: TObject);
begin
  deletar;
end;

procedure TFrmCadEdicao.BtnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFrmCadEdicao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Dm.SqlCga07.Close;
  action := cafree;
  FrmCadEdicao := nil;
end;

procedure TFrmCadEdicao.atualizar;
begin
  EdCodEdicao.Text := Dm.SqlCga07cg07_codedicao.AsString;
  EdDesc.Text      := Dm.SqlCga07cg07_edicao.AsString;
  MkEdDtEdi.Text   := FormatDateTime('dd/mm/yyyy',Dm.SqlCga07cg07_dtedicao.AsDateTime);
  cod              := Dm.SqlCga07cg07_codedicao.AsString;
end;

procedure TFrmCadEdicao.DBGrid2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  atualizar;
end;

procedure TFrmCadEdicao.DBGrid2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  atualizar;
end;

end.
