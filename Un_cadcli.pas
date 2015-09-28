unit Un_cadcli;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Buttons, Mask, ExtCtrls;

type
  TfrmCadcli = class(TForm)
    PnEnde: TPanel;
    EdEnde: TEdit;
    PnBairro: TPanel;
    EdBairro: TEdit;
    EdCli: TEdit;
    PnCliente: TPanel;
    PnUf: TPanel;
    EdUf: TEdit;
    PnCep: TPanel;
    MskCep: TMaskEdit;
    EdCid: TEdit;
    PnCid: TPanel;
    BtInclui: TBitBtn;
    BtSai: TBitBtn;
    DbgCadCli: TDBGrid;
    Panel2: TPanel;
    btnExcluir: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnLimpar: TBitBtn;
    btPrint: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BtIncluiClick(Sender: TObject);
    procedure DbgCadCliKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DbgCadCliMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtSaiClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure DbgCadCliMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DbgCadCliKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure Limpa2;
    procedure BtnLimparClick(Sender: TObject);
    procedure EdCliKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdCliKeyPress(Sender: TObject; var Key: Char);
    procedure EdEndeKeyPress(Sender: TObject; var Key: Char);
    procedure EdBairroKeyPress(Sender: TObject; var Key: Char);
    procedure EdCidKeyPress(Sender: TObject; var Key: Char);
    procedure EdUfKeyPress(Sender: TObject; var Key: Char);
    procedure MskCepKeyPress(Sender: TObject; var Key: Char);
    procedure btPrintClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadcli: TfrmCadcli;

implementation

uses Dmdados, U_cadcliPrint, U_confirma;

{$R *.dfm}

procedure TfrmCadcli.FormShow(Sender: TObject);
begin
   edcli.SetFocus;
   self.DbgCadCli.Refresh;
   limpa2;
end;

procedure TfrmCadcli.BtIncluiClick(Sender: TObject);
begin
   dm.SqlAux1.Close;
   dm.SqlAux1.Sql.Clear;
   dm.SqlAux1.Sql.Add('insert into cadcli (nome,endereco,cidade,cep,estado,bairro) values (:nome,:endereco,:cidade,:cep,:estado,:bairro)');
   dm.SqlAux1.Params[0].Value := edcli.Text;
   dm.SqlAux1.Params[1].Value := edende.Text;
   dm.SqlAux1.Params[2].Value := edcid.Text;
   dm.SqlAux1.Params[3].Value := MskCep.Text;
   dm.SqlAux1.Params[4].Value := eduf.Text;
   dm.SqlAux1.Params[5].Value := edbairro.Text;
   dm.SqlAux1.ExecSql;
   dm.sqlcadcli.Refresh;
   DbgCadCli.Refresh;
   limpa2;
   edcli.SetFocus;

end;

procedure TfrmCadcli.DbgCadCliKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   self.EdCli.Text    := dm.sqlcadclinome.Value;
   self.EdEnde.Text   := dm.sqlcadcliendereco.Value;
   self.EdBairro.Text := dm.sqlcadclibairro.Value;
   self.EdCid.Text    := dm.sqlcadclicidade.Value;
   self.EdUf.Text     := dm.sqlcadcliestado.Value;
   self.MskCep.Text   := dm.sqlcadclicep.Value;

end;

procedure TfrmCadcli.DbgCadCliMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   self.EdCli.Text    := dm.sqlcadclinome.Value;
   self.EdEnde.Text   := dm.sqlcadcliendereco.Value;
   self.EdBairro.Text := dm.sqlcadclibairro.Value;
   self.EdCid.Text    := dm.sqlcadclicidade.Value;
   self.EdUf.Text     := dm.sqlcadcliestado.Value;
   self.MskCep.Text   := dm.sqlcadclicep.Value;

end;

procedure TfrmCadcli.BtSaiClick(Sender: TObject);
begin
 close;
end;

procedure TfrmCadcli.BtnAlterarClick(Sender: TObject);
begin
   dm.SqlAux1.Close;
   dm.SqlAux1.Sql.Clear;
   dm.SqlAux1.Sql.Add('update cadcli set nome = :nome,endereco = :endereco,cidade = :cidade,cep = :cep,estado = :estado,bairro = :bairro  where codcli = :codcli');
   dm.SqlAux1.Params[0].Value := edcli.Text;
   dm.SqlAux1.Params[1].Value := edende.Text;
   dm.SqlAux1.Params[2].Value := edcid.Text;
   dm.SqlAux1.Params[3].Value := MskCep.Text;
   dm.SqlAux1.Params[4].Value := eduf.Text;
   dm.SqlAux1.Params[5].Value := edbairro.Text;
   dm.SqlAux1.Params[6].Value := dm.sqlcadclicodcli.Value;
   dm.SqlAux1.ExecSql;
   dm.sqlcadcli.Refresh;
   self.DbgCadCli.Refresh;
   messageDlg('Registro Alterado!',mtinformation,[mbok],0);
end;

procedure TfrmCadcli.DbgCadCliMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   self.EdCli.Text    := dm.sqlcadclinome.Value;
   self.EdEnde.Text   := dm.sqlcadcliendereco.Value;
   self.EdBairro.Text := dm.sqlcadclibairro.Value;
   self.EdCid.Text    := dm.sqlcadclicidade.Value;
   self.EdUf.Text     := dm.sqlcadcliestado.Value;
   self.MskCep.Text   := dm.sqlcadclicep.Value;

end;

procedure TfrmCadcli.DbgCadCliKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   self.EdCli.Text    := dm.sqlcadclinome.Value;
   self.EdEnde.Text   := dm.sqlcadcliendereco.Value;
   self.EdBairro.Text := dm.sqlcadclibairro.Value;
   self.EdCid.Text    := dm.sqlcadclicidade.Value;
   self.EdUf.Text     := dm.sqlcadcliestado.Value;
   self.MskCep.Text   := dm.sqlcadclicep.Value;

end;

procedure TfrmCadcli.btnExcluirClick(Sender: TObject);
begin
dm.SqlAux1.Close;
   dm.SqlAux1.Sql.Clear;
   dm.SqlAux1.Sql.Add('Delete from cadcli where codcli = :codcli');
   dm.SqlAux1.Params[0].Value := dm.sqlcadclicodcli.Value;
   dm.SqlAux1.ExecSql;
   dm.sqlcadcli.Refresh;
   self.DbgCadCli.Refresh;
   limpa2;
   messageDlg('Registro Excluído!',mtinformation,[mbok],0);
end;

procedure TfrmCadcli.Limpa2;
begin
   self.EdCli.Text    := '';
   self.EdEnde.Text   := '';
   self.EdBairro.Text := '';
   self.EdCid.Text    := '';
   self.EdUf.Text     := '';
   self.MskCep.Text   := '';

end;
procedure TfrmCadcli.BtnLimparClick(Sender: TObject);
begin
  limpa2;
end;

procedure TfrmCadcli.EdCliKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
  13 : showmessage('teste');
  end;
end;

procedure TfrmCadcli.EdCliKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
  #13:
      begin
         edende.SetFocus;
      end;
   end;
end;

procedure TfrmCadcli.EdEndeKeyPress(Sender: TObject; var Key: Char);
begin
 case key of
  #13:
      begin
         edbairro.SetFocus;
      end;
   end;
end;

procedure TfrmCadcli.EdBairroKeyPress(Sender: TObject; var Key: Char);
begin
 case key of
  #13:
      begin
         edcid.SetFocus;
      end;
   end;
end;

procedure TfrmCadcli.EdCidKeyPress(Sender: TObject; var Key: Char);
begin
 case key of
  #13:
      begin
         eduf.SetFocus;
      end;
   end;

end;

procedure TfrmCadcli.EdUfKeyPress(Sender: TObject; var Key: Char);
begin
 case key of
  #13:
      begin
         mskcep.SetFocus;
      end;
   end;
end;

procedure TfrmCadcli.MskCepKeyPress(Sender: TObject; var Key: Char);
begin
 case key of
  #13:
      begin
        self.BtInclui.SetFocus;
      end;
   end;
end;

procedure TfrmCadcli.btPrintClick(Sender: TObject);
begin
     Application.CreateForm(TFrmconfirma, Frmconfirma);
     frmconfirma.ShowModal;
end;

procedure TfrmCadcli.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
  FrmCadCli:=nil;
end;

end.
