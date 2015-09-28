Unit u_FrmMkdivisao;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Grids, DBGrids, Buttons, ExtCtrls,
  DBCtrls;

type
  TFrmMkdivisao = class(TForm)
    ScrollBoxmk: TScrollBox;
    Panel5mk: TPanel;
    edcodigo: TEdit;
    Panel7mk: TPanel;
    Btn_Salvarmk: TBitBtn;
    BtnAlterarmk: TBitBtn;
    BtnDeletarmk: TBitBtn;
    BtnFecharmk: TBitBtn;
    dbgdiv: TDBGrid;
    Btlimpa: TBitBtn;
    edcodloja: TEdit;
    Edcidade: TEdit;
    edEndereco: TEdit;
    eduf: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    dblcloja: TDBLookupComboBox;
    procedure BtnFecharmkClick(Sender: TObject);
    procedure dbgdivKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgdivMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtlimpaClick(Sender: TObject);
    procedure Btn_SalvarmkClick(Sender: TObject);
    procedure BtnAlterarmkClick(Sender: TObject);
    procedure BtnDeletarmkClick(Sender: TObject);
    procedure dblclojaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMkdivisao: TFrmMkdivisao;

implementation

uses DmDados;

{$R *.dfm}

procedure TFrmMkdivisao.BtnFecharmkClick(Sender: TObject);
begin
  close;
end;

procedure TFrmMkdivisao.dbgdivKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  self.edcodigo.Text     :=  dm.SqlCga106coddiv.AsString;
  self.edcodloja.Text    :=  dm.SqlCga106codloja.AsString;
  self.Edcidade.Text     :=  dm.SqlCga106cidade.AsString;
  self.edEndereco.Text   :=  dm.SqlCga106endereco.AsString;
  self.eduf.Text         :=  dm.SqlCga106uf.AsString;
  self.dblcloja.KeyValue :=  dm.SqlCga106codloja.Value;
end;

procedure TFrmMkdivisao.dbgdivMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  self.edcodigo.Text   :=  dm.SqlCga106coddiv.AsString;
  self.edcodloja.Text  :=  dm.SqlCga106codloja.AsString;
  self.Edcidade.Text   :=  dm.SqlCga106cidade.AsString;
  self.edEndereco.Text :=  dm.SqlCga106endereco.AsString;
  self.eduf.Text       :=  dm.SqlCga106uf.AsString;
  self.dblcloja.KeyValue :=  dm.SqlCga106codloja.Value;
end;

procedure TFrmMkdivisao.BtlimpaClick(Sender: TObject);
begin
  self.edcodigo.Text     := '';
  self.edcodloja.Text    := '';
  self.Edcidade.Text     := '';
  self.edEndereco.Text   := '';
  self.eduf.Text         := '';
  self.dblcloja.KeyValue := null;
end;


procedure TFrmMkdivisao.Btn_SalvarmkClick(Sender: TObject);
begin
  if (edcodigo.Text <> '') and (edcodloja.Text <> '') and (Edcidade.Text <> '') and (edEndereco.Text <> '') and (eduf.Text <> '') then
   begin
       dm.SqlAux1.Close;
       dm.SqlAux1.Sql.Clear;
       dm.SqlAux1.Sql.Add('insert into cga106divisao (codloja,coddiv,endereco,cidade,uf) values (:codloja,:coddiv,:endereco,:cidade,:uf)');
       dm.SqlAux1.Params[0].Value := self.edcodloja.Text;
       dm.SqlAux1.Params[1].Value := self.edcodigo.Text;
       dm.SqlAux1.Params[2].Value := self.edEndereco.Text;
       dm.SqlAux1.Params[3].Value := self.Edcidade.Text;
       dm.SqlAux1.Params[4].Value := self.eduf.Text;
     Try
       dm.SqlAux1.ExecSql;
       dm.SqlCga106.Refresh;
       dbgdiv.Refresh;
       application.MessageBox('Registro Incluído com sucesso','Ads',MB_OK+MB_ICONINFORMATION);
     except on e: exception do
      begin
        application.MessageBox(PChar('Ocorreu um erro: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
       end;
     end;
    end;
end;

procedure TFrmMkdivisao.BtnAlterarmkClick(Sender: TObject);
begin
 if (edcodigo.Text <> '') and (edcodloja.Text <> '') and (Edcidade.Text <> '') and (edEndereco.Text <> '') and (eduf.Text <> '') then
   begin
      dm.SqlAux1.Close;
      dm.SqlAux1.Sql.Clear;
      dm.SqlAux1.Sql.Add('Update cga106divisao set codloja= :codloja, coddiv= :coddiv, endereco = :endereco,cidade = :cidade,uf = :uf where coddiv = :xcoddiv');
      dm.SqlAux1.Params[0].Value := self.edcodloja.Text;
      dm.SqlAux1.Params[1].Value := self.edcodigo.Text;
      dm.SqlAux1.Params[2].Value := self.edEndereco.Text;
      dm.SqlAux1.Params[3].Value := self.Edcidade.Text;
      dm.SqlAux1.Params[4].Value := self.eduf.Text;
      dm.SqlAux1.Params[5].Value := dm.SqlCga106coddiv.Value;
   Try
      dm.SqlAux1.ExecSql;
      dm.SqlCga106.Refresh;
      dbgdiv.Refresh;
      application.MessageBox('Registro atualizado com sucesso','Ads',MB_OK+MB_ICONINFORMATION);
    except on e: exception do
       begin
         application.MessageBox(PChar('Ocorreu um erro: '+#10+e.message),'Ads',MB_OK+MB_ICONERROR);
       end;
    end;
   end;
end;

procedure TFrmMkdivisao.BtnDeletarmkClick(Sender: TObject);
begin
if (edcodigo.Text <> '') and (edcodloja.Text <> '') and (Edcidade.Text <> '') and (edEndereco.Text <> '') and (eduf.Text <> '') then
   begin
      dm.SqlAux1.Close;
      dm.SqlAux1.Sql.Clear;
      dm.SqlAux1.Sql.Add('Delete from cga106divisao where coddiv = :xcoddiv and codloja = :xcodloja');
      dm.SqlAux1.Params[0].Value := dm.SqlCga106coddiv.Value;
      dm.SqlAux1.Params[1].Value := dm.SqlCga106codloja.Value;
     Try
      dm.SqlAux1.ExecSql;
      dm.SqlCga106.Refresh;
      dbgdiv.Refresh;
      application.MessageBox('Registro excluído com Sucesso','Ads',MB_OK+MB_ICONINFORMATION);
    except on e: exception do
      begin
         application.MessageBox(PChar('Ocorreu um erro: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
      end;
    end;
      self.edcodigo.Text     := '';
      self.edcodloja.Text    := '';
      self.Edcidade.Text     := '';
      self.edEndereco.Text   := '';
      self.eduf.Text         := '';
      self.dblcloja.KeyValue := null;
   end;
end;

procedure TFrmMkdivisao.dblclojaClick(Sender: TObject);
begin
   edcodloja.Text  := dblcloja.KeyValue;
end;

procedure TFrmMkdivisao.FormShow(Sender: TObject);
begin
  dm.SqlCga106.Close;
  dm.SqlCga106.Sql.Clear;
  dm.SqlCga106.Sql.Add('select * from cga106divisao order by coddiv ');
  dm.SqlCga106.ExecSql;
  dm.SqlCga106.Open;
end;

end.

