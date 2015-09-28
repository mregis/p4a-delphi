unit u_FrmMkEdi;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Grids, DBGrids, Buttons, ExtCtrls, Mask;

type
  TfrmMkcadedi = class(TForm)
    ScrollBoxmk: TScrollBox;
    Panel5mk: TPanel;
    Ednumedi: TEdit;
    Panel7mk: TPanel;
    Btn_Salvarmk: TBitBtn;
    BtnAlterarmk: TBitBtn;
    BtnDeletarmk: TBitBtn;
    BtnFecharmk: TBitBtn;
    DBGrided: TDBGrid;
    Btlimpa: TBitBtn;
    edDtEdi: TMaskEdit;
    procedure BtnFecharmkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtlimpaClick(Sender: TObject);
    procedure Btn_SalvarmkClick(Sender: TObject);
    procedure BtnAlterarmkClick(Sender: TObject);
    procedure DBGridedKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridedMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtnDeletarmkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMkcadedi: TfrmMkcadedi;

implementation

uses DmDados;

{$R *.dfm}

procedure TfrmMkcadedi.BtnFecharmkClick(Sender: TObject);
begin
  close;
end;

procedure TfrmMkcadedi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Dm.SqlCga105.Close;
  action := cafree;
end;

procedure TfrmMkcadedi.BtlimpaClick(Sender: TObject);
begin
  ednumedi.Text := '';
  eddtedi.Text  := '';
end;

procedure TfrmMkcadedi.Btn_SalvarmkClick(Sender: TObject);
begin
 if (trim(ednumedi.Text) <> '') and (trim(edDtEdi.Text) <> '') then
   begin
     with Dm do
       Begin
         Sqlaux1.Close;
         Sqlaux1.Sql.Clear;
         Sqlaux1.Sql.Add('insert into cga105cadEdi (numedi,dtedi)');
         Sqlaux1.Sql.Add('values (:numedi,:dtedi)');
         Sqlaux1.Params[0].Value := Trim(ednumedi.Text);
         Sqlaux1.Params[1].Value := FormatDateTime('mm-dd-yyyy',StrToDate(eddtEdi.Text));
       try
         Sqlaux1.ExecSql;
         SqlCga105.Refresh;
         application.MessageBox('Inclusão feita com sucesso','Ads',MB_OK+MB_ICONINFORMATION);
       except on e: exception do
            begin
              application.MessageBox(PChar('Ocorreu um erro falta: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
            end;
      end;
     end;
   end;
   end;
procedure TfrmMkcadedi.BtnAlterarmkClick(Sender: TObject);
begin
 if (trim(ednumedi.Text) <> '') and (trim(edDtEdi.Text) <> '') then
     begin
       With DM do
         begin
           sqlaux1.Close;
           sqlaux1.Sql.Clear;
           sqlaux1.Sql.Add('update cga105cadedi set numedi= :numedi, dtedi = :dtedi where numedi = :numedix');
           sqlaux1.Params[0].Value := Trim(ednumedi.Text);
           Sqlaux1.Params[1].Value := FormatDateTime('mm-dd-yyyy',StrToDate(eddtEdi.Text));
           SqlAux1.Params[2].Value := Dm.SqlCga105numedi.Value;
           Sqlaux1.ExecSql;
           sqlcga105.Refresh;
           dbgridEd.Refresh;
         end;
     end;
end;

procedure TfrmMkcadedi.DBGridedKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ednumedi.text := dm.SqlCga105numedi.AsString;
   edDtEdi.text  := dm.SqlCga105dtedi.AsString;
end;

procedure TfrmMkcadedi.DBGridedMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   ednumedi.text := dm.SqlCga105numedi.AsString;
   edDtEdi.text  := dm.SqlCga105dtedi.AsString;
end;

procedure TfrmMkcadedi.BtnDeletarmkClick(Sender: TObject);
begin
if (trim(Ednumedi.Text) <> '') and (trim(edDtEdi.Text) <> '') then
    begin
      With Dm do
        begin
          sqlaux1.Close;
          sqlaux1.Sql.Clear;
          sqlaux1.Sql.Add('delete from cga105cadEdi where numedi = :num');
          sqlaux1.Params[0].Value := Trim(ednumedi.Text);
     Try
          sqlaux1.ExecSql;
          SqlCga105.Refresh;
          application.MessageBox('Edição deletada','Ads',MB_OK+MB_ICONINFORMATION);
            except on e: exception do
                begin
                  application.MessageBox(Pchar('Ocorreu um erro faltal: '+#10+e.Message),'Ads',MB_OK+MB_ICONERROR);
                end;
             end;
        end;
    end;
        ednumedi.Text := '';
        eddtedi.Text  := '';
end;

end.
