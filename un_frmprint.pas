unit un_frmprint;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls,dmdados, ExtCtrls;

type
  TfrmMKPrint = class(TForm)
    btnPrint: TBitBtn;
    btnclose: TBitBtn;
    cmbprinter: TComboBox;
    dblcloja: TDBLookupComboBox;
    dblcdivisao: TDBLookupComboBox;
    dblcedicao: TDBLookupComboBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    procedure btnconsisteClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btncloseClick(Sender: TObject);
    procedure dblclojaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMKPrint: TfrmMKPrint;

implementation

uses u_mketiqueta, u_mketiquetamat, Unit1;

{$R *.dfm}

procedure TfrmMKPrint.btnconsisteClick(Sender: TObject);
begin
  btnPrint.Enabled    := true;
end;

procedure TfrmMKPrint.btnPrintClick(Sender: TObject);
var
  Vez      : string;
begin
   if (dblcloja.KeyValue = null) or (dblcdivisao.KeyValue = null) or (dblcedicao.KeyValue = null) then
       MessageDlg('Uma ou mais opções não foram selecionadas, Por Favor Verifique.',mtWarning,[mbok],0)
   else
    begin
      With Dm do
       begin
         SqlCga111Check.Close;
         SqlCga111Check.Sql.Clear;
         SqlCga111Check.Sql.Add('select * from cga111check where chloja = :chloja and chdivisao = :chdivisao and chedicao = :chedicao');
         SqlCga111Check.Params[0].Value := dblcloja.KeyValue;
         SqlCga111Check.Params[1].Value := dblcdivisao.KeyValue;
         SqlCga111Check.Params[2].Value := dblcedicao.KeyValue;
         sqlcga111check.Open;
        case dm.SqlCga111Check.RecordCount of
         0:
          begin
           dm.SqlCgaMakro.Close;
           dm.SqlCgaMakro.Sql.Clear;
           dm.SqlCgaMakro.Sql.Add('select * from cga110makro where mkcodloja = :mkcodloja and mkcoddiv = :mkcoddiv');
           dm.SqlCgaMakro.Params[0].Value := dblcloja.KeyValue;
           dm.SqlCgaMakro.Params[1].Value := dblcdivisao.KeyValue;
           dm.SqlCgaMakro.Open;
              case dm.SqlCgaMakro.RecordCount of
                0:
                  begin
                   showmessage('Sem dados para impressão!');
                   exit;
                  end
              else
               {Há dados para impressão - portanto - insere informação na tabela }

               if self.cmbprinter.ItemIndex = 0 then
                 begin
                    Application.CreateForm(TFrmMkEtiqueta,FrmMkEtiqueta);
                    FrmMkEtiqueta.Rlmketiqueta.PreviewModal;
                    FrmMkEtiqueta.Destroy;
                 end
               else
                 begin
                  {Application.CreateForm(TFrmMkEtiquetaMat,FrmMkEtiquetaMat);
                   FrmMkEtiquetaMat.RLReport1.PreviewModal;
                   FrmMkEtiquetaMat.Destroy;}
                   Application.CreateForm(TForm1,Form1);
                   Form1.RLReport1.PreviewModal;
                   Form1.RLReport1.Destroy;
                 end
              end
          end
        else
           dm.SqlAux1.Close;
           dm.SqlAux1.Sql.Clear;
           dm.SqlAux1.Sql.Add('select count(*) from cga111check where chloja = :chloja and chdivisao = :chdivisao and chedicao = :chedicao');
           dm.SqlAux1.Params[0].Value := dblcloja.KeyValue;
           dm.SqlAux1.Params[1].Value := dblcdivisao.KeyValue;
           dm.SqlAux1.Params[2].Value := dblcedicao.KeyValue;
           dm.SqlAux1.Open;

            if dm.SqlAux1.Fields[0].AsInteger =1 then
               vez := 'vez'
            else
                vez := 'vezes';
            if MessageDlg('Você já imprimiu esta loja '+inttostr(dm.SqlAux1.Fields[0].AsInteger)+' '+vez +', deseja realmente reimprimir?', mtConfirmation,[mbyes,mbno],0)<>mrno then
      // Rotina de Impressão
             Begin
              dm.SqlCgaMakro.Close;
              dm.SqlCgaMakro.Sql.Clear;
              dm.SqlCgaMakro.Sql.Add('select * from cga110makro where mkcodloja = :mkcodloja and mkcoddiv = :mkcoddiv');
              dm.SqlCgaMakro.Params[0].Value := dblcloja.KeyValue;
              dm.SqlCgaMakro.Params[1].Value := dblcdivisao.KeyValue;
              dm.SqlCgaMakro.Open;

              if self.cmbprinter.ItemIndex = 0 then
                 begin
                    Application.CreateForm(TFrmMkEtiqueta,FrmMkEtiqueta);
                    FrmMkEtiqueta.Rlmketiqueta.PreviewModal;
                    FrmMkEtiqueta.Destroy;
                 end
              else
                 begin
                   {Application.CreateForm(TFrmMkEtiquetaMat,FrmMkEtiquetaMat);
                   FrmMkEtiquetaMat.RLReport1.PreviewModal;
                   FrmMkEtiquetaMat.Destroy;}
                   Application.CreateForm(TForm1,Form1);
                   Form1.RLReport1.PreviewModal;
                   Form1.RLReport1.Destroy;

                 end
             end
           else
            exit;
         end;
        end;
    end;
end;


procedure TfrmMKPrint.btncloseClick(Sender: TObject);
begin
  close;
end;

procedure TfrmMKPrint.dblclojaClick(Sender: TObject);
begin
    Dm.SqlCgaLojaDivi.Close;
    Dm.SqlCgaLojaDivi.Sql.Clear;
    Dm.SqlCgaLojaDivi.Sql.Add('select * from cga106divisao inner join cga109cadloja');
    Dm.SqlCgaLojaDivi.Sql.Add('on cga109cadloja.codloja = cga106divisao.codloja where');
    Dm.SqlCgaLojaDivi.Sql.Add('cga106divisao.codloja = :cgadivi');
    Dm.SqlCgaLojaDivi.Sql.Add('order by cga106divisao.coddiv');
    Dm.SqlCgaLojaDivi.Params[0].Value := dm.SqlCga109.Fields[0].Value;
    Dm.SqlCgaLojaDivi.ExecSql;
    Dm.SqlCgaLojaDivi.Open;
    dblcdivisao.KeyValue := null;
    dblcdivisao.Refresh;
end;

procedure Imprimir;
   begin

   end;

procedure TfrmMKPrint.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dm.SqlCga105.Close;
end;

procedure TfrmMKPrint.FormShow(Sender: TObject);
begin
      dm.sqlCga105.Close;
      dm.SqlCga105.Sql.Clear;
      dm.Sqlcga105.Sql.Add('select * from cga105cadedi');
      dm.sqlcga105.Open;
end;

end.

