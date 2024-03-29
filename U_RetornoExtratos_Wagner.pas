unit U_RetornoExtratos;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask;

type
  TFrmRetornoExtratos = class(TForm)
    ScrollBox1: TScrollBox;
    BtnGerar: TBitBtn;
    BtnSair: TBitBtn;
    PbProgresso: TProgressBar;
    LCDTot: TStaticText;
    LCDLidos: TStaticText;
    LCDGrav: TStaticText;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    LCDErros: TStaticText;
    Panel5: TPanel;
    Panel6: TPanel;
    PBConsistencia: TProgressBar;
    Bevel1: TBevel;
    Panel7: TPanel;
    mkeddtini: TMaskEdit;
    Panel8: TPanel;
    mkeddtfin: TMaskEdit;
    ChkGerarSeparado: TCheckBox;
    EdNumeroSeparador: TEdit;
    ChkSepCodigoLeitura: TCheckBox;
    procedure Verifica(Str: string);
    procedure BtnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnGerarClick(Sender: TObject);
    procedure mkeddtiniExit(Sender: TObject);
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
  private
    caracterinvalido,Corrompido : boolean;
    sim:boolean;
    reenviados :array [0..0] of ShortInt;
    arquivo           : TextFile;
    arquivo_separado  : TextFile;
    linha             : string;
    separador_correto : bool;
    sel : string;
    ctareg:integer;
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
     (length(str) = 31) then
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

procedure TFrmRetornoExtratos.BtnSairClick(Sender: TObject);
begin
  close;
end;

procedure TFrmRetornoExtratos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := cafree;
end;

procedure TFrmRetornoExtratos.BtnGerarClick(Sender: TObject);
var
  i:integer;
begin
  LCDTot.Caption   := '0';
  LCDLidos.Caption := '0';
  LCDGrav.Caption  := '0';
  LCDErros.Caption := '0';
  PbProgresso.Position    := 0;
  PBConsistencia.Position := 0;
  BtnGerar.Enabled := false;
  case tag of
    1: // Consolidado
      begin
        Dm.SqlAux1.Close;
        Dm.SqlAux1.Sql.Clear;
//        Dm.SqlAux1.Sql.Add('select distinct on (cga68.cg68_remes) cga68.cg68_remes,cga20.cg20_codbrad ');
        Dm.SqlAux1.Sql.Add('select distinct(cga75.cg75_remes) ,cga20.cg20_codbrad ,cg75_tipo, cg75_dv, cg75_codag, cg75_conta, cg75_dtbaixa ');
       //                                         0                     1              2          3        4            5           6
        Dm.SqlAux1.Sql.Add('from cga75 inner join cga20 on cga20.cg20_codbaixa = cga75.cg75_codbaixa ');
        Dm.SqlAux1.Sql.Add('where (cg75_dtbaixa between ');
        Dm.SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39)+')');
        if application.MessageBox('Deseja que sejam reenviados registros?','Ads',MB_YESNO+MB_ICONQUESTION) = idno then
            Dm.SqlAux1.Sql.Add(' and (cg75_dtret is null)')
        else
            begin
            sim:=true;
            Dm.SqlAux1.Sql.Add(' and (cg75_dtret is not null )');
            end;
//        InputBox('','',Dm.SqlAux1.Sql.Text);
        Dm.SqlAux1.Open;
        LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
        case Dm.SqlAux1.RecordCount of
          0: application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION);
        else
          begin
            Dm.SqlAux1.First;
            PbProgresso.Max := Dm.SqlAux1.RecordCount;
            linha := 'f:\sistemas\retorno\unificado\rt_4237.0'+formatdatetime('dd',date);
            AssignFile(arquivo,linha);
            Rewrite(arquivo);
            for i:=1 to Dm.SqlAux1.RecordCount do
              begin
                linha := GeraNT(Dm.SqlAux1.Fields[4].AsString,4);
                linha := linha + copy(Dm.SqlAux1.Fields[3].AsString,1,1);
                linha := linha + GeraNT(Dm.SqlAux1.Fields[5].AsString,8);
                linha := linha + FormatDateTime('ddmmyyyy',(Dm.SqlAux1.Fields[6].AsDateTime));
                linha := linha + GeraNT(Dm.SqlAux1.Fields[2].AsString,2);
                linha := linha + GeraNT(Dm.SqlAux1.Fields[1].AsString,2);
                linha := linha + GeraNT('0',5);
                case length(linha) of
                  30:
                     begin
                       Verifica(linha);
                       if Corrompido = false then
                         begin
                           Writeln(arquivo,linha);
                           LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                         end;
                     end;
                else
                  begin
                    LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                  end;
                end;
                Dm.SqlAux1.Next;
                LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
                PbProgresso.Position := PbProgresso.Position + 1;
              end;
            Dm.SqlAux1.Close;
            Dm.SqlAux1.Sql.Clear;
            Dm.SqlAux1.Sql.Add('update cga75 set cg75_dtret ='+chr(39)+formatdatetime('mm-dd-yyy',date)+chr(39));
            if sim = false then
              dm.SqlAux1.Sql.Add(' , cg75_dtenv ='+chr(39) +formatdatetime('mm-dd-yyyy',date)+chr(39));
            dm.SqlAux1.Sql.Add(' where cg75_dtbaixa between ');
            Dm.SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39));
            Dm.SqlAux1.ExecSql;
            Dm.SqlAux1.Close;
            CloseFile(arquivo);
            Application.MessageBox('Gera��o de Arquivo Retorno Finalizada','Ads',MB_OK+MB_ICONINFORMATION);
            BtnGerar.Enabled := true;
          end;
        end;
      end;

    2: // extrato velho
      begin
        Dm.SqlAux1.Close;
        Dm.SqlAux1.Sql.Clear;
        Dm.SqlAux1.Sql.Add('select cga33.cg33_remes,cga20.cg20_codbrad,cg33_dtext,cg33_dtbaixa ');
        Dm.SqlAux1.Sql.Add(' from cga33 inner join cga20 on cga20.cg20_codbaixa = cga33.cg33_codbaixa ');
        Dm.SqlAux1.Sql.Add(' where (cg33_dtbaixa between ');
        Dm.SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39)+')');
        if application.MessageBox('Deseja que sejam reenviados registros?','Ads',MB_YESNO+MB_ICONQUESTION) = idno then
          begin
            Dm.SqlAux1.Sql.Add(' and (cg33_dtret is null)');
          end
        else
          begin
            Dm.SqlAux1.Sql.Add(' and (cg33_dtret <>' +chr(39)+'01-01-1950'+chr(39)+')');
          end;
        Dm.SqlAux1.Open;
        LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
        case Dm.SqlAux1.RecordCount of
          0: application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION);
        else
          begin
            Dm.SqlAux1.First;
            PbProgresso.Max := Dm.SqlAux1.RecordCount;
            linha := 'C:\RetornoExt\';
            if not(DirectoryExists(linha)) then
               MkDir(linha);
            linha :=  linha+'CCP3237.0'+formatdatetime('dd',date);
            AssignFile(arquivo,linha);
            Rewrite(arquivo);
            for i:=1 to Dm.SqlAux1.RecordCount do
              begin
                linha := GeraNT(dm.SqlAux1.Fields[0].AsString,14);
                linha := linha + formatdatetime('ddmmyyyy',dm.SqlAux1.Fields[2].AsDateTime);
                linha := linha + trim(dm.SqlAux1.Fields[1].AsString);
                linha := linha + formatdatetime('ddmmyyyy',dm.SqlAux1.Fields[3].AsDateTime)+'       ';
                case length(linha) of
                  38:
                     begin
                       Verifica(linha);
                       if Corrompido = false then
                         begin
                           Writeln(arquivo,linha);
                           LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                         end;
                     end;
                else
                  begin
                    // corrompido
                    LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                  end;
                end;
                Dm.SqlAux1.Next;
                LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
                PbProgresso.Position := PbProgresso.Position + 1;
              end;
            CloseFile(arquivo);
            Dm.SqlAux1.Close;
            Dm.SqlAux1.Sql.Clear;
            Dm.SqlAux1.Sql.Add('update cga33 set cg33_dtret ='+chr(39)+formatdatetime('mm-dd-yyy',date)+chr(39)+' where (cg33_dtbaixa between ');
            Dm.SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39));
            Dm.SqlAux1.Sql.Add(') and ((cg33_dtret <> '+chr(39)+'01-01-1950'+chr(39)+' or (cg33_dtret is null)))');
            Dm.SqlAux1.ExecSql;
            Application.MessageBox('Gera��o de Arquivo Retorno Finalizada','Ads',MB_OK+MB_ICONINFORMATION);
            BtnGerar.Enabled := true;
            Dm.SqlAux1.Close;
          end;
        end;
      end;
    3:  ///drc cobran�a
      begin
        Dm.SqlAux1.Close;
        Dm.SqlAux1.Sql.Clear;
        Dm.SqlAux1.Sql.Add('select cga100.cg100_remes,cga20.cg20_codbrad_drc');
        Dm.SqlAux1.Sql.Add(' from cga100 inner join cga20 on cga20.cg20_codbaixa = cga100.cg100_codbaixa ');
        Dm.SqlAux1.Sql.Add(' where (cg100_dtbaixa between ');
        Dm.SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39)+')');
//        if application.MessageBox('Deseja que sejam reenviados registros?','Ads',MB_YESNO+MB_ICONQUESTION) = idno then
//          begin
            Dm.SqlAux1.Sql.Add(' and (cg100_dtret is null)');
//            reenviados[0]:=0;
//          end
//        else
//          begin
//            Dm.SqlAux1.Sql.Add(' and (cg100_dtret is not null)');
//            reenviados[0]:=1;
//          end;
//        if ChkSepCodigoLeitura.Checked = True then
        Dm.SqlAux1.Sql.Add(' order by cg100_remes');
        Dm.SqlAux1.Open;
        LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
        case Dm.SqlAux1.RecordCount of
          0: application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION);
          else
            begin
              PbProgresso.Max := Dm.SqlAux1.RecordCount;
              Dm.SqlAux1.Open;
              Dm.SqlAux1.First;
              linha := 'F:\sistemas\Retorno\drc\rt_5237-4120.0'+formatdatetime('dd',date);
              AssignFile(arquivo,linha);
              Rewrite(arquivo);
{              if ChkGerarSeparado.Checked = True then
                begin
                  linha := 'F:\sistemas\retorno\drc\rt_5237-4120-'+Trim(EdNumeroSeparador.Text)+'.0'+formatdatetime('dd',date);
                  AssignFile(arquivo_separado,linha);
                  Rewrite(arquivo_separado);
                end;}
              while not(Dm.SqlAux1.Eof)  do
                begin
                  linha := Trim(dm.SqlAux1.Fields[0].AsString);
{                  if ChkGerarSeparado.Checked = True then
                    begin
                      if ((StrToInt64(linha)) < StrToInt64(Trim(EdNumeroSeparador.Text))) then
                          separador_correto := False
                        else
                          separador_correto := True;
                    end;}
                  case length(trim(linha)) of
                    11,12,13,18:
                      begin
                        Verifica(linha);
                        if Corrompido = false then
                          begin
                            linha := linha + gerant(dm.SqlAux1.Fields[1].AsString,2);
                            Writeln(arquivo,linha);
                     //       if (ChkGerarSeparado.Checked = True) and (separador_correto = True) then
                      //        Writeln(arquivo,linha);
                            LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                          end;
                      end;
                    else
                      begin
                        LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                        // corrompido
                      end;
                  end;
                  Dm.SqlAux1.Next;
                  LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
                  PbProgresso.Position := PbProgresso.Position + 1;
                end;
              {if ChkGerarSeparado.Checked = True then
                CloseFile(arquivo_separado);}
              CloseFile(arquivo);
              Dm.SqlAux1.Close;
              Dm.SqlAux1.Sql.Clear;
//              Dm.SqlAux1.Sql.Add('update cga100 set cg100_dtret ='+chr(39)+formatdatetime('mm-dd-yyy',date)+chr(39));
//              if sim = false then
//                dm.SqlAux1.Sql.Add(' ,cg100_dtenv ='+chr(39) +formatdatetime('mm-dd-yyyy',date)+chr(39));
//              dm.SqlAux1.Sql.Add(' where cg100_dtbaixa between ');
//              Dm.SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39));
//              Dm.SqlAux1.ExecSql;
//              Dm.SqlAux1.Close;
              Application.MessageBox('Gera��o de Arquivo Retorno Finalizada','Ads',MB_OK+MB_ICONINFORMATION);
              BtnGerar.Enabled := true;
            end;
        end;
      end;
    4: // Unificado
      begin
        Dm.SqlAux1.Close;
        Dm.SqlAux1.Sql.Clear;
//        Dm.SqlAux1.Sql.Add('select distinct on (cga68.cg68_remes) cga68.cg68_remes,cga20.cg20_codbrad ');
        Dm.SqlAux1.Sql.Add('select distinct(cga68.cg68_remes) ,cga20.cg20_codbrad,cga68.cg68_dtbaixa ');
       //
        Dm.SqlAux1.Sql.Add('from cga68 inner join cga20 on cga20.cg20_codbaixa = cga68.cg68_codbaixa ');
        Dm.SqlAux1.Sql.Add('where (cg68_dtbaixa between ');
        Dm.SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39)+')');
        if application.MessageBox('Deseja que sejam reenviados registros?','Ads',MB_YESNO+MB_ICONQUESTION) = idno then
            Dm.SqlAux1.Sql.Add(' and (cg68_dtret is null)')
        else
            begin
            sim:=true;
            Dm.SqlAux1.Sql.Add(' and (cg68_dtret is not null )');
            end;
        //InputBox('','',Dm.SqlAux1.Sql.Text);
        Dm.SqlAux1.Open;
        LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
        case Dm.SqlAux1.RecordCount of
          0: application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION);
        else
          begin
            Dm.SqlAux1.First;
            PbProgresso.Max := Dm.SqlAux1.RecordCount;
            linha := 'C:\RetornoExt\UNI4237.0'+formatdatetime('dd',date);
            try AssignFile(arquivo,linha);
            except on e: exception do
              begin
                Application.MessageBox(PChar('Erro ao Criar o Arquivo: '+linha+' '+e.Message+' !'),'ADS - Unificado',64);
                exit
              end;
            end;
            Rewrite(arquivo);
            for i:=1 to Dm.SqlAux1.RecordCount do
              begin
                linha := copy(Dm.SqlAux1.Fields[0].AsString,1,23);
                linha := linha + GeraNT(Dm.SqlAux1.Fields[1].AsString,2);
                linha := linha +copy(Dm.SqlAux1.Fields[0].AsString,24,4)+'0';
                linha := linha+formatdatetime('ddmmyyyy',dm.SqlAux1.Fields[2].AsDateTime);
                case length(linha) of
                  30,38:
                     begin
                       Verifica(linha);
                       if Corrompido = false then
                         begin
                           Writeln(arquivo,linha);
                           LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                         end;
                     end;
                else
                  begin
                    LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                  end;
                end;
                Dm.SqlAux1.Next;
                LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
                PbProgresso.Position := PbProgresso.Position + 1;
              end;
            Dm.SqlAux1.Close;
            Dm.SqlAux1.Sql.Clear;
            Dm.SqlAux1.Sql.Add('update cga68 set cg68_dtret ='+chr(39)+formatdatetime('mm-dd-yyy',date)+chr(39));
            if sim = false then
              dm.SqlAux1.Sql.Add(' , cg68_dtenv ='+chr(39) +formatdatetime('mm-dd-yyyy',date)+chr(39));
            dm.SqlAux1.Sql.Add(' where cg68_dtbaixa between ');
            Dm.SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39));
            Dm.SqlAux1.ExecSql;
            Dm.SqlAux1.Close;
            CloseFile(arquivo);
            Application.MessageBox('Gera��o de Arquivo Retorno Finalizada','Ads',MB_OK+MB_ICONINFORMATION);
            BtnGerar.Enabled := true;
          end;
        end;
      end;
    5:
      begin
      end;
    6: // extrato cartao bradesco
      begin
        Dm.SqlAux1.Close;
        Dm.SqlAux1.Sql.Clear;
        Dm.SqlAux1.Sql.Add('select distinct (cga67.cg67_remes) ,cga20.cg20_codbrad ');
        Dm.SqlAux1.Sql.Add(' from cga67 inner join cga20 on cga20.cg20_codbaixa = cga67.cg67_codbaixa ');
        Dm.SqlAux1.Sql.Add(' where (cg67_dtbaixa between ');
        Dm.SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39)+')');
        if application.MessageBox('Deseja que sejam reenviados registros?','Ads',MB_YESNO+MB_ICONQUESTION) = idno then
          Dm.SqlAux1.Sql.Add(' and (cg67_dtret is null)')
        else
          begin
            sim:=true;
            Dm.SqlAux1.Sql.Add(' and (cg67_dtret is not null )');
          end;
        Dm.SqlAux1.Open;
        LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
        case Dm.SqlAux1.RecordCount of
          0: application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION);
        else
          begin
            Dm.SqlAux1.First;
            PbProgresso.Max := Dm.SqlAux1.RecordCount;
            linha := 'f:\sistemas\retorno\cartao\rt_5237.0'+formatdatetime('dd',date);
            AssignFile(arquivo,linha);
            Rewrite(arquivo);
            linha := '1058'+formatdatetime('yyyymmdd',date);
            Writeln(arquivo,linha);
            linha := '';
            for i:=1 to Dm.SqlAux1.RecordCount do
              begin
                linha := '2'+Dm.SqlAux1.Fields[0].AsString+GeraNT(Dm.SqlAux1.Fields[1].AsString,2)+formatdatetime('yyyymmdd',date);
                case length(linha) of
                  43:
                     begin
                       Verifica(linha);
                       if Corrompido = false then
                         begin
                           Writeln(arquivo,linha);
                           LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                         end;
                     end;
                else
                  begin
                    LCDErros.Caption := inttostr(1+strtoint(LCDErros.Caption));
                  end;
                end;
                Dm.SqlAux1.Next;
                LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
                PbProgresso.Position := PbProgresso.Position + 1;
              end;
            linha := '9058'+formatdatetime('yyyymmdd',date)+gerant(IntToStr(Dm.SqlAux1.RecordCount+2),9);
            Writeln(arquivo,linha);
            CloseFile(arquivo);
            Dm.SqlAux1.Close;
            Dm.SqlAux1.Sql.Clear;
            Dm.SqlAux1.Sql.Add('update cga67 set cg67_dtret ='+chr(39)+formatdatetime('mm-dd-yyy',date)+chr(39));
            if sim = false then
              dm.SqlAux1.Sql.Add(' , cg67_dtenv ='+chr(39) +formatdatetime('mm-dd-yyyy',date)+chr(39));
            dm.SqlAux1.Sql.Add(' where cg67_dtbaixa between ');
            Dm.SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39));
            Dm.SqlAux1.ExecSql;
            Application.MessageBox('Gera��o de Arquivo Retorno Finalizada','Ads',MB_OK+MB_ICONINFORMATION);
            BtnGerar.Enabled := true;
          end;
        end;
      end;
    07: seldrccrt;  // drc carta convite
    08: selcrtseg;  // cartao seguranca
    09: selcodetq;  // baixa codigo de etica
    10: seltokens;  // tokens
    11: selcadetq; // cadastro codigo de etica
    12: selfatcardcred; // Baixa Fatura Cart�o de Credito.
    13: seldrccllp;   // Drc - Aviso de Cobran�a
    14: selcrtsenha; // Bradesco Adm. Consorcio
    15: selconsorcio; // Bradesco Adm. Consorcio
  end; //fim do case
  BtnGerar.Enabled := true;
end;
procedure TFrmRetornoExtratos.mkeddtiniExit(Sender: TObject);
begin
  try
    mkeddtfin.Text := formatdatetime('dd/mm/yyyy',(6+StrToDate(mkeddtini.Text)));
  except
  end;
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
  mkeddtini.SetFocus;
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
      SqlAux1.Sql.Add('select distinct(cga120.cg120_remes),cga20.cg20_codbrad_drc');
      SqlAux1.Sql.Add(' from cga120 inner join cga20 on cga20.cg20_codbaixa = cga120.cg120_codbaixa ');
      SqlAux1.Sql.Add(' where (cg120_dtbaixa between ');
      SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39)+')');
      if application.MessageBox('Deseja que sejam reenviados registros?','Ads',MB_YESNO+MB_ICONQUESTION) = idno then
        begin
          SqlAux1.Sql.Add(' and (cg120_dtret is null)');
        end
      else
        begin
          SqlAux1.Sql.Add(' and (cg120_dtret is not null)');
          sim:=true;
          //InputBox('','',SqlAux1.SQL.Text);
        end;
      Dm.SqlAux1.Sql.Add(' order by cg120_remes');
      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      case SqlAux1.RecordCount of
        0: application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION);
        else
          begin
            PbProgresso.Max := Dm.SqlAux1.RecordCount;
            SqlAux1.First;
            linha := 'F:\sistemas\retorno\drccarta\rt_5237-4120.0'+formatdatetime('dd',date);
            //essa linha abaixo � apenas para testes
            //linha := 'c:\temp\rt_5237-4120.0'+formatdatetime('dd',date);
            AssignFile(arquivo,linha);
            Rewrite(arquivo);
            while not SqlAux1.Eof do
              begin
                linha := Trim(dm.SqlAux1.Fields[0].AsString);
                linha := linha + gerant(SqlAux1.Fields[1].AsString,2);
                case length(linha) of
                  13,17,18,19:
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
                      end;
                    end;
                end;
                //Writeln(arquivo,linha);
                //LCDGrav.Caption := inttostr(1+strtoint(LCDGrav.Caption));
                SqlAux1.Next;
                LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
                PbProgresso.Position  :=  PbProgresso.Position + 1;
              end;
              SqlAux1.Close;
              SqlAux1.Sql.Clear;
              SqlAux1.Sql.Add('update cga120 set cg120_dtret ='+chr(39)+formatdatetime('mm-dd-yyy',date)+chr(39));
              if sim = false then
                  SqlAux1.Sql.Add(' ,cg120_dtenv ='+chr(39) +formatdatetime('mm-dd-yyyy',date)+chr(39));
              SqlAux1.Sql.Add(' where cg120_dtbaixa between ');
              SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39));
              SqlAux1.ExecSql;
              SqlAux1.Close;
              Application.MessageBox('Gera��o de Arquivo Retorno Finalizada','Ads',MB_OK+MB_ICONINFORMATION);
          end;
        CloseFile(arquivo);
      end;
    end;
end;

procedure TFrmRetornoExtratos.selfatcardcred;
var testo : string;
conta : Integer;
begin
  sel := 'SELECT cgafatcrtcrd.cgfatcrtcrd_remes,cga20.cg20_codbrad_drc,cgafatcrtcrd.cgfatcrtcrd_dtbaixa ';
  sel := sel + 'from cgafatcrtcrd inner join cga20 on cga20.cg20_codbaixa = cgafatcrtcrd.cgfatcrtcrd_codbaixa ';
  sel := sel + 'where cgafatcrtcrd.cgfatcrtcrd_dtbaixa between '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(mkeddtini.Text))+Chr(39)+' and ';
  sel := sel + Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(mkeddtfin.Text))+Chr(39)+'';
//  sel := sel + ' and cgfatcrtcrd_dtret is null';
  with Dm.SqlAux1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add(sel);
      Open;
    end;
  case Dm.SqlAux1.RecordCount of
  0:
    begin
      Application.MessageBox('N�o foi localizado registros com esses parametros!!!','ADS',0);
      mkeddtini.SetFocus;
      Exit;
    end
  else
    begin
      PbProgresso.Max := Dm.SqlAux1.RecordCount;
      Dm.SqlAux1.First;
      linha := 'C:\RetornoExt\';
      if not (DirectoryExists(linha)) then
        MkDir(linha);
      linha:=linha+'FatCartao.0'+formatdatetime('dd',date);

      AssignFile(arquivo,linha);
      Rewrite(arquivo);
      linha := '1000'+FormatDateTime('yyyymmdd',Date)+GeraArquivo(testo,38);
      Writeln(arquivo,linha);
      conta := 1;
      while not Dm.SqlAux1.Eof do
        begin
          linha := '2';
          linha := linha + Trim(Dm.SqlAux1.Fields.Fields[0].AsString);
          linha := linha + Trim(Dm.SqlAux1.Fields.Fields[1].AsString);
          linha := linha + FormatDateTime('yyyymmdd',Date);
          linha := linha + GeraArquivo(testo,5);
          linha := linha + formatdatetime('ddmmyyyy',dm.SqlAux1.Fields[2].AsDateTime);
          LCDGrav.Caption       := inttostr(1+strtoint(LCDGrav.Caption));
          LCDLidos.Caption      := inttostr(1+strtoint(LCDLidos.Caption));
          PbProgresso.Position  := PbProgresso.Position + 1;
          Writeln(arquivo,linha);
          Dm.SqlAux1.Next;
          conta := conta + 1;
        end;
      conta := conta + 1;
      linha := '9000'+FormatDateTime('yyyymmdd',Date);
      linha := linha + GeraNT(IntToStr(conta),9);
      linha := linha + GeraArquivo(testo,29);
      Writeln(arquivo,linha);
      CloseFile(arquivo);
      sel := 'UPDATE cgafatcrtcrd set cgfatcrtcrd_dtret = '+Chr(39)+FormatDateTime('mm-dd-yyyy',Date)+Chr(39);
      sel := sel + ' WHERE cgafatcrtcrd.cgfatcrtcrd_dtbaixa between '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(mkeddtini.Text))+Chr(39);
      sel := sel + ' and '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(mkeddtfin.Text))+Chr(39);
      sel := sel + ' and cgfatcrtcrd_dtret is null';
      with Dm.SqlAux1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add(sel);
          ExecSQL;
        end;
      ShowMessage('Gera��o Concluida !!!');
    end;
  end;
end;

procedure TFrmRetornoExtratos.selcrtseg;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('select cga130.cg130_remes,to_char(cga130.cg130_dtbaixa,''ddmmyyyy''),cga20.cg20_codbrad');
      SqlAux1.Sql.Add(' from cga130 inner join cga20 on cga20.cg20_codbaixa = cga130.cg130_codbaixa ');
      SqlAux1.Sql.Add(' where (cg130_dtbaixa between ');
      SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39)+')');
      if application.MessageBox('Deseja que sejam reenviados registros?','Ads',MB_YESNO+MB_ICONQUESTION) = idno then
        begin
          SqlAux1.Sql.Add(' and (cg130_dtret is null)');
        end
      else
        begin
          SqlAux1.Sql.Add(' and (cg130_dtret is not null)');
          sim:=true;
        end;
      SqlAux1.Sql.Add(' order by cg130_remes');
      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      case SqlAux1.RecordCount of
        0: application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION);
        else
          begin
            PbProgresso.Max := Dm.SqlAux1.RecordCount;
            SqlAux1.First;
            linha := 'C:\RetornoExt\';
            if not (DirectoryExists(linha)) then
              MkDir(linha);
            linha:=linha+'CrtSeg.0'+formatdatetime('dd',date);
//            linha:=linha+'rt_5237-4120.0'+formatdatetime('dd',date);
//            linha := 'C:\RetornoExt\CrtSeg.0'+formatdatetime('dd',date);
            //essa linha abaixo � apenas para testes
            //linha := 'c:\temp\rt_5237-4120.0'+formatdatetime('dd',date);

            AssignFile(arquivo,linha);
            Rewrite(arquivo);
            ctareg:=0;
            while not SqlAux1.Eof do
              begin
                linha := trim(SqlAux1.Fields[0].AsString);
                linha := linha  + SqlAux1.Fields[1].AsString;
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
                end;
                SqlAux1.Next;
                LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
                PbProgresso.Position := PbProgresso.Position + 1;
              end;
              SqlAux1.Close;
              SqlAux1.Sql.Clear;
              SqlAux1.Sql.Add('update cga130 set cg130_dtret ='+chr(39)+formatdatetime('mm-dd-yyy',date)+chr(39));
              if sim = false then
                  SqlAux1.Sql.Add(' ,cg130_dtenv ='+chr(39) +formatdatetime('mm-dd-yyyy',date)+chr(39));
              SqlAux1.Sql.Add(' where (cg130_dtbaixa between ');
              SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39)+') and (cg130_dtret is null)');
              SqlAux1.ExecSql;
              SqlAux1.Close;
              Application.MessageBox('Gera��o de Arquivo Retorno Finalizada','Ads',MB_OK+MB_ICONINFORMATION);
          end;
        CloseFile(arquivo);
      end;
    end;
end;
procedure TFrmRetornoExtratos.selcodetq;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('select cga140.cg140_remes, to_char(cga140.cg140_dtbxa,'+chr(39)+'ddmmyyyy'+chr(39)+'),cg140_codbxa ');
      SqlAux1.Sql.Add('from cga140 ');
      SqlAux1.Sql.Add('where (cg140_dtbxa between ');
      SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39)+')');
      if application.MessageBox('Deseja que sejam reenviados registros?','Ads',MB_YESNO+MB_ICONQUESTION) = idno then
        begin
          SqlAux1.Sql.Add(' and (cg140_dtret is null)');
        end
      else
        begin
          SqlAux1.Sql.Add(' and (cg140_dtret is not null)');
          sim:=true;
        end;
      SqlAux1.Sql.Add(' order by cg140_remes');
      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      case SqlAux1.RecordCount of
        0: application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION);
        else
          begin
            PbProgresso.Max := Dm.SqlAux1.RecordCount;
            SqlAux1.First;
            linha := 'F:\sistemas\retorno\codigoetica\rt_5237-4120.0'+formatdatetime('dd',date);
            //essa linha abaixo � apenas para testes
            //linha := 'c:\temp\rt_5237-4120.0'+formatdatetime('dd',date);

            AssignFile(arquivo,linha);
            Rewrite(arquivo);
            while not SqlAux1.Eof do
              begin
                linha := Trim(SqlAux1.Fields[0].AsString);
                linha := linha + SqlAux1.Fields[1].AsString;
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
                end;
                SqlAux1.Next;
                LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
                PbProgresso.Position := PbProgresso.Position + 1;
              end;
              SqlAux1.Close;
              SqlAux1.Sql.Clear;
              SqlAux1.Sql.Add('update cga140 set cg140_dtret ='+chr(39)+formatdatetime('mm-dd-yyy',date)+chr(39));
              if sim = false then
                  SqlAux1.Sql.Add(' ,cg140_dtenv ='+chr(39) +formatdatetime('mm-dd-yyyy',date)+chr(39));
              SqlAux1.Sql.Add(' where (cg140_dtbxa between ');
              SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39)+') and (cg140_dtret is null)');
              SqlAux1.ExecSql;
              SqlAux1.Close;
              Application.MessageBox('Gera��o de Arquivo Retorno Finalizada','Ads',MB_OK+MB_ICONINFORMATION);
          end;
        CloseFile(arquivo);
      end;
    end;
end;
procedure TFrmRetornoExtratos.seltokens;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('select cg76_remes, to_char(cg76_dtsai,'+chr(39)+'dd/mm/yyyy'+chr(39)+'),cg76_ag');
      SqlAux1.Sql.Add(',cg76_tipocli,cg76_dtb from cga76 ');
      SqlAux1.Sql.Add('where (cg76_dtsai between ');
      SqlAux1.Sql.Add(''+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39)+')');
      if application.MessageBox('Deseja que sejam reenviados registros?','Ads',MB_YESNO+MB_ICONQUESTION) = idno then
        begin
          SqlAux1.Sql.Add(' and (cg76_dtret is null)');
        end
      else
        begin
          SqlAux1.Sql.Add(' and (cg76_dtret is not null)');
          sim:=true;
        end;
      SqlAux1.Sql.Add(' order by cg76_remes');
      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      case SqlAux1.RecordCount of
        0: application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION);
        else
          begin
            PbProgresso.Max := Dm.SqlAux1.RecordCount;
            SqlAux1.First;
            linha := 'F:\sistemas\retorno\token\rt_9237-4120.0'+formatdatetime('dd',date);
            //essa linha abaixo � apenas para testes
            //linha := 'c:\temp\rt_5237-4120.0'+formatdatetime('dd',date);

            AssignFile(arquivo,linha);
            Rewrite(arquivo);
            while not SqlAux1.Eof do
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
              SqlAux1.Sql.Add('update cga76 set cg76_dtret ='+chr(39)+formatdatetime('mm-dd-yyy',date)+chr(39));
              if sim = false then
                  SqlAux1.Sql.Add(' ,cg76_dtenv ='+chr(39) +formatdatetime('mm-dd-yyyy',date)+chr(39));
              SqlAux1.Sql.Add(' where (cg76_dtsai between ');
              SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39)+') and (cg76_dtret is null)');
              SqlAux1.ExecSql;
              SqlAux1.Close;
              Application.MessageBox('Gera��o de Arquivo Retorno Finalizada','Ads',MB_OK+MB_ICONINFORMATION);
          end;
        CloseFile(arquivo);
      end;
    end;
end;
procedure TFrmRetornoExtratos.selcadetq;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('select cga140.cg140_remes, to_char(cga140.cg140_dtcad,'+chr(39)+'ddmmyyyy'+chr(39)+'),cg140_codbxa ');
      SqlAux1.Sql.Add('from cga140 ');
      SqlAux1.Sql.Add('where (cg140_dtcad between ');
      SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39)+')');
      sim:=true;
      SqlAux1.Sql.Add(' order by cg140_remes');
      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      case SqlAux1.RecordCount of
        0: application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION);
        else
          begin
            PbProgresso.Max := Dm.SqlAux1.RecordCount;
            SqlAux1.First;
            linha := 'F:\sistemas\retorno\codigoetica\rt_5237-4120.0'+formatdatetime('dd',date);
            //essa linha abaixo � apenas para testes
            //linha := 'c:\temp\rt_5237-4120.0'+formatdatetime('dd',date);

            AssignFile(arquivo,linha);
            Rewrite(arquivo);
            while not SqlAux1.Eof do
              begin
                linha := Trim(SqlAux1.Fields[0].AsString);
                linha := linha + SqlAux1.Fields[1].AsString;
                //linha := linha + SqlAux1.Fields[2].AsString;
                case length(linha) of
                  28:
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
                end;
                SqlAux1.Next;
                LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
                PbProgresso.Position := PbProgresso.Position + 1;
              end;
              SqlAux1.Close;
              SqlAux1.Sql.Clear;
              SqlAux1.Sql.Add('update cga140 set cg140_dtret ='+chr(39)+formatdatetime('mm-dd-yyy',date)+chr(39));
              if sim = false then
                  SqlAux1.Sql.Add(' ,cg140_dtenv ='+chr(39) +formatdatetime('mm-dd-yyyy',date)+chr(39));
              SqlAux1.Sql.Add(' where (cg140_dtbxa between ');
              SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39)+') and (cg140_dtret is null)');
              SqlAux1.ExecSql;
              SqlAux1.Close;
              Application.MessageBox('Gera��o de Arquivo Retorno Finalizada','Ads',MB_OK+MB_ICONINFORMATION);
          end;
        CloseFile(arquivo);
      end;
    end;
end;

procedure TFrmRetornoExtratos.seldrccllp;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;//alterado at� regerar
      SqlAux1.Sql.Add('select distinct(cga78.cg78_remes),cga20.cg20_codbrad,cga78.cg78_dtbaixa ');
      //to_char(cga78.cg78_dtbaixa,'+chr(39)+'ddmmyyyy'+chr(39)+'),
      SqlAux1.Sql.Add('from cga78 inner join cga20 on cga20.cg20_codbaixa = cga78.cg78_codbaixa ');
      SqlAux1.Sql.Add('where (cg78_dtbaixa between :dtini and :dtfin) ');
//      sim:=true;
      SqlAux1.Sql.Add('order by cg78_remes,cga20.cg20_codbrad');
      SqlAux1.Params[0].AsString  :=  FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text));
      SqlAux1.Params[1].AsString  :=  FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text));
      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      case SqlAux1.RecordCount of
        0: application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION);
        else
          begin
            PbProgresso.Max := SqlAux1.RecordCount;
            SqlAux1.First;
            linha := 'C:\RetornoExt\';
            if not(DirectoryExists(linha)) then
               MkDir(linha);
            linha :=  linha+'CLLP.0'+formatdatetime('dd',date);
            Application.MessageBox(PChar('Arquivo : '+linha),'ADS',0);
                        //essa linha abaixo � apenas para testes
            //linha := 'c:\temp\rt_5237-4120.0'+formatdatetime('dd',date);
            try
            AssignFile(arquivo,linha);
            except on e: exception do
              begin
                Application.MessageBox(PChar('Arquivo : '+linha+' n�o foi poss�vel abrir'),'ADS',0);
                exit;
              end;
            end;
            Rewrite(arquivo);
            linha:='@ADDRESS LOGISTICA    '+  format('%9.9s%',[' ']);
            Writeln(arquivo,linha);
            while not SqlAux1.Eof do
              begin
                linha := Trim(SqlAux1.Fields[0].AsString);
                linha := linha + format('%2.2d',[SqlAux1.Fields[1].AsInteger ]);
                linha := linha + formatdatetime('ddmmyyyy',SqlAux1.Fields[2].AsDateTime);
                case length(linha) of
                  39:
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
                end;
                SqlAux1.Next;
                LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
                PbProgresso.Position := PbProgresso.Position + 1;
              end;
              linha:= '*'+format('%9.9d',[strtoint(LCDGrav.caption)])+format('%21.21s%',[' ']);
              Writeln(arquivo,linha);
              SqlAux1.Close;
              SqlAux1.Sql.Clear;
              SqlAux1.Sql.Add('update cga78 set cg78_dtret ='+chr(39)+formatdatetime('mm-dd-yyy',date)+chr(39));
              if sim = false then
                  SqlAux1.Sql.Add(' ,cg78_dtenv ='+chr(39) +formatdatetime('mm-dd-yyyy',date)+chr(39));
              SqlAux1.Sql.Add(' where (cg78_dtbaixa between ');
              SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39)+') and (cg78_dtret is null)');
              SqlAux1.ExecSql;
              SqlAux1.Close;
              Application.MessageBox('Gera��o de Arquivo Retorno Finalizada','Ads',MB_OK+MB_ICONINFORMATION);
          end;
        closefile(arquivo);
      end;
    end;
end;
procedure TFrmRetornoExtratos.selcrtsenha;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;//alterado at� regerar
//      SqlAux1.Sql.Add('select distinct(cga035.cg035_remes),cga20.cg20_codbrad ');
      SqlAux1.Sql.Add('select cga035.cg035_remes,cga20.cg20_codbrad,cga035.cg035_dtbaixa ');
      //to_char(cga78.cg78_dtbaixa,'+chr(39)+'ddmmyyyy'+chr(39)+'),
      SqlAux1.Sql.Add('from cga035 inner join cga20 on cga20.cg20_codbaixa = cga035.cg035_codbaixa ');
      SqlAux1.Sql.Add('where (cg035_dtbaixa between :dtini and :dtfin) ');
//      sim:=true;
      SqlAux1.Sql.Add('order by cg035_remes,cga20.cg20_codbrad');
      SqlAux1.Params[0].AsString  :=  FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text));
      SqlAux1.Params[1].AsString  :=  FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text));
      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      case SqlAux1.RecordCount of
        0: application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION);
        else
          begin
            PbProgresso.Max := SqlAux1.RecordCount;
            SqlAux1.First;
            linha := 'C:\RetornoExt\';
            if not(DirectoryExists(linha)) then
              MkDir(linha);
            linha :=  linha+'CrtSen.0'+formatdatetime('dd',date);
            Application.MessageBox(PChar('Arquivo : '+linha),'ADS',0);
                        //essa linha abaixo � apenas para testes
            //linha := 'c:\temp\rt_5237-4120.0'+formatdatetime('dd',date);
            try
            AssignFile(arquivo,linha);
            except on e: exception do
              begin
                Application.MessageBox(PChar('Arquivo : '+linha+' n�o foi poss�vel abrir'),'ADS',0);
                exit;
              end;
            end;
            Rewrite(arquivo);
            linha:='@ADDRESS LOGISTICA    '+  format('%9.9s%',[' ']);
            Writeln(arquivo,linha);
            ctareg:=1;
            while not SqlAux1.Eof do
              begin
                linha := Trim(SqlAux1.Fields[0].AsString);
                linha := linha + format('%2.2d',[SqlAux1.Fields[1].AsInteger ]);
                linha := linha + formatdatetime('ddmmyyyy',SqlAux1.Fields[2].AsDateTime);
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
                end;
                SqlAux1.Next;
                LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
                PbProgresso.Position := PbProgresso.Position + 1;
              end;
              linha:= '*'+format('%9.9d',[strtoint(LCDGrav.caption)])+format('%21.21s%',[' ']);
              Writeln(arquivo,linha);
              SqlAux1.Close;
              SqlAux1.Sql.Clear;
              SqlAux1.Sql.Add('update cga035 set cg035_dtret =(select current_date) where (cg035_dtbaixa between ');
              SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39)+') and (cg035_dtret is null)');
              SqlAux1.ExecSql;
              SqlAux1.Close;
              Application.MessageBox('Gera��o de Arquivo Retorno Finalizada','Ads',MB_OK+MB_ICONINFORMATION);
              closefile(arquivo);
          end;
      end;
    end;
end;
procedure TFrmRetornoExtratos.selconsorcio;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;//alterado at� regerar
//      SqlAux1.Sql.Add('select distinct(cga036.cg036_remes),cga20.cg20_codbrad ');
      //to_char(cga78.cg78_dtbaixa,'+chr(39)+'ddmmyyyy'+chr(39)+'),
      SqlAux1.Sql.Add('select cga036.cg036_remes,cga20.cg20_codbrad,cga036.cg036_dtbaixa ');
      SqlAux1.Sql.Add('from cga036 inner join cga20 on cga20.cg20_codbaixa = cga036.cg036_codbaixa ');
      SqlAux1.Sql.Add('where (cg036_dtbaixa between :dtini and :dtfin) ');
//      sim:=true;
      SqlAux1.Sql.Add('order by cg036_remes,cga20.cg20_codbrad');
      SqlAux1.Params[0].AsString  :=  FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text));
      SqlAux1.Params[1].AsString  :=  FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text));
      SqlAux1.Open;
      LCDTot.Caption := inttostr(Dm.SqlAux1.RecordCount);
      case SqlAux1.RecordCount of
        0: application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION);
        else
          begin
            PbProgresso.Max := SqlAux1.RecordCount;
            SqlAux1.First;

            linha := 'C:\RetornoExt\';
            if not(DirectoryExists(linha)) then
              MkDir(linha);
            linha:=linha+'ExtCons.0'+formatdatetime('dd',date);
            Application.MessageBox(PChar('Arquivo : '+linha),'ADS',0);
                        //essa linha abaixo � apenas para testes
            //linha := 'c:\temp\rt_5237-4120.0'+formatdatetime('dd',date);
            try
            AssignFile(arquivo,linha);
            except on e: exception do
              begin
                Application.MessageBox(PChar('Arquivo : '+linha+' n�o foi poss�vel abrir'),'ADS',0);
                exit;
              end;
            end;
            Rewrite(arquivo);
            linha:='@ADDRESS LOGISTICA    '+  format('%9.9s%',[' ']);
            Writeln(arquivo,linha);
            ctareg:=1;
            while not SqlAux1.Eof do
              begin
                linha := Trim(SqlAux1.Fields[0].AsString);
                linha := linha + format('%2.2d',[SqlAux1.Fields[1].AsInteger ]);
                linha := linha + formatdatetime('ddmmyyyy',dm.SqlAux1.Fields[2].AsDateTime);
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
                end;
                SqlAux1.Next;
                LCDLidos.Caption := inttostr(1+strtoint(LCDLidos.Caption));
                PbProgresso.Position := PbProgresso.Position + 1;
              end;
              linha:= '*'+format('%9.9d',[strtoint(LCDGrav.caption)])+format('%21.21s%',[' ']);
              Writeln(arquivo,linha);
              SqlAux1.Close;
              SqlAux1.Sql.Clear;
              SqlAux1.Sql.Add('update cga036 set cg036_dtret =(select current_date) where (cg036_dtbaixa between ');
              SqlAux1.Sql.Add(' '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtini.text))+chr(39)+' and '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(mkeddtfin.text))+chr(39)+') and (cg036_dtret is null)');
              SqlAux1.ExecSql;
              SqlAux1.Close;
              Application.MessageBox('Gera��o de Arquivo Retorno Finalizada','Ads',MB_OK+MB_ICONINFORMATION);
              closefile(arquivo);
          end;
      end;
    end;
end;

end.
