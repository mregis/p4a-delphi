unit U_PreCadToken;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExcelXP, StdCtrls, ExtCtrls, ComCtrls,  Buttons, ShlObj,
  OleConst, SysConst, Types, OfficeXP,ComObj, ActiveX,  DB, Math, OleServer, OleDB,
  DBCtrls;

type
  TFrmPreCadToken = class(TForm)
    ScrollBox1: TScrollBox;
    EdErro: TEdit;
    StBr: TStatusBar;
    Ednumlote: TEdit;
    OpenArq: TOpenDialog;
    ExcelApplication1: TExcelApplication;
    StrGridDados: TStringGrid;
    EdLocal: TEdit;
    BtnAbrir: TBitBtn;
    EdQtdreg: TEdit;
    EdGrava: TEdit;
    Panel5: TPanel;
    Lbl001: TLabel;
    NovoLoteChkBox: TCheckBox;
    Bevel1: TBevel;
    BtnFechar: TBitBtn;
    BtnSalvar: TBitBtn;
    BtnLeitura: TBitBtn;
    LabelLote: TLabel;
    LabelErros: TLabel;
    LabelGravados: TLabel;
    LabelLidos: TLabel;
    CboProdutoServSedex: TDBLookupComboBox;
    Label38: TLabel;
    PanelProgress: TPanel;
    PanelProgressBar: TProgressBar;
    procedure NovoLoteChkBoxClick(Sender: TObject);
    procedure BtnAbrirClick(Sender: TObject);
    procedure BtnLeituraClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
//    procedure lertk;
//    procedure lertc;
//    procedure lerol;
//    procedure lerol2;
    procedure gravaol;
    procedure gravaol2;
    procedure gravatk;
    procedure gravatk2;
    procedure gravatc;
    procedure gravatc2;
    procedure crgtk;
//    procedure lertb;
    procedure gravatb;

    procedure lerXlsPreCarga;
  private
    WorkBk : _WorkBook;
    WorkSheet : _WorkSheet;
    v_soma,K, X, K1,t : Integer;
    RangeMatrix : Variant;
    FileName : WideString;
    mcep,cepr,seldup,agant,insere : string;
    numobj, novolote, lin, nLote : string;
    arq : TextFile;
    nLotes, agencias : TStringList;
    procedure ProgressBarStepItOne;

    { Private declarations }
  public
    { Public declarations }
  end;

type
  TPagante = record
    cod : Integer; // Código do Produto
    desc : String[50]; // Descrição
    cartao: String[9];
    qtde: Integer; // Qtde de Número de objetos
  end;

var
  FrmPreCadToken: TFrmPreCadToken;

implementation

uses DmDados, U_Func, ZDataset;

{$R *.dfm}

procedure TFrmPreCadToken.BtnAbrirClick(Sender: TObject);
begin
  if FrmPreCadToken.Tag = 3 then
    OpenArq.Filter  :=  '*.*';
  OpenArq.Execute;
  EdLocal.Text := OpenArq.FileName;
end;

procedure TFrmPreCadToken.BtnLeituraClick(Sender: TObject);
begin
  t:= 0;
  Lbl001.Caption  :='';
  if (trim(EdLocal.Text) = '') then
    begin
      Application.MessageBox('Escolha Um Arquivo! ','Ads',MB_OK + MB_ICONERROR);
      BtnAbrir.SetFocus;
      exit;
    end;

  EdQtdreg.Text :=  '0';
  EdErro.Text   :=  '0';
  PanelProgress.Visible := True;
  PanelProgress.Refresh;
  try
    lerXlsPreCarga;
  finally
    PanelProgressBar.Position := 0;
    PanelProgress.Visible := False;
  end;

end;

procedure TFrmPreCadToken.FormShow(Sender: TObject);
begin
  Lbl001.Color  :=  $00FEE39C;
  Lbl001.Visible:=  false;

  with dm do
    begin
      SqlSdxServ.Close;
      SqlSdxServ.SQL.Clear;
      SqlSdxServ.SQL.Add('SELECT * FROM public.tbsdxserv t ');
      SqlSdxServ.SQL.Add('WHERE t.tbsdxserv_status = 1 AND ');
      SqlSdxServ.SQL.Add('(t.tbsdxserv_dsc ILIKE ''%TOKEN%'' OR ');
      SqlSdxServ.SQL.Add('t.tbsdxserv_dsc ILIKE ''%TANCODE%'' OR ');
      SqlSdxServ.SQL.Add('t.tbsdxserv_dsc ILIKE ''% OL %'')');

      SqlSdxServ.Open;
      CboProdutoServSedex.Refresh;
    end;

  if (FrmPreCadToken.Tag in[3]) then
      BtnLeitura.Caption  := 'Grava';
end;

procedure TFrmPreCadToken.BtnSalvarClick(Sender: TObject);
var lotemin, lotemax : Int64;
i : Integer;
begin
  EdGrava.Text :=  '0';
  nLote := '';
  // Verificando itens de preenchimeno obrigatório
  if (trim(CboProdutoServSedex.Text) = '') then
    begin
      application.MessageBox(PChar('Selecione um Produto!'),
          'Ads', MB_OK + MB_ICONINFORMATION);
      exit;
    end;

  // Verificando se é pra gerar um novo número de Lote ou aceitar
  // o que foi passado
  if NovoLoteChkBox.Checked then
    begin
      nLotes := TStringList.Create;
      For i := 3 To 6 Do
        begin
          lotemin := Trunc(Power(10, i));
          lotemax := Trunc(Power(10, i + 1));

          // Numero de Lotes incrementais a partir do ultimo lote utilizado
          With Dm do
            begin
              SqlAux2.Close;
              SqlAux2.SQL.Clear;
              SqlAux2.SQL.Add('SELECT MAX(s.sdx_seqcarga) as nLote ');
              SqlAux2.SQL.Add('FROM tbsdx02 s ');
              SqlAux2.SQL.Add('WHERE s.sdx_seqcarga BETWEEN :lotemin AND :lotemax');
              SqlAux2.ParamByName('lotemin').AsInteger := lotemin;
              SqlAux2.ParamByName('lotemax').AsInteger := lotemax;
              SqlAux2.Open;
              if (SqlAux2.RecordCount > 0) then
                if (SqlAux2.FieldByName('nLote').AsInteger < lotemax) then
                  begin
                    nLote := IntToStr(SqlAux2.FieldByName('nLote').AsInteger + 1);
                    break;
                  end;
            end;
        end;

      Ednumlote.Text := nLote;
      nLotes.add(nLote);
    end
  else
    begin
      if (TryStrToInt64(trim(Ednumlote.Text), lotemin) ) then
        begin
          nLote := IntToStr(lotemin);
          With Dm do
            begin
              SqlAux2.Close;
              SqlAux2.SQL.Clear;
              SqlAux2.SQL.Add('SELECT COUNT(1) as qt ');
              SqlAux2.SQL.Add('FROM tbsdx02 s ');
              SqlAux2.SQL.Add('WHERE s.sdx_seqcarga = :lote');
              SqlAux2.ParamByName('lote').AsInteger := lotemin;
              SqlAux2.Open;
              if (SqlAux2.FieldByName('qt').AsInteger > 0) then
                begin
                  Application.MessageBox(
                      PChar('Já existe um Lote com esse número! ' +
                            'Utilize outro n° de Lote !'),
                          'Ads', MB_OK + MB_ICONINFORMATION);
                  Ednumlote.Enabled := true;
                  Ednumlote.SetFocus;
                  exit;
                end;
            end;
        end;
    end;

  if (nLote = '') or (nLote = '0') then
    begin
      application.MessageBox(PChar('Número de Lote Inválido! Digite um n° de Lote !'), 'Ads', MB_OK + MB_ICONINFORMATION);
      Ednumlote.Enabled := true;
      Ednumlote.SetFocus;
      exit;
    end;

  try
    PanelProgress.Visible := True;
    PanelProgress.Refresh;
    // OL não pode buscar numeros de objetos pois
    // serão multiplos pagantes (produtos) na planilha
      With Dm do
        begin
          if AnsiPos(' OL ', SqlSdxServtbsdxserv_dsc.Value) < 1 then
            begin // Token ou Tancode
              SqlAux2.Close;
              SqlAux2.SQL.Clear;
              SqlAux2.SQL.Add('SELECT COUNT(t.tbsdxect_num) as qt_obj ');
              SqlAux2.SQL.Add('FROM public.tbsdx_ect t WHERE t.tbsdx_use IS NULL ');
              SqlAux2.SQL.Add('AND t.tbsdxect_prod = :prod');
              SqlAux2.SQL.Add('AND t.tbsdxect_dtvenc > CURRENT_DATE ');
              SqlAux2.ParamByName('prod').AsInteger := CboProdutoServSedex.KeyValue;
              SqlAux2.Open;
              if (SqlAux2.FieldByName('qt_obj').AsInteger < StrtoInt(EdQtdreg.Text)) then
                begin
                  Application.MessageBox(PChar('Quantidade insuficiente de números ' +
                      'de objeto disponíveis. ' + #13#10 +
                      'Solicite uma nova faixa para o Correios.'),
                      'ADS', ID_OK);
                  BtnSalvar.Enabled :=  false;
                  exit;
                end;

              if AnsiPos('TOKEN', SqlSdxServtbsdxserv_dsc.Value) > 0  then
                begin
                  gravatk2;
                end
              else if AnsiPos('TANCODE', SqlSdxServtbsdxserv_dsc.Value) > 0  then
                begin
                  gravatc2;
                end
              else
                begin
                  ShowMessage('Erro ao tentar identificar o produto!');
                  exit;
                end;
            end
          else
            begin
              gravaol2;
            end;
        end;

  finally
    PanelProgress.Visible := False;
    PanelProgressBar.Position := 0;
  end;

  if (trim(EdGrava.Text) <> '') and (StrToInt(EdGrava.Text) > 0) then
    begin
      application.MessageBox(PChar(EdGrava.Text  + ' registros inseridos com sucesso!'),
        'Ads', MB_OK + MB_ICONERROR);

      BtnSalvar.Enabled := false;
      BtnLeitura.Enabled := true;
      if (nLotes.Count > 0) then
        begin
          Lbl001.Visible := true;
          Lbl001.Color := clRed;
          Lbl001.Font.Size :=  12;
          Lbl001.Font.Style := [fsBold];
          Lbl001.Caption := 'Lote[s] ' + nLotes.CommaText + ' criado[s]';
          nLotes.Free;
        end;
    end;

end;

procedure TFrmPreCadToken.gravatk;
var insmov, sqldadosobj, dv,
  siglaobj, num_obj: String;
begin
  if (trim(EdErro.Text) <> '0') then
    begin
      Application.MessageBox('Erro na Planilha, verificar','ADS',IDOK);
      BtnSalvar.Enabled   :=    false;
      BtnLeitura.Enabled  :=  true;
      EdErro.Text  :=  '0';
      exit;
    end;
  K:=3;
  x:=1;
  with dm do
    begin
{
      repeat
        try
          strtoint(trim(StrGridDados.Cells[1,k]));
          VirgPonto2(trim(StrGridDados.Cells[8,k]));
          strtoint(trim(StrGridDados.Cells[3,k]));
        except on e:exception do
          begin
            EdErro.Text := IntToStr(strtoint(EdErro.Text)+1);
            EdErro.Refresh;
{*
            StrGridErro.Cells[R1,K1]   :=  trim(StrGridDados.Cells[0,k]);
            StrGridErro.Cells[R1+1,K1] :=  trim(StrGridDados.Cells[1,k]);
            StrGridErro.Cells[R1+2,K1] :=  trim(StrGridDados.Cells[7,k]);
            StrGridErro.Cells[R1+3,K1] :=  trim(Ednumlote.Text);
            StrGridErro.RowCount := K1 + 1;
            StrGridErro.Refresh;
*
          end;
        end;
        Inc(k,1);
        Inc(x,1);
      until x > StrToInt(EdQtdreg.Text);

      if (strtoint(trim(EdErro.Text)) > 0) then
        begin
          application.MessageBox(PChar('Erro na Planilha, verificar!'),'Ads',MB_OK+MB_ICONERROR);
          BtnSalvar.Enabled  :=  false;
          BtnFechar.Enabled := true;
          exit;
        end;
}
      if NovoLoteChkBox.Checked then
          begin
            SqlAux1.Close;
            SqlAux1.SQL.Clear;
            SqlAux1.SQL.Add('SELECT MAX(cg77_numlote) + 1 as novo_lote FROM cga77');
            SqlAux1.Open;
            Ednumlote.Text :=  SqlAux1.FieldByName('novo_lote').AsString;
            Ednumlote.Refresh;
          end
      else
          begin
            Ednumlote.Enabled := true;
            Ednumlote.SetFocus;
          end;

      case strtoint64(trim(Ednumlote.Text)) of
        0:
          begin
            application.MessageBox(PChar('Digite o n° do Lote !'),'Ads',MB_OK+MB_ICONINFORMATION);
            Ednumlote.Enabled := true;
            Ednumlote.SetFocus;
          end;
        else
          begin
            agant := '';
            K := 3;
            x := 1;

            // Instruções SQL que serão executadas em LOOP
            seldup := 'SELECT COUNT(cg77_dtb) as qt_dtb ' + #13#10 +
                'FROM cga77 WHERE cg77_dtb = :dtb and cg77_ag = :ag ' + #13#10 +
                '  AND cg77_numlote = :numlote ' + #13#10 +
                '  AND cg77_tokini > :tokini ';

            insere := 'INSERT INTO cga77 (cg77_dtb, cg77_ag, cg77_qtd, ' + #13#10 +
                  'cg77_numlote, cg77_status, cg77_tokini, cg77_tokfin) ' + #13#10 +
                  'VALUES (:dtb, :ag, :qtd, :numlote, :status, :tokini, :tokfin)';

            sqldadosobj := 'SELECT DISTINCT t.tbsdxect_num, t.tbsdxect_dv, t.tbsdxect_sigla ' + #13#10 +
                        'FROM public.tbsdx_ect t ' + #13#10 +
                        'INNER JOIN (' + #13#10 +
                        'SELECT MIN(tsub.tbsdxect_num) as numobj, tsub.tbsdxect_prod ' + #13#10 +
                        'FROM public.tbsdx_ect tsub ' + #13#10 +
                        'WHERE tsub.tbsdxect_dtvenc > CURRENT_DATE ' + #13#10 +
                        ' AND tsub.tbsdx_use IS NULL ' + #13#10 +
                        'GROUP BY 2 ' + #13#10 +
                        ') t2 ON (t.tbsdxect_prod = t2.tbsdxect_prod) AND t.tbsdxect_num = t2.numobj ' + #13#10 +
                        'WHERE t.tbsdxect_prod = :prod ';

            insmov :='INSERT INTO tbsdx02 (sdx_codcli, sdx_idcli, sdx_siglaobj, ' +
                  'sdx_numobj, sdx_paisorigem, sdx_numobj4, sdx_nomdest, ' +
                  'sdx_endedest, sdx_cidade, sdx_uf, sdx_cep, sdx_numseqarq, ' +
                  'sdx_numseqreg, sdx_dtcarga, sdx_numobj2, sdx_numobj1, ' +
                  'sdx_codusu, sdx_valdec, sdx_seqcarga, sdx_qtprod, sdx_dtmov) ' +
                  'VALUES (99,''99'',:sigla, :numobj, ''BR'', :numobj4, :nomdest, ' +
                  ':enddest, :ciddest, :ufdest, :cepdest, 99, :numreg, ' +
                  'CURRENT_DATE, :numobj2, :numobj1, :codusu, :sdx_valdec, ' +
                  ':sdx_seqcarga, :qtprod, :sdx_dtmov)';


            repeat
              Begin
                if (trim(StrGridDados.Cells[1, K]) <> '') then
                  begin
                    SqlAux1.Close;
                    SqlAux1.SQL.Clear;
                    SqlAux1.SQL.Add(seldup);
                    SqlAux1.ParamByName('dtb').AsString := trim(StrGridDados.Cells[7,K]);
                    SqlAux1.ParamByName('ag').AsString := trim(StrGridDados.Cells[1,k]);
                    SqlAux1.ParamByName('numlote').AsString := gerant(trim(Ednumlote.Text), 6);
                    SqlAux1.ParamByName('tokini').AsString := '0';
                    SqlAux1.Open;
                    if (SqlAux1.FieldByName('qt_dtb').AsInteger = null) then
                      Begin
                        // Caso a consulta não seja executada corretamente, marca
                        // a linha para informar sobre os dados inconsistentes
                        EdErro.Text := IntToStr(strtoint(EdErro.Text)+1);
                        EdErro.Refresh;
                        Inc(K1,1);
                      End
                    Else
                      Begin
                        // Próximo número de objeto disponível
                        SqlAux3.Close;
                        SqlAux3.SQL.Clear;
                        SqlAux3.SQL.Add(sqldadosobj);
                        SqlAux3.ParamByName('prod').AsInteger  :=  CboProdutoServSedex.KeyValue;
                        SqlAux3.Open;
                        num_obj := SqlAux3.FieldByName('tbsdxect_num').AsString;
                        dv := SqlAux3.FieldByName('tbsdxect_dv').AsString;
                        siglaobj := SqlAux3.FieldByName('tbsdxect_sigla').AsString;

                        // Dados da Agência
                        SqlTbBradDeptos.Close;
                        SqlTbBradDeptos.SQL.Clear;
                        SqlTbBradDeptos.SQL.Add('SELECT * FROM tbbraddptos WHERE juncao = :juncao LIMIT 1');
                        SqlTbBradDeptos.ParamByName('juncao').AsString  :=  trim(StrGridDados.Cells[1,k]);
                        SqlTbBradDeptos.Open;

                        // Inserindo cadastro de vinculo de TOKEN à Agencia
                        SqlAux2.Close;
                        SqlAux2.SQL.Clear;
                        SqlAux2.SQL.Add(insere);
                        SqlAux2.ParamByName('dtb').AsString := num_obj + dv;
                        SqlAux2.ParamByName('ag').AsString := trim(StrGridDados.Cells[1,k]);
                        SqlAux2.ParamByName('qtd').AsInteger := strtoint(trim(StrGridDados.Cells[3,k]));
                        if  agant =  trim(StrGridDados.Cells[1,k]) then
                          begin
                            novolote  :=  IntToStr(StrToInt(Ednumlote.Text)+1);
                            SqlAux2.ParamByName('numlote').AsString := GeraNt(novolote,6);
                            Lbl001.Caption  :=  Lbl001.Caption + novolote + ' - ' + trim(StrGridDados.Cells[1,k] )+ ' - ';
                          end
                        else
                          SqlAux2.ParamByName('numlote').AsString := gerant(trim(Ednumlote.Text),6);

                        agant :=  trim(StrGridDados.Cells[1,k]);
                        SqlAux2.ParamByName('status').AsString := '0';
                        SqlAux2.ParamByName('tokini').AsString := '0';
                        SqlAux2.ParamByName('tokfin').AsString := '0';
                        try
                          SqlAux2.ExecSQL;
                          EdGrava.Text := inttostr(strtoint(EdGrava.Text)+1);
                          EdGrava.Refresh;
                          SqlAux1.Close;
                          SqlAux1.SQL.Clear;
                          SqlAux1.SQL.Add('UPDATE tbsdx_ect SET tbsdx_use = :use '+
                            'WHERE tbsdxect_num = :numobj AND tbsdxect_prod = :prod');
                          SqlAux1.ParamByName('use').AsString := 'S';
                          SqlAux1.ParamByName('numobj').AsString := num_obj;
                          SqlAux1.ParamByName('prod').AsInteger := CboProdutoServSedex.KeyValue;
                          SqlAux1.ExecSQL;

                          SqlAux1.Close;
                          SqlAux1.SQL.Clear;
                          SqlAux1.SQL.Add(insmov);
                          SqlAux1.ParamByName('sigla').AsString := SqlSdxServtbsdxserv_sigla.AsString;
                          SqlAux1.ParamByName('numobj').AsInteger := StrToInt(num_obj + dv);
                          SqlAux1.ParamByName('numobj4').AsString := 'AR'+ num_obj + dv + SqlSdxServtbsdxserv_sigla.AsString;
                          if (SqlTbBradDeptos.RecordCount = 0) then
                            SqlAux1.ParamByName('nomdest').AsString  :=  gerant(trim(StrGridDados.Cells[1,k]),4)
                          else
                            SqlAux1.ParamByName('nomdest').AsString :=  gerant(SqlTbBradDeptosjuncao.AsString,4) + ': ' + SqlTbBradDeptosdepto.AsString;

                          SqlAux1.ParamByName('enddest').AsString := SqlTbBradDeptosender.AsString;
                          SqlAux1.ParamByName('ciddest').AsString := SqlTbBradDeptoscidade.Text;
                          SqlAux1.ParamByName('ufdest').AsString := SqlTbBradDeptosuf.Text;
                          SqlAux1.ParamByName('cepdest').AsString := copy(SqlTbBradDeptoscep.Text,1,5)+copy(SqlTbBradDeptoscep.Text,7,3);
                          SqlAux1.ParamByName('numreg').AsString := gerant(inttostr(random(999)),3)+FormatDateTime('yyyymmdd',date)+FormatDateTime('hhmmss',Time)+GeraNT(sqlcga_acessocodigo.AsString,4)+gerant(inttostr(random(999)),3);
                          SqlAux1.ParamByName('numobj2').AsString := siglaobj + num_obj + dv + 'BR';
                          SqlAux1.ParamByName('numobj1').AsString := 'AR'+ num_obj + dv + SqlSdxServtbsdxserv_sigla.AsString;
                          SqlAux1.ParamByName('codusu').AsString := sqlcga_acessocodigo.AsString;
                          SqlAux1.ParamByName('sdx_valdec').AsFloat := Moeda2Float(trim(StrGridDados.Cells[8,k]));
                          SqlAux1.ParamByName('sdx_seqcarga').AsString := trim(Ednumlote.Text);
                          SqlAux1.ParamByName('qtprod').AsInteger :=  strtoint(trim(StrGridDados.Cells[3,k]));
                          SqlAux1.ParamByName('sdx_dtmov').AsString := FormatDateTime('yyyy-mm-dd', StrToDate(StrGridDados.Cells[4,k]));

                          SqlAux1.ExecSQL;
                        except on e: exception do
                          begin
                            application.MessageBox(PChar('Existem dados ' +
                              'incorretos na linha ' + IntToStr(K) +
                              ' da planilha. Verifique se a data ' +
                              'está no formato DD/MM/YYYY. Detalhes do erro: ' + e.Message), 'ADS', MB_OK+MB_ICONERROR);
                            EdErro.Text := IntToStr(strtoint(EdErro.Text)+1);
                            ShowMessage('O Processo foi abortado');
                            exit;
                          end;
                      end;

                    Inc(K,1);
                    Inc(x,1);
                    StrGridDados.RowCount := K + 1;
                    StrGridDados.Refresh;
                  end;
                end
              else
                Inc(K,1);
            end;
          until
            x > StrToInt(EdQtdreg.Text);

          if (strtoint(trim(EdErro.Text)) > 0) then
            application.MessageBox(PChar('Registros com erros Verificar!'),'Ads',MB_OK+MB_ICONERROR)
          else
            application.MessageBox(PChar('Registros Gravados com Sucesso!'),'Ads',MB_OK+MB_ICONERROR);

          BtnSalvar.Enabled  :=  false;
          BtnFechar.Enabled := true;
        end;
      end;
    end;
end;

procedure TFrmPreCadToken.BtnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFrmPreCadToken.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with dm do
    begin
    SqlAux1.Close;
    SqlAux2.Close
    end;
  action := cafree;
end;

//********** Inicio Grava OL
procedure TFrmPreCadToken.gravaol;
begin
  K:=1;
  x:=1;

  with dm do
    begin
      if NovoLoteChkBox.Checked then
        begin
          Ednumlote.Text := IntToStr(Random(99)) + gerant(formatdatetime('hhmm',Time),4);
          Ednumlote.Refresh;
        end
      else
        begin
          Ednumlote.Enabled := true;
          Ednumlote.SetFocus;
        end;

      case strtoint64(trim(Ednumlote.Text)) of
      0:
        begin
          application.MessageBox(PChar('Digite o n° do Lote !'),'Ads',MB_OK+MB_ICONINFORMATION);
          Ednumlote.Enabled := true;
          Ednumlote.SetFocus;
        end;
      else
        begin
          agant :=  '';
          repeat
            Begin
              SqlAux3.Close;
              SqlAux3.SQL.Clear;
              SqlAux3.SQL.Add('select min(tbsdxect_num), tbsdxect_dv from tbsdx_ect where (tbsdxect_prod = ''1660'') and (tbsdx_use is null) group by tbsdxect_num,tbsdxect_dv order by tbsdxect_num limit 1');
              SqlAux3.Open;
              numobj:= SqlAux3.Fields[0].AsString + SqlAux3.Fields[1].AsString;
              SqlTbBradDeptos.Close;
              SqlTbBradDeptos.SQL.Clear;
              SqlTbBradDeptos.SQL.Add('select * from tbbraddptos where (juncao = :juncao) limit 1');
              SqlTbBradDeptos.Params[0].AsString  :=  trim(StrGridDados.Cells[1,k]);
              SqlTbBradDeptos.Open;
              if  (agant = trim(StrGridDados.Cells[1, k])) and (k > 1) then
                begin
                  novolote  :=  IntToStr(StrToInt(Ednumlote.Text)+1);
                  Lbl001.Caption  :=  Lbl001.Caption + novolote + ' - ' +
                      trim(StrGridDados.Cells[1, k]) + ' - ';
                end;

              agant :=  trim(StrGridDados.Cells[1,k]);
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
              //                  10      11       12          13           14        15
              SqlAux1.SQL.Add(':numobj1,:codusu,:sdx_valdec,:sdx_seqcarga,:qtprod,:sdx_dtmov)');
              SqlAux1.Params[00].AsString  :=  'OL';//
              SqlAux1.Params[01].AsString  :=  numobj;
              SqlAux1.Params[02].AsString  :=  'AR'+ numobj + 'OL';//
              if (SqlTbBradDeptos.RecordCount = 0) then
                SqlAux1.Params[03].AsString  :=  gerant(trim(StrGridDados.Cells[1,k]),4)
              else
                SqlAux1.Params[03].AsString  :=  gerant(SqlTbBradDeptosjuncao.AsString,4)+': '+SqlTbBradDeptosdepto.AsString;
              SqlAux1.Params[04].AsString  :=  SqlTbBradDeptosender.AsString;
              SqlAux1.Params[05].AsString  :=  SqlTbBradDeptoscidade.Text;
              SqlAux1.Params[06].AsString  :=  SqlTbBradDeptosuf.Text;
              SqlAux1.Params[07].AsString  :=  copy(SqlTbBradDeptoscep.Text,1,5)+copy(SqlTbBradDeptoscep.Text,7,3);
              SqlAux1.Params[08].AsString  :=  gerant(inttostr(random(999)),3)+FormatDateTime('yyyymmdd',date)+FormatDateTime('hhmmss',Time)+GeraNT(sqlcga_acessocodigo.AsString,4)+gerant(inttostr(random(999)),3);
              SqlAux1.Params[09].AsString  :=  'DG'+ numobj + 'BR';
              SqlAux1.Params[10].AsString  :=  'AR'+ numobj + 'OL';//
              SqlAux1.Params[11].AsString  :=  sqlcga_acessocodigo.AsString;
              SqlAux1.Params[12].AsString  :=  VirgPonto2(trim(StrGridDados.Cells[8,k]));
              SqlAux1.Params[13].AsString  :=  trim(Ednumlote.Text);
              SqlAux1.Params[14].Value     :=  strtoint(trim(StrGridDados.Cells[3,k]));
              SqlAux1.Params[15].Text      :=  ''''+copy(StrGridDados.Cells[4,k],4,3)+copy(StrGridDados.Cells[4,k],1,3)+copy(StrGridDados.Cells[4,k],7,4)+'''';
              try
                SqlAux1.ExecSQL;
                EdGrava.Text := inttostr(strtoint(EdGrava.Text)+1);
                EdGrava.Refresh;
                SqlAux1.Close;
                SqlAux1.SQL.Clear;
                SqlAux1.SQL.Add('update tbsdx_ect set tbsdx_use = ''S'' where (tbsdxect_num = :num)');
                SqlAux1.Params[0].AsString  :=  SqlAux3.Fields[0].AsString;
                SqlAux1.ExecSQL;
                SqlAux1.Close;
              except on e: exception do
                begin
                  application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message+chr(10)+'Nro Objeto: '+numobj),'Ads',MB_OK+MB_ICONERROR);
                  EdErro.Text := IntToStr(strtoint(EdErro.Text)+1);
                  EdErro.Refresh;
{*
                  StrGridErro.Cells[R1,K1]   :=  trim(StrGridDados.Cells[0,k]);
                  StrGridErro.Cells[R1+1,K1] :=  trim(StrGridDados.Cells[1,k]);
                  StrGridErro.Cells[R1+2,K1] :=  trim(StrGridDados.Cells[4,k]);
                  StrGridErro.Cells[R1+3,K1] :=  trim(Ednumlote.Text);
                  StrGridErro.RowCount := (K1 + 1);
                  StrGridErro.Refresh;
*}                  
                  Inc(K1,1);
                end;
              end;
              Inc(K,1);
              Inc(x,1);
              StrGridDados.RowCount := K + 1;
              StrGridDados.Refresh;
            end;
          until
          x > StrToInt(EdQtdreg.Text);
          if (strtoint(trim(EdErro.Text)) > 0) then
            application.MessageBox(PChar('Registros com erros Verificar!'),'Ads',MB_OK+MB_ICONERROR)
          else
            application.MessageBox(PChar('Registros Gravados com Sucesso!'),'Ads',MB_OK+MB_ICONERROR);
          BtnSalvar.Enabled  :=  false;
          BtnFechar.Enabled := true;
        end;
      end;
    end;
end;

//********** Fim Grava OL


//********** Inicio Grava OL
procedure TFrmPreCadToken.gravaol2;
var siglaobj, num_obj, siglaprod,
  dv, sqldadosobj, insmov: String;
  i, j, iTmp: Integer;
begin
  PanelProgressBar.Max := StrGridDados.RowCount - 1;
  nLotes := TStringList.Create;
  nLotes.Add(trim(Ednumlote.Text));

  // SQL Base para buscar o próximo número de objeto livre
  sqldadosobj := 'SELECT DISTINCT t.tbsdxect_num, t.tbsdxect_dv, ' + #13#10 +
        't.tbsdxect_sigla, s.tbsdxserv_sigla ' + #13#10 +
        'FROM public.tbsdx_ect t ' + #13#10 +
        '  INNER JOIN (SELECT MIN(tsub.tbsdxect_num) as numobj, ' + #13#10 +
        '                 tsub.tbsdxect_prod ' + #13#10 +
        '              FROM public.tbsdx_ect tsub ' + #13#10 +
        '              WHERE tsub.tbsdxect_dtvenc > CURRENT_DATE AND ' + #13#10 +
        '                 tsub.tbsdx_use IS NULL ' + #13#10 +
        '              GROUP BY 2 ' + #13#10 +
        '             ) t2 ON (t.tbsdxect_prod = t2.tbsdxect_prod) ' + #13#10 +
        '                  AND t.tbsdxect_num = t2.numobj ' + #13#10 +
        '  INNER JOIN tbsdxserv s ON t2.tbsdxect_prod = s.tbsdxserv_prod ' + #13#10 +
        'WHERE t.tbsdxect_prod = :prod ';
  // SQL Base para inserir um objeto de envio
  insmov := 'INSERT INTO tbsdx02 (sdx_codcli, sdx_idcli, sdx_siglaobj, ' + #13#10 +
            '    sdx_numobj, sdx_paisorigem, sdx_numobj4, sdx_nomdest, ' + #13#10 +
            '    sdx_endedest, sdx_cidade, sdx_uf, sdx_cep, sdx_numseqarq, ' + #13#10 +
            '    sdx_numseqreg, sdx_dtcarga, sdx_numobj2, sdx_numobj1, ' + #13#10 +
            '    sdx_codusu, sdx_valdec, sdx_seqcarga, sdx_qtprod, sdx_dtmov, ' + #13#10 +
            '    sdx_juncaopagante) ' + #13#10 +
            'VALUES (99,''99'',:sigla, :numobj, ''BR'', :numobj4, :nomdest, ' + #13#10 +
            '    :enddest, :ciddest, :ufdest, :cepdest, 99, :numreg, ' + #13#10 +
            '    CURRENT_DATE, :numobj2, :numobj1, :codusu, :sdx_valdec, ' + #13#10 +
            '    :sdx_seqcarga, :qtprod, :sdx_dtmov, :sdx_juncaopagante)';
  With Dm do
    Begin
      SqlAux3.Close;
      SqlAux2.Close;
      SqlAux1.Close;
      SqlTbBradDeptos.Close;

      // Iniciando uma transação
      SqlAux3.SQL.Text := 'START TRANSACTION';
      SqlAux3.ExecSQL;

      SqlTbBradDeptos.SQL.Clear;
      SqlTbBradDeptos.SQL.Add('SELECT * FROM tbbraddptos WHERE juncao = :juncao');

      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add(insmov);

      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('UPDATE tbsdx_ect SET tbsdx_use = :use ' +
          'WHERE tbsdxect_num = :numobj AND tbsdxect_prod = :prod');


      SqlAux3.SQL.Clear;
      SqlAux3.SQL.Add(sqldadosobj);

      for i := 0 to StrGridDados.RowCount - 1 do
        begin
          if StrGridDados.Cells[0, i] <> 'UF' then // Escapando o cabeçalho
            begin
              // Buscando os dados do destino
              if not TryStrToInt(StrGridDados.Cells[1, i], iTmp) then
                begin
                  Application.MessageBox(PChar('Código de Agência ' +
                      StrGridDados.Cells[1, i] + ', presente na linha ' +
                      IntToStr(i + 1) + ', é inválido! '),
                    'ADS', MB_OK + MB_ICONERROR);
                  exit;
                end;

              SqlTbBradDeptos.Params[0].AsInteger := iTmp;
              SqlTbBradDeptos.ExecSQL;
              SqlTbBradDeptos.Open;
              if (SqlTbBradDeptos.RecordCount < 1) then
                begin
                  application.MessageBox(PChar('A agência ' +
                      StrGridDados.Cells[1, i] + ', presente na linha ' +
                      IntToStr(i + 1) + ', não foi encontrada no cadastro. ' + #13#10 +
                      'Necessário verificar!'),
                    'ADS', MB_OK + MB_ICONERROR);
                  exit;
                end;

              // Inserindo a entrada
              // A Coluna VOLUME[s] indica quantos números de objetos
              // precisam ser vinculados para a agência em questão
              // Caso a quantidade de itens seja maior que 1 é necessário
              // perguntar ao operador se o valor encontrado é o mesmo para todos
              // os volumes
              if (StrToInt(StrGridDados.Cells[5, i]) > 1) and
                  (StrToInt(StrGridDados.Cells[3, i]) > 1) then
                begin
                  if (MessageDlg('Encontrado envio de múltiplos objetos para ' +
                        'uma mesma agência, porém com ' + StrGridDados.Cells[3, i] +
                        ' de quantidade. Atribuir esta quantidade para cada '+
                        'um dos volumes?', mtCustom, [mbYes,mbNo], 0) = mrNo) then
                    begin
                      ShowMessage('O Processo será interrompido.' + #13#10 +
                         'Revise as informações antes de tentar carregar ' +
                          'novamente os dados');
                      exit;
                    end;
                end;

              // fazendo o loop
              for j := 1 to StrToInt(StrGridDados.Cells[5, i]) do
                begin
                  // Pegando dados do número de objeto
                  SqlAux3.ParamByName('prod').AsInteger := StrToInt(StrGridDados.Cells[10, i]);
                  SqlAux3.ExecSQL;
                  SqlAux3.Open;
                  if SqlAux3.RecordCount > 0 then
                    begin
                      num_obj := SqlAux3.Fields[0].AsString;
                      dv := SqlAux3.Fields[1].AsString;
                      siglaobj := SqlAux3.Fields[2].AsString;
                      siglaprod := SqlAux3.Fields[3].AsString;
                      // Inserindo o envio
                      SqlAux1.ParamByName('sigla').AsString := SqlSdxServtbsdxserv_sigla.AsString;
                      SqlAux1.ParamByName('numobj').AsInteger := StrToInt(num_obj + dv);
                      SqlAux1.ParamByName('numobj4').AsString := 'AR' + num_obj + dv + siglaprod;
                      SqlAux1.ParamByName('nomdest').AsString := gerant(SqlTbBradDeptosjuncao.AsString, 4) + ': ' + SqlTbBradDeptosdepto.AsString;
                      SqlAux1.ParamByName('enddest').AsString := SqlTbBradDeptosender.AsString;
                      SqlAux1.ParamByName('ciddest').AsString := SqlTbBradDeptoscidade.Text;
                      SqlAux1.ParamByName('ufdest').AsString := SqlTbBradDeptosuf.Text;
                      SqlAux1.ParamByName('cepdest').AsString := copy(SqlTbBradDeptoscep.Text, 1, 5) + copy(SqlTbBradDeptoscep.Text, 7, 3);
                      SqlAux1.ParamByName('numreg').AsString := GeraNt(inttostr(random(999)), 3) + FormatDateTime('yyyymmdd', date) + FormatDateTime('hhmmss', Time) + GeraNT(sqlcga_acessocodigo.AsString, 4) + GeraNt(inttostr(random(999)), 3);
                      SqlAux1.ParamByName('numobj2').AsString := siglaobj + num_obj + dv + 'BR';
                      SqlAux1.ParamByName('numobj1').AsString := 'AR' + num_obj + dv + siglaprod;
                      SqlAux1.ParamByName('codusu').AsString := sqlcga_acessocodigo.AsString;
                      SqlAux1.ParamByName('sdx_valdec').AsFloat := Moeda2Float(trim(StrGridDados.Cells[8, i]));
                      SqlAux1.ParamByName('sdx_seqcarga').AsString := nLote;
                      SqlAux1.ParamByName('qtprod').AsInteger := strtoint(trim(StrGridDados.Cells[3, i]));
                      SqlAux1.ParamByName('sdx_dtmov').AsString := FormatDateTime('yyyy-mm-dd', StrToDate(StrGridDados.Cells[4, i]));
                      SqlAux1.ParamByName('sdx_juncaopagante').AsString := StrGridDados.Cells[9, i];
                      try
                        SqlAux1.ExecSQL;
                        EdGrava.Text := IntToStr(i);
                        EdGrava.Refresh;
                        ProgressBarStepItOne;

                        SqlAux2.ParamByName('use').AsString := 'S';
                        SqlAux2.ParamByName('numobj').AsString := num_obj;
                        SqlAux2.ParamByName('prod').AsInteger := StrToInt(StrGridDados.Cells[10, i]);
                        SqlAux2.ExecSQL;
                        if (SqlAux2.RowsAffected < 1) then
                            raise Exception.Create('Numero de objeto ' + num_obj + ' não pode ser marcado como utilizado.');

                      except on e: Exception do
                        begin
                          application.MessageBox(PChar('Ocorreu um erro fatal ao tentar ' +
                                'vincular um numero de objeto para o item da linha ' +
                                IntToStr(i) + '. ' + #13#10 + 'Detalhes: ' + e.Message +
                                #13#10 + 'Nro Objeto: ' + num_obj + dv),
                            'Ads', MB_OK + MB_ICONERROR);
                          SqlAux1.SQL.Text := 'ROLLBACK';
                          SqlAux1.ExecSQL;
                          EdGrava.Text := '0';
                          exit;
                        end;
                      end;
                    end
                  else
                    begin
                      application.MessageBox(PChar('O Cartão de Postagem do pagante ' +
                            StrGridDados.Cells[10, i] + ', presente na linha ' +
                            IntToStr(i) + ', não possui números de objetos livres. ' + #13#10 +
                            'Requisite novos objetos!'),
                          'ADS', MB_OK + MB_ICONERROR);
                    exit;


                    end;
                end;
          end;
        end;
      // Finalizando a transação
      SqlAux3.SQL.Text := 'COMMIT';
      SqlAux3.ExecSQL;

      SqlAux1.Close;
      SqlAux2.Close;
      SqlAux3.Close;
    end;
end;

//********** Fim Grava OL

procedure TFrmPreCadToken.gravatc;
var siglaobj, dv, dbg, sqldadosobj: String;
begin
  K:=1;
  x:=1;

  Ednumlote.Text   :=  IntToStr(Random(99))+gerant(formatdatetime('hhmm',Time),4);
  Ednumlote.Refresh;

  with dm do
    begin
      if NovoLoteChkBox.Checked then
        begin
          Ednumlote.Text := IntToStr(Random(99)) + gerant(formatdatetime('hhmm',Time),4);
          Ednumlote.Refresh;
        end
      else
        begin
          Ednumlote.Enabled := true;
          Ednumlote.SetFocus;
        end;

      case strtoint64(trim(Ednumlote.Text)) of
      0:
        begin
          application.MessageBox(PChar('Digite o n° do Lote !'),'Ads',MB_OK+MB_ICONINFORMATION);
          Ednumlote.Enabled := true;
          Ednumlote.SetFocus;
        end;
      else
        begin
          agant :=  '';

          sqldadosobj := 'SELECT DISTINCT t.tbsdxect_num, t.tbsdxect_dv, t.tbsdxect_sigla ' +
                        'FROM public.tbsdx_ect t ' +
                        'INNER JOIN (' +
                        'SELECT MIN(tsub.tbsdxect_num) as numobj, tsub.tbsdxect_prod ' +
                        'FROM public.tbsdx_ect tsub ' +
                        'WHERE tsub.tbsdxect_dtvenc > CURRENT_DATE ' +
                        ' AND tsub.tbsdx_use IS NULL ' +
                        'GROUP BY 2 ' +
                        ') t2 ON (t.tbsdxect_prod = t2.tbsdxect_prod) AND t.tbsdxect_num = t2.numobj ' +
                        'WHERE t.tbsdxect_prod = :prod ';
          repeat
            Begin
              // Pegando dados do número de objeto
              SqlAux3.Close;
              SqlAux3.SQL.Clear;
              SqlAux3.SQL.Add(sqldadosobj);
              SqlAux3.ParamByName('prod').AsInteger  :=  CboProdutoServSedex.KeyValue;
              SqlAux3.Open;
              numobj := SqlAux3.Fields[0].AsString;
              dv := SqlAux3.Fields[1].AsString;
              siglaobj:= SqlAux3.Fields[2].AsString;


              SqlTbBradDeptos.Close;
              SqlTbBradDeptos.SQL.Clear;
              SqlTbBradDeptos.SQL.Add('select * from tbbraddptos where (juncao = :juncao) limit 1');
              SqlTbBradDeptos.Params[0].AsString  :=  trim(StrGridDados.Cells[1,k]);
              SqlTbBradDeptos.Open;
              if  (agant =  trim(StrGridDados.Cells[1,k])) and (k>=2)  then
                begin
                  novolote  :=  IntToStr(StrToInt(Ednumlote.Text)+1);
                  Lbl001.Caption  :=  Lbl001.Caption+novolote+ ' - '+trim(StrGridDados.Cells[1,k])+ ' - ';
                end;
              agant :=  trim(StrGridDados.Cells[1,k]);
              SqlAux1.SQL.Clear;
              SqlAux1.SQL.Add('insert into tbsdx02 ');
              SqlAux1.SQL.Add('(sdx_codcli,sdx_idcli,sdx_siglaobj,sdx_numobj,sdx_paisorigem,');
              SqlAux1.SQL.Add('sdx_numobj4,sdx_nomdest,sdx_endedest,sdx_cidade,sdx_uf,');
              SqlAux1.SQL.Add('sdx_cep,sdx_numseqarq,sdx_numseqreg,sdx_dtcarga,sdx_numobj2,');
              SqlAux1.SQL.Add('sdx_numobj1,sdx_codusu,sdx_valdec,sdx_seqcarga,sdx_qtprod,sdx_dtmov) ');
              SqlAux1.SQL.Add('values (');
              //                              0     1
              SqlAux1.SQL.Add('99,''99'',:siglaobj,:numobj,''BR'',');
              //                  2       3         4         5       6
              SqlAux1.SQL.Add(':numobj4,:nomdest,:enddest,:ciddest,:ufdest,');
              //                  7            8                            9
              SqlAux1.SQL.Add(':cepdest,99,:numreg, CURRENT_DATE,:numobj2,');
              //                  10      11       12          13           14        15
              SqlAux1.SQL.Add(':numobj1,:codusu,:sdx_valdec,:sdx_seqcarga,:qtprod,:sdx_dtmov)');
              SqlAux1.ParamByName('siglaobj').AsString := SqlSdxServtbsdxserv_sigla.AsString;
              SqlAux1.ParamByName('numobj').AsString  :=  numobj + dv;
              SqlAux1.ParamByName('numobj4').AsString  :=  'AR'+ numobj + dv + SqlSdxServtbsdxserv_sigla.AsString;
              if (SqlTbBradDeptos.RecordCount = 0) then
                SqlAux1.Params[03].AsString  :=  gerant(trim(StrGridDados.Cells[1,k]),4)
              else
                SqlAux1.Params[03].AsString  :=  gerant(SqlTbBradDeptosjuncao.AsString,4)+': '+SqlTbBradDeptosdepto.AsString;
              SqlAux1.Params[04].AsString  :=  SqlTbBradDeptosender.AsString;
              SqlAux1.Params[05].AsString  :=  SqlTbBradDeptoscidade.Text;
              SqlAux1.Params[06].AsString  :=  SqlTbBradDeptosuf.Text;
              SqlAux1.Params[07].AsString  :=  copy(SqlTbBradDeptoscep.Text,1,5)+copy(SqlTbBradDeptoscep.Text,7,3);
              SqlAux1.Params[08].AsString  :=  gerant(inttostr(random(999)),3)+FormatDateTime('yyyymmdd',date)+FormatDateTime('hhmmss',Time)+GeraNT(sqlcga_acessocodigo.AsString,4)+gerant(inttostr(random(999)),3);
              SqlAux1.ParamByName('numobj2').AsString  :=  siglaobj + numobj + dv + 'BR';
              dbg := siglaobj + numobj + dv + 'BR';
              SqlAux1.ParamByName('numobj1').AsString :=  'AR'+ numobj + dv + SqlSdxServtbsdxserv_sigla.AsString;
              SqlAux1.Params[11].AsString  :=  sqlcga_acessocodigo.AsString;
              SqlAux1.Params[12].AsString  :=  VirgPonto2(trim(StrGridDados.Cells[8,k]));
              SqlAux1.Params[13].AsString  :=  trim(Ednumlote.Text);
              SqlAux1.Params[14].Value     :=  strtoint(trim(StrGridDados.Cells[3,k]));
              SqlAux1.ParamByName('sdx_dtmov').AsString := FormatDateTime('yyyy-mm-dd', StrToDate(StrGridDados.Cells[4,k]));
              dbg := SqlAux1.SQL.Text;
              try
                SqlAux1.ExecSQL;
                EdGrava.Text := inttostr(strtoint(EdGrava.Text)+1);
                EdGrava.Refresh;
                SqlAux1.Close;
                SqlAux1.SQL.Clear;
                SqlAux1.SQL.Add('UPDATE tbsdx_ect SET tbsdx_use = ''S'' ' +
                  'WHERE tbsdxect_num = :numobj AND tbsdxect_sigla = :siglaobj');
                SqlAux1.ParamByName('numobj').AsString := numobj;
                SqlAux1.ParamByName('siglaobj').AsString := siglaobj;
                SqlAux1.ExecSQL;
                SqlAux1.Close;
              except on e: exception do
                begin
                  application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message+chr(10)+'Nro Objeto: '+numobj),'Ads',MB_OK+MB_ICONERROR);
                  EdErro.Text := IntToStr(strtoint(EdErro.Text)+1);
                  EdErro.Refresh;
{*
                  StrGridErro.Cells[R1,K1]   :=  trim(StrGridDados.Cells[0,k]);
                  StrGridErro.Cells[R1+1,K1] :=  trim(StrGridDados.Cells[1,k]);
                  StrGridErro.Cells[R1+2,K1] :=  trim(StrGridDados.Cells[4,k]);
                  StrGridErro.Cells[R1+3,K1] :=  trim(Ednumlote.Text);
                  StrGridErro.RowCount := (K1 + 1);
                  StrGridErro.Refresh;
*}                  
                  Inc(K1,1);
//                  SqlAux1.CancelUpdates; // Rollback???
                  exit;
                end;
              end;
              Inc(K,1);
              Inc(x,1);
              StrGridDados.RowCount := K + 1;
              StrGridDados.Refresh;
            end;
          until
          x > StrToInt(EdQtdreg.Text);
          if (strtoint(trim(EdErro.Text)) > 0) then
            application.MessageBox(PChar('Registros com erros Verificar!'),'Ads',MB_OK+MB_ICONERROR)
          else
            application.MessageBox(PChar('Registros Gravados com Sucesso!'),'Ads',MB_OK+MB_ICONERROR);
          BtnSalvar.Enabled  :=  false;
          BtnFechar.Enabled := true;
        end;
      end;
    end;
end;

procedure TFrmPreCadToken.crgtk;
begin
  EdErro.Text   :=  '0';
  EdQtdreg.Text :=  '0';
  EdGrava.Text :=  '0';
  with Dm do
    begin
      if EdLocal.Text = '' then
        begin
          Application.MessageBox('Escolha O Arquivo','ADS',IDOK);
          exit;
        end
      else
        begin
          AssignFile(arq,EdLocal.Text);
          reset(arq);
          Readln(arq,lin);
          while not(Eof(arq)) do
            begin
              EdQtdreg.Text :=  IntToStr(StrToInt(EdQtdreg.Text)+1);
              EdQtdreg.Refresh;
              SqlAux1.Close;
              SqlAux1.SQL.Clear;
              SqlAux1.SQL.Add('insert into cga76 values (:remes) ');//values ('''+lin+''')');
              SqlAux1.Params[0].AsString  :=  IntToStr(StrToInt64(trim(lin)));
              try
                SqlAux1.ExecSQL;
                EdGrava.Text  :=  IntToStr(StrToInt(EdGrava.Text)+1);
              except on e:exception do
                begin
                  EdErro.Text :=  IntToStr(StrToInt(EdErro.Text)+1);
                  EdErro.Refresh;
{*
                  StrGridErro.Cells[R1,K1]   :=  trim(lin);
                  StrGridErro.Cells[R1+1,K1]   :=  e.Message;
                  StrGridErro.Refresh;
                  StrGridErro.RowCount := K1 + 1;
*}                  
                  Inc(k1,1);
                end;
              end;
              Readln(arq,lin);
            end;
          Application.MessageBox('Fim de Leitura','ADS',IDOK);
        end;
    end;
end;


procedure TFrmPreCadToken.gravatb;
var i:Integer;
begin
  K:=1;
  x:=1;
  with dm do
    begin
      if NovoLoteChkBox.Checked then
        begin
          Ednumlote.Text   :=  IntToStr(Random(99)) + gerant(formatdatetime('hhmm', Time), 4);
          Ednumlote.Refresh;
        end
      else
         begin
           Ednumlote.Enabled := true;
           Ednumlote.SetFocus;
         end;

      case strtoint64(trim(Ednumlote.Text)) of
      0:
        begin
          application.MessageBox(PChar('Digite o n° do Lote !'),'Ads',MB_OK+MB_ICONINFORMATION);
          Ednumlote.Enabled := true;
          Ednumlote.SetFocus;
        end;
      else
        begin
          agant :=  '';
          repeat
            begin
              SqlAux3.Close;
              SqlAux3.SQL.Clear;
              SqlAux3.SQL.Add('select min(tbsdxect_num),tbsdxect_dv from tbsdx_ect where (tbsdxect_prod = ''1953'') and (tbsdx_use is null) group by tbsdxect_num,tbsdxect_dv order by tbsdxect_num limit 1');
              SqlAux3.Open;
              numobj:= SqlAux3.Fields[0].AsString+SqlAux3.Fields[1].AsString;
              if  (agant =  trim(StrGridDados.Cells[0,k])) and (k>=2)  then
                begin
                  novolote  :=  IntToStr(StrToInt(Ednumlote.Text)+1);
                  agant :=  trim(StrGridDados.Cells[0,k]);
                end
              else
                agant :=  trim(StrGridDados.Cells[0,k]);
                v_soma := 0;
                mcep  :=  copy(StrGridDados.Cells[5,k],1,5)+copy(StrGridDados.Cells[5,k],7,3);
                for i:= 1 to 8 do
                  v_soma := v_soma + strtoint(copy(mcep,i,1));
                v_soma := strtoint(copy(intTostr(v_soma),length(inttostr(v_soma)),1));
                if v_soma = 0 then
                  cepr := mcep + '0'
                else
                  begin
                    v_soma := 10 - v_soma;
                    cepr := '/'+mcep + intToStr(v_soma)+'\';
                  end;
                SqlAux1.SQL.Clear;
                SqlAux1.SQL.Add('insert into tbsdx02 ');
                SqlAux1.SQL.Add('(sdx_codcli,sdx_idcli,sdx_siglaobj,sdx_numobj,sdx_paisorigem,');
                SqlAux1.SQL.Add('sdx_numobj4,sdx_nomdest,sdx_endedest,sdx_cidade,sdx_uf,');
                SqlAux1.SQL.Add('sdx_cep,sdx_numseqarq,sdx_numseqreg,sdx_dtcarga,sdx_numobj2,');
                SqlAux1.SQL.Add('sdx_numobj1,sdx_codusu,sdx_seqcarga,sdx_peso,sdx_dtmov) ');
                SqlAux1.SQL.Add('values (');
                //                              0     1
                SqlAux1.SQL.Add('99,''99'',:sigla,:numobj,''BR'',');
                //                  2       3         4         5       6
                SqlAux1.SQL.Add(':numobj4,:nomdest,:enddest,:ciddest,:ufdest,');
                //                  7            8                            9
                SqlAux1.SQL.Add(':cepdest,99,:numreg,(select current_date),:numobj2,');
                //                  10      11       12          13
                SqlAux1.SQL.Add(':numobj1,:codusu,:sdx_seqcarga,:sdx_peso,(select current_date))');
                SqlAux1.Params[00].AsString  :=  'KB';//
                SqlAux1.Params[01].AsString  :=  numobj;
                SqlAux1.Params[02].AsString  :=  'AR'+ numobj + 'KB';//
                SqlAux1.Params[03].AsString  :=  trim(StrGridDados.Cells[0,k]);
                SqlAux1.Params[04].AsString  :=  trim(StrGridDados.Cells[1,k]);
                SqlAux1.Params[05].AsString  :=  trim(StrGridDados.Cells[3,k]);
                SqlAux1.Params[06].AsString  :=  trim(StrGridDados.Cells[4,k]);
                SqlAux1.Params[07].AsString  :=  copy(StrGridDados.Cells[5,k],1,5)+copy(StrGridDados.Cells[5,k],7,3);
                SqlAux1.Params[08].AsString  :=  gerant(inttostr(random(999)),3)+FormatDateTime('yyyymmdd',date)+FormatDateTime('hhmmss',Time)+GeraNT(sqlcga_acessocodigo.AsString,4)+gerant(inttostr(random(999)),3);
                SqlAux1.Params[09].AsString  :=  'SL'+ numobj + 'BR';
                SqlAux1.Params[10].AsString  :=  'AR'+ numobj + 'KB';//
                SqlAux1.Params[11].AsString  :=  sqlcga_acessocodigo.AsString;
                SqlAux1.Params[12].AsString  :=  trim(Ednumlote.Text);
                SqlAux1.Params[13].AsString  :=  '0.010';
              try
                SqlAux1.ExecSQL;
                EdGrava.Text := inttostr(strtoint(EdGrava.Text)+1);
                EdGrava.Refresh;
                SqlAux1.Close;
                SqlAux1.SQL.Clear;
                SqlAux1.SQL.Add('update tbsdx_ect set tbsdx_use = ''S'' where (tbsdxect_num = :num)');
                SqlAux1.Params[0].AsString  :=  SqlAux3.Fields[0].AsString;
                SqlAux1.ExecSQL;
                SqlAux1.Close;
              except on e: exception do
                begin
                  application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                  EdErro.Text := IntToStr(strtoint(EdErro.Text)+1);
                  EdErro.Refresh;
{*
                  StrGridErro.Cells[R1,K1]   :=  trim(StrGridDados.Cells[0,k]);
                  StrGridErro.Cells[R1+1,K1] :=  trim(StrGridDados.Cells[1,k]);
                  StrGridErro.Cells[R1+2,K1] :=  trim(StrGridDados.Cells[4,k]);
                  StrGridErro.Cells[R1+3,K1] :=  trim(Ednumlote.Text);
                  StrGridErro.RowCount := (K1 + 1);
                  StrGridErro.Refresh;
*}                  
                  Inc(K1,1);
                end;
              end;
            Inc(K,1);
            Inc(x,1);
            StrGridDados.RowCount := K + 1;
            StrGridDados.Refresh;
            end;
          until
          x > StrToInt(EdQtdreg.Text);
          if (strtoint(trim(EdErro.Text)) > 0) then
            application.MessageBox(PChar('Registros com erros Verificar!'),'Ads',MB_OK+MB_ICONERROR)
          else
            application.MessageBox(PChar('Registros Gravados com Sucesso!'),'Ads',MB_OK+MB_ICONERROR);
          BtnSalvar.Enabled  :=  false;
          BtnFechar.Enabled := true;
        end;
      end;
    end;
end;

{
  Método que le uma planilha Excel contendo discriminação de envios
  A planilha deve conter 10 colunas com cabeçalhos e o
  primeiro cabeçalho obrigatóriamente deve ser a UF do envio
  A ordem das colunas não pode ser alteradas
  São elas: [UF] [JUNCAO] [NOME AGENCIA] [QTDE ITENS] [DATA EMISSAO] [VOLUMES] [PESO] [DTB] [VALOR] [PAGANTE]
  As colunas UF, Nome Agencia e Peso não são utilizadas
  As demais colunãs são de preenchimento obrigatório
}
procedure TFrmPreCadToken.lerXlsPreCarga;

var R, _Col, cols, _Line, lines,
  i, iIni, jTemp: Integer;
  cartoes : Array of TPagante;
  dtTemp: TDateTime;
begin
  BtnAbrir.Enabled :=  false;
  filename := Trim(Edlocal.Text);
  ExcelApplication1.Connect;
  Try
    ExcelApplication1.Workbooks.Open(filename, EmptyParam,
              EmptyParam, EmptyParam, EmptyParam, EmptyParam,
              EmptyParam, EmptyParam, EmptyParam, EmptyParam,
              EmptyParam, EmptyParam, EmptyParam,EmptyParam,
              EmptyParam, 0);

    WorkBk := ExcelApplication1.WorkBooks.Item[1];
    // Selecionando a primeira Aba
    WorkSheet := WorkBk.WorkSheets.Get_Item(1) as _WorkSheet;
    // Selecionando a ultima celula da ultima linha com dados
    lines := WorkSheet.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Row;
    cols := 10;
    StrGridDados.ColCount := cols + 1;
    RangeMatrix := ExcelApplication1.Range['A1', ExcelApplication1.Cells.Item[lines, cols]].Value2;
    ExcelApplication1.Quit;

    PanelProgressBar.Max := lines * cols;
  Finally
    ExcelApplication1.Disconnect;
  End;

  // Buscando a lista de cartões de postagem para posterior verificação
  // da existência de numeros de objetos disponíveis
  With Dm do
    begin
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('SELECT t.tbsdxserv_prod, t.tbsdxserv_dsc, t.tbsdxserv_crtpst, ');
      SqlAux2.SQL.Add('COUNT(DISTINCT e.tbsdxect_num) AS qt_objs ');
      SqlAux2.SQL.Add('FROM tbsdxserv t ');
      SqlAux2.SQL.Add('    LEFT JOIN public.tbsdx_ect e ON (t.tbsdxserv_prod = e.tbsdxect_prod) ');
      SqlAux2.SQL.Add('        AND e.tbsdxect_dtvenc > CURRENT_DATE AND e.tbsdx_use IS NULL ');
      SqlAux2.SQL.Add('WHERE t.tbsdxserv_status = 1 ');
      SqlAux2.SQL.Add('GROUP BY t.tbsdxserv_prod, t.tbsdxserv_dsc, t.tbsdxserv_crtpst');
      SqlAux2.Open;
      if SqlAux2.RecordCount > 0 then
        begin
          SetLength(cartoes, SqlAux2.RecordCount);
          i := 0;
          while not SqlAux2.Eof do
            begin
              cartoes[i].cod := SqlAux2.FieldByName('tbsdxserv_prod').AsInteger;
              cartoes[i].desc := SqlAux2.FieldByName('tbsdxserv_dsc').AsString;
              cartoes[i].cartao := SqlAux2.FieldByName('tbsdxserv_crtpst').AsString;
              cartoes[i].qtde := SqlAux2.FieldByName('qt_objs').AsInteger;
              SqlAux2.next;
              i := i + 1;
            end;
        end
      else
        begin
           application.MessageBox(
                      PChar('Ocorreu um erro fatal ao verificar existencia de ' + #13#10 +
                        'números de objetos livres. Processo será abortado'),
                        'ADS', MB_OK + MB_ICONERROR);
           exit;
        end;
    end;

  // Procurando a linha que contém o cabeçalho [UF]
  _Col := 1;

//  agencias := TStringList.Create;
  for iIni := 1 to lines do
    begin
      if (UpperCase(trim(RangeMatrix[iIni, _Col])) = 'UF') then
        // Encontrado
        begin
          // Lendo os dados do cabeçalho
          for _Col := 1 to cols do
            begin
              StrGridDados.Cells[_Col - 1, 0] := trim(RangeMatrix[iIni, _Col]);
              ProgressBarStepItOne;
            end;
            // Adicionando o cabeção de Cartao de Postagem após ultima coluna
          StrGridDados.Cells[cols, 0] := 'CARTAO POSTAGEM';
          break;
        end;
      PanelProgressBar.StepBy(cols);
      PanelProgress.Refresh;
    end;

  // Se o código acima encontrou a célula, ela pertence a linha dos cabeçalhos
  // portanto a próxima tem que ser linha de dados
  R := 1;
  StrGridDados.RowCount := (lines - iIni) + 1;
  for _Line := iIni + 1 to lines do // Ciclo da Linha
    begin
      for _Col := 1 to cols do // Ciclo da Coluna
        begin
          ProgressBarStepItOne;          
          {*
  O padrão definido para as planilhas a serem carregadas é o que segue
  10 colunas sendo [UF, COD AGENCIA, NOME AGENCIA, QTDE ITENS, DATA EMISSAO,
  QTDE VOLUMES, PESO, Nº DOCUMENTO, VALOR, PAGANTE]
  As Colunas UF e Nome de Agência podem ser ignoradas já que os dados de envio
  serão obtidos a partir do código da Agência. Aqui usaremos estas informações
  apenas para uma validação simples.
  Ver Documentação do processo ADS - Atribuição de Números de Objetos Bradesco
          *}
          if (trim(RangeMatrix[_Line, _Col]) <> '') then
              StrGridDados.Cells[(_Col - 1), R] := trim(RangeMatrix[_Line, _Col]);

          // Validandos os dados de UF com a Agência quando esta for encontrada
          if (_Col = 2) then
            begin
              if (trim(RangeMatrix[_Line, _Col]) <> '') and
                  (TryStrToInt(RangeMatrix[_Line, _Col], jTemp)) then
                begin
                  With Dm do
                    begin
                      SqlAux2.Close;
                      SqlAux2.SQL.Clear;
                      SqlAux2.SQL.Add('SELECT t.uf, t.juncao, t.depto FROM tbbraddptos t ');
                      SqlAux2.SQL.Add('WHERE t.juncao = :juncao');
                      SqlAux2.ParamByName('juncao').AsInteger := StrToInt(RangeMatrix[_Line, _Col]);
                      SqlAux2.Open;
                      if SqlAux2.RecordCount > 0 then
                        begin
                          if (trim(RangeMatrix[_Line, _Col -1]) <> '') and
                              (SqlAux2.FieldByName('uf').AsString <> trim(RangeMatrix[_Line, _Col -1])) then
                            begin
                              application.MessageBox(
                                  PChar('UF do destino presente na linha ' + IntToStr(_Line) + #13#10 +
                                      '  é diferente do existente no cadastro. Necessário verificar!'),
                                  'ADS', MB_OK + MB_ICONERROR);
                              exit;
                            end;
                          StrGridDados.Cells[(_Col - 1), R] :=  Format('%.4d', [SqlAux2.FieldByName('juncao').AsInteger]);
                          StrGridDados.Cells[_Col, R] :=  SqlAux2.FieldByName('depto').AsString;
                        end
                      else
                        begin;
                          application.MessageBox(
                              PChar('A agência ' + VarToStr(RangeMatrix[_Line, _Col]) +
                                  ', presente na linha ' + IntToStr(_Line) + #13#10 +
                                  ', não foi encontrada no cadastro. Necessário verificar!'),
                              'ADS', MB_OK + MB_ICONERROR);
                          exit;
                        end;
                    end;
                end
            end
          // Validando a data
          else if _Col = 5 then
            begin
              if TryStrToDate(RangeMatrix[_Line, _Col], dtTemp) then
                  StrGridDados.Cells[(_Col - 1), R] := FormatDateTime('dd/mm/yyyy', StrToDate(RangeMatrix[_Line, _Col]))
              else
                Try
                  IntToDateTime(StrToInt(RangeMatrix[_Line, _Col]));
                  StrGridDados.Cells[(_Col - 1), R] := FormatDateTime('dd/mm/yyyy', IntToDateTime(StrToInt(RangeMatrix[_Line, _Col])));
                except
                  application.MessageBox(
                      PChar('A Data presente na linha ' + IntToStr(_Line) +
                        '  é inválida. ' + #13#10 + 'Utilize o formato dd/mm/YYYY!'),
                        'ADS', MB_OK + MB_ICONERROR);
                  exit;
                end;
            end

          {
            Eventualmente será necessário enviar mais de um volume para um
              mesmo destino.
            Quando isso ocorrer, a mesma quantidade será utilizada para cada uma
              das entradas existentes.
            Se a coluna 4 (QTDE) possuir um valor maior que a quantidade de volumes
              será necessário informar um erro para que corrijam a planilha.
            Se a quantidade for diferente para cada volume, será necessário
              informar ao operador que separe as entradas em arquivos diferentes,
              podendo utilizar o mesmo nº de Lote
          }
          else if _Col = 6 then
            begin
              if (StrToInt(RangeMatrix[_Line, _Col]) > 1) and
                  (StrToInt(RangeMatrix[_Line, 4]) > StrToInt(RangeMatrix[_Line, _Col])) then
                begin
                  application.MessageBox(
                       PChar('Encontrado envios múltiplos com erro de informações.' + #13#10 +
                          'Qtde presente na linha ' + IntToStr(_Line) +
                          '  é superior a quantidade de Volumes. ' + #13#10 +
                          'Corrija as informações ou separe as entradas em arquivos diferentes.'),
                        'ADS', MB_OK + MB_ICONERROR);
                 exit;
                end;
            end

          // Validando o valor
          else if (_Col = 9) then
            begin
              if Moeda2Float(RangeMatrix[_Line, _Col]) > 0 then
                StrGridDados.Cells[(_Col - 1), R] := FloatToStrF(Moeda2Float(RangeMatrix[_Line, _Col]), ffNumber, 4, 2)
              else
                begin
                  application.MessageBox(
                      PChar('O valor presente na linha ' + IntToStr(_Line) +
                        '  é inválido!'), 'ADS', MB_OK + MB_ICONERROR);
                  exit;
                end;
            end

          // Validando o pagante e verificando se tem números de objetos
          // disponíveis.
          // NOTA: O Código do pagante é um número de 4 dígitos.
          //  Em algumas situações o campo pode conter uma data
          //  que será interpretada como um inteiro e devemos avisar
          //  ao operador que a informação está incorreta
          else if _Col = 10 then
            if (trim(RangeMatrix[_Line, _Col]) <> '') and
                    (TryStrToInt(RangeMatrix[_Line, _Col], jTemp)) and
                    (StrToInt(RangeMatrix[_Line, _Col]) < 9999) then
              begin
                // Buscando do cadastro de destinos qual o pagante vinculado
                With Dm do
                  begin
                    SqlAux2.Close;
                    SqlAux2.SQL.Clear;
                    SqlAux2.SQL.Add('SELECT t.tbsdxserv_prod, t.tbsdxserv_dsc, t.tbsdxserv_crtpst ');
                    SqlAux2.SQL.Add('FROM tbbraddptos d ');
                    SqlAux2.SQL.Add('    INNER JOIN tbsdxserv t ON (d.cartao_postagem = t.tbsdxserv_cod) ');
                    SqlAux2.SQL.Add('WHERE d.juncao = :juncao');
                    SqlAux2.ParamByName('juncao').AsInteger := jTemp;
                    SqlAux2.Open;
                  end;

                if dm.SqlAux2.RecordCount > 0 then
                  begin
                    for i:= Low(cartoes) to High(cartoes) do
                      if (cartoes[i].cod = Dm.SqlAux2.FieldByName('tbsdxserv_prod').AsInteger ) then
                        begin // Cartão encontrado
                          if (cartoes[i].qtde > StrToInt(RangeMatrix[_Line, 6])) then
                            begin
                              // Tem numero de objeto livre
                              cartoes[i].qtde := cartoes[i].qtde - StrToInt(RangeMatrix[_Line, 6]);
                              StrGridDados.Cells[_Col, R] := IntToStr(cartoes[i].cod);
                              StrGridDados.Cells[_Col - 1, R] := RangeMatrix[_Line, _Col];
                              break;
                            end
                          else
                            begin
                              application.MessageBox(
                                    PChar('O pagante ' + cartoes[i].desc + ' referente a linha ' +
                                      IntToStr(_Line) + #13#10 + ' não possui números ' +
                                      'de objetos livres suficientes. ' + #13#10 +
                                      'Necessário requisitar uma nova faixa!'),
                                    'ADS', MB_OK + MB_ICONERROR);
                              exit;
                            end;
                        end;
                  end
                else
                  begin
                    application.MessageBox(
                        PChar('A Junção Pagante referente a linha ' +
                            IntToStr(_Line) + #13#10 + ' não foi encontrada ' + #13#10 +
                            'Favor conferir as informações!'),
                        'ADS', MB_OK + MB_ICONERROR);
                    exit;
                  end;

                if i >= High(cartoes) then
                  // Essa condição jamais deverá ocorrer a menos que seja
                  // um bug não previsto. Avisar Operador
                  begin
                    application.MessageBox(
                          PChar('A Junção pagante presente na linha ' +
                            IntToStr(_Line) + #13#10 + ' não está vinculada a nenhum ' +
                            ' Cartão de Postagem. ' + #13#10 +
                            'Necessário conferir o cadastro uma nova faixa!'),
                          'ADS', MB_OK + MB_ICONERROR);
                    exit;
                  end;
              end
            else
              begin
                application.MessageBox(
                    PChar('A linha ' + IntToStr(_Line) + ' não possui informação ' +
                      'de Junção Pagante. Certifique-se de que a informação ' + #13#10 +
                      'esteja presente na coluna 10.'),
                    'ADS', MB_OK + MB_ICONERROR);
                exit;
              end;
        end; // end for 2
        R := R + 1;

        StrGridDados.Refresh;
        EdQtdreg.Text := IntToStr(_Line - iIni);
        EdQtdreg.Refresh;
    end;// end for 1

  RangeMatrix := Unassigned;
  if (StrGridDados.RowCount > 1 ) then
    begin
      BtnSalvar.Enabled := true;
      ShowMessage(IntToStr(StrGridDados.RowCount - 1) + ' registros lidos com sucesso!');
      // Facilitando...
      // Selecionando o produto a qual o ultimo registro tem como pagante
      if TryStrToInt(StrGridDados.Cells[10, StrGridDados.RowCount - 1], R) then
        CboProdutoServSedex.KeyValue := R;
    end;

end;

procedure TFrmPreCadToken.NovoLoteChkBoxClick(Sender: TObject);
begin
  Ednumlote.Enabled := not (NovoLoteChkBox.Checked);

end;

procedure TFrmPreCadToken.ProgressBarStepItOne;
begin
  PanelProgressBar.StepBy(1);
  PanelProgressBar.StepBy(-1);
  PanelProgressBar.StepBy(1);
  PanelProgressBar.Update;
  PanelProgress.Refresh;
end;

procedure TFrmPreCadToken.gravatk2;
var sqldadosobj, insmov, num_obj, dv,
  siglaobj, siglaprod : String;
  i: Integer;
begin
  PanelProgressBar.Max := StrGridDados.RowCount;
  nLotes := TStringList.Create;
  agencias := TStringList.Create;
  with dm do
    begin
      if NovoLoteChkBox.Checked then
        begin
          SqlAux1.Close;
          SqlAux1.SQL.Clear;
          SqlAux1.SQL.Add('SELECT MAX(CAST(t.cg77_numlote AS INTEGER)) + 1 as nlote');
          SqlAux1.SQL.Add('FROM cga77 t WHERE t.cg77_numlote ~ E''^\\d+$''');
          SqlAux1.Open;
          Ednumlote.Text := SqlAux1.FieldByName('nlote').AsString;
          nLotes.Add(SqlAux1.FieldByName('nlote').AsString);
          Ednumlote.Refresh;
        end;

      // Instruções SQL que serão executadas em LOOP
      seldup := 'SELECT COUNT(cg77_dtb) as qt_dtb ' + #13#10 +
                'FROM cga77 WHERE cg77_dtb = :dtb and cg77_ag = :ag ' + #13#10 +
                '  AND cg77_numlote = :numlote ' + #13#10 +
                '  AND cg77_tokini > :tokini ';

      insere := 'INSERT INTO cga77 (cg77_dtb, cg77_ag, cg77_qtd, ' + #13#10 +
                  'cg77_numlote, cg77_status, cg77_tokini, cg77_tokfin) ' + #13#10 +
                  'VALUES (:dtb, :ag, :qtd, :numlote, :status, :tokini, :tokfin)';

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

      insmov :='INSERT INTO tbsdx02 (sdx_codcli, sdx_idcli, sdx_siglaobj, ' +
                  'sdx_numobj, sdx_paisorigem, sdx_numobj4, sdx_nomdest, ' +
                  'sdx_endedest, sdx_cidade, sdx_uf, sdx_cep, sdx_numseqarq, ' +
                  'sdx_numseqreg, sdx_dtcarga, sdx_numobj2, sdx_numobj1, ' +
                  'sdx_codusu, sdx_valdec, sdx_seqcarga, sdx_qtprod, sdx_dtmov) ' +
                  'VALUES (99,''99'',:sigla, :numobj, ''BR'', :numobj4, :nomdest, ' +
                  ':enddest, :ciddest, :ufdest, :cepdest, 99, :numreg, ' +
                  'CURRENT_DATE, :numobj2, :numobj1, :codusu, :sdx_valdec, ' +
                  ':sdx_seqcarga, :qtprod, :sdx_dtmov)';

      for i := 0 to StrGridDados.RowCount - 1 do
        Begin
          ProgressBarStepItOne;
            if (trim(StrGridDados.Cells[1, i]) <> '') and
                (StrGridDados.Cells[0, i] <> 'UF') then
              begin
                // Validando que a linha é para o Pagante Correto
                if (StrToInt(StrGridDados.Cells[9, i]) <> CboProdutoServSedex.KeyValue) then
                  begin
                    ShowMessage('O Pagante da linha ' + IntToStr(i) +
                            ' não coincide com o pagante do produto selecionado. ' +
                            #13#10 + 'Processo será abortado');
                    exit;
                  end;

                // Caso tenha mais de um envio para uma mesma agencia
                // Estes devem ser separados em lotes diferentes
                if (agencias.IndexOf(StrGridDados.Cells[1, i]) > 0) then
                  begin
                    nLote := Format('%.5d', [StrToInt(nLotes[nLotes.Count - 1]) + 1]);
                    nLotes.Add(nLote);
                  end
                else
                  nLote := trim(Ednumlote.Text);
                
                // Buscando os dados do destino
                SqlTbBradDeptos.Close;
                SqlTbBradDeptos.SQL.Clear;
                SqlTbBradDeptos.SQL.Add('SELECT * FROM tbbraddptos WHERE juncao = :juncao');
                SqlTbBradDeptos.Params[0].AsInteger := StrToInt(StrGridDados.Cells[1, i]);
                SqlTbBradDeptos.Open;
                if (SqlTbBradDeptos.RecordCount < 1) then
                  begin
                    application.MessageBox(
                          PChar('A AGÊNCIA ' + StrGridDados.Cells[1, i] +
                              ', presente na linha ' + IntToStr(i + 1) +
                              ', não foi encontrada no cadastro. Necessário verificar!'),
                              'ADS', MB_OK + MB_ICONERROR);
                    exit;
                  end;

                agencias.Add(StrGridDados.Cells[1, i]);
                  
                SqlAux1.Close;
                SqlAux1.SQL.Clear;
                SqlAux1.SQL.Add(seldup);
                SqlAux1.ParamByName('dtb').AsString := trim(StrGridDados.Cells[7, i]);
                SqlAux1.ParamByName('ag').AsString := trim(StrGridDados.Cells[1, i]);
                SqlAux1.ParamByName('numlote').AsString := gerant(trim(Ednumlote.Text), 6);
                SqlAux1.ParamByName('tokini').AsString := '0';
                SqlAux1.Open;
                if (SqlAux1.FieldByName('qt_dtb').AsInteger = null) then
                  Begin
                    // Caso a consulta não seja executada corretamente, marca
                    // a linha para informar sobre os dados inconsistentes
                    EdErro.Text := IntToStr(strtoint(EdErro.Text) + 1);
                    EdErro.Refresh;
                  End
                Else
                  Begin
                    // Próximo número de objeto disponível
                    SqlAux3.Close;
                    SqlAux3.SQL.Clear;
                    SqlAux3.SQL.Add(sqldadosobj);
                    SqlAux3.ParamByName('prod').AsInteger := CboProdutoServSedex.KeyValue;
                    SqlAux3.Open;
                    num_obj := SqlAux3.FieldByName('tbsdxect_num').AsString;
                    dv := SqlAux3.FieldByName('tbsdxect_dv').AsString;
                    siglaobj := SqlAux3.FieldByName('tbsdxect_sigla').AsString;
                    siglaprod:= SqlAux3.FieldByName('tbsdxserv_sigla').AsString;

                    // Inserindo cadastro de vinculo de TOKEN à Agencia
                    SqlAux2.Close;
                    SqlAux2.SQL.Clear;
                    SqlAux2.SQL.Add(insere);
                    SqlAux2.ParamByName('dtb').AsString := num_obj + dv;
                    SqlAux2.ParamByName('ag').AsString := trim(StrGridDados.Cells[1, i]);
                    SqlAux2.ParamByName('qtd').AsInteger := strtoint(trim(StrGridDados.Cells[3, i]));
                    SqlAux2.ParamByName('numlote').AsString := GeraNt(trim(Ednumlote.Text), 6);
                    SqlAux2.ParamByName('status').AsString := '0';
                    SqlAux2.ParamByName('tokini').AsString := '0';
                    SqlAux2.ParamByName('tokfin').AsString := '0';
                    try
                      SqlAux2.ExecSQL;
                      SqlAux1.Close;
                      SqlAux1.SQL.Clear;
                      SqlAux1.SQL.Add(insmov);
                      SqlAux1.ParamByName('sigla').AsString := SqlSdxServtbsdxserv_sigla.AsString;
                      SqlAux1.ParamByName('numobj').AsInteger := StrToInt(num_obj + dv);
                      SqlAux1.ParamByName('numobj4').AsString := 'AR'+ num_obj + dv + SqlSdxServtbsdxserv_sigla.AsString;
                      SqlAux1.ParamByName('nomdest').AsString := GeraNt(trim(StrGridDados.Cells[1, i]), 4) + ': ' + trim(StrGridDados.Cells[2, i]);
                      SqlAux1.ParamByName('enddest').AsString := SqlTbBradDeptosender.AsString;
                      SqlAux1.ParamByName('ciddest').AsString := SqlTbBradDeptoscidade.Text;
                      SqlAux1.ParamByName('ufdest').AsString := SqlTbBradDeptosuf.Text;
                      SqlAux1.ParamByName('cepdest').AsString := StringReplace(SqlTbBradDeptoscep.Text, '-', '', [rfReplaceAll, rfIgnoreCase]);
                      SqlAux1.ParamByName('numreg').AsString := gerant(inttostr(random(999)), 3) +
                      FormatDateTime('yyyymmdd',date) + FormatDateTime('hhmmss',Time) +
                      GeraNT(sqlcga_acessocodigo.AsString,4) + GeraNt(inttostr(random(999)), 3);
                      SqlAux1.ParamByName('numobj2').AsString := siglaobj + num_obj + dv + 'BR';
                      SqlAux1.ParamByName('numobj1').AsString := 'AR'+ num_obj + dv + SqlSdxServtbsdxserv_sigla.AsString;
                      SqlAux1.ParamByName('codusu').AsString := sqlcga_acessocodigo.AsString;
                      SqlAux1.ParamByName('sdx_valdec').AsFloat := Moeda2Float(trim(StrGridDados.Cells[8, i]));
                      SqlAux1.ParamByName('sdx_seqcarga').AsString := trim(Ednumlote.Text);
                      SqlAux1.ParamByName('qtprod').AsInteger :=  strtoint(trim(StrGridDados.Cells[3, i]));
                      SqlAux1.ParamByName('sdx_dtmov').AsString := FormatDateTime('yyyy-mm-dd', StrToDate(StrGridDados.Cells[4, i]));

                      SqlAux1.ExecSQL;
                      EdGrava.Text := IntToStr(StrToInt64(EdGrava.Text) + 1);
                      EdGrava.Refresh;
                      SqlAux1.Close;
                      SqlAux1.SQL.Clear;

                      SqlAux1.SQL.Add('UPDATE tbsdx_ect SET tbsdx_use = :use '+
                              'WHERE tbsdxect_num = :numobj AND tbsdxect_prod = :prod');
                      SqlAux1.ParamByName('use').AsString := 'S';
                      SqlAux1.ParamByName('numobj').AsString := num_obj;
                      SqlAux1.ParamByName('prod').AsInteger := StrToInt(StrGridDados.Cells[9, i]);;
                      SqlAux1.ExecSQL;
                      if (SqlAux1.RowsAffected < 1 ) then
                        raise Exception.Create('Numero de objeto ' + num_obj +
                                ' não pode ser marcado como utilizado.');

                      SqlAux1.Close;
                    except on e: Exception do
                      begin
                        application.MessageBox(PChar('Ocorreu um erro fatal ao tentar ' +
                                  'vincular um numero de objeto ' + #13#10 +
                                  'para o item da linha ' + IntToStr(i) +
                                  '. Detalhes: '+ e.Message + #13#10 +
                                  'Nro Objeto: ' + siglaobj + num_obj + dv + 'BR'),
                                'Ads', MB_OK + MB_ICONERROR);
                        exit;
                      end;
                    end;
                  end
              end;
        end;
    end;
end;

{
  Método que atribui à cada uma das entradas
  da planilha lida um número de objeto
}
procedure TFrmPreCadToken.gravatc2;
var siglaobj, num_obj, siglaprod,
  dv, sqldadosobj, insmov: String;
  i: Integer;
begin
  PanelProgressBar.Max := StrGridDados.RowCount - 1;
  nLotes := TStringList.Create;
  agencias := TStringList.Create;
  nLotes.Add(trim(Ednumlote.Text));
  with dm do
    begin
      sqldadosobj := 'SELECT DISTINCT t.tbsdxect_num, t.tbsdxect_dv, t.tbsdxect_sigla, ' +
          's.tbsdxserv_sigla ' + #13#10 +
          'FROM public.tbsdx_ect t ' + #13#10 +
          '    INNER JOIN (' + #13#10 +
          '        SELECT MIN(tsub.tbsdxect_num) as numobj, ' + #13#10 +
          '             tsub.tbsdxect_prod ' + #13#10 +
          '        FROM public.tbsdx_ect tsub ' + #13#10 +
          '        WHERE tsub.tbsdxect_dtvenc > CURRENT_DATE ' + #13#10 +
          '            AND tsub.tbsdx_use IS NULL ' + #13#10 +
          '        GROUP BY 2 ) t2 ' + #13#10 +
          '      ON (t.tbsdxect_prod = t2.tbsdxect_prod) AND ' + #13#10 +
          '        t.tbsdxect_num = t2.numobj ' + #13#10 +
          '    INNER JOIN tbsdxserv s  ON t2.tbsdxect_prod = s.tbsdxserv_prod ' + #13#10 +
          'WHERE t.tbsdxect_prod = :prod ';
      insmov :='INSERT INTO tbsdx02 (sdx_codcli, sdx_idcli, sdx_siglaobj, ' +
                  'sdx_numobj, sdx_paisorigem, sdx_numobj4, sdx_nomdest, ' +
                  'sdx_endedest, sdx_cidade, sdx_uf, sdx_cep, sdx_numseqarq, ' +
                  'sdx_numseqreg, sdx_dtcarga, sdx_numobj2, sdx_numobj1, ' +
                  'sdx_codusu, sdx_valdec, sdx_seqcarga, sdx_qtprod, sdx_dtmov) ' +
                  'VALUES (99,''99'',:sigla, :numobj, ''BR'', :numobj4, :nomdest, ' +
                  ':enddest, :ciddest, :ufdest, :cepdest, 99, :numreg, ' +
                  'CURRENT_DATE, :numobj2, :numobj1, :codusu, :sdx_valdec, ' +
                  ':sdx_seqcarga, :qtprod, :sdx_dtmov)';
      for i := 0 to StrGridDados.RowCount - 1 do
        begin
          ProgressBarStepItOne;
          if (trim(StrGridDados.Cells[1, i]) <> '') and
              (StrGridDados.Cells[0, i] <> 'UF') then
            begin
              // Validando que a linha é para o Pagante Correto
              if (StrToInt(StrGridDados.Cells[9, i]) <> CboProdutoServSedex.KeyValue) then
                begin
                  ShowMessage('O Pagante da linha ' + IntToStr(i) +
                            ' não coincide com o pagante do produto selecionado. ' +
                            #13#10 + 'Processo será abortado');
                  exit;
                end;

              // Caso tenha mais de um envio para uma mesma agencia
              // Estes devem ser separados em lotes diferentes
              if (agencias.IndexOf(StrGridDados.Cells[1, i]) > 0) then
                begin
                  nLote := Format('%.5d', [StrToInt(nLotes[nLotes.Count - 1]) + 1]);
                  nLotes.Add(nLote);
                end
              else
                nLote := trim(Ednumlote.Text);

              // Buscando os dados do destino
              SqlTbBradDeptos.Close;
              SqlTbBradDeptos.SQL.Clear;
              SqlTbBradDeptos.SQL.Add('SELECT * FROM tbbraddptos WHERE juncao = :juncao');
              SqlTbBradDeptos.Params[0].AsInteger := StrToInt(StrGridDados.Cells[1, i]);
              SqlTbBradDeptos.Open;
              if (SqlTbBradDeptos.RecordCount < 1) then
                begin
                  application.MessageBox(
                          PChar('A AGÊNCIA ' + StrGridDados.Cells[1, i] +
                              ', presente na linha ' + IntToStr(i + 1) +
                              ', não foi encontrada no cadastro. Necessário verificar!'),
                              'ADS', MB_OK + MB_ICONERROR);
                  exit;
                end;

              agencias.Add(StrGridDados.Cells[1, i]);
                
              // Próximo número de objeto disponível
              SqlAux3.Close;
              SqlAux3.SQL.Clear;
              SqlAux3.SQL.Add(sqldadosobj);
              SqlAux3.ParamByName('prod').AsInteger := CboProdutoServSedex.KeyValue;
              SqlAux3.Open;
              num_obj := SqlAux3.FieldByName('tbsdxect_num').AsString;
              dv := SqlAux3.FieldByName('tbsdxect_dv').AsString;
              siglaobj := SqlAux3.FieldByName('tbsdxect_sigla').AsString;
              siglaprod:= SqlAux3.FieldByName('tbsdxserv_sigla').AsString;

              try
                SqlAux2.ExecSQL;
                SqlAux1.Close;
                SqlAux1.SQL.Clear;
                SqlAux1.SQL.Add(insmov);
                SqlAux1.ParamByName('sigla').AsString := SqlSdxServtbsdxserv_sigla.AsString;
                SqlAux1.ParamByName('numobj').AsInteger := StrToInt(num_obj + dv);
                SqlAux1.ParamByName('numobj4').AsString := 'AR' + num_obj + dv + SqlSdxServtbsdxserv_sigla.AsString;
                SqlAux1.ParamByName('nomdest').AsString := GeraNt(SqlTbBradDeptosjuncao.AsString, 4) +
                    ': ' + SqlTbBradDeptosdepto.AsString;
                SqlAux1.ParamByName('enddest').AsString := SqlTbBradDeptosender.AsString;
                SqlAux1.ParamByName('ciddest').AsString := SqlTbBradDeptoscidade.Text;
                SqlAux1.ParamByName('ufdest').AsString := SqlTbBradDeptosuf.Text;
                SqlAux1.ParamByName('cepdest').AsString := StringReplace(SqlTbBradDeptoscep.Text, '-', '', [rfReplaceAll, rfIgnoreCase]);
                SqlAux1.ParamByName('numreg').AsString := GeraNt(IntTostr(Random(999)), 3) +
                    FormatDateTime('yyyymmdd', Date) + FormatDateTime('hhmmss', Time) +
                    GeraNT(sqlcga_acessocodigo.AsString,4) + GeraNt(inttostr(random(999)), 3);

                SqlAux1.ParamByName('numobj2').AsString := siglaobj + num_obj + dv + 'BR';
                SqlAux1.ParamByName('numobj1').AsString := 'AR' + num_obj + dv + SqlSdxServtbsdxserv_sigla.AsString;
                SqlAux1.ParamByName('codusu').AsString := sqlcga_acessocodigo.AsString;
                SqlAux1.ParamByName('sdx_valdec').AsFloat := Moeda2Float(trim(StrGridDados.Cells[8, i]));
                SqlAux1.ParamByName('sdx_seqcarga').AsString := nLote;
                SqlAux1.ParamByName('qtprod').AsInteger :=  strtoint(trim(StrGridDados.Cells[3, i]));
                SqlAux1.ParamByName('sdx_dtmov').AsString := FormatDateTime('yyyy-mm-dd', StrToDate(StrGridDados.Cells[4, i]));

                SqlAux1.ExecSQL;
                EdGrava.Text := IntToStr(StrToInt64(EdGrava.Text) + 1);
                EdGrava.Refresh;
                SqlAux1.Close;
                SqlAux1.SQL.Clear;

                SqlAux1.SQL.Add('UPDATE tbsdx_ect SET tbsdx_use = :use '+
                              'WHERE tbsdxect_num = :numobj AND tbsdxect_prod = :prod');
                SqlAux1.ParamByName('use').AsString := 'S';
                SqlAux1.ParamByName('numobj').AsString := num_obj;
                SqlAux1.ParamByName('prod').AsInteger := StrToInt(StrGridDados.Cells[9, i]);;
                SqlAux1.ExecSQL;
                if (SqlAux1.RowsAffected < 1 ) then
                  raise Exception.Create('Numero de objeto ' + num_obj +
                                ' não pode ser marcado como utilizado.');

                SqlAux1.Close;
              except on e: Exception do
                begin
                  application.MessageBox(PChar('Ocorreu um erro fatal ao tentar ' +
                        'vincular um numero de objeto ' + #13#10 +
                        'para o item da linha ' + IntToStr(i) +
                        '. Detalhes: '+ e.Message + #13#10 +
                        'Nro Objeto: ' + siglaobj + num_obj + dv + 'BR'),
                        'Ads', MB_OK + MB_ICONERROR);
                  exit;
                end;
              end;
            end;
        end; // end for
    end; // end with
end;

end.
