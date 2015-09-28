unit u_FrmMkCep;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Grids, DBGrids, Buttons, ExtCtrls, DBCtrls;

type
  TFrmMkcep = class(TForm)
    ScrollBoxmk: TScrollBox;
    Panel5mk: TPanel;
    edFilial: TEdit;
    Panel7mk: TPanel;
    edCepinicial: TEdit;
    Btn_Salvarmk: TBitBtn;
    BtnAlterarmk: TBitBtn;
    BtnDeletarmk: TBitBtn;
    BtnFecharmk: TBitBtn;
    DBGridcep: TDBGrid;
    Btlimpa: TBitBtn;
    Panel1: TPanel;
    edCepfinal: TEdit;
    dblcFilial: TDBLookupComboBox;
    Panel2: TPanel;
    procedure BtnFecharmkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtlimpaClick(Sender: TObject);
    procedure Btn_SalvarmkClick(Sender: TObject);
    procedure BtnAlterarmkClick(Sender: TObject);
    procedure DBGridcepKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridcepMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure dblcFilialClick(Sender: TObject);
    procedure BtnDeletarmkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMkcep: TFrmMkcep;

implementation

uses DmDados;

{$R *.dfm}

procedure TFrmMkcep.BtnFecharmkClick(Sender: TObject);
begin
  close;
end;

procedure TFrmMkcep.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dm.SqlCga108.Close;
  Dm.SqlCga107.Close;
  action := cafree;
end;

procedure TFrmMkcep.BtlimpaClick(Sender: TObject);
begin
   edfilial.Text       := '';
   edcepinicial.Text   := '';
   edcepfinal.Text     := '';
   dblcfilial.KeyValue := 0;
end;

procedure TFrmMkcep.Btn_SalvarmkClick(Sender: TObject);
begin
  if (trim(edFilial.Text) <> '') and (trim(self.edCepinicial.Text) <> '') and (trim(self.edCepfinal.Text) <> '') then
   Begin
     With Dm do
          with dm do
        begin
          Sqlaux1.Close;
          Sqlaux1.sql.Clear;
          Sqlaux1.sql.Add('insert into cga108cadfaixacep (codfilial,cepini,cepfim) values (:codfilial,:cepini,:cepfim)');
          Sqlaux1.Params[0].Value := Trim(edfilial.Text);
          Sqlaux1.Params[1].Value := Trim(edcepinicial.Text);
          Sqlaux1.Params[2].Value := Trim(edcepfinal.Text);
        try
            Sqlaux1.ExecSql;
            SqlCga108.Refresh;
            dbgridCep.Refresh;
            application.MessageBox('Inclusão feita com sucesso','Ads',MB_OK+MB_ICONINFORMATION);
          except on e: exception do
            begin
              application.MessageBox(PChar('Ocorreu um erro falta: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
            end;
        end;
    end;
 end;



end;

procedure TFrmMkcep.BtnAlterarmkClick(Sender: TObject);
begin
  if (trim(edFilial.Text) <> '') and (trim(edCepinicial.Text) <> '') and (trim(edCepfinal.Text) <> '') then
   begin
       With DM do
         begin
           sqlaux1.Close;
           sqlaux1.Sql.Clear;
           sqlaux1.Sql.Add('update cga108cadfaixacep set codfilial= :codfilial, cepini= :cepini, cepfim= :cepfim where codfilial = :codfilialx');
           sqlaux1.Params[0].Value := Trim(edFilial.Text);
           sqlaux1.Params[1].Value := Trim(edCepinicial.Text);
           sqlaux1.Params[2].Value := Trim(edCepFinal.Text);
           SqlAux1.Params[3].Value := dm.SqlCga108codfilial.Value;
           Sqlaux1.ExecSql;
           Sqlcga108.Refresh;
         end;
     end;
end;

procedure TFrmMkcep.DBGridcepKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    edfilial.Text     := dm.SqlCga108codfilial.AsString;
    edcepinicial.Text := dm.SqlCga108cepini.AsString;
    edcepfinal.Text   := dm.SqlCga108cepfim.AsString;
    dblcfilial.KeyValue := dm.SqlCga108codfilial.Value;
end;

procedure TFrmMkcep.DBGridcepMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    edfilial.Text     := dm.SqlCga108codfilial.AsString;
    edcepinicial.Text := dm.SqlCga108cepini.AsString;
    edcepfinal.Text   := dm.SqlCga108cepfim.AsString;
    dblcfilial.KeyValue := dm.SqlCga108codfilial.Value;
end;

procedure TFrmMkcep.FormShow(Sender: TObject);
begin
  dm.SqlCga107.Open;
end;

procedure TFrmMkcep.dblcFilialClick(Sender: TObject);
begin
  edfilial.Text := dblcfilial.KeyValue;
end;

procedure TFrmMkcep.BtnDeletarmkClick(Sender: TObject);
begin
if (trim(edFilial.Text) <> '') and (trim(edCepinicial.Text) <> '') and (trim(edCepfinal.Text) <> '') then
    begin
     With Dm do
        begin
          sqlaux1.Close;
         sqlaux1.Sql.Clear;
          sqlaux1.Sql.Add('delete from cga108cadfaixacep where codfilial = :codfilial');
          sqlaux1.Params[0].Value := Trim(edFilial.Text);
     Try
          sqlaux1.ExecSql;
          SqlCga108.Refresh;
          application.MessageBox('Filial deletada','Ads',MB_OK+MB_ICONINFORMATION);
            except on e: exception do
                begin
                 application.MessageBox(PChar('Ocorreu um erro faltal: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
                end;
            end;
        end;
      end;
end;

end.

