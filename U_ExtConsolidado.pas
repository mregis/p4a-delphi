unit U_ExtConsolidado;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, Buttons;

type
  TFrmExtConsolidado = class(TForm)
    ScrollBox1: TScrollBox;
    Panel5: TPanel;
    EdCaixa: TEdit;
    Panel6: TPanel;
    DbLkbaixa: TDBLookupComboBox;
    Panel7: TPanel;
    EdQt: TEdit;
    Panel8: TPanel;
    EdRemes: TEdit;
    Panel9: TPanel;
    EdAgencia: TEdit;
    BtnFechar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure seleciona;
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure EdRemesKeyPress(Sender: TObject; var Key: Char);
    function DV11(Matr : string): string;
    function Modulo11(Valor: String; Base: Integer = 7; Resto : boolean = false) : string;

  private
    conta : integer;
    anterior,dgconta : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExtConsolidado: TFrmExtConsolidado;

implementation

uses DmDados, U_Func, DB;

{$R *.dfm}

procedure TFrmExtConsolidado.BtnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFrmExtConsolidado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmExtConsolidado := nil;
  action := cafree;
end;

procedure TFrmExtConsolidado.FormCreate(Sender: TObject);
begin
  conta := 0;
end;

procedure TFrmExtConsolidado.FormShow(Sender: TObject);
begin
  EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmss',time);
end;

procedure TFrmExtConsolidado.EdRemesKeyPress(Sender: TObject;
  var Key: Char);
begin
  case key of
    #13:
        begin

          case dm.SqlCga20cg20_codbaixa.AsInteger of
            100,109,112,117,118 :
              begin
                application.MessageBox('Código de Baixa Inválido'+#10+
                'Favor Recolher o Movimento e'+#10+
                'Entregue-o ao - CPD','Ads',MB_OK+MB_ICONERROR);
                EdRemes.Clear;
                EdRemes.SetFocus;
                exit;
              end;
            else
              begin
                if anterior <> Trim(EdRemes.Text) then
                  begin
                    anterior  := Trim(EdRemes.Text);
                    if Verifica(EdRemes.Text) = 'erro' then
                      begin
                       application.MessageBox('Caracter inválido','Ads',MB_OK+MB_ICONERROR);
                       EdRemes.Clear;
                       exit;
                      end;
                    dm.SqlAux1.Close;
                    dm.SqlAux1.Sql.Clear;
                    dm.SqlAux1.Sql.Add('select count(cg75_dup) from cga75 where (cg75_remes = :cg75_remes) and (cg75_dtbaixa = (select current_date))');
                    dm.SqlAux1.Params[0].AsString := Trim(EdRemes.Text);
                    dm.SqlAux1.Open;
                    if Dm.SqlAux1.Fields[0].Value >= 20 then
                      begin
                        application.MessageBox('Número de Duplicidades Excedidas','Ads',MB_OK+MB_ICONERROR);
                        EdRemes.Clear;
                        exit;
                      end
                    else
                      begin
                        Dm.SqlAux1.Close;
                        Dm.SqlAux1.Sql.Clear;
                        Dm.SqlAux1.Sql.Add('insert into cga75 ');
                        case length(EdRemes.Text) of
                          14:
                             begin
                               Dm.SqlAux1.Sql.Add('(cg75_caixa,cg75_codbaixa,cg75_codusu,cg75_dtbaixa,cg75_dup,cg75_remes,cg75_conta,cg75_codag,cg75_tipo,cg75_dv)');
                                //                       0             1           2          3           4             5      6          7         8
                               Dm.SqlAux1.Sql.Add(' values ');
                               Dm.SqlAux1.Sql.Add('(:cg75_caixa,:cg75_codbaixa,:cg75_codusu,:cg75_dtbaixa,:cg75_dup,:cg75_remes,:cg75_conta,:cg75_codag,:cg75_tipo,:cg75_dv)');
                                //                        0             1            2             3           4          5           6            7          8         9
                               dgconta := Modulo11(Copy(EdRemes.Text,1,7));
                               Dm.SqlAux1.ParamByName('cg75_conta').AsInteger := StrToInt64(Copy(EdRemes.Text,1,7) + dgconta);
                               Dm.SqlAux1.ParamByName('cg75_codag').AsInteger := StrToInt64(Copy(EdRemes.Text,10,5));
                               EdAgencia.Text             := inttostr(strtoint(Copy(EdRemes.Text,10,5)));
                               Dm.SqlAux1.ParamByName('cg75_tipo').AsInteger := 4;
                               Dm.SqlAux1.ParamByName('cg75_dv').AsInteger := StrToInt(Modulo11(Copy(EdRemes.Text,11,4)));
                             end;
                          26:
                             begin
                               Dm.SqlAux1.Sql.Add('(cg75_caixa,cg75_codbaixa,cg75_codusu,cg75_dtbaixa,cg75_dup,cg75_remes,cg75_conta,cg75_codag,cg75_dv,cg75_tipo)');
                                //                       0           1            2             3         4         5          6         7        8          9
                               Dm.SqlAux1.Sql.Add(' values ');
                               Dm.SqlAux1.Sql.Add('(:cg75_caixa,:cg75_codbaixa,:cg75_codusu,:cg75_dtbaixa,:cg75_dup,:cg75_remes,:cg75_conta,:cg75_codag,:cg75_dv,:cg75_tipo)');
                               //                        0             1               2           3           4          5           6           7          8         9
                               Dm.SqlAux1.ParamByName('cg75_remes').AsString := Copy(EdRemes.Text,7,8);
                               Dm.SqlAux1.ParamByname('cg75_codag').AsInteger := StrToInt64(Copy(EdRemes.Text,1,5));
                               Dm.SqlAux1.ParamByName('cg75_dv').AsInteger := StrToInt(Modulo11(Copy(EdRemes.Text,1,5)));
                               Dm.SqlAux1.ParamByName('cg75_tipo').AsInteger := 4;
                               EdAgencia.Text             := inttostr(strtoint(Copy(EdRemes.Text,1,5)));
                             end;
                          32:
                             begin
                               Dm.SqlAux1.Sql.Add('(cg75_caixa,cg75_codbaixa,cg75_codusu,cg75_dtbaixa,cg75_dup,cg75_remes,cg75_codag,cg75_conta,cg75_dtext,cg75_tipo)');
                               Dm.SqlAux1.Sql.Add(' values ');
                               Dm.SqlAux1.Sql.Add('(:cg75_caixa,:cg75_codbaixa,:cg75_codusu,:cg75_dtbaixa,:cg75_dup,:cg75_remes,:cg75_codag,:cg75_conta,:cg75_dtext,:cg75_tipo)');
                               //                       0             1             2             3           4         5           6             7           8           9
                               Dm.SqlAux1.ParamByname('cg75_codag').AsInteger := StrToInt64(copy(EdRemes.Text,1,6));
                               Dm.SqlAux1.ParamByName('cg75_conta').AsInteger := StrToInt64(copy(EdRemes.Text,7,8));
                               EdAgencia.Text             := inttostr(strtoint(copy(EdRemes.Text,1,5)))+'-'+inttostr(strtoint(copy(EdRemes.Text,6,1)));
                               Dm.SqlAux1.ParamByName('cg75_dtext').AsDate := StrToDate(Copy(EdRemes.Text,21,4)+'-'+Copy(EdRemes.Text,19,2)+'-'+Copy(EdRemes.Text,17,2));
                               Dm.SqlAux1.ParamByName('cg75_tipo').AsInteger := StrToInt64(copy(EdRemes.Text,15,2));
                             end;
                        end;
                        Dm.SqlAux1.ParamByName('cg75_caixa').AsInteger := StrToInt64(EdCaixa.Text);
                        Dm.SqlAux1.ParamByName('cg75_codbaixa').AsString := Dm.SqlCga20cg20_codbaixa.AsString;
                        Dm.SqlAux1.ParamByName('cg75_codusu').AsInteger := Dm.sqlcga_acessocodigo.AsInteger;
                        Dm.SqlAux1.ParamByname('cg75_dtbaixa').AsDate := Date;
                        Dm.SqlAux1.ParamByName('cg75_dup').AsInteger := 1;
                        Dm.SqlAux1.ParamByName('cg75_remes').AsString := Trim(EdRemes.Text);
                        try
                          EdRemes.Clear;
                          Dm.SqlAux1.ExecSql;
                          EdQt.Text := inttostr(1+strtoint(EdQt.Text));
                        except on e: exception do
                          begin
                            application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                          end;
                        end;
                      end;
                  end
                else
                  begin
                    EdRemes.Clear;
                    EdRemes.SetFocus;
                    exit;
                  end;
              end;
          end;
        end;
  end;

end;

procedure TFrmExtConsolidado.seleciona;
begin
end;
{Var Dup: Real;
Begin
  If Key = #13 Then
    Begin
      if anterior <> EdRem.Text then
        begin
 //     Sound(20);
      DmDados.TbCgaAcesso.Locate('CGA_Login',FrmAds1.StsMenu.Panels[1].Text,[LoCaseInsensitive]);
      Verifica(EdRem.Text);
      If Length(EdRem.Text) = 32 Then
        Begin
          If DmDados.TbCga75A.FindKey([EdRem.Text]) Then
            Begin
              Dmdados.TbCga75B.Last;
              {If DmDados.TbCga75BCG75_DUP.Value = 20 Then
                Begin
                  ShowMessage('Numero de Duplicidades Excedidas');
                  EdRem.Text := '';
                  EdRem.SetFocus;
                End
              Else
                Begin
                  Dup := (DmDados.TbCga75BCG75_DUP.Value+1);
//                ShowMessage('Remessa já Cadastrada pela  '+(FloatToStr(DmDados.TbCga75BCG75_DUP.Value+1))+'ª  vez');
                  Dmdados.TbCga75A.Edit;
                  Dmdados.TbCga75A.Append;
                  DmDados.TbCga75ACG75_REMES.Value   := EdRem.Text;
                  Dmdados.TbCga75ACG75_DUP.Value     := Dup;
                  DmDados.TbCga75ACG75_AG.Value      := StrToInt(Copy(EdRem.Text,1,6));
                  DmDados.TbCga75ACG75_CONTA.Value   := StrToInt(Copy(EdRem.Text,7,8));
                  EdAg.Text                          := '';
                  EdConta.Text                       := '';
                  EdAg.Text                          := IntToStr(StrToInt(Copy(EdRem.Text,1,5)))+'-'+Copy(EdRem.Text,6,1);
                  EdConta.Text                       := IntToStr(StrToInt(Copy(EdRem.Text,7,7)))+'-'+Copy(EdRem.Text,14,1);
                  DmDados.TbCga75ACG75_TIPO.Value    := Copy(EdRem.Text,15,2);
                  Dmdados.TbCga75ACG75_DTPROC.Value  := StrToDate(Copy(EdRem.Text,17,2)+'/'+Copy(EdRem.Text,19,2)+'/'+Copy(EdRem.Text,21,4));
                  DmDados.TbCga75ACG75_CODBA.Value   := Edbaixa.Text;
                  DmDados.TbCga75ACG75_BAIXA.Value   := LblMot.Caption;
                  DmDados.TbCga75ACG75_CODBRAD.Value := DmDados.TbCga06CG05_CODBRAD.Value;
                  DmDados.TbCga75ACG75_DTBAIXA.Value := Date;
                  Dmdados.TbCga75ACG75_CAIXA.Value   := EdCaixa.Text;
                  DmDados.TbCga75ACG75_CODUSU.Value  := DmDados.TbCgaAcessoCGA_Codigo.Value;
                  Dmdados.TbCga75A.Edit;
                  Dmdados.TbCga75A.Post;
                  Dmdados.TbCga75.Refresh;
                  Dmdados.TbCga75B.Refresh;
                  Dmdados.TbCga75A.Refresh;
                  DbgExt.Refresh;
                  EdQt.Text := IntToStr(DmDados.TbCga75.RecordCount);
                  EdRem.Text := '';
                  EdRem.SetFocus;
                End;
              End
            Else
              Begin
                Dmdados.TbCga75A.Append;
                Dmdados.TbCga75A.Edit;
                DmDados.TbCga75ACG75_REMES.Value   := EdRem.Text;
                Dmdados.TbCga75ACG75_DUP.Value     := 1;
                DmDados.TbCga75ACG75_AG.Value      := StrToInt(Copy(EdRem.Text,1,6));
                DmDados.TbCga75ACG75_CONTA.Value   := StrToInt(Copy(EdRem.Text,7,8));
                EdAg.Text                          := '';
                EdConta.Text                       := '';
                EdAg.Text                          := IntToStr(StrToInt(Copy(EdRem.Text,1,5)))+'-'+Copy(EdRem.Text,6,1);
                EdConta.Text                       := IntToStr(StrToInt(Copy(EdRem.Text,7,7)))+'-'+Copy(EdRem.Text,14,1);
                DmDados.TbCga75ACG75_TIPO.Value    := Copy(EdRem.Text,15,2);
                Dmdados.TbCga75ACG75_DTPROC.Value  := StrToDate(Copy(EdRem.Text,17,2)+'/'+Copy(EdRem.Text,19,2)+'/'+Copy(EdRem.Text,21,4));
                DmDados.TbCga75ACG75_CODBA.Value   := Edbaixa.Text;
                DmDados.TbCga75ACG75_BAIXA.Value   := LblMot.Caption;
                DmDados.TbCga75ACG75_CODBRAD.Value := DmDados.TbCga06CG05_CODBRAD.Value;
                DmDados.TbCga75ACG75_DTBAIXA.Value := Date;
                Dmdados.TbCga75ACG75_CAIXA.Value   := EdCaixa.Text;
                DmDados.TbCga75ACG75_CODUSU.Value  := DmDados.TbCgaAcessoCGA_Codigo.Value;
                Dmdados.TbCga75A.Edit;
                Dmdados.TbCga75A.Post;
                Dmdados.TbCga75.Refresh;
                Dmdados.TbCga75B.Refresh;
                Dmdados.TbCga75A.Refresh;
                DbgExt.Refresh;
                EdQt.Text := IntToStr(DmDados.TbCga75.RecordCount);
                EdRem.Text := '';
                EdRem.SetFocus;
              End;
            End
      Else If Length(EdRem.Text) = 14 Then
        Begin
          If DmDados.TbCga75A.FindKey([EdRem.Text]) Then
            Begin
              Dmdados.TbCga75B.Last;
              {If DmDados.TbCga75BCG75_DUP.Value = 20 Then
                Begin
                  ShowMessage('Numero de Duplicidades Excedidas');
                  EdRem.Text := '';
                  EdRem.SetFocus;
                End
              Else
                Begin
                  Dup := (DmDados.TbCga75BCG75_DUP.Value+1);
                  Dmdados.TbCga75A.Edit;
                  Dmdados.TbCga75A.Append;
                  DmDados.TbCga75ACG75_REMES.Value   := EdRem.Text;
                  Dmdados.TbCga75ACG75_DUP.Value     := Dup;
                  DmDados.TbCga75ACG75_AG.Value      := StrToInt(Copy(EdRem.Text,10,5));
                  DmDados.TbCga75ACG75_CONTA.Value   := StrToInt(Copy(EdRem.Text,1,7));
                  EdAg.Text                          := '';
                  EdConta.Text                       := '';
                  EdAg.Text                          := IntToStr(StrToInt(Copy(EdRem.Text,10,5)));
                  EdConta.Text                       := IntToStr(StrToInt(Copy(EdRem.Text,1,7)));
                  DmDados.TbCga75ACG75_TIPO.Value    := Copy(EdRem.Text,8,2);
                  DmDados.TbCga75ACG75_CODBA.Value   := Edbaixa.Text;
                  DmDados.TbCga75ACG75_BAIXA.Value   := LblMot.Caption;
                  DmDados.TbCga75ACG75_CODBRAD.Value := DmDados.TbCga06CG05_CODBRAD.Value;
                  DmDados.TbCga75ACG75_DTBAIXA.Value := Date;
                  Dmdados.TbCga75ACG75_CAIXA.Value   := EdCaixa.Text;
                  DmDados.TbCga75ACG75_CODUSU.Value  := DmDados.TbCgaAcessoCGA_Codigo.Value;
                  Dmdados.TbCga75A.Edit;
                  Dmdados.TbCga75A.Post;
                  Dmdados.TbCga75.Refresh;
                  Dmdados.TbCga75B.Refresh;
                  Dmdados.TbCga75A.Refresh;
                  DbgExt.Refresh;
                  EdQt.Text := IntToStr(DmDados.TbCga75.RecordCount);
                  EdRem.Text := '';
                  EdRem.SetFocus;
                End;
              End
            Else
              Begin
                Dmdados.TbCga75A.Append;
                Dmdados.TbCga75A.Edit;
                DmDados.TbCga75ACG75_REMES.Value   := EdRem.Text;
                Dmdados.TbCga75ACG75_DUP.Value     := 1;
                DmDados.TbCga75ACG75_AG.Value      := StrToInt(Copy(EdRem.Text,10,5));
                DmDados.TbCga75ACG75_CONTA.Value   := StrToInt(Copy(EdRem.Text,1,7));
                EdAg.Text                          := '';
                EdConta.Text                       := '';
                EdAg.Text                          := IntToStr(StrToInt(Copy(EdRem.Text,10,5)));
                EdConta.Text                       := IntToStr(StrToInt(Copy(EdRem.Text,1,7)));
                DmDados.TbCga75ACG75_TIPO.Value    := Copy(EdRem.Text,8,2);
                DmDados.TbCga75ACG75_CODBA.Value   := Edbaixa.Text;
                DmDados.TbCga75ACG75_BAIXA.Value   := LblMot.Caption;
                DmDados.TbCga75ACG75_CODBRAD.Value := DmDados.TbCga06CG05_CODBRAD.Value;
                DmDados.TbCga75ACG75_DTBAIXA.Value := Date;
                Dmdados.TbCga75ACG75_CAIXA.Value   := EdCaixa.Text;
                DmDados.TbCga75ACG75_CODUSU.Value  := DmDados.TbCgaAcessoCGA_Codigo.Value;
                Dmdados.TbCga75A.Edit;
                Dmdados.TbCga75A.Post;
                Dmdados.TbCga75.Refresh;
                Dmdados.TbCga75B.Refresh;
                Dmdados.TbCga75A.Refresh;
                DbgExt.Refresh;
                EdQt.Text := IntToStr(DmDados.TbCga75.RecordCount);
                EdRem.Text := '';
                EdRem.SetFocus;
              End;
        End
      Else If Length(EdRem.Text) = 26 Then
        Begin
          If DmDados.TbCga75A.FindKey([EdRem.Text]) Then
            Begin
              Dmdados.TbCga75B.Last;
              {If DmDados.TbCga75BCG75_DUP.Value = 20 Then
                Begin
                  ShowMessage('Numero de Duplicidades Excedidas');
                  EdRem.Text := '';
                  EdRem.SetFocus;
                End
              Else
                Begin
                  Dup := (DmDados.TbCga75BCG75_DUP.Value+1);
                  Dmdados.TbCga75A.Edit;
                  Dmdados.TbCga75A.Append;
                  DmDados.TbCga75ACG75_REMES.Value   := EdRem.Text;
                  Dmdados.TbCga75ACG75_DUP.Value     := Dup;
                  DmDados.TbCga75ACG75_AG.Value      := StrToInt(Copy(EdRem.Text,1,5));
                  DmDados.TbCga75ACG75_CONTA.Value   := StrToInt(Copy(EdRem.Text,8,7));
                  EdAg.Text                          := '';
                  EdConta.Text                       := '';
                  EdAg.Text                          := IntToStr(StrToInt(Copy(EdRem.Text,1,5)));
                  EdConta.Text                       := IntToStr(StrToInt(Copy(EdRem.Text,8,7)));
                  DmDados.TbCga75ACG75_CODBA.Value   := Edbaixa.Text;
                  DmDados.TbCga75ACG75_BAIXA.Value   := LblMot.Caption;
                  DmDados.TbCga75ACG75_CODBRAD.Value := DmDados.TbCga06CG05_CODBRAD.Value;
                  DmDados.TbCga75ACG75_DTBAIXA.Value := Date;
                  Dmdados.TbCga75ACG75_CAIXA.Value   := EdCaixa.Text;
                  DmDados.TbCga75ACG75_CODUSU.Value  := DmDados.TbCgaAcessoCGA_Codigo.Value;
                  Dmdados.TbCga75A.Edit;
                  Dmdados.TbCga75A.Post;
                  Dmdados.TbCga75.Refresh;
                  Dmdados.TbCga75B.Refresh;
                  Dmdados.TbCga75A.Refresh;
                  DbgExt.Refresh;
                  EdQt.Text := IntToStr(DmDados.TbCga75.RecordCount);
                  EdRem.Text := '';
                  EdRem.SetFocus;
                End;
              End
            Else
              Begin
                Dmdados.TbCga75A.Append;
                Dmdados.TbCga75A.Edit;
                DmDados.TbCga75ACG75_REMES.Value   := EdRem.Text;
                Dmdados.TbCga75ACG75_DUP.Value     := 1;
                DmDados.TbCga75ACG75_AG.Value      := StrToInt(Copy(EdRem.Text,1,5));
                DmDados.TbCga75ACG75_CONTA.Value   := StrToInt(Copy(EdRem.Text,8,7));
                EdAg.Text                          := '';
                EdConta.Text                       := '';
                EdAg.Text                          := IntToStr(StrToInt(Copy(EdRem.Text,1,5)));
                EdConta.Text                       := IntToStr(StrToInt(Copy(EdRem.Text,8,7)));
                DmDados.TbCga75ACG75_CODBA.Value   := Edbaixa.Text;
                DmDados.TbCga75ACG75_BAIXA.Value   := LblMot.Caption;
                DmDados.TbCga75ACG75_CODBRAD.Value := DmDados.TbCga06CG05_CODBRAD.Value;
                DmDados.TbCga75ACG75_DTBAIXA.Value := Date;
                Dmdados.TbCga75ACG75_CAIXA.Value   := EdCaixa.Text;
                DmDados.TbCga75ACG75_CODUSU.Value  := DmDados.TbCgaAcessoCGA_Codigo.Value;
                Dmdados.TbCga75A.Edit;
                Dmdados.TbCga75A.Post;
                Dmdados.TbCga75.Refresh;
                Dmdados.TbCga75B.Refresh;
                Dmdados.TbCga75A.Refresh;
                DbgExt.Refresh;
                EdQt.Text := IntToStr(DmDados.TbCga75.RecordCount);
                EdRem.Text := '';
                EdRem.SetFocus;
              End;
        End
      Else
        Begin
          ShowMessage('Numero de Remessa incorreto');
          EdRem.Text := '';
          EdRem.SetFocus;
        End;
     End
      else
       begin
         EdRem.Clear;
         EdRem.SetFocus;
       end;
    end;
End;}
//Calcula o digito verificador


function TFrmExtConsolidado.DV11(Matr: string): string;
{Calculo pelo módulo 11 - tabela 2..7}
var
X, Cont, Soma,mult, DV, NMatr : integer;
begin
Cont := 4; Soma := 0;
mult := 5;
For X := 1 to 4 do
begin
NMatr := StrToInt(Copy(Matr,Cont-3,1));
Soma := Soma + (NMatr * mult);
Inc(Cont);
dec(mult);
end;
DV := Soma mod 11;
if DV > 9 then DV := 11 - DV;
Result := IntToStr(DV);
end;

Function TFrmExtConsolidado.Modulo11(Valor: String; Base: Integer = 7; Resto : boolean = false) : string;

var
   Soma : integer;
   Contador, Peso, Digito : integer;
begin
   Soma := 0;
   Peso := 2;
   for Contador := Length(Valor) downto 1 do
   begin
      Soma := Soma + (StrToInt(Valor[Contador]) * Peso);
       if Peso < Base then
          Peso := Peso + 1
       else
          Peso := 2;
    end;
   if Resto then
      Result := IntToStr(Soma mod 11)
   else begin
      Digito := 11 - (Soma mod 11);
        if (Digito > 9) then
            Digito := 0;
      Result := IntToStr(Digito);
   end

end;



end.
