unit U_FrmRemSdx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, DBCtrls, Mask, StdCtrls, Buttons, Grids, DBGrids;

type
  TFrmRemSdx = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label34: TLabel;
    DBGrid002: TDBGrid;
    BtnLimpa: TBitBtn;
    BtnSalva: TBitBtn;
    BtnReenv: TBitBtn;
    BtnSair: TBitBtn;
    EdJuncao: TEdit;
    EdPeso: TEdit;
    EdVol: TEdit;
    EdDestino: TEdit;
    EdEnd: TEdit;
    EdBairro: TEdit;
    EdCid: TEdit;
    EdUF: TEdit;
    MkEdCep: TMaskEdit;
    EdSeqCarga: TEdit;
    EdValor: TEdit;
    EdReg: TEdit;
    EdVvalor: TEdit;
    EdObjeto: TEdit;
    Edvaldec: TEdit;
    EdValAr: TEdit;
    EdPorc: TEdit;
    EdAdVal: TEdit;
    EdValMin: TEdit;
    EdQtde: TEdit;
    BtnAltera: TBitBtn;
    MkEdDtMov: TMaskEdit;
    MkEdDtEnvio: TMaskEdit;
    MkEdCarga: TMaskEdit;
    MkEdBaixa: TMaskEdit;
    DBCboBaixa: TDBLookupComboBox;
    StsRemSdx: TStatusBar;
    Timer1: TTimer;
    procedure EdPesoEnter(Sender: TObject);
    procedure BtnSalvaClick(Sender: TObject);
    procedure EdPesoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSairClick(Sender: TObject);
    procedure EdObjetoKeyPress(Sender: TObject; var Key: Char);
    procedure atudds;
    procedure ObtemConfiguracoes;
    procedure limpa;
  private
    { Private declarations }
  CEPr  : string;
  v_soma  : Integer;
  public
    { Public declarations }
  end;

type
  PInteger = ^Integer;

Const
  PcScale = 'PcScale.dll'; //Contante para não ficar repetindo
                           //o nome do arquivo da Dll

var
  FrmRemSdx: TFrmRemSdx;
  Modelo, Porta, BaudRate: Integer;
  mascara : String;
    //Variável que armazenará o modelo da balança, função ObtemNomeBalanca
  CModelo: array[0..50] of char;


implementation

uses U_Func, DmDados;

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

procedure TFrmRemSdx.ObtemConfiguracoes;
begin
  if ObtemParametrosBalanca(0, @Modelo, @Porta, @BaudRate) then
    begin
      ObtemNomeBalanca(Modelo, CModelo);
    end;
end;


procedure TFrmRemSdx.Timer1Timer(Sender: TObject);
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
      ShowMessage('---------');
end;

procedure TFrmRemSdx.BtnSairClick(Sender: TObject);
begin
  Close();
end;

procedure TFrmRemSdx.BtnSalvaClick(Sender: TObject);
var i:Integer;
begin
//  Timer1.Enabled := false;
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
  with Dm do
    begin
      if vernum(copy(EdObjeto.Text,3,9)) =  true then
        begin
          SqlAux1.Close;
          SqlAux1.SQL.Clear;
          SqlAux1.SQL.Add('update tbsdx ');
          SqlAux1.SQL.Add('set sdx_cepnet = :cepnet,sdx_peso = :peso,sdx_dtenvio = (select current_date),sdx_horaenvio = (select current_time(0)) where (sdx_numobj = :numboj) ');
          SqlAux1.Params[00].AsString  :=  cepr;
          SqlAux1.Params[01].AsString  :=  VirgPonto2(EdPeso.Text);
          SqlAux1.Params[02].AsString  :=  copy(EdObjeto.Text,3,9);
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

end;

procedure TFrmRemSdx.EdObjetoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      if vernum(copy(EdObjeto.Text,3,9)) =  true then
        begin
          with Dm do
            begin
              if vernum(copy(EdObjeto.Text,3,9)) =  true then
                begin
                  SqlSdx5.Close;
                  SqlSdx5.SQL.Clear;
                  SqlSdx5.SQL.Add('select sdx_codcli,sdx_idcli,sdx_siglaobj,sdx_numobj,');
                  SqlSdx5.SQL.Add('sdx_paisorigem,sdx_codoperacao,sdx_numobj3,sdx_nomdest,sdx_endedest,sdx_cidade,');
                  SqlSdx5.SQL.Add('sdx_uf,sdx_cep,sdx_numseqarq,sdx_numseqreg,sdx_dtcarga,sdx_seqcarga,');
                  SqlSdx5.SQL.Add('sdx_numobj2,sdx_cepnet,sdx_numobj1,sdx_numobj4 ,sdx_numobj5,');
                  SqlSdx5.SQL.Add('sdx_codusu,  sdx_peso,  sdx_qtd,  sdx_dtenvio,  sdx_horaenvio from tbsdx ');
                  SqlSdx5.SQL.Add('where (sdx_numobj = :dds)');
                  SqlSdx5.ParamByName('dds').Text :=  copy(EdObjeto.Text,3,9);
                  SqlSdx5.Open;
                  DBGrid002.Refresh;
                  atudds;
                  EdPeso.SetFocus;
                end;
            end;
        end;
    end;
end;
procedure TFrmRemSdx.EdPesoEnter(Sender: TObject);
begin
  if InicializaLeitura(0) then
       Timer1.Enabled := True;
end;

procedure TFrmRemSdx.EdPesoKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    BtnSalva.SetFocus;
end;

procedure TFrmRemSdx.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action  :=  caFree;
end;

procedure TFrmRemSdx.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
  FrmRemSdx.SelectNext(ActiveControl,true,true);
end;

procedure TFrmRemSdx.atudds;
begin
  with Dm do
  begin
    EdDestino.Text  :=  trim(SqlSdx5sdx_nomdest.Text);
    EdEnd.Text      :=  Trim(SqlSdx5sdx_endedest.Text);
    EdCid.Text      :=  Trim(SqlSdx5sdx_cidade.Text);
    EdUF.Text       :=  Trim(SqlSdx5sdx_uf.Text);
    MkEdCep.Text    :=  Trim(SqlSdx5sdx_cep.Text);
    EdVol.Text      :=  Trim(SqlSdx5sdx_qtd.Text);
  end;
end;
procedure TFrmRemSdx.limpa;
begin
  EdObjeto.Clear;
  EdDestino.Clear;
  EdEnd.Clear;
  EdCid.Clear;
  EdUF.Clear;
  MkEdCep.Clear;
end;


end.
