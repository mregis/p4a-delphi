unit U_PreCadToken;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExcelXP, StdCtrls, ExtCtrls, ComCtrls,  Buttons, ShlObj,
  OleConst, SysConst, Types, OfficeXP,ComObj, ActiveX,  DB, Math, OleServer, OleDB,
  DBCtrls, DBGrids, DateUtils;

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
    lblLotesCriado: TLabel;
    NovoLoteChkBox: TCheckBox;
    Bevel1: TBevel;
    LabelLote: TLabel;
    LabelErros: TLabel;
    LabelGravados: TLabel;
    LabelLidos: TLabel;
    CboProdutoServSedex: TDBLookupComboBox;
    Label38: TLabel;
    PanelProgress: TPanel;
    PanelProgressBar: TProgressBar;
    BtnFechar: TBitBtn;
    BtnSalvar: TBitBtn;
    BtnLeitura: TBitBtn;
    BitBtnImprimeARs: TBitBtn;
    DBGridRelObjetos: TDBGrid;
    procedure DBGridRelObjetosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BitBtnImprimeARsClick(Sender: TObject);
    procedure NovoLoteChkBoxClick(Sender: TObject);
    procedure BtnAbrirClick(Sender: TObject);
    procedure BtnLeituraClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gravaol2;
    procedure gravatk2;
    procedure gravatc2;
    procedure lerXlsPreCarga;
  private
    WorkBk : _WorkBook;
    WorkSheet : _WorkSheet;
    t : Integer;
    RangeMatrix : Variant;
    FileName : WideString;
    seldup,insere : string;
    nLote : string;
    nLotes, agencias : TStringList;
    procedure ProgressBarStepItOne;

    { Private declarations }
  public
    { Public declarations }
  end;

type
  TPagante = record
    cod : Integer; // C�digo do Produto
    desc : String[50]; // Descri��o
    cartao: String[9]; // Numero cart�o de Postagem
    qtde: Integer; // Qtde de N�mero de objetos
    sigla: String[2]; // Sigla do Produto
  end;

var
  FrmPreCadToken: TFrmPreCadToken;

implementation

uses DmDados, U_Func, ZDataset;

{$R *.dfm}

procedure TFrmPreCadToken.BitBtnImprimeARsClick(Sender: TObject);
var lotes : TStringList;
  i : Integer;
  s : String;
begin
  // Verificar se h� o que imprimir baseado nas op��es do formul�rio
  With Dm do
    begin
      // Iniciando intera��o com o Banco
      SqlSdx3.Close;
      SqlSdx3.SQL.Clear;
      SqlSdx3.SQL.Add('SELECT DISTINCT t.sdx_codcli, t.sdx_idcli, t.sdx_siglaobj, t.sdx_numobj,');
      SqlSdx3.SQL.Add('  t.sdx_paisorigem, t.sdx_codoperacao, t.sdx_numobj3, t.sdx_nomdest,');
      SqlSdx3.SQL.Add('  t.sdx_endedest, t.sdx_cidade, t.sdx_uf, t.sdx_cep, t.sdx_numseqarq,');
      SqlSdx3.SQL.Add('  t.sdx_numseqreg, t.sdx_dtcarga, t.sdx_seqcarga, t.sdx_numobj2, ');
      SqlSdx3.SQL.Add('  t.sdx_cepnet, t.sdx_numobj1, t.sdx_numobj4, t.sdx_numobj5, ');
      SqlSdx3.SQL.Add('  t.sdx_peso, t.sdx_valor, t.sdx_qtde, t.sdx_tvalor, t.sdx_valdec, ');
      SqlSdx3.SQL.Add('  s.tbsdxserv_nrocto, s.tbsdxserv_crtpst, t.sdx_cmp, t.sdx_bas, ');
      SqlSdx3.SQL.Add('  t.sdx_alt, e.tbsdxect_sigla ');
      SqlSdx3.SQL.Add('FROM public.tbsdx02 t ');
      SqlSdx3.SQL.Add('    INNER JOIN public.tbsdx_ect e ON (t.sdx_numobj2 = e.tbsdxect_sigla || e.tbsdxect_num || ' +
                      'e.tbsdxect_dv || ''BR'' ) ');
      SqlSdx3.SQL.Add('    INNER JOIN public.tbsdxserv s ON (e.tbsdxect_prod = s.tbsdxserv_prod) ');                      
      SqlSdx3.SQL.Add('WHERE t.sdx_dtcarga = CURRENT_DATE ');
      lotes := TStringList.Create;
      lotes.DelimitedText := StringReplace(lblLotesCriado.Caption, 'Lote[s] criados[s]: ', '', [rfReplaceAll]);
      // Verificando se foi indicado um ou mais n�meros de lotes
      if (lotes.Count > 0) then
        begin
          SqlSdx3.SQL.Add(' AND t.sdx_seqcarga IN (:lote0'); // Abre
          SqlSdx3.ParamByName('lote0').AsInteger := StrToInt64(lotes.Strings[0]);
          for i := 1 to lotes.Count - 1 do
            begin
              s := 'lote' + IntToStr(i); // Nome do parametro
              SqlSdx3.SQL.Add(', :' + s); // Abre
              SqlSdx3.ParamByName(s).AsInteger := StrToInt64(lotes.Strings[i]);
            end;
          SqlSdx3.SQL.Add(') '); // Fecha
          SqlSdx3.SQL.Add('ORDER BY t.sdx_nomdest ');
          s := SqlSdx3.SQl.Text;
          SqlSdx3.Open;

          // Gerando o relat�rio de impress�o
          s := ExtractFilePath(Application.ExeName);
          RvRelatorios.ProjectFile := s + 'ARDigital.rav';
          RvRelatorios.ExecuteReport('RpSedexArOl');
          RvRelatorios.Close;
        end
      else
        Application.MessageBox(
            PChar('Ocorreu um erro ao identificar os lotes criados. ' +
                'Contate o administrador!'),
            'ADS', MB_OK + MB_ICONERROR);

      lotes.Free;
    end;
end;

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
  lblLotesCriado.Caption  :='';
  // Verificando itens de preenchimeno obrigat�rio  
  if (trim(EdLocal.Text) = '') then
    begin
      Application.MessageBox('Escolha Um Arquivo! ','Ads',MB_OK + MB_ICONERROR);
      BtnAbrir.SetFocus;
      exit;
    end;
  if (trim(CboProdutoServSedex.Text) = '') then
    begin
      application.MessageBox(PChar('Selecione um Produto!'),
          'Ads', MB_OK + MB_ICONINFORMATION);
      CboProdutoServSedex.SetFocus;
      exit;
    end;


  DBGridRelObjetos.Hide;
  BitBtnImprimeARs.Hide;
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
  lblLotesCriado.Color := clMoneyGreen;
  LblLotesCriado.Visible :=  false;

  with dm do
    begin
      // Preenchendo o Combo de Produtos
      SqlSdxServ.Close;
      SqlSdxServ.SQL.Clear;
      SqlSdxServ.SQL.Add('SELECT * FROM public.tbsdxserv t ');
      SqlSdxServ.SQL.Add('WHERE t.tbsdxserv_status = 1 AND ');
      SqlSdxServ.SQL.Add('(t.tbsdxserv_dsc ILIKE ''%TOKEN%'' OR ');
      SqlSdxServ.SQL.Add('t.tbsdxserv_dsc ILIKE ''%TANCODE%'' OR ');
      SqlSdxServ.SQL.Add('t.tbsdxserv_dsc ILIKE ''% OL %'')');

      SqlSdxServ.Open;
      CboProdutoServSedex.Refresh;

      // Verificando estado do n�meros de objetos e alertando caso existam
      // Faixas com muitos n�meros a vencerem nos pr�ximos 5 dias
      DBGridRelObjetos.Show; // Caso tenha sido ocultado anteriormente
      SqlAux4.Close;
      SqlAux4.SQL.Clear;
      SqlAux4.SQL.Add('SELECT DISTINCT s.tbsdxserv_sigla as sigla, ');
      SqlAux4.SQL.Add('    b.lote, b.dtcadastro, b.dtvencto, b.carga, ');
      SqlAux4.SQL.Add('    b.usado, b.livre, s.tbsdxserv_dsc as pagante ');
      SqlAux4.SQL.Add('FROM tbsdxserv s ');
      SqlAux4.SQL.Add('    LEFT JOIN (');
      SqlAux4.SQL.Add('        SELECT e.tbsdxect_lote as lote, ');
      SqlAux4.SQL.Add('            e.tbsdxect_dtcad as dtcadastro, ');
      SqlAux4.SQL.Add('            e.tbsdxect_dtvenc as dtvencto, ');
      SqlAux4.SQL.Add('            s2.tbsdxserv_sigla as sigla, ');
      SqlAux4.SQL.Add('            COUNT(e.*) as carga, ');
      SqlAux4.SQL.Add('            SUM(CASE WHEN e.tbsdx_use IS NOT NULL THEN 1 ELSE 0 END) AS usado, ');
      SqlAux4.SQL.Add('            SUM(CASE WHEN e.tbsdx_use IS NULL AND e.tbsdxect_num IS NOT NULL THEN 1 ELSE 0 END) AS livre ');
      SqlAux4.SQL.Add('        FROM tbsdx_ect e ');
      SqlAux4.SQL.Add('            INNER JOIN tbsdxserv s2 ON (e.tbsdxect_prod = s2.tbsdxserv_prod) ');
      SqlAux4.SQL.Add('        WHERE e.tbsdxect_dtvenc >= CURRENT_DATE ');
      SqlAux4.SQL.Add('        GROUP BY e.tbsdxect_lote, e.tbsdxect_dtcad, ');
      SqlAux4.SQL.Add('            e.tbsdxect_dtvenc, s2.tbsdxserv_sigla ) ');
      SqlAux4.SQL.Add('    b ON (s.tbsdxserv_sigla = b.sigla) ');
      SqlAux4.SQL.Add('WHERE s.tbsdxserv_status = 1 AND ');
      SqlAux4.SQL.Add('    (s.tbsdxserv_dsc ILIKE ''%TOKEN%'' OR ');
      SqlAux4.SQL.Add('    s.tbsdxserv_dsc ILIKE ''%TANCODE%'' OR ');
      SqlAux4.SQL.Add('    s.tbsdxserv_dsc ILIKE ''% OL %'')');
      SqlAux4.Open;
      DBGridRelObjetos.Refresh;

    end;

  if (FrmPreCadToken.Tag in[3]) then
      BtnLeitura.Caption  := 'Grava';
end;

procedure TFrmPreCadToken.BtnSalvarClick(Sender: TObject);
var lotemin, lotemax : Int64;
i : Integer;
begin
  PanelProgress.Visible := True;
  PanelProgress.Refresh;
  EdGrava.Text :=  '0';
  nLote := '';
  // Verificando se � pra gerar um novo n�mero de Lote ou aceitar
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
                      PChar('J� existe um Lote com esse n�mero! ' +
                            'Utilize outro n� de Lote !'),
                          'Ads', MB_OK + MB_ICONINFORMATION);
                  Ednumlote.Enabled := true;
                  Ednumlote.SetFocus;
                  PanelProgress.Visible := False;
                  exit;
                end;
            end;
        end;
    end;

  if (nLote = '') or (nLote = '0') then
    begin
      application.MessageBox(PChar('N�mero de Lote Inv�lido! Digite um n� de Lote !'), 'Ads', MB_OK + MB_ICONINFORMATION);
      Ednumlote.Enabled := true;
      Ednumlote.SetFocus;
      PanelProgress.Visible := False;
      exit;
    end;

  try
    // OL n�o pode buscar numeros de objetos pois
    // ser�o multiplos pagantes (produtos) na planilha
      With Dm do
        begin // Token, Tancode ou OL
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
              Application.MessageBox(
                  PChar('Quantidade insuficiente de n�meros ' +
                      'de objeto dispon�veis. ' + #13#10 +
                      'Solicite uma nova faixa para o Correios.'),
                  'ADS', ID_OK);
              BtnSalvar.Enabled :=  false;
              PanelProgress.Visible := False;
              exit;
            end;

          if AnsiPos(' OL ', SqlSdxServtbsdxserv_dsc.Value) > 0 then
            begin
              gravaol2;
            end
          else if AnsiPos('TOKEN', SqlSdxServtbsdxserv_dsc.Value) > 0  then
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
        end;
  finally
    PanelProgress.Visible := False;
    PanelProgressBar.Position := 0;
  end;

  if (trim(EdGrava.Text) <> '') and (StrToInt(EdGrava.Text) > 0) then
    begin
      application.MessageBox(PChar(EdGrava.Text  + ' registros inseridos com sucesso!'),
        'Ads', MB_OK + MB_ICONINFORMATION);

      BtnSalvar.Enabled := false;
      BtnLeitura.Enabled := true;
      if (nLotes.Count > 0) then
        begin
          LblLotesCriado.Visible := true;
          LblLotesCriado.Color := clRed;
          LblLotesCriado.Font.Size :=  12;
          LblLotesCriado.Font.Style := [fsBold];
          LblLotesCriado.Caption := 'Lote[s] criados[s]: ' + nLotes.CommaText;
          BitBtnImprimeARs.Show;
          nLotes.Free;
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
procedure TFrmPreCadToken.gravaol2;
var siglaobj, num_obj, siglaprod,
  dv, sqldadosobj, insmov: String;
  i, j, iTmp: Integer;
begin
  PanelProgressBar.Max := StrGridDados.RowCount - 1;
  nLotes := TStringList.Create;
  nLotes.Add(trim(Ednumlote.Text));

  // SQL Base para buscar o pr�ximo n�mero de objeto livre
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

      // Iniciando uma transa��o
      SqlAux3.SQL.Text := 'START TRANSACTION';
      SqlAux3.ExecSQL;

      SqlTbBradDeptos.SQL.Clear;
      SqlTbBradDeptos.SQL.Add('SELECT * FROM tbbraddptos WHERE juncao = :juncao');

      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add(insmov);

      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('UPDATE tbsdx_ect ' +
          'SET tbsdx_use = :use, tbsdxect_prod = :sel_prod ' +
          'WHERE tbsdxect_num = :numobj AND tbsdxect_prod = :prod');


      SqlAux3.SQL.Clear;
      SqlAux3.SQL.Add(sqldadosobj);

      for i := 0 to StrGridDados.RowCount - 1 do
        begin
          if StrGridDados.Cells[0, i] <> 'UF' then // Escapando o cabe�alho
            begin
              // Verificando se por engano n�o carregou uma planilha de
              // TANCODE ou TOKEN com o produto OL
              if (StrGridDados.Cells[9, i] = '0' ) then
                begin
                  Application.MessageBox(PChar('JUN��O PAGANTE [' +
                      StrGridDados.Cells[9, i] + '], presente na linha ' +
                      IntToStr(i + 1) + ', � inv�lida!' + #13#10 +
                      'Verifique se a carga � mesmo para o produto indicado'),
                    'ADS', MB_OK + MB_ICONERROR);
                  exit;
                end;

              // Buscando os dados do destino
              if not TryStrToInt(StrGridDados.Cells[1, i], iTmp) then
                begin
                  Application.MessageBox(PChar('C�digo de Ag�ncia ' +
                      StrGridDados.Cells[1, i] + ', presente na linha ' +
                      IntToStr(i + 1) + ', � inv�lido! '),
                    'ADS', MB_OK + MB_ICONERROR);
                  exit;
                end;

              SqlTbBradDeptos.Params[0].AsInteger := iTmp;
              SqlTbBradDeptos.ExecSQL;
              SqlTbBradDeptos.Open;
              if (SqlTbBradDeptos.RecordCount < 1) then
                begin
                  application.MessageBox(PChar('A ag�ncia ' +
                      StrGridDados.Cells[1, i] + ', presente na linha ' +
                      IntToStr(i + 1) + ', n�o foi encontrada no cadastro. ' + #13#10 +
                      'Necess�rio verificar!'),
                    'ADS', MB_OK + MB_ICONERROR);
                  exit;
                end;

              // Inserindo a entrada
              // A Coluna VOLUME[s] indica quantos n�meros de objetos
              // precisam ser vinculados para a ag�ncia em quest�o
              // Caso a quantidade de itens seja maior que 1 � necess�rio
              // perguntar ao operador se o valor encontrado � o mesmo para todos
              // os volumes
              if (StrToInt(StrGridDados.Cells[5, i]) > 1) and
                  (StrToInt(StrGridDados.Cells[3, i]) > 1) then
                begin
                  if (MessageDlg('Encontrado envio de m�ltiplos objetos para ' +
                        'uma mesma ag�ncia, por�m com ' + StrGridDados.Cells[3, i] +
                        ' de quantidade. Atribuir esta quantidade para cada '+
                        'um dos volumes?', mtCustom, [mbYes,mbNo], 0) = mrNo) then
                    begin
                      ShowMessage('O Processo ser� interrompido.' + #13#10 +
                         'Revise as informa��es antes de tentar carregar ' +
                          'novamente os dados');
                      exit;
                    end;
                end;

              // fazendo o loop
              for j := 1 to StrToInt(StrGridDados.Cells[5, i]) do
                begin
                  // Pegando dados do n�mero de objeto
                  SqlAux3.ParamByName('prod').AsInteger := SqlSdxServtbsdxserv_prod.AsInteger;
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
                      if (trim(StrGridDados.Cells[2, i]) = '') then
                        SqlAux1.ParamByName('nomdest').AsString := gerant(SqlTbBradDeptosjuncao.AsString, 4) + ': ' + SqlTbBradDeptosdepto.AsString
                      else
                        SqlAux1.ParamByName('nomdest').AsString := gerant(SqlTbBradDeptosjuncao.AsString, 4) + ': ' + trim(StrGridDados.Cells[2, i]);

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
                        SqlAux2.ParamByName('prod').AsInteger := SqlSdxServtbsdxserv_prod.AsInteger;
                        SqlAux2.ParamByName('sel_prod').AsInteger := StrToInt(StrGridDados.Cells[10, i]);
                        SqlAux2.ExecSQL;
                        if (SqlAux2.RowsAffected < 1) then
                            raise Exception.Create('Numero de objeto ' + num_obj + ' n�o pode ser marcado como utilizado.');

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
                      application.MessageBox(PChar('O Cart�o de Postagem do pagante ' +
                            StrGridDados.Cells[10, i] + ', presente na linha ' +
                            IntToStr(i) + ', n�o possui n�meros de objetos livres. ' + #13#10 +
                            'Requisite novos objetos!'),
                          'ADS', MB_OK + MB_ICONERROR);
                    exit;
                    end;
                end;
          end;
        end;
      // Finalizando a transa��o
      SqlAux3.SQL.Text := 'COMMIT';
      SqlAux3.ExecSQL;

      SqlAux1.Close;
      SqlAux2.Close;
      SqlAux3.Close;
    end;
end;

//********** Fim Grava OL

//********** Inicio Indica��o de Estado de Faixa de Objetos
procedure TFrmPreCadToken.DBGridRelObjetosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with DBGridRelObjetos do
    begin
      if Odd( DataSource.DataSet.RecNo) then
        Canvas.Brush.Color := clMoneyGreen;

        Canvas.Font.Style := [];
        Canvas.Font.Color := clBlack;
        { Se for zero }
      if (DataSource.DataSet.FieldByName('livre').AsInteger = 0) OR
         { Ou se venceu }
          (DataSource.DataSet.FieldByName('dtvencto').Value = null) then
        begin
          Canvas.Font.Style := [fsBold];
          Canvas.Brush.Color := clRed;
        end
        { chegar a 89% de uso da carga inicial }
      else if (DataSource.DataSet.FieldByName('livre').AsFloat <
            DataSource.DataSet.FieldByName('carga').AsFloat * 0.11) OR
        { Se faltar menos do que 1 semana para vencer a faixa }
            (CompareDate(Date, DataSource.DataSet.FieldByName('dtvencto').AsDateTime - 30) > 0)  then
        begin
          Canvas.Font.Style := [fsBold];
          Canvas.Brush.Color := clYellow;
        end;

      Canvas.FillRect(Rect);
      DefaultDrawColumnCell(Rect,DataCol,Column,State);
    end;
end;
//********** FIM Indica��o de Estado de Faixa de Objetos

{
  M�todo que le uma planilha Excel contendo discrimina��o de envios
  A planilha deve conter 10 colunas com cabe�alhos e o
  primeiro cabe�alho obrigat�riamente deve ser a UF do envio
  A ordem das colunas n�o pode ser alteradas
  S�o elas: [UF] [JUNCAO] [NOME AGENCIA] [QTDE ITENS] [DATA EMISSAO] [VOLUMES] [PESO] [DTB] [VALOR] [PAGANTE]
  As colunas UF e Peso n�o s�o utilizadas
  A coluna Nome Agencia pode ficar em Branco - Se preenchido ser� usado como DESTINAT�RIO
  As demais colun�s s�o de preenchimento obrigat�rio
}
procedure TFrmPreCadToken.lerXlsPreCarga;

var R, _Col, cols, _Line, lines,
  i, iIni, jTemp, prod_sel: Integer;
  cartoes : Array of TPagante;
  dtTemp: TDateTime;
  sigla_sel: String;
begin
  BtnAbrir.Enabled :=  false;
  filename := Trim(Edlocal.Text);
  ExcelApplication1.Connect;
  prod_sel := 0;
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

  // Buscando a lista de cart�es de postagem para posterior verifica��o
  // da exist�ncia de numeros de objetos dispon�veis
  With Dm do
    begin
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('SELECT t.tbsdxserv_prod, t.tbsdxserv_dsc, ');
      SqlAux2.SQL.Add('    t.tbsdxserv_crtpst, t.tbsdxserv_sigla, ');
      SqlAux2.SQL.Add('COUNT(DISTINCT e.tbsdxect_num) AS qt_objs ');
      SqlAux2.SQL.Add('FROM tbsdxserv t ');
      SqlAux2.SQL.Add('    LEFT JOIN public.tbsdx_ect e ON (t.tbsdxserv_prod = e.tbsdxect_prod) ');
      SqlAux2.SQL.Add('        AND e.tbsdxect_dtvenc > CURRENT_DATE AND e.tbsdx_use IS NULL ');
      SqlAux2.SQL.Add('WHERE t.tbsdxserv_status = 1 AND ');
      SqlAux2.SQL.Add('(t.tbsdxserv_dsc ILIKE ''%TOKEN%'' OR ');
      SqlAux2.SQL.Add('t.tbsdxserv_dsc ILIKE ''%TANCODE%'' OR ');
      SqlAux2.SQL.Add('t.tbsdxserv_dsc ILIKE ''% OL %'')');
      SqlAux2.SQL.Add('GROUP BY t.tbsdxserv_prod, t.tbsdxserv_dsc, ');
      SqlAux2.SQL.Add('    t.tbsdxserv_crtpst, t.tbsdxserv_sigla');
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
              cartoes[i].sigla := SqlAux2.FieldByName('tbsdxserv_sigla').AsString;
              SqlAux2.next;
              i := i + 1;
            end;
        end
      else
        begin
           application.MessageBox(
                      PChar('Ocorreu um erro fatal ao verificar existencia de ' + #13#10 +
                        'n�meros de objetos livres. Processo ser� abortado'),
                        'ADS', MB_OK + MB_ICONERROR);
           exit;
        end;
    end;

  // Procurando a linha que cont�m o cabe�alho [UF]
  _Col := 1;

//  agencias := TStringList.Create;
  for iIni := 1 to lines do
    begin
      if (UpperCase(trim(RangeMatrix[iIni, _Col])) = 'UF') then
        // Encontrado
        begin
          // Lendo os dados do cabe�alho
          for _Col := 1 to cols do
            begin
              StrGridDados.Cells[_Col - 1, 0] := trim(RangeMatrix[iIni, _Col]);
              ProgressBarStepItOne;
            end;
            // Adicionando o cabe��o de Cartao de Postagem ap�s ultima coluna
          StrGridDados.Cells[cols, 0] := 'CART�O';
          break;
        end;
      PanelProgressBar.StepBy(cols);
      PanelProgress.Refresh;
    end;

  if iIni >= lines then
    begin
      // Planilha n�o est� no formato adequado
      application.MessageBox(
                PChar('N�o foi encontrado a linha de cabe�alhos na planilha.'
                  + #13#10 + 'Uma linha contendo os cabe�alhos [UF|JUNCAO/AG|' +
                  'NOME AGENCIA|QTDE|DATA EMISSAO|VOL|PESO|OS|VALOR|PAGANTE] ' +
                  #13#10 + 'precisa estar presente.'),
                'ADS', MB_OK + MB_ICONERROR);
      exit;
    end;
  // Se o c�digo acima encontrou a c�lula, ela pertence a linha dos cabe�alhos
  // portanto a pr�xima tem que ser linha de dados
  R := 1;
  StrGridDados.RowCount := (lines - iIni) + 1;
  for _Line := iIni + 1 to lines do // Ciclo da Linha
    begin
      for _Col := 1 to cols do // Ciclo da Coluna
        begin
          ProgressBarStepItOne;
          {*
      O padr�o definido para as planilhas a serem carregadas � o que segue
      10 colunas sendo [UF, COD AGENCIA, NOME AGENCIA, QTDE ITENS, DATA EMISSAO,
      QTDE VOLUMES, PESO, N� DOCUMENTO, VALOR, PAGANTE]
      As Colunas UF e Nome de Ag�ncia podem ser ignoradas j� que os dados de envio
      ser�o obtidos a partir do c�digo da Ag�ncia. Aqui usaremos estas informa��es
      apenas para uma valida��o simples.
      Ver Documenta��o do processo ADS - Atribui��o de N�meros de Objetos Bradesco
      RangeMatrix indexado em 1
      StringGrid indexado em 0
          *}
          if (trim(RangeMatrix[_Line, _Col]) <> '') then
              StrGridDados.Cells[(_Col - 1), R] := trim(RangeMatrix[_Line, _Col]);

          // Validandos os dados de UF com a Ag�ncia quando esta for encontrada
          if (_Col = 2) then
            begin
              if (trim(RangeMatrix[_Line, _Col]) <> '') and
                  (TryStrToInt(RangeMatrix[_Line, _Col], jTemp)) then
                begin
                  With Dm do
                    begin
                      SqlAux2.Close;
                      SqlAux2.SQL.Clear;
                      SqlAux2.SQL.Add('SELECT t.uf, t.juncao, t.depto ');
                      SqlAux2.SQL.Add('FROM tbbraddptos t ');
                      SqlAux2.SQL.Add('WHERE t.juncao = :juncao');
                      SqlAux2.ParamByName('juncao').AsInteger := jTemp;
                      SqlAux2.Open;
                      if SqlAux2.RecordCount > 0 then
                        begin
                          if (trim(RangeMatrix[_Line, _Col -1]) <> '') then
                            begin
                              if (SqlAux2.FieldByName('uf').AsString <> trim(RangeMatrix[_Line, _Col -1])) then
                                begin
                                  application.MessageBox(
                                      PChar('UF do destino presente na linha ' + IntToStr(_Line) + #13#10 +
                                          '  � diferente do existente no cadastro. Necess�rio verificar!'),
                                      'ADS', MB_OK + MB_ICONERROR);
                                  exit;
                                end;
                            end
                          else
                            // UF da jun��o exibida no GRIO
                            StrGridDados.Cells[(_Col - 2), R] := SqlAux2.FieldByName('uf').AsString;
                          // Codigo da Juncao
                          StrGridDados.Cells[(_Col - 1), R] :=  Format('%.4d', [SqlAux2.FieldByName('juncao').AsInteger]);

                          if (trim(RangeMatrix[_Line, _Col + 1]) <> '') AND
                            (trim(RangeMatrix[_Line, 10]) <> '0') then
                            StrGridDados.Cells[_Col, R] := trim(RangeMatrix[_Line, _Col + 1])
                          else
                            RangeMatrix[_Line, _Col + 1] := SqlAux2.FieldByName('depto').AsString;
                        end
                      else
                        begin;
                          application.MessageBox(
                              PChar('A ag�ncia ' + VarToStr(RangeMatrix[_Line, _Col]) +
                                  ', presente na linha ' + IntToStr(_Line) + #13#10 +
                                  ', n�o foi encontrada no cadastro. Necess�rio verificar!'),
                              'ADS', MB_OK + MB_ICONERROR);
                          exit;
                        end;
                    end; // end with
                end;
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
                        '  � inv�lida. ' + #13#10 + 'Utilize o formato dd/mm/YYYY!'),
                        'ADS', MB_OK + MB_ICONERROR);
                  exit;
                end;
            end

          {
            Eventualmente ser� necess�rio enviar mais de um volume para um
              mesmo destino.
            Quando isso ocorrer, a mesma quantidade ser� utilizada para cada uma
              das entradas existentes.
            Se a coluna 4 (QTDE) possuir um valor maior que a quantidade de volumes
              ser� necess�rio informar um erro para que corrijam a planilha.
            Se a quantidade for diferente para cada volume, ser� necess�rio
              informar ao operador que separe as entradas em arquivos diferentes,
              podendo utilizar o mesmo n� de Lote
          }
          else if _Col = 6 then
            begin
              if (StrToInt(RangeMatrix[_Line, _Col]) > 1) and
                  (StrToInt(RangeMatrix[_Line, 4]) > StrToInt(RangeMatrix[_Line, _Col])) then
                begin
                  application.MessageBox(
                       PChar('Encontrado envios m�ltiplos com erro de informa��es.' + #13#10 +
                          'Qtde presente na linha ' + IntToStr(_Line) +
                          '  � superior a quantidade de Volumes. ' + #13#10 +
                          'Corrija as informa��es ou separe as entradas em arquivos diferentes.'),
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
                        '  � inv�lido!'), 'ADS', MB_OK + MB_ICONERROR);
                  exit;
                end;
            end

          // Validando o pagante e verificando se tem n�meros de objetos
          // dispon�veis atrav�s da liga��o do cart�o de postagem com a sigla
          else if _Col = 10 then
            begin
              jTemp := 0;
              if ((trim(RangeMatrix[_Line, _Col]) = '') or
                  not (TryStrToInt(RangeMatrix[_Line, _Col], jTemp))) then
                begin
                  application.MessageBox(
                      PChar('A linha ' + IntToStr(_Line) +
                        ' n�o possui informa��o de Jun��o Pagante v�lido. ' +
                        #13#10 + 'Certifique-se de que a informa��o ' +
                        'esteja presente na coluna 10.'),
                      'ADS', MB_OK + MB_ICONERROR);
                  exit;
                end;
              sigla_sel := '';
              if (jTemp > 0) then
                begin // Buscando o PAGANTE (Cart�o de Postagem) vinculado a JUNC�O PAGANTE
                  With Dm do
                    begin
                      SqlAux2.Close;
                      SqlAux2.SQL.Clear;
                      SqlAux2.SQL.Add('SELECT t.tbsdxserv_prod, t.tbsdxserv_dsc, ');
                      SqlAux2.SQL.Add('    t.tbsdxserv_sigla, t.tbsdxserv_crtpst ');
                      SqlAux2.SQL.Add('FROM tbbraddptos d ');
                      SqlAux2.SQL.Add('    INNER JOIN tbsdxserv t ON (d.cartao_postagem = t.tbsdxserv_cod) ');
                      SqlAux2.SQL.Add('WHERE d.juncao = :juncao');
                      SqlAux2.ParamByName('juncao').AsInteger := jTemp;
                      SqlAux2.Open;
                    end;

                  if dm.SqlAux2.RecordCount > 0 then
                    begin
                      sigla_sel := Dm.SqlAux2.FieldByName('tbsdxserv_sigla').AsString;
                      prod_sel := Dm.SqlAux2.FieldByName('tbsdxserv_prod').AsInteger;
                    end
                  else
                    begin
                      application.MessageBox(
                          PChar('A Jun��o Pagante referente a linha ' +
                            IntToStr(_Line) + #13#10 + ' n�o foi encontrada ' + #13#10 +
                            'Favor conferir as informa��es!'),
                          'ADS', MB_OK + MB_ICONERROR);
                      exit;
                    end;
                end
              else
                prod_sel := CboProdutoServSedex.KeyValue;

              for i:= Low(cartoes) to High(cartoes) do
                if ((cartoes[i].sigla = sigla_sel) OR
                    (cartoes[i].cod = CboProdutoServSedex.KeyValue)) then
                  begin // Cart�o encontrado
                    if (cartoes[i].qtde > StrToInt(RangeMatrix[_Line, 6])) then
                      begin
                        // Tem numero de objeto livre
                        // Diminuindo o valor dispon�vel usando a quantidade de volumes
                        // indicado na Coluna 6
                        cartoes[i].qtde := cartoes[i].qtde - StrToInt(RangeMatrix[_Line, 6]);
                        // Exibindo o Cart�o de Postagem selecionado
                        StrGridDados.Cells[_Col, R] := IntToStr(prod_sel);
                        // Exibindo a Jun��o Pagante
                        StrGridDados.Cells[_Col - 1, R] := RangeMatrix[_Line, _Col];
                        break;
                      end
                    else
                      begin
                        application.MessageBox(
                            PChar('O pagante ' + cartoes[i].desc + ' referente a linha ' +
                                IntToStr(_Line) + #13#10 + ' n�o possui n�meros ' +
                                'de objetos livres suficientes. ' + #13#10 +
                                'Necess�rio requisitar uma nova faixa!'),
                            'ADS', MB_OK + MB_ICONERROR);
                        exit;
                      end;
                  end;

              if i > High(cartoes) then
                  // Essa condi��o jamais dever� ocorrer a menos que seja
                  // um bug n�o previsto. Avisar Operador
                begin
                  application.MessageBox(
                      PChar('A Jun��o pagante presente na linha ' +
                            IntToStr(_Line) + #13#10 + ' n�o est� vinculada a nenhum ' +
                            ' Cart�o de Postagem. ' + #13#10 +
                            'Necess�rio conferir o cadastro!'),
                      'ADS', MB_OK + MB_ICONERROR);
                  exit;
                end;
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
      if CboProdutoServSedex.KeyValue = null then
        begin
          ShowMessage('Selecione o tipo de envio!');
          CboProdutoServSedex.SetFocus;
        end;
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
  i, prod_sel: Integer;
begin
  PanelProgressBar.Max := StrGridDados.RowCount;
  nLotes := TStringList.Create;
  agencias := TStringList.Create;
  prod_sel := 0;
  with dm do
    begin
      SqlAux1.SQL.Text := 'BEGIN';
      SqlAux1.ExecSQL;
          
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

      // Instru��es SQL que ser�o executadas em LOOP
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
                if (StrGridDados.Cells[9, i] = '0') then
                  prod_sel := CboProdutoServSedex.KeyValue
              else
                if not TryStrToInt(CboProdutoServSedex.KeyValue, prod_sel) then
                  begin
                    ShowMessage('H� um problema com o Pagante da linha ' +
                        IntToStr(i) +
                        '!' + #13#10 + 'Processo ser� abortado');
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
                          PChar('A AG�NCIA ' + StrGridDados.Cells[1, i] +
                              ', presente na linha ' + IntToStr(i + 1) +
                              ', n�o foi encontrada no cadastro. Necess�rio verificar!'),
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
                    // Caso a consulta n�o seja executada corretamente, marca
                    // a linha para informar sobre os dados inconsistentes
                    EdErro.Text := IntToStr(strtoint(EdErro.Text) + 1);
                    EdErro.Refresh;
                  End
                Else
                  Begin
                    // Pr�ximo n�mero de objeto dispon�vel
                    SqlAux3.Close;
                    SqlAux3.SQL.Clear;
                    SqlAux3.SQL.Add(sqldadosobj);
                    SqlAux3.ParamByName('prod').AsInteger := CboProdutoServSedex.KeyValue;
                    SqlAux3.Open;
                    num_obj := SqlAux3.FieldByName('tbsdxect_num').AsString;
                    dv := SqlAux3.FieldByName('tbsdxect_dv').AsString;
                    siglaobj := SqlAux3.FieldByName('tbsdxect_sigla').AsString;
                    siglaprod:= SqlAux3.FieldByName('tbsdxserv_sigla').AsString;

                    // Inserindo cadastro de vinculo de TOKEN � Agencia
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
                      SqlAux1.ParamByName('nomdest').AsString := GeraNt(SqlTbBradDeptosjuncao.AsString, 4) +
                    ': ' + SqlTbBradDeptosdepto.AsString;

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
                      SqlAux1.ParamByName('prod').AsInteger := prod_sel;
                      SqlAux1.ExecSQL;

                      if (SqlAux1.RowsAffected < 1 ) then
                        raise Exception.Create('Numero de objeto ' + num_obj +
                                ' n�o pode ser marcado como utilizado.');

                      SqlAux1.Close;
                    except on e: Exception do
                      begin
                        SqlAux1.SQL.Text := 'ROLLBACK';
                        SqlAux1.ExecSQL;
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
      SqlAux1.SQL.Text := 'COMMIT';
      SqlAux1.ExecSQL;
    end;
end;

{
  M�todo que atribui � cada uma das entradas
  da planilha lida um n�mero de objeto
}
procedure TFrmPreCadToken.gravatc2;
var siglaobj, num_obj, siglaprod,
  dv, sqldadosobj, insmov: String;
  i, prod_sel: Integer;
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

      SqlAux1.SQL.Text := 'BEGIN';
      SqlAux1.ExecSQL;
      for i := 0 to StrGridDados.RowCount - 1 do
        begin
          ProgressBarStepItOne;
          if (trim(StrGridDados.Cells[1, i]) <> '') and
              (StrGridDados.Cells[0, i] <> 'UF') then
            begin
              // Verificando se a linha � para o Pagante Correto
              // Se estiver preenchido com zero, o valor do produto selecionado
              // no combo de produtos ser� utilizado
              if (StrGridDados.Cells[9, i] = '0') then
                prod_sel := CboProdutoServSedex.KeyValue
              else
                if not TryStrToInt(CboProdutoServSedex.KeyValue, prod_sel) then
                  begin
                    ShowMessage('H� um problema com o Pagante da linha ' +
                        IntToStr(i) +
                        '!' + #13#10 + 'Processo ser� abortado');
                    exit;
                  end;

              if ( prod_sel <> CboProdutoServSedex.KeyValue) then
                begin
                  ShowMessage('O Pagante da linha ' + IntToStr(i) +
                            ' n�o coincide com o pagante do produto selecionado. ' +
                            #13#10 + 'Processo ser� abortado');
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
                          PChar('A AG�NCIA ' + StrGridDados.Cells[1, i] +
                              ', presente na linha ' + IntToStr(i + 1) +
                              ', n�o foi encontrada no cadastro. Necess�rio verificar!'),
                              'ADS', MB_OK + MB_ICONERROR);
                  exit;
                end;

              agencias.Add(StrGridDados.Cells[1, i]);

              // Pr�ximo n�mero de objeto dispon�vel
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
                SqlAux1.ParamByName('prod').AsInteger := prod_sel;
                SqlAux1.ExecSQL;
                if (SqlAux1.RowsAffected < 1 ) then
                  raise Exception.Create('Numero de objeto ' + num_obj +
                                ' n�o pode ser marcado como utilizado.');
                SqlAux1.Close;
              except on e: Exception do
                begin
                  application.MessageBox(PChar('Ocorreu um erro fatal ao tentar ' +
                        'vincular um numero de objeto ' + #13#10 +
                        'para o item da linha ' + IntToStr(i) +
                        '. Detalhes: '+ e.Message + #13#10 +
                        'Nro Objeto: ' + siglaobj + num_obj + dv + 'BR'),
                        'Ads', MB_OK + MB_ICONERROR);
                  SqlAux1.CancelUpdates;
                  SqlAux1.SQL.Text := 'ROLLBACK';
                  SqlAux1.ExecSQL;
                  exit;
                end;
              end;
            end;
        end; // end for
      SqlAux1.SQL.Text := 'COMMIT';
      SqlAux1.ExecSQL;
    end; // end with
end;

end.
