unit U_RetornoExtratos;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask;

type
  TFrmRetornoExtratos = class(TForm)
    LabelTotal: TLabel;
    LabelGravados: TLabel;
    LabelLidos: TLabel;
    LabelErros: TLabel;
    GroupBoxPeridoCarga: TGroupBox;
    LabelDtIni: TLabel;
    LabelDtFin: TLabel;
    DtPickerDtIni: TDateTimePicker;
    DtPickerDtFin: TDateTimePicker;
    LCDTot: TStaticText;
    LCDLidos: TStaticText;
    LCDGrav: TStaticText;
    LCDErros: TStaticText;
    EdNumeroSeparador: TEdit;
    ChkGerarSeparado: TCheckBox;
    ChkSepCodigoLeitura: TCheckBox;
    PbProgresso: TProgressBar;
    PBConsistencia: TProgressBar;
    BtnFechar: TBitBtn;
    BtnGerar: TBitBtn;
    LabelProcessados: TLabel;
    Label1: TLabel;
    LabelLCDArquivo: TLabel;
    StsRemSdx: TStatusBar;
    LabelCaminho: TLabel;
    EdNomeArquivo: TEdit;
    EdCaminho: TEdit;
    procedure BtnFecharClick(Sender: TObject);
    procedure Verifica(Str: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnGerarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChkGerarSeparadoClick(Sender: TObject);
    procedure seldrccrt;
    procedure selcrtseg;
    procedure selcodetq;
    procedure seltokens;
    procedure selcadetq;
    procedure selfatcardcred;
    procedure seldrccllp;
    procedure selconsorcio;
    procedure selcrtsenha;
    procedure selfinasafpe; // Baixa Extrato Finasa FPE
    procedure selfinasacli; // Baixa Boleto Finasa CLI
    procedure selfinasacrt; //
    procedure seldrcprvlbl; // DRC Private Label
    procedure seldrccrtfat; // DRC - Cartao Fatura
    procedure seldrczogmcsi; // DRC Zogbi MCSI
    procedure seldrcbolamex; // DRC Boleto Amex

  private
    caracterinvalido,Corrompido : boolean;
    sim:boolean;
    arquivo: TextFile;
    linha, linaux, destdir, fname : string;
    sel : string;
    ctareg, seq : Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRetornoExtratos: TFrmRetornoExtratos;

implementation

uses DmDados, DB, U_Func, ZDataset, ZAbstractRODataset;

{$R *.dfm}

procedure  TFrmRetornoExtratos.Verifica(Str: string);
Const Num = '0123456789';
const alpha = 'ABCDEFGHIJKLMNOPQRSTUVXZWYabcdefghijklmnopqrstuvxzwy';
Var
  X: Integer;
Begin
  caracterinvalido := false;
  str:=trim(str);
  sim:=false;
  if (length(str) = 24) or (length(str) = 13) or (length(str) = 20) or
     (length(str) = 31) or (length(str) = 36) then
    begin
      For x:= 1 To Length(Str) do
        Begin
          If Pos(Str[X],Num) = 0 Then
            Begin
              Corrompido := true;
              ShowMessage('Caracter Inv�lido');
              caracterinvalido := true;
            End;
        End;
    end
  else
    begin
      For x:= 1 To Length(Str) do
        Begin
        { Aqui o programa verifica se o c�digo tem 13 ou 12 digitos
        e , se chegou ao final em algum deles, confere se termina com
        alguma letra. Modifiquei essa parte logicamente, invertendo
        a ordem dos IF's.
        }


              if ((x = 12) and ((Length(Str)=14))) or ((x = 13) and ((Length(Str)=15))) then
                begin
                  If (Pos(Str[X],alpha) = 0) and (Pos(Str[X],Num) = 0) Then
                    Begin
                        Corrompido := true;
                        ShowMessage('Caracter Inv�lido');
                        caracterinvalido := true;
                      End
                    end
                  else
                      begin
                      { Adicionei esse if logo abaixo pois agora, o programa poder� ler c�digos
                      com 13 digitos e tra�o no decimo segundo n�mero. Ele verifica se o c�digo
                      realmente faz parte do Retorno de Extratos (DRC - Cobran�as) e se
                      est� fazendo a leitura o 12 digito }
                        if (x = 12) and (FrmRetornoExtratos.Tag=3) and (Length(Str)=15) then
                            begin
                              if Pos(Str[12],'-') = 0 then
                                begin
                                  Corrompido := true;
                                  ShowMessage('Caracter Inv�lido');
                                  caracterinvalido := true;
                                end;
                            end
                          else if Pos(Str[X],Num) = 0 Then
                            begin
                              Corrompido := true;
                              ShowMessage('Caracter Inv�lido');
                              caracterinvalido := true;
                            end;
                      end;
        end;
    end;
End;

procedure TFrmRetornoExtratos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := cafree;
end;

procedure TFrmRetornoExtratos.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmRetornoExtratos.BtnGerarClick(Sender: TObject);
var
  i : integer;
  linhabase : string;
begin
  LCDTot.Caption   := '0';
  LCDLidos.Caption := '0';
  LCDGrav.Caption  := '0';
  LCDErros.Caption := '0';
  PbProgresso.Position := 0;
  PBConsistencia.Position := 0;
  BtnGerar.Enabled := false;
  EdNomeArquivo.Text := '';
  EdCaminho.Text := '';
  case tag of
    1: // Consolidado
      begin
        Dm.SqlAux1.Close;
        Dm.SqlAux1.Sql.Clear;
        Dm.SqlAux1.Sql.Add('SELECT DISTINCT a.cg75_remes, ' +
          'b.cg20_codbrad, a.cg75_tipo, a.cg75_dv, a.cg75_codag, ' +
          'a.cg75_conta, a.cg75_dtbaixa ');
        Dm.SqlAux1.Sql.Add('FROM cga75 a ');
        Dm.SqlAux1.Sql.Add('INNER JOIN cga20 b on a.cg75_codbaixa = b.cg20_codbaixa ');
        Dm.SqlAux1.Sql.Add('WHERE a.cg75_dtbaixa BETWEEN :dtini AND :dtfin ');

        Dm.SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
        Dm.SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

        if application.MessageBox('Deseja que sejam reenviados registros?',
          'ADS',
          MB_YESNO + MB_ICONQUESTION) = IDNO then
            Dm.SqlAux1.Sql.Add(' AND a.cg75_dtret IS NULL')
        else
          begin
            sim := true;
            Dm.SqlAux1.Sql.Add(' AND a.cg75_dtret IS NOT NULL ');
          end;

        Dm.SqlAux1.Open;
        LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);

        case Dm.SqlAux1.RecordCount of
          0: application.MessageBox('N�o foi encontrado nenhum registro',
            'ADS', MB_OK + MB_ICONINFORMATION);
          else
            begin
              Dm.SqlAux1.First;
              PbProgresso.Max := Dm.SqlAux1.RecordCount;
              try
                // Diret�rio onde colocar arquivos gerados
                destdir := GetCurrentDir + '\retorno\consolidado\' +
                      UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';

                if (not DirectoryExists(destdir))
                  AND (not SysUtils.ForceDirectories(destdir)) then
                    raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);

                fname := 'RT_4237.0' + formatdatetime('dd', date);

                // Garantindo que n�o existe arquivo com a nomenclatura passada
                seq := 0;
                while FileExists(destdir + fname) do
                  begin
                   seq := seq + 1;
                   fname := 'RT_4237.0' + formatdatetime('dd', date) + '_' +
                     IntToStr(seq);
                  end;

                AssignFile(arquivo, destdir + fname);
                Rewrite(arquivo);
             
                While not Dm.SqlAux1.Eof do
                  begin
                    linha := LPad(Dm.SqlAux1.FieldByName('cg75_codag').AsString, 4, '0');
                    linha := linha + copy(Dm.SqlAux1.FieldByName('cg75_dv').AsString, 1, 1);
                    linha := linha + LPad(Dm.SqlAux1.FieldByName('cg75_conta').AsString, 8, '0');
                    linha := linha + FormatDateTime('ddmmyyyy',(Dm.SqlAux1.FieldByName('cg75_dtbaixa').AsDateTime));
                    linha := linha + LPad(Dm.SqlAux1.FieldByName('cg75_tipo').AsString, 2, '0');
                    linha := linha + LPad(Dm.SqlAux1.FieldByName('cg20_codbrad').AsString, 2, '0');
                    linha := linha + LPad('0', 5, '0');
                    case length(linha) of
                      30:
                        begin
                          Verifica(linha);
                          if Corrompido = false then
                            begin
                              Writeln(arquivo, linha);
                              LCDGrav.Caption := inttostr(1 + strtoint(LCDGrav.Caption));
                            end;
                        end;
                      else
                        begin
                          LCDErros.Caption := inttostr(1 + strtoint(LCDErros.Caption));
                        end;
                    end;
                    Dm.SqlAux1.Next;
                    LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
                    PbProgresso.Position := PbProgresso.Position + 1;
                  end;
                Dm.SqlAux1.Close;
                Dm.SqlAux1.Sql.Clear;
                Dm.SqlAux1.Sql.Add('UPDATE cga75 SET cg75_dtret = :dtret ');
                Dm.SqlAux1.ParamByName('dtret').AsDate := Date;
                if sim = false then
                  dm.SqlAux1.Sql.Add(', cg75_dtenv = :dtenv ');
                Dm.SqlAux1.ParamByName('dtenv').AsDate := Date;
                Dm.SqlAux1.Sql.Add('WHERE cg75_dtbaixa BETWEEN :dtini AND :dtfin ');
                Dm.SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
                Dm.SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
                Dm.SqlAux1.ExecSql;
                Dm.SqlAux1.Close;
                CloseFile(arquivo);
                Application.MessageBox('Arquivo de Retorno Gerado com sucesso!', 
                  'ADS', MB_OK+MB_ICONINFORMATION);
                BtnGerar.Enabled := true;
          
                EdNomeArquivo.Text := fname;
                EdCaminho.Text := destdir;

              except on E: Exception do
                Begin
                  Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                      'de Registros de Retorno Consolidado.' + #13+#10 +
                      'Por favor informe o ocorrido para a �rea de T.I..'),
                    'ADS', MB_OK + MB_ICONERROR);
                  CloseFile(arquivo);
                end;
              end;
            end;
        end;
      end;

    2: // extrato velho
      begin
        Dm.SqlAux1.Close;
        Dm.SqlAux1.Sql.Clear;
        Dm.SqlAux1.Sql.Add('SELECT cga33.cg33_remes, cga20.cg20_codbrad, cg33_dtext ');
        Dm.SqlAux1.Sql.Add('FROM cga33 ');
        Dm.SqlAux1.Sql.Add('  INNER JOIN cga20 on cga20.cg20_codbaixa = cga33.cg33_codbaixa ');
        Dm.SqlAux1.Sql.Add('WHERE cg33_dtbaixa BETWEEN :dtini AND :dtfin ');
        Dm.SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
        Dm.SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

        if application.MessageBox('Deseja que sejam reenviados registros?',
            'ADS', MB_YESNO + MB_ICONQUESTION) = IDNO then
          Dm.SqlAux1.Sql.Add(' AND cg33_dtret IS NULL ')
        else
          Dm.SqlAux1.Sql.Add(' and cg33_dtret IS NOT NULL');

        Dm.SqlAux1.Open;
        LCDTot.Caption := IntToStr(Dm.SqlAux1.RecordCount);
        case Dm.SqlAux1.RecordCount of
          0: application.MessageBox('N�o foi encontrado nenhum registro',
              'Ads', MB_OK + MB_ICONINFORMATION);
        else
          begin
            Dm.SqlAux1.First;
            PbProgresso.Max := Dm.SqlAux1.RecordCount;
            try
              // Diret�rio onde colocar arquivos gerados
              destdir := GetCurrentDir + '\retorno\CCP\' +
                      UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';

              if (not DirectoryExists(destdir))
                  AND (not SysUtils.ForceDirectories(destdir)) then
                raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);

              fname := 'rt_3237.0' + formatdatetime('dd', date);

              // Garantindo que n�o existe arquivo com a nomenclatura passada
              seq := 0;
              while FileExists(destdir + fname) do
                begin
                  seq := seq + 1;
                  fname := 'rt_3237.0' + formatdatetime('dd', date) + '_' +
                     IntToStr(seq);
                end;

              AssignFile(arquivo, destdir + fname);
              Rewrite(arquivo);
              while not Dm.SqlAux1.Eof  do
                begin
                  linha := LPad(dm.SqlAux1.FieldByName('cg33_remes').AsString, 14, '0');
                  linha := linha + FormatDateTime('ddmmyyyy', dm.SqlAux1.FieldByName('cg33_dtext').AsDateTime);
                  linha := linha + RPad(dm.SqlAux1.FieldByName('cg20_codbrad').AsString, 8, ' ');
                  if length(linha) = 30 then
                    begin
                      Verifica(linha);
                      if Corrompido = false then
                        begin
                          Writeln(arquivo, linha);
                          LCDGrav.Caption := inttostr(1 + strtoint(LCDGrav.Caption));
                        end;
                    end
                  else
                    // corrompido
                    LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));

                  Dm.SqlAux1.Next;
                  LCDLidos.Caption := inttostr(1 + strtoint(LCDLidos.Caption));
                  PbProgresso.Position := PbProgresso.Position + 1;
                end;

              Dm.SqlAux1.Close;
              Dm.SqlAux1.Sql.Clear;
              Dm.SqlAux1.Sql.Add('UPDATE cga33 SET cg33_dtret = :dtret ');
              Dm.SqlAux1.ParamByName('dtret').AsDate := Date;
              Dm.SqlAux1.Sql.Add('WHERE cg33_dtbaixa BETWEEN :dtini AND :dtfin ');
              Dm.SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
              Dm.SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
              Dm.SqlAux1.ExecSql;

              Dm.SqlAux1.Close;
              CloseFile(arquivo);
              Application.MessageBox('Arquivo de Retorno Gerado com sucesso!',
                  'ADS', MB_OK+MB_ICONINFORMATION);
                BtnGerar.Enabled := true;

              EdNomeArquivo.Text := fname;
              EdCaminho.Text := destdir;

            except on E: Exception do
              Begin
                Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                      'de Registros de Retorno.' + #13+#10 +
                      'Por favor informe o ocorrido para a �rea de T.I..'),
                    'ADS', MB_OK + MB_ICONERROR);
                CloseFile(arquivo);
              end;
            end;
          end;
        end;
      end;

    3:  ///drc cobran�a
      begin
        Dm.SqlAux1.Close;
        Dm.SqlAux1.Sql.Clear;
        Dm.SqlAux1.Sql.Add('SELECT cga100.cg100_remes, cga20.cg20_codbrad_drc ');
        Dm.SqlAux1.Sql.Add('FROM cga100 ');
        Dm.SqlAux1.Sql.Add('  INNER JOIN cga20 on cga20.cg20_codbaixa = cga100.cg100_codbaixa ');
        Dm.SqlAux1.Sql.Add('WHERE cg100_dtbaixa BETWEEN :dtini AND :dtfin ');
        Dm.SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
        Dm.SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
        Dm.SqlAux1.Sql.Add('  AND cg100_dtret is null');
        Dm.SqlAux1.Sql.Add('ORDER BY cg100_remes');
        Dm.SqlAux1.Open;
        LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
        case Dm.SqlAux1.RecordCount of
          0: application.MessageBox('N�o foi encontrado nenhum registro',
              'ADS', MB_OK + MB_ICONINFORMATION);
          else
            begin
              PbProgresso.Max := Dm.SqlAux1.RecordCount;
              Dm.SqlAux1.Open;
              Dm.SqlAux1.First;
              try
                // Diret�rio onde colocar arquivos gerados
                destdir := GetCurrentDir + '\retorno\DRC\' +
                      UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';

                if (not DirectoryExists(destdir))
                      AND (not SysUtils.ForceDirectories(destdir)) then
                  raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);

                fname := 'rt_5237-4120.0' + formatdatetime('dd', date);

                // Garantindo que n�o existe arquivo com a nomenclatura passada
                seq := 0;
                while FileExists(destdir + fname) do
                  begin
                    seq := seq + 1;
                    fname := 'rt_5237-4120.0' + formatdatetime('dd', date) + '_' +
                       IntToStr(seq);
                  end;

                AssignFile(arquivo, destdir + fname);
                Rewrite(arquivo);
                while not Dm.SqlAux1.Eof  do
                  begin
                    linha := Trim(dm.SqlAux1.FieldByName('cg100_remes').AsString);
                    if (Length(linha) in [11..13,18]) then
                      begin
                        Verifica(linha);
                        if Corrompido = false then
                          begin
                            linha := linha + LPad(dm.SqlAux1.FieldByName('cg20_codbrad_drc').AsString, 2, '0');
                            Writeln(arquivo, linha);
                            LCDGrav.Caption := inttostr(1 + strtoint(LCDGrav.Caption));
                          end;
                      end
                    else
                      LCDErros.Caption := inttostr(1 + strtoint(LCDErros.Caption));

                    Dm.SqlAux1.Next;
                    LCDLidos.Caption := inttostr(1 + strtoint(LCDLidos.Caption));
                    PbProgresso.Position := PbProgresso.Position + 1;
                  end;

                Dm.SqlAux1.Close;
                CloseFile(arquivo);
                Application.MessageBox('Arquivo de Retorno Gerado com sucesso!',
                      'ADS', MB_OK + MB_ICONINFORMATION);
                BtnGerar.Enabled := true;
                EdNomeArquivo.Text := fname;
                EdCaminho.Text := destdir;

              except on E: Exception do
                Begin
                  Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                          'de Registros de Retorno.' + #13+#10 +
                          'Por favor informe o ocorrido para a �rea de T.I..'),
                      'ADS', MB_OK + MB_ICONERROR);
                  CloseFile(arquivo);
                  Exit;
                end;
              end; // end try
            end;
        end; // case
      end; // case

    4: // Unificado
      begin
        ctareg := 0;
        Dm.SqlAux1.Close;
        Dm.SqlAux1.Sql.Clear;
        Dm.SqlAux1.Sql.Add('SELECT DISTINCT cga68.cg68_remes, cga20.cg20_codbrad ');
        Dm.SqlAux1.Sql.Add('FROM cga68 ');
        Dm.SqlAux1.Sql.Add('  INNER JOIN cga20 on cga20.cg20_codbaixa = cga68.cg68_codbaixa ');
        Dm.SqlAux1.Sql.Add('WHERE cg68_dtbaixa BETWEEN :dtini AND :dtfin ');
        Dm.SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
        Dm.SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

        if application.MessageBox('Deseja que sejam reenviados registros?',
              'Ads',MB_YESNO+MB_ICONQUESTION) = idno then
            Dm.SqlAux1.Sql.Add('  AND cg68_dtret is null ')
        else
          begin
            sim := true;
            Dm.SqlAux1.Sql.Add('  AND cg68_dtret IS NOT NULL ');
          end;

        Dm.SqlAux1.Open;
        LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
        if Dm.SqlAux1.RecordCount > 0 then
          begin
            Dm.SqlAux1.First;
            PbProgresso.Max := Dm.SqlAux1.RecordCount;
            try
              // Diret�rio onde colocar arquivos gerados
              destdir := GetCurrentDir + '\retorno\unificado\' +
                      UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';

              if (not DirectoryExists(destdir))
                      AND (not SysUtils.ForceDirectories(destdir)) then
                  raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);

              fname := 'RT_4237.0' + formatdatetime('dd', date);
              // Garantindo que n�o existe arquivo com a nomenclatura passada
              seq := 0;
              while FileExists(destdir + fname) do
                begin
                  seq := seq + 1;
                  fname := 'RT_4237.0' + formatdatetime('dd', date) + '_' +
                       IntToStr(seq);
                end;

              AssignFile(arquivo, destdir + fname);
              Rewrite(arquivo);
              linha := format('%-31.31s%',['@0000058720731000191']);
              Writeln(arquivo, linha);
              While not Dm.SqlAux1.Eof  do
                begin
                  linaux := trim(Dm.SqlAux1.FieldByName('cg68_remes').AsString);
                  case length(linaux) of
                    30,34,35:
                      begin
                        linha := copy(linaux, 1, 23);
                        linha := linha + LPad(Dm.SqlAux1.FieldByName('cg20_codbrad').AsString, 2, '0');
                        linha := linha + copy(linaux, 24, 6);
                        Verifica(linha);
                        if Corrompido = false then
                          begin
                            Writeln(arquivo, linha);
                            LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                          end;
                      end;
                    36: Inc(ctareg, 1);//
                      else
                        LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                  end; // case

                  Dm.SqlAux1.Next;
                  LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
                  PbProgresso.Position := PbProgresso.Position + 1;
                end; // while

              CloseFile(arquivo); // Fechando o arquivo rt_4237.0
              EdNomeArquivo.Text := fname;
              EdCaminho.Text := destdir;

              if ctareg > 0 then
                begin
                  Dm.SqlAux1.First;
                  fname := 'RT_4237.2' + formatdatetime('dd', date);
                  PBConsistencia.Max := Dm.SqlAux1.RecordCount;
                  // Garantindo que n�o existe arquivo com a nomenclatura passada
                  seq := 0;
                  while FileExists(destdir + fname) do
                    begin
                      seq := seq + 1;
                      fname := 'RT_4237.2' + formatdatetime('dd', date) + '_' +
                            IntToStr(seq);
                    end;

                  AssignFile(arquivo, destdir + fname);
                  Rewrite(arquivo);
                  linha := format('%-31.31s%',['00000058720731000191']);
                  Writeln(arquivo, linha);
                  While not Dm.SqlAux1.Eof  Do
                    Begin
                      linaux  :=  trim(Dm.SqlAux1.FieldByName('cg68_remes').AsString);
                      case length(linaux) of
                        36:
                          begin
                            linha := copy(linaux, 1, 24);
                            linha := linha + LPad(Dm.SqlAux1.FieldByName('cg20_codbrad').AsString, 2, '0');
                            linha := linha + copy(linaux, 24, 5);
                            Verifica(linha);
                            if Corrompido = false then
                              Writeln(arquivo, linha);
                          end;
                      end; // \case

                      Dm.SqlAux1.Next;
                      PBConsistencia.Position := PBConsistencia.Position + 1;
                    end; // \while
                  CloseFile(arquivo); // \Fechando arquivo rt_4237.2
                  EdNomeArquivo.Text := EdNomeArquivo.Text + ' e ' + fname;
                end // \if ctareg > 0
              else
                PBConsistencia.Position := PBConsistencia.Max;
            except on E: Exception do
              Begin
                Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                          'de Registros de Retorno.' + #13+#10 +
                          'Por favor informe o ocorrido para a �rea de T.I..'),
                      'ADS', MB_OK + MB_ICONERROR);
                CloseFile(arquivo);
                Exit;
              end;
            end; // \try
          end; //  \if Dm.SqlAux1.RecordCount > 0

        Dm.SqlAux1.Close;
        Dm.SqlAux1.Sql.Clear;

        Dm.SqlAux1.Sql.Add('UPDATE cga68 SET cg68_dtret = CURRENT_DATE ');
        if sim = false then
          dm.SqlAux1.Sql.Add(', cg68_dtenv = CURRENT_DATE ');
        dm.SqlAux1.Sql.Add('WHERE cg68_dtbaixa BETWEEN :dtini AND :dtfin ');
        Dm.SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
        Dm.SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
        Dm.SqlAux1.ExecSql;
        Dm.SqlAux1.Close;

        Application.MessageBox('Gera��o de Arquivo Extrato Unificado conclu�do',
            'Ads', MB_OK + MB_ICONINFORMATION);
        BtnGerar.Enabled := true;
      end;
    5:
      begin
      end;
    6: // extrato cartao bradesco - TanCode
      begin
        Dm.SqlAux1.Close;
        Dm.SqlAux1.Sql.Clear;
        Dm.SqlAux1.Sql.Add('SELECT DISTINCT cga67.cg67_remes, cga20.cg20_codbrad ');
        Dm.SqlAux1.Sql.Add('FROM cga67 ');
        Dm.SqlAux1.Sql.Add('  INNER JOIN cga20 on cga20.cg20_codbaixa = cga67.cg67_codbaixa ');
        Dm.SqlAux1.Sql.Add('WHERE cg67_dtbaixa BETWEEN :dtini AND :dtfin ');
        Dm.SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
        Dm.SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

        if application.MessageBox('Deseja que sejam reenviados registros?',
              'ADS', MB_YESNO + MB_ICONQUESTION) = idno then
          Dm.SqlAux1.Sql.Add('  AND cg67_dtret IS NULL ')
        else
          begin
            sim := true;
            Dm.SqlAux1.Sql.Add('  AND cg67_dtret IS NOT NULL ');
          end;
        Dm.SqlAux1.Open;
        LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);

        if Dm.SqlAux1.RecordCount > 0 then
          begin
            Dm.SqlAux1.First;
            PbProgresso.Max := Dm.SqlAux1.RecordCount;
            try
              // Diret�rio onde colocar arquivos gerados
              destdir := GetCurrentDir + '\retorno\cartao\' +
                      UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';

              if (not DirectoryExists(destdir))
                      AND (not SysUtils.ForceDirectories(destdir)) then
                  raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);

              fname := 'RT_4237.0' + formatdatetime('dd', date);
              // Garantindo que n�o existe arquivo com a nomenclatura passada
              seq := 0;
              while FileExists(destdir + fname) do
                begin
                  seq := seq + 1;
                  fname := 'RT_4237.0' + formatdatetime('dd', date) + '_' +
                       IntToStr(seq);
                end;

              AssignFile(arquivo, destdir + fname);
              Rewrite(arquivo);

              linha := '1058' + formatdatetime('yyyymmdd', date);
              Writeln(arquivo, linha);

              While Not Dm.SqlAux1.Eof Do
                Begin
                  linha := '2' + Dm.SqlAux1.FieldByName('cg67_remes').AsString +
                      LPad(Dm.SqlAux1.FieldByName('cg20_codbrad').AsString, 2, '0') +
                      formatdatetime('yyyymmdd', date);
                  if Length(linha) = 43 then
                    begin
                      Verifica(linha);
                      if Corrompido = false then
                        begin
                          Writeln(arquivo, linha);
                          LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                        end;
                    end
                  else
                    LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));

                  Dm.SqlAux1.Next;
                  LCDLidos.Caption := inttostr(1 + strtoint(LCDLidos.Caption));
                  PbProgresso.Position := PbProgresso.Position + 1;
                end;

              linha := '9058' + formatdatetime('yyyymmdd', date) +
                  LPad(IntToStr(Dm.SqlAux1.RecordCount + 2), 9, '0');
              Writeln(arquivo, linha); // Trailer
              CloseFile(arquivo); // Fechando arquivo
              Dm.SqlAux1.Close;
              Dm.SqlAux1.Sql.Clear;

              Dm.SqlAux1.Sql.Add('UPDATE cga67 SET cg67_dtret = CURRENT_DATE ');

              if sim = false then
                dm.SqlAux1.Sql.Add(', cg67_dtenv = CURRENT_DATE ');

              dm.SqlAux1.Sql.Add('WHERE cg67_dtbaixa BETWEEN :dtini AND :dtfin ');
              Dm.SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
              Dm.SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
              Dm.SqlAux1.ExecSql;
              Application.MessageBox('Gera��o de Arquivo Retorno Finalizada',
                  'ADS', MB_OK + MB_ICONINFORMATION);
              EdNomeArquivo.Text := fname;
              EdCaminho.Text := destdir;

              BtnGerar.Enabled := true;

            except on E: Exception do
              Begin
                Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                          'de Registros de Retorno.' + #13+#10 +
                          'Por favor informe o ocorrido para a �rea de T.I..'),
                      'ADS', MB_OK + MB_ICONERROR);
                CloseFile(arquivo);
              end;
            end; // \try

          end
        else
          application.MessageBox('N�o foi encontrado nenhum registro',
              'ADS', MB_OK + MB_ICONINFORMATION);

      end;

    07: seldrccrt;  // drc carta convite
    08: selcrtseg;  // cartao seguranca
    09: selcodetq;  // codigo de etica
    10: seltokens;  // tokens
    11: selcadetq; // cadastro codigo de etica
    12: selfatcardcred; // Fatura Cart�o de Credito.
    13: seldrccllp;   // Drc - Aviso de Cobran�a  CLLP
    14: selcrtsenha; // Bradesco Adm. Consorcio
    15: selconsorcio; // Bradesco Adm. Consorcio
    16: selfinasafpe; // Baixa Extrato Finasa FPE
    17: selfinasacli; // Baixa Boleto Finasa CLI
    18: selfinasacrt; // Baixa Carta Finasa CLI
    19: seldrcprvlbl; // Drc Private Label
    20: seldrccrtfat; // Drc Cartao Fatura
    21: seldrczogmcsi; // Drc Zogbi MCSI
    22: seldrcbolamex; // Drc Boleto Amex
  end; //fim do case
  BtnGerar.Enabled := true;
end;

procedure TFrmRetornoExtratos.FormShow(Sender: TObject);
begin
  case FrmRetornoExtratos.Tag of
    3:
      begin
        ChkGerarSeparado.Visible       := True;
        ChkSepCodigoLeitura.Visible    := True;
      end;
  end;
  DtPickerDtFin.Date := Date;
  DtPickerDtIni.Date := Date - 30;
  DtPickerDtIni.SetFocus;
end;

procedure TFrmRetornoExtratos.ChkGerarSeparadoClick(Sender: TObject);
begin
  if ChkGerarSeparado.Checked = True then
      EdNumeroSeparador.Visible := True
    else
      EdNumeroSeparador.Visible := False;
end;

procedure TFrmRetornoExtratos.seldrccrt;
begin
  with Dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('SELECT DISTINCT a.cg120_remes, b.cg20_codbrad_drc ');
      SqlAux1.Sql.Add('FROM cga120 a ');
      SqlAux1.Sql.Add(' INNER JOIN cga20 b ON a.cg120_codbaixa = b.cg20_codbaixa ');
      SqlAux1.Sql.Add('WHERE cg120_dtbaixa BETWEEN :dtini AND :dtfin ');
      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

      if application.MessageBox('Deseja que sejam reenviados registros?',
          'ADS', MB_YESNO+MB_ICONQUESTION) = IDNO then
          SqlAux1.Sql.Add(' AND cg120_dtret IS NULL ')
      else
        begin
          SqlAux1.Sql.Add(' AND cg120_dtret IS NOT NULL');
          sim := true;
        end;
      Dm.SqlAux1.Sql.Add('ORDER BY cg120_remes');
      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);

      if (SqlAux1.RecordCount > 0) then
        begin
          PbProgresso.Max := Dm.SqlAux1.RecordCount;
          SqlAux1.First;
          try
            // Diret�rio onde colocar arquivos gerados
            destdir := GetCurrentDir + '\retorno\DRC\carta\' +
                      UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';

            if (not DirectoryExists(destdir))
                      AND (not SysUtils.ForceDirectories(destdir)) then
              raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);

            fname := 'rt_5237-4120.0' + formatdatetime('dd', date);
            // Garantindo que n�o existe arquivo com a nomenclatura passada
            seq := 0;
            While FileExists(destdir + fname) do
              begin
                seq := seq + 1;
                    fname := 'rt_5237-4120.0' + formatdatetime('dd', date) +
                    '_' + IntToStr(seq);
              end;

            AssignFile(arquivo, destdir + fname);
            Rewrite(arquivo);

            While not SqlAux1.Eof do
              begin
                linha := Trim(dm.SqlAux1.FieldByName('acg120_remes').AsString);
                linha := linha + LPad(SqlAux1.FieldByName('cg20_codbrad_drc').AsString, 2, '0');
                case length(linha) of
                  13,17,18,19:
                    begin
                      Verifica(linha);
                      if Corrompido = false then
                        begin
                          Writeln(arquivo,linha);
                          LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                        end
                      else
                        begin
                          LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                          PBConsistencia.Position  :=  PBConsistencia.Position + 1;
                        end // \if
                    end;
                end; // \case

                SqlAux1.Next;
                LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
                PbProgresso.Position  :=  PbProgresso.Position + 1;

              end; // While

            SqlAux1.Close;
            SqlAux1.Sql.Clear;
            SqlAux1.Sql.Add('UPDATE cga120 SET cg120_dtret = CURRENT_DATE ');
            if sim = false then
              SqlAux1.Sql.Add(', cg120_dtenv = CURRENT_DATE');

            SqlAux1.Sql.Add('WHERE cg120_dtbaixa BETWEEN :dtini AND :dtfin ');
            SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
            SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

            SqlAux1.ExecSql;
            SqlAux1.Close;
            EdNomeArquivo.Text := fname;
            EdCaminho.Text := destdir;
            CloseFile(arquivo); // fechando arquivo
            Application.MessageBox('Gera��o de Arquivo Retorno Finalizada',
                  'ADS', MB_OK + MB_ICONINFORMATION);

          except on E: Exception do
              Begin
                Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                          'de Registros de Retorno.' + #13+#10 +
                          'Por favor informe o ocorrido para a �rea de T.I..'),
                      'ADS', MB_OK + MB_ICONERROR);
                CloseFile(arquivo);
              end;
          end; // \try
        end // \if
      else
        application.MessageBox('N�o foi encontrado nenhum registro',
              'ADS', MB_OK + MB_ICONINFORMATION);

  end; // With
end;

procedure TFrmRetornoExtratos.selfatcardcred;
var conta: Integer;
begin
  sel := 'SELECT a.cgfatcrtcrd_remes, b.cg20_codbrad_drc ' + #13#10 +
      'FROM cgafatcrtcrd a ' + #13#10 +
      '  INNER JOIN cga20 b on b.cg20_codbaixa = a.cgfatcrtcrd_codbaixa ' + #13#10 +
      'WHERE a.cgfatcrtcrd_dtbaixa BETWEEN :dtini AND :dtfin ';

  With Dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add(sel);
      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
      SqlAux1.Open;
    end;

  if Dm.SqlAux1.RecordCount > 0 then
    begin
      try
        PbProgresso.Max := Dm.SqlAux1.RecordCount;
        LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
        Dm.SqlAux1.First;

        try
          // Diret�rio onde colocar arquivos gerados
          destdir := GetCurrentDir + '\retorno\fatcardcred\' +
              UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';

          if (not DirectoryExists(destdir))
              AND (not SysUtils.ForceDirectories(destdir)) then
            raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);

          fname := 'RT_5237-4120.0' + formatdatetime('dd', date);
          // Garantindo que n�o existe arquivo com a nomenclatura passada
          seq := 0;
          While FileExists(destdir + fname) do
            begin
              seq := seq + 1;
              fname := 'RT_5237-4120.0' + formatdatetime('dd', date) +
                      '_' + IntToStr(seq);
            end;

          AssignFile(arquivo, destdir + fname);
          Rewrite(arquivo);
        except on E: Exception do
          Begin
            Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                          'de Registros de Retorno.' + #13+#10 +
                          'Por favor informe o ocorrido para a �rea de T.I..'),
                      'ADS', MB_OK + MB_ICONERROR);
            CloseFile(arquivo);
          end;
        end; // \try 2

        linha := '1000' + FormatDateTime('yyyymmdd', Date) + LPad(' ', 38, ' ');
        Writeln(arquivo, linha);
        conta := 1;
        while not Dm.SqlAux1.Eof do
          begin
            linha := '2';
            linha := linha + Trim(Dm.SqlAux1.Fields.Fields[0].AsString);
            linha := linha + Trim(Dm.SqlAux1.Fields.Fields[1].AsString);
            linha := linha + FormatDateTime('yyyymmdd', Date);
            linha := linha + LPad(' ', 5, ' ');
            LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
            LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
            PbProgresso.Position := PbProgresso.Position + 1;
            Writeln(arquivo, linha);
            Dm.SqlAux1.Next;
            conta := conta + 1;
          end;
        conta := conta + 1;
        linha := '9000' + FormatDateTime('yyyymmdd', Date);
        linha := linha + LPad(IntToStr(conta), 9, '0');
        linha := linha + LPad(' ', 29, ' ');
        Writeln(arquivo, linha); // Trailer
        CloseFile(arquivo);
        sel := 'UPDATE cgafatcrtcrd set cgfatcrtcrd_dtret = CURRENT_DATE ';
        sel := sel + 'WHERE cgfatcrtcrd_dtbaixa BETWEEN :dtini AND :dtfin ';
        sel := sel + '  AND cgfatcrtcrd_dtret IS NULL';
        with Dm do
          begin
            SqlAux1.Close;
            SqlAux1.SQL.Clear;
            SqlAux1.SQL.Add(sel);
            SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
            SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
            SqlAux1.ExecSQL;
          end;
        EdNomeArquivo.Text := fname;
        EdCaminho.Text := destdir;
        ShowMessage('Gera��o Concluida !!!');

      except on e: exception do
        Application.MessageBox(PChar(e.Message), 'ADS', ID_OK);
      end; // \try 1
    end // \else
  else
    begin
      Application.MessageBox('N�o foi localizado registros com esses parametros!!!','ADS',0);
      DtPickerDtIni.SetFocus;
    end; // \if
end;

procedure TFrmRetornoExtratos.selcrtseg;
begin
  With dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('SELECT a.cg130_remes, a.cg130_dtbaixa, b.cg20_codbrad ');
      SqlAux1.Sql.Add('FROM cga130 a ');
      SqlAux1.Sql.Add(' INNER JOIN cga20 b on b.cg20_codbaixa = a.cg130_codbaixa ');
      SqlAux1.Sql.Add('WHERE cg130_dtbaixa BETWEEN :dtini AND :dtfin ');
      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

      if application.MessageBox('Deseja que sejam reenviados registros?',
            'ADS', MB_YESNO + MB_ICONQUESTION) = idno then
        begin
          SqlAux1.Sql.Add(' AND cg130_dtret IS NULL ');
        end
      else
        begin
          SqlAux1.Sql.Add(' AND cg130_dtret IS NOT NULL');
          sim := true;
        end;
      SqlAux1.Sql.Add('ORDER BY cg130_remes');
      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      if SqlAux1.RecordCount > 0 then
        begin
          PbProgresso.Max := Dm.SqlAux1.RecordCount;
          SqlAux1.First;
          try
            // Diret�rio onde colocar arquivos gerados
            destdir := GetCurrentDir + '\retorno\cartaoseguranca\' +
                UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';

            if (not DirectoryExists(destdir))
                  AND (not SysUtils.ForceDirectories(destdir)) then
              raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);

            fname := 'RT_5237-4120.0' + formatdatetime('dd', date);
            // Garantindo que n�o existe arquivo com a nomenclatura passada
            seq := 0;
            While FileExists(destdir + fname) do
              begin
                seq := seq + 1;
                fname := 'RT_5237-4120.0' + formatdatetime('dd', date) +
                          '_' + IntToStr(seq);
              end;

            AssignFile(arquivo, destdir + fname);
            Rewrite(arquivo);
          except on E: Exception do
            Begin
              Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                              'de Registros de Retorno.' + #13+#10 +
                              'Por favor informe o ocorrido para a �rea de T.I..'),
                          'ADS', MB_OK + MB_ICONERROR);
              CloseFile(arquivo);
              exit;
            end;
          end; // \try 2

          EdNomeArquivo.Text :=  fname;
          EdCaminho.Text := destdir;
          ctareg := 0;
          While not SqlAux1.Eof do
            begin
              linha := trim(SqlAux1.Fields[0].AsString);
              linha := linha  + FormatDateTime('ddmmyyyy', SqlAux1.FieldByName('cg130_dtbaixa').AsDateTime);
              linha := linha  + gerant(SqlAux1.Fields[2].AsString,2);
              case length(linha) of
                21:
                  begin
                    Verifica(linha);
                    if Corrompido = true then
                      begin
                        LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                        PBConsistencia.Position  :=  PBConsistencia.Position + 1;
                        corrompido :=  false;
                      end
                    else
                      begin
                        ctareg:=ctareg+1;
                        linha:=gerant(inttostr(ctareg),6)+linha;
                        Writeln(arquivo,linha);
                        LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                      end;
                  end;
              end; // \case
              SqlAux1.Next;
              LCDLidos.Caption := inttostr(1 + strtoint(LCDLidos.Caption));
              PbProgresso.Position := PbProgresso.Position + 1;
            end;
          SqlAux1.First;
          CloseFile(arquivo);

          try
            fname := 'RT_5237-4120.1' + formatdatetime('dd', date);
            // Garantindo que n�o existe arquivo com a nomenclatura passada
            seq := 0;
            While FileExists(destdir + fname) do
              begin
                seq := seq + 1;
                fname := 'RT_5237-4120.1' + formatdatetime('dd', date) +
                          '_' + IntToStr(seq);
              end;

            AssignFile(arquivo, destdir + fname);
            Rewrite(arquivo);
          except on E: Exception do
            Begin
              Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                              'de Registros de Retorno.' + #13+#10 +
                              'Por favor informe o ocorrido para a �rea de T.I..'),
                          'ADS', MB_OK + MB_ICONERROR);
              CloseFile(arquivo);
              exit;
            end;
          end; // \try 2

          fname :=  EdNomeArquivo.Text + ' e ' + fname;
          ctareg := 0;
          PbProgresso.Max := PbProgresso.Max * 2;
          PBConsistencia.Max := PBConsistencia.Max * 2;
          While not SqlAux1.Eof do
            begin
              linha := trim(SqlAux1.Fields[0].AsString);
              linha := linha  + FormatDateTime('ddmmyyyy', SqlAux1.FieldByName('cg130_dtbaixa').AsDateTime);
              linha := linha  + LPad(SqlAux1.Fields[2].AsString, 2, '0');
              case length(linha) of
                26:
                  begin
                    Verifica(linha);
                    if Corrompido = true then
                      begin
                        LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                        PBConsistencia.Position  :=  PBConsistencia.Position + 1;
                        corrompido :=  false;
                      end
                    else
                      begin
                        ctareg:=ctareg+1;
                        linha:= LPad(inttostr(ctareg), 6, '0')+linha;
                        Writeln(arquivo,linha);
                        LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                      end;
                  end;
              end; // \case

              SqlAux1.Next;
              LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
              PbProgresso.Position := PbProgresso.Position + 1;
            end; // \while

          SqlAux1.Close;
          SqlAux1.Sql.Clear;
          SqlAux1.Sql.Add('UPDATE cga130 SET cg130_dtret = CURRENT_DATE ');
          if sim = false then
            SqlAux1.Sql.Add(', cg130_dtenv = CURRENT_DATE');

          SqlAux1.Sql.Add('WHERE cg130_dtbaixa BETWEEN :dtini AND :dtfin ');
          SqlAux1.SQL.Add(' AND cg130_dtret is null ');

          SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
          SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
          SqlAux1.ExecSql;

          SqlAux1.Close;
          CloseFile(arquivo);
          EdNomeArquivo.Text :=  fname;
          EdCaminho.Text := destdir;

          Application.MessageBox('Gera��o de Arquivo Retorno Finalizada',
              'Ads', MB_OK + MB_ICONINFORMATION);
        end
      else
        application.MessageBox('N�o foi encontrado nenhum registro',
              'Ads', MB_OK + MB_ICONINFORMATION);

    end; // \With
end;

procedure TFrmRetornoExtratos.selcodetq;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('SELECT a.cg140_remes, ' +
          'to_char(a.cg140_dtbxa,'+chr(39)+'ddmmyyyy'+chr(39)+'), ' +
          'cg140_codbxa,  a.cg140_dtbxa as dtbxa ');
      SqlAux1.Sql.Add('FROM cga140 a ');
      SqlAux1.Sql.Add('WHERE cg140_dtbxa BETWEEN :dtini AND :dtfin ');
      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

      if application.MessageBox('Deseja que sejam reenviados registros?',
            'Ads', MB_YESNO + MB_ICONQUESTION) = idno then
        begin
          SqlAux1.Sql.Add(' AND cg140_dtret IS NULL ');
        end
      else
        begin
          SqlAux1.Sql.Add(' AND cg140_dtret IS NOT NULL');
          sim:=true;
        end;
      SqlAux1.Sql.Add('ORDER BY cg140_remes');
      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      case SqlAux1.RecordCount of
        0: application.MessageBox('N�o foi encontrado nenhum registro',
              'Ads', MB_OK + MB_ICONINFORMATION);
        else
          begin
            PbProgresso.Max := Dm.SqlAux1.RecordCount;
            SqlAux1.First;

            try
              // Diret�rio onde colocar arquivos gerados
              destdir := GetCurrentDir + '\retorno\codigoetica\' +
                  UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';

              if (not DirectoryExists(destdir))
                    AND (not SysUtils.ForceDirectories(destdir)) then
                raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);

              fname := 'rt_5237-4120.0' + formatdatetime('dd', date);
              // Garantindo que n�o existe arquivo com a nomenclatura passada
              seq := 0;
              While FileExists(destdir + fname) do
                begin
                  seq := seq + 1;
                  fname := 'rt_5237-4120.0' + formatdatetime('dd', date) +
                          '_' + IntToStr(seq);
              end;

            AssignFile(arquivo, destdir + fname);
            Rewrite(arquivo);
            except on E: Exception do
              Begin
                Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                              'de Registros de Retorno.' + #13+#10 +
                              'Por favor informe o ocorrido para a �rea de T.I..'),
                          'ADS', MB_OK + MB_ICONERROR);
                CloseFile(arquivo);
              end;
            end; // \try 2

            While not SqlAux1.Eof do
              begin
                linha := Trim(SqlAux1.Fields[0].AsString);
                linha := linha + FormatDateTime('ddmmyyyy', SqlAux1.FieldByName('dtbxa').AsDateTime);
                linha := linha + SqlAux1.Fields[2].AsString;
                case length(linha) of
                   30:
                     begin
                       Verifica(linha);
                       if Corrompido = true then
                         begin
                           LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                           PBConsistencia.Position  :=  PBConsistencia.Position + 1;
                           // corrompido
                         end
                       else
                         begin
                           Writeln(arquivo,linha);
                           LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                           LCDGrav.Refresh;
                         end;
                     end;
                end; // \case
                SqlAux1.Next;
                LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
                PbProgresso.Position := PbProgresso.Position + 1;
              end; // \While

            SqlAux1.Close;
            SqlAux1.Sql.Clear;
            SqlAux1.Sql.Add('UPDATE cga140 SET cg140_dtret = CURRENT_DATE ');
            if sim = false then
              SqlAux1.Sql.Add(', cg140_dtenv = CURRENT_DATE');

            SqlAux1.Sql.Add('WHERE cg140_dtbxa BETWEEN :dtini AND :dtfin ');
            SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
            SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

            SqlAux1.SQL.Add('AND cg140_dtret is null');
            SqlAux1.ExecSql;
            SqlAux1.Close;
            Application.MessageBox('Gera��o de Arquivo Retorno Finalizada',
                    'Ads', MB_OK + MB_ICONINFORMATION);
            CloseFile(arquivo);
          end;
        end; // \case
    end;
end;

procedure TFrmRetornoExtratos.seltokens;
begin
  With Dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('SELECT cg76_remes, ' +
          'to_char(cg76_dtsai,' + chr(39) + 'dd/mm/yyyy' + chr(39) + '), ' +
          'cg76_ag, cg76_tipocli, cg76_dtb, cg76_dtsai as dtsai');
      SqlAux1.Sql.Add('FROM cga76 ');
      SqlAux1.Sql.Add('WHERE cg76_dtsai BETWEEN :dtini AND :dtfin ');
      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

      if application.MessageBox('Deseja que sejam reenviados registros?',
          'Ads', MB_YESNO + MB_ICONQUESTION) = idno then
        begin
          SqlAux1.Sql.Add(' AND cg76_dtret IS NULL ');
        end
      else
        begin
          SqlAux1.Sql.Add(' AND cg76_dtret IS NOT NULL ');
          sim := true;
        end;

      SqlAux1.Sql.Add('ORDER by cg76_remes');
      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      case SqlAux1.RecordCount of
        0: application.MessageBox('N�o foi encontrado nenhum registro',
              'Ads', MB_OK + MB_ICONINFORMATION);
        else
          begin
            PbProgresso.Max := Dm.SqlAux1.RecordCount;
            SqlAux1.First;
            try
              // Diret�rio onde colocar arquivos gerados
              destdir := GetCurrentDir + '\retorno\token\' +
                  UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';

              if (not DirectoryExists(destdir))
                    AND (not SysUtils.ForceDirectories(destdir)) then
                raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);

              fname := 'RT_9237-4120.0' + formatdatetime('dd', date);
              // Garantindo que n�o existe arquivo com a nomenclatura passada
              seq := 0;
              While FileExists(destdir + fname) do
                begin
                  seq := seq + 1;
                  fname := 'RT_9237-4120.0' + formatdatetime('dd', date) +
                          '_' + IntToStr(seq);
              end;

            AssignFile(arquivo, destdir + fname);
            Rewrite(arquivo);
            except on E: Exception do
              Begin
                Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                              'de Registros de Retorno.' + #13+#10 +
                              'Por favor informe o ocorrido para a �rea de T.I..'),
                          'ADS', MB_OK + MB_ICONERROR);
                CloseFile(arquivo);
                exit;
              end;
            end; // \try 2

            While Not SqlAux1.Eof Do
              begin
                linha := GeraArquivo(trim(SqlAux1.Fields[0].AsString),31);
                linha := linha + GeraArquivo(SqlAux1.Fields[1].AsString,11);
                linha := linha + GeraArquivo(SqlAux1.Fields[2].AsString,5);
                linha := linha + SqlAux1.Fields[3].AsString;
                linha := linha + GeraArquivo(SqlAux1.Fields[4].AsString,15);
                case length(linha) of
                  63:
                    begin
                      Writeln(arquivo,linha);
                      LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                      LCDGrav.Refresh;
                    end;
                end;
                SqlAux1.Next;
                LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
                PbProgresso.Position := PbProgresso.Position + 1;
              end;
              SqlAux1.Close;
              SqlAux1.Sql.Clear;
              SqlAux1.Sql.Add('UPDATE cga76 SET cg76_dtret = CURRENT_DATE ');

              if sim = false then
                  SqlAux1.Sql.Add(', cg76_dtenv = CURRENT_DATE ');

              SqlAux1.Sql.Add('WHERE cg76_dtsai BETWEEN :dtini AND :dtfin ');
              SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
              SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
              SqlAux1.SQL.Add(' AND cg76_dtret IS NULL ');
              SqlAux1.ExecSql;
              SqlAux1.Close;
              CloseFile(arquivo);
              EdNomeArquivo.Text := fname;
              EdCaminho.Text := destdir;
              Application.MessageBox('Gera��o de Arquivo Retorno Finalizada',
                    'Ads', MB_OK + MB_ICONINFORMATION);

          end;
      end;  // \case
    end; // \With
end;


procedure TFrmRetornoExtratos.selcadetq;
begin
  With Dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('SELECT a.cg140_remes, ' +
        'to_char(a.cg140_dtcad, ' + chr(39) + 'ddmmyyyy' + chr(39) + '), ' +
        'a.cg140_codbxa,  a.dtcad ');
      SqlAux1.Sql.Add('FROM cga140 a ');
      SqlAux1.Sql.Add('WHERE cg140_dtcad BETWEEN :dtini AND :dtfin ');
      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

      sim := true;
      SqlAux1.Sql.Add('ORDER BY cg140_remes');
      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      If (SqlAux1.RecordCount > 0 ) then
        begin
          PbProgresso.Max := Dm.SqlAux1.RecordCount;
          SqlAux1.First;
          try
            // Diret�rio onde colocar arquivos gerados
            destdir := GetCurrentDir + '\retorno\codigoetica\' +
                UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';

            if (not DirectoryExists(destdir))
                  AND (not SysUtils.ForceDirectories(destdir)) then
              raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);

            fname := 'RT_5237-4120.0' + formatdatetime('dd', date);
            // Garantindo que n�o existe arquivo com a nomenclatura passada
            seq := 0;
            While FileExists(destdir + fname) do
              begin
                seq := seq + 1;
                fname := 'RT_5237-4120.0' + formatdatetime('dd', date) +
                          '_' + IntToStr(seq);
              end;

            AssignFile(arquivo, destdir + fname);
            Rewrite(arquivo);
          except on E: Exception do
            Begin
              Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                              'de Registros de Retorno.' + #13+#10 +
                              'Por favor informe o ocorrido para a �rea de T.I..'),
                          'ADS', MB_OK + MB_ICONERROR);
              CloseFile(arquivo);
            end;
          end; // \try 2

          While Not SqlAux1.Eof do
            Begin
              linha := Trim(SqlAux1.Fields[0].AsString);
              linha := linha + FormatDateTime('ddmmyyyy', SqlAux1.FieldByName('dtcad').AsDateTime);
              If length(linha) = 28 then
                begin
                  Verifica(linha);
                  if Corrompido = true then
                    begin
                      LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                      PBConsistencia.Position  :=  PBConsistencia.Position + 1;
                          // corrompido
                    end
                  else
                    begin
                      Writeln(arquivo, linha);
                      LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                      LCDGrav.Refresh;
                    end;

                end;
              SqlAux1.Next;
              LCDLidos.Caption := inttostr(1 + strtoint(LCDLidos.Caption));
              PbProgresso.Position := PbProgresso.Position + 1;
            end;

          SqlAux1.Close;
          SqlAux1.Sql.Clear;
          SqlAux1.Sql.Add('UPDATE cga140 SET cg140_dtret = CURRENT_DATE ');
          if sim = false then
            SqlAux1.Sql.Add(', cg140_dtenv = CURRENT_DATE');

          SqlAux1.Sql.Add('WHERE cg140_dtbxa BETWEEN :dtini AND :dtfin ');
          SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
          SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

          SqlAux1.SQL.Add(' AND cg140_dtret IS NULL');
          SqlAux1.ExecSql;
          SqlAux1.Close;
          EdNomeArquivo.Text := fname;
          EdCaminho.Text := destdir;
          Application.MessageBox('Gera��o de Arquivo Retorno Finalizada',
                    'Ads', MB_OK + MB_ICONINFORMATION);

          CloseFile(arquivo);
        end
      else
        application.MessageBox('N�o foi encontrado nenhum registro',
              'ADS', MB_OK + MB_ICONINFORMATION);
    end; // \With
end;

procedure TFrmRetornoExtratos.seldrccllp;
begin
  With Dm Do
    Begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear; // alterado at� regerar

      SqlAux1.Sql.Add('SELECT a.cg78_remes, b.cg20_codbrad ');
      SqlAux1.Sql.Add(', to_char(a.cg78_dtbaixa,''ddmmyyyy''), ');
      SqlAux1.Sql.Add('a.cg78_dtbaixa as dtbaixa ');
      SqlAux1.Sql.Add('FROM cga78 ');
      SqlAux1.Sql.Add('INNER JOIN cga20 b on b.cg20_codbaixa = a.cg78_codbaixa ');
      SqlAux1.Sql.Add('WHERE a.cg78_dtbaixa BETWEEN :dtini and :dtfin ');

      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

      SqlAux1.Sql.Add('ORDER BY by a.cg78_remes, b.cg20_codbrad');
      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      if SqlAux1.RecordCount > 0 then
        Begin
          PbProgresso.Max := SqlAux1.RecordCount;
          SqlAux1.First;
          try
            // Diret�rio onde colocar arquivos gerados
            destdir := GetCurrentDir + '\retorno\DRC\avisocob\' +
                UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';
            if (not DirectoryExists(destdir))
                  AND (not SysUtils.ForceDirectories(destdir)) then
              raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);
            fname := 'RT_5237-4120.0' + formatdatetime('dd', date);
            // Garantindo que n�o existe arquivo com a nomenclatura passada
            seq := 0;
            While FileExists(destdir + fname) do
              begin
                seq := seq + 1;
                fname := 'RT_5237-4120.0' + formatdatetime('dd', date) +
                          '_' + IntToStr(seq);
              end;
            AssignFile(arquivo, destdir + fname);
            Rewrite(arquivo);
          except on E: Exception do
            Begin
              Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                              'de Registros de Retorno.' + #13+#10 +
                              'Por favor informe o ocorrido para a �rea de T.I..'),
                          'ADS', MB_OK + MB_ICONERROR);
              CloseFile(arquivo);
            end;
          end; // \try 2

          linha := RPad('@ADDRESS S.A.', 31, ' ');
          Writeln(arquivo, linha);
          While Not SqlAux1.Eof Do
            Begin
              linha := copy(Trim(SqlAux1.Fields[0].AsString), 1, 15) +
                  SqlAux1.Fields[2].AsString +
                  copy(Trim(SqlAux1.Fields[0].AsString), 24, 6);
              linha := linha + format('%2.2d', [SqlAux1.Fields[1].AsInteger]);
              If length(linha) = 31 then
                begin
                  Verifica(linha);
                  if Corrompido = true then
                    begin
                      LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                      PBConsistencia.Position  :=  PBConsistencia.Position + 1;
                          // corrompido
                    end
                  else
                    begin
                      Writeln(arquivo,linha);
                      LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                      LCDGrav.Refresh;
                    end;
                end;

              SqlAux1.Next;
              LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
              PbProgresso.Position := PbProgresso.Position + 1;
            end;

          linha:= RPad('*' + format('%9.9d', [strtoint(LCDGrav.caption)]), 31, ' ');
          Writeln(arquivo, linha);
          SqlAux1.Close;
          SqlAux1.Sql.Clear;
          SqlAux1.Sql.Add('UPDATE cga78 SET cg78_dtret = CURRENT_DATE ');
          if sim = false then
            SqlAux1.Sql.Add(', cg78_dtenv = CURRENT_DATE ');

          SqlAux1.Sql.Add('WHERE cg78_dtbaixa BETWEEN :dtini AND :dtfin ');
          SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
          SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

          SqlAux1.SQL.ADD(' AND cg78_dtret IS NULL');
          SqlAux1.ExecSql;
          SqlAux1.Close;
          EdNomeArquivo.Text := fname;
          EdCaminho.Text := destdir;
          Application.MessageBox('Gera��o de Arquivo Retorno Finalizada',
                  'Ads', MB_OK + MB_ICONINFORMATION);

          closefile(arquivo);
        end
      else
        application.MessageBox('N�o foi encontrado nenhum registro',
                'Ads', MB_OK + MB_ICONINFORMATION);

    end; // \With
end;


procedure TFrmRetornoExtratos.selcrtsenha;
begin
  With Dm Do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;// alterado at� regerar
      SqlAux1.Sql.Add('SELECT cga035.cg035_remes, cga20.cg20_codbrad ');
      SqlAux1.Sql.Add('FROM cga035 ');
      SqlAux1.Sql.Add(' INNER JOIN cga20 on cga20.cg20_codbaixa = cga035.cg035_codbaixa ');
      SqlAux1.Sql.Add('WHERE cg035_dtbaixa BETWEEN :dtini and :dtfin ');
      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

      SqlAux1.Sql.Add('ORDER BY cg035_remes, cga20.cg20_codbrad');

      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      If SqlAux1.RecordCount > 0 then
        begin
          PbProgresso.Max := SqlAux1.RecordCount;
          SqlAux1.First;
          try
            // Diret�rio onde colocar arquivos gerados
            destdir := GetCurrentDir + '\retorno\consorcio\cartasenha\' +
                UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';
            if (not DirectoryExists(destdir))
                  AND (not SysUtils.ForceDirectories(destdir)) then
              raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);
            fname := 'RT_5237-4120.0' + formatdatetime('dd', date);
            // Garantindo que n�o existe arquivo com a nomenclatura passada
            seq := 0;
            While FileExists(destdir + fname) do
              begin
                seq := seq + 1;
                fname := 'RT_5237-4120.0' + formatdatetime('dd', date) +
                          '_' + IntToStr(seq);
              end;
            AssignFile(arquivo, destdir + fname);
            Rewrite(arquivo);
          except on E: Exception do
            Begin
              Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                              'de Registros de Retorno.' + #13+#10 +
                              'Por favor informe o ocorrido para a �rea de T.I..'),
                          'ADS', MB_OK + MB_ICONERROR);
              CloseFile(arquivo);
              exit;
            end;
          end; // \try 2

          linha := RPad('@ADDRESS S.A.', 31, ' ');
          Writeln(arquivo, linha);
          ctareg := 1;
          While Not SqlAux1.Eof Do
            Begin
              linha := RPad(
                            Trim(SqlAux1.Fields[0].AsString) +
                              format('%2.2d', [SqlAux1.Fields[1].AsInteger]),
                            22, ' ');
              If length(linha) = 22 then
                begin
                  Verifica(linha);
                  if Corrompido = true then
                    begin
                      LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                      PBConsistencia.Position  :=  PBConsistencia.Position + 1;
                          // corrompido
                    end
                  else
                    begin
                      Writeln(arquivo,linha);
                      LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                      LCDGrav.Refresh;
                    end;
                end;
              SqlAux1.Next;
              LCDLidos.Caption := inttostr(1 + strtoint(LCDLidos.Caption));
              PbProgresso.Position := PbProgresso.Position + 1;
            end;

          linha:= RPad('*' + format('%9.9d', [strtoint(LCDGrav.caption)]),
                       31, ' ');
          Writeln(arquivo, linha);
          SqlAux1.Close;
          SqlAux1.Sql.Clear;
          SqlAux1.Sql.Add('UPDATE cga035 SET cg035_dtret = CURRENT_DATE ');
          SqlAux1.SQL.Add('WHERE cg035_dtbaixa BETWEEN :dtini AND :dtfin ');
          SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
          SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
          SqlAux1.SQL.Add(' AND cg035_dtret IS NULL ');
          SqlAux1.ExecSql;
          SqlAux1.Close;
          EdNomeArquivo.Text := fname;
          EdCaminho.Text := destdir;
          Closefile(arquivo);
          Application.MessageBox('Gera��o de Arquivo Retorno Finalizada',
                    'Ads', MB_OK + MB_ICONINFORMATION);
        end
      else
        application.MessageBox('N�o foi encontrado nenhum registro',
                  'Ads', MB_OK + MB_ICONINFORMATION);
    end; // \With
end;


procedure TFrmRetornoExtratos.selconsorcio;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;// alterado at� regerar

      SqlAux1.Sql.Add('SELECT a.cg036_remes, b.cg20_codbrad ');
      SqlAux1.Sql.Add('FROM cga036 a INNER JOIN cga20 b on b.cg20_codbaixa = a.cg036_codbaixa ');
      SqlAux1.Sql.Add('WHERE cg036_dtbaixa BETWEEN :dtini and :dtfin ');
      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
      SqlAux1.Sql.Add('ORDER BY cg036_remes, b.cg20_codbrad');
      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);

      If (SqlAux1.RecordCount > 0 ) then
        Begin
          PbProgresso.Max := SqlAux1.RecordCount;
          SqlAux1.First;
          try
            // Diret�rio onde colocar arquivos gerados
            destdir := GetCurrentDir + '\retorno\consorcio\extrato\' +
                UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';
            if (not DirectoryExists(destdir))
                  AND (not SysUtils.ForceDirectories(destdir)) then
              raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);
            fname := 'RT_5237-4120.0' + formatdatetime('dd', date);
            // Garantindo que n�o existe arquivo com a nomenclatura passada
            seq := 0;
            While FileExists(destdir + fname) do
              begin
                seq := seq + 1;
                fname := 'RT_5237-4120.0' + formatdatetime('dd', date) +
                          '_' + IntToStr(seq);
              end;

            AssignFile(arquivo, destdir + fname);
            Rewrite(arquivo);
          except on E: Exception do
            Begin
              Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                              'de Registros de Retorno.' + #13+#10 +
                              'Por favor informe o ocorrido para a �rea de T.I..'),
                          'ADS', MB_OK + MB_ICONERROR);
              CloseFile(arquivo);
              exit;
            end;
          end; // \try 2

          linha := RPad('@ADDRESS S.A.', 31, ' ');
          Writeln(arquivo, linha);
          ctareg := 1;

          While Not SqlAux1.Eof Do
            Begin
              linha := Trim(SqlAux1.Fields[0].AsString);
              linha := linha + format('%2.2d',[SqlAux1.Fields[1].AsInteger ]);
              If length(linha) = 22 then
                begin
                  Verifica(linha);
                  if Corrompido = true then
                    begin
                      LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                      PBConsistencia.Position  :=  PBConsistencia.Position + 1;
                          // corrompido
                    end
                  else
                    begin
                      Writeln(arquivo,linha);
                      LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                      LCDGrav.Refresh;
                    end;
                end;
              SqlAux1.Next;
              LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
              PbProgresso.Position := PbProgresso.Position + 1;
            end;

          linha := RPAd('*' + format('%9.9d', [strtoint(LCDGrav.caption)]), 31, ' ') ;
          Writeln(arquivo,linha);
          SqlAux1.Close;
          SqlAux1.Sql.Clear;
          SqlAux1.Sql.Add('UPDATE cga036 SET cg036_dtret = CURRENT_DATE ');
          SqlAux1.SQL.Add('WHERE cg036_dtbaixa BETWEEN :dtini AND :dtfin ');
          SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
          SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
          SqlAux1.SQL.Add('AND cg036_dtret IS NULL ');
          SqlAux1.ExecSql;
          SqlAux1.Close;
          Closefile(arquivo);
          EdNomeArquivo.Text := fname;
          EdCaminho.Text := destdir;

          Application.MessageBox('Gera��o de Arquivo Retorno Finalizada',
                'Ads', MB_OK + MB_ICONINFORMATION);
        end
      else
        application.MessageBox('N�o foi encontrado nenhum registro',
                'Ads', MB_OK + MB_ICONINFORMATION);

    end; // \With
end;


procedure TFrmRetornoExtratos.selfinasafpe; // Baixa Extrato Finasa FPE
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('SELECT a.cg038_remes, b.cg20_codbrad ');
      SqlAux1.Sql.Add('FROM cga038 a ');
      SqlAux1.Sql.Add('  INNER JOIN cga20 b on b.cg20_codbaixa = a.cg038_codbaixa ');
      SqlAux1.Sql.Add('WHERE cg038_dtbaixa BETWEEN :dtini AND :dtfin ');
      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
      SqlAux1.Sql.Add('ORDER BY cg038_remes, b.cg20_codbrad');

      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      If SqlAux1.RecordCount < 1 then
          application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION)
      else
        begin
          PbProgresso.Max := SqlAux1.RecordCount;
          SqlAux1.First;
          try
            // Diret�rio onde colocar arquivos gerados
            destdir := GetCurrentDir + '\retorno\FINASA\FPE\' +
                UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';
            if (not DirectoryExists(destdir))
                  AND (not SysUtils.ForceDirectories(destdir)) then
              raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);
            fname := 'RTFINFPE' + formatdatetime('ddmm.0yy', date);
            // Garantindo que n�o existe arquivo com a nomenclatura passada
            seq := 0;
            While FileExists(destdir + fname) do
              begin
                seq := seq + 1;
                fname := 'RTFINFPE' +
                      formatdatetime('ddmm.0_' + IntToStr(seq) + 'yy', date);
              end;

            AssignFile(arquivo, destdir + fname);
            Rewrite(arquivo);
          except on E: Exception do
            Begin
              Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                              'de Registros de Retorno.' + #13+#10 +
                              'Por favor informe o ocorrido para a �rea de T.I..'),
                          'ADS', MB_OK + MB_ICONERROR);
              CloseFile(arquivo);
              exit;
            end;
          end; // \try 2

          linha := RPad('@ADDRESS S.A.', 36, ' ');
          Writeln(arquivo, linha);
          ctareg := 1;

          While Not SqlAux1.Eof Do
            begin
              linha := Trim(SqlAux1.Fields[0].AsString);
              linha := linha + format('%2.2d',[SqlAux1.Fields[1].AsInteger ]);
              If length(linha) = 36 then
                begin
                  Verifica(linha);
                  if Corrompido = true then
                    begin
                      LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                      PBConsistencia.Position  :=  PBConsistencia.Position + 1;
                      // corrompido
                    end
                  else
                    begin
                      Writeln(arquivo,linha);
                      LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                      LCDGrav.Refresh;
                    end;
                end;

              SqlAux1.Next;
              LCDLidos.Caption := inttostr(1 + strtoint(LCDLidos.Caption));
              PbProgresso.Position := PbProgresso.Position + 1;
            end;

          linha:= RPad('*' + format('%9.9d', [strtoint(LCDGrav.caption)]), 36, ' ');
          Writeln(arquivo, linha);
          SqlAux1.Close;
          SqlAux1.Sql.Clear;
          SqlAux1.Sql.Add('UPDATE cga038 SET cg038_dtret = CURRENT_DATE ');
          SqlAux1.SQL.Add('WHERE cg038_dtbaixa BETWEEN :dtini AND :dtfin ');
          SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
          SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
          SqlAux1.SQL.Add(' AND cg038_dtret is null ');
          SqlAux1.ExecSql;
          SqlAux1.Close;
          Closefile(arquivo);
          EdNomeArquivo.Text := fname;
          EdCaminho.Text := destdir;
          Application.MessageBox('Gera��o de Arquivo Retorno Finalizada',
                  'Ads', IDOK);

        end;

    end; // \With
end;

procedure TFrmRetornoExtratos.selfinasacli; // Baixa Boleto Finasa CLI
begin
  With Dm do
    Begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('SELECT cga039.cg039_remes, cga20.cg20_codbrad ');
      SqlAux1.Sql.Add('FROM cga039 ');
      SqlAux1.Sql.Add(' INNER JOIN cga20 on cga20.cg20_codbaixa = cga039.cg039_codbaixa ');
      SqlAux1.Sql.Add('WHERE cg039_dtbaixa BETWEEN :dtini AND :dtfin ');
      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
      SqlAux1.Sql.Add('ORDER BY cg039_remes,cga20.cg20_codbrad');

      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      If SqlAux1.RecordCount < 1 then
          application.MessageBox('N�o foi encontrado nenhum registro',
                  'Ads', MB_OK + MB_ICONINFORMATION)
      else
        begin
          PbProgresso.Max := SqlAux1.RecordCount;
          SqlAux1.First;
          try
            // Diret�rio onde colocar arquivos gerados
            destdir := GetCurrentDir + '\retorno\FINASA\boleto\' +
                UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';
            if (not DirectoryExists(destdir))
                  AND (not SysUtils.ForceDirectories(destdir)) then
              raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);
            fname := 'RTFINCLI' + formatdatetime('ddmm.yy0', date);
            // Garantindo que n�o existe arquivo com a nomenclatura passada
            seq := 0;
            While FileExists(destdir + fname) do
              begin
                seq := seq + 1;
                fname := 'RTFINCLI' +
                      formatdatetime('ddmm_' + IntToStr(seq) + '.yy0', date);
              end;

            AssignFile(arquivo, destdir + fname);
            Rewrite(arquivo);
          except on E: Exception do
            Begin
              Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                              'de Registros de Retorno.' + #13+#10 +
                              'Por favor informe o ocorrido para a �rea de T.I..'),
                          'ADS', MB_OK + MB_ICONERROR);
              CloseFile(arquivo);
              exit;
            end;
          end; // \try 2

          linha := '@' + format('%-35.35s%',['ADDRESS S.A.']);
          Writeln(arquivo, linha);
          ctareg := 1;
          While Not SqlAux1.Eof Do
            begin
              linha := Trim(SqlAux1.Fields[0].AsString)+format('%2.2d',[SqlAux1.Fields[1].AsInteger ]);
              If length(linha) = 13 then
                begin
                  Verifica(linha);
                  if Corrompido = true then
                    begin
                      LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                      PBConsistencia.Position  :=  PBConsistencia.Position + 1;
                          // corrompido
                    end
                  else
                    begin
                      linha := linha + format('%-23.23s%',[' ']);
                      Writeln(arquivo,linha);
                      LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                      LCDGrav.Refresh;
                    end;

                end;
              SqlAux1.Next;
              LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
              PbProgresso.Position := PbProgresso.Position + 1;
            end;

            linha:= '*'+format('%9.9d',[strtoint(LCDGrav.caption)])+format('%-26.26s%',[' ']);
            Writeln(arquivo,linha);
            SqlAux2.Close;
            SqlAux2.Sql.Clear;
            SqlAux2.Sql.Add('UPDATE cga039 SET cg039_dtret = CURRENT_DATE ');
            SqlAux2.SQL.Add('cg039_dtbaixa BETWEEN :dtini AND :dtfin ');
            SqlAux2.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
            SqlAux2.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
            SqlAux2.SQL.Add('AND cg039_dtret is null');
            SqlAux2.ExecSql;
            SqlAux2.Close;
            Closefile(arquivo);
            EdNomeArquivo.Text := fname;
            EdCaminho.Text := destdir;
            Application.MessageBox('Gera��o de Arquivo Retorno Finalizada','Ads',IDOK);
        end;
    end; // \With
end;

procedure TFrmRetornoExtratos.selfinasacrt; // Baixa Boleto Finasa CLI
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('SELECT cga040.cg040_remes,cga20.cg20_codbrad ');
      SqlAux1.Sql.Add('FROM cga040 ');
      SqlAux1.Sql.Add(' INNER JOIN cga20 on cga20.cg20_codbaixa = cga040.cg040_codbaixa ');
      SqlAux1.Sql.Add('WHERE cg040_dtbaixa BETWEEN :dtini AND :dtfin ');
      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
      SqlAux1.Sql.Add('ORDER BY cg040_remes, cga20.cg20_codbrad');

      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      If SqlAux1.RecordCount < 1 then
        application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION)
      else
        Begin
          PbProgresso.Max := SqlAux1.RecordCount;
          SqlAux1.First;
          try
            // Diret�rio onde colocar arquivos gerados
            destdir := GetCurrentDir + '\retorno\FINASA\carta\' +
                UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';
            if (not DirectoryExists(destdir))
                  AND (not SysUtils.ForceDirectories(destdir)) then
              raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);
            fname := 'RTFINCRT' + formatdatetime('ddmmyyyy', date) + '.txt';
            // Garantindo que n�o existe arquivo com a nomenclatura passada
            seq := 0;
            While FileExists(destdir + fname) do
              begin
                seq := seq + 1;
                fname := 'RTFINCLI' +
                      formatdatetime('ddmmyyyy_' + IntToStr(seq) + '.txt', date);
              end;

            AssignFile(arquivo, destdir + fname);
            Rewrite(arquivo);
          except on E: Exception do
            Begin
              Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                              'de Registros de Retorno.' + #13+#10 +
                              'Por favor informe o ocorrido para a �rea de T.I..'),
                          'ADS', MB_OK + MB_ICONERROR);
              CloseFile(arquivo);
              exit;
            end;
          end; // \try 2

          linha := '@' + format('%-35.35s%',['ADDRESS S.A.']);
          Writeln(arquivo,linha);
          ctareg := 1;
          While Not SqlAux1.Eof Do
            Begin
              linha := Trim(SqlAux1.Fields[0].AsString) +
                    format('%2.2d',[SqlAux1.Fields[1].AsInteger ]);
              if length(linha) = 9 then
                begin
                  Verifica(linha);
                  if Corrompido = true then
                    begin
                      LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                      PBConsistencia.Position  :=  PBConsistencia.Position + 1;
                          // corrompido
                    end
                  else
                    begin
                      linha := format('%-36.36s%',[linha]);
                      Writeln(arquivo,linha);
                      LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                      LCDGrav.Refresh;
                    end;
                end;

              SqlAux1.Next;
              LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
              PbProgresso.Position := PbProgresso.Position + 1;
            end;

            linha := '*' + format('%9.9d',[strtoint(LCDGrav.caption)]) +
                    format('%-26.26s%',[' ']);
            Writeln(arquivo, linha);
            SqlAux2.Close;
            SqlAux2.Sql.Clear;
            SqlAux2.Sql.Add('UPDATE cga040 SET cg040_dtret = CURRENT_DATE ');
            SqlAux2.SQL.Add('cg040_dtbaixa BETWEEN :dtini AND :dtfin ');
            SqlAux2.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
            SqlAux2.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
            SqlAux2.Sql.Add('  AND cg040_dtret IS NULL ');
            SqlAux2.ExecSql;
            SqlAux2.Close;
            Application.MessageBox('Gera��o de Arquivo Retorno Finalizada',
                      'Ads', IDOK);
            Closefile(arquivo);
            EdNomeArquivo.Text := fname;
            EdCaminho.Text := destdir;
        end; // \If
    end; // \With
end;

procedure TFrmRetornoExtratos.seldrcprvlbl; // drc private label
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('SELECT a.cg041_remes, b.cg20_codbrad ');
      SqlAux1.Sql.Add('FROM cga041 a ');
      SqlAux1.Sql.Add(' INNER JOIN cga20 b on b.cg20_codbaixa = a.cg041_codbaixa ');
      SqlAux1.Sql.Add('WHERE cg041_dtbaixa BETWEEN :dtini AND :dtfin ');
      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

      SqlAux1.Sql.Add('ORDER BY cg041_remes, b.cg20_codbrad');
      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      If SqlAux1.RecordCount < 1 then
          application.MessageBox('N�o foi encontrado nenhum registro',
                'Ads', MB_OK + MB_ICONINFORMATION)
      else
        begin
          PbProgresso.Max := SqlAux1.RecordCount;
          SqlAux1.First;
          try
            // Diret�rio onde colocar arquivos gerados
            destdir := GetCurrentDir + '\retorno\DRC\private\' +
                UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';
            if (not DirectoryExists(destdir))
                  AND (not SysUtils.ForceDirectories(destdir)) then
              raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);
            fname := 'RT_5237-4120.' + formatdatetime('dd', date);
            // Garantindo que n�o existe arquivo com a nomenclatura passada
            seq := 0;
            While FileExists(destdir + fname) do
              begin
                seq := seq + 1;
                fname := 'RT_5237-4120' +
                      formatdatetime('_' + IntToStr(seq) + '.dd', date);
              end;

            AssignFile(arquivo, destdir + fname);
            Rewrite(arquivo);
          except on E: Exception do
            Begin
              Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                              'de Registros de Retorno.' + #13+#10 +
                              'Por favor informe o ocorrido para a �rea de T.I..'),
                          'ADS', MB_OK + MB_ICONERROR);
              CloseFile(arquivo);
              exit;
            end;
          end; // \try 2

          ctareg := 1;
          while not SqlAux1.Eof do
            begin
              linha := Trim(SqlAux1.Fields[0].AsString) +
                  format('%2.2d', [SqlAux1.Fields[1].AsInteger ]);
              if length(linha) = 13 then
                begin
                  Verifica(linha);
                  if Corrompido = true then
                    begin
                      LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                      PBConsistencia.Position  :=  PBConsistencia.Position + 1;
                          // corrompido
                    end
                  else
                    begin
                      Writeln(arquivo,linha);
                      LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                      LCDGrav.Refresh;
                    end;
                end;

              SqlAux1.Next;
              LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
              PbProgresso.Position := PbProgresso.Position + 1;
            end;

          if Corrompido = false then
            begin
              SqlAux2.Close;
              SqlAux2.Sql.Clear;
              SqlAux2.Sql.Add('UPDATE cga041 SET cg041_dtret = current_date ');
              SqlAux2.SQL.Add('WHERE cg041_dtbaixa BETWEEN :dtini AND :dtfin ');
              SqlAux2.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
              SqlAux2.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
              SqlAux2.Sql.Add(' AND cg041_dtret IS NULL');
              SqlAux2.ExecSql;
              SqlAux2.Close;
            end;

          Application.MessageBox('Gera��o de Arquivo Retorno Finalizada', 'Ads', IDOK);
          Closefile(arquivo);
          EdNomeArquivo.Text := fname;
          EdCaminho.Text := destdir;
        end;
    end; // \With
end;

procedure TFrmRetornoExtratos.seldrccrtfat; // drc private label
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('SELECT a.cg042_remes, b.cg20_codbrad ');
      SqlAux1.Sql.Add('FROM cga042 a ');
      SqlAux1.Sql.Add(' INNER JOIN cga20 b on b.cg20_codbaixa = a.cg042_codbaixa ');
      SqlAux1.Sql.Add('WHERE cg042_dtbaixa BETWEEN :dtini AND :dtfin ');
      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
      SqlAux1.Sql.Add('ORDER BY cg042_remes, b.cg20_codbrad');

      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      If SqlAux1.RecordCount < 1 then
        application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION)
      else
        begin
          PbProgresso.Max := SqlAux1.RecordCount;
          SqlAux1.First;
          try
            // Diret�rio onde colocar arquivos gerados
            destdir := GetCurrentDir + '\retorno\DRC\cartaofat\' +
                UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';
            if (not DirectoryExists(destdir))
                  AND (not SysUtils.ForceDirectories(destdir)) then
              raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);
            fname := 'RT_5237-4120.' + formatdatetime('dd', date);
            // Garantindo que n�o existe arquivo com a nomenclatura passada
            seq := 0;
            While FileExists(destdir + fname) do
              begin
                seq := seq + 1;
                fname := 'RT_5237-4120' +
                      formatdatetime('_' + IntToStr(seq) + '.dd', date);
              end;

            AssignFile(arquivo, destdir + fname);
            Rewrite(arquivo);
          except on E: Exception do
            Begin
              Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                              'de Registros de Retorno.' + #13+#10 +
                              'Por favor informe o ocorrido para a �rea de T.I..'),
                          'ADS', MB_OK + MB_ICONERROR);
              CloseFile(arquivo);
              exit;
            end;
          end; // \try 2

          ctareg := 1;
          While not SqlAux1.Eof do
            begin
              linha := Trim(SqlAux1.Fields[0].AsString) +
                    format('%2.2d', [SqlAux1.Fields[1].AsInteger ]);
              If length(linha) = 13 then
                begin
                  Verifica(linha);
                  if Corrompido = true then
                    begin
                      LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                      PBConsistencia.Position  :=  PBConsistencia.Position + 1;
                          // corrompido
                    end
                  else
                    begin
                      Writeln(arquivo,linha);
                      LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                      LCDGrav.Refresh;
                    end;

                end;

              SqlAux1.Next;
              LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
              PbProgresso.Position := PbProgresso.Position + 1;
            end;

          if Corrompido = false then
            begin
              SqlAux2.Close;
              SqlAux2.Sql.Clear;
              SqlAux2.Sql.Add('UPDATE cga042 SET cg042_dtret = CURRENT_DATE ');
              SqlAux2.SQL.Add('WHERE cg042_dtbaixa BETWEEN :dtini AND :dtfin ');
              SqlAux2.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
              SqlAux2.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
              SqlAux2.Sql.Add(' AND cg042_dtret IS NULL');
              SqlAux2.ExecSql;
              SqlAux2.Close;
            end;

          Application.MessageBox('Gera��o de Arquivo Retorno Finalizada',
                    'Ads', IDOK);
          Closefile(arquivo);
          EdNomeArquivo.Text := fname;
          EdCaminho.Text := destdir;
        end;
    end; // \With
end;

procedure TFrmRetornoExtratos.seldrczogmcsi; // Drc Zogbi MCSI
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('SELECT a.cg043_remes, b.cg20_codbrad ');
      SqlAux1.Sql.Add('FROM cga043 a ');
      SqlAux1.Sql.Add(' INNER JOIN cga20 b on b.cg20_codbaixa = a.cg043_codbaixa ');
      SqlAux1.Sql.Add('WHERE cg043_dtbaixa BETWEEN :dtini and :dtfin ');
      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

      SqlAux1.Sql.Add('ORDER BY cg043_remes, b.cg20_codbrad');

      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);

      If SqlAux1.RecordCount < 1 then
        application.MessageBox('N�o foi encontrado nenhum registro', 'Ads', MB_OK + MB_ICONINFORMATION)
      else
        begin
          PbProgresso.Max := SqlAux1.RecordCount;
          SqlAux1.First;
          try
            // Diret�rio onde colocar arquivos gerados
            destdir := GetCurrentDir + '\retorno\DRC\zogbmcsi\' +
                UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';
            if (not DirectoryExists(destdir))
                  AND (not SysUtils.ForceDirectories(destdir)) then
              raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);
            fname := 'RT_5237-4120.' + formatdatetime('dd', date);
            // Garantindo que n�o existe arquivo com a nomenclatura passada
            seq := 0;
            While FileExists(destdir + fname) do
              begin
                seq := seq + 1;
                fname := 'RT_5237-4120' +
                      formatdatetime('_' + IntToStr(seq) + '.dd', date);
              end;

            AssignFile(arquivo, destdir + fname);
            Rewrite(arquivo);
          except on E: Exception do
            Begin
              Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                              'de Registros de Retorno.' + #13+#10 +
                              'Por favor informe o ocorrido para a �rea de T.I..'),
                          'ADS', MB_OK + MB_ICONERROR);
              CloseFile(arquivo);
              exit;
            end;
          end; // \try 2


          ctareg := 1;
          while not SqlAux1.Eof do
            begin
              linha := Trim(SqlAux1.Fields[0].AsString) +
                    format('%2.2d',[SqlAux1.Fields[1].AsInteger ]);
              If length(linha) = 13 then
                begin
                  Verifica(linha);
                  if Corrompido = true then
                    begin
                      LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                      PBConsistencia.Position  :=  PBConsistencia.Position + 1;
                          // corrompido
                    end
                  else
                    begin
                      Writeln(arquivo,linha);
                      LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                      LCDGrav.Refresh;
                    end;

                end;

              SqlAux1.Next;
              LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
              PbProgresso.Position := PbProgresso.Position + 1;
            end;

          if Corrompido = false then
            begin
              SqlAux2.Close;
              SqlAux2.Sql.Clear;
              SqlAux2.Sql.Add('UPDATE cga043 SET cg043_dtret = CURRENT_DATE ');
              SqlAux2.SQL.Add('WHERE cg043_dtbaixa BETWEEN :dtini AND :dtfin ');
              SqlAux2.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
              SqlAux2.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
              SqlAux2.Sql.Add(' AND cg043_dtret is null');
              SqlAux2.ExecSql;
              SqlAux2.Close;
            end;

          Application.MessageBox('Gera��o de Arquivo Retorno Finalizada','Ads',IDOK);
          Closefile(arquivo);
          EdNomeArquivo.Text := fname;
          EdCaminho.Text := destdir;
        end;
    end; // \With
end;

procedure TFrmRetornoExtratos.seldrcbolamex; // Drc Boleto Amex
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('SELECT a.cg044_remes, b.cg20_codbrad ');
      SqlAux1.Sql.Add('FROM cga044 a ');
      SqlAux1.Sql.Add('INNER JOIN cga20 b on b.cg20_codbaixa = a.cg044_codbaixa ');
      SqlAux1.Sql.Add('WHERE cg044_dtbaixa BETWEEN :dtini AND :dtfin ');
      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;

      SqlAux1.Sql.Add('ORDER BY cg044_remes, b.cg20_codbrad');
      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      If SqlAux1.RecordCount < 1 then
        application.MessageBox('N�o foi encontrado nenhum registro',
              'Ads', MB_OK + MB_ICONINFORMATION)
      else
        begin
          PbProgresso.Max := SqlAux1.RecordCount;
          SqlAux1.First;
          try
            // Diret�rio onde colocar arquivos gerados
            destdir := GetCurrentDir + '\retorno\DRC\bolamex\' +
                UpperCase(FormatDateTime('yyyy\mmmm', Date)) + '\';
            if (not DirectoryExists(destdir))
                  AND (not SysUtils.ForceDirectories(destdir)) then
              raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);
            fname := 'RT_5237-4120.' + formatdatetime('dd', date);
            // Garantindo que n�o existe arquivo com a nomenclatura passada
            seq := 0;
            While FileExists(destdir + fname) do
              begin
                seq := seq + 1;
                fname := 'RT_5237-4120' +
                      formatdatetime('_' + IntToStr(seq) + '.dd', date);
              end;

            AssignFile(arquivo, destdir + fname);
            Rewrite(arquivo);
          except on E: Exception do
            Begin
              Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
                              'de Registros de Retorno.' + #13+#10 +
                              'Por favor informe o ocorrido para a �rea de T.I..'),
                          'ADS', MB_OK + MB_ICONERROR);
              CloseFile(arquivo);
              exit;
            end;
          end; // \try 2

          ctareg := 1;
          while not SqlAux1.Eof do
            begin
              linha := Trim(SqlAux1.Fields[0].AsString) +
                    format('%2.2d', [SqlAux1.Fields[1].AsInteger]);
              if length(linha) = 13 then
                begin
                  Verifica(linha);
                  if Corrompido = true then
                    begin
                      LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                      PBConsistencia.Position  :=  PBConsistencia.Position + 1;
                          // corrompido
                    end
                  else
                    begin
                      Writeln(arquivo,linha);
                      LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                      LCDGrav.Refresh;
                    end;

                end;

              SqlAux1.Next;
              LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
              PbProgresso.Position := PbProgresso.Position + 1;
            end;

          if Corrompido = false then
            begin
              SqlAux2.Close;
              SqlAux2.Sql.Clear;
              SqlAux2.Sql.Add('UPDATE cga044 SET cg044_dtret = CURRENT_DATE ');
              SqlAux2.SQL.Add('WHERE cg044_dtbaixa BETWEEN :dtini AND :dtfin ');
              SqlAux2.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
              SqlAux2.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
              SqlAux2.Sql.Add(' AND cg044_dtret IS NULL');
              SqlAux2.ExecSql;
              SqlAux2.Close;
            end;

          Application.MessageBox('Gera��o de Arquivo Retorno Finalizada','Ads',IDOK);
          Closefile(arquivo);
          EdNomeArquivo.Text := fname;
          EdCaminho.Text := destdir;
        end;
    end; // \With
end;
end.
