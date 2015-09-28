unit U_FrmDigExtratoUnificado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ExtCtrls, DBCtrls, ComCtrls;

type
  TFrmDigExtratoUnificado = class(TForm)
    StBr: TStatusBar;
    ScrollBox1: TScrollBox;
    DbLkBaixa: TDBLookupComboBox;
    Panel2: TPanel;
    EdCaixa: TEdit;
    Panel1: TPanel;
    MskAgencia: TMaskEdit;
    Panel3: TPanel;
    Panel4: TPanel;
    BtnFechar: TBitBtn;
    Panel7: TPanel;
    EdQt: TEdit;
    MskContaCorrente: TEdit;
    Label1: TLabel;
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdControleKeyPress(Sender: TObject; var Key: Char);
    procedure MskAgenciaExit(Sender: TObject);
    procedure MskContaCorrenteExit(Sender: TObject);

    procedure InserirExtrato;
    procedure LimpaCampos;
    function FormataControle(numero: String):String;
    function FormataNumero(numero: String; quantidade: Integer): String;
    procedure MskContaCorrenteKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    NumRemessa  : String;
  public
    { Public declarations }
  end;

var
  FrmDigExtratoUnificado: TFrmDigExtratoUnificado;

implementation

uses DmDados, U_Func, Math;

{$R *.dfm}

procedure TFrmDigExtratoUnificado.BtnFecharClick(Sender: TObject);
begin
  Close();
end;

procedure TFrmDigExtratoUnificado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action                        := CaFree;
  FrmDigExtratoUnificado        := Nil;
end;

procedure TFrmDigExtratoUnificado.InserirExtrato;
var
  anterior        : String;
  calculado       : Integer;
  numero          : Integer;
  digito          : Integer;
  total           : Integer;
  conta_corrente  : String;
  digito_corrente : Boolean;
begin

  case dm.SqlCga20cg20_codbaixa.AsInteger of
    100,109,112,117,118 :
      begin
        application.MessageBox('Código de Baixa Inválido'+#10+
        'Favor Recolher o Movimento e'+#10+
        'Entregue-o ao Sr. Renado - CPD','Ads',MB_OK+MB_ICONERROR);
        LimpaCampos;
        exit;
      end;
    else
      begin
        conta_corrente  := FormataNumero(Trim(MskContaCorrente.Text),8);
        NumRemessa      := Trim(MskAgencia.Text)+conta_corrente+'13022005'+'030000'+'0000000';
        //Application.MessageBox(PChar(NumRemessa),'seila',MB_OK);
        if (anterior <> NumRemessa) then
          begin
            anterior  := NumRemessa;
            if Verifica(NumRemessa) = 'erro' then
              begin
               application.MessageBox('Caracter inválido','Ads',MB_OK+MB_ICONERROR);
               LimpaCampos;
               exit;
              end;
           case length(NumRemessa) of
             30,34:
               begin
                 calculado := StrToInt(VerificaDigito11(Copy(NumRemessa,6,7)));
                 numero    := StrToInt(Copy(NumRemessa,6,7));

                 if (Copy(NumRemessa,13,1) = 'P') then
                    begin
                      if (VerificaDigito11(Copy(NumRemessa,6,7)) = '0') then
                        digito_corrente := true
                      else
                        digito_corrente := false;
                    end
                 else
                    begin
                      if ((Copy(NumRemessa,13,1)) = ((VerificaDigito11(Copy(NumRemessa,6,7))))) then
                        digito_corrente := true
                      else
                        digito_corrente := false;
                    end;



                 //showmessage('Numero: '+IntToStr(numero)+' - '+IntToStr(digito)+' ||Calculado: '+IntToStr(calculado));
                 if (((Copy(NumRemessa,5,1)) <> ((VerificaDigito11(copy(NumRemessa,1,4))))) or (digito_corrente = false)) then
                   begin
                     MessageDlg('Código de Agência ou Conta Inválido',mtwarning,[mbok],0);
                     LimpaCampos;
                   end
                 else
                   begin
                     Dm.SqlAux1.Close;
                     Dm.SqlAux1.Sql.Clear;
                     Dm.SqlAux1.Sql.Add('select count(*) from cga68 where cg68_remes = :cg68_remes');
                     Dm.SqlAux1.Params[0].AsString := NumRemessa;
                     Dm.SqlAux1.Open;
                     total := 0;
                    total := Dm.SqlAux1.Fields[0].AsInteger;
                    case Dm.SqlAux1.Fields[0].AsInteger of
                      3:
                        begin
                          StBr.Panels[0].Text := 'Numero de remessas excedidas';
                          LimpaCampos;
                          exit; // remessas excedidas
                        end;
                    else
                      begin
                        Dm.SqlAux1.Close;
                        Dm.SqlAux1.Sql.Clear;
                        Dm.SqlAux1.Sql.Add('insert into cga68');
                        Dm.SqlAux1.Sql.Add('(cg68_remes,cg68_dup,cg68_dtext,cg68_codbaixa,');
                        Dm.SqlAux1.Sql.Add('cg68_caixa,cg68_codusu,cg68_codag,cg68_tipo,cg68_dtbaixa,cg68_digit) ');
                        Dm.SqlAux1.Sql.Add(' values ');
                        Dm.SqlAux1.Sql.Add('(:cg68_remes,:cg68_dup,:cg68_dtext,:cg68_codbaixa,');
                        Dm.SqlAux1.Sql.Add(':cg68_caixa,:cg68_codusu,:cg68_codag,:cg68_tipo,:cg68_dtbaixa,True) ');
                        Dm.SqlAux1.Params[0].Value := NumRemessa;
                        Dm.SqlAux1.Params[1].Value := total + 1;
                        Dm.SqlAux1.Params[2].Value := Copy(NumRemessa,18,4)+'-'+Copy(NumRemessa,16,2)+'-'+Copy(NumRemessa,14,2);
                        //Dm.SqlAux1.Params[2].Value := Copy(EdRemessa.Text,21,4)+'-'+Copy(EdRemessa.Text,19,2)+'-'+Copy(EdRemessa.Text,17,2);
                        Dm.SqlAux1.Params[3].Value := Dm.SqlCga20cg20_codbaixa.Value;
                        Dm.SqlAux1.Params[4].Value := EdCaixa.Text;
                        Dm.SqlAux1.Params[5].Value := Dm.sqlcga_acessocodigo.AsInteger;
                        Dm.SqlAux1.Params[6].Value := Copy(NumRemessa,1,5);
                        Dm.SqlAux1.Params[7].Value := copy(NumRemessa,22,2);
                        Dm.SqlAux1.Params[8].Value := formatdatetime('yyyy-mm-dd',date);
                        try
                          Dm.SqlAux1.ExecSql;
                          StBr.Panels[0].Text := '';
                          EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                          LimpaCampos;
                        except on e: exception do
                          begin
                            application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                            LimpaCampos;
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
               LimpaCampos;
             end;
           end;
          end
        else
          begin
            StBr.Panels[0].Text := 'Anterior igual ao atual';
            LimpaCampos;
          end;
      end;
  end;
end;

procedure TFrmDigExtratoUnificado.LimpaCampos;
begin
  MskAgencia.Clear;
  MskContaCorrente.Clear;
  MskAgencia.SetFocus;
end;

procedure TFrmDigExtratoUnificado.EdControleKeyPress(Sender: TObject;
  var Key: Char);
begin
  case key of
    #13:
      begin
        InserirExtrato;
      end;
  end;
end;





procedure TFrmDigExtratoUnificado.MskAgenciaExit(Sender: TObject);
begin
  if (Trim(MskAgencia.Text) <> '') then
    begin
      if ((Copy(MskAgencia.Text,5,1)) <> ((VerificaDigito11(copy(MskAgencia.Text,1,4))))) then
        begin
          Application.MessageBox('Erro: Número da agência não coincide com o digito verificador.','Ads',MB_OK+MB_ICONERROR);
        end;
    end;
end;

procedure TFrmDigExtratoUnificado.MskContaCorrenteExit(
  Sender: TObject);
begin

  if (Trim(MskContaCorrente.Text) <> '') then
    begin
      if ((Copy(trim(MskContaCorrente.Text),Length(MskContaCorrente.Text),1))) <> ((VerificaDigito11(Copy(trim(MskContaCorrente.Text),1,Length(MskContaCorrente.Text)-1)))) then
        begin
          Application.MessageBox('Erro: Número da conta corrente não coincide com o digito verificador.','Ads',MB_OK+MB_ICONERROR);
        end;
    end;
end;

function TFrmDigExtratoUnificado.FormataControle(numero: String): String;
var
  retorno        : String;
  cont,num_falta : Integer;
begin
  retorno     := '';
  num_falta   := 7 - Length(numero);
  if (num_falta < 1) then
      begin
        Result  := Trim(numero);
      end
    else
      begin
        for cont := 1 to num_falta do
          begin
            retorno := retorno+'0';
          end;

        for cont := 1 to Length(Trim(numero)) do
          begin
            retorno := retorno+copy(numero,cont,1);
          end;

        Result  := retorno;
      end;
end;

function TFrmDigExtratoUnificado.FormataNumero(numero: String;
  quantidade: Integer): String;
var
  cont          : Integer;
  string_saida  : String;
begin
  string_saida  := '';
  for cont := 1 to quantidade do
    begin
      if (cont > length(numero)) then
          begin
            string_saida  := '0'+string_saida;
          end
        else
          begin
            string_saida  := string_saida+copy(numero,cont,1);
          end;
    end;
  Result := string_saida;
end;

procedure TFrmDigExtratoUnificado.MskContaCorrenteKeyPress(Sender: TObject;
  var Key: Char);
begin
  case key of
    #13:
      begin
        InserirExtrato;
      end;
  end;
end;

end.
