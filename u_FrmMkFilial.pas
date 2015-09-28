unit u_FrmMkFilial;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Grids, DBGrids, Buttons, ExtCtrls;

type
  TfrmMkcadfilial = class(TForm)
    ScrollBoxmk: TScrollBox;
    Panel5mk: TPanel;
    edcodigo: TEdit;
    Panel7mk: TPanel;
    edFilial: TEdit;
    Btn_Salvarmk: TBitBtn;
    BtnAlterarmk: TBitBtn;
    BtnDeletarmk: TBitBtn;
    BtnFecharmk: TBitBtn;
    DBGridfili: TDBGrid;
    Btlimpa: TBitBtn;
    procedure BtnFecharmkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtlimpaClick(Sender: TObject);
    procedure Btn_SalvarmkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAlterarmkClick(Sender: TObject);
    procedure DBGridfiliKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridfiliMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtnDeletarmkClick(Sender: TObject);
    procedure edcodigoClick(Sender: TObject);
    procedure edcodigoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edcodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMkcadfilial: TfrmMkcadfilial;

implementation

uses DmDados;

{$R *.dfm}

procedure TfrmMkcadfilial.BtnFecharmkClick(Sender: TObject);
begin
  close;
end;

procedure TfrmMkcadfilial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Dm.SqlCga107.Close;
  action := cafree;
end;

procedure TfrmMkcadfilial.BtlimpaClick(Sender: TObject);
begin
  edcodigo.Text  := '';
  edfilial.Text  := '';
end;

procedure TfrmMkcadfilial.Btn_SalvarmkClick(Sender: TObject);

  begin
   if (EdCodigo.Text <> '') and (edfilial.Text <> '') and ( edcodigo.Tag = 3) then
    begin
      with dm do
        begin
          Sqlaux1.Close;
          Sqlaux1.sql.Clear;
          Sqlaux1.sql.Add('insert into cga107cadfilial (nomefilial,codfilial) values (:nomefilial,:codfilial)');
          Sqlaux1.Params[0].Value := Trim(edfilial.Text);
          Sqlaux1.Params[1].Value := Trim(edcodigo.Text);

        try
            Sqlaux1.ExecSql;
            SqlCga107.Refresh;
            dbgridfili.Refresh;
            edcodigo.Tag := 1;
            application.MessageBox('Inclusão feita com sucesso','Ads',MB_OK+MB_ICONINFORMATION);
          except on e: exception do
            begin
              application.MessageBox(PChar('Ocorreu um erro falta: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
            end;
        end;
    end;
  end;
end;
procedure TfrmMkcadfilial.FormShow(Sender: TObject);
begin
   dbgridfili.Refresh;
   edcodigo.Tag := 1;
end;

procedure TfrmMkcadfilial.BtnAlterarmkClick(Sender: TObject);
begin
   if (Trim(edcodigo.Text) <> '') and (trim(edfilial.Text) <> '') then
     begin
       With DM do
         begin
           sqlaux1.Close;
           sqlaux1.Sql.Clear;
           sqlaux1.Sql.Add('update cga107cadfilial set codfilial= :cod, nomefilial = :nome where codfilial = :codx');
           sqlaux1.Params[0].Value := Trim(edcodigo.Text);
           sqlaux1.Params[1].Value := Trim(edfilial.Text);
           SqlAux1.Params[2].Value := Dm.SqlCga107codfilial.Value;
           sqlaux1.ExecSql;
           sqlcga107.Refresh;
           dbgridfili.Refresh;
         end;
     end;
end;

procedure TfrmMkcadfilial.DBGridfiliKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  edcodigo.Text := dm.SqlCga107codfilial.AsString;
  edfilial.Text := dm.SqlCga107nomefilial.AsString;
end;

procedure TfrmMkcadfilial.DBGridfiliMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edcodigo.Text := dm.SqlCga107codfilial.AsString;
  edfilial.Text := dm.SqlCga107nomefilial.AsString;
end;

procedure TfrmMkcadfilial.BtnDeletarmkClick(Sender: TObject);
begin
  if (trim(edcodigo.Text) <> '') and (trim(edfilial.Text) <> '') then
    begin
      With Dm do
        begin
          sqlaux1.Close;
          sqlaux1.Sql.Clear;
          sqlaux1.Sql.Add('delete from cga107cadfilial where codfilial = :cod');
          sqlaux1.Params[0].Value := Trim(edcodigo.Text);
      Try
          sqlaux1.ExecSql;
          SqlCga107.Refresh;
          application.MessageBox('Filial deletada','Ads',MB_OK+MB_ICONINFORMATION);
            except on e: exception do
                begin
                  application.MessageBox(PChar('Ocorreu um erro faltal: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
                end;
              end;
          end;
    end;
end;

procedure TfrmMkcadfilial.edcodigoClick(Sender: TObject);
begin
  edcodigo.Tag := 3;
end;

procedure TfrmMkcadfilial.edcodigoMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  edcodigo.Tag := 3;
end;

procedure TfrmMkcadfilial.edcodigoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  edcodigo.Tag := 3;
end;

end.
