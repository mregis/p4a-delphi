unit U_CadAssinantes;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls, Mask;

type
  TFrmCadAssinantes = class(TForm)
    ScrollBox1: TScrollBox;
    Panel5: TPanel;
    EdCod: TEdit;
    Btn_Salvar: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnFechar: TBitBtn;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    MkEdDtAssinatura: TMaskEdit;
    procedure BtnFecharClick(Sender: TObject);
    procedure Btn_SalvarClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadAssinantes: TFrmCadAssinantes;

implementation

uses DmDados;

{$R *.dfm}

procedure TFrmCadAssinantes.BtnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFrmCadAssinantes.Btn_SalvarClick(Sender: TObject);
begin
  if application.MessageBox(PChar('Deseja Realmente Tornar assinante o Codigo: '+EdCod.Text+' ?'),'Ads',MB_YESNO+MB_ICONQUESTION) = idyes then
    begin
      Dm.SqlAux1.Close;
      Dm.SqlAux1.Sql.Clear;
      Dm.SqlAux1.Sql.Add('update cga10 set cg10_assinante =:assinante, cg10_dtassinatura=:data where (cg10_codcli =:codcli) and (cg10_dtassinatura is null)');
      Dm.SqlAux1.Params[0].AsString  := 'S';
      Dm.SqlAux1.Params[1].AsString  := formatdatetime('mm-dd-yyyy',StrToDate(MkEdDtAssinatura.Text));
      Dm.SqlAux1.Params[2].AsInteger := strtoint(trim(EdCod.Text));
      Dm.SqlAux1.ExecSql;
      if Dm.SqlAux1.RowsAffected = 0 then
        begin
          Dm.SqlAux1.Close;
          Dm.SqlAux1.Sql.Clear;
          Dm.SqlAux1.Sql.Add(' select cg10_dtassinatura from cga10 where (cg10_codcli =:codcli) and (cg10_dtassinatura is not null)');
          Dm.SqlAux1.Params[0].AsInteger := strtoint(EdCod.Text);
          Dm.SqlAux1.open;
          case Dm.SqlAux1.RecordCount of
            0:
              begin
                application.MessageBox(PChar('O Codigo: '+EdCod.Text+' não foi encontrado'),'Ads',MB_OK+MB_ICONWARNING);
              end;
            1:
              begin
                application.MessageBox(PChar('O Codigo: '+EdCod.Text+' Já é um Assinante do Arauto desde '+formatdatetime('dd/mm/yyyy',Dm.SqlAux1.Fields[0].AsDateTime)),'Ads',MB_OK+MB_ICONWARNING);
              end;
          end;
        end
      else
        begin
          application.MessageBox(PChar('O Codigo: '+EdCod.Text+' é um novo assinante do Arauto'),'Ads',MB_OK+MB_ICONINFORMATION);
        end;
    end
  else
    begin
      application.MessageBox('Operação cancelada','Ads',MB_OK+MB_ICONINFORMATION);
      exit;
    end;
end;

procedure TFrmCadAssinantes.BtnAlterarClick(Sender: TObject);
begin
  Dm.SqlAux1.Close;
  Dm.SqlAux1.Sql.Clear;
  Dm.SqlAux1.Sql.Add('update cga10 set cg10_assinante =:assinante, cg10_dtassinatura=:data where (cg10_codcli =:codcli) and (cg10_dtassinatura is not null)');
  Dm.SqlAux1.Params[0].AsString  := 'N';
  Dm.SqlAux1.Params[1].Value     := null;
  Dm.SqlAux1.Params[2].AsInteger := strtoint(EdCod.Text);
  Dm.SqlAux1.ExecSql;
  if Dm.SqlAux1.RowsAffected = 0 then
    begin
      Dm.SqlAux1.Close;
      Dm.SqlAux1.Sql.Clear;
      Dm.SqlAux1.Sql.Add(' select cg10_dtassinatura from cga10 where (cg10_codcli =:codcli) and (cg10_dtassinatura is null)');
      Dm.SqlAux1.Params[0].AsInteger := strtoint(EdCod.Text);
      Dm.SqlAux1.open;
      case Dm.SqlAux1.RecordCount of
        0:
          begin
            application.MessageBox(PChar('O Codigo: '+EdCod.Text+' não foi encontrado'),'Ads',MB_OK+MB_ICONWARNING);
          end;
        1:
          begin
            application.MessageBox(PChar('O Codigo: '+EdCod.Text+' não é assinante do Arauto'),'Ads',MB_OK+MB_ICONWARNING);
          end;
      end;
    end
  else
    begin
      application.MessageBox(PChar('O Codigo: '+EdCod.Text+' esta extornado!'),'Ads',MB_OK+MB_ICONINFORMATION);
    end;
end;

end.
