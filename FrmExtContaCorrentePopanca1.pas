unit FrmExtContaCorrentePopanca1;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, QTypes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, Buttons, ComCtrls, Mask;

type
  TFrmExtContaCorrentePoupanca = class(TForm)
    ScrollBox1: TScrollBox;
    DbLkBaixa: TDBLookupComboBox;
    EdCaixa: TEdit;
    EdQt: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    BtnFechar: TBitBtn;
    StBr: TStatusBar;
    GroupTipo: TGroupBox;
    ChkLeitura: TRadioButton;
    ChkDigita: TRadioButton;
    EdRemessa: TMaskEdit;
    Edremessa2: TMaskEdit;
    Panel5: TPanel;
    RdGrptipocli: TRadioGroup;
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdRemessaKeyPress(Sender: TObject; var Key: Char);
    procedure ChkDigitaClick(Sender: TObject);
    procedure ChkLeituraClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edremessa2KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Edremessa2Exit(Sender: TObject);
  private
    anterior,anterior2 : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExtContaCorrentePoupanca: TFrmExtContaCorrentePoupanca;

implementation

uses DmDados, U_Func, DB;

{$R *.dfm}

procedure TFrmExtContaCorrentePoupanca.BtnFecharClick(Sender: TObject);
begin
//  showmessage( '2558-5 =original /  calculado='+ (VerificaDigito11(2558));
  close;
end;

procedure TFrmExtContaCorrentePoupanca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := cafree;
end;

procedure TFrmExtContaCorrentePoupanca.EdRemessaKeyPress(Sender: TObject;
  var Key: Char);
var
  proxretorno : variant;
  total : integer;
  testa : string;
  calculado : integer;
  numero   : integer;
  digito    : integer;


begin
  case key of
    #13:
       begin
    case tag of
      11: // cartao segurança
        begin
          if anterior <> EdRemessa.Text then
              begin
                anterior := EdRemessa.Text;
                //Testa:= Verifica(EdRemessa.Text);
                //if (length(EdRemessa.Text)<> 17) and (Testa<>'erro') and (ChkDigita.Checked=True) and (GroupTipo.Visible=True) then
                //  Testa:=VerificaValidade_Codigo(EdRemessa.Text);
                if testa <> 'erro' then
                  begin
                    If (Length(EdRemessa.Text) = 20) Then
                      Begin
                        Dm.SqlAux1.Close;
                        Dm.SqlAux1.Sql.Clear;
                        Dm.SqlAux1.Sql.Add('select count(*) from cga140 where cg140_remes = :cg140_remes');
                        Dm.SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                        Dm.SqlAux1.Open;
  //                            total := Dm.SqlAux1.Fields[0].AsInteger;
                        case Dm.SqlAux1.Fields[0].AsInteger of
                          0:
                            begin
                              Dm.SqlAux1.Close;
                              Dm.SqlAux1.Sql.Clear;
                              Dm.SqlAux1.Sql.Add('insert into cga140 (');
                              Dm.SqlAux1.Sql.Add('cg140_remes,cg140_dup,cg140_codag,cg140_dtcad,');
                              Dm.SqlAux1.Sql.Add('cg140_caixa,cg140_codusu)');
                              Dm.SqlAux1.Sql.Add(' values ');
                              Dm.SqlAux1.Sql.Add('(:cg140_remes,:cg140_dup,:cg140_codag,:cg140_dtcad,');
                              Dm.SqlAux1.Sql.Add(':cg140_caixa,:cg140_codusu)');
                              Dm.SqlAux1.Params[0].Value := EdRemessa.Text;
                              Dm.SqlAux1.Params[1].Value := total + 1;
                              Dm.SqlAux1.Params[2].Value := copy(EdRemessa.Text,5,4);
                              Dm.SqlAux1.Params[3].Value := formatdatetime('yyyy-mm-dd',date);
                              Dm.SqlAux1.Params[4].Value := trim(EdCaixa.Text);
                              Dm.SqlAux1.Params[5].Value := Dm.sqlcga_acessocodigo.AsInteger;
                              total:=total+1;
                              try
                                Dm.SqlAux1.ExecSql;
                                StBr.Panels[0].Text := '';
                                EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                              except on e: exception do
                                begin
                                  application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                                  EdRemessa.Clear;
                                  EdRemessa.SetFocus;
                                  exit;
                                end;
                            end;
                          end
                          else
                            begin
                              EdRemessa.Clear;
                              EdRemessa.SetFocus;
                              exit;
                            end;
                        end;
                      end
                  else
                    Application.MessageBox('Esse código de remessa está fora de padrão.'+chr(10)+'Procure o administrador do sistema e relate o erro.','Erro na leitura !',MB_OK+MB_ICONERROR);
                end
              else
                Application.MessageBox('Esse código de remessa está fora de padrão.'+chr(10)+'Procure o administrador do sistema e relate o erro.','Erro na leitura !',MB_OK+MB_ICONERROR);
            end;
            EdRemessa.Clear;
            EdRemessa.SetFocus;
        end;
      else
      begin
          case dm.SqlCga20cg20_codbaixa.AsInteger of
            100,109,112,117,118 :
              begin
                application.MessageBox('Código de Baixa Inválido'+#10+
                'Favor Recolher o Movimento e'+#10+
                'Entregue-o ao Sr. Renato - CPD','Ads',MB_OK+MB_ICONERROR);
                EdRemessa.Clear;
                EdRemessa.SetFocus;
                exit;
              end;
            else
              begin
                case tag of
                  1: // extrato conta corrente poupança
                    begin
                      if anterior <> Trim(EdRemessa.Text) then
                        begin
                          anterior  := Trim(EdRemessa.Text);
                          if Verifica(EdRemessa.Text) = 'erro' then
                            begin
                             application.MessageBox('Caracter inválido','Ads',MB_OK+MB_ICONERROR);
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
                                   StBr.Panels[0].Text := '';
                                   EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                                 except on e: exception do
                                   begin
                                     application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                                     EdRemessa.Clear;
                                     EdRemessa.SetFocus;
                                     exit;
                                   end;
                                 end;
                                 EdRemessa.Clear;
                                 EdRemessa.SetFocus;
                               end;
                          else
                            begin
                              StBr.Panels[0].Text := 'Numero de remessa Incorreta';
                              EdRemessa.Clear;
                              EdRemessa.SetFocus;
                            end;
                          end;
                        end
                      else
                        begin
                          StBr.Panels[0].Text := 'Anterior igual ao atual';
                          EdRemessa.Clear;
                          EdRemessa.SetFocus;
                        end;
                    end;
                  2: // extrato unificado
                    begin

                            if anterior <> Trim(EdRemessa.Text) then
                              begin
                                anterior  := Trim(EdRemessa.Text);
                                if Verifica(EdRemessa.Text) = 'erro' then
                                  begin
                                   application.MessageBox('Caracter inválido','Ads',MB_OK+MB_ICONERROR);
                                   EdRemessa.Clear;
                                   EdRemessa.SetFocus;
                                   exit;
                                  end;
                               case length(EdRemessa.Text) of
                                 30,34:
                                   begin
                                     calculado := StrToInt(VerificaDigito11(Copy(EdRemessa.Text,6,7)));
                                     numero    := StrToInt(Copy(EdRemessa.Text,6,7));
                                     digito    := StrToInt(Copy(EdRemessa.Text,13,1));
                                     //showmessage('Numero: '+IntToStr(numero)+' - '+IntToStr(digito)+' ||Calculado: '+IntToStr(calculado));
                                     if ((Copy(EdRemessa.Text,5,1)) <> ((VerificaDigito11(copy(EdRemessa.Text,1,4))))) or ((Copy(EdRemessa.Text,13,1)) <> ((VerificaDigito11(Copy(EdRemessa.Text,6,7))))) then
                                       begin
                                         MessageDlg('Código de Agência ou Conta Inválido',mtwarning,[mbok],0);
                                         EdRemessa.Clear;
                                         EdRemessa.SetFocus;
                                       end
                                     else
                                       begin
                                         Dm.SqlAux1.Close;
                                         Dm.SqlAux1.Sql.Clear;
                                         Dm.SqlAux1.Sql.Add('select count(*) from cga68 where cg68_remes = :cg68_remes');
                                         Dm.SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                                         Dm.SqlAux1.Open;
                                         total := 0;
                                        total := Dm.SqlAux1.Fields[0].AsInteger;
                                        case Dm.SqlAux1.Fields[0].AsInteger of
                                          3:
                                            begin
                                              StBr.Panels[0].Text := 'Numero de remessas excedidas';
                                              EdRemessa.Clear;
                                              exit; // remessas excedidas
                                            end;
                                        else
                                          begin
                                            Dm.SqlAux1.Close;
                                            Dm.SqlAux1.Sql.Clear;
                                            Dm.SqlAux1.Sql.Add('insert into cga68');
                                            Dm.SqlAux1.Sql.Add('(cg68_remes,cg68_dup,cg68_dtext,cg68_codbaixa,');
                                            Dm.SqlAux1.Sql.Add('cg68_caixa,cg68_codusu,cg68_codag,cg68_tipo,cg68_dtbaixa) ');
                                            Dm.SqlAux1.Sql.Add(' values ');
                                            Dm.SqlAux1.Sql.Add('(:cg68_remes,:cg68_dup,:cg68_dtext,:cg68_codbaixa,');
                                            Dm.SqlAux1.Sql.Add(':cg68_caixa,:cg68_codusu,:cg68_codag,:cg68_tipo,:cg68_dtbaixa) ');
                                            Dm.SqlAux1.Params[0].Value := EdRemessa.Text;
                                            Dm.SqlAux1.Params[1].Value := total + 1;
                                            Dm.SqlAux1.Params[2].Value := Copy(EdRemessa.Text,18,4)+'-'+Copy(EdRemessa.Text,16,2)+'-'+Copy(EdRemessa.Text,14,2);
                                            //Dm.SqlAux1.Params[2].Value := Copy(EdRemessa.Text,21,4)+'-'+Copy(EdRemessa.Text,19,2)+'-'+Copy(EdRemessa.Text,17,2);
                                            Dm.SqlAux1.Params[3].Value := Dm.SqlCga20cg20_codbaixa.Value;
                                            Dm.SqlAux1.Params[4].Value := EdCaixa.Text;
                                            Dm.SqlAux1.Params[5].Value := Dm.sqlcga_acessocodigo.AsInteger;
                                            Dm.SqlAux1.Params[6].Value := Copy(EdRemessa.Text,1,5);
                                            Dm.SqlAux1.Params[7].Value := copy(EdRemessa.Text,22,2);
                                            Dm.SqlAux1.Params[8].Value := formatdatetime('yyyy-mm-dd',date);
                                            try
                                              Dm.SqlAux1.ExecSql;
                                              StBr.Panels[0].Text := '';
                                              EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                                              EdRemessa.Clear;
                                              EdRemessa.SetFocus;
                                            except on e: exception do
                                              begin
                                                application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                                                EdRemessa.Clear;
                                                EdRemessa.SetFocus;
                                                exit;
                                              end;
                                            end;
                                          end;
                                        end;
                                      end;
                                    end;
                               else
                                 begin
                                   StBr.Panels[0].Text := 'Numero de remessa Incorreta';
                                   EdRemessa.Clear;
                                   EdRemessa.SetFocus;
                                 end;
                               end;
                              end
                            else
                              begin
                                StBr.Panels[0].Text := 'Anterior igual ao atual';
                                EdRemessa.Clear;
                                EdRemessa.SetFocus;
                              end;

                    end;
                  3: // extrato drc
                    begin
                      if anterior <> EdRemessa.Text then
                          begin
                            anterior := EdRemessa.Text;
                            Testa:= Verifica(EdRemessa.Text);
                            if (length(EdRemessa.Text)=13) and (Testa<>'erro') and (ChkDigita.Checked=True) and (GroupTipo.Visible=True) then
                              Testa:=VerificaValidade_Codigo(EdRemessa.Text);

                            if testa <> 'erro' then
                              begin
                                If (Length(EdRemessa.Text) = 18) or ((Length(EdRemessa.Text)>=11) and (Length(EdRemessa.Text)<=13)) Then
                                  Begin
                                    Dm.SqlAux1.Close;
                                    Dm.SqlAux1.Sql.Clear;
                                    Dm.SqlAux1.Sql.Add('select count(*) from cga100 where cg100_remes = :cg100_remes');
                                    Dm.SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                                    Dm.SqlAux1.Open;
        //                            total := Dm.SqlAux1.Fields[0].AsInteger;
                                    case Dm.SqlAux1.Fields[0].AsInteger of
                                      3: // remessas excedidas
                                        begin
                                          EdRemessa.Clear;
                                          EdRemessa.SetFocus;
                                          exit;
                                        end;
                                    else
                                      begin
                                        Dm.SqlAux1.Close;
                                        Dm.SqlAux1.Sql.Clear;
                                        Dm.SqlAux1.Sql.Add('insert into cga100 (');
                                        Dm.SqlAux1.Sql.Add('cg100_remes,cg100_dup,cg100_dtbaixa,cg100_codbaixa,');
                                        Dm.SqlAux1.Sql.Add('cg100_caixa,cg100_codusu)');
                                        Dm.SqlAux1.Sql.Add(' values ');
                                        Dm.SqlAux1.Sql.Add('(:cg100_remes,:cg100_dup,:cg100_dtbaixa,:cg100_codbaixa,');
                                        Dm.SqlAux1.Sql.Add(':cg100_caixa,:cg100_codusu)');
                                        Dm.SqlAux1.Params[0].Value := EdRemessa.Text;
                                        Dm.SqlAux1.Params[1].Value := total + 1;
                                        Dm.SqlAux1.Params[2].Value := formatdatetime('yyyy-mm-dd',date);
                                        Dm.SqlAux1.Params[3].Value := Dm.SqlCga20cg20_codbaixa.Value;
                                        Dm.SqlAux1.Params[4].Value := EdCaixa.Text;
                                        Dm.SqlAux1.Params[5].Value := Dm.sqlcga_acessocodigo.AsInteger;
                                        total:=total+1;
                                        try
                                          Dm.SqlAux1.ExecSql;
                                          StBr.Panels[0].Text := '';
                                          EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                                        except on e: exception do
                                          begin
                                            application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                                            EdRemessa.Clear;
                                            EdRemessa.SetFocus;
                                            exit;
                                          end;
                                      end;
                                    End;
                                  End;
                              end
                            else
                              Application.MessageBox('Esse código de remessa está fora de padrão. Procure o administrador do sistema e relate o erro.','Erro na leitura !',MB_OK+MB_ICONERROR);

                            end;
                        End;

                        EdRemessa.Clear;
                        EdRemessa.SetFocus;

                    end;
                  4: // extrato cartao
                    begin
                      if anterior <> Trim(EdRemessa.Text) then
                        begin
                          anterior  := Trim(EdRemessa.Text);
                          if Verifica(EdRemessa.Text) = 'erro' then
                            begin
                             application.MessageBox('Caracter inválido','Ads',MB_OK+MB_ICONERROR);
                             EdRemessa.Clear;
                             EdRemessa.SetFocus;
                             exit;
                            end;
                         case length(EdRemessa.Text) of
                           32:
                             begin
                               Dm.SqlAux1.Close;
                               Dm.SqlAux1.Sql.Clear;
                               Dm.SqlAux1.Sql.Add('select count(*) from cga67 where cg67_remes = :cg67_remes');
                               Dm.SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                               Dm.SqlAux1.Open;
                               total := 0;
                               total := Dm.SqlAux1.Fields[0].AsInteger;
                               case Dm.SqlAux1.Fields[0].AsInteger of
                                 3:
                                   begin
                                     StBr.Panels[0].Text := 'Numero de remessas excedidas';
                                     EdRemessa.Clear;
                                     exit; // remessas excedidas
                                   end;
                               else
                                 begin
                                   Dm.SqlAux1.Close;
                                   Dm.SqlAux1.Sql.Clear;
                                   Dm.SqlAux1.Sql.Add('insert into cga67');
                                   Dm.SqlAux1.Sql.Add('(cg67_remes,cg67_dup,cg67_dtext,cg67_codbaixa,');
                                   Dm.SqlAux1.Sql.Add('cg67_caixa,cg67_codusu,cg67_dtbaixa) ');
                                   Dm.SqlAux1.Sql.Add(' values ');
                                   Dm.SqlAux1.Sql.Add('(:cg67_remes,:cg67_dup,:cg67_dtext,:cg67_codbaixa,');
                                   Dm.SqlAux1.Sql.Add(':cg67_caixa,:cg67_codusu,:cg67_dtbaixa) ');
                                   Dm.SqlAux1.Params[0].Value := EdRemessa.Text;
                                   Dm.SqlAux1.Params[1].Value := total + 1;
                                   Dm.SqlAux1.Params[2].Value := Copy(EdRemessa.Text,25,4) + '-' + Copy(EdRemessa.Text,29,2) +'-'+ Copy(EdRemessa.Text,31,2)   ;
                                   Dm.SqlAux1.Params[3].Value := Dm.SqlCga20cg20_codbaixa.Value;
                                   Dm.SqlAux1.Params[4].Value := EdCaixa.Text;
                                   Dm.SqlAux1.Params[5].Value := Dm.sqlcga_acessocodigo.AsInteger;
                                   Dm.SqlAux1.Params[6].Value := formatdatetime('yyyy-mm-dd',date);
                                   try
                                     Dm.SqlAux1.ExecSql;
                                     StBr.Panels[0].Text := '';
                                     EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                                     EdRemessa.Clear;
                                     EdRemessa.SetFocus;
                                   except on e: exception do
                                     begin
                                       application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                                       EdRemessa.Clear;
                                       EdRemessa.SetFocus;
                                       exit;
                                     end;
                                  end;
                                end;
                             end;
                           end;
                         else
                           begin
                             StBr.Panels[0].Text := 'Numero de remessa Incorreta';
                             EdRemessa.Clear;
                             EdRemessa.SetFocus;
                           end;
                         end;
                        end
                      else
                        begin
                          StBr.Panels[0].Text := 'Anterior igual ao atual';
                          EdRemessa.Clear;
                          EdRemessa.SetFocus;
                        end;
                     end;
                  5: // extrato CVM
                    begin
                      if anterior <> Trim(EdRemessa.Text) then
                        begin
                          anterior  := Trim(EdRemessa.Text);
                          if Verifica(EdRemessa.Text) = 'erro' then
                            begin
                             application.MessageBox('Caracter inválido','Ads',MB_OK+MB_ICONERROR);
                             EdRemessa.Clear;
                             EdRemessa.SetFocus;
                             exit;
                            end
                          else
                            begin
                              case length(trim(edremessa.Text)) of
                                24:
                                   begin
                                     Edremessa2.SetFocus;
                                   end;
                              else
                                begin
                                  application.MessageBox('Numero de Remessa Incorreto','Ads',MB_OK+MB_ICONERROR);
                                  EdRemessa.Clear;
                                  EdRemessa.SetFocus;
                                  exit;
                                end;
                              end;
                            end;
                        end
                      else
                        begin
                          StBr.Panels[0].Text := 'Anterior igual ao atual';
                          EdRemessa.Clear;
                          EdRemessa.SetFocus;
                          exit;
                        end;
                    end;
                  6: // extrato Banco Postal
                    begin
                      if anterior <> Trim(EdRemessa.Text) then
                        begin
                          anterior  := Trim(EdRemessa.Text);
                          if Verifica(EdRemessa.Text) = 'erro' then
                            begin
                             application.MessageBox('Caracter inválido','Ads',MB_OK+MB_ICONERROR);
                             EdRemessa.Clear;
                             EdRemessa.SetFocus;
                             exit;
                            end;
                         case length(EdRemessa.Text) of
                           16:
                             begin
                               Dm.SqlAux1.Close;
                               Dm.SqlAux1.Sql.Clear;
                               Dm.SqlAux1.Sql.Add('select count(*) from cga70 where cg70_remes = :cg70_remes');
                               Dm.SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                               Dm.SqlAux1.Open;
                               total := 0;
                               total := Dm.SqlAux1.Fields[0].AsInteger;
                               case Dm.SqlAux1.Fields[0].AsInteger of
                                 3:
                                   begin
                                     StBr.Panels[0].Text := 'Numero de remessas excedidas';
                                     EdRemessa.Clear;
                                     exit; // remessas excedidas
                                   end;
                               else
                                 begin
                                   Dm.SqlAux1.Close;
                                   Dm.SqlAux1.Sql.Clear;
                                   Dm.SqlAux1.Sql.Add('insert into cga70');
                                   Dm.SqlAux1.Sql.Add('(cg70_remes,cg70_codbaixa,');
                                   Dm.SqlAux1.Sql.Add('cg70_caixa,cg70_codusu,cg70_dtbaixa) ');
                                   Dm.SqlAux1.Sql.Add(' values ');
                                   Dm.SqlAux1.Sql.Add('(:cg70_remes,:cg70_codbaixa,');
                                   Dm.SqlAux1.Sql.Add(':cg70_caixa,:cg70_codusu,:cg70_dtbaixa) ' );
                                   Dm.SqlAux1.Params[0].Value := EdRemessa.Text;
                                   Dm.SqlAux1.Params[1].Value := Dm.SqlCga20cg20_codbaixa.Value;
                                   Dm.SqlAux1.Params[2].Value := EdCaixa.Text;
                                   Dm.SqlAux1.Params[3].Value := Dm.sqlcga_acessocodigo.AsInteger;
                                   Dm.SqlAux1.Params[4].Value := formatdatetime('yyyy-mm-dd',date);
                                   try
                                     Dm.SqlAux1.ExecSql;
                                     StBr.Panels[0].Text := '';
                                     EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                                     EdRemessa.Clear;
                                     EdRemessa.SetFocus;
                                   except on e: exception do
                                     begin
                                       application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                                       EdRemessa.Clear;
                                       EdRemessa.SetFocus;
                                       exit;
                                     end;
                                   end;
                               end;
                             end;
                           end
                         else
                           begin
                             StBr.Panels[0].Text := 'Numero de remessa Incorreta';
                             EdRemessa.Clear;
                             EdRemessa.SetFocus;
                           end;
                         end;
                        end
                      else
                        begin
                          StBr.Panels[0].Text := 'Anterior igual ao atual';
                          EdRemessa.Clear;
                          EdRemessa.SetFocus;
                        end;
                     end;
                  7: // Entrada de Token
                    begin
                      if anterior <> Trim(EdRemessa.Text) then
                        begin
                          anterior  := Trim(EdRemessa.Text);
                          if Verifica(EdRemessa.Text) = 'erro' then
                            begin
                             application.MessageBox('Caracter inválido','Ads',MB_OK+MB_ICONERROR);
                             EdRemessa.Clear;
                             EdRemessa.SetFocus;
                             exit;
                            end;
                         case length(EdRemessa.Text) of
                           10:
                             begin
                               Dm.SqlAux1.Close;
                               Dm.SqlAux1.Sql.Clear;
                               Dm.SqlAux1.Sql.Add('select count(*) from cga76 where cg76_remes = :cg76_remes');
                               Dm.SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                               Dm.SqlAux1.Open;
                               If Dm.SqlAux1.Fields[0].AsInteger <> 0  Then
                                 Begin
                                   application.MessageBox(PChar('Remessa já Cadastrada: '),'Ads',MB_OK+MB_ICONERROR);
                                   EdRemessa.Clear;
                                   EdRemessa.SetFocus;
                                 End
                               else
                                 begin
                                   Dm.SqlAux1.Close;
                                   Dm.SqlAux1.Sql.Clear;
                                   Dm.SqlAux1.Sql.Add('insert into cga76');
                                   Dm.SqlAux1.Sql.Add('(cg76_remes,cg76_dtentr,cg76_caixa)');
                                   Dm.SqlAux1.Sql.Add(' values ');
                                   Dm.SqlAux1.Sql.Add('(:cg76_remes,:cg76_dtentr,:cg76_caixa)');
                                   Dm.SqlAux1.Params[0].Value := EdRemessa.Text;
                                   Dm.SqlAux1.Params[1].Value := formatdatetime('yyyy-mm-dd',date);
                                   Dm.SqlAux1.Params[2].Value := EdCaixa.Text;
                                   try
                                     Dm.SqlAux1.ExecSql;
                                     StBr.Panels[0].Text := '';
                                     EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                                     EdRemessa.Clear;
                                     EdRemessa.SetFocus;
                                   except on e: exception do
                                     begin
                                       application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                                       EdRemessa.Clear;
                                       EdRemessa.SetFocus;
                                       exit;
                                     end;
                                  end;
                                end;
                             end
                         else
                           begin
                             StBr.Panels[0].Text := 'Numero de remessa Incorreta';
                             EdRemessa.Clear;
                             EdRemessa.SetFocus;
                           end;
                         end;
                        end
                      else
                        begin
                          StBr.Panels[0].Text := 'Anterior igual ao atual';
                          EdRemessa.Clear;
                          EdRemessa.SetFocus;
                        end;
                     end;
                  8: // Saida  de Token
                    Begin
                      case length(EdRemessa.Text) of
                         10:
                           Begin
                             Dm.SqlAux1.Close;
                             Dm.SqlAux1.Sql.Clear;
                             Dm.SqlAux1.Sql.Add('select count(*) from cga76 where cg76_remes = :cg76_remes');
                             Dm.SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                             Dm.SqlAux1.Open;
                             If Dm.SqlAux1.Fields[0].AsInteger <> 0  Then
                               Begin
                                 Dm.SqlAux1.Close;
                                 Dm.SqlAux1.Sql.Clear;
                                 Dm.SqlAux1.Sql.Add('select cg76_ag from cga76 where cg76_remes = :cg76_remes');
                                 Dm.SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                                 Dm.SqlAux1.Open;
                                 If (Dm.SqlAux1.Fields[0].Value = '') or (Dm.SqlAux1.Fields[0].Value = null) Then
                                   Begin
                                     Dm.SqlAux1.Close;
                                     Dm.SqlAux1.Sql.Clear;
                                     Dm.SqlAux1.Sql.Add('update cga76 set ');
                                     Dm.SqlAux1.Sql.Add('cg76_codbaixa=:codbaixa,cg76_dtsai=:dtsaida,cg76_ag=:ag,cg76_tipocli=:tipocli ');
                                     Dm.SqlAux1.Sql.Add('where cg76_remes=:cg76_remes');
                                     Dm.SqlAux1.Params[0].Value := dm.SqlCga20cg20_codbaixa.Value;
                                     Dm.SqlAux1.Params[1].Value := formatdatetime('yyyy-mm-dd',date);
                                     Dm.SqlAux1.Params[2].Value := Trim(EdRemessa2.Text);
                                     case self.RdGrptipocli.ItemIndex of
                                       0: Dm.SqlAux1.Params[3].Value := 0;
                                       1: Dm.SqlAux1.Params[3].Value := 1;
                                     end;
                                     Dm.SqlAux1.Params[4].Value := Trim(EdRemessa.Text);
                                     try
                                       Dm.SqlAux1.ExecSql;
                                       StBr.Panels[0].Text := '';
                                       EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                                       EdRemessa.Clear;
                                       EdRemessa.SetFocus;
                                     except on e: exception do
                                       begin
                                         application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                                         EdRemessa.Clear;
                                         EdRemessa.SetFocus;
                                         exit;
                                       end;
                                     end;
                                   End
                                 Else
                                   Begin
                                     ShowMessage('Produto já Enviado para Agência:  '+Dm.SqlAux1.Fields[0].Value);
                                     EdRemessa.Clear;
                                     EdRemessa.SetFocus;
                                   End;
                               End
                             Else
                               Begin
                                 application.MessageBox(PChar('Remessa não Cadastrada: '),'Ads',MB_OK+MB_ICONERROR);
                                 EdRemessa.Clear;
                                 EdRemessa.SetFocus;
                               End;
                           End;
                      End;
                    End;
                  9: // extrato drc
                    begin
                      if anterior <> EdRemessa.Text then
                          begin
                            anterior := EdRemessa.Text;
                            Testa:= Verifica(EdRemessa.Text);
                            //if (length(EdRemessa.Text)<> 17) and (Testa<>'erro') and (ChkDigita.Checked=True) and (GroupTipo.Visible=True) then
                            //  Testa:=VerificaValidade_Codigo(EdRemessa.Text);
                            if testa <> 'erro' then
                              begin
                                If (Length(EdRemessa.Text) = 17) Then
                                  Begin
                                    Dm.SqlAux1.Close;
                                    Dm.SqlAux1.Sql.Clear;
                                    Dm.SqlAux1.Sql.Add('select count(*) from cga120 where cg120_remes = :cg120_remes');
                                    Dm.SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                                    Dm.SqlAux1.Open;
        //                            total := Dm.SqlAux1.Fields[0].AsInteger;
                                    case Dm.SqlAux1.Fields[0].AsInteger of
                                      0:
                                        begin
                                          Dm.SqlAux1.Close;
                                          Dm.SqlAux1.Sql.Clear;
                                          Dm.SqlAux1.Sql.Add('insert into cga120 (');
                                          Dm.SqlAux1.Sql.Add('cg120_remes,cg120_dup,cg120_dtbaixa,cg120_codbaixa,');
                                          Dm.SqlAux1.Sql.Add('cg120_caixa,cg120_codusu)');
                                          Dm.SqlAux1.Sql.Add(' values ');
                                          Dm.SqlAux1.Sql.Add('(:cg120_remes,:cg120_dup,:cg120_dtbaixa,:cg120_codbaixa,');
                                          Dm.SqlAux1.Sql.Add(':cg120_caixa,:cg120_codusu)');
                                          Dm.SqlAux1.Params[0].Value := EdRemessa.Text;
                                          Dm.SqlAux1.Params[1].Value := total + 1;
                                          Dm.SqlAux1.Params[2].Value := formatdatetime('yyyy-mm-dd',date);
                                          Dm.SqlAux1.Params[3].Value := Dm.SqlCga20cg20_codbaixa.Value;
                                          Dm.SqlAux1.Params[4].Value := EdCaixa.Text;
                                          Dm.SqlAux1.Params[5].Value := Dm.sqlcga_acessocodigo.AsInteger;
                                          total:=total+1;
                                          try
                                            Dm.SqlAux1.ExecSql;
                                            StBr.Panels[0].Text := '';
                                            EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                                          except on e: exception do
                                            begin
                                              application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                                              EdRemessa.Clear;
                                              EdRemessa.SetFocus;
                                              exit;
                                            end;
                                        end;
                                      end
                                      else
                                        begin
                                          EdRemessa.Clear;
                                          EdRemessa.SetFocus;
                                          exit;
                                        end;
                                    end;
                                  end
                              else
                                Application.MessageBox('Esse código de remessa está fora de padrão. Procure o administrador do sistema e relate o erro.','Erro na leitura !',MB_OK+MB_ICONERROR);
                            end
                          else
                            Application.MessageBox('Esse código de remessa está fora de padrão. Procure o administrador do sistema e relate o erro.','Erro na leitura !',MB_OK+MB_ICONERROR);
                        end;
                        EdRemessa.Clear;
                        EdRemessa.SetFocus;
                    end;
                  10: // cartao segurança
                    begin
                      if anterior <> EdRemessa.Text then
                          begin
                            anterior := EdRemessa.Text;
                            //Testa:= Verifica(EdRemessa.Text);
                            //if (length(EdRemessa.Text)<> 17) and (Testa<>'erro') and (ChkDigita.Checked=True) and (GroupTipo.Visible=True) then
                            //  Testa:=VerificaValidade_Codigo(EdRemessa.Text);
                            if testa <> 'erro' then
                              begin
                                If (Length(EdRemessa.Text) = 11) Then
                                  Begin
                                    Dm.SqlAux1.Close;
                                    Dm.SqlAux1.Sql.Clear;
                                    Dm.SqlAux1.Sql.Add('select count(*) from cga130 where cg130_remes = :cg130_remes');
                                    Dm.SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                                    Dm.SqlAux1.Open;
        //                            total := Dm.SqlAux1.Fields[0].AsInteger;
                                    case Dm.SqlAux1.Fields[0].AsInteger of
                                      0:
                                        begin
                                          Dm.SqlAux1.Close;
                                          Dm.SqlAux1.Sql.Clear;
                                          Dm.SqlAux1.Sql.Add('insert into cga130 (');
                                          Dm.SqlAux1.Sql.Add('cg130_remes,cg130_dup,cg130_dtbaixa,cg130_codbaixa,');
                                          Dm.SqlAux1.Sql.Add('cg130_caixa,cg130_codusu)');
                                          Dm.SqlAux1.Sql.Add(' values ');
                                          Dm.SqlAux1.Sql.Add('(:cg130_remes,:cg130_dup,:cg130_dtbaixa,:cg130_codbaixa,');
                                          Dm.SqlAux1.Sql.Add(':cg130_caixa,:cg130_codusu)');
                                          Dm.SqlAux1.Params[0].Value := EdRemessa.Text;
                                          Dm.SqlAux1.Params[1].Value := total + 1;
                                          Dm.SqlAux1.Params[2].Value := formatdatetime('yyyy-mm-dd',date);
                                          Dm.SqlAux1.Params[3].Value := Dm.SqlCga20cg20_codbaixa.Value;
                                          Dm.SqlAux1.Params[4].Value := EdCaixa.Text;
                                          Dm.SqlAux1.Params[5].Value := Dm.sqlcga_acessocodigo.AsInteger;
                                          total:=total+1;
                                          try
                                            Dm.SqlAux1.ExecSql;
                                            StBr.Panels[0].Text := '';
                                            EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                                          except on e: exception do
                                            begin
                                              application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                                              EdRemessa.Clear;
                                              EdRemessa.SetFocus;
                                              exit;
                                            end;
                                        end;
                                      end
                                      else
                                        begin
                                          EdRemessa.Clear;
                                          EdRemessa.SetFocus;
                                          exit;
                                        end;
                                    end;
                                  end
                              else
                                Application.MessageBox('Esse código de remessa está fora de padrão. Procure o administrador do sistema e relate o erro.','Erro na leitura !',MB_OK+MB_ICONERROR);
                            end
                          else
                            Application.MessageBox('Esse código de remessa está fora de padrão. Procure o administrador do sistema e relate o erro.','Erro na leitura !',MB_OK+MB_ICONERROR);
                        end;
                        EdRemessa.Clear;
                        EdRemessa.SetFocus;
                    end;

                end;// fim do case para tipo de extrato
              end;
          end; //fim do case para baixa
        end;
      end
      end;
   end;
end;

procedure TFrmExtContaCorrentePoupanca.ChkDigitaClick(Sender: TObject);
begin
  EdRemessa.Clear;
  EdRemessa.EditMask:='99999999999-a;1;_';
  EdRemessa.CharCase:=ecUpperCase;
  EdRemessa.SetFocus;
end;

procedure TFrmExtContaCorrentePoupanca.ChkLeituraClick(Sender: TObject);
begin

  EdRemessa.Clear;
  EdRemessa.EditMask:='';
  EdRemessa.MaxLength:=22;
  EdRemessa.CharCase:=ecNormal;
  EdRemessa.SetFocus;
end;

procedure TFrmExtContaCorrentePoupanca.FormShow(Sender: TObject);
begin
  if Tag=3 then
      GroupTipo.Visible:=True
    else
      begin
        GroupTipo.Visible:=False;
      end;
  case tag of
    11: EdRemessa.SetFocus;
  end;
end;

procedure TFrmExtContaCorrentePoupanca.Edremessa2KeyPress(Sender: TObject;
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
              'Entregue-o ao Sr. Renado - CPD','Ads',MB_OK+MB_ICONERROR);
              EdRemessa.Clear;
              EdRemessa.SetFocus;
              exit;
            end;
          else
            begin
             if (anterior2 <> Trim(EdRemessa2.Text)) or (anterior <> Trim(EdRemessa.Text)) then
               begin
                 anterior2  := Trim(EdRemessa2.Text);
                 if (length(Trim(EdRemessa2.Text)) <> 34) or (length(Trim(EdRemessa.Text)) <> 24) then
                   begin
                     application.MessageBox('Numero de Remessa Incorreto!!!','Ads',MB_OK+MB_ICONERROR);
                     EdRemessa.Clear;
                     Edremessa2.Clear;
                     EdRemessa.SetFocus;
                     exit;
                   end;
                 if Verifica(EdRemessa2.Text) = 'erro' then
                   begin
                     application.MessageBox('Caracter inválido','Ads',MB_OK+MB_ICONERROR);
                     EdRemessa2.Clear;
                     EdRemessa2.SetFocus;
                     exit;
                   end
                 else
                   begin
                     Dm.SqlAux1.Close;
                     Dm.SqlAux1.Sql.Clear;
                     Dm.SqlAux1.Sql.Add('insert into cga69');
                     Dm.SqlAux1.Sql.Add('(cg69_remes1,cg69_remes2,cg69_codbaixa,');
                     Dm.SqlAux1.Sql.Add('cg69_caixa,cg69_codusu,cg69_dtbaixa) ');
                     Dm.SqlAux1.Sql.Add(' values ');
                     Dm.SqlAux1.Sql.Add('(:cg69_remes1,:cg69_remes2,:cg69_codbaixa,');
                     Dm.SqlAux1.Sql.Add(':cg69_caixa,:cg69_codusu,:cg69_dtbaixa) ' );
                     Dm.SqlAux1.Params[0].Value := EdRemessa.Text;
                     Dm.SqlAux1.Params[1].Value := EdRemessa2.Text;
                     Dm.SqlAux1.Params[2].Value := Dm.SqlCga20cg20_codbaixa.Value;
                     Dm.SqlAux1.Params[3].Value := EdCaixa.Text;
                     Dm.SqlAux1.Params[4].Value := Dm.sqlcga_acessocodigo.AsInteger;
                     Dm.SqlAux1.Params[5].Value := formatdatetime('yyyy-mm-dd',date);
                     try
                       Dm.SqlAux1.ExecSql;
                       StBr.Panels[0].Text := '';
                       EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                       EdRemessa.Clear;
                       Edremessa2.Clear;
                       EdRemessa.SetFocus;
                     except on e: exception do
                       begin
                         application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                         EdRemessa.Clear;
                         EdRemessa.SetFocus;
                         exit;
                       end;
                     end;
                     EdRemessa.Clear;
                     Edremessa2.Clear;
                     EdRemessa.SetFocus;
                   end;
               end
             else
               begin
                 StBr.Panels[0].Text := 'Anterior igual ao atual';
                 EdRemessa.Clear;
                 EdRemessa.SetFocus;
                 exit;
               end;
            end;
        end;    
       end;
  end;
end;

procedure TFrmExtContaCorrentePoupanca.FormCreate(Sender: TObject);
begin
  anterior := '';
  anterior2 := '';
end;

procedure TFrmExtContaCorrentePoupanca.Edremessa2Exit(Sender: TObject);
begin
  If EdRemessa2.Tag = 5 Then
    Begin
      EdQt.Text := '0';
    End;
end;

end.
