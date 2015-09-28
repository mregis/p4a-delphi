unit U_FrmMkLoja;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Grids, DBGrids, Buttons, ExtCtrls;

type
  TFrmMkLoja = class(TForm)
    ScrollBoxmk: TScrollBox;
    Panel5mk: TPanel;
    edcodloja: TEdit;
    Panel7mk: TPanel;
    Btn_Salvarmk: TBitBtn;
    BtnAlterarmk: TBitBtn;
    BtnDeletarmk: TBitBtn;
    BtnFecharmk: TBitBtn;
    dbgcadloja: TDBGrid;
    Btlimpa: TBitBtn;
    eddesc: TEdit;
    procedure BtnFecharmkClick(Sender: TObject);
    procedure BtlimpaClick(Sender: TObject);
    procedure dbgcadlojaMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbgcadlojaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Btn_SalvarmkClick(Sender: TObject);
    procedure BtnAlterarmkClick(Sender: TObject);
    procedure BtnDeletarmkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMkLoja: TFrmMkLoja;

implementation

uses DmDados;

{$R *.dfm}

procedure TFrmMkLoja.BtnFecharmkClick(Sender: TObject);
begin
  close;
end;

procedure TFrmMkLoja.BtlimpaClick(Sender: TObject);
begin
  edcodloja.Text := '';
  eddesc.Text    := '';
end;

procedure TFrmMkLoja.dbgcadlojaMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  self.edcodloja.Text  := dm.SqlCga109codloja.AsString;
  self.eddesc.Text     := dm.SqlCga109descricao.AsString;
end;

procedure TFrmMkLoja.dbgcadlojaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  self.edcodloja.Text  := dm.SqlCga109codloja.AsString;
  self.eddesc.Text     := dm.SqlCga109descricao.AsString;
end;

procedure TFrmMkLoja.Btn_SalvarmkClick(Sender: TObject);
begin
  if  (edcodloja.Text <> '') and (Eddesc.Text <> '') then
   begin
     dm.SqlAux1.Close;
     dm.SqlAux1.Sql.Clear;
     dm.SqlAux1.Sql.Add('insert into cga109cadloja (codloja,descricao) values (:codloja,:descricao)');
     dm.SqlAux1.Params[0].Value := self.edcodloja.Text;
     dm.SqlAux1.Params[1].Value := self.eddesc.Text;
   Try
     dm.SqlAux1.ExecSql;
     dm.SqlCga109.Refresh;
     dbgcadloja.Refresh;
     application.MessageBox('Inclusão efetuada com Sucesso','Ads',MB_OK+MB_ICONINFORMATION);
   except on m: exception do
     begin
       application.MessageBox(PChar('Ocorreu um erro:'+#10+m.Message),'Ads',MB_OK+MB_ICONERROR);
     end;
   end;
  end;
end;

procedure TFrmMkLoja.BtnAlterarmkClick(Sender: TObject);
begin
  if (edcodloja.Text <> '') and (eddesc.Text <> '') then
    begin
        dm.SqlAux1.Close;
        dm.SqlAux1.Sql.Clear;
        dm.SqlAux1.Sql.Add('update cga109cadloja set codloja= :codloja, descricao= :descricao where codloja = :xcodloja');
        dm.SqlAux1.Params[0].Value := Trim(edcodloja.Text);
        dm.SqlAux1.Params[1].Value := Trim(eddesc.Text);
        dm.SqlAux1.Params[2].Value := dm.SqlCga109codloja.Value;
      Try
        dm.SqlAux1.ExecSql;
        dm.SqlCga109.Refresh;
        self.dbgcadloja.Refresh;
        application.MessageBox('Atualização efetuada com Sucesso','Ads',MB_OK+MB_ICONINFORMATION);
      except on l: exception do
        begin
          application.MessageBox(PChar('Ocorreu um erro: '+#10+l.Message),'Ads',MB_OK+MB_ICONERROR);
        end;
      end;
    end;
end;

procedure TFrmMkLoja.BtnDeletarmkClick(Sender: TObject);
begin
  if (self.edcodloja.Text <> '') and (self.eddesc.Text <> '') then
    begin
       dm.SqlAux1.Close;
       dm.SqlAux1.Sql.Clear;
       dm.SqlAux1.Sql.Add('delete from cga109cadloja where codloja = :xcodloja');
       dm.SqlAux1.Params[0].Value := dm.SqlCga109codloja.Value;
     Try
       dm.SqlAux1.ExecSql;
       dm.SqlCga109.Refresh;
       self.dbgcadloja.Refresh;
       application.MessageBox('Registro excluído com sucesso','Ads',MB_OK+MB_ICONINFORMATION);
     except on e: exception do
       begin
          application.MessageBox(PChar('Ocorreu um erro: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
       end;
     end;
        self.edcodloja.Text  := '';
        self.eddesc.Text     := '';
    end;
end;

end.
