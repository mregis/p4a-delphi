unit FrmExtContaCorrentePopanca;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
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
    CboBoxTipoBxa: TComboBox;
    Ednumlote: TEdit;
    Panel6: TPanel;
    Panel7: TPanel;
    Edresto: TEdit;
    CheckBox1: TCheckBox;
    BtnFechaCxa: TBitBtn;
    BtnRecCxa: TBitBtn;
    procedure Edremessa2Exit(Sender: TObject);
    procedure BtnRecCxaClick(Sender: TObject);
    procedure BtnFechaCxaClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdRemessaKeyPress(Sender: TObject; var Key: Char);
    procedure proccadetica;
    procedure procpressecr;
    procedure procentrtoken(tipo:  Integer);
    procedure procsaitoken;
    procedure proccodetica;
    procedure procbaixas;
    procedure procbxactacorpoup;
    procedure procextraunificado;// extrato unificado
    procedure procextratocartao;
    procedure procextratodrc;
    procedure procextratocvm;
    procedure procextratobcopostal;
    procedure procdrccrtconv;
    procedure proccartaoseg;
    procedure proccartaocred;
    procedure proccllpdrc;
    procedure ChkDigitaClick(Sender: TObject);
    procedure ChkLeituraClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edremessa2KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure CboBoxTipoBxaClick(Sender: TObject);
    procedure EdnumloteKeyPress(Sender: TObject; var Key: Char);
    procedure gravatoken;
    procedure finalagencia;
    procedure vertoken;
    procedure gravainitoken;
    procedure CheckBox1Click(Sender: TObject);
    procedure contatoken;
    procedure gerreltokenlido;
	  procedure proccrtsenha;
    procedure procconsorcio;
    procedure novolote;
    procedure procreg;
    procedure proccadtoken;
    procedure procpfe001; // Extrato Finasa PFE - 001
    procedure procbolcli; // Boleto Finasa CLI
    procedure proccrtfin; // Carta Finasa Cli
    procedure procdrcprv; // DRC - Private Label
    procedure procdrcs;
    procedure drccrtfatu; // DRC - Cartao Fatura
    procedure drczogmcsi;
    procedure drccrtamex;
    private
    testa,anterior,anterior2,dtb,data               : string;
    qtde,qtdaux,calculado,digito,total,numero       : integer;
    proxretorno                                     : variant;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExtContaCorrentePoupanca: TFrmExtContaCorrentePoupanca;

implementation

uses U_Func, DB, ZDataset, ZAbstractRODataset, DmDados, UFrmFrTokenLido,
  U_Principal;

{$R *.dfm}

procedure TFrmExtContaCorrentePoupanca.BtnFechaCxaClick(Sender: TObject);
begin
  with dm do
    begin
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('select count(cg76_caixa) from cga76 where (cg76_caixa = :caixa)');
      SqlAux2.Params[0].Value :=  strtoint64(EdCaixa.Text);
      SqlAux2.Open;
      if (SqlAux2.Fields[0].Value > 0) and (SqlAux2.Fields[0].Value < 100) then
        begin
          Application.MessageBox(PChar('Aten��o Caixa Qtde Menor 100'+#10+'Favor Verificar com a Listagem'),'ADS',0);
          gerreltokenlido;
        end
      else if (SqlAux2.Fields[0].Value = 100) then
        begin
          Application.MessageBox(PChar('Caixa Fechada : '+EdCaixa.Text),'ADS',0);
          EdCaixa.Text := formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmssn',time);
          EdQt.Text :=  '0';
          EdRemessa.SetFocus;
        end
      else if (SqlAux2.Fields[0].Value > 100) then
        begin
          StBr.Panels[0].Text :=  'Caixa Qtde > 100. Inicie Outra ';
          gerreltokenlido;
          ScrollBox1.SetFocus;
        end
      else
        begin
          StBr.Panels[0].Text :=  'Est� Faltando Token � ser Lido, Informe o Supervisor ';
          gerreltokenlido;
          ScrollBox1.SetFocus;
        end

    end;
end;
procedure TFrmExtContaCorrentePoupanca.gerreltokenlido;
begin
  with dm do
    begin
      ZROQTokenLido.Close;
      ZROQTokenLido.SQL.Clear;
      ZROQTokenLido.SQL.Add('select cg76_remes as "Token",cg76_caixa as "Caixa",cg76_dtentr as "Lido", cg76_ag as "Ag�ncia",cg76_dtb as "DTB",cg76_dtsai as "Data",');
      ZROQTokenLido.SQL.Add('cg76_numlote as "Lote", cga_acesso.nome  as "Usu�rio" from cga76 ');
      ZROQTokenLido.SQL.Add('full join cga_acesso on cga76.cg76_codusu_dig = cga_acesso.codigo ');
      ZROQTokenLido.SQL.Add('where (cg76_caixa = :caixa) order by substr(cg76_remes,1,9)');
      ZROQTokenLido.Params[0].Value :=  strtoint64(EdCaixa.Text);
      ZROQTokenLido.Open;
      Application.CreateForm(TFrmRlTokenLidos,FrmRlTokenLidos);
      FrmRlTokenLidos.RLReport1.PreviewModal;
      FrmRlTokenLidos.RLReport1.Destroy;
    end;
end;

procedure TFrmExtContaCorrentePoupanca.BtnFecharClick(Sender: TObject);
begin
//  showmessage( '2558-5 =original /  calculado='+ (VerificaDigito11(2558));
case tag of
  7: contatoken;
else;
  close;
end;
end;
procedure TFrmExtContaCorrentePoupanca.BtnRecCxaClick(Sender: TObject);
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add('select distinct(cg76_caixa) from cga76 ');
      SqlAux1.SQL.Add('WHERE cg76_codusu_dig = :dig AND substr(cg76_remes, 1, LENGTH(cg76_remes) -1) = :token');
      SqlAux1.ParamByName('dig').AsInteger := sqlcga_acessocodigo.AsInteger;
      SqlAux1.ParamByName('token').AsString :=  Copy(EdRemessa.Text, 1, Length(EdRemessa.Text) -1);
      SqlAux1.Open;
      case SqlAux1.RecordCount of
        0: Application.MessageBox('N�o h� Registros','ADS',0);
        else
          begin
            if (Application.MessageBox('Deseja Recuperar a Caixa','ADS',mb_YesNo) = ID_Yes) then
              begin
                EdCaixa.Text  :=  SqlAux1.Fields[0].AsString;
                SqlAux1.Close;
                SqlAux1.SQL.Clear;
                SqlAux1.SQL.Add('select count(cg76_remes) from cga76 where (cg76_codusu_dig = :dig) and (cg76_caixa = :cxa)');
                SqlAux1.Params[0].Value  :=  sqlcga_acessocodigo.AsInteger;
                SqlAux1.Params[1].Value  :=  EdCaixa.Text;
                SqlAux1.Open;
                if (SqlAux1.Fields[0].Value < 100) then
                  EdQt.Text :=  SqlAux1.Fields[0].AsString
                else
                  Application.MessageBox(PChar('Caixa: '+EdCaixa.Text+' Fechada'),'ADS',0);
              end;
          end;
      end;
    end;
end;
procedure TFrmExtContaCorrentePoupanca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmExtContaCorrentePoupanca := nil;
  action := cafree;
end;

procedure TFrmExtContaCorrentePoupanca.EdRemessaKeyPress(Sender: TObject;
  var Key: Char);
begin
      case key of
        #13:
           begin
             case tag of
               11: proccadetica;// cadastro codigo de etica - cga140
               12: procpressecr;// Presente Secretaria Bradesco - cga145
                7: procentrtoken(0);// Entrada de Token - cga76
                8: procsaitoken;// Saida  de Token - cga76
               13: proccodetica;// baixa codigo de etica - cga140
               52: proccadtoken;// Cadastro e Entrada de Token
               else
                   procbaixas; // baixas de extratos
             end;
           end;
      end;
end;
procedure TFrmExtContaCorrentePoupanca.proccadetica;
begin
  with dm do
    begin
      if anterior <> EdRemessa.Text then
        begin
          anterior := EdRemessa.Text;
          if testa <> 'erro' then
            begin
              If (Length(trim(EdRemessa.Text)) = 20) Then
                Begin
                  Dm.SqlAux1.Close;
                  Dm.SqlAux1.Sql.Clear;
                  Dm.SqlAux1.Sql.Add('select count(*) from cga140 where cg140_remes = :cg140_remes');
                  Dm.SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                  Dm.SqlAux1.Open;
                  case Dm.SqlAux1.Fields[0].AsInteger of
                    0:
                      begin
                        Dm.SqlAux1.Close;
                        Dm.SqlAux1.Sql.Clear;
                        Dm.SqlAux1.Sql.Add('insert into cga140 (');
                        Dm.SqlAux1.Sql.Add('cg140_remes,cg140_dup,cg140_codag,cg140_dtcad,cg140_caixa,cg140_codusu)');
                        Dm.SqlAux1.Sql.Add(' values (');
                        Dm.SqlAux1.Sql.Add(':cg140_remes,:cg140_dup,:cg140_codag,(select current_date),:cg140_caixa,:cg140_codusu)');
                        Dm.SqlAux1.Params[0].Value := trim(EdRemessa.Text);
                        Dm.SqlAux1.Params[1].Value := total + 1;
                        Dm.SqlAux1.Params[2].Value := copy(EdRemessa.Text,5,4);
                        Dm.SqlAux1.Params[3].Value := trim(EdCaixa.Text);
                        Dm.SqlAux1.Params[4].Value := Dm.sqlcga_acessocodigo.AsInteger;
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
                      end;
                  end;
                end
                else
                  begin
                    EdRemessa.Clear;
                    EdRemessa.SetFocus;
                    exit;
                  end;
            end
          else
          Application.MessageBox('Esse c�digo de remessa est� fora de padr�o.'+chr(10)+'Procure o administrador do sistema e relate o erro.','Erro na leitura !',MB_OK+MB_ICONERROR);
        end
      else
      Application.MessageBox('Esse c�digo de remessa est� fora de padr�o.'+chr(10)+'Procure o administrador do sistema e relate o erro.','Erro na leitura !',MB_OK+MB_ICONERROR);
    end;
    EdRemessa.Clear;
    EdRemessa.SetFocus;

end;
procedure TFrmExtContaCorrentePoupanca.procpressecr;
begin
  with dm do
    begin
      if anterior <> EdRemessa.Text then
          begin
            anterior := EdRemessa.Text;
            if testa <> 'erro' then
              begin
                If (Length(trim(EdRemessa.Text)) = 5) Then
                  Begin
                    Dm.SqlAux1.Close;
                    Dm.SqlAux1.Sql.Clear;
                    Dm.SqlAux1.Sql.Add('select count(cg145_remes) from cga145 where cg145_remes = :cg145_remes');
                    Dm.SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                    Dm.SqlAux1.Open;
                    case Dm.SqlAux1.Fields[0].AsInteger of
                      1:
                        begin
                          Dm.SqlAux1.Close;
                          Dm.SqlAux1.Sql.Clear;
                          Dm.SqlAux1.Sql.Add('update cga145 set cg145_dtsai = (select current_date),cg145_codususai = :codusu where cg145_remes = :remes');
                          Dm.SqlAux1.Params[0].Value := Dm.sqlcga_acessocodigo.AsInteger;
                          Dm.SqlAux1.Params[1].Value := trim(EdRemessa.Text);
                          total:=total+1;
                          try
                            Dm.SqlAux1.ExecSql;
                            StBr.Panels[0].Text := '';
                            EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                          except on e: exception do
                            begin
                              Application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
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
                Application.MessageBox('Esse c�digo de remessa est� fora de padr�o.'+chr(10)+'Procure o administrador do sistema e relate o erro.','Erro na leitura !',MB_OK+MB_ICONERROR);
            end
          else
            Application.MessageBox('Esse c�digo de remessa est� fora de padr�o.'+chr(10)+'Procure o administrador do sistema e relate o erro.','Erro na leitura !',MB_OK+MB_ICONERROR);
        end;
    EdRemessa.Clear;
    EdRemessa.SetFocus;
    end;
end; //fim case 12

procedure TFrmExtContaCorrentePoupanca.procentrtoken(tipo:  Integer);
var codtkn : String;
begin
  with dm do
    begin
    StBr.Panels[0].Text := '';
      if anterior <> Trim(EdRemessa.Text) then
        begin
          anterior  := Trim(EdRemessa.Text);
          EdRemessa.Text:=remcaract(Trim(EdRemessa.Text));
          if Verifica(Trim(EdRemessa.Text)) = 'erro' then
            begin
              StBr.Panels[0].Text := 'N�mero de Token Incorreto';
              EdRemessa.Clear;
              //EdRemessa.SetFocus;
              //StBr.Panels.Items[0].Style;
              ScrollBox1.SetFocus;
              exit;
            end;
          case length(trim(EdRemessa.Text)) of
            10:
              begin
                SqlAux1.Close;
                SqlAux1.Sql.Clear;
                SqlAux1.Sql.Add('SELECT cg76_remes FROM cga76 ');
                SqlAux1.Sql.Add('WHERE SUBSTR(cg76_remes, 1, LENGTH(cg76_remes) - 1) = :remes');
                SqlAux1.Sql.Add('     AND cg76_dtentr IS NOT NULL');
                SqlAux1.ParamByName('cg76_remes').AsString := Copy(EdRemessa.Text, 1, Length(EdRemessa.Text) - 1);
                SqlAux1.Open;
                case SqlAux1.RecordCount of
                  0:
                    begin
                      codtkn := SqlAux1.FieldByName('cg76_remes').AsString;
                      SqlAux1.Close;
                      SqlAux1.Sql.Clear;
                      //                                                0                         1                         2                              3
                      SqlAux1.Sql.Add('UPDATE cga76 SET cg76_remes = :cg76_remes, cg76_dtentr = CURRENT_DATE, cg76_caixa = :cg76_caixa, cg76_codusu_dig = :codusu, ');
                      SqlAux1.Sql.Add('cg76_codentr = :codentr WHERE cg76_remes = :remes AND cg76_dtentr IS NULL AND cg76_codbaixa IS NULL AND cg76_dtsai IS NULL ');
                      SqlAux1.Sql.Add('AND cg76_ag IS NULL AND cg76_dtb IS NULL AND cg76_numlote IS NULL AND cg76_codusu_dig IS NULL ');
                      SqlAux1.ParamByname('cg76_remes').AsString := codtkn;
                      SqlAux1.ParamByName('cg76_caixa').AsInteger := StrToInt64(trim(EdCaixa.Text));
                      SqlAux1.ParamByName('codusu').AsInteger := sqlcga_acessocodigo.AsInteger;
                      SqlAux1.ParamByName('codentr').AsString := SqlCga20cg20_codbaixa.AsString;
                      SqlAux1.ParamByName('remes').AsString := Copy(EdRemessa.Text, 1, Length(EdRemessa.Text) - 1);
                      try
                        SqlAux1.ExecSql;
                        StBr.Panels[0].Text := '';
                        if SqlAux1.RowsAffected > 0 then
                          begin
                            case tipo of
                              0:
                                begin
                                  EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                                  EdQt.Refresh;
                                  EdRemessa.Clear;
                                  EdRemessa.SetFocus;
                                end;
                            end;
                          end
                        else
                          begin
                            showmessage('Erro. Separe o Token e Comunique o CPD');
                            ScrollBox1.SetFocus;
                            Exit;
                          end;
                      except on e: exception do
                        begin
                          Application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                          ScrollBox1.SetFocus;
                          exit;
                        end;
                      end;
                    end;
                  else
                    begin
                      Application.MessageBox(PChar('Token j� Lido: '+EdRemessa.Text),'Ads',MB_OK+MB_ICONERROR);
                      ScrollBox1.SetFocus;
                      exit;
                    end;
                end;
            end;
          else
            begin
              StBr.Panels[0].Text := 'N�mero de Token Incorreta';
              ScrollBox1.SetFocus;
            end;
          end;
        end
      else
        begin
          StBr.Panels[0].Text := 'Anterior Igual ao Atual';
          ScrollBox1.SetFocus;
        end;
    end;
end;//fim case 7
procedure TFrmExtContaCorrentePoupanca.procsaitoken;
Begin
StBr.Panels[0].Text :=  '';
  with dm do
    begin
      EdRemessa.Text  :=  RemCaract(Trim(EdRemessa.Text));
      case length(Trim(EdRemessa.Text)) of
        10:
          Begin
            SqlAux1.Close;
            SqlAux1.Sql.Clear;
            SqlAux1.Sql.Add('SELECT COUNT(cg77_dtb) as qt ');
            SqlAux1.Sql.Add('FROM cga77 ');
            SqlAux1.Sql.Add('WHERE cg77_dtb = :grm AND cg77_numlote = :numlote ');
            SqlAux1.Sql.Add('    AND cg77_ag IN (:ag, :ag2) ');
            SqlAux1.Sql.Add('    AND cg77_status = :status');
            SqlAux1.ParamByName('grm').AsString := Trim(dtb);
            SqlAux1.ParamByName('numlote').AsString := LPad(trim(Ednumlote.Text), 6, '0');
            SqlAux1.ParamByName('ag').AsString := LPad(trim(Edremessa2.Text), 4, '0');
            SqlAux1.ParamByName('ag2').AsString := IntToStr(StrToInt(trim(Edremessa2.Text)));
            SqlAux1.ParamByName('status').AsString := '0';
            SqlAux1.Open;
            case SqlAux1.FieldByName('qt').AsInteger of
              0:
                begin
                  Application.MessageBox(Pchar('Ag�ncia ' + Edremessa2.Text +
                        'J� Est� Fechada'), 'ADS', MB_OK + MB_ICONERROR);
                  exit;
                end;
              1: vertoken;
              else
                begin
                  application.MessageBox(PChar('H� mais de uma DTB para esse lote e Ag�ncia'+#10+
                  'Separe o Lote e Ag�ncia, chame o Supervisor!'),'Ads',MB_OK+MB_ICONERROR);
                  EdRemessa.Clear;
                  EdRemessa.SetFocus;
                  exit;
                end;
            end;
          end;
        else
          begin
            if  ChkLeitura.Checked = false then
              begin
                application.MessageBox(PChar('Token j� lido'+#10+
                'Separe o Lote e Ag�ncia, chame o Supervisor!'),'Ads',MB_OK+MB_ICONERROR);
                EdRemessa.Clear;
                EdRemessa.SetFocus;
                exit;
              end
            else if Length(Trim(EdRemessa.Text)) < 10 then
              begin
              StBr.Panels[0].Text := 'Token Incompleto: '+EdRemessa.Text;
              StBr.SetFocus;
              end
            else
              vertoken;
          end;
      End;
    end;
End;//fim case 8
procedure TFrmExtContaCorrentePoupanca.proccodetica;
begin
  with dm do
    begin
      case CboBoxTipoBxa.ItemIndex of
        -1:
          begin
            Application.MessageBox('Necess�rio escolher c�digo de baixa.','leitura baixa!',MB_OK+MB_ICONERROR);
            CboBoxTipoBxa.SetFocus;
          end;
        else
          begin
            case (length(trim(EdRemessa.Text))) of
              20:
                begin
                  Dm.SqlAux1.Close;
                  Dm.SqlAux1.Sql.Clear;
                  Dm.SqlAux1.Sql.Add('select count(cg140_remes) from cga140 where (cg140_remes = :cg140_remes) and (cg140_dtbxa is null)');
                  Dm.SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                  Dm.SqlAux1.Open;
                  case Dm.SqlAux1.Fields[0].AsInteger of
                    1:
                      begin
                        Dm.SqlAux1.Close;
                        Dm.SqlAux1.Sql.Clear;
                        Dm.SqlAux1.Sql.Add('update cga140 set');
                        Dm.SqlAux1.Sql.Add('cg140_dtbxa=:dtbxa,cg140_codbxa=:codbxa,cg140_usubxa=:usubxa ');
                        Dm.SqlAux1.Sql.Add('where (trim(cg140_remes)=:remes)');
                        Dm.SqlAux1.Params[0].Value := formatdatetime('yyyy-mm-dd',date);
                        case CboBoxTipoBxa.ItemIndex of
                        0:Dm.SqlAux1.Params[1].Value := '01'; // desligado
                        1:Dm.SqlAux1.Params[1].Value := '02'; // afastado
                        2:Dm.SqlAux1.Params[1].Value := '03'; // ferias
                        3:Dm.SqlAux1.Params[1].Value := '04'; // outros
                        4:Dm.SqlAux1.Params[1].Value := '05'; // tranferido para outras dep
                        5:Dm.SqlAux1.Params[1].Value := '06'; // dep receb func transf
                        6:Dm.SqlAux1.Params[1].Value := '07'; // Func. Recem Admitidos
                        7:Dm.SqlAux1.Params[1].Value := '08'; // Entregue
                        //8:Dm.SqlAux1.Params[1].Value := '09'; // outros
                        end;
                          Dm.SqlAux1.Params[2].Value := Dm.sqlcga_acessocodigo.AsInteger;
                          Dm.SqlAux1.Params[3].Value := trim(EdRemessa.Text);
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
                      end;
                    0:
                      begin
                        application.MessageBox(PChar('J� Baixado: '+chr(10)+
                        'Favor Recolher a remessa e devolver ao Sr Renato!'),'Ads',MB_OK+MB_ICONERROR);
                        EdRemessa.Clear;
                        EdRemessa.SetFocus;
                        exit;
                      end;
                    else
                      begin
                        application.MessageBox(PChar('Ocorreu um erro fatal: '+chr(10)+
                        'Favor Recolher a remessa e devolver ao Sr Renato!'),'Ads',MB_OK+MB_ICONERROR);
                        EdRemessa.Clear;
                        EdRemessa.SetFocus;
                        exit;
                      end;
                  end;
                end;
              else
                Application.MessageBox('Esse c�digo de remessa est� fora de padr�o.'+chr(10)+'Procure o administrador do sistema e relate o erro.','Erro na leitura !',MB_OK+MB_ICONERROR);
            end;
          end;
      end;
      EdRemessa.Clear;
      EdRemessa.SetFocus;
    end;
end;//fim case 13
procedure TFrmExtContaCorrentePoupanca.procbaixas;
begin
  case dm.SqlCga20cg20_codbaixa.AsInteger of
    100,109,112,117,118 :
      begin
        application.MessageBox('C�digo de Baixa Inv�lido'+#10+
        'Favor Recolher o Movimento e'+#10+
        'Entregue-o ao Sr. Supervisor ou TI','Ads',MB_OK+MB_ICONERROR);
        EdRemessa.Clear;
        EdRemessa.SetFocus;
        exit;
      end;
    else
      begin
        case tag of
          1 : procbxactacorpoup;          // Extrato conta corrente poupan�a  cga33
          2 : procextraunificado;         // Extrato unificado  cga68
          3 : procextratodrc;             // Extrato drc Cobran�a - cga100 - agencia que comecem com 412 e 42  tipo = 3 da tabela cga037
          4 : procextratocartao;          // Extrato cartao  - cga67
          5 : procextratocvm;             // Extrato CVM - cga69
          6 : procextratobcopostal;       // Eextrato Banco Postal - cga70
          9 : procdrccrtconv;             // DRC Carta Convite - cga120
          10: proccartaoseg;              // Cartao seguran�a tan_code - cga130
          14: proccrtsenha;               // Carta senha consorcio - cga035
          15: procconsorcio;              // Extrato recibo consorciado - cga036
		      50: proccartaocred;             // Fatura Cart�o de Cr�dito - cgafatcrtcrd
          51: proccllpdrc;                // Drc Aviso de Cobran�a  - cga78 - CLLP
          53: procpfe001;                 // Extrato Finasa PFE - cga038 001
          54: procbolcli;                 // Boleto Finasa CLI - cga039   - agencia que comecem com 417 tipo = 17 da tabela cga037
          55: proccrtfin;                 // Carta Aviso Finasa - cga040
          56: procdrcprv;                 // Extrato DRC - Private Label cga041  agencia que comecem com 402 tipo = 18 da tabela cga037
          57: procdrcs;                   // Extrato DRC - Private Label - Boleto - Finasa CLI - DRC Cobranca
        end;
      end;
  end;
end;

procedure TFrmExtContaCorrentePoupanca.procbxactacorpoup;
begin
  with dm do
    begin
      if anterior <> Trim(EdRemessa.Text) then
        begin
          anterior  := Trim(EdRemessa.Text);
          if Verifica(EdRemessa.Text) = 'erro' then
            begin
              application.MessageBox('Caracter inv�lido','Ads',MB_OK+MB_ICONERROR);
              EdRemessa.Clear;
              EdRemessa.SetFocus;
              exit;
            end;
            case length(trim(EdRemessa.Text)) of
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
                        0: proxretorno := null;
                        else
                          proxretorno := '01-01-1950';
                      end;
                    end
                  else
                    begin
                      if (strtoint(DifDias(date,Dm.SqlAux1.Fields[0].Value))) >= 30 then
                        proxretorno := null
                      else
                        proxretorno := '01-01-1950';
                    end;
                  Dm.SqlAux1.Close;
                  Dm.SqlAux1.Sql.Clear;
                  Dm.SqlAux1.Sql.Add('insert into cga33 ');
                  Dm.SqlAux1.Sql.Add('(cg33_caixa,cg33_codbaixa,cg33_codusu,cg33_dtret,cg33_dtbaixa,cg33_dtext,cg33_dup,cg33_remes)');
                  Dm.SqlAux1.Sql.Add(' values');
                  Dm.SqlAux1.Sql.Add('(:cg33_caixa,:cg33_codbaixa,:cg33_codusu,:cg33_dtret,(select current_date),:cg33_dtext,:cg33_dup,:cg33_remes)');
                  Dm.SqlAux1.Params[0].Value := Trim(EdCaixa.Text);
                  Dm.SqlAux1.Params[1].Value := Dm.SqlCga20cg20_codbaixa.Value;
                  Dm.SqlAux1.Params[2].Value := Dm.sqlcga_acessocodigo.Value;
                  Dm.SqlAux1.Params[3].Value := proxretorno;
                  Dm.SqlAux1.Params[4].Value := (Copy(EdRemessa.Text,19,4)+'-'+Copy(EdRemessa.Text,17,2)+'-'+Copy(EdRemessa.Text,15,2));
                  Dm.SqlAux1.Params[5].Value := 1;
                  Dm.SqlAux1.Params[6].Value := COPY(EdRemessa.Text,1,14);
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
                end;
              else
                StBr.Panels[0].Text := 'N�mero de remessa Incorreta';
            end;
        end
      else
        begin
          StBr.Panels[0].Text := 'Anterior igual ao atual';
        end;
    end;
    EdRemessa.Clear;
    EdRemessa.SetFocus;
end;//fim case bxactacorpoup
procedure TFrmExtContaCorrentePoupanca.procextraunificado;// extrato unificado
begin
StBr.Panels[0].Text :=  '';
  with dm do
    begin
      if anterior <> Trim(EdRemessa.Text) then
        begin
          anterior  := Trim(EdRemessa.Text);
          if Verifica(EdRemessa.Text) = 'erro' then
            begin
              application.MessageBox('Caracter inv�lido','Ads',MB_OK+MB_ICONERROR);
              EdRemessa.SetFocus;
              exit;
            end;
          case length(trim(EdRemessa.Text)) of
            30,34,35:
              begin
                calculado := StrToInt(VerificaDigito7(Copy(EdRemessa.Text,6,7)));
                numero    := StrToInt(Copy(EdRemessa.Text,6,7));
                digito    := StrToInt(Copy(EdRemessa.Text,13,1)); //codigo da ag de 1 a 5 e conta de 6 a 9
                if ((Copy(EdRemessa.Text,5,1)) <> ((VerificaDigito7(copy(EdRemessa.Text,1,4))))) then
                  begin
                    MessageDlg('D�gito Verificador do C�digo de Ag�ncia Inv�lido ',mtwarning,[mbok],0);
                    EdRemessa.SetFocus;
                    exit;
                  end
                else if ((Copy(EdRemessa.Text,13,1)) <> ((VerificaDigito7(Copy(EdRemessa.Text,6,7))))) then
                  begin
                    if ((Copy(EdRemessa.Text,13,1) <> '7') and ((VerificaDigito7(Copy(EdRemessa.Text,6,7))<> '0'))) then
                      begin
                        MessageDlg('D�gito Verificador do C�digo da Conta Inv�lido ',mtwarning,[mbok],0);
                        EdRemessa.SetFocus;
                        exit;
                      end
                    else
                    procreg;
                  end
                else
                    procreg;
              end;
            36:
              begin
                calculado := StrToInt(VerificaDigito7(Copy(EdRemessa.Text,6,8)));
                numero    := StrToInt(Copy(EdRemessa.Text,6,8));
                digito    := StrToInt(Copy(EdRemessa.Text,14,1)); //codigo da ag de 1 a 5 e conta de 6 a 9
                if ((Copy(EdRemessa.Text,5,1)) <> ((VerificaDigito7(copy(EdRemessa.Text,1,4))))) then
                  begin
                    MessageDlg('D�gito Verificador do C�digo de Ag�ncia Inv�lido ',mtwarning,[mbok],0);
                    EdRemessa.SetFocus;
                    exit;
                  end
                else if ((Copy(EdRemessa.Text,14,1)) <> ((VerificaDigito7(Copy(EdRemessa.Text,6,8))))) then
                  begin
                    if ((Copy(EdRemessa.Text,14,1) <> '7') and ((VerificaDigito7(Copy(EdRemessa.Text,6,8))<> '0'))) then
                      begin
                        MessageDlg('D�gito Verificador do C�digo da Conta Inv�lido ',mtwarning,[mbok],0);
                        EdRemessa.SetFocus;
                        exit;
                      end
                    else
                    procreg;
                  end
                else
                    procreg;
              end;
            else
                StBr.Panels[0].Text := 'D�gitos Excedentes � 30 ou 34 ou 36 ou < � 30 ou 34 ou 36';
          end;
        end
      else
        StBr.Panels[0].Text := 'Anterior igual ao atual';
    end;
  EdRemessa.Clear;
  EdRemessa.SetFocus;
end;//fim bxa extrato unificado
procedure TFrmExtContaCorrentePoupanca.procextratocartao;
begin
  with dm do
    begin
      if anterior <> Trim(EdRemessa.Text) then
        begin
          anterior  := Trim(EdRemessa.Text);
          if Verifica(EdRemessa.Text) = 'erro' then
            begin
              application.MessageBox('Caracter inv�lido','Ads',MB_OK+MB_ICONERROR);
              EdRemessa.Clear;
              EdRemessa.SetFocus;
              exit;
            end;
          case length(trim(EdRemessa.Text)) of
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
                  3:  StBr.Panels[0].Text := 'N�mero de remessas excedidas';
                  else
                    begin
                      Dm.SqlAux1.Close;
                      Dm.SqlAux1.Sql.Clear;
                      Dm.SqlAux1.Sql.Add('insert into cga67 ');
                      Dm.SqlAux1.Sql.Add('(cg67_remes,cg67_dup,cg67_dtext,cg67_codbaixa,');
                      Dm.SqlAux1.Sql.Add('cg67_caixa,cg67_codusu,cg67_dtbaixa) ');
                      Dm.SqlAux1.Sql.Add(' values ');
                      Dm.SqlAux1.Sql.Add('(:cg67_remes,:cg67_dup,:cg67_dtext,:cg67_codbaixa,');
                      Dm.SqlAux1.Sql.Add(':cg67_caixa,:cg67_codusu,(select current_date)) ');
                      Dm.SqlAux1.Params[0].Value := EdRemessa.Text;
                      Dm.SqlAux1.Params[1].Value := total + 1;
                      Dm.SqlAux1.Params[2].Value := Copy(EdRemessa.Text,25,4) + '-' + Copy(EdRemessa.Text,29,2) +'-'+ Copy(EdRemessa.Text,31,2)   ;
                      Dm.SqlAux1.Params[3].Value := Dm.SqlCga20cg20_codbaixa.Value;
                      Dm.SqlAux1.Params[4].Value := EdCaixa.Text;
                      Dm.SqlAux1.Params[5].Value := Dm.sqlcga_acessocodigo.AsInteger;
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
            StBr.Panels[0].Text := 'Numero de remessa Incorreta';
          end;
        end
      else
        StBr.Panels[0].Text := 'Anterior igual ao atual';
    end;
    EdRemessa.Clear;
    EdRemessa.SetFocus;
end;
procedure TFrmExtContaCorrentePoupanca.procextratodrc;
begin
  with dm do
    begin
      if (Copy(trim(EdRemessa.Text),1,3) = '402') then
        procdrcprv
      else
        begin
          if anterior <> EdRemessa.Text then
            begin
              anterior := EdRemessa.Text;
              Testa:= Verifica(EdRemessa.Text);
              if (length(trim(EdRemessa.Text))=13) and (Testa<>'erro') and (ChkDigita.Checked=True) and (GroupTipo.Visible=True) then
                Testa:=VerificaValidade_Codigo(EdRemessa.Text);
              if testa <> 'erro' then
                begin
                  if (Length(trim(EdRemessa.Text)) = 18) or ((Length(trim(EdRemessa.Text))>=11) and (Length(trim(EdRemessa.Text))<=13)) Then
                    begin
                      if (copy(EdRemessa.Text,1,3) <> '000') then
                        begin
                          SqlAux1.Close;
                          SqlAux1.Sql.Clear;
//                          SqlAux1.Sql.Add('select count(*) from cga037 where (cg037_dp = :cg037_dp) and (cg037_tiposerv = 3)');
                          SqlAux1.Sql.Add('select count(*) from cga037 where (:cg037_dp between cg037_dpini and cg037_dpfin) and (cg037_tiposerv = 3) limit 1');
                          SqlAux1.Params[0].AsString := trim(copy(EdRemessa.Text,1,4));
//                          SqlAux1.Params[0].AsString := trim(copy(EdRemessa.Text,1,4));
                          SqlAux1.Open;
                          if (SqlAux1.Fields[0].AsInteger = 1) then
                            begin
                              if  ((Length(trim(EdRemessa.Text))= 11) and (VerDvCpf(trim(EdRemessa.Text)) = false)) or
                                  ((Length(trim(EdRemessa.Text)) = 18) or ((Length(trim(EdRemessa.Text))>=11) and (Length(trim(EdRemessa.Text))<=13))) then
                                begin
                                  SqlAux1.Close;
                                  SqlAux1.Sql.Clear;
                                  SqlAux1.Sql.Add('select count(*) from cga100 where cg100_remes = :cg100_remes');
                                  SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                                  SqlAux1.Open;
                                  case Dm.SqlAux1.Fields[0].AsInteger of
                                    3: Application.MessageBox('Remessas Excedidas'+chr(10)+'Separe-o com Remessas Excedidas','ADS',0);
                                  else
                                    begin
                                      SqlAux1.Close;
                                      SqlAux1.Sql.Clear;
                                      SqlAux1.Sql.Add('insert into cga100 (');
                                      SqlAux1.Sql.Add('cg100_remes,cg100_dup,cg100_dtbaixa,cg100_codbaixa,');
                                      SqlAux1.Sql.Add('cg100_caixa,cg100_codusu)');
                                      SqlAux1.Sql.Add(' values ');
                                      SqlAux1.Sql.Add('(:cg100_remes,:cg100_dup,(select current_date),:cg100_codbaixa,');
                                      SqlAux1.Sql.Add(':cg100_caixa,:cg100_codusu)');
                                      SqlAux1.Params[0].Value := EdRemessa.Text;
                                      SqlAux1.Params[1].Value := total + 1;
                                      SqlAux1.Params[2].Value := Dm.SqlCga20cg20_codbaixa.Value;
                                      SqlAux1.Params[3].Value := EdCaixa.Text;
                                      SqlAux1.Params[4].Value := Dm.sqlcga_acessocodigo.AsInteger;
                                      total:=total+1;
                                      try
                                        SqlAux1.ExecSql;
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
                                    end;
                                  end;//fim case
                                end
                              else
                                Application.MessageBox('Esse c�digo de remessa est� fora de padr�o.'+chr(10)+'Procure o administrador do sistema e relate o erro.','Erro na leitura !',MB_OK+MB_ICONERROR);
                            end
                          else
                          Application.MessageBox(PChar('N�o H� C�digo Cadastrado: '+copy(EdRemessa.Text,1,4)+' Separe-os'),'ADS',ID_OK);
                        end
                      else
                        Application.MessageBox('C�digo Inv�lido'+chr(10)+'Verifique se � Drc-Cobran�a'+chr(10)+'Separe-os','ADS',0);
                    end
                  else
                    Application.MessageBox('Esse c�digo de remessa est� fora de padr�o.'+chr(10)+'Procure o administrador do sistema e relate o erro.','Erro na leitura !',MB_OK+MB_ICONERROR);
                end
              else
                Application.MessageBox('Esse c�digo de remessa est� fora de padr�o. Procure o administrador do sistema e relate o erro.','Erro na leitura !',MB_OK+MB_ICONERROR);
            end
          else
            Application.MessageBox('Mesmo C�digo.','ADS!',MB_OK+MB_ICONERROR);
        end;
    end;
  EdRemessa.Clear;
  EdRemessa.SetFocus;
end;
procedure TFrmExtContaCorrentePoupanca.procextratocvm;
begin
  with dm do
  begin
    if anterior <> Trim(EdRemessa.Text) then
      begin
        anterior  := Trim(EdRemessa.Text);
        if Verifica(EdRemessa.Text) = 'erro' then
          begin
           application.MessageBox('Caracter inv�lido','Ads',MB_OK+MB_ICONERROR);
           EdRemessa.Clear;
           EdRemessa.SetFocus;
           exit;
          end
        else
          begin
            case length(trim(edremessa.Text)) of
              24,26:
                 begin
                   Edremessa2.SetFocus;
                 end;
            else
              begin
                StBr.Panels[0].Text := 'N�mero de Remessa Incorreto ou Lay-Out Incorreto';
                EdRemessa.Clear;
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
end;
procedure TFrmExtContaCorrentePoupanca.procextratobcopostal; // extrato Banco Postal
begin
  with dm do
    begin
      if anterior <> Trim(EdRemessa.Text) then
        begin
          anterior  := Trim(EdRemessa.Text);
          if Verifica(EdRemessa.Text) = 'erro' then
            begin
             application.MessageBox('Caracter inv�lido','Ads',MB_OK+MB_ICONERROR);
             EdRemessa.Clear;
             EdRemessa.SetFocus;
             exit;
            end;
         case length(trim(EdRemessa.Text)) of
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
                   Dm.SqlAux1.Sql.Add(':cg70_caixa,:cg70_codusu,(select current_date)) ' );
                   Dm.SqlAux1.Params[0].Value := EdRemessa.Text;
                   Dm.SqlAux1.Params[1].Value := Dm.SqlCga20cg20_codbaixa.Value;
                   Dm.SqlAux1.Params[2].Value := EdCaixa.Text;
                   Dm.SqlAux1.Params[3].Value := Dm.sqlcga_acessocodigo.AsInteger;
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
end;

procedure TFrmExtContaCorrentePoupanca.procdrccrtconv;
begin
  with dm do
    begin
       // extrato carta convitedrc
        if anterior <> EdRemessa.Text then
            begin
              anterior := EdRemessa.Text;
              Testa:= Verifica(EdRemessa.Text);
              //if (length(EdRemessa.Text)<> 17) and (Testa<>'erro') and (ChkDigita.Checked=True) and (GroupTipo.Visible=True) then
              //  Testa:=VerificaValidade_Codigo(EdRemessa.Text);
              if testa <> 'erro' then
                begin
                  If (Length(trim(EdRemessa.Text)) = 11) or ((Length(trim(EdRemessa.Text)) >= 15) and (length(EdRemessa.Text) <= 17)) then
                    Begin
                      if ((Length(trim(EdRemessa.Text)) = 11) and (VerDvCpf(trim(EdRemessa.Text))= true)) or ((Length(trim(EdRemessa.Text)) >= 15) and (length(EdRemessa.Text) <= 17))  then
                      begin
                      Dm.SqlAux1.Close;
                      Dm.SqlAux1.Sql.Clear;    //Aqui to esperando uma defini�ao do cliente address e cliente bradesco sobre o procedimento qdo achar um registro de outro ano
                      Dm.SqlAux1.Sql.Add('select count(cg120_remes) from cga120 where (cg120_remes = :cg120_remes) and (cg120_codbaixa = :codbxa) and ((select current_date) - cg120_dtbaixa < 7)');
                      Dm.SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                      Dm.SqlAux1.Params[1].AsString := Dm.SqlCga20cg20_codbaixa.AsString;
                      //                      Dm.SqlAux1.Params[1].AsString := formatdatetime('yyyy-mm-dd',date-32);
                      Dm.SqlAux1.Open;
//                            total := Dm.SqlAux1.Fields[0].AsInteger;
                      case Dm.SqlAux1.Fields[0].AsInteger of
                        0:
                          begin
                            Dm.SqlAux1.Close;
                            Dm.SqlAux1.Sql.Clear;
                            Dm.SqlAux1.Sql.Add('insert into cga120 (');
                            Dm.SqlAux1.Sql.Add('cg120_remes,cg120_dtbaixa,cg120_codbaixa,');
                            Dm.SqlAux1.Sql.Add('cg120_caixa,cg120_codusu)');
                            Dm.SqlAux1.Sql.Add(' values ');
                            Dm.SqlAux1.Sql.Add('(:cg120_remes,(select current_date),:cg120_codbaixa,');
                            Dm.SqlAux1.Sql.Add(':cg120_caixa,:cg120_codusu)');
                            Dm.SqlAux1.Params[0].Value := EdRemessa.Text;
                            Dm.SqlAux1.Params[1].Value := Dm.SqlCga20cg20_codbaixa.Value;
                            Dm.SqlAux1.Params[2].Value := EdCaixa.Text;
                            Dm.SqlAux1.Params[3].Value := Dm.sqlcga_acessocodigo.AsInteger;
                            total:=total+1;
                            try
                              Dm.SqlAux1.ExecSql;
                              StBr.Panels[0].Text := '';
                              EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                            except on e: exception do
                              begin
                                StBr.Panels[0].Text := 'Ocorreu um erro fatal: '+e.Message;
                                EdRemessa.Clear;
                                EdRemessa.SetFocus;
                                exit;
                              end;
                            end;
                          end;
{                        else
                          StBr.Panels[0].Text := 'C�digo J� Existe. '+EdRemessa.Text;}
                      end;
                    end
                    else
                      Application.MessageBox(PChar('Digito Verificador Inv�lido'+chr(10)+'Verifique se � Drc - Carta Convite'+chr(10)+'Separe-o.'),'SPT - DRC - Carta Convite !',MB_OK+MB_ICONERROR)

                    end
                  else
                  Application.MessageBox(PChar('Esse c�digo de remessa est� fora de padr�o.'+chr(10)+'Separe-o.'),'SPT - DRC - Carta Convite !',MB_OK+MB_ICONERROR)
                end
              else
                Application.MessageBox(PChar('Esse c�digo de remessa est� fora de padr�o.'+chr(10)+'Separe-o.'),'SPT - DRC - Carta Convite !',MB_OK+MB_ICONERROR)
            end
        else
          StBr.Panels[0].Text := 'C�digo = Anterior: '+EdRemessa.Text;
    end;
  EdRemessa.Clear;
  EdRemessa.SetFocus;
end;

procedure TFrmExtContaCorrentePoupanca.proccrtsenha;
begin
  with dm do
    begin
    if anterior <> EdRemessa.Text then
        begin
          anterior := EdRemessa.Text;
          //Testa:= Verifica(EdRemessa.Text);
          //if (length(EdRemessa.Text)<> 17) and (Testa<>'erro') and (ChkDigita.Checked=True) and (GroupTipo.Visible=True) then
          //  Testa:=VerificaValidade_Codigo(EdRemessa.Text);
          if (trim(EdRemessa.Text) <> '') and (vernum(trim(EdRemessa.Text)) = true) then
            begin
              If (Length((trim(EdRemessa.Text))) = 20) Then
                Begin
                  SqlAux1.Close;
                  SqlAux1.Sql.Clear;
                  SqlAux1.Sql.Add('select count(cg035_remes) from cga035 where (cg035_remes = :remes) and (cg035_dtbaixa =(select current_date))');
                  SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                  SqlAux1.Open;
//                            total := Dm.SqlAux1.Fields[0].AsInteger;
                  case SqlAux1.Fields[0].AsInteger of
                    0:
                      begin
                        SqlAux1.Close;
                        SqlAux1.Sql.Clear;
                        SqlAux1.Sql.Add('insert into cga035 (cg035_remes,cg035_dtext,cg035_dtbaixa,cg035_hrbaixa,cg035_codbaixa,');
                        SqlAux1.Sql.Add('cg035_caixa,cg035_codusu)');
                        SqlAux1.Sql.Add(' values ');
                        SqlAux1.Sql.Add('(:cg035_remes,:cg035_dtext,(select current_date),(select current_time),:cg035_codbaixa,');
                        SqlAux1.Sql.Add(':cg035_caixa,:cg035_codusu)');
                        SqlAux1.Params[0].Value := EdRemessa.Text;
                        SqlAux1.Params[1].Value := copy(EdRemessa.Text,17,4)+'-'+copy(EdRemessa.Text,15,2)+'-'+copy(EdRemessa.Text,13,2);
                        SqlAux1.Params[2].Value := Dm.SqlCga20cg20_codbaixa.Value;
                        SqlAux1.Params[3].Value := EdCaixa.Text;
                        SqlAux1.Params[4].Value := FrmPrincipal.codusu;
                        try
                          SqlAux1.ExecSql;
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
                      end;
                    else
                    begin
                      StBr.Panels[0].Text := 'C�digo J� Cadastro no Dia'+EdRemessa.Text;
                    end;
                  end;
                end
            else
              Application.MessageBox('Esse c�digo de remessa est� fora de padr�o. '+#10+'Separe a Remessa.','Erro na leitura !',MB_OK+MB_ICONERROR);
          end
        else
          Application.MessageBox('Esse c�digo de remessa est� fora de padr�o.'+#10+'Separe a Remessa','Erro na leitura !',MB_OK+MB_ICONERROR);
      end;
      EdRemessa.Clear;
      EdRemessa.SetFocus;
    end;
end;// fim do case para tipo de extrato
procedure TFrmExtContaCorrentePoupanca.procconsorcio;
begin
  with dm do
    begin
    if anterior <> EdRemessa.Text then
        begin
          anterior := EdRemessa.Text;
          //Testa:= Verifica(EdRemessa.Text);
          //if (length(EdRemessa.Text)<> 17) and (Testa<>'erro') and (ChkDigita.Checked=True) and (GroupTipo.Visible=True) then
          //  Testa:=VerificaValidade_Codigo(EdRemessa.Text);
          if (trim(EdRemessa.Text) <> '') and (vernum(trim(EdRemessa.Text)) = true) then
            begin
              If (Length((trim(EdRemessa.Text))) = 20) Then
                Begin
                  Dm.SqlAux1.Close;
                  Dm.SqlAux1.Sql.Clear;
                  Dm.SqlAux1.Sql.Add('select count(cg036_remes) from cga036 where (cg036_remes = :remes) and (cg036_dtbaixa = (select current_date))');
                  Dm.SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                  Dm.SqlAux1.Open;
//                            total := Dm.SqlAux1.Fields[0].AsInteger;
                  case Dm.SqlAux1.Fields[0].AsInteger of
                    0:
                      begin
                        Dm.SqlAux1.Close;
                        Dm.SqlAux1.Sql.Clear;
                        Dm.SqlAux1.Sql.Add('insert into cga036 (cg036_remes,cg036_dtext,cg036_dtbaixa,cg036_hrbaixa,cg036_codbaixa,');
                        Dm.SqlAux1.Sql.Add('cg036_caixa,cg036_codusu)');
                        Dm.SqlAux1.Sql.Add(' values ');
                        Dm.SqlAux1.Sql.Add('(:cg036_remes,:cg036_dtext,(select current_date),(select current_time),:cg036_codbaixa,');
                        Dm.SqlAux1.Sql.Add(':cg036_caixa,:cg036_codusu)');
                        Dm.SqlAux1.Params[0].Value := EdRemessa.Text;
                        Dm.SqlAux1.Params[1].Value := copy(EdRemessa.Text,17,4)+'-'+copy(EdRemessa.Text,15,2)+'-'+copy(EdRemessa.Text,13,2);
                        Dm.SqlAux1.Params[2].Value := Dm.SqlCga20cg20_codbaixa.Value;
                        Dm.SqlAux1.Params[3].Value := EdCaixa.Text;
                        Dm.SqlAux1.Params[4].Value := FrmPrincipal.codusu;
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
                      end;
                    else
                      begin
                        StBr.Panels[0].Text := 'Remessa j� Cadastrada no Dia'+EdRemessa.Text;
                      end;
                  end;
                end
            else
              Application.MessageBox('Esse c�digo de remessa est� fora de padr�o. '+#10+'Separe a Remessa.','Erro na leitura !',MB_OK+MB_ICONERROR);
          end
        else
          Application.MessageBox('Esse c�digo de remessa est� fora de padr�o.'+#10+'Separe a Remessa','Erro na leitura !',MB_OK+MB_ICONERROR);
      end;
      EdRemessa.Clear;
      EdRemessa.SetFocus;
    end;
end;// fim do case para tipo de extrato

procedure TFrmExtContaCorrentePoupanca.proccartaoseg;
begin
  with dm do
    begin
    if anterior <> EdRemessa.Text then
        begin
          anterior := EdRemessa.Text;
          //Testa:= Verifica(EdRemessa.Text);
          //if (length(EdRemessa.Text)<> 17) and (Testa<>'erro') and (ChkDigita.Checked=True) and (GroupTipo.Visible=True) then
          //  Testa:=VerificaValidade_Codigo(EdRemessa.Text);
          if (trim(EdRemessa.Text) <> '') and (vernum(trim(EdRemessa.Text)) = true) then
            begin
              If (Length((trim(EdRemessa.Text))) in [11,16]) Then
                Begin
                  Dm.SqlAux1.Close;
                  Dm.SqlAux1.Sql.Clear;
                  Dm.SqlAux1.Sql.Add('select count(cg130_remes) from cga130 where cg130_remes = :cg130_remes');
                  Dm.SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
                  Dm.SqlAux1.Open;
//                            total := Dm.SqlAux1.Fields[0].AsInteger;
                  case Dm.SqlAux1.Fields[0].AsInteger of
                    0:
                      begin
                        Dm.SqlAux1.Close;
                        Dm.SqlAux1.Sql.Clear;
                        Dm.SqlAux1.Sql.Add('insert into cga130 (');
                        Dm.SqlAux1.Sql.Add('cg130_remes,cg130_dtbaixa,cg130_codbaixa,');
                        Dm.SqlAux1.Sql.Add('cg130_caixa,cg130_codusu)');
                        Dm.SqlAux1.Sql.Add(' values ');
                        Dm.SqlAux1.Sql.Add('(:cg130_remes,(select current_date),:cg130_codbaixa,');
                        Dm.SqlAux1.Sql.Add(':cg130_caixa,:cg130_codusu)');
                        Dm.SqlAux1.Params[0].Value := EdRemessa.Text;
                        Dm.SqlAux1.Params[1].Value := Dm.SqlCga20cg20_codbaixa.Value;
                        Dm.SqlAux1.Params[2].Value := EdCaixa.Text;
                        Dm.SqlAux1.Params[3].Value := Dm.sqlcga_acessocodigo.AsInteger;
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
              Application.MessageBox('Esse c�digo de remessa est� fora de padr�o. '+#10+'Separe a Remessa e Procure o Supervisor.','Erro na leitura !',MB_OK+MB_ICONERROR);
          end
        else
          Application.MessageBox('Esse c�digo de remessa est� fora de padr�o.'+#10+'Separe a Remessa e Procure o Superior.','Erro na leitura !',MB_OK+MB_ICONERROR);
      end;
      EdRemessa.Clear;
      EdRemessa.SetFocus;
    end;
end;



procedure TFrmExtContaCorrentePoupanca.proccartaocred;//Fatura cartao de credito    50:
begin
  with dm do
  begin
    if anterior <> EdRemessa.Text then
      begin
        anterior  := EdRemessa.Text;
        testa := Verifica(trim(EdRemessa.Text));
        if(Length(trim(EdRemessa.Text))=34) and (testa <> 'erro')then
          begin
            data  := Copy(EdRemessa.Text,29,2);
            data  := data + '/';
            data  := data + Copy(EdRemessa.Text,31,2);
            data  := data + '/';
            data  := data + copy(EdRemessa.Text,33,2);
            //data  := data + '20';
            SqlAux1.Close;
            SqlAux1.SQL.Clear;
            SqlAux1.SQL.Add('INSERT into cgafatcrtcrd (cgfatcrtcrd_remes,cgfatcrtcrd_dtext,cgfatcrtcrd_codbaixa,');
            SqlAux1.SQL.Add('cgfatcrtcrd_caixa,cgfatcrtcrd_codusu,cgfatcrtcrd_dtbaixa)');
            SqlAux1.SQL.Add('VALUES(:rem,:dtext,:codbxa,:caixa,:codusu,(select current_date))');
            SqlAux1.Params[0].AsString  := trim(EdRemessa.Text);
            SqlAux1.Params[1].AsString  := FormatDateTime('yyyy/mm/dd',StrToDate(data));
            SqlAux1.Params[2].AsString  := DbLkBaixa.KeyValue;
            SqlAux1.Params[3].AsString  := EdCaixa.Text;
            SqlAux1.Params[4].AsInteger := Dm.sqlcga_acessocodigo.AsInteger;
            try
              BEGIN
                SqlAux1.ExecSql;
                EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                EdRemessa.Clear;
                EdRemessa.SetFocus;
              END;
            except on e: exception do
              begin
                application.MessageBox(PChar('C�digo Inv�lido!! Separe - o: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                StBr.Panels[0].Text := 'Ocorreu um erro Fatal';
                exit;
              end;
            end;
          end
        else
          begin
            Application.MessageBox('C�digo Com D�gitos < ou > 34 !! Separe - o!!!','ADS',0);
            EdRemessa.SetFocus;
            Exit;
          end;
      end
    else
      begin
        Application.MessageBox('C�digo Inv�lido!! Separe - o!!!','ADS',0);
        EdRemessa.SetFocus;
        Exit;
      end;
    end;
end;
procedure TFrmExtContaCorrentePoupanca.proccllpdrc;
begin
  StBr.Panels[0].Text := '';
  with dm do
    begin
      if anterior <> Trim(EdRemessa.Text) then
        begin
          anterior  := Trim(EdRemessa.Text);
          if Verifica(EdRemessa.Text) = 'erro' then
            begin
              application.MessageBox('Caracter inv�lido','Ads',MB_OK+MB_ICONERROR);
              //EdRemessa.Clear;
              EdRemessa.SetFocus;
              exit;
            end;
          if (vernum(EdRemessa.Text) = False) then
            begin
              application.MessageBox('Caracter inv�lido','Ads',MB_OK+MB_ICONERROR);
              //EdRemessa.Clear;
              EdRemessa.SetFocus;
              exit;
            end;
          if (copy(EdRemessa.Text,10,4)='0000') then
            begin
              if (VerDvCpf(copy(EdRemessa.Text,1,9)+copy(EdRemessa.Text,14,2))=False) then
                begin
                  application.MessageBox('Documento inv�lido','Adsb - Separe-o',MB_OK+MB_ICONERROR);
                  EdRemessa.SetFocus;
                  exit;
                end;
            end;
          case length(trim(EdRemessa.Text)) of
            29:
              begin
                SqlAux1.Close;
                SqlAux1.Sql.Clear;
                SqlAux1.Sql.Add('select (cg78_remes) from cga78 where (cg78_remes = :remes) and (cg78_dtret is null)');
                SqlAux1.Params[0].AsString  :=  trim(EdRemessa.Text);
                SqlAux1.Open;
                case SqlAux1.RecordCount of
                  0:
                    begin
                      SqlAux1.Close;
                      SqlAux1.Sql.Clear;
                      SqlAux1.Sql.Add('insert into cga78 (cg78_remes,cg78_dtext,cg78_codbaixa,');
                      SqlAux1.Sql.Add('cg78_caixa,cg78_codusu,cg78_dtbaixa) values (');
                      SqlAux1.Sql.Add(':cg78_remes,:cg78_dtext,:cg78_codbaixa,');
                      SqlAux1.Sql.Add(':cg78_caixa,:cg78_codusu,(select current_date)) ');
                      SqlAux1.Params[0].Value := trim(EdRemessa.Text);
                      //SqlAux1.Params[1].Value := total + 1;
                      SqlAux1.Params[1].Value := Copy(EdRemessa.Text,20,4)+'-'+Copy(EdRemessa.Text,18,2)+'-'+Copy(EdRemessa.Text,16,2);
                      //Dm.SqlAux1.Params[2].Value := Copy(EdRemessa.Text,21,4)+'-'+Copy(EdRemessa.Text,19,2)+'-'+Copy(EdRemessa.Text,17,2);
                      SqlAux1.Params[2].Value := SqlCga20cg20_codbaixa.Value;
                      SqlAux1.Params[3].Value := EdCaixa.Text;
                      SqlAux1.Params[4].Value := sqlcga_acessocodigo.AsInteger;
                      //SqlAux1.Params[6].Value := Copy(EdRemessa.Text,1,5);
                      //SqlAux1.Params[7].Value := copy(EdRemessa.Text,22,2);
                      try
                        BEGIN
                          SqlAux1.ExecSql;
                          EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                          EdRemessa.Clear;
                          EdRemessa.SetFocus;
                        END;
                      except on e: exception do
                        begin
                          application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                          StBr.Panels[0].Text := 'Ocorreu um erro Fatal';
                          exit;
                        end;
                      end;
                    end;
                  else
                    begin
                      Application.MessageBox('C�digo J� Inserido ','ADS - DRC - Aviso Cobran�a - CLLP',MB_OK);
                      //EdRemessa.Text  :=EdRemessa.Text+'A';
                      StBr.Panels[0].Text := 'N�mero Remessa J� Lida :'+EdRemessa.Text;
                      exit;
                    end;
                end;
              end
            else
              begin
                Application.MessageBox('C�digo Errado - Qtde de D�gitos < ou > 29','ADS - DRC - Aviso Cobran�a',MB_OK);
                EdRemessa.Text  :=EdRemessa.Text+'A';
                StBr.Panels[0].Text := 'N�mero de remessa Incorreta';
                exit;
              end;
          end;
        end
      else
//        Application.MessageBox('C�digo Errado','ADS - DRC - Aviso Cobran�a',MB_OK);
        StBr.Panels[0].Text := 'Anterior igual ao atual';
    end;          end;//fim leitura CCLP-DRC
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
        GroupTipo.Visible:=False;
  case tag of
    8:
      begin
        RdGrptipocli.Visible   :=true;
//        RdGrptipocli.ItemIndex := 0;
        RdGrptipocli.Enabled   := True;
        Ednumlote.Visible  := true;
        Ednumlote.Enabled  := true;
        Edresto.Visible    := true;
        Panel6.Visible     := true;
        Panel7.Visible     := true;
      end;
    else
      begin
        RdGrptipocli.Visible:=false;
        RdGrptipocli.Enabled:=false;
      end;
  end;
  case tag of
    11,12: EdRemessa.SetFocus;
    13:
      begin
        CboBoxTipoBxa.Enabled  := true;
        CboBoxTipoBxa.Visible  := true;

      end;
  end;
end;

procedure TFrmExtContaCorrentePoupanca.Edremessa2Exit(Sender: TObject);
begin
  If EdRemessa2.Tag = 5 Then
    Begin
      EdQt.Text := '0';
    End;
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
                Application.MessageBox('C�digo de Baixa Inv�lido'+#10+
                'Favor Recolher o Movimento e'+#10+
                'Entregue-o ao Respon�vel','Ads',MB_OK+MB_ICONERROR);
                EdRemessa.Clear;
                EdRemessa.SetFocus;
                exit;
              end;
            else
              begin
                case FrmExtContaCorrentePoupanca.Tag of
                  8:
                    begin
                      if ((trim(Edremessa2.Text) = '') or (vernum(trim(Edremessa2.Text)) = false)) then
                        begin
                          application.MessageBox('Ag�ncia deve ser n�merico','Ads',MB_OK+MB_ICONERROR);
                          EdRemessa2.Clear;
                          Edremessa2.SetFocus;
                          exit;
                        end
                      else
                          Ednumlote.SetFocus;
                    end;
                  else
                    begin
                     if (anterior2 <> Trim(EdRemessa2.Text)) or (anterior <> Trim(EdRemessa.Text)) then
                       begin
                         anterior2  := Trim(EdRemessa2.Text);
                         case (length(Trim(EdRemessa2.Text))) of
                           34:
                             begin
                               if Verifica(EdRemessa2.Text) = 'erro' then
                                 begin
                                   application.MessageBox('Caracter inv�lido','Ads',MB_OK+MB_ICONERROR);
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
                                   Dm.SqlAux1.Sql.Add(':cg69_caixa,:cg69_codusu,(select current_date)) ' );
                                   Dm.SqlAux1.Params[0].Value := trim(EdRemessa.Text);
                                   Dm.SqlAux1.Params[1].Value := trim(EdRemessa2.Text);
                                   Dm.SqlAux1.Params[2].Value := Dm.SqlCga20cg20_codbaixa.Value;
                                   Dm.SqlAux1.Params[3].Value := EdCaixa.Text;
                                   Dm.SqlAux1.Params[4].Value := Dm.sqlcga_acessocodigo.AsInteger;
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
                             end;
                           else
                             begin
                               StBr.Panels[0].Text := 'C�digo Correio Incorreto!!!';
                               exit;
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


procedure TFrmExtContaCorrentePoupanca.CboBoxTipoBxaClick(Sender: TObject);
begin
  EdRemessa.SetFocus;
end;


procedure TFrmExtContaCorrentePoupanca.EdnumloteKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key = #13) AND (FrmExtContaCorrentePoupanca.Tag = 8) then // IF 1
    begin
      if ((trim(Edremessa2.Text) <> '') or (trim(Ednumlote.Text) <> '' ) or
          (vernum(trim(Ednumlote.Text)) = true)) then // IF 2
        begin
          dm.SqlAux1.Close;
          dm.SqlAux1.SQL.Clear;
          dm.SqlAux1.SQL.Add('SELECT cg77_qtd, cg77_dtb ');
          dm.SqlAux1.SQL.Add('FROM cga77 ');
          dm.SqlAux1.SQL.Add('WHERE cg77_ag IN (:ag, :ag2) AND cg77_numlote = :numlote ');
          dm.SqlAux1.SQL.Add('    AND cg77_status = :status');
          dm.SqlAux1.ParamByName('ag').AsString := LPad(trim(Edremessa2.Text), 4, '0');
          dm.SqlAux1.ParamByName('ag2').AsString := Edremessa2.Text;
          dm.SqlAux1.ParamByName('numlote').AsString :=  LPad(trim(Ednumlote.Text), 6, '0');
          dm.SqlAux1.ParamByName('status').AsString := '0';
          dm.SqlAux1.Open;

          if (dm.SqlAux1.RecordCount > 0) then // IF 3
            begin
              qtde := dm.SqlAux1.FieldByName('cg77_qtd').AsInteger;
              dtb := dm.SqlAux1.FieldByName('cg77_dtb').AsString;
              dm.SqlAux1.Close;
              dm.SqlAux1.SQL.Clear;
              dm.SqlAux1.SQL.Add('SELECT COUNT(cg76_remes) as qt ');
              dm.SqlAux1.SQL.Add('FROM cga76 ');
              dm.SqlAux1.SQL.Add('WHERE cg76_ag IN (:ag, :ag2) ');
              dm.SqlAux1.SQL.Add('    AND cg76_numlote = :numlote');
              dm.SqlAux1.ParamByName('ag').AsString := LPad(trim(Edremessa2.Text), 4, '0');
              dm.SqlAux1.ParamByName('ag2').AsString := Edremessa2.Text;
              dm.SqlAux1.ParamByName('numlote').AsString :=  LPad(trim(Ednumlote.Text), 6, '0');
              dm.SqlAux1.Open;
              if (qtde - dm.SqlAux1.FieldByName('qt').AsInteger) > 0 then // If 4
                begin
                  qtdaux := qtde - dm.SqlAux1.FieldByName('qt').AsInteger;
                  Edresto.Text :=  IntToStr(qtdaux);
                  EdRemessa.SetFocus;
                end
              else
                begin
                  application.MessageBox('Tokens para Ag�ncia Finalizada!'+chr(10)+
                      'Fechar a Caixa e Criar nova Ag�ncia!','Ads',MB_OK+MB_ICONERROR);
                  finalagencia;
                  Edremessa2.Clear;
                  Edremessa2.SetFocus;
                  exit;
                end; // IF 4
            end
          else
            begin
              application.MessageBox('Ag�ncia ou N� do Lote n�o Existe,'+chr(10)+
                  'ou j� foi enviado'+chr(10)+'Procure o Supervisor do Servi�o',
                  'Ads',  MB_OK+MB_ICONERROR);
              exit;
            end; // IF 3
        end
      else
        begin
          application.MessageBox('Digite a Ag�ncia ou N� do Lote deve ser num�rico',
              'Ads', MB_OK + MB_ICONERROR);
          Edremessa2.Clear;
          Edremessa2.SetFocus;
        end; // IF 2
    end; // IF 1
end;

procedure TFrmExtContaCorrentePoupanca.gravatoken;
var codtkn, codag : String;
begin
  with dm do
    begin
     SqlAux1.Close;
     SqlAux1.Sql.Clear;
     SqlAux1.Sql.Add('SELECT COUNT(cg77_dtb) as qt');
     SqlAux1.Sql.Add('FROM cga77 WHERE cg77_dtb = :dtb ');
     SqlAux1.Sql.Add('    AND cg77_numlote = :numlote ');
     SqlAux1.Sql.Add('    AND cg77_ag IN (:ag, :ag2) ');
     if CheckBox1.Checked = false then
       begin
         SqlAux1.Sql.Add('    AND cg77_tokfin >= :tokfin ');
         SqlAux1.Sql.Add('    AND cg77_tokini <= :tokini');
         SqlAux1.ParamByName('tokfin').AsString := copy(trim(Edremessa.Text), 1, 9);
         SqlAux1.ParamByName('tokini').AsString := copy(trim(Edremessa.Text), 1, 9);
       end;
     SqlAux1.ParamByName('dtb').AsString := Trim(dtb);
     SqlAux1.ParamByName('numlote').AsString := LPad(trim(Ednumlote.Text), 6, '0');
     SqlAux1.ParamByName('ag').AsString := LPad(trim(Edremessa2.Text), 4, '0');
     SqlAux1.ParamByName('ag2').AsString := IntToStr(StrToInt(Edremessa2.Text));

     SqlAux1.Open;
     if (SqlAux1.Fields[0].Value = 0) and (CheckBox1.Checked = false) then
       begin
         application.MessageBox(PChar('Token N�o Pertence A Essa Ag�ncia e Lote ou est� fora de sequ�ncia !'),'Ads',MB_OK+MB_ICONERROR);
         if (Application.MessageBox('Deseja Criar Novo Lote','ADS',mb_YesNo) = ID_No) then
           begin
             EdRemessa.Clear;
             EdRemessa.SetFocus;
             exit;
           end
         else
          novolote;
       end
     else
       begin
         SqlAux1.Close;
         SqlAux1.Sql.Clear;
         SqlAux1.Sql.Add('SELECT COUNT(cg76_remes) ');
         SqlAux1.Sql.Add('FROM cga76 ');
         SqlAux1.Sql.Add('WHERE cg76_dtb = :dtb AND cg76_numlote = :numlote');
         SqlAux1.ParamByName('dtb').AsString := Trim(dtb);
         SqlAux1.ParamByName('numlote').AsString := Trim(Ednumlote.Text);
         SqlAux1.Open;
         if (SqlAux1.Fields[0].Value < qtde) then
           begin
             SqlAux1.Close;
             SqlAux1.Sql.Clear;
             SqlAux1.Sql.Add('SELECT cg76_ag, cg76_remes  ');
             SqlAux1.Sql.Add('FROM cga76 ');
             SqlAux1.Sql.Add('WHERE SUBSTR(cg76_remes, 1, LENGTH(cg76_remes) - 1) = :cg76_remes ');
             EdRemessa.Text := Trim(EdRemessa.Text);
             // Sempre supondo que o �ltimo caractere lido do Token � o DV
             SqlAux1.ParamByName('cg76_remes').AsString := Copy(EdRemessa.Text, 1, Length(EdRemessa.Text) - 1);
             SqlAux1.Open;
             If SqlAux1.RecordCount > 0  Then
               Begin
                 codtkn := SqlAux1.FieldByName('cg76_remes').AsString;
                 codag := SqlAux1.FieldByName('cg76_ag').AsString;
                 If ((trim(codag) = '') or
                    (codag = null)) or
                    (CheckBox1.Checked = true) Then
                  Begin
                    SqlAux1.Close;
                    SqlAux1.Sql.Clear;
                    SqlAux1.Sql.Add('UPDATE cga76');
                    SqlAux1.Sql.Add('SET cg76_codbaixa = :codbaixa, ');
                    SqlAux1.Sql.Add('cg76_dtsai = CURRENT_DATE, cg76_ag =:ag, ');
                    SqlAux1.Sql.Add('cg76_tipocli = :tipocli, cg76_dtb = :dtb, ');
                    SqlAux1.Sql.Add('cg76_numlote = :numlote, cg76_codusu = :codusu, ');
                    SqlAux1.Sql.Add('cg76_remes = :cg76_remes ');
                    SqlAux1.Sql.Add('WHERE cg76_remes = :cg76_remes2');
                    SqlAux1.ParamByName('codbaixa').AsString := SqlCga20cg20_codbaixa.AsString;
                    SqlAux1.ParamByName('ag').AsString := LPad(Trim(EdRemessa2.Text), 4, '0');
                    SqlAux1.ParamByName('tipocli').AsInteger := RdGrptipocli.ItemIndex;
                    SqlAux1.ParamByName('dtb').AsString := Trim(dtb);
                    SqlAux1.ParamByName('numlote').AsString := LPad(trim(Ednumlote.Text),6, '0');
                    SqlAux1.ParamByName('codusu').AsInteger := Dm.sqlcga_acessocodigo.AsInteger;
                    SqlAux1.ParamByName('cg76_remes').AsString := EdRemessa.Text;
                    SqlAux1.ParamByName('cg76_remes2').AsString := codtkn;

                     try
                       SqlAux1.ExecSql;
                       StBr.Panels[0].Text := '';
                       EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                       case (qtdaux - strtoint(trim(EdQt.Text))) of
                         0:
                           begin
                             application.MessageBox(PChar('Finalizar Ag�ncia: '),'Ads',MB_OK+MB_ICONERROR);
                             finalagencia;
                             EdRemessa.Clear;
                             Edremessa2.SetFocus;
                             EdQt.Text  := '0';
                           end;
                         else
                           begin
                             Edresto.Text  :=  inttostr((qtdaux - strtoint(trim(EdQt.Text))));
                             EdRemessa.Clear;
                             EdRemessa.SetFocus;
                           end;
                       end;
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
                     ShowMessage('Produto j� Enviado para Ag�ncia:  '+Dm.SqlAux1.Fields[0].Value);
                     EdRemessa.Clear;
                     EdRemessa.SetFocus;
                   End;
               End
             Else
               Begin
                 procentrtoken(1);
                 EdRemessa.Clear;
                 EdRemessa.SetFocus;
               End;
           end
         else
           begin
             application.MessageBox(PChar('DTB ou Ag�ncia j� est� Fechada: '),'Ads',MB_OK+MB_ICONERROR);
             Edremessa2.Clear;
             EdRemessa.Clear;
             EdRemessa2.SetFocus;
           end;
       end;
     end;
end;

procedure TFrmExtContaCorrentePoupanca.finalagencia;
begin
  with dm do
    begin
     SqlAux1.Close;
     SqlAux1.Sql.Clear;
     SqlAux1.Sql.Add('UPDATE cga77 ');
     SqlAux1.Sql.Add('SET cg77_status = :status ');
     SqlAux1.Sql.Add('WHERE cg77_dtb = :dtb AND cg77_numlote = :numlote');
     SqlAux1.Sql.Add('    AND cg77_ag  IN (:ag, :ag2) ');
     SqlAux1.ParamByName('status').AsString := '1';
     SqlAux1.ParamByName('dtb').AsString := Trim(dtb);
     SqlAux1.ParamByName('numlote').AsString := LPad(trim(Ednumlote.Text),6, '0');
     SqlAux1.ParamByName('ag').AsString := LPad(trim(Edremessa2.Text), 4, '0');
     SqlAux1.ParamByName('ag2').AsString := IntToStr(StrToInt(Edremessa2.Text));
     try
       SqlAux1.ExecSQL;
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

procedure TFrmExtContaCorrentePoupanca.vertoken;
begin
  with dm do
    begin
     SqlAux1.Close;
     SqlAux1.Sql.Clear;
     SqlAux1.Sql.Add('SELECT COUNT(cg77_ag) FROM cga77 ');
     SqlAux1.Sql.Add('WHERE cg77_dtb = :dtb AND cg77_numlote = :numlote ');
     SqlAux1.Sql.Add('    AND cg77_ag  IN (:ag, :ag2) ');
     SqlAux1.Sql.Add('    AND cg77_tokini > :tokini');
     SqlAux1.ParamByName('dtb').AsString := Trim(dtb);
     SqlAux1.ParamByName('numlote').AsString := LPad(trim(Ednumlote.Text), 6, '0');
     SqlAux1.ParamByName('ag').AsString := LPad(trim(Edremessa2.Text), 4, '0');
     SqlAux1.ParamByName('ag2').AsString := IntToStr(StrToInt(Edremessa2.Text));
     SqlAux1.ParamByName('tokini').AsString := '0';
     SqlAux1.Open;
     case SqlAux1.Fields[0].Value of
       0: gravainitoken;
       1: gravatoken;
     end;
    end;
end;

procedure TFrmExtContaCorrentePoupanca.gravainitoken;
begin
  with dm do
    begin
     SqlAux1.Close;
     SqlAux1.Sql.Clear;
     SqlAux1.Sql.Add('SELECT COUNT(cg77_tokini) ');
     SqlAux1.Sql.Add('FROM cga77 ');
     SqlAux1.Sql.Add('WHERE cg77_dtb = :dtb AND cg77_numlote = :numlote ');
     SqlAux1.Sql.Add('    AND cg77_ag IN(:ag,:ag2) ');
     SqlAux1.Sql.Add('    AND cg77_tokini <= :toki AND cg77_tokfin >= :tokf ');
     SqlAux1.ParamByName('dtb').AsString := Trim(dtb);
     SqlAux1.ParamByName('numlote').AsString := LPad(trim(Ednumlote.Text), 6, '0');
     SqlAux1.ParamByName('ag').AsString := LPad(trim(Edremessa2.Text), 4, '0');
     SqlAux1.ParamByName('ag2').AsString := IntToStr(StrToInt(Edremessa2.Text));
     SqlAux1.ParamByName('toki').AsString := copy(trim(EdRemessa.Text), 1, 9);
     SqlAux1.ParamByName('tokf').AsString := copy(trim(EdRemessa.Text), 1, 9);
     SqlAux1.Open;
     case SqlAux1.Fields[0].Value of
       0:
         begin
           SqlAux1.Close;
           SqlAux1.Sql.Clear;
           SqlAux1.Sql.Add('UPDATE cga77 ');
           SqlAux1.Sql.Add('SET cg77_tokini = :tokini, cg77_tokfin = :tokfin ');
           SqlAux1.Sql.Add('WHERE cg77_dtb = :dtb AND cg77_numlote = :numlote ');
           SqlAux1.Sql.Add('    AND cg77_ag IN (:ag, :ag2) ');
           SqlAux1.Sql.Add('    AND cg77_status = :tok');
           SqlAux1.ParamByName('tokini').AsString := copy(trim(EdRemessa.Text), 1, 9);
           SqlAux1.ParamByName('tokfin').AsInteger := StrToInt(copy(EdRemessa.Text, 1, 9)) + qtde - 1;
           SqlAux1.ParamByName('dtb').AsString := Trim(dtb);
           SqlAux1.ParamByName('numlote').AsString := LPad(trim(Ednumlote.Text), 6, '0');
           SqlAux1.ParamByName('ag').AsString := LPad(trim(Edremessa2.Text), 4, '0');
           SqlAux1.ParamByName('ag2').AsString := IntToStr(StrToInt(Edremessa2.Text));
           SqlAux1.ParamByName('tok').AsString := '0';
           try
             begin
               SqlAux1.ExecSQL;
               if SqlAux1.RowsAffected = 0 then
                 begin
                   Application.MessageBox('N�o Gravou Token Inicial'+#10+'Chame o CPD','ADS',0);
                   EdRemessa.SetFocus;
                   exit;
                 end
               else
                   gravatoken;
             end;
           except on e: exception do
             begin
               application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
               EdRemessa.Clear;
               EdRemessa.SetFocus;
               exit;
             end;
           end;
         end;
       else
         begin
          gravatoken;
        end;
     end;
    end;
end;

procedure TFrmExtContaCorrentePoupanca.CheckBox1Click(Sender: TObject);
begin
  if inputbox('Senha de Supervis�o','Digite a Senha','') = 'bratoq' then
     CheckBox1.Checked := true
  else
     CheckBox1.Checked := false;
end;
procedure TFrmExtContaCorrentePoupanca.contatoken;
begin
  with dm do
    begin
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('select count(cg76_caixa) from cga76 where (cg76_caixa = :caixa)');
      SqlAux2.Params[0].Value :=  strtoint64(EdCaixa.Text);
      SqlAux2.Open;
      if (SqlAux2.fields[0].Value > 0) and (SqlAux2.Fields[0].Value < 100) then
        begin
          Application.MessageBox(PChar('Aten��o Caixa Qtde Menor 100'+#10+'Favor Verificar com a Listagem'),'ADS',0);
          gerreltokenlido;
          ScrollBox1.SetFocus;
        end
      else if (SqlAux2.fields[0].Value > 100) then
        begin
          Application.MessageBox(PChar('Aten��o Caixa Qtde Maior 100'+#10+'Favor Verificar com a Listagem'),'ADS',0);
          gerreltokenlido;
          ScrollBox1.SetFocus;
        end
      else
        close;
    end;
end;
procedure TFrmExtContaCorrentePoupanca.novolote;
var novolote:string;
  resto:integer;
begin
  with dm do
    begin
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('select max(cg77_numlote) from cga77');
      //where (cg77_tokini >= :toki and cg77_tokfin <= :tokf) ');
      SqlAux2.Open;
      if (SqlAux2.Fields[0].Value = null) or (SqlAux2.Fields[0].Value = '999999') then
        novolote  :=  '000001'
      else
        novolote  := GeraNT(IntToStr(SqlAux2.Fields[0].AsInteger+1),6);
     SqlAux2.Close;
     SqlAux2.Sql.Clear;
     resto:= StrToInt(Edresto.Text);
     resto:= resto+1;
     SqlAux2.Sql.Add('update cga77 set cg77_status = ''1'',cg77_tokfin  = (to_number(cg77_tokini,''999999999'') + (cg77_qtd - 1)-'+IntToStr(resto)+') where (cg77_dtb = '+chr(39)+trim(dtb)+chr(39)+') and (cg77_ag = '+chr(39)+trim(Edremessa2.Text)+chr(39)+') and (cg77_numlote = '+chr(39)+gerant(trim(Ednumlote.Text),6)+chr(39)+')');
//     SqlAux2.Params[0].value  :=  resto;
     //     SqlAux2.Params[0].AsString :=  trim(dtb);
//     SqlAux2.Params[1].AsString :=  GeraNt(trim(ednumlote.Text),6);
//     SqlAux2.Params[2].AsString :=  trim(Edremessa2.Text);
//     inputbox('','',SqlAux2.SQL.Text);
     try
       SqlAux2.ExecSQL;
       if SqlAux2.RowsAffected = 0 then
         begin
           Application.MessageBox(Pchar('N�o Foi Alterado Lote: '+Ednumlote.Text+chr(10)+'Feche esse Lote'+chr(10)+'Informe o Ocorrido ao CPD'),'ADS',MB_OK);
           exit;
         end
       else if SqlAux2.RowsAffected = 1 then
         begin
           SqlAux2.Close;
           SqlAux2.Sql.Clear;
           SqlAux2.Sql.Add('INSERT INTO cga77 ');
           SqlAux2.Sql.Add('VALUES (:dtb, :ag, :qtd, :numlote, :status, :toki, :tokf) ');
           SqlAux2.Params[0].AsString :=  trim(dtb);
           SqlAux2.Params[1].AsString :=  trim(Edremessa2.Text);
           SqlAux2.Params[2].AsString :=  trim(Edresto.Text);
           SqlAux2.Params[3].AsString :=  GeraNt(trim(novolote),6);
           SqlAux2.Params[4].AsString :=  '0';
           SqlAux2.Params[5].AsInteger :=  StrToInt64(EdRemessa.Text);
           SqlAux2.Params[6].AsInteger :=  StrToInt64(copy(trim(EdRemessa.Text), 1, 9)) + (StrToInt64(Edresto.Text) - 1);
           try
             SqlAux2.ExecSQL;
             Ednumlote.text :=  GeraNt(trim(novolote),6);//receber� novo lote
             EdQt.Text      :=  '0';
             qtdaux := strtoint(trim(Edresto.Text));
           except on e: exception do
             begin
               Application.MessageBox(Pchar(e.Message+chr(10)+chr(10)+'Erro para Alterar Lote: '+Ednumlote.Text+chr(10)+'Feche esse Lote'+chr(10)+'Informe o Ocorrido ao CPD'),'ADS',MB_OK);
               exit;
             end;
           end;
         end
       else
         begin
           Application.MessageBox(Pchar('Foi Alterado + de 1 Registro: '+Ednumlote.Text+chr(10)+'Feche esse Lote'+chr(10)+'Informe o Ocorrido ao CPD'),'ADS',MB_OK);
           exit;
         end
     except on e: exception do
       begin
         Application.MessageBox(Pchar(e.Message+chr(10)+chr(10)+'Erro para Alterar Lote: '+Ednumlote.Text+chr(10)+'Feche esse Lote'+chr(10)+'Informe o Ocorrido ao CPD'),'ADS',MB_OK);
         exit;
       end;
     end;
    end;
end;
procedure TFrmExtContaCorrentePoupanca.procreg;
begin
  with dm do
    begin
      Dm.SqlAux1.Close;
      Dm.SqlAux1.Sql.Clear;
      Dm.SqlAux1.Sql.Add('select count(cg68_remes) from cga68 where (cg68_remes = :cg68_remes) and ((select current_date) - cg68_dtbaixa < 7)');
      Dm.SqlAux1.Params[0].AsString := Trim(EdRemessa.Text);
      Dm.SqlAux1.Open;
      total := 0;
      total := Dm.SqlAux1.Fields[0].AsInteger;
      case Dm.SqlAux1.Fields[0].AsInteger of
        0:
          begin
            Dm.SqlAux1.Close;
            Dm.SqlAux1.Sql.Clear;
            Dm.SqlAux1.Sql.Add('insert into cga68 ');
            Dm.SqlAux1.Sql.Add('(cg68_remes,cg68_dup,cg68_dtext,cg68_codbaixa,');
            Dm.SqlAux1.Sql.Add('cg68_caixa,cg68_codusu,cg68_codag,cg68_tipo,cg68_dtbaixa) ');
            Dm.SqlAux1.Sql.Add(' values ');
            Dm.SqlAux1.Sql.Add('(:cg68_remes,:cg68_dup,:cg68_dtext,:cg68_codbaixa,');
            Dm.SqlAux1.Sql.Add(':cg68_caixa,:cg68_codusu,:cg68_codag,:cg68_tipo,(Select current_date)) ');
            Dm.SqlAux1.Params[0].Value := EdRemessa.Text;
            Dm.SqlAux1.Params[1].Value := total + 1;
            case (length(trim(EdRemessa.Text))) of
              34,35:
                begin
                  Dm.SqlAux1.Params[2].Value := Copy(EdRemessa.Text,18,4)+'-'+Copy(EdRemessa.Text,16,2)+'-'+Copy(EdRemessa.Text,14,2);
                  Dm.SqlAux1.Params[7].Value := copy(EdRemessa.Text,22,2);
                end;
              36:
                begin
                  Dm.SqlAux1.Params[2].Value := Copy(EdRemessa.Text,19,4)+'-'+Copy(EdRemessa.Text,17,2)+'-'+Copy(EdRemessa.Text,15,2);
                  Dm.SqlAux1.Params[7].Value := copy(EdRemessa.Text,23,2);
                end;
            end;
            //Dm.SqlAux1.Params[2].Value := Copy(EdRemessa.Text,21,4)+'-'+Copy(EdRemessa.Text,19,2)+'-'+Copy(EdRemessa.Text,17,2);
            Dm.SqlAux1.Params[3].Value := Dm.SqlCga20cg20_codbaixa.Value;
            Dm.SqlAux1.Params[4].Value := EdCaixa.Text;
            Dm.SqlAux1.Params[5].Value := Dm.sqlcga_acessocodigo.AsInteger;
            Dm.SqlAux1.Params[6].Value := Copy(EdRemessa.Text,1,5);
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
          end;
        else
          StBr.Panels[0].Text := 'N�mero de remessas excedidas nessa data';
      end;
    end;
end;
procedure TFrmExtContaCorrentePoupanca.proccadtoken;// Cadastro e Entrada de Token
begin
  with dm do
    begin
      StBr.Panels[0].Text := '';
        if anterior <> Trim(EdRemessa.Text) then
          begin
            anterior  := Trim(EdRemessa.Text);
            EdRemessa.Text  :=  RemCaract(Trim(EdRemessa.Text));
            if Verifica(Trim(EdRemessa.Text)) = 'erro' then
              begin
                StBr.Panels[0].Text := 'N�mero de Token Incorreto';
                EdRemessa.Clear;
                ScrollBox1.SetFocus;
                exit;
              end;
            case length(trim(EdRemessa.Text)) of
              10:
                begin
                  SqlAux1.Close;
                  SqlAux1.Sql.Clear;
                  SqlAux1.Sql.Add('insert into cga76 (cg76_remes,cg76_dtentr,cg76_caixa,cg76_codusu_dig,cg76_codentr) ');
                  SqlAux1.Sql.Add('values (');
                  SqlAux1.Sql.Add(':remes,(select current_date),:cxa,:codusudig,:codentr)');
                  SqlAux1.Params[0].AsString  :=  trim(EdRemessa.Text);
                  SqlAux1.Params[1].AsString  :=  trim(EdCaixa.Text);
                  SqlAux1.Params[2].Value     :=  sqlcga_acessocodigo.Value;
                  SqlAux1.Params[3].AsString  :=  '119';
                  try
                    SqlAux1.ExecSQL;
                    EdRemessa.Clear;
                    EdRemessa.SetFocus;
                    EdQt.Text :=  IntToStr(StrToInt(EdQt.Text)+ 1);
                  except on e: exception do
                    begin
                      StBr.Panels[0].Text := 'Erro: '+e.Message+' Token:'+EdRemessa.Text;
                      EdRemessa.Clear;
                      ScrollBox1.SetFocus;
                      exit;
                    end;

                  end;
                end;
            else
              begin;
                StBr.Panels[0].Text := 'N�mero = Anterior';
                EdRemessa.Clear;
                ScrollBox1.SetFocus;
                exit;
              end;
            end;
          end
        else
          begin
            anterior  :=  EdRemessa.Text;
            EdRemessa.Clear;
            EdRemessa.SetFocus;
          end;
    end;
end;
procedure TFrmExtContaCorrentePoupanca.procpfe001; // Extrato Finasa PFE - 001end.
begin
  with dm do
    begin
      StBr.Panels[0].Text := '';
        if anterior <> Trim(EdRemessa.Text) then
          begin
            anterior  := Trim(EdRemessa.Text);
            if Verifica(Trim(EdRemessa.Text)) = 'erro' then
              begin
                StBr.Panels[0].Text := 'N�mero de Remessa Incorreto'+EdRemessa.Text;
                EdRemessa.Clear;
                ScrollBox1.SetFocus;
                exit;
              end;
            case length(trim(EdRemessa.Text)) of
              34:
                begin
                  SqlAux1.Close;
                  SqlAux1.Sql.Clear;
                  SqlAux1.Sql.Add('insert into cga038 values (');
                  SqlAux1.Sql.Add(':remes,:dtext,(select current_date),(select current_time(0)),:bxa,:cxa,:usu)');
                  SqlAux1.Params[0].Text        :=  trim(EdRemessa.Text);
                  SqlAux1.Params[1].Value       :=  null;
                  SqlAux1.Params[2].Value       :=  SqlCga20cg20_codbaixa.Value;
                  SqlAux1.Params[3].Text        :=  trim(EdCaixa.Text);
                  SqlAux1.Params[4].Value       :=  sqlcga_acessocodigo.Value;
                  try
                    SqlAux1.ExecSQL;
                    EdRemessa.Clear;
                    EdRemessa.SetFocus;
                    EdQt.Text :=  IntToStr(StrToInt(EdQt.Text)+ 1);
                  except on e: exception do
                    begin
                      StBr.Panels[0].Text := 'Erro: '+e.Message+' PFE:'+EdRemessa.Text;
                      EdRemessa.Clear;
                      ScrollBox1.SetFocus;
                      exit;
                    end;
                  end;
                end;
            else
              begin;
                StBr.Panels[0].Text := 'Qtde Digitos Remessa < 34 PFE:'+EdRemessa.Text;
                EdRemessa.Clear;
                ScrollBox1.SetFocus;
                exit;
              end;
            end;
          end
        else
          begin
            StBr.Panels[0].Text := 'Remessa = Anterior: '+EdRemessa.Text;
            EdRemessa.Clear;
            ScrollBox1.SetFocus;
            exit;
          end;
    end;
end;
procedure TFrmExtContaCorrentePoupanca.procbolcli;
begin
  with dm do
    begin
      StBr.Panels[0].Text := '';
        if anterior <> Trim(EdRemessa.Text) then
          begin
            anterior  := Trim(EdRemessa.Text);
            if Verifica(Trim(EdRemessa.Text)) = 'erro' then
              begin
                StBr.Panels[0].Text := 'N� de Remessa Incorreto'+EdRemessa.Text;
                EdRemessa.Clear;
                ScrollBox1.SetFocus;
                exit;
              end;
            if (vernum(Trim(EdRemessa.Text)) = false) then
              begin
                StBr.Panels[0].Text := 'N� de Remessa Inv�lido: '+EdRemessa.Text;
                anterior  :='0';
                EdRemessa.Clear;
                ScrollBox1.SetFocus;
                exit;
              end;
            case length(trim(EdRemessa.Text)) of
              11:
                begin
                  SqlAux1.Close;
                  SqlAux1.Sql.Clear;
//                  SqlAux1.Sql.Add('select count(*) from cga037 where (cg037_dp = :cg037_dp) and (cg037_tiposerv = 17)');
                  SqlAux1.Sql.Add('select count(*) from cga037 where (:cg037_dp between cg037_dpini and cg037_dpfin) and (cg037_tiposerv = 17)limit 1');

                  SqlAux1.Params[0].AsString := trim(copy(EdRemessa.Text,1,4));
                  SqlAux1.Open;
                  if (SqlAux1.Fields[0].AsInteger = 1) then
                    begin
                      SqlAux1.Close;
                      SqlAux1.Sql.Clear;
                      SqlAux1.Sql.Add('insert into cga039 values (');
                      SqlAux1.Sql.Add(':remes,:dtext,(select current_date),(select current_time(0)),:bxa,:cxa,:usu)');
                      SqlAux1.Params[0].Text        :=  trim(EdRemessa.Text);
                      SqlAux1.Params[1].Value       :=  null;
                      SqlAux1.Params[2].Value       :=  SqlCga20cg20_codbaixa.Value;
                      SqlAux1.Params[3].Text        :=  trim(EdCaixa.Text);
                      SqlAux1.Params[4].Value       :=  sqlcga_acessocodigo.Value;
                      try
                        SqlAux1.ExecSQL;
                        EdRemessa.Clear;
                        EdRemessa.SetFocus;
                        EdQt.Text :=  IntToStr(StrToInt(EdQt.Text)+ 1);
                      except on e: exception do
                        begin
                          StBr.Panels[0].Text := 'Erro: '+e.Message+' Boleto-Cli: '+EdRemessa.Text;
                          EdRemessa.Clear;
                          ScrollBox1.SetFocus;
                          exit;
                        end;
                      end;
                    end
                  else
                    begin;
                      StBr.Panels[0].Text := 'C�digo  n�o Cadastrado : '+copy(EdRemessa.Text,1,4)+' Separe-o' ;
                      EdRemessa.Clear;
                      ScrollBox1.SetFocus;
                      exit;
                    end;
                end;
            else
              begin;
                StBr.Panels[0].Text := 'Qtde D�gitos Remessa < 11 Boleto Cli: '+EdRemessa.Text;
                EdRemessa.Clear;
                ScrollBox1.SetFocus;
                exit;
              end;
            end;
          end
        else
          begin
            StBr.Panels[0].Text := 'Remessa = Anterior: '+EdRemessa.Text;
            EdRemessa.Clear;
            ScrollBox1.SetFocus;
            exit;
          end;
    end;
end;
procedure TFrmExtContaCorrentePoupanca.proccrtfin;
begin
  EdRemessa.Text  :=  GeraNT(EdRemessa.Text,7);
  with dm do
    begin
      StBr.Panels[0].Text := '';
        if anterior <> Trim(EdRemessa.Text) then
          begin
            anterior  := Trim(EdRemessa.Text);
            if Verifica(Trim(EdRemessa.Text)) = 'erro' then
              begin
                StBr.Panels[0].Text := 'N� de Remessa Incorreto'+EdRemessa.Text;
                EdRemessa.Clear;
                ScrollBox1.SetFocus;
                exit;
              end;
            if (vernum(Trim(EdRemessa.Text)) = false) then
              begin
                StBr.Panels[0].Text := 'N� de Remessa Incorreto: '+EdRemessa.Text;
                anterior  :='0';
                EdRemessa.Clear;
                ScrollBox1.SetFocus;
                exit;
              end;
            case length(trim(EdRemessa.Text)) of
              07:
                begin
                  SqlAux1.Close;
                  SqlAux1.Sql.Clear;
                  SqlAux1.Sql.Add('select count(cg040_remes) from cga040 where (cg040_remes = :remes) and (cg040_dtbaixa > (select current_date-7))');
                  SqlAux1.Params[0].AsString := trim(EdRemessa.Text);
                  SqlAux1.Open;
                  if (SqlAux1.Fields[0].AsInteger = 0) then
                    begin
                      SqlAux1.Close;
                      SqlAux1.Sql.Clear;
                      SqlAux1.Sql.Add('insert into cga040 values (');
                      SqlAux1.Sql.Add(':remes,(select current_date),(select current_time(0)),:bxa,:cxa,:usu)');
                      SqlAux1.Params[0].Text        :=  trim(EdRemessa.Text);
                      SqlAux1.Params[1].Value       :=  SqlCga20cg20_codbaixa.Value;
                      SqlAux1.Params[2].Text        :=  trim(EdCaixa.Text);
                      SqlAux1.Params[3].Value       :=  sqlcga_acessocodigo.Value;
                      try
                        SqlAux1.ExecSQL;
                        EdRemessa.Clear;
                        EdRemessa.SetFocus;
                        EdQt.Text :=  IntToStr(StrToInt(EdQt.Text)+ 1);
                      except on e: exception do
                        begin
                          StBr.Panels[0].Text := 'Erro: '+e.Message+' Boleto-Cli: '+EdRemessa.Text;
                          EdRemessa.Clear;
                          ScrollBox1.SetFocus;
                          exit;
                        end;
                      end;
                    end
                  else
                    begin;
                      EdRemessa.Clear;
                      EdRemessa.SetFocus;
                      exit;
                    end;
                end;
            else
              begin;
                StBr.Panels[0].Text := 'Qtde D�gitos Remessa < 07 Carta Finasa: '+EdRemessa.Text;
                EdRemessa.Clear;
                ScrollBox1.SetFocus;
                exit;
              end;
            end;
          end
        else
          begin
            StBr.Panels[0].Text := 'Remessa = Anterior: '+EdRemessa.Text;
            EdRemessa.Clear;
            ScrollBox1.SetFocus;
            exit;
          end;
    end;
end;
procedure TFrmExtContaCorrentePoupanca.procdrcprv;
begin
  with dm do
    begin
      if anterior <> EdRemessa.Text then
        begin
          anterior := EdRemessa.Text;
          if Verifica(Trim(EdRemessa.Text)) = 'erro' then
            begin
              StBr.Panels[0].Text := 'N� de Remessa Incorreto'+EdRemessa.Text;
              EdRemessa.Clear;
              ScrollBox1.SetFocus;
              exit;
            end;
          if (vernum(Trim(EdRemessa.Text)) = false) then
            begin
              StBr.Panels[0].Text := 'N� de Remessa Incorreto: '+EdRemessa.Text;
              anterior  :='0';
              EdRemessa.Clear;
              ScrollBox1.SetFocus;
              exit;
            end;
          if (Length(trim(EdRemessa.Text)) = 11) Then
            begin
              if (copy(EdRemessa.Text,1,3) <> '000') then
                begin
                  SqlAux1.Close;
                  SqlAux1.Sql.Clear;
//                  SqlAux1.Sql.Add('select count(cg037_dp) from cga037 where (cg037_dp = :cg037_dp) and (cg037_tiposerv = 18) limit 1');
                  SqlAux1.Sql.Add('select count(*) from cga037 where (:cg037_dp between cg037_dpini and cg037_dpfin) and (cg037_tiposerv = 18) limit 1');
                  SqlAux1.Params[0].AsString := trim(copy(EdRemessa.Text,1,4));
                  SqlAux1.Open;
                  if (SqlAux1.Fields[0].AsInteger = 1) then
                    begin
                      SqlAux1.Close;
                      SqlAux1.Sql.Clear;
                      SqlAux1.Sql.Add('insert into cga041 (');
                      SqlAux1.Sql.Add('cg041_remes,cg041_dtbaixa,cg041_hrbaixa,cg041_codbaixa,');
                      SqlAux1.Sql.Add('cg041_caixa,cg041_codusu)');
                      SqlAux1.Sql.Add(' values ');
                      SqlAux1.Sql.Add('(:remes,(select current_date),(select current_time(0)),:codbaixa,');
                      SqlAux1.Sql.Add(':caixa,:codusu)');
                      SqlAux1.Params[0].Value := EdRemessa.Text;
                      SqlAux1.Params[1].Value := SqlCga20cg20_codbaixa.Value;
                      SqlAux1.Params[2].Value := EdCaixa.Text;
                      SqlAux1.Params[3].Value := sqlcga_acessocodigo.AsInteger;
                      try
                        SqlAux1.ExecSql;
                        StBr.Panels[0].Text := '';
                        EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                      except on e: exception do
                        begin
                          application.MessageBox(PChar(e.Message),'Ads',MB_OK+MB_ICONERROR);
                          EdRemessa.Clear;
                          EdRemessa.SetFocus;
                          exit;
                        end;
                      End;
                    end
                  else
                    StBr.Panels[0].Text := 'N�o H� C�digo Cadastrado: '+copy(EdRemessa.Text,1,4)+' Separe-os';
                end
              else
                StBr.Panels[0].Text := 'C�digo fora de padr�o.Separe-o.';
            end
          else
            StBr.Panels[0].Text := 'C�digo fora de padr�o.Separe-o.';
        end
      else
        StBr.Panels[0].Text := 'Mesmo C�digo.';
    end;
  EdRemessa.Clear;
  EdRemessa.SetFocus;
end;
procedure TFrmExtContaCorrentePoupanca.drccrtfatu;
begin
  with dm do
    begin
      if anterior <> EdRemessa.Text then
        begin
          anterior := EdRemessa.Text;
          if Verifica(Trim(EdRemessa.Text)) = 'erro' then
            begin
              StBr.Panels[0].Text := 'N� de Remessa Incorreto'+EdRemessa.Text;
              EdRemessa.Clear;
              ScrollBox1.SetFocus;
              exit;
            end;
          if (vernum(Trim(EdRemessa.Text)) = false) then
            begin
              StBr.Panels[0].Text := 'N� de Remessa Incorreto: '+EdRemessa.Text;
              anterior  :='0';
              EdRemessa.Clear;
              ScrollBox1.SetFocus;
              exit;
            end;
          if (Length(trim(EdRemessa.Text)) = 11) Then
            begin
              if (copy(EdRemessa.Text,1,3) <> '000') then
                begin
                  SqlAux1.Close;
                  SqlAux1.Sql.Clear;
                  SqlAux1.Sql.Add('select count(*) from cga037 where (:cg037_dp between cg037_dpini and cg037_dpfin) and (cg037_tiposerv = 19) limit 1');
                  SqlAux1.Params[0].AsString := trim(copy(EdRemessa.Text,1,4));
                  SqlAux1.Open;
                  if (SqlAux1.Fields[0].AsInteger = 1) then
                    begin
                      SqlAux1.Close;
                      SqlAux1.Sql.Clear;
                      SqlAux1.Sql.Add('insert into cga042 (');
                      SqlAux1.Sql.Add('cg042_remes,cg042_codbaixa,cg042_caixa,cg042_codusu)');
                      SqlAux1.Sql.Add(' values ');
                      SqlAux1.Sql.Add('(:remes,:codbaixa,:caixa,:codusu)');
                      SqlAux1.Params[0].Value := EdRemessa.Text;
                      SqlAux1.Params[1].Value := SqlCga20cg20_codbaixa.Value;
                      SqlAux1.Params[2].Value := EdCaixa.Text;
                      SqlAux1.Params[3].Value := sqlcga_acessocodigo.AsInteger;
                      try
                        SqlAux1.ExecSql;
                        StBr.Panels[0].Text := '';
                        EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                      except on e: exception do
                        begin
                          application.MessageBox(PChar(e.Message),'Ads',MB_OK+MB_ICONERROR);
                          EdRemessa.Clear;
                          EdRemessa.SetFocus;
                          exit;
                        end;
                      End;
                    end
                  else
                    StBr.Panels[0].Text := 'N�o H� C�digo Cadastrado: '+copy(EdRemessa.Text,1,4)+' Separe-os';
                end
              else
                StBr.Panels[0].Text := 'C�digo fora de padr�o.Separe-os.';
            end
          else
            StBr.Panels[0].Text := 'C�digo fora de padr�o.Separe-os.';
        end
      else
        StBr.Panels[0].Text := 'Mesmo C�digo.';
    end;
  EdRemessa.Clear;
  EdRemessa.SetFocus;
end;
procedure TFrmExtContaCorrentePoupanca.drczogmcsi;
begin
  with dm do
    begin
      if anterior <> EdRemessa.Text then
        begin
          anterior := EdRemessa.Text;
          if Verifica(Trim(EdRemessa.Text)) = 'erro' then
            begin
              StBr.Panels[0].Text := 'N� de Remessa Incorreto'+EdRemessa.Text;
              EdRemessa.Clear;
              ScrollBox1.SetFocus;
              exit;
            end;
          if (vernum(Trim(EdRemessa.Text)) = false) then
            begin
              StBr.Panels[0].Text := 'N� de Remessa Incorreto: '+EdRemessa.Text;
              anterior  :='0';
              EdRemessa.Clear;
              ScrollBox1.SetFocus;
              exit;
            end;
          if (Length(trim(EdRemessa.Text)) = 11) Then
            begin
              if (copy(EdRemessa.Text,1,3) <> '000') then
                begin
                  SqlAux1.Close;
                  SqlAux1.Sql.Clear;
                  SqlAux1.Sql.Add('select count(*) from cga037 where (:cg037_dp between cg037_dpini and cg037_dpfin) and (cg037_tiposerv = 20) limit 1');
                  SqlAux1.Params[0].AsString := trim(copy(EdRemessa.Text,1,4));
                  SqlAux1.Open;
                  if (SqlAux1.Fields[0].AsInteger = 1) then
                    begin
                      SqlAux1.Close;
                      SqlAux1.Sql.Clear;
                      SqlAux1.Sql.Add('insert into cga043 (');
                      SqlAux1.Sql.Add('cg043_remes,cg043_codbaixa,cg043_caixa,cg043_codusu)');
                      SqlAux1.Sql.Add(' values ');
                      SqlAux1.Sql.Add('(:remes,:codbaixa,:caixa,:codusu)');
                      SqlAux1.Params[0].Value := EdRemessa.Text;
                      SqlAux1.Params[1].Value := SqlCga20cg20_codbaixa.Value;
                      SqlAux1.Params[2].Value := EdCaixa.Text;
                      SqlAux1.Params[3].Value := sqlcga_acessocodigo.AsInteger;
                      try
                        SqlAux1.ExecSql;
                        StBr.Panels[0].Text := '';
                        EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                      except on e: exception do
                        begin
                          application.MessageBox(PChar(e.Message),'Ads',MB_OK+MB_ICONERROR);
                          EdRemessa.Clear;
                          EdRemessa.SetFocus;
                          exit;
                        end;
                      End;
                    end
                  else
                    StBr.Panels[0].Text := 'N�o H� C�digo Cadastrado: '+copy(EdRemessa.Text,1,4)+' Separe-os';
                end
              else
                StBr.Panels[0].Text := 'C�digo fora de padr�o.Separe-os.';
            end
          else
            StBr.Panels[0].Text := 'C�digo fora de padr�o.Separe-os.';
        end
      else
        StBr.Panels[0].Text := 'Mesmo C�digo.';
    end;
  EdRemessa.Clear;
  EdRemessa.SetFocus;

end;
procedure TFrmExtContaCorrentePoupanca.drccrtamex;
begin
  with dm do
    begin
      if anterior <> EdRemessa.Text then
        begin
          anterior := EdRemessa.Text;
          if Verifica(Trim(EdRemessa.Text)) = 'erro' then
            begin
              StBr.Panels[0].Text := 'N� de Remessa Incorreto'+EdRemessa.Text;
              EdRemessa.Clear;
              ScrollBox1.SetFocus;
              exit;
            end;
          if (vernum(Trim(EdRemessa.Text)) = false) then
            begin
              StBr.Panels[0].Text := 'N� de Remessa Incorreto: '+EdRemessa.Text;
              anterior  :='0';
              EdRemessa.Clear;
              ScrollBox1.SetFocus;
              exit;
            end;
          if (Length(trim(EdRemessa.Text)) = 11) Then
            begin
              if (copy(EdRemessa.Text,1,3) <> '000') then
                begin
                  SqlAux1.Close;
                  SqlAux1.Sql.Clear;
                  SqlAux1.Sql.Add('select count(*) from cga037 where (:cg037_dp between cg037_dpini and cg037_dpfin) and (cg037_tiposerv = 21) limit 1');
                  SqlAux1.Params[0].AsString := trim(copy(EdRemessa.Text,1,4));
                  SqlAux1.Open;
                  if (SqlAux1.Fields[0].AsInteger = 1) then
                    begin
                      SqlAux1.Close;
                      SqlAux1.Sql.Clear;
                      SqlAux1.Sql.Add('insert into cga044 (');
                      SqlAux1.Sql.Add('cg044_remes,cg044_codbaixa,cg044_caixa,cg044_codusu)');
                      SqlAux1.Sql.Add(' values ');
                      SqlAux1.Sql.Add('(:remes,:codbaixa,:caixa,:codusu)');
                      SqlAux1.Params[0].Value := EdRemessa.Text;
                      SqlAux1.Params[1].Value := SqlCga20cg20_codbaixa.Value;
                      SqlAux1.Params[2].Value := EdCaixa.Text;
                      SqlAux1.Params[3].Value := sqlcga_acessocodigo.AsInteger;
                      try
                        SqlAux1.ExecSql;
                        StBr.Panels[0].Text := '';
                        EdQt.Text := inttostr(1+StrToInt(EdQt.Text));
                      except on e: exception do
                        begin
                          application.MessageBox(PChar(e.Message),'Ads',MB_OK+MB_ICONERROR);
                          EdRemessa.Clear;
                          EdRemessa.SetFocus;
                          exit;
                        end;
                      End;
                    end
                  else
                    StBr.Panels[0].Text := 'N�o H� C�digo Cadastrado: '+copy(EdRemessa.Text,1,4)+' Separe-os';
                end
              else
                StBr.Panels[0].Text := 'C�digo fora de padr�o.Separe-os.';
            end
          else
            StBr.Panels[0].Text := 'C�digo fora de padr�o.Separe-os.';
        end
      else
        StBr.Panels[0].Text := 'Mesmo C�digo.';
    end;
  EdRemessa.Clear;
  EdRemessa.SetFocus;

end;

procedure TFrmExtContaCorrentePoupanca.procdrcs;
begin
  with Dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('select cg037_tiposerv from cga037 where (:cg037_dp between cg037_dpini and cg037_dpfin) limit 1');
      SqlAux1.Params[0].AsString := trim(copy(EdRemessa.Text,1,4));
      SqlAux1.Open;
      case SqlAux1.Fields[0]
      .AsInteger of
        3 : procextratodrc;
        17: procbolcli;
        18: procdrcprv;
        19: drccrtfatu;
        20: drczogmcsi;
        21: drccrtamex;
      else
        StBr.Panels[0].Text := 'Servi�o N�o Cadastrado: '+copy(EdRemessa.Text,1,4);
      end;
  end;

end;
end.
