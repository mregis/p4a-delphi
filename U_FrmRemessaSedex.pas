unit U_FrmRemessaSedex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, Mask, DBCtrls, ComCtrls;

type
  TFrmRemessaSedex = class(TForm)
    Bevel1: TBevel;
    DBGrid001: TDBGrid;
    BtnLimpa: TBitBtn;
    BtnSalva: TBitBtn;
    BtnReenv: TBitBtn;
    BtnSair: TBitBtn;
    EdJuncao: TEdit;
    EdPeso: TEdit;
    EdVol: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EdDpto: TEdit;
    EdEnd: TEdit;
    EdBairro: TEdit;
    EdCid: TEdit;
    EdUF: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MkEdCep: TMaskEdit;
    EdSeqCarga: TEdit;
    Label10: TLabel;
    EdValor: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    EdReg: TEdit;
    EdVvalor: TEdit;
    Label13: TLabel;
    EdObjeto: TEdit;
    Label14: TLabel;
    Edvaldec: TEdit;
    Label15: TLabel;
    EdValAr: TEdit;
    Label16: TLabel;
    EdPorc: TEdit;
    EdAdVal: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    EdValMin: TEdit;
    Label19: TLabel;
    Bevel2: TBevel;
    Label20: TLabel;
    EdNovoAr: TEdit;
    Label21: TLabel;
    EdNovoLote: TEdit;
    Label22: TLabel;
    EdNovReg: TEdit;
    Label23: TLabel;
    EdNovoEnd: TEdit;
    Label24: TLabel;
    EdNovaAg: TEdit;
    Label25: TLabel;
    EdNovaCid: TEdit;
    Label26: TLabel;
    EdNovaUf: TEdit;
    Label27: TLabel;
    MkEdNovoCep: TMaskEdit;
    Label28: TLabel;
    EdQtde: TEdit;
    BtnAltera: TBitBtn;
    MkEdDtMov: TMaskEdit;
    MkEdDtEnvio: TMaskEdit;
    Label29: TLabel;
    Label30: TLabel;
    MkEdCarga: TMaskEdit;
    Label31: TLabel;
    Label32: TLabel;
    MkEdBaixa: TMaskEdit;
    DBCboBaixa: TDBLookupComboBox;
    Label34: TLabel;
    StsRemSdx: TStatusBar;
    Timer1: TTimer;
    Ednrocxa: TEdit;
    Edbas: TEdit;
    Edcpm: TEdit;
    Edalt: TEdit;
    Label33: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    procedure EdnrocxaKeyPress(Sender: TObject; var Key: Char);
    procedure EdbasEnter(Sender: TObject);
    procedure EdaltKeyPress(Sender: TObject; var Key: Char);
    procedure EdcpmKeyPress(Sender: TObject; var Key: Char);
    procedure EdbasKeyPress(Sender: TObject; var Key: Char);
//    procedure EdVolKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdVolKeyPress(Sender: TObject; var Key: Char);
    procedure EdVolEnter(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EdPesoEnter(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BtnAlteraClick(Sender: TObject);
    procedure DBGrid001CellClick(Column: TColumn);
    procedure BtnReenvClick(Sender: TObject);
    procedure EdObjetoKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid001DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DBGrid001DblClick(Sender: TObject);
    procedure BtnLimpaClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EdPesoKeyPress(Sender: TObject; var Key: Char);
    procedure BtnSalvaClick(Sender: TObject);
    procedure DBGrid001KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid001KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid001KeyPress(Sender: TObject; var Key: Char);
    procedure EdJuncaoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSairClick(Sender: TObject);
    procedure verag;
    procedure atuddsag(tipo:Integer);
    procedure calcvalor;
    procedure calclocal;
    procedure calcdiv;
    procedure vertabs;
    procedure calcint;
    procedure limpa;
    procedure verobj;
    procedure objtbsdx02(tipo:Integer);
    procedure ObtemConfiguracoes;
    procedure calcvol;
    procedure proccxa(tipo:Integer);
  private
  uf,numobjdv,cepr,mcep,selcga77,numobj,mpeso  : String;
  v_soma,codcxa              : Integer;
  vvalor,txcor,pescub,volcub,pescal: Real;
  dt                  : TDate;
  selcxa  : Boolean;


  //Vari�vel que armazenar� o modelo da balan�a, fun��o ObtemNomeBalanca


    { Private declarations }
  public

    { Public declarations }

  end;

type
  PInteger = ^Integer;

Const
  PcScale = 'PcScale.dll'; //Contante para n�o ficar repetindo
                           //o nome do arquivo da Dll

var
  FrmRemessaSedex: TFrmRemessaSedex;
  Modelo, Porta, BaudRate: Integer;
  mascara : String;
    //Vari�vel que armazenar� o modelo da balan�a, fun��o ObtemNomeBalanca
  CModelo: array[0..50] of char;

implementation

uses U_Func, DmDados, U_Principal;

{$R *.dfm}
function AttachScale(hScale : THandleStream;Com,BaudRate,ByteSize,StopBits,Parity: Integer): Integer; stdcall;
external 'PcScale.dll';

function ReadScale(hScale : THandleStream; Indicator: Integer; gross,tare,net,unitd: Pchar): Integer; stdcall;
external 'PcScale.dll';

function DettachScale(hScale : THandleStream): Integer; stdcall;
external 'PcScale.dll';
{Declara a fun��o ConfiguraBalanca existente na DLL "PcScale.dll"}
function ConfiguraBalanca(Balanca: Integer; Aplicativo: THandle): Boolean;
             stdcall; external PcScale;

{Declara a fun��o InicializaLeitura existente na DLL "PcScale.dll"}
function InicializaLeitura(Balanca: Integer): Boolean;
             stdcall; external PcScale;

{Declara a fun��o ObtemInformacao existente na DLL "PcScale.dll"}
function ObtemInformacao(Balanca: Integer; Campo: Integer): double;
             stdcall; external PcScale;

{Declara a fun��o FinalizaLeitura existente na DLL "PcScale.dll"}
function FinalizaLeitura(Balanca: Integer) : Boolean;
             stdcall; external PcScale;

{Declara a fun��o ExibeMsgErro existente na DLL "PcScale.dll"}
function EnviaPrecoCS(Balanca : integer; Preco : double) : Boolean;
             stdcall; external PcScale;

{Declara a fun��o FinalizaLeitura existente na DLL "PcScale.dll"}
function ObtemParametrosBalanca(Balanca: Integer; Modelo: PInteger;
                             Porta: PInteger; BaudRate: PInteger
                             ): Boolean
             stdcall; external PcScale;

{Declara a fun��o ObtemNomeBalanca existente na DLL "PcScale.dll"}
Procedure ObtemNomeBalanca(Modelo: Integer; Ret: PChar);
             stdcall; external PcScale;

{Declara a fun��o ExibeMsgErro existente na DLL "PcScale.dll"}
Procedure ExibeMsgErro(Aplicativo : THandle);
             stdcall; external PcScale;

procedure TFrmRemessaSedex.ObtemConfiguracoes;
begin
  if ObtemParametrosBalanca(0, @Modelo, @Porta, @BaudRate) then
    begin
      ObtemNomeBalanca(Modelo, CModelo);
    end;
end;


procedure TFrmRemessaSedex.BtnAlteraClick(Sender: TObject);
begin
  with Dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add('update tbsdx02 set sdx_nomdest = :nom,sdx_endedest = :end,sdx_cidade = :cid,sdx_uf = :uf,sdx_cep = :cep where (sdx_numobj4 = :numobj) and (sdx_siglaobj = :sigla)');
      SqlAux1.Params[0].Text  :=  EdJuncao.Text+': '+EdNovaAg.Text;
      SqlAux1.Params[1].Text  :=  EdNovoEnd.Text;
      SqlAux1.Params[2].Text  :=  EdNovaCid.Text;
      SqlAux1.Params[3].Text  :=  EdNovaUF.Text;
      SqlAux1.Params[4].Text  :=  MkEdNovoCep.Text;
      SqlAux1.Params[5].Text  :=  EdObjeto.Text;
      if FrmRemessaSedex.Tag = 3 then
        SqlAux1.Params[6].Text  := 'OL'
      else if FrmRemessaSedex.Tag = 4 then
        SqlAux1.Params[6].Text  := 'KD'//'TC'
      else if FrmRemessaSedex.Tag = 5 then
        SqlAux1.Params[6].Text  := 'KE'//'TK'
      else
        SqlAux1.Params[6].Value := null;
      try
        SqlAux1.ExecSQL;
        Application.MessageBox('AR-Sedex Alterado','ADS',ID_OK);
      except on e: exception do
        Application.MessageBox(PChar(e.Message),'ADS',ID_OK);
      end;
    end;

end;

procedure TFrmRemessaSedex.BtnLimpaClick(Sender: TObject);
begin
  EdSeqCarga.Text :=   IntToStr(StrToInt(EdSeqCarga.Text)+1);
  EdReg.Text      :=   '0';
end;

procedure TFrmRemessaSedex.BtnReenvClick(Sender: TObject);
begin
  with Dm do
    begin
      SqlAux3.Close;
      SqlAux3.SQL.Clear;
      SqlAux3.SQL.Add('select min(tbsdxect_num),tbsdxect_dv from tbsdx_ect where (tbsdx_use is null) ');
      if FrmRemessaSedex.Tag = 3 then
        SqlAux3.SQL.Add('and (tbsdxect_prod = ''1660'') ')
      else  if FrmRemessaSedex.Tag = 4 then
        SqlAux3.SQL.Add('and (tbsdxect_prod = ''2240'') ')
      else  if FrmRemessaSedex.Tag = 5 then
        SqlAux3.SQL.Add('and (tbsdxect_prod = ''2241'') ');
      SqlAux3.SQL.Add('group by tbsdxect_num,tbsdxect_dv order by tbsdxect_num limit 1');
      SqlAux3.Open;
      numobj:= SqlAux3.Fields[0].AsString+SqlAux3.Fields[1].AsString;
      SqlTbBradDeptos.Close;
      SqlTbBradDeptos.SQL.Clear;
      SqlTbBradDeptos.SQL.Add('select * from tbbraddptos where (juncao = :juncao) limit 1');
      SqlTbBradDeptos.Params[0].AsString  :=  IntToStr(StrToInt(EdJuncao.Text));
      SqlTbBradDeptos.Open;
      EdNovolote.Text   :=  IntToStr(Random(99))+gerant(formatdatetime('hhmm',Time),4);
      EdNovolote.Refresh;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add('insert into tbsdx02 ');
      SqlAux1.SQL.Add('(sdx_codcli,sdx_idcli,sdx_siglaobj,sdx_numobj,sdx_paisorigem,');
      SqlAux1.SQL.Add('sdx_numobj4,sdx_nomdest,sdx_endedest,sdx_cidade,sdx_uf,');
      SqlAux1.SQL.Add('sdx_cep,sdx_numseqarq,sdx_numseqreg,sdx_dtcarga,sdx_numobj2,');
      SqlAux1.SQL.Add('sdx_numobj1,sdx_codusu,sdx_valdec,sdx_seqcarga,sdx_qtprod,sdx_dtmov) ');
      SqlAux1.SQL.Add('values (');
      //                              0     1
      SqlAux1.SQL.Add('99,''99'',:sigla,:numobj,''BR'',');
      //                  2       3         4         5       6
      SqlAux1.SQL.Add(':numobj4,:nomdest,:enddest,:ciddest,:ufdest,');
      //                  7            8                            9
      SqlAux1.SQL.Add(':cepdest,99,:numreg,(select current_date),:numobj2,');
      //                  10      11       12          13           14      15
      SqlAux1.SQL.Add(':numobj1,:codusu,:sdx_valdec,:sdx_seqcarga,:qtprod,:sdx_dtmov)');
      if FrmRemessaSedex.Tag = 3 then
        SqlAux1.Params[00].AsString  :=  'OL' //
      else  if FrmRemessaSedex.Tag = 4 then
        SqlAux1.Params[00].AsString  :=  'KD'//'TC' //
      else  if FrmRemessaSedex.Tag = 5 then
        SqlAux1.Params[00].AsString  :=  'KE';//'TK';//
      SqlAux1.Params[01].AsString  :=  numobj;
      if FrmRemessaSedex.Tag = 3 then
        SqlAux1.Params[02].AsString  :=  'AR'+ numobj + 'OL'  //
      else  if FrmRemessaSedex.Tag = 4 then
        SqlAux1.Params[02].AsString  :=  'AR'+ numobj + 'KD'//'TC'  //
      else  if FrmRemessaSedex.Tag = 5 then
        SqlAux1.Params[02].AsString  :=  'AR'+ numobj + 'KE';//'TK';
      SqlAux1.Params[03].AsString  :=  gerant(SqlTbBradDeptosjuncao.AsString,4)+': '+SqlTbBradDeptosdepto.AsString;
      SqlAux1.Params[04].AsString  :=  SqlTbBradDeptosender.AsString;
      SqlAux1.Params[05].AsString  :=  SqlTbBradDeptoscidade.Text;
      SqlAux1.Params[06].AsString  :=  SqlTbBradDeptosuf.Text;
      SqlAux1.Params[07].AsString  :=  copy(SqlTbBradDeptoscep.Text,1,5)+copy(SqlTbBradDeptoscep.Text,7,3);
      EdNovReg.Text :=  gerant(inttostr(random(999)),3)+FormatDateTime('yyyymmdd',date)+FormatDateTime('hhmmss',Time)+GeraNT(sqlcga_acessocodigo.AsString,4)+gerant(inttostr(random(999)),3);
      EdNovReg.Refresh;
      SqlAux1.Params[08].AsString  := EdNovReg.Text;
      SqlAux1.Params[09].AsString  :=  'DL'+ numobj + 'BR';
      if FrmRemessaSedex.Tag = 3 then
        SqlAux1.Params[10].AsString  :=  'AR'+ numobj + 'OL'  //
      else  if FrmRemessaSedex.Tag = 4 then
        SqlAux1.Params[10].AsString  :=  'AR'+ numobj + 'KD'//'TC'  //
      else  if FrmRemessaSedex.Tag = 5 then
        SqlAux1.Params[10].AsString  :=  'AR'+ numobj + 'KE';//'TK';//
      if FrmRemessaSedex.Tag = 3 then
        EdNovoAr.Text  :=  'AR'+ numobj + 'OL'  //
      else  if FrmRemessaSedex.Tag = 4 then
        EdNovoAr.Text  :=  'AR'+ numobj + 'KD'//'TC'  //
      else  if FrmRemessaSedex.Tag = 5 then
        EdNovoAr.Text  :=  'AR'+ numobj + 'KE';//'TK';//
      EdNovoAr.Refresh;
      SqlAux1.Params[11].AsString  :=  sqlcga_acessocodigo.AsString;
      SqlAux1.Params[12].Value     :=  SqlSdx4sdx_valdec.Value;
      SqlAux1.Params[13].AsString  :=  trim(EdNovolote.Text);
      SqlAux1.Params[14].Value     :=  SqlSdx4sdx_qtprod.value;
      SqlAux1.Params[15].Value     :=  SqlSdx4sdx_dtmov.Value;
      try
        SqlAux1.ExecSQL;
        EdNovoEnd.Text  :=  SqlTbBradDeptosender.Text;
        EdNovoEnd.Refresh;
        SqlAux1.Close;
        SqlAux1.SQL.Clear;
        SqlAux1.SQL.Add('update tbsdx_ect set tbsdx_use = ''S'' where (tbsdxect_num = :num)');
        SqlAux1.Params[0].AsString  :=  SqlAux3.Fields[0].AsString;
        SqlAux1.ExecSQL;
      except on e:exception do
        begin
          Application.MessageBox(PChar(e.Message),'ADS',ID_OK);
          exit;
        end;
      end;
    end;

end;

procedure TFrmRemessaSedex.BtnSairClick(Sender: TObject);
begin
  close;
end;

procedure TFrmRemessaSedex.BtnSalvaClick(Sender: TObject);
var i:Integer;
begin
//  Timer1.Enabled := false;
//      EdPeso.Text        := FormatFloat('#,##0.000;0;0', StrToint(EdPeso.Text)/1000);
{  if (trim(Edcodcxa.Text) = '') or (vernum(Edcodcxa.Text) = false) then
    begin
      //Application.MessageBox(Pchar('Digite ou Leia o C�digo da Caixa !'),'ADS',ID_OK);
     // Edcodcxa.SetFocus;
    end
  else}
    calcvol;
    mpeso       :=  EdPeso.Text;

    if (pescub <= StrToFloat(mpeso)) then
      pescal  :=  StrToFloat(mpeso)
    else
      pescal  :=  pescub;


  calcvalor;

  if trim(EdObjeto.Text) = '' then
    begin
      Application.MessageBox('Digite Ar','ADS',ID_OK);
      EdObjeto.SetFocus;
      exit;
    end;
  v_soma := 0;
  i := 0;
  //    mcep  :=  MkEdCep.Text
  for i:= 1 to 8 do
    v_soma := v_soma + strtoint(copy(MkEdCep.Text,i,1));
  v_soma := strtoint(copy(intTostr(v_soma),length(inttostr(v_soma)),1));
  if v_soma = 0 then
    CEPr := MkEdCep.Text + '0'
  else
    begin
      v_soma := 10 - v_soma;
      CEPr := '/'+MkEdCep.Text + intToStr(v_soma)+'\';
    end;
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add('update tbsdx02 ');
      SqlAux1.SQL.Add('set sdx_cepnet = :cepnet,sdx_valor = :valor,sdx_peso = :peso,sdx_qtde = :qtde,sdx_tvalor = :tvalor,');
      SqlAux1.SQL.Add('sdx_dtenvio = (select current_date)');
      case FrmRemessaSedex.Tag of
        0..2  : SqlAux1.SQL.Add(',sdx_valar = (select distinct(tbsdxserv_txasrv) from tbsdxserv where (tbsdxserv_prod in(0,1,1660)))');
      end;
      SqlAux1.SQL.Add(',sdx_porc = 0.003,sdx_valmin = 275.00, sdx_difval = :valdif,sdx_horaenvio = (select current_time(0)),');
      SqlAux1.SQL.Add('sdx_bas = :bas,sdx_cmp = :cmp,sdx_alt = :alt,sdx_pescub = :pescub,sdx_codcxa = :codcxa ');
      SqlAux1.SQL.Add('where (sdx_numobj = :numboj) ');
      SqlAux1.Params[00].AsString  :=  cepr;
      SqlAux1.Params[01].AsString  :=  VirgPonto2(EdValor.Text);
      SqlAux1.Params[02].AsString  :=  U_Func.VirgPonto2(EdPeso.Text);
      SqlAux1.Params[03].AsString  :=  VirgPonto2(EdVol.Text);
      SqlAux1.Params[04].AsFloat   :=  vvalor;
      if  SqlSdx4sdx_valdec.Value  > 275.00 then
        SqlAux1.Params[05].AsFloat   :=  (SqlSdx4sdx_valdec.Value-275.00)
      else
        SqlAux1.Params[05].AsFloat   :=  0;
      SqlAux1.Params[06].AsString  :=  VirgPonto2(Edbas.Text);
      SqlAux1.Params[07].AsString  :=  VirgPonto2(Edcpm.Text);
      SqlAux1.Params[08].AsString  :=  VirgPonto2(Edalt.Text);
      SqlAux1.Params[09].AsFloat   :=  pescal;
      SqlAux1.Params[10].AsInteger :=  codcxa;
      SqlAux1.Params[11].AsString  :=  copy(EdObjeto.Text,3,9);//SqlSdx4sdx_valdec.Value  > 275.00
      try
//       inputbox('','',SqlAux1.SQL.Text);
        SqlAux1.ExecSQL;
        Timer1.Enabled  :=  false;
        limpa;
        FinalizaLeitura(0);
        EdObjeto.SetFocus;
      except on e: exception do
        begin
          Application.MessageBox(PChar('Erro: '+e.Message+chr(10)+'Verifique com o CPD'),'ADS',ID_OK);
          EdJuncao.SetFocus;
          exit;
        end;
      end;
    end;
end;

procedure TFrmRemessaSedex.Button1Click(Sender: TObject);
begin
  if InicializaLeitura(0) then
     begin
       Timer1.Enabled := True;
     end
end;

procedure TFrmRemessaSedex.DBGrid001CellClick(Column: TColumn);
begin
  atuddsag(1);
end;

procedure TFrmRemessaSedex.DBGrid001DblClick(Sender: TObject);
begin
  atuddsag(1);
end;

procedure TFrmRemessaSedex.DBGrid001DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  atuddsag(1);
end;

procedure TFrmRemessaSedex.DBGrid001KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  atuddsag(1);
end;

procedure TFrmRemessaSedex.DBGrid001KeyPress(Sender: TObject; var Key: Char);
begin
  atuddsag(1);
end;

procedure TFrmRemessaSedex.DBGrid001KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  atuddsag(1);
end;

procedure TFrmRemessaSedex.EdaltKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    Edalt.Text  :=  FormatFloat('##0.00;;',StrToFloat(Edalt.text)/100);
end;

procedure TFrmRemessaSedex.EdbasEnter(Sender: TObject);
begin
  Edbas.Hint  :=  'Digite sem virgula ou ponto';

end;

procedure TFrmRemessaSedex.EdbasKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    Edbas.Text  :=  FormatFloat('##0.00;;',StrToFloat(Edbas.text)/100);
end;

procedure TFrmRemessaSedex.EdcpmKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    Edcpm.Text  :=  FormatFloat('##0.00;;',StrToFloat(Edcpm.text)/100);

end;

procedure TFrmRemessaSedex.EdJuncaoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      if vernum(EdJuncao.Text) =  true then
        begin
          verag;
          EdJuncao.Text :=  GeraNT(EdJuncao.Text,4);
          objtbsdx02(1);
          DBGrid001.SetFocus;
        end
      else
        begin
          Application.MessageBox(PChar('Digite n�meros'),'ADS',ID_OK);
          EdJuncao.SetFocus;
          Exit;
        end;
    end;

end;

procedure TFrmRemessaSedex.EdnrocxaKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    proccxa(0);
  
end;

procedure TFrmRemessaSedex.EdObjetoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      if vernum(copy(EdObjeto.Text,3,9)) =  true then
        begin
          objtbsdx02(0);
          selcxa:=false;
          if Tag in [0..2] then
            Ednrocxa.SetFocus
            //EdVol.SetFocus
          else
            BtnReenv.SetFocus;
        end
      else
        begin
          Application.MessageBox(PChar('Erro Ler Ou Digite Novamente'),'ADS',ID_OK);
          EdObjeto.Clear;
          EdObjeto.SetFocus;
          Exit;
        end;
    end;

end;

procedure TFrmRemessaSedex.EdPesoEnter(Sender: TObject);
begin
  if InicializaLeitura(0) then
       Timer1.Enabled := True;
 end;

procedure TFrmRemessaSedex.EdPesoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
 //     EdPeso.Text        := FormatFloat('#,##0.000;0;0', StrToint(EdPeso.Text)/1000);
//      mpeso       :=  EdPeso.Text;
//      calcvalor;
    end;
end;
procedure TFrmRemessaSedex.calcvol;
begin
  if (vernum(Ednrocxa.Text) = true) then
    begin
      if  (vernum(strtran(Edbas.Text,',','')) = true) then
        begin
          if (vernum(strtran(Edcpm.Text,',','')) = true) then
            begin
              if (vernum(strtran(Edalt.Text,',','')) = true) then
                begin
                //
        //        volcub  :=  (StrToFloat(strtran(Edbas.Text,',','.')) * StrToFloat(strtran(Edcpm.Text,',','.')) *StrToFloat(strtran(Edalt.Text,',','.')));
                volcub  :=  (StrToFloat(Edbas.Text)*StrToFloat(Edcpm.Text)*StrToFloat(Edalt.Text));
                volcub  :=  (volcub*100);
                if (volcub > 3) then
                  pescub  :=  ((volcub/6)*10);
                //else
                //  pescub  :=  (volcub*10);
                //EdPeso.SetFocus;
                exit;
                //pescub  :=
                end
              else
                begin
                  Application.MessageBox(Pchar('Digite Altura da Caixa Somente N�meros'),'ADS',ID_OK);
                  Edalt.SetFocus;
                  exit;
                end;
            end
          else
            begin
              Application.MessageBox(Pchar('Digite Comprimento somente N�meros'),'ADS',ID_OK);
              Edcpm.SetFocus;
              exit;
            end;
        end
      else
        begin
          Application.MessageBox(Pchar('Digite Largura somente N�meros'),'ADS',ID_OK);
          Edbas.SetFocus;
          exit;
        end;
    end
  else
    begin
      Application.MessageBox(Pchar('Digite C�digo da Caixa somente N�meros'),'ADS',ID_OK);
      Ednrocxa.SetFocus;
      exit;
    end;
  //
  //
end;

procedure TFrmRemessaSedex.EdVolEnter(Sender: TObject);
begin
  if (selcxa = false) then
    proccxa(1);
end;
procedure TFrmRemessaSedex.proccxa(tipo:Integer);
begin
  with Dm do
    begin
      if (trim(Ednrocxa.Text) = '') or (vernum(Ednrocxa.Text) = false) then
        begin
          Application.MessageBox(Pchar('Digite ou Leia o C�digo da Caixa !'),'ADS',ID_OK);
          Ednrocxa.SetFocus;
        end
      else
        begin
          with Dm do
            begin
              SqlAux1.Close;
              SqlAux1.SQL.Clear;
              SqlAux1.SQL.Add('select * from tbcadcaixa where (nrocxa='+chr(39)+Ednrocxa.Text+chr(39)+') limit 1');
              SqlAux1.Open;
              case SqlAux1.RecordCount of
                1:
                  begin
                    codcxa          :=  SqlAux1.Fields[0].AsInteger;
                    Edbas.Enabled   :=  false;
                    Edcpm.Enabled   :=  false;
                    Edalt.Enabled   :=  false;
                    Edbas.Text      :=  FormatFloat('##0.00;;',SqlAux1.Fields[2].AsFloat);
                    Edcpm.Text      :=  FormatFloat('##0.00;;',SqlAux1.Fields[3].AsFloat);
                    Edalt.Text      :=  FormatFloat('##0.00;;',SqlAux1.Fields[4].AsFloat);
                    EdVol.SetFocus;
                  end;
                else
                  begin
                    codcxa          :=  SqlAux1.Fields[0].AsInteger;
                    Edbas.Enabled   :=  true;
                    Edcpm.Enabled   :=  true;
                    Edalt.Enabled   :=  true;
                    Edbas.SetFocus;
                  end;
              end;
              selcxa:=true;
            end;
        end;
    end;
end;


procedure TFrmRemessaSedex.EdVolKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#13) then
//    proccxa(0); //

end;

procedure TFrmRemessaSedex.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action  :=  caFree;
end;

procedure TFrmRemessaSedex.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
  Frmremessasedex.SelectNext(ActiveControl,true,true);
end;

procedure TFrmRemessaSedex.FormShow(Sender: TObject);
begin
  ObtemConfiguracoes;
  EdReg.Text  :=  '0';
  with Dm do
    begin
      SqlSdx4.Close;
      SqlSdx4.SQL.Clear;
      SqlSdx4.SQL.Add('select * from tbsdx02 where (sdx_siglaobj = :sigla) and (sdx_dtcarga = (select current_date)) ');
      case FrmRemessaSedex.Tag of
        0,3:  SqlSdx4.Params[0].AsString  :=  'OL';//
        1,4:  SqlSdx4.Params[0].AsString  :=  'KD';//'TC';//
        2,5:  SqlSdx4.Params[0].AsString  :=  'KE';//'TK';//
      end;
      if FrmRemessaSedex.tag in [3..5] then
        begin
          BtnReenv.Enabled  :=  true;
          BtnSalva.Enabled  :=  false;
          EdJuncao.Enabled  :=  true;
          EdJuncao.ReadOnly :=  false;
          BtnAltera.Enabled :=  true;
        end;
      if FrmRemessaSedex.tag in [6] then
        begin
          EdJuncao.Enabled  :=  true;
          EdJuncao.ReadOnly :=  false;
          BtnSalva.Enabled  :=  false;
          Sqltbbxasdx.Close;
          Sqltbbxasdx.SQL.Clear;
          Sqltbbxasdx.SQL.Add('select * from tbbxasdx ');
          Sqltbbxasdx.Open;
          //DBCboBaixa.Enabled  :=  true;
        end;
      SqlSdx4.Open;
      SqlSdx4.First;
      DBGrid001.Refresh;
    end;
end;
procedure TFrmRemessaSedex.verag;
begin
  with dm do
  begin
    SqlTbBradDeptos.Close;
    SqlTbBradDeptos.SQL.Clear;
    SqlTbBradDeptos.SQL.Add('select * from tbbraddptos where (juncao = :juncao) limit 1');
    SqlTbBradDeptos.Params[0].AsString  :=  EdJuncao.Text;
    SqlTbBradDeptos.Open;
    if SqlTbBradDeptos.RecordCount = 1 then
      begin
      //atuddsag(0)
        EdNovaAg.Text    := SqlTbBradDeptosdepto.Text;
        EdNovoEnd.Text   := SqlTbBradDeptosender.Text;
        EdNovaCid.Text   := SqlTbBradDeptoscidade.Text;
        EdNovaUF.Text    := SqlTbBradDeptosuf.Text;
        MkEdNovoCep.Text := copy(SqlTbBradDeptoscep.Text,1,5)+copy(SqlTbBradDeptoscep.Text,7,3);
      end
    else  if SqlTbBradDeptos.RecordCount > 1 then
      begin
        Application.MessageBox(Pchar('Verificar Junto ao Cpd'+chr(10)+'Mais de Uma Ag�ncia Encontrada'),'ADS',ID_OK);
        EdJuncao.SetFocus;
        exit;
      end
    else
      begin
        Application.MessageBox(Pchar('Verificar Junto ao Cpd'+chr(10)+'Agencia N�o Encontrada'),'ADS',ID_OK);
        EdJuncao.SetFocus;
        exit;
      end
  end;
end;
procedure TFrmRemessaSedex.atuddsag(tipo: integer);
begin
  with dm do
    begin
      EdObjeto.Text :=  SqlSdx4sdx_numobj4.Text;
      case tipo of
        0:  begin
              EdJuncao.Text :=  copy(SqlSdx4sdx_nomdest.Text,1,4);
              EdDpto.Text        :=  SqlSdx4sdx_nomdest.Text;
              EdEnd.Text         :=  SqlSdx4sdx_endedest.Text;
              EdCid.Text         :=  SqlSdx4sdx_cidade.Text;
              EdUF.Text          :=  SqlSdx4sdx_uf.Text;
              MkEdCep.Text       :=  SqlSdx4sdx_cep.Text;
              EdVol.Text         :=  SqlSdx4sdx_qtde.AsString;
              EdPeso.Text        :=  FormatFloat('#,##0.000;;',SqlSdx4sdx_peso.AsFloat);
              EdValor.Text       :=  FormatFloat('#,##0.00;;',SqlSdx4sdx_valor.AsFloat);
              EdVvalor.Text      :=  FormatFloat('#,##0.00;;',SqlSdx4sdx_tvalor.AsFloat);
              Edvaldec.Text      :=  FormatFloat('#,##0.00;;',SqlSdx4sdx_valdec.AsFloat);
              EdSeqCarga.Text    :=  SqlSdx4sdx_seqcarga.AsString;
              EdValAr.Text       :=  FormatFloat('#,##0.00;;',SqlSdx4sdx_valar.AsFloat);
              EdValMin.Text      :=  FormatFloat('#,##0.00;;',SqlSdx4sdx_valmin.AsFloat);
              EdPorc.Text        :=  FormatFloat('#,##0.000;;',SqlSdx4sdx_porc.AsFloat);
              EdAdVal.Text       :=  FormatFloat('#,##0.00;;',SqlSdx4sdx_difval.AsFloat);
              EdReg.Text         :=  SqlSdx4sdx_numseqreg.Text;
              EdQtde.Text        :=  SqlSdx4sdx_qtprod.Text;
              MkEdDtMov.Text     :=  FormatDateTime('dd/mm/yyyy',SqlSdx4sdx_dtmov.Value);
              MkEdCarga.text     :=  FormatDateTime('dd/mm/yyyy',SqlSdx4sdx_dtcarga.Value);
              Ednrocxa.Text      :=  SqlSdx4sdx_codcxa.AsString;
              Edbas.Text         :=  SqlSdx4sdx_bas.AsString;
              Edcpm.Text         :=  SqlSdx4sdx_cmp.AsString;
              Edalt.Text         :=  SqlSdx4sdx_alt.Text;
            end;
        1:  begin
              EdJuncao.Text      :=  copy(SqlSdx4sdx_nomdest.Text,1,4);
              EdDpto.Text        :=  SqlSdx4sdx_nomdest.Text;
              EdEnd.Text         :=  SqlSdx4sdx_endedest.Text;
              EdCid.Text         :=  SqlSdx4sdx_cidade.Text;
              EdUF.Text          :=  SqlSdx4sdx_uf.Text;
              MkEdCep.Text       :=  SqlSdx4sdx_cep.AsString;
              EdVol.Text         :=  SqlSdx4sdx_qtde.AsString;
              EdPeso.Text        :=  FormatFloat('#,##0.000;;',SqlSdx4sdx_peso.AsFloat);
              EdValor.Text       :=  FormatFloat('#,##0.00;;',SqlSdx4sdx_valor.AsFloat);
              EdVvalor.Text      :=  FormatFloat('#,##0.00;;',SqlSdx4sdx_tvalor.AsFloat);
              Edvaldec.Text      :=  FormatFloat('#,##0.00;;',SqlSdx4sdx_valdec.AsFloat);
              EdSeqCarga.Text    :=  SqlSdx4sdx_seqcarga.AsString;
              EdValAr.Text       :=  FormatFloat('#,##0.00;;',SqlSdx4sdx_valar.AsFloat);
              EdValMin.Text      :=  FormatFloat('#,##0.00;;',SqlSdx4sdx_valmin.AsFloat);
              EdPorc.Text        :=  FormatFloat('#,##0.000;;',SqlSdx4sdx_porc.AsFloat);
              EdAdVal.Text       :=  FormatFloat('#,##0.00;;',SqlSdx4sdx_difval.AsFloat);
              EdReg.Text         :=  SqlSdx4sdx_numseqreg.Text;
              EdQtde.Text        :=  SqlSdx4sdx_qtprod.Text;
              MkEdDtMov.Text     :=  FormatDateTime('dd/mm/yyyy',SqlSdx4sdx_dtmov.Value);
              MkEdCarga.text     :=  FormatDateTime('dd/mm/yyyy',SqlSdx4sdx_dtcarga.Value);
              Ednrocxa.Text      :=  SqlSdx4sdx_codcxa.AsString;
              Edbas.Text         :=  FormatFloat('##0.00;;',SqlSdx4sdx_bas.AsFloat);
              Edcpm.Text         :=  FormatFloat('##0.00;;',SqlSdx4sdx_cmp.AsFloat);
              Edalt.Text         :=  FormatFloat('##0.00;;',SqlSdx4sdx_alt.AsFloat);
            end;
      end;
      if (SqlSdx4sdx_dtenvio.Value > 0) then
        MkEdDtEnvio.Text   :=  FormatDateTime('dd/mm/yyyy',SqlSdx4sdx_dtenvio.Value)
      else
        MkEdDtEnvio.Clear;
      if (SqlSdx4sdx_dtbaixa.Value > 0) then
        MkEdBaixa.Text   :=  FormatDateTime('dd/mm/yyyy',SqlSdx4sdx_dtbaixa.Value)
      else
        MkEdBaixa.Clear;

      if (SqlSdx4.RecordCount > 0) then
        begin
          if (FrmRemessaSedex.Tag in[6]) then
            begin
              DBCboBaixa.KeyValue :=  SqlSdx4sdx_codbxa.Value;
              DBCboBaixa.Refresh;
            end
          else
            EdNovoLote.Text   :=  IntToStr(StrToInt(EdSeqCarga.Text)+1)+gerant(formatdatetime('hhmm',Time),4);
        end;
    end;
end;
procedure TFrmRemessaSedex.calcvalor;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add('select tb_valtxaar from tbtxaar');
      SqlAux1.Open;
      txcor :=  SqlAux1.Fields[00].Value; // taxa de Servi�o AR - Correio
    end;
  if (EdUF.Text = 'SP') and (MkEdCep.Text <= '09999999') then
    calclocal
  else  if (EdUF.Text = 'SP') and (MkEdCep.Text > '09999999') then
    calcint
  else
    calcdiv;

end;
procedure TFrmRemessaSedex.calclocal;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add('select tb_pesosdxlocval from tbsdxprecoloc where (:peso between tb_pesosdxlocini and tb_pesosdxlocfin)');
//      SqlAux1.Params[0].AsString  := VirgPonto2(EdPeso.Text);
      SqlAux1.Params[0].Value :=   pescal;
      SqlAux1.Open;
      SqlAux1.First;
      EdValor.Text  :=  FormatFloat('#,##0.00;;',SqlAux1.Fields[0].AsFloat);
      if (SqlSdx4sdx_valdec.Value  > 275.00) then
        vvalor        :=  StrToFloat(EdValor.Text)+((SqlSdx4sdx_valdec.AsFloat-275.00)* 0.003)
      else
        vvalor        :=  StrToFloat(EdValor.Text);
      vvalor  :=  vvalor+txcor;
      EdVValor.Text  :=  FormatFloat('#,##0.00;;',vvalor)
    end;
end;
procedure TFrmRemessaSedex.calcdiv;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add('select tb_ufdiv from tbcepdivisa where (:cep between tb_cepini and tb_cepfin) and (tb_ufdiv = :uf) limit 1');
      SqlAux1.Params[0].AsString  :=  MkEdCep.Text;
      SqlAux1.Params[1].AsString  :=  EdUF.Text;
      SqlAux1.Open;
      uf := SqlAux1.Fields[0].AsString;
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('select tb_pesosdxdivval from tbsdxprecodiv where (:peso between tb_pesosdxdivini and tb_pesosdxdivfin) and (tb_ufsdxprcdiv = :uf)');
//      SqlAux2.Params[0].AsString  :=  VirgPonto2(EdPeso.Text);
      SqlAux2.Params[0].Value     :=   pescal;
      SqlAux2.Params[1].AsString  :=  SqlAux1.Fields[0].AsString;
      SqlAux2.Open;
      if SqlAux2.RecordCount = 1 then
        begin
          EdValor.Text  :=  FormatFloat('#,##0.00;;',SqlAux2.Fields[0].AsFloat);
          if (SqlSdx4sdx_valdec.Value  > 275.00) then
            vvalor        :=  StrToFloat(EdValor.Text)+((SqlSdx4sdx_valdec.AsFloat-275.00)* 0.003)
          else
            vvalor        :=  StrToFloat(EdValor.Text);
          vvalor  :=  vvalor+txcor;
          EdVValor.Text  :=  FormatFloat('#,##0.00;;',vvalor);
        end
      else
        vertabs;
    end;
end;

procedure TFrmRemessaSedex.vertabs;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add('select tb_cepcapuf from tbcepcap where (:cep between tb_cepcapcepini and tb_cepcapcepfin) and (tb_cepcapuf = :uf) limit 1');
      SqlAux1.Params[0].AsString  :=  MkEdCep.Text;
      SqlAux1.Params[1].AsString  :=  EdUF.Text;
      SqlAux1.Open;
      uf := SqlAux1.Fields[0].AsString;
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('select tb_pesosdxval from tbsdxprecouf where (:peso between tb_pesosdxini and tb_pesosdxfin) and (tb_ufsdxprc = :uf)');
//      SqlAux2.Params[0].AsString  :=  VirgPonto2(EdPeso.Text);
      SqlAux2.Params[0].Value     :=   pescal;
      SqlAux2.Params[1].AsString  :=  SqlAux1.Fields[0].AsString;
      SqlAux2.Open;
      if SqlAux2.RecordCount = 1 then
        begin
          EdValor.Text  :=  FormatFloat('#,##0.00;;',SqlAux2.Fields[0].AsFloat);
          if (SqlSdx4sdx_valdec.Value  > 275.00) then
            vvalor        :=  StrToFloat(EdValor.Text)+((SqlSdx4sdx_valdec.AsFloat-275.00)* 0.003)
          else
            vvalor        :=  StrToFloat(EdValor.Text);
          vvalor  :=  vvalor+txcor;
          EdVValor.Text  :=  FormatFloat('#,##0.00;;',vvalor);
        end
      else
        calcint;
    end;
end;
procedure TFrmRemessaSedex.calcint;
begin
  with Dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add('select tb_ufint from tbcepinterior where (:cep between tb_cepini and tb_cepfin) and (tb_ufint = :uf) limit 1');
      SqlAux1.Params[0].AsString  :=  MkEdCep.Text;
      SqlAux1.Params[1].AsString  :=  EdUF.Text;
      SqlAux1.Open;
      uf := SqlAux1.Fields[0].AsString;
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('select tb_pesosdxval from tbsdxprecoint where (:peso between tb_pesosdxini and tb_pesosdxfin) and (tb_ufsdxprc = :uf)');
//      SqlAux2.Params[0].AsString  :=  VirgPonto2(EdPeso.Text);
      SqlAux2.Params[0].Value :=   pescal;
      SqlAux2.Params[1].AsString  :=  EdUF.Text;
      SqlAux2.Open;
      if SqlAux2.RecordCount = 1 then
        begin
          EdValor.Text  :=  FormatFloat('#,##0.00;;',SqlAux2.Fields[0].AsFloat);
          if (SqlSdx4sdx_valdec.Value  > 275.00) then
            vvalor        :=  StrToFloat(EdValor.Text)+((SqlSdx4sdx_valdec.AsFloat-275.00) * 0.003)
          else
            vvalor        :=  StrToFloat(EdValor.Text);
          vvalor  :=  vvalor+txcor;
          EdVValor.Text  :=  FormatFloat('#,##0.00;;',vvalor);
        end
      else if SqlAux2.RecordCount  = 0 then
        begin
          Application.MessageBox(PChar('Erro: Nenhum Registro Encontrado para o Cep ou UF'),'ADS',ID_OK);
          exit;
        end
      else
        begin
          Application.MessageBox(PChar('Erro: Encontrado + de 1 Registro para o Cep ou UF'),'ADS',ID_OK);
          exit;
        end;
    end;
end;

procedure TFrmRemessaSedex.limpa;
begin
  EdObjeto.Clear;
  EdJuncao.Clear;
  EdDpto.Clear;
  EdDpto.Clear;
  EdEnd.Clear;
  EdBairro.Clear;
  EdCid.Clear;
  EdUF.Clear;
  MkEdCep.Clear;
  //EdPeso.Clear;
  EdVol.Clear;
  EdValor.Clear;
  EdValor.Clear;
  EdVvalor.Clear;
  Edvaldec.Clear;
  vvalor  :=  0;
  EdValAr.Clear;
  EdValMin.Clear;
  EdAdVal.Clear;
  EdPorc.Clear;
  EdSeqCarga.Clear;
  EdReg.Clear;
  Ednrocxa.Clear;
  Edbas.Clear;
  Edcpm.Clear;
  Edalt.Clear;
end;
procedure TFrmRemessaSedex.verobj;
begin
  with dm do
    begin
      sqlsdx4.Close;
      sqlsdx4.SQL.Clear;
      sqlsdx4.SQL.Add('select * from tbsdx02 where (sdx_numobj = :numobj) and (sdx_siglaobj = :sigla) ' );
      sqlsdx4.Params[0].AsString  :=  EdObjeto.Text;
      case Tag of
        0:  sqlsdx4.Params[0].AsString  :=  'OL';
        1:  sqlsdx4.Params[1].AsString  :=  'KD';//'TC';
        2:  sqlsdx4.Params[2].AsString  :=  'KE';//'TK';
      end;
      sqlsdx4.Open;
      if SqlSdx4.RecordCount = 0 then
        begin
          Application.MessageBox('Registro n�o encontrado, tente novamente!','ADS',ID_OK);
          EdObjeto.SetFocus;
          exit;
        end
      else  if SqlSdx4.RecordCount > 1 then
          Application.MessageBox('Encontrado + 1 Registro, Escolha no Grid Abaixo!','ADS',ID_OK)
      else
        atuddsag(1);
      DBGrid001.Refresh;
    end;
end;
procedure TFrmRemessaSedex.objtbsdx02(Tipo:Integer);
begin
  with dm do
    begin
//      selcga77 :=  'select cg77_ag,cg77_qtd from cga77 where (cg77_dtb = :dtb) limit 1';
      SqlSdx4.Close;
      SqlSdx4.SQL.Clear;
      SqlSdx4.SQL.Add('select * from tbsdx02 ');
      if (tipo = 0) then
        begin
          SqlSdx4.SQL.Add('where (sdx_numobj = :dds) ');
          SqlSdx4.ParamByName('dds').Text :=  copy(EdObjeto.Text,3,9);
        end
      else
        begin
          SqlSdx4.SQL.Add('where (substr(sdx_nomdest,1,4) = :dds) ');
          SqlSdx4.ParamByName('dds').Text :=  gerant(EdJuncao.Text,4);
          if (FrmRemessaSedex.Tag in [3..5]) then
            SqlSdx4.SQL.Add('and (sdx_siglaobj = :sigla) ');
          if (FrmRemessaSedex.Tag = 3) then
            SqlSdx4.ParamByName('sigla').Text := 'OL'
          else if (FrmRemessaSedex.Tag = 4) then
            SqlSdx4.ParamByName('sigla').Text := 'KD'//'TC'
          else if (FrmRemessaSedex.Tag = 5) then
            SqlSdx4.ParamByName('sigla').Text := 'KE';//'TK';
        end;
      SqlSdx4.SQL.Add('order by sdx_dtcarga desc');
      SqlSdx4.Open;
      atuddsag(0);
      DBGrid001.Refresh;
//      verag;
    end;
end;

procedure TFrmRemessaSedex.Timer1Timer(Sender: TObject);
var
status, aux: integer;

begin
  status := StrToInt(FloatToStr(ObtemInformacao(0,0)));
  case status of
    0:  StsRemSdx.Panels[1].Text := 'Falha comunciando-se com a balan�a.';
    1:  StsRemSdx.Panels[1].Text := 'Peso Oscilando.';
    2:  StsRemSdx.Panels[1].Text := 'Peso Est�vel.';
    3:  StsRemSdx.Panels[1].Text := 'Sobrecarga de Peso ou Alivio de Plataforma.';
    4:  StsRemSdx.Panels[1].Text := 'Erro lendo licensa do Software.';
    else   StsRemSdx.Panels[1].Text := 'Erro';
  end;

  if ( status = 1 ) or ( status = 2 ) then
    begin
      if mascara = '' then
        begin
          mascara := '0.';
          for aux := 1 to StrToInt(FloatToStr(ObtemInformacao(0,8))) do
              mascara := mascara + '0';
        end;

        EdPeso.Text        := FormatFloat(mascara,ObtemInformacao(0,1));
        EdPeso.Refresh;
    end
  else
      ShowMessage('---------');
end;

end.
