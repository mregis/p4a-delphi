unit U_ExtUnificado;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls;

type
  TFrmExtUnificado = class(TForm)
    ScrollBox1: TScrollBox;
    DbLkBaixa: TDBLookupComboBox;
    EdCaixa: TEdit;
    EdQt: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    EdRemessa: TEdit;
    Panel4: TPanel;
    BtnFechar: TBitBtn;
    procedure EdRemessaKeyPress(Sender: TObject; var Key: Char);
    procedure BtnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExtUnificado: TFrmExtUnificado;

implementation

uses DmDados;

{$R *.dfm}

procedure TFrmExtUnificado.EdRemessaKeyPress(Sender: TObject;
  var Key: Char);
var
  proxretorno : variant;
begin
  case key of
    #13:
        begin
          if anterior <> Trim(EdRemessa.Text) then
            begin
              anterior  := Trim(EdRemessa.Text);
              if Verifica(EdRemessa.Text) = 'erro' then
                begin
                 application.MessageBox('Caracter invalido','Ads',MB_OK+MB_ICONERROR);
                 EdRemessa.Clear;
                 EdRemessa.SetFocus;
                 exit;
                end;
              case length(EdRemessa.Text) of
                22:
                  begin
                    Dm.SqlAux1.Close;
                    Dm.SqlAux1.Sql.Clear;
                    //Dm.SqlAux1.Sql.Add('select * from maior_data_arq_retorno(:codremes)');
                    Dm.SqlAux1.Sql.Add('select max(cg33_dtret) from cga33 where cg33_remes = ');
                    Dm.SqlAux1.Sql.Add(':x and cg33_dtret <>'+chr(39)+'01-01-1950'+chr(39));
                    Dm.SqlAux1.Params[0].Value := copy(EdRemessa.Text,1,14);
                    Dm.SqlAux1.Open;
                    if Dm.SqlAux1.Fields[0].Value = null  then
                      begin
                        Dm.SqlAux1.Close;
                        Dm.SqlAux1.Sql.Clear;
                        Dm.SqlAux1.Sql.Add('select count(cg33_remes)from cga33 where cg33_remes =:codremes');
                        Dm.SqlAux1.Params[0].Value := copy(EdRemessa.Text,1,14);
                        Dm.SqlAux1.Open;
                        case Dm.SqlAux1.Fields[0].Value of
                          0:
                            begin
                              proxretorno := null;
                            end;
                        else
                          begin
                            proxretorno := '01-01-1950';
                          end;
                        end;
                      end
                    else
                      begin
                        if (strtoint(DifDias(date,Dm.SqlAux1.Fields[0].Value))) >= 30 then
                          begin
                             proxretorno := null;
                          end
                        else
                          begin
                             proxretorno := '01-01-1950';
                          end;
                      end;
                    Dm.SqlAux1.Close;
                    Dm.SqlAux1.Sql.Clear;
                    Dm.SqlAux1.Sql.Add('insert into cga33');
                    Dm.SqlAux1.Sql.Add('(cg33_caixa,cg33_codbaixa,cg33_codusu,cg33_dtret,cg33_dtbaixa,cg33_dtext,cg33_dup,cg33_remes)');
                    Dm.SqlAux1.Sql.Add(' values');
                    Dm.SqlAux1.Sql.Add('(:cg33_caixa,:cg33_codbaixa,:cg33_codusu,:cg33_dtret,:cg33_dtbaixa,:cg33_dtext,:cg33_dup,:cg33_remes)');
                    Dm.SqlAux1.Params[0].Value := Trim(EdCaixa.Text);
                    Dm.SqlAux1.Params[1].Value := Dm.SqlCga20cg20_codbaixa.Value;
                    Dm.SqlAux1.Params[2].Value := Dm.sqlcga_acessocodigo.Value;
                    Dm.SqlAux1.Params[3].Value := proxretorno;
                    Dm.SqlAux1.Params[4].Value := formatdatetime('mm-dd-yyyy',date);
                    Dm.SqlAux1.Params[5].Value := (Copy(EdRemessa.Text,19,4)+'-'+Copy(EdRemessa.Text,17,2)+'-'+Copy(EdRemessa.Text,15,2));
                    Dm.SqlAux1.Params[6].Value := 1;
                    Dm.SqlAux1.Params[7].Value := copy(EdRemessa.Text,1,14);
                    try
                      Dm.SqlAux1.ExecSql;
                      EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                    except on e: exception do
                      begin
                        application.MessageBox('Ocorreu um erro fatal: '+e.Message,'Ads',MB_OK+MB_ICONERROR);
                        EdRemessa.Clear;
                        EdRemessa.SetFocus;
                        exit;
                      end;
                    end;
                    EdRemessa.Clear;
                    EdRemessa.SetFocus;
                  end;
              end;
            end
          else
            begin
              EdRemessa.Clear;
              EdRemessa.SetFocus;
            end;
        end;
  end;
end;

end;

procedure TFrmExtUnificado.BtnFecharClick(Sender: TObject);
begin
 close;
end;

end.
