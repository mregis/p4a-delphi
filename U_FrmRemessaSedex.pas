unit U_FrmRemessaSedex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, Mask, DBCtrls,
  ComCtrls, Math, CPort, IniFiles;

type
  TFrmRemessaSedex = class(TForm)
    DBGrid001: TDBGrid;
    BtnLimpa: TBitBtn;
    BtnSalva: TBitBtn;
    BtnReenv: TBitBtn;
    BtnSair: TBitBtn;
    EdJuncao: TEdit;
    Label1: TLabel;
    EdObjeto: TEdit;
    Label14: TLabel;
    BtnAltera: TBitBtn;
    StsRemSdx: TStatusBar;
    Timer1: TTimer;
    CboProdutoServSedex: TDBLookupComboBox;
    Label38: TLabel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    EdEnd: TEdit;
    Label6: TLabel;
    EdBairro: TEdit;
    Label4: TLabel;
    EdDpto: TEdit;
    Label7: TLabel;
    EdCid: TEdit;
    Label8: TLabel;
    EdUF: TEdit;
    MkEdCep: TMaskEdit;
    Label9: TLabel;
    GroupBox2: TGroupBox;
    Label33: TLabel;
    Ednrocxa: TEdit;
    Label35: TLabel;
    Edbas: TEdit;
    Label36: TLabel;
    Edcpm: TEdit;
    Label37: TLabel;
    Edalt: TEdit;
    EdVol: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EdPeso: TEdit;
    GroupBox3: TGroupBox;
    Label15: TLabel;
    Edvaldec: TEdit;
    Label11: TLabel;
    EdValor: TEdit;
    Label13: TLabel;
    EdVvalor: TEdit;
    Label16: TLabel;
    EdValAr: TEdit;
    Label17: TLabel;
    EdPorc: TEdit;
    Label19: TLabel;
    EdValMin: TEdit;
    Label18: TLabel;
    EdAdVal: TEdit;
    Label28: TLabel;
    EdQtde: TEdit;
    Label10: TLabel;
    EdSeqCarga: TEdit;
    Label12: TLabel;
    EdReg: TEdit;
    MkEdBaixa: TMaskEdit;
    Label32: TLabel;
    MkEdDtEnvio: TMaskEdit;
    Label30: TLabel;
    MkEdCarga: TMaskEdit;
    Label31: TLabel;
    MkEdDtMov: TMaskEdit;
    Label29: TLabel;
    Bevel1: TBevel;
    GroupBox4: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label34: TLabel;
    EdNovoAr: TEdit;
    EdNovoLote: TEdit;
    EdNovReg: TEdit;
    EdNovoEnd: TEdit;
    EdNovaAg: TEdit;
    EdNovaCid: TEdit;
    EdNovaUf: TEdit;
    MkEdNovoCep: TMaskEdit;
    DBCboBaixa: TDBLookupComboBox;
    ComPort: TComPort;
    procedure EdPesoExit(Sender: TObject);
    procedure ComPortRxChar(Sender: TObject; Count: Integer);
    procedure EdnrocxaKeyPress(Sender: TObject; var Key: Char);
    procedure EdbasEnter(Sender: TObject);
    procedure EdaltKeyPress(Sender: TObject; var Key: Char);
    procedure EdcpmKeyPress(Sender: TObject; var Key: Char);
    procedure EdbasKeyPress(Sender: TObject; var Key: Char);
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
    procedure CarregaBalanca;
    procedure calcvol;
    procedure proccxa(tipo:Integer);
  private
    { Private declarations }
  uf, cepr, mpeso : String;
  v_soma,codcxa              : Integer;
  vvalor,txcor,pescub,volcub,pescal: Real;
  selcxa  : Boolean;

  public
    { Public declarations }
    Balanca, comando, modo_leitura: string;
    dec_sep: char;
    i_ini, i_fim, unidade: Integer;
    peso: Double;

  end;

type
  PInteger = ^Integer;

Const
  PcScale = 'PcScale.dll'; //Contante para não ficar repetindo
                           //o nome do arquivo da Dll

var
  FrmRemessaSedex: TFrmRemessaSedex;
  Modelo, Porta, BaudRate: Integer;
  mascara : String;
    //Variável que armazenará o modelo da balança, função ObtemNomeBalanca
  CModelo: array[0..50] of char;

implementation

uses U_Func, DmDados, U_Principal, DB;

{$R *.dfm}
function AttachScale(hScale : THandleStream;Com,BaudRate,ByteSize,StopBits,Parity: Integer): Integer; stdcall;
external 'PcScale.dll';

function ReadScale(hScale : THandleStream; Indicator: Integer; gross,tare,net,unitd: Pchar): Integer; stdcall;
external 'PcScale.dll';

function DettachScale(hScale : THandleStream): Integer; stdcall;
external 'PcScale.dll';
{Declara a função ConfiguraBalanca existente na DLL "PcScale.dll"}
function ConfiguraBalanca(Balanca: Integer; Aplicativo: THandle): Boolean;
             stdcall; external PcScale;

{Declara a função InicializaLeitura existente na DLL "PcScale.dll"}
function InicializaLeitura(Balanca: Integer): Boolean;
             stdcall; external PcScale;

{Declara a função ObtemInformacao existente na DLL "PcScale.dll"}
function ObtemInformacao(Balanca: Integer; Campo: Integer): double;
             stdcall; external PcScale;

{Declara a função FinalizaLeitura existente na DLL "PcScale.dll"}
function FinalizaLeitura(Balanca: Integer) : Boolean;
             stdcall; external PcScale;

{Declara a função ExibeMsgErro existente na DLL "PcScale.dll"}
function EnviaPrecoCS(Balanca : integer; Preco : double) : Boolean;
             stdcall; external PcScale;

{Declara a função FinalizaLeitura existente na DLL "PcScale.dll"}
function ObtemParametrosBalanca(Balanca: Integer; Modelo: PInteger;
                             Porta: PInteger; BaudRate: PInteger
                             ): Boolean
             stdcall; external PcScale;

{Declara a função ObtemNomeBalanca existente na DLL "PcScale.dll"}
Procedure ObtemNomeBalanca(Modelo: Integer; Ret: PChar);
             stdcall; external PcScale;

{Declara a função ExibeMsgErro existente na DLL "PcScale.dll"}
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
      SqlAux1.SQL.Add('UPDATE tbsdx02 SET sdx_nomdest = :nom, ');
      SqlAux1.SQL.Add('sdx_endedest = :end, sdx_cidade = :cid, ');
      SqlAux1.SQL.Add('sdx_uf = :uf, sdx_cep = :cep ');
      SqlAux1.SQL.Add('WHERE sdx_numobj2 = :numobj2 ');
      SqlAux1.ParamByName('nom').AsString := EdJuncao.Text + ': ' + EdNovaAg.Text;
      SqlAux1.ParamByName('end').AsString := EdNovoEnd.Text;
      SqlAux1.ParamByName('cid').AsString := EdNovaCid.Text;
      SqlAux1.ParamByName('uf').AsString := EdNovaUF.Text;
      SqlAux1.ParamByName('cep').AsString := MkEdNovoCep.Text;
      SqlAux1.ParamByName('numobj2').AsString := EdObjeto.Text;

      try
        SqlAux1.ExecSQL;
        if SqlAux1.RowsAffected > 0 then
          Application.MessageBox('Informações alteradas com sucesso!', 'ADS', ID_OK)
        else
          Application.MessageBox('Nenhum dado foi alterado"!','ADS', ID_OK)

      except on e: exception do
        Application.MessageBox(PChar('Erro ao tentar atualizar dados do Objeto.' +
            'Detalhes: ' + e.Message), 'ADS', ID_OK);
      end;
    end;

end;

procedure TFrmRemessaSedex.BtnLimpaClick(Sender: TObject);
begin
  EdSeqCarga.Text :=   IntToStr(StrToInt(EdSeqCarga.Text)+1);
  EdReg.Text      :=   '0';
end;

procedure TFrmRemessaSedex.BtnReenvClick(Sender: TObject);
var sqldadosobj, num_obj, dv, sigla_obj,
  sigla_prod, insmov : String;
begin

// validação básica
if (dm.SqlSdx4sdx_numobj2.Text <> EdObjeto.Text) then
  begin
    application.MessageBox(
              PChar('Para efetuar uma repostagem é necessário indicar o número' +
                ' de objeto anterior.'),
              'ADS', MB_OK + MB_ICONERROR);
    exit;
  end;

if (DBCboBaixa.KeyValue = null) then
  begin
    application.MessageBox(
              PChar('Indique o motivo da devolução do objeto.'),
              'ADS', MB_OK + MB_ICONERROR);
    exit;
  end;


  with Dm do
    begin
      SqlAux3.Close;
      SqlAux3.SQL.Clear;
      // Procurar o próximo número de objeto livre para o produto
      // selecionado
      sqldadosobj := 'SELECT DISTINCT t.tbsdxect_num, t.tbsdxect_dv, t.tbsdxect_sigla, ' +
          's.tbsdxserv_sigla ' +
          'FROM public.tbsdx_ect t ' +
          'INNER JOIN (' +
          'SELECT MIN(tsub.tbsdxect_num) as numobj, tsub.tbsdxect_prod ' +
          'FROM public.tbsdx_ect tsub ' +
          'WHERE tsub.tbsdxect_dtvenc > CURRENT_DATE ' +
          ' AND tsub.tbsdx_use IS NULL ' +
          'GROUP BY 2 ' +
          ') t2 ON (t.tbsdxect_prod = t2.tbsdxect_prod) AND t.tbsdxect_num = t2.numobj ' +
          '  INNER JOIN tbsdxserv s  ON t2.tbsdxect_prod = s.tbsdxserv_prod ' +
          'WHERE t.tbsdxect_prod = :prod ';

      SqlAux3.SQL.Add(sqldadosobj);
      SqlAux3.ParamByName('prod').AsInteger := CboProdutoServSedex.KeyValue;
      SqlAux3.Open;
      num_obj := SqlAux3.Fields[0].AsString;
      dv := SqlAux3.Fields[1].AsString;
      sigla_obj := SqlAux3.Fields[2].AsString;
      sigla_prod := SqlAux3.Fields[3].AsString;

      // Pegando dados do destino para o Novo Envio
      SqlTbBradDeptos.Close;
      SqlTbBradDeptos.SQL.Clear;
      SqlTbBradDeptos.SQL.Add('SELECT * FROM tbbraddptos WHERE juncao = :juncao');
      SqlTbBradDeptos.Params[0].AsInteger := StrToInt(EdJuncao.Text);
      SqlTbBradDeptos.Open;
      if (SqlTbBradDeptos.RecordCount < 1) then
        begin
          application.MessageBox(
              PChar('AGÊNCIA ' + EdJuncao.Text + ' não encontrada'),
              'ADS', MB_OK + MB_ICONERROR);
          exit;
        end;
      // Novo Lote
      EdNovolote.Text   :=  IntToStr(Random(99)) + GeraNt(formatdatetime('hhmm', Time), 4);
      EdNovolote.Refresh;

      insmov :='INSERT INTO tbsdx02 (sdx_codcli, sdx_idcli, sdx_siglaobj, ' +
          'sdx_numobj, sdx_paisorigem, sdx_numobj4, sdx_nomdest, ' +
          'sdx_endedest, sdx_cidade, sdx_uf, sdx_cep, sdx_numseqarq, ' +
          'sdx_numseqreg, sdx_dtcarga, sdx_numobj2, sdx_numobj1, ' +
          'sdx_codusu, sdx_valdec, sdx_seqcarga, sdx_qtprod, sdx_dtmov) ' +
          'VALUES (99,''99'',:sigla, :numobj, ''BR'', :numobj4, :nomdest, ' +
          ':enddest, :ciddest, :ufdest, :cepdest, 99, :numreg, ' +
          'CURRENT_DATE, :numobj2, :numobj1, :codusu, :sdx_valdec, ' +
          ':sdx_seqcarga, :qtprod, :sdx_dtmov)';

      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add(insmov);
      SqlAux1.ParamByName('sigla').AsString := SqlSdxServtbsdxserv_sigla.AsString;
      SqlAux1.ParamByName('numobj').AsInteger := StrToInt(num_obj + dv);
      SqlAux1.ParamByName('numobj4').AsString := 'AR'+ num_obj + dv + sigla_prod;
      SqlAux1.ParamByName('nomdest').AsString :=  gerant(SqlTbBradDeptosjuncao.AsString,4) +
          ': ' +  SqlTbBradDeptosdepto.AsString;
      SqlAux1.ParamByName('enddest').AsString := SqlTbBradDeptosender.AsString;
      SqlAux1.ParamByName('ciddest').AsString := SqlTbBradDeptoscidade.Text;
      SqlAux1.ParamByName('ufdest').AsString := SqlTbBradDeptosuf.Text;
      SqlAux1.ParamByName('cepdest').AsString := StringReplace(SqlTbBradDeptoscep.Text, '-', '', [rfReplaceAll, rfIgnoreCase]);
      EdNovReg.Text := GeraNt(inttostr(random(999)), 3) +
            FormatDateTime('yyyymmdd', date) + FormatDateTime('hhmmss', Time) +
            GeraNT(sqlcga_acessocodigo.AsString, 4) + GeraNt(inttostr(random(999)) , 3);
      EdNovReg.Refresh;
      SqlAux1.ParamByName('numreg').AsString := EdNovReg.Text;

      SqlAux1.ParamByName('numobj2').AsString := sigla_obj + num_obj + dv + 'BR';

      SqlAux1.ParamByName('numobj1').AsString := 'AR'+ num_obj + dv + sigla_prod;

      SqlAux1.ParamByName('codusu').AsString := sqlcga_acessocodigo.AsString;
      SqlAux1.ParamByName('sdx_valdec').AsFloat := SqlSdx4sdx_valdec.Value;
      SqlAux1.ParamByName('sdx_seqcarga').AsInteger := StrToInt64(EdNovolote.Text);
      SqlAux1.ParamByName('qtprod').AsInteger :=  SqlSdx4sdx_qtprod.value;
      SqlAux1.ParamByName('sdx_dtmov').AsString := FormatDateTime('yyyy-mm-dd', SqlSdx4sdx_dtmov.Value);
      try
        SqlAux1.ExecSQL;
        EdNovoEnd.Text  :=  SqlTbBradDeptosender.Text;
        EdNovoEnd.Refresh;

        SqlAux1.Close;
        SqlAux1.SQL.Clear;

        SqlAux1.SQL.Add('UPDATE tbsdx_ect SET tbsdx_use = :use ' +
                          'WHERE tbsdxect_num = :numobj AND tbsdxect_prod = :prod');
        SqlAux1.ParamByName('use').AsString := 'S';
        SqlAux1.ParamByName('numobj').AsString := num_obj;
        SqlAux1.ParamByName('prod').AsInteger := CboProdutoServSedex.KeyValue;
        SqlAux1.ExecSQL;
        if (SqlAux1.RowsAffected < 1 ) then
          raise Exception.Create('Numero de objeto ' + sigla_obj + num_obj +
              dv + 'BR' + ' não pode ser marcado como utilizado.');

        SqlAux1.Close;
        SqlAux1.SQL.Clear;
        // Marcar o motivo de devolução no objeto anterior
        SqlAux1.SQL.Add('UPDATE tbsdx02 SET sdx_codbxa = :motivo '+
                          'WHERE sdx_numobj2 = :numobj2');
        SqlAux1.ParamByName('motivo').AsInteger := DBCboBaixa.KeyValue;
        SqlAux1.ParamByName('numobj2').AsString := SqlSdx4sdx_numobj2.Value;
        SqlAux1.ExecSQL;
        if (SqlAux1.RowsAffected < 1 ) then
          raise Exception.Create('Ocorreu um erro ao tentar informar o motivo de ' +
            'devolução para o objeto ' + SqlSdx4sdx_numobj2.Value + #13#10 +
            'O processo foi abortado.');

        // Tudo OK
        EdNovoAr.Text := sigla_obj + num_obj + dv + 'BR';
        EdNovoAr.Refresh;
        except on e: Exception do
          begin
            application.MessageBox(PChar('Ocorreu um erro fatal ao tentar ' +
                'vincular um numero de objeto. Detalhes: '+ e.Message + chr(10) +
                'Nro Objeto: ' + sigla_obj + num_obj + dv + 'BR'), 'Ads', MB_OK + MB_ICONERROR);
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
  if trim(EdObjeto.Text) = '' then
    begin
      Application.MessageBox('Digite o Número de Objeto', 'ADS', ID_OK);
      EdObjeto.SetFocus;
      exit;
    end;

    calcvol;
    mpeso:= FloatToStr(peso);

    if (pescub <= StrToFloat(mpeso)) then
      pescal  :=  StrToFloat(mpeso)
    else
      pescal  :=  pescub;

  calcvalor;

  // Início Calculo DV CEP
  v_soma := 0;
  for i:= 1 to Length(MkEdCep.Text) do
    v_soma := v_soma + StrToInt(copy(MkEdCep.Text, i, 1));

  v_soma := v_soma mod 10;
  if v_soma > 0 then
      v_soma := 10 - v_soma;

  CEPr := Format('\/%s%d\\', [MkEdCep.Text, v_soma]);
  // Fim Calculo DV CEP

  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add('UPDATE tbsdx02 ');
      SqlAux1.SQL.Add('SET sdx_cepnet = E:cepnet, sdx_valor = :valor, ');
      SqlAux1.SQL.Add('sdx_peso = :peso, sdx_qtde = :qtde, sdx_tvalor = :tvalor,');
      SqlAux1.SQL.Add('sdx_dtenvio = CURRENT_DATE, sdx_valar = :valar, ');
      { TODO : Procurar saber o que é esse porc com valor de 0.003 }
      SqlAux1.SQL.Add('sdx_porc = 0.003, sdx_valmin = 275.00, ');
      SqlAux1.SQL.Add('sdx_difval = :valdif, sdx_horaenvio = CURRENT_TIME,');
      SqlAux1.SQL.Add('sdx_bas = :bas, sdx_cmp = :cmp, sdx_alt = :alt, ');
      SqlAux1.SQL.Add('sdx_pescub = :pescub, sdx_codcxa = :codcxa ');
      SqlAux1.SQL.Add('WHERE sdx_numobj2 = E:numboj2 ');
      SqlAux1.ParamByName('cepnet').AsString := CEPr;
      SqlAux1.ParamByName('valor').AsFloat := Moeda2Float(EdValor.Text);
      SqlAux1.ParamByName('peso').AsFloat := Moeda2Float(EdPeso.Text);
      SqlAux1.ParamByName('qtde').AsInteger := StrToInt(EdVol.Text);
      SqlAux1.ParamByName('valor').AsFloat := vvalor;
      SqlAux1.ParamByName('valar').AsFloat := SqlSdxServtbsdxserv_txasrv.Value;
      SqlAux1.ParamByName('valdif').AsFloat := max(0, (SqlSdx4sdx_valdec.Value - 275.00));
      SqlAux1.ParamByName('bas').AsFloat := Moeda2Float(Edbas.Text);
      SqlAux1.ParamByName('cmp').AsFloat := Moeda2Float(Edcpm.Text);
      SqlAux1.ParamByName('alt').AsFloat := Moeda2Float(Edalt.Text);
      SqlAux1.ParamByName('pescub').AsFloat := pescal;
      SqlAux1.ParamByName('codcxa').AsInteger := codcxa;
      SqlAux1.ParamByName('numboj2').AsString := EdObjeto.Text;
      try
        SqlAux1.ExecSQL;
        if SqlAux1.RowsAffected > 0 then
          Application.MessageBox('Informações alteradas com sucesso!', 'ADS', ID_OK)
        else
          Application.MessageBox('Nenhum dado foi alterado"!', 'ADS', ID_OK);

        SqlAux1.Close;

        Timer1.Enabled := false;
        limpa;
        FinalizaLeitura(0);
        EdObjeto.SetFocus;
      except on e: exception do
        begin
          Application.MessageBox(PChar('Erro: ' + e.Message + chr(10) +
              'Verifique com o CPD'),'ADS',ID_OK);
          EdObjeto.SetFocus;
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
  if (key = #13) and (trim(EdJuncao.Text) <> '') then
    begin
      if vernum(EdJuncao.Text) =  true then
        begin
          verag;
          EdJuncao.Text :=  GeraNT(EdJuncao.Text, 4);
          EdObjeto.Clear;
          objtbsdx02(1);
          DBGrid001.SetFocus;
        end
      else
        begin
          Application.MessageBox(PChar('Digite números'), 'ADS', ID_OK);
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
  if (key = #13) and  (Length(EdObjeto.Text) > 10) then
    begin
      if vernum(copy(EdObjeto.Text, 3, 9)) =  true then
        begin
          EdJuncao.Clear;
          objtbsdx02(0);
          selcxa := false;
          if Tag = 9 then
            Ednrocxa.SetFocus
          else
            BtnReenv.SetFocus;
        end
      else
        begin
          Application.MessageBox(PChar(EdObjeto.Text + ' não é um número ' +
              'de objeto ou AR válido. Tente novamente.'),
            'ADS',  ID_OK);
          EdObjeto.Clear;
          EdObjeto.SetFocus;
          Exit;
        end;
    end;

end;

procedure TFrmRemessaSedex.EdPesoEnter(Sender: TObject);
begin
  if ComPort.Connected then
      ComPort.Close;
      
  ComPort.Open;
  if modo_leitura = 'Comando' then
    begin
      if (Length(Trim(comando)) < 1) then
        begin
          Application.MessageBox(PChar('A balança está configurada para ' +
                  'para o modo de ''Comando'' porém não há instrução para ' +
                  'enviar. Configure a balança novamente!'),
              'ADS', MB_OK + MB_ICONERROR);
          BtnSair.SetFocus;
          ComPort.Close;
          exit;
        end;
      // Modo de envio de comando
      ComPort.WriteStr(comando);
    end;
end;

procedure TFrmRemessaSedex.EdPesoExit(Sender: TObject);
begin
  if ComPort.Connected then
    ComPort.Close;
end;

procedure TFrmRemessaSedex.EdPesoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    if FrmRemessaSedex.Tag = 9 then
      BtnSalva.SetFocus;
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
                  Application.MessageBox(Pchar('Digite Altura da Caixa Somente Números'),'ADS',ID_OK);
                  Edalt.SetFocus;
                  exit;
                end;
            end
          else
            begin
              Application.MessageBox(Pchar('Digite Comprimento somente Números'),'ADS',ID_OK);
              Edcpm.SetFocus;
              exit;
            end;
        end
      else
        begin
          Application.MessageBox(Pchar('Digite Largura somente Números'),'ADS',ID_OK);
          Edbas.SetFocus;
          exit;
        end;
    end
  else
    begin
      Application.MessageBox(Pchar('Digite Código da Caixa somente Números'),'ADS',ID_OK);
      Ednrocxa.SetFocus;
      exit;
    end;
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
          Application.MessageBox(Pchar('Digite ou Leia o Código da Caixa !'), 'ADS', ID_OK);
          Ednrocxa.SetFocus;
        end
      else
        begin
          with Dm do
            begin
              SqlAux1.Close;
              SqlAux1.SQL.Clear;
              SqlAux1.SQL.Add('SELECT t.id_cxa, t.nrocxa, t.cmpcxa, ');
              SqlAux1.SQL.Add('  t.bascxa, t.altcxa, t.volcxa ');
              SqlAux1.SQL.Add('FROM tbcadcaixa t ');
              SqlAux1.SQL.Add('WHERE t.nrocxa = :nrocxa ');
              SqlAux1.SQL.Add('LIMIT 1');
              SqlAux1.ParamByName('nrocxa').AsString := Ednrocxa.Text;
              SqlAux1.Open;
              case SqlAux1.RecordCount of
                1:
                  begin
                    codcxa          :=  SqlAux1.FieldByName('id_cxa').AsInteger;
                    Edbas.Enabled   :=  false;
                    Edcpm.Enabled   :=  false;
                    Edalt.Enabled   :=  false;
                    Edbas.Text      :=  FormatFloat('##0.00;;', SqlAux1.FieldByName('bascxa').AsFloat);
                    Edcpm.Text      :=  FormatFloat('##0.00;;', SqlAux1.FieldByName('cmpcxa').AsFloat);
                    Edalt.Text      :=  FormatFloat('##0.00;;', SqlAux1.FieldByName('altcxa').AsFloat);
                    EdVol.SetFocus;
                  end;
                else
                  begin
                    codcxa          :=  SqlAux1.FieldByName('id_cxa').AsInteger;
                    Edbas.Enabled   :=  true;
                    Edcpm.Enabled   :=  true;
                    Edalt.Enabled   :=  true;
                    Edbas.SetFocus;
                  end;
              end;
              selcxa := true;
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
  CarregaBalanca;
  EdReg.Text  :=  '0';
  with Dm do
    begin
      SqlSdx4.Close;
      SqlSdx4.SQL.Clear;
      SqlSdx4.SQL.Add('SELECT t.*, ' +
        's.tbsdxserv_sigla, s.tbsdxserv_dsc, s.tbsdxserv_prod, ' +
        'd.bxasdx_dscbxa');
      SqlSdx4.SQL.Add('FROM public.tbsdx02 t ');
      SqlSdx4.SQL.Add('    INNER JOIN public.tbsdx_ect e ON ' +
            '(t.sdx_numobj2 = e.tbsdxect_sigla || ' +
            'e.tbsdxect_num || e.tbsdxect_dv || ''BR'') ');
      SqlSdx4.SQL.Add('    INNER JOIN public.tbsdxserv s ON ' +
            '(e.tbsdxect_prod = s.tbsdxserv_prod)');
      SqlSdx4.SQL.Add('    LEFT JOIN public.tbbxasdx d ON ' +
            '(t.sdx_codbxa = d.bxasdx_codbxa)');
      SqlSdx4.SQL.Add('ORDER BY t.sdx_dtcarga DESC LIMIT 10	');


      dm.SqlSdxServ.Close;
      dm.SqlSdxServ.SQL.Clear;
      dm.SqlSdxServ.SQL.Add('SELECT t.* FROM public.tbsdxserv t ');
      dm.SqlSdxServ.Open;
      CboProdutoServSedex.Refresh;
      // Reenvio
      if FrmRemessaSedex.tag = 8 then
        begin
          EdJuncao.Enabled  := True;
          EdJuncao.ReadOnly := False;
          BtnReenv.Enabled := True;
          // Combo de Motivos de Devolução
          Sqltbbxasdx.Open;
          if (Sqltbbxasdx.RecordCount > 0) then
            begin
              DBCboBaixa.Enabled  :=  true;
              DBCboBaixa.Refresh;
            end;
          // Grid de Ultimos Registros criados ou resultado de pesquisas
          SqlSdx4.Open;
          if (SqlSdx4.RecordCount > 0) then
            begin
              SqlSdx4.First;
              DBGrid001.Refresh;
            end;
        end
      // Pesagem
      else if FrmRemessaSedex.Tag = 9 then
        begin
          BtnSalva.Enabled  := true;
          BtnAltera.Enabled := true;
        end
      // Consulta 
      else if FrmRemessaSedex.Tag = 6 then
        begin
          EdJuncao.Enabled  := True;
          EdJuncao.ReadOnly := False;
        end;


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
        MkEdNovoCep.Text := SqlTbBradDeptoscep.Text;
      end
    else  if SqlTbBradDeptos.RecordCount > 1 then
      begin
        Application.MessageBox(Pchar('Verificar Junto ao Cpd' + chr(10) +
              'Mais de Uma Agência Encontrada'),'ADS',ID_OK);
        EdJuncao.SetFocus;
        exit;
      end
    else
      begin
        Application.MessageBox(Pchar('Verificar Junto ao Cpd' + chr(10) +
              'Agencia Não Encontrada'),'ADS',ID_OK);
        EdJuncao.SetFocus;
        exit;
      end
  end;
end;

procedure TFrmRemessaSedex.atuddsag(tipo: integer);
begin
//  if dm.SqlSdx4sdx_numobj4.Text <> '' then
    with dm do
      begin
        EdObjeto.Text :=  SqlSdx4sdx_numobj2.Text;

        // tipo = 0 ou 1
        EdJuncao.Text      :=  copy(SqlSdx4sdx_nomdest.Text,1,4);
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
        EdValAr.Text       :=  FormatFloat('#,##0.00;;',SqlSdx4sdx_valar.AsFloat);
        EdValMin.Text      :=  FormatFloat('#,##0.00;;',SqlSdx4sdx_valmin.AsFloat);
        EdSeqCarga.Text    :=  SqlSdx4sdx_seqcarga.AsString;
        EdPorc.Text        :=  FormatFloat('#,##0.000;;',SqlSdx4sdx_porc.AsFloat);
        EdAdVal.Text       :=  FormatFloat('#,##0.00;;',SqlSdx4sdx_difval.AsFloat);
        EdReg.Text         :=  SqlSdx4sdx_numseqreg.Text;
        EdQtde.Text        :=  SqlSdx4sdx_qtprod.Text;
        MkEdDtMov.Text     :=  FormatDateTime('dd/mm/yyyy',SqlSdx4sdx_dtmov.Value);
        MkEdCarga.text     :=  FormatDateTime('dd/mm/yyyy',SqlSdx4sdx_dtcarga.Value);
        Ednrocxa.Text      :=  SqlSdx4sdx_codcxa.AsString;
        Edbas.Text         :=  FormatFloat('##0.00;;', SqlSdx4sdx_bas.AsFloat);
        Edcpm.Text         :=  FormatFloat('##0.00;;', SqlSdx4sdx_cmp.AsFloat);
        Edalt.Text         :=  FormatFloat('##0.00;;', SqlSdx4sdx_alt.AsFloat);
        CboProdutoServSedex.KeyValue := SqlSdx4tbsdxserv_codprod.Value;

        if (SqlSdx4sdx_dtenvio.Value > 0) then
          MkEdDtEnvio.Text :=  FormatDateTime('dd/mm/yyyy', SqlSdx4sdx_dtenvio.Value)
        else
          MkEdDtEnvio.Clear;

        if (SqlSdx4sdx_dtbaixa.Value > 0) then
          MkEdBaixa.Text :=  FormatDateTime('dd/mm/yyyy', SqlSdx4sdx_dtbaixa.Value)
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
      SqlAux1.SQL.Add('SELECT tb_valtxaar FROM tbtxaar');
      SqlAux1.Open;
      txcor :=  SqlAux1.Fields[00].Value; // taxa de Serviço AR - Correio
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
      SqlAux1.SQL.Add('SELECT tb_pesosdxlocval FROM tbsdxprecoloc ');
      SqlAux1.SQL.Add('WHERE (:peso between tb_pesosdxlocini AND tb_pesosdxlocfin)');
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
      SqlAux1.SQL.Add('SELECT tb_ufdiv FROM tbcepdivisa ');
      SqlAux1.SQL.Add('WHERE (:cep BETWEEN tb_cepini AND tb_cepfin) ');
      SqlAux1.SQL.Add('   AND (tb_ufdiv = :uf) LIMIT 1');
      SqlAux1.Params[0].AsString  :=  MkEdCep.Text;
      SqlAux1.Params[1].AsString  :=  EdUF.Text;
      SqlAux1.Open;
      uf := SqlAux1.Fields[0].AsString;
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('SELECT tb_pesosdxdivval FROM tbsdxprecodiv ');
      SqlAux2.SQL.Add('WHERE (:peso BETWEEN tb_pesosdxdivini AND tb_pesosdxdivfin) ');
      SqlAux2.SQL.Add('    AND (tb_ufsdxprcdiv = :uf)');
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
      SqlAux1.SQL.Add('SELECT tb_cepcapuf FROM tbcepcap ');
      SqlAux1.SQL.Add('WHERE (:cep BETWEEN tb_cepcapcepini AND tb_cepcapcepfin) ');
      SqlAux1.SQL.Add('    AND (tb_cepcapuf = :uf) LIMIT 1');
      SqlAux1.Params[0].AsString  :=  MkEdCep.Text;
      SqlAux1.Params[1].AsString  :=  EdUF.Text;
      SqlAux1.Open;
      uf := SqlAux1.Fields[0].AsString;
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('SELECT tb_pesosdxval FROM tbsdxprecouf ');
      SqlAux2.SQL.Add('WHERE (:peso BETWEEN tb_pesosdxini AND tb_pesosdxfin) ');
      SqlAux2.SQL.Add('    AND (tb_ufsdxprc = :uf)');
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
      SqlAux1.SQL.Add('SELECT tb_ufint FROM tbcepinterior ');
      SqlAux1.SQL.Add('WHERE (:cep BETWEEN tb_cepini and tb_cepfin) ');
      SqlAux1.SQL.Add('   AND (tb_ufint = :uf) LIMIT 1');
      SqlAux1.Params[0].AsString  :=  MkEdCep.Text;
      SqlAux1.Params[1].AsString  :=  EdUF.Text;
      SqlAux1.Open;
      uf := SqlAux1.Fields[0].AsString;
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('SELECT tb_pesosdxval FROM tbsdxprecoint ');
      SqlAux2.SQL.Add('WHERE (:peso BETWEEN tb_pesosdxini AND tb_pesosdxfin) ');
      SqlAux2.SQL.Add('AND (tb_ufsdxprc = :uf)');
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
  EdPeso.Clear;
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
          Application.MessageBox('Registro não encontrado, tente novamente!','ADS',ID_OK);
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
      SqlSdx4.Close;
      SqlSdx4.SQL.Clear;
      SqlSdx4.SQL.Add('SELECT t.*, ' +
        's.tbsdxserv_sigla, s.tbsdxserv_dsc, s.tbsdxserv_prod, ' +
        'd.bxasdx_dscbxa');
      SqlSdx4.SQL.Add('FROM public.tbsdx02 t ');
      SqlSdx4.SQL.Add('    INNER JOIN public.tbsdx_ect e ON ' +
            '(t.sdx_numobj2 = e.tbsdxect_sigla || ' +
            'e.tbsdxect_num || e.tbsdxect_dv || ''BR'') ');
      SqlSdx4.SQL.Add('    INNER JOIN public.tbsdxserv s ON ' +
            '(e.tbsdxect_prod = s.tbsdxserv_prod)');
      SqlSdx4.SQL.Add('    LEFT JOIN public.tbbxasdx d ON ' +
            '(t.sdx_codbxa = d.bxasdx_codbxa)');
      SqlSdx4.SQL.Add('WHERE t.sdx_nomdest ILIKE :juncao ');
      if (copy(EdObjeto.Text, 1, 2) = 'AR') then
        SqlSdx4.SQL.Add('  AND t.sdx_numobj4 LIKE :obj')
      else
        SqlSdx4.SQL.Add('  AND t.sdx_numobj2 LIKE :obj');

      SqlSdx4.SQL.Add('ORDER BY t.sdx_dtcarga DESC');
      SqlSdx4.ParamByName('obj').AsString :=  EdObjeto.Text + '%';
      SqlSdx4.ParamByName('juncao').AsString :=  EdJuncao.Text + '%';

{*
      if (tipo = 0) then
        begin
          SqlSdx4.SQL.Add('WHERE t.sdx_numobj = :dds ');
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
*}

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
    0:  StsRemSdx.Panels[1].Text := 'Falha comunciando-se com a balança.';
    1:  StsRemSdx.Panels[1].Text := 'Peso Oscilando.';
    2:  StsRemSdx.Panels[1].Text := 'Peso Estável.';
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
      StsRemSdx.Panels[1].Text := '---------';
end;


procedure TFrmRemessaSedex.CarregaBalanca;
var iniFile, balancaFile: TiniFile;
Balancas : TStringList;
i: Integer;
s, t: String;
begin
  try
    IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
    Balancas:= TStringList.Create;
    if iniFile.SectionExists('Balancas') then
      begin
        iniFile.ReadSection('Balancas', Balancas);
        // Se não houver Balanca configurada, gerar alerta
        // Se houver balanca configurada mas não marcada como padrão, utilizar a ultima
        for i:= 0 to Balancas.Count - 1 do
          begin
            s:= GetCurrentDir + PathDelim + Balancas[i] + '.ini';
            if (FileExists(s)) then
              begin
                Balanca := Balancas[i];
                t:= iniFile.ReadString ('Balancas', Balanca, Balanca);
                if (t = '1') or (i = Balancas.Count - 1) then
                  begin // Se for a primeira marcada para ser usada ou
                        // se for a ultima encontrada
                    ComPort.LoadSettings(stIniFile, s);
                    balancaFile:= TIniFile.Create(s);
                    modo_leitura:= balancaFile.ReadString('ConfigLeituraPeso', 'Modo', 'Constante');
                    comando:= balancaFile.ReadString('ConfigLeituraPeso', 'Comando', 'R');
                    i_ini:= balancaFile.ReadInteger('ConfigLeituraPeso', 'InicioLeitura', 0);
                    i_fim:= balancaFile.ReadInteger('ConfigLeituraPeso', 'FimLeitura', 0);
                    t:= balancaFile.ReadString('ConfigLeituraPeso', 'SeparadorDecimal', DecimalSeparator);
                    dec_sep:= t[1];
                    unidade:= balancaFile.ReadInteger('ConfigLeituraPeso', 'UnidadeMedida', 1);
                    balancaFile.Free;
                  end;
              end;
          end;
      end;

    if Balanca = null then
      begin
        Application.MessageBox(PChar('Nenhuma balanca configurada. '  +
            'Vá até o painel de Configurações e adicione uma.'), 'ADS',ID_OK);
      end;

    iniFile.Free;

  Except
    Application.MessageBox(PChar('Erro ao carregar informações da balança'),'ADS',ID_OK);
  end;
end;


procedure TFrmRemessaSedex.ComPortRxChar(Sender: TObject; Count: Integer);
var
  Str: String;
begin
  try
    ComPort.ReadStr(Str, Count);
    if (modo_leitura = 'Constante') then
      Str := copy(Str, i_ini, i_fim - i_ini);

    peso := StrToPeso(Str, dec_sep);

    if (peso > 0) then
      peso := peso / unidade;

    EdPeso.Text:= FloatToStr(peso);
  Except
    Application.MessageBox(PChar('Erro ao ler peso. ' +
            'A balança está corretamente configurada?'),
        'ADS',ID_OK);
    ComPort.Close;
  end;

end;

end.
