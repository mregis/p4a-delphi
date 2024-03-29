unit U_FrmGeraListaPostagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, ComCtrls, Grids, DBGrids, ExtCtrls,
  FileCtrl, Math, DateUtils, Mask, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdFTP, Registry;

type
  TFrmGeraListaPostagem = class(TForm)
    BitBtnGerar: TBitBtn;
    GroupBoxPeridoPostagem: TGroupBox;
    LabelDtIni: TLabel;
    LabelDtFin: TLabel;
    DtPickerDtIni: TDateTimePicker;
    DtPickerDtFin: TDateTimePicker;
    CboPagante: TDBLookupComboBox;
    LabelProd: TLabel;
    DBGridPostagem: TDBGrid;
    LabelLote: TLabel;
    PanelProgress: TPanel;
    PanelProgressBar: TProgressBar;
    BtnFechar: TBitBtn;
    BtnAbrir: TBitBtn;
    EdDirDestinoListagem: TEdit;
    LblDirDestino: TLabel;
    CheckBoxGerar: TCheckBox;
    EdLote: TEdit;
    StsRemSdx: TStatusBar;
    procedure CheckBoxGerarClick(Sender: TObject);
    procedure BtnAbrirClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure DBGridPostagemCellClick(Column: TColumn);
    procedure DtPickerDtFinUserInput(Sender: TObject; const UserString: string;
      var DateAndTime: TDateTime; var AllowChange: Boolean);
    procedure DtPickerDtIniUserInput(Sender: TObject; const UserString: string;
      var DateAndTime: TDateTime; var AllowChange: Boolean);
    procedure DtPickerDtFinCloseUp(Sender: TObject);
    procedure DtPickerDtIniCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtnGerarClick(Sender: TObject);

  private
    { Private declarations }
    procedure AtualizaGridPostagem;
    procedure ProgressBarStepItOne;
    procedure XLSReport;
    procedure GeraArquivoPrevisao;
    procedure EnviaArquivoPrevisao;
    procedure GeraImpressaoListaPostagem;
    procedure GeraMidiaSara;
  public
    { Public declarations }
  end;

var
  FrmGeraListaPostagem: TFrmGeraListaPostagem;
  filename, chosenDir, fname, destdir : string; // Diret�rio de Destino para salvar arquivos gerados

implementation

uses DmDados, DB, U_Func, U_FrmRelArSedexListaOL, IniFiles;

{$R *.dfm}

procedure TFrmGeraListaPostagem.BitBtnGerarClick(Sender: TObject);
  var i: integer;
Begin
  // Preenchimento do Per�odo para pesquisa � obrigat�rio
  if (CompareDate(DtPickerDtIni.Date, DtPickerDtFin.Date) > 0) then
    begin
      Application.MessageBox(PChar('A data final n�o pode ser inferior a data inicial.'),
          'ADS', MB_OK + MB_ICONERROR);
      Exit;
    end;

  // Obrigat�rio selecionar um Cart�o de Postagem ou Indicar um Lote
  if (CboPagante.KeyValue = null) AND (Trim(EdLote.Text) = '') then
    begin
      Application.MessageBox(PChar('Indique o Lote ou Selecione um Pagante.'),
              'ADS', MB_OK + MB_ICONERROR);
      EdLote.SetFocus;
      Exit;
    end;

  // checando se a informa��o de Lote est� v�lida
  if (Length(TRim(EdLote.Text)) > 0) AND not (TryStrToInt(EdLote.Text, i) ) then
        begin
          Application.MessageBox(PChar('N�mero de Lote inv�lido!'),
              'ADS', MB_OK + MB_ICONERROR);
          EdLote.SetFocus;
          Exit;
        end;

  // Caso tenha sido marcado para Gerar Arquivo...
  if CheckBoxGerar.Checked then
    begin
      try
        if (EdDirDestinoListagem.Text <> '') then
          destdir := chosenDir
        else
          destdir := GetCurrentDir;

        destdir := StringReplace(destdir + '\', '\\','\', [rfReplaceAll]) +
            UpperCase(FormatDateTime('yyyy\mmmm\dd', Date)) + '\';

        if (not DirectoryExists(destdir))
          AND (not SysUtils.ForceDirectories(destdir)) then
            raise Exception.CreateFmt('N�o foi poss�vel criar o diret�rio %s', [destdir]);

      Except on E : Exception do
        begin
          application.MessageBox(PChar(E.Message),
              'ADS', MB_OK + MB_ICONERROR);
          BtnAbrir.SetFocus;
          exit;
        end;
      end;
    
    end;

  With Dm do
    Begin
      // Verificando se h� registros para gerar a lista
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQl.Add('SELECT COUNT(t.sdx_numobj2) AS qt_regs, ');
      SqlAux1.SQL.Add('  SUM(t.sdx_peso) AS peso_total, ');
      SqlAux1.SQL.Add('  SUM(t.sdx_valdec) AS valdec_total, ');
      SqlAux1.SQL.Add('  MIN(t.sdx_numobj) AS obj_ini, ');
      SqlAux1.SQL.Add('  MAX(t.sdx_numobj) AS obj_fim ');
      SqlAux1.SQl.Add('FROM public.tbsdx_ect e ');
      SqlAux1.SQL.Add('  INNER JOIN public.tbsdxserv s ');
      SqlAux1.SQL.Add('      ON (e.tbsdxect_prod = s.tbsdxserv_prod) ');
      SqlAux1.SQL.Add('  INNER JOIN public.tbsdx02 t ');
      SqlAux1.SQL.Add('      ON (e.tbsdxect_sigla || e.tbsdxect_num || ' +
          'e.tbsdxect_dv || ''BR'' = t.sdx_numobj2) ');
      SqlAux1.SQL.Add('WHERE t.sdx_dtenvio BETWEEN :dtini AND :dtfim ');
      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfim').AsDate := DtPickerDtFin.Date;
      if (CboPagante.KeyValue <> null) then
        begin
          SqlAux1.SQL.Add('  AND s.tbsdxserv_prod = :prod');
          SqlAux1.ParamByName('prod').AsInteger := CboPagante.KeyValue;
        end;

      if (Length(TRim(EdLote.Text)) > 0) then
        begin
          SqlAux1.SQL.Add('  AND t.sdx_seqcarga = :lote');
          SqlAux1.ParamByName('lote').AsInteger := StrToInt64(EdLote.Text);
        end;

      SqlAux1.Open;

      if (SqlAux1.FieldByName('qt_regs').AsInteger > 0) then
        Begin
          // H� registros para gerar a listagem. Criando-a...

          // Inciando a consulta para gerar os itens da lista a ser impressa
          SqlSdx3.Close;
          SqlSdx3.SQL.Clear;
          //                                  0           1
          SqlSdx3.SQL.Add('SELECT DISTINCT sdx_numobj, sdx_paisorigem, ');
          //                    2           3           4           5
          SqlSdx3.SQL.Add('  sdx_cep, sdx_seqcarga, sdx_numobj1, sdx_peso, ');
          //                  6           7                8          9
          SqlSdx3.SQL.Add('  sdx_valdec, sdx_siglaobj, sdx_cmp, sdx_bas, ');
          //                     10       11            12          13                14
          SqlSdx3.SQL.Add('  sdx_alt, sdx_cobdest, sdx_numobj2, tbsdxserv_nrocto, ');
          //                    14                  15          16        17
          SqlSdx3.SQL.Add('  tbsdxserv_crtpst, sdx_nomdest, sdx_codcli, sdx_idcli, ');
          //                    18                19            20            21
          SqlSdx3.SQL.Add('  sdx_codoperacao, sdx_numobj3, sdx_endedest, sdx_cidade, ');
          //                    22        22          23              24
          SqlSdx3.SQL.Add('  sdx_uf, sdx_numseqarq, sdx_numseqreg, sdx_dtcarga, ');
          //                    25            26           27          28
          SqlSdx3.SQL.Add('  sdx_cepnet, sdx_numobj4, sdx_numobj5, sdx_valor, ');
          //                    29        30            31
          SqlSdx3.SQL.Add('  sdx_qtde, sdx_tvalor, e.tbsdxect_sigla ');
          SqlSdx3.SQl.Add('FROM public.tbsdx_ect e ');
          SqlSdx3.SQL.Add('  INNER JOIN public.tbsdxserv s ');
          SqlSdx3.SQL.Add('      ON (e.tbsdxect_prod = s.tbsdxserv_prod) ');
          SqlSdx3.SQL.Add('  INNER JOIN public.tbsdx02 t ');
          SqlSdx3.SQL.Add('      ON (e.tbsdxect_sigla || e.tbsdxect_num || ' +
              'e.tbsdxect_dv || ''BR'' = t.sdx_numobj2) ');
          SqlSdx3.SQL.Add('WHERE t.sdx_dtenvio BETWEEN :dtini AND :dtfim ');
          SqlSdx3.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
          SqlSdx3.ParamByName('dtfim').AsDate := DtPickerDtFin.Date;

          if (CboPagante.KeyValue <> null) then
            begin
              SqlSdx3.SQL.Add('  AND s.tbsdxserv_prod = :prod');
              SqlSdx3.ParamByName('prod').AsInteger := CboPagante.KeyValue;
            end;

          if (Length(TRim(EdLote.Text)) > 0) then
            begin
              SqlSdx3.SQL.Add('  AND t.sdx_seqcarga = :lote');
              SqlSdx3.ParamByName('lote').AsInteger := StrToInt64(EdLote.Text);
            end;

          SqlSdx3.SQL.Add('ORDER BY sdx_cep');
          SqlSdx3.Open;

          // Gerando o Relat�rio a ser impresso
          GeraImpressaoListaPostagem;

          // Requisitado Gera��o de arquivo de postagem
          if CheckBoxGerar.Checked then
            Begin
              Try
                // Mostrando o ProgressBar
                PanelProgressBar.Max :=  SqlSdx3.RecordCount * 3; // Ser�o 3 listas
                PanelProgressBar.Position := 0;
                PanelProgress.Visible := True;
                PanelProgress.Refresh;
                // Gerando Arquivo de M�dia para enviar via E-mail
                GeraMidiaSara;
                // Gerando o XLS
                XLSReport;
                // Aviso de que tudo saiu OK
                Application.MessageBox(
                  PChar('Gera��o de Arquivos efetuado com sucesso!' + #13#10 +
                    'Os seguintes arquivos foram gerados : ' + #13#10 +
                    '"' + filename + '" e "' + ChangeFileExt(filename, '.xls') +
                    '".'
                  ),  'ADS', MB_OK + MB_ICONINFORMATION);

              finally
                // Resetando e ocultando o Progress Bar
                PanelProgress.Caption := 'Executando a opera��o. Aguarde...';
                PanelProgress.Hide;
                PanelProgressBar.Position := 0;
              end;

            end; // End Gera��o de Arquivo Para envio aos correios
        end // End Com Resultados
      else
        Application.MessageBox(
            PChar('N�o H� Registros com os Parametros Informados'),
                    'ADS', MB_OK + MB_ICONERROR);
    end; // End With


End;

procedure TFrmGeraListaPostagem.BtnAbrirClick(Sender: TObject);
var Registro: TRegistry;
begin
  if SelectDirectory('Selecione o diret�rio de destino',
      chosenDir,
      chosenDir)  then
    Begin
      chosenDir := StringReplace(chosenDir + '\', '\\','\', [rfReplaceAll]);
      
      Registro := TRegistry.Create;
      Registro.RootKey := HKEY_CURRENT_USER;
      if Registro.OpenKey('ADS_ADSRESS', true) then
        // Verificando exist�ncia do diret�rio base
        Registro.WriteString('UltDirListaPostagem', chosenDir);
      EdDirDestinoListagem.Text := chosenDir;
    end;

end;

procedure TFrmGeraListaPostagem.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmGeraListaPostagem.CheckBoxGerarClick(Sender: TObject);
var st : Boolean;
begin
  st := CheckBoxGerar.Checked;
  LblDirDestino.Enabled := st;
  EdDirDestinoListagem.Enabled := st;
  BtnAbrir.Enabled := st;
end;

procedure TFrmGeraListaPostagem.AtualizaGridPostagem;
begin
  with Dm do
    begin
      SqlSdxServ.Close;
      SqlSdxServ.SQL.Clear;

      SqlSdxServ.SQL.Add('SELECT s.tbsdxserv_dsc, s.tbsdxserv_crtpst, s.tbsdxserv_sigla, ');
      SqlSdxServ.SQL.Add('  s.tbsdxserv_cod, s.tbsdxserv_prod, s.tbsdxserv_dtcad, ');
      SqlSdxServ.SQL.Add('  s.tbsdxserv_usu, s.tbsdxserv_nrocto, s.tbsdxserv_status, ');
      SqlSdxServ.SQL.Add('  s.tbsdxserv_txasrv, ');
      SqlSdxServ.SQL.Add('  COUNT(t.sdx_numobj2) AS qtobjs ');
      SqlSdxServ.SQL.Add('FROM public.tbsdx_ect e ');
      SqlSdxServ.SQL.Add('  INNER JOIN public.tbsdxserv s ');
      SqlSdxServ.SQL.Add('      ON (e.tbsdxect_prod = s.tbsdxserv_prod) ');
      SqlSdxServ.SQL.Add('  INNER JOIN public.tbsdx02 t ');
      SqlSdxServ.SQL.Add('      ON (e.tbsdxect_sigla || e.tbsdxect_num || ' +
          'e.tbsdxect_dv || ''BR'' = t.sdx_numobj2) ');
      SqlSdxServ.SQL.Add('WHERE t.sdx_dtenvio BETWEEN :dtini AND :dtfim ');
      SqlSdxServ.SQL.Add('GROUP BY   s.tbsdxserv_dsc,  s.tbsdxserv_crtpst, ');
      SqlSdxServ.SQL.Add('  s.tbsdxserv_sigla, s.tbsdxserv_cod, ');
      SqlSdxServ.SQL.Add('  s.tbsdxserv_dtcad, s.tbsdxserv_prod, s.tbsdxserv_dtcad,');
      SqlSdxServ.SQL.Add('  s.tbsdxserv_usu, s.tbsdxserv_nrocto, s.tbsdxserv_status,');
      SqlSdxServ.SQL.Add('  tbsdxserv_txasrv');
      SqlSdxServ.SQL.Add('HAVING COUNT(t.sdx_numobj2) > 0 ');
      SqlSdxServ.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlSdxServ.ParamByName('dtfim').AsDate := DtPickerDtFin.Date;

      SqlSdxServ.Open;
      CboPagante.Refresh;

      SqlSdx7.Close;
      SqlSdx7.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlSdx7.ParamByName('dtfim').AsDate := DtPickerDtFin.Date;
      SqlSdx7.Open;
      DBGridPostagem.Refresh;
  end;
end;

procedure TFrmGeraListaPostagem.DBGridPostagemCellClick(Column: TColumn);
begin
  With Dm Do
    begin
      DtPickerDtIni.DateTime := SqlSdx7mindt.Value;
      DtPickerDtFin.DateTime := SqlSdx7maxdt.Value;
      CboPagante.KeyValue := SqlSdx7tbsdxserv_prod.Value;
      EdLote.Text := IntToStr(SqlSdx7lote.Value);
    end;
end;

procedure TFrmGeraListaPostagem.DtPickerDtFinCloseUp(Sender: TObject);
begin
  AtualizaGridPostagem;
end;

procedure TFrmGeraListaPostagem.DtPickerDtFinUserInput(Sender: TObject;
  const UserString: string; var DateAndTime: TDateTime;
  var AllowChange: Boolean);
begin
  AtualizaGridPostagem;
end;

procedure TFrmGeraListaPostagem.DtPickerDtIniCloseUp(Sender: TObject);
begin
  AtualizaGridPostagem;
end;


procedure TFrmGeraListaPostagem.DtPickerDtIniUserInput(Sender: TObject;
  const UserString: string; var DateAndTime: TDateTime;
  var AllowChange: Boolean);
begin
  AtualizaGridPostagem;
end;

procedure TFrmGeraListaPostagem.FormShow(Sender: TObject);
var IniFile : TIniFile;
begin
  // Ajustando data de exibi��o
  DtPickerDtIni.Date := Date;
  DtPickerDtFin.Date := Date;
  AtualizaGridPostagem;

  // Recuperando o diret�rio usando anteriormente
  IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  chosenDir := iniFile.ReadString('Arquivos', 'Local', GetCurrentDir);

  EdDirDestinoListagem.Text := chosenDir;
end;

procedure TFrmGeraListaPostagem.ProgressBarStepItOne;
begin
  PanelProgressBar.StepBy(1);
  PanelProgressBar.StepBy(-1);
  PanelProgressBar.StepBy(1);
  PanelProgressBar.Update;
  PanelProgress.Refresh;
end;

{
  Gera um arquivo XLS para Controle
}
procedure TFrmGeraListaPostagem.XLSReport;
var
  XL : TDataSetToExcel;
  cab, f : String;
Begin
  PanelProgress.Caption := 'Criando Relat�rio de envios em XLS';
  With Dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add('SELECT DISTINCT t.sdx_siglaobj as "TIPO", ');
      SqlAux1.SQL.Add('  t.sdx_numobj2 as "N� Objeto", ');
      SqlAux1.SQL.Add('  SUBSTR(t.sdx_nomdest, 1, 4) AS "AG.", ');
      SqlAux1.SQL.Add('  SUBSTR(t.sdx_nomdest, 7, 40) AS "DESTINO", ') ;
      SqlAux1.SQL.Add('  t.sdx_endedest as "ENDERECO", t.sdx_cidade as "CIDADE",');
      SqlAux1.SQL.Add('  t.sdx_uf as "UF", t.sdx_cep as "CEP", ');
      SqlAux1.SQL.Add('  t.sdx_dtmov as "DATA ENVIO", ');
      SqlAux1.SQL.Add('  t.sdx_peso as "PESO" ');
      SqlAux1.SQl.Add('FROM public.tbsdx_ect e ');
      SqlAux1.SQL.Add('  INNER JOIN public.tbsdxserv s ');
      SqlAux1.SQL.Add('      ON (e.tbsdxect_prod = s.tbsdxserv_prod) ');
      SqlAux1.SQL.Add('  INNER JOIN public.tbsdx02 t ');
      SqlAux1.SQL.Add('      ON (e.tbsdxect_sigla || e.tbsdxect_num || ' +
              'e.tbsdxect_dv || ''BR'' = t.sdx_numobj2) ');
      SqlAux1.SQL.Add('WHERE t.sdx_dtenvio BETWEEN :dtini AND :dtfim ');
      SqlAux1.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlAux1.ParamByName('dtfim').AsDate := DtPickerDtFin.Date;

      if (CboPagante.KeyValue <> null) then
        begin
          SqlAux1.SQL.Add('  AND s.tbsdxserv_prod = :prod');
          SqlAux1.ParamByName('prod').AsInteger := CboPagante.KeyValue;
        end;

      if (Length(TRim(EdLote.Text)) > 0) then
        begin
          SqlAux1.SQL.Add('  AND t.sdx_seqcarga = :lote');
          SqlAux1.ParamByName('lote').AsInteger := StrToInt64(EdLote.Text);
        end;

      SqlAux1.SQL.Add('ORDER BY t.sdx_cep ');
      SqlAux1.Open;
      cab := 'LISTA DE POSTAGEM - CONTRATO ESPECIAL - SEDEX: ' +
          SqlSdxServtbsdxserv_crtpst.AsString + ' - ' +
        FormatDateTime('ddmmyyyy', DtPickerDtIni.Date ) + '.xls';

      f := ChangeFileExt(filename, '.xls');
      try
        SqlAux1.First;
        XL := TDataSetToExcel.Create(SqlAux1, destdir + f, cab);
        XL.WriteFile;
        XL.Free;
      Except
          application.MessageBox(PChar('Ocorreu um erro ao criar o arquivo "' + f + '".'),
          'ADS', MB_OK + MB_ICONERROR);
      end;

    end;
end;


procedure TFrmGeraListaPostagem.GeraArquivoPrevisao;
type
  TArqPrevDat = Record
    nome: string[15];
    diames : string[4];
    seq : Char;
    envio : TDateTime;
    qtde : Integer;
    remessa: Integer;
end;

var linha : String;
  regs, remessa, i : Integer;
  seq : Char;
  ArqPrevDat : TArqPrevDat;
  ArqReg : File of TArqPrevDat;
  arq : TextFile;

Begin
  PanelProgress.Caption := 'Gerando arquivo de Previs�o de Postagem';
  // Valores padr�o para quando o arquivo n�o � encontrado
  seq := '0';
  remessa :=  DayOfTheYear(Date) * (CurrentYear - 2014);
  try
    // Lendo informa��o do arquivo de Dados
    AssignFile(ArqReg, 'ads.dat');
    if not FileExists('ads.dat') then
      Rewrite(ArqReg)
    else
      Reset(ArqReg);

    regs :=  FileSize(ArqReg);
    if (regs > 0) then
      begin
        Seek(ArqReg, regs - 1);
        Read(ArqReg, ArqPrevDat);
        if (ArqPrevDat.diames = FormatDateTime('ddmm', Date)) then
          begin
            // Lendo o ultimo sequencial utilizado, incrementando-o e verificando
            seq := Chr((Ord(ArqPrevDat.seq) + 1));
            while not (seq in ['0'..'9','A'..'Z']) do
              seq := Chr(Ord(seq)+1);

            // Lendo o ultimo sequencial de arquivo utilizado e incrementando-o
            remessa := ArqPrevDat.remessa + 1;
          end;

      end;
  except on E: Exception do
    Begin
      Application.MessageBox(Pchar('N�o foi poss�vel encontrar a informa��o de ' +
          '�ltimo arquivo de Previs�o enviado.' + #13+#10+'Reiniciando o contador.'),
        'ADS', MB_OK + MB_ICONERROR);
      CloseFile(ArqReg);
    end;
  end;
  // Nome do arquivo de destino
  fname := Dm.SqlSdxServtbsdxserv_sigla.AsString + '1' +
                    FormatDateTime('ddmm', Date) + seq + '.SD1';

  try
    AssignFile(arq, destdir + fname);
    Rewrite(arq);

  except on E: Exception do
    Begin
      Application.MessageBox(Pchar('N�o foi poss�vel criar o arquivo ' +
          'de Previs�o de Postagem.' + #13+#10 +
          'Por favor informe o ocorrido para a �rea de T.I..'),
        'ADS', MB_OK + MB_ICONERROR);
      CloseFile(arq);
    end;

  end;
  // Iniciando a cria��o dos registros
  // ###### REGISTRO HEADER - IN�CIO
  linha := '8' + // Tipo de Registro - Header
        LPad(Dm.SqlSdxServtbsdxserv_prod.AsString, 4, '0') + // C�digo do Cliente
        LPad('0', 15, '0') + // Filler
        RPad(Dm.SqlSdxServtbsdxserv_dsc.AsString, 40, ' ') + // Nome do Cliente
        FormatDateTime('yyyymmdd', Date) + // Data Gera��o do arquivo
        LPad(IntToStr(Dm.SqlSdx3.RecordCount + 1), 6, '0') + // Quantidade de Registros do Arquivo incluindo o Header
        LPad('0', 94, '0') + // Filler
        Format('%.5d', [remessa]) + // N�mero de Remessa
        Format('%.7d', [1]); // Sequencial Inicial de Registro

  // Escrevendo o Header o arquivo
  WriteLn(arq, linha);
  // ###### REGISTRO HEADER - FIM

  // ##### REGISTRO DETALHE - INICIO
  With Dm do
    Begin
      // Reposicionando o ponteiro do cursor para o primeiro resultado
      SqlSdx3.First;
      i := 2; // Sequencial Registro Iniciando em 2
      While not SqlSdx3.Eof do
        Begin
          linha := '9' + // Tipo de Registro - Detalhe
                LPad(Dm.SqlSdxServtbsdxserv_prod.AsString, 4, '0') + // C�digo Cliente
                Dm.SqlSdxServtbsdxserv_sigla.AsString + // Identificador Cliente
                SqlSdx3.FieldByName('sdx_numobj2').AsString + // Sigla Objeto + Numero Objeto + Pais Origem
                '1101' + // C�digo da Opera��o (Vide Documento ARQUIVO_PREV_RET
                RPad(' ', 16, ' ') + // Campo Livre
                LPad(
                  ReplaceNonAscii(Trim(SqlSdx3.FieldByName('sdx_nomdest').AsString)),
                  40, ' ') + // Nome Destinat�rio
                copy(LPad(
                  ReplaceNonAscii(Trim(SqlSdx3.FieldByName('sdx_endedest').AsString)),
                  40, ' '), 1, 40) + // Endere�o Destinat�rio
                copy(LPad(
                  ReplaceNonAscii(Trim(SqlSdx3.FieldByName('sdx_cidade').AsString)),
                  30, ' '), 1, 40) + // Cidade Endere�o Destinat�rio
                Trim(SqlSdx3.FieldByName('sdx_uf').AsString) + // UF Endere�o Destinat�rio
                Trim(SqlSdx3.FieldByName('sdx_cep').AsString) + // CEP Endere�o Destinat�rio
                RPad('0', 8, '0') + // Campo Livre
                Format('%.5d', [remessa])  + // N�mero Remessa
                Format('%.7d', [i]); // Sequencial Registro
          i := i + 1;
          WriteLn(arq, linha);
          SqlSdx3.Next;
          ProgressBarStepItOne;
        end;
    end;
  // ##### REGISTRO DETALHE - FIM

  // Gerando um novo Registro para incluir no arquivo de Registros
  ArqPrevDat.nome := fname;
  ArqPrevDat.diames := FormatDateTime('ddmm', Date);
  ArqPrevDat.seq := seq;
  ArqPrevDat.envio := Date;
  ArqPrevDat.qtde := i;
  ArqPrevDat.remessa := remessa;
  Seek(ArqReg, Filesize(ArqReg));
  Write(ArqReg, ArqPrevDat);

  CloseFile(ArqReg);
  CloseFile(arq);
end;


procedure TFrmGeraListaPostagem.EnviaArquivoPrevisao;
var iniFile : TIniFile;
  IdFtp : TIdFTP;
begin
  IdFtp := TIdFTP.Create(Self);
  try
    PanelProgress.Caption := 'Enviando arquivos para o Correios';
    IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
    // Nome/IP do Servidor de destino dos arquivos
    IdFtp.Host := iniFile.ReadString('FTPCORREIOS', 'Host', '10.1.1.10');
    // Porta de conex�o ao FTP
    IdFtp.Port := iniFile.ReadInteger('FTPCORREIOS', 'Porta', 21);
    // Nome de usuario
    IdFtp.Username := iniFile.ReadString('FTPCORREIOS', 'Usuario', 'joe');
    // Senha de acesso
    IdFtp.Password := iniFile.ReadString('FTPCORREIOS', 'Senha', 'doe');
    // Tempo m�ximo de espera por uma conex�o
    IdFtp.ReadTimeout := iniFile.ReadInteger('FTPCORREIOS', 'Timeout', 5000);
  except
    raise Exception.Create('Erro ao ler informa��es do arquivo de configura��o!');
      iniFile.Free;
      exit;
  end;
   
  try
    IdFtp.Passive := true;
    // Conectando
    IdFtp.Connect;
    // Diret�rio de Destino para o arquivo
    IdFtp.ChangeDir(iniFile.ReadString('FTPCORREIOS', 'Destino', 'ENTRADA'));
    // Enviando o arquivo rec�m-criado
    IdFtp.Put(destdir + fname, fname, False);
    // Fechando a conex�o    
    IdFtp.Disconnect;  
  Except
    IdFtp.Free;
    ShowMessage('N�o foi poss�vel enviar os arquivos para o FTP destino!');    
  end;
  
end;


procedure TFrmGeraListaPostagem.GeraImpressaoListaPostagem;
begin
  // Criando o formul�rio de Listagem de Postagem
  Application.CreateForm(TFrmRelArSedexListaOL, FrmRelArSedexListaOL);

  // Definindo vari�veis de sum�rio para o relat�rio impresso
  FrmRelArSedexListaOl.pesoTotal := Dm.SqlAux1.FieldByName('peso_total').AsFloat;
  FrmRelArSedexListaOl.valDecTotal := Dm.SqlAux1.FieldByName('valdec_total').AsFloat;
  FrmRelArSedexListaOl.qtObjs := Dm.SqlAux1.FieldByName('qt_regs').AsInteger;
  FrmRelArSedexListaOl.objIni := Dm.SqlAux1.FieldByName('obj_ini').AsString;
  FrmRelArSedexListaOl.objfim := Dm.SqlAux1.FieldByName('obj_fim').AsString;

  FrmRelArSedexListaOL.RLReport1.PreviewModal;
  FrmRelArSedexListaOL.RLReport1.Destroy;
end;

procedure TFrmGeraListaPostagem.GeraMidiaSara;
var seq, i, comprimento, largura, altura : Integer;
  searchResult : TSearchRec;
  arq : TextFile; 
  linhabase, linha : String; 
begin
  PanelProgress.Caption := 'Criando arquivo de M�dia SARA';
  seq := 0;
  try
    // Nome do arquivo de destino
    // Pesquisando o diret�rio corrente para gerar arquivos �nicos
    if (FindFirst(destdir + '*_' + FormatDateTime('ddmmyy', Date) +
                      '_*.txt', faArchive, searchResult) = 0 ) then
      begin
        repeat
          // Extraindo o sequencial do arquivo
          i := LastDelimiter('_', searchResult.Name);
          if (TryStrToInt(copy(searchResult.Name, i, 3), i)) then
            seq := Max(i, seq);
        until FindNext(searchResult) <> 0;

        FindClose(searchResult);
      end;

    filename := Dm.SqlSdxServtbsdxserv_crtpst.AsString + '_' +
            FormatDateTime('ddmmyy', Date) + '_' +
            LPad(IntToStr(seq + 1), 3, '0') + '.txt';
    // Garantindo que n�o existe arquivo com a nomenclatura passada
    while FileExists(destdir + filename) do
      begin
        seq := seq + 1;
        filename := Dm.SqlSdxServtbsdxserv_crtpst.AsString + '_' +
                    FormatDateTime('ddmmyy', Date) + '_' +
                    LPad(IntToStr(seq + 1), 3, '0') + '.txt';

      end;

    AssignFile(arq, destdir + filename);

  except
    begin
      Application.MessageBox(PChar('N�o foi poss�vel utilizar o diret�rio'),
                      'ADS', MB_OK + MB_ICONERROR);
      exit;
    end;
  end; // End Try Except

  try
    Rewrite(arq);
  except
    begin
      Application.MessageBox(PChar('N�o foi poss�vel criar o arquivo de registros.'),
                     'ADS', MB_OK + MB_ICONERROR);
      exit;
    end;
  end; // End Try

  // Iniciando a gera��o dos arquivos
  // Iniciando a cria��o dos registros
  // Linha Base do Registro Detalhe, apenas com os placeholders
  // Ver documenta��o No arquivo LAYOUT LISTA POSTAGEM Sistema SARA - TXT

  linhabase := '3' + // Tipo de Registro (3 - Detalhe lista de Postagem)
      '0000000000000000000000' + // Filler
      '%s' + // N�mero do Contrato Placeholder
      '09036539' + // C�digo Administrativo do Cliente
      '%s' + // Cep do Destino Placeholder
      '40436' + // C�digo do Servi�o (SFI)
      '55' + // Grupo P�is (Brasil) Conforme Tabela Serv. Adic.
      '37' + // Cod Serv Adic 1 (Arquivo e Controle AR (Fac)) Conforme Tabela Serv. Adic.
      '19' + // Cod Serv Adic 2 (Ad Valorem)
      '00' + // Cod Serv Adic 3
      '%s' + // Valor Declarado Placeholder
      '00000000000' + // FILLER
      '%.9d' + // N�mero de Etiqueta Placeholder
      '%.5d' + // Peso Placeholder
      '0000000000000000000000000000000000000000000' + // FILLER
      '%s' + // N� Cart�o Postagem Placeholder
      '0000000' + // N�mero Nota Fiscal
      '%s' + // Sigla Servi�o Placeholder
      '%.5d' + // Comprimento Objeto Placeholder
      '%.5d' + // Largura Objeto Placeholder
      '%.5d' + // Altura Objeto Placeholder
      '%s' + // Valor Cobrar Destinatario Placeholder
      '%s' + // Nome Destinatario Placeholder
      '002' +  //C�digo Tipo Objto (01:Envelope, 02:Pacote, 03:Rolo)
      '00000'; // Di�metro do objeto
  With Dm do
    Begin
      // Reposicionando o ponteiro do cursor para o primeiro resultado
      SqlSdx3.First;
      While not SqlSdx3.Eof do
        Begin
          comprimento := Round(SqlSdx3.FieldByName('sdx_cmp').AsFloat * 100);
          if comprimento = 0 then
            comprimento := 16; // Comprimento m�nimo para efeito de c�lculo

          largura :=  Round(SqlSdx3.FieldByName('sdx_bas').ASFloat * 100);
          if largura = 0 then
            largura := 16; // largura m�nima

          altura := Round(SqlSdx3.FieldByName('sdx_alt').ASFloat * 100);
          if (altura = 0) then
            altura := 16; // Altura m�nima

          linha := Format(linhabase,
              [LPad(SqlSdx3.FieldByName('tbsdxserv_nrocto').AsString, 10, '0'), // N�mero do Contrato
                SqlSdx3.FieldByName('sdx_cep').AsString, // Cep do Destino
                LPad(
                    Format('%f', [SqlSdx3.FieldByName('sdx_valdec').AsFloat]),
                    8, '0'), // Valor Declarado
                SqlSdx3.FieldByName('sdx_numobj').AsInteger, // N�mero da Etiqueta (Num Objeto)
                Round(SqlSdx3.FieldByName('sdx_peso').AsFloat * 1000), // Peso (Armazenado em Kg e convertido para g)
                LPad(SqlSdx3.FieldByName('tbsdxserv_crtpst').AsString, 11, '0'), // Cart�o de Postagem
                SqlSdx3.FieldByName('tbsdxect_sigla').AsString, // Sigla do Servi�o
                comprimento, // Comprimento do Objeto em cm
                largura, // Largura do Objeto em cm
                altura, // Altura do Objeto em cm
                LPad(Format('%f', [SqlSdx3.FieldByName('sdx_valdec').AsFloat]),
                          8, '0'), // Valor a Cobrar do Destinat�rio
                copy(LPad(
                        ReplaceNonAscii(Trim(SqlSdx3.FieldByName('sdx_nomdest').AsString)), 
                        40, ' '), 
                  1, 40) // Nome do Destinat�rio
              ]);

          WriteLn(arq, linha);
          SqlSdx3.Next;
          ProgressBarStepItOne;

        End; // End While SqlSdx3.Eof

      //  Trailer do arquivo - Ver documenta��o do Layout
      linha := Format('9%.8d%s', [SqlSdx3.RecordCount + 1, LPad(' ', 129, ' ')]);
      WriteLn(arq, linha);
      CloseFile(Arq);
    end;     
end;

end.
