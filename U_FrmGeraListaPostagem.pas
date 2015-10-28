unit U_FrmGeraListaPostagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, ComCtrls, Grids, DBGrids, ExtCtrls, FileCtrl;

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
    EditLotes: TEdit;
    LabelLote: TLabel;
    PanelProgress: TPanel;
    ProgBar: TProgressBar;
    BtnFechar: TBitBtn;
    BtnAbrir: TBitBtn;
    EdDirDestinoListagem: TEdit;
    Label1: TLabel;
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
    procedure AtualizaGridPostagem;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGeraListaPostagem: TFrmGeraListaPostagem;

implementation

uses DmDados, DB, U_Func;

{$R *.dfm}

procedure TFrmGeraListaPostagem.BitBtnGerarClick(Sender: TObject);

var i : Integer;
  filename, linha, linhabase : String;
  arq : TextFile;
Begin
  if ((EdDirDestinoListagem.Text = '') OR
      (not DirectoryExists(EdDirDestinoListagem.Text))) then
    begin
      application.MessageBox(
          PChar('Não foi indicado o diretório de destino para salvar a listagem!'),
              'ADS', MB_OK + MB_ICONERROR);
      BtnAbrir.SetFocus;
      exit;
    end;
  
  With dm do
    Begin
      // Verificando se há registros para gerar a lista
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQl.Add('SELECT COUNT(t.sdx_numobj2) AS qt_regs');
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

      if (Length(TRim(EditLotes.Text)) > 0) then
        begin
          SqlAux1.SQL.Add('  AND t.sdx_seqcarga = :lote');
          SqlAux1.ParamByName('lote').AsInteger := StrToInt64(EditLotes.Text);
        end;

      SqlAux1.Open;

      if (SqlAux1.FieldByName('qt_regs').AsInteger > 0) then
        // Há registros para gerar o arquivo. Criando-o...
        Begin
          try
            // Nome do arquivo de destino
            filename := 'RT'
                + SqlSdxServtbsdxserv_sigla.AsString +
                FormatDateTime('ddmm', Date) + '.txt';
            // Verificando se já existe arquivo com a nomenclatura
            if FileExists(EdDirDestinoListagem.Text + filename) then
              begin
                i := MessageDlg('Já existe um arquivo com a data de hoje e com a '+
                    'Sigla ' + SqlSdxServtbsdxserv_sigla.AsString +
                    ' no diretório escolhido.' + #13#10 +
                    'Deseja sobrescrever o arquivo existente?', mtWarning,
                    [mbYes, mbNo, mbCancel], 0);
                if (i = mrNo) then
                  begin
                    i := 2;
                    while FileExists(EdDirDestinoListagem.Text + filename) do
                      begin
                        filename := 'RT'
                            + SqlSdxServtbsdxserv_sigla.AsString +
                            FormatDateTime('ddmm', Date) + IntToStr(i) + '.txt';
                        i := i + 1;
                      end;

                    Application.MessageBox(PChar('Será criado o arquivo ' +
                      filename), 'ADS', 0);

                  end
                else if (i = mrCancel) then
                  exit;

              end;
            AssignFile(arq, EdDirDestinoListagem.Text + filename);
          except
            begin
              Application.MessageBox(PChar('Não foi possível utilizar o diretório'), 'ADS',0);
              exit;
            end;
          end;

          try
            Rewrite(arq);
          except
            begin
              Application.MessageBox(PChar('Não foi possível criar o arquivo de registros.'), 'ADS', 0);
              exit;
            end;
          end;

          SqlAux2.Close;
          SqlAux2.SQL.Clear;
          //                                  0           1
          SqlAux2.SQL.Add('SELECT DISTINCT sdx_numobj, sdx_paisorigem, ');
          //                    2           3           4           5
          SqlAux2.SQL.Add('  sdx_cep, sdx_seqcarga, sdx_numobj1, sdx_peso, ');
          //                  6           7                8          9
          SqlAux2.SQL.Add('  sdx_valdec, sdx_siglaobj, sdx_cmp, sdx_bas, ');
          //                     10       11            12          13                14
          SqlAux2.SQL.Add('  sdx_alt, sdx_cobdest, sdx_numobj2, tbsdxserv_nrocto, ');
          //                    14                  15
          SqlAux2.SQL.Add('  tbsdxserv_crtpst, sdx_nomdest');
          SqlAux2.SQl.Add('FROM public.tbsdx_ect e ');
          SqlAux2.SQL.Add('  INNER JOIN public.tbsdxserv s ');
          SqlAux2.SQL.Add('      ON (e.tbsdxect_prod = s.tbsdxserv_prod) ');
          SqlAux2.SQL.Add('  INNER JOIN public.tbsdx02 t ');
          SqlAux2.SQL.Add('      ON (e.tbsdxect_sigla || e.tbsdxect_num || ' +
              'e.tbsdxect_dv || ''BR'' = t.sdx_numobj2) ');
          SqlAux2.SQL.Add('WHERE t.sdx_dtenvio BETWEEN :dtini AND :dtfim ');
          SqlAux2.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
          SqlAux2.ParamByName('dtfim').AsDate := DtPickerDtFin.Date;

          if (CboPagante.KeyValue <> null) then
            begin
              SqlAux2.SQL.Add('  AND s.tbsdxserv_prod = :prod');
              SqlAux2.ParamByName('prod').AsInteger := CboPagante.KeyValue;
            end;

          if (Length(TRim(EditLotes.Text)) > 0) then
            begin
              SqlAux2.SQL.Add('  AND t.sdx_seqcarga = :lote');
              SqlAux2.ParamByName('lote').AsInteger := StrToInt64(EditLotes.Text);
            end;

          SqlAux2.SQL.Add('ORDER BY sdx_cep');
          SqlAux2.Open;
          SqlAux2.First;
          ProgBar.Max :=  SqlAux2.RecordCount;
          ProgBar.Position  := 1;
          ProgBar.Refresh;
          // Iniciando a criação dos registros
          // Linha Base do Registro Detalhe, apenas com os placeholders
          // Ver documentação No arquivo LAYOUT LISTA POSTAGEM Sistema SARA - TXT

          linhabase := '3' + // Tipo de Registro (3 - Detalhe lista de Postagem)
              '0000000000000000000000' + // Filler
              '%s' + // Número do Contrato Placeholder
              '09036539' + // Código Administrativo do Cliente
              '%s' + // Cep do Destino Placeholder
              '40436' + // Código do Serviço (SFI)
              '55' + // Grupo Páis (Brasil) Conforme Tabela Serv. Adic.
              '37' + // Cod Serv Adic 1 (Arquivo e Controle AR (Fac)) Conforme Tabela Serv. Adic.
              '19' + // Cod Serv Adic 2 (Ad Valorem)
              '00' + // Cod Serv Adic 3
              '%s' + // Valor Declarado Placeholder
              '00000000000' + // FILLER
              '%.9d' + // Número de Etiqueta Placeholder
              '%.5d' + // Peso Placeholder
              '0000000000000000000000000000000000000000000' + // FILLER
              '%s' + // Nº Cartão Postagem Placeholder
              '0000000' + // Número Nota Fiscal
              '%s' + // Sigla Serviço Placeholder
              '%.5d' + // Comprimento Objeto Placeholder
              '%.5d' + // Largura Objeto Placeholder
              '%.5d' + // Altura Objeto Placeholder
              '%s' + // Valor Cobrar Destinatario Placeholder
              '%s' + // Nome Destinatario Placeholder
              '002' +  //Código Tipo Objto (01:Envelope, 02:Pacote, 03:Rolo)
              '00000'; // Diâmetro do objeto
          While not SqlAux2.Eof do
            Begin
              linha := Format(linhabase,
                  [LPad(SqlAux2.FieldByName('tbsdxserv_nrocto').AsString, 10, '0'), // Número do Contrato
                   SqlAux2.FieldByName('sdx_cep').AsString, // Cep do Destino
                   LPad(
                      Format('%f', [SqlAux2.FieldByName('sdx_valdec').AsFloat]),
                      8, '0'), // Valor Declarado
                   SqlAux2.FieldByName('sdx_numobj').AsInteger, // Número da Etiqueta (Num Objeto)
                   Round(SqlAux2.FieldByName('sdx_peso').AsFloat * 1000), // Peso (Armazenado em Kg e convertido para g)
                   LPad(SqlAux2.FieldByName('tbsdxserv_crtpst').AsString, 11, '0'), // Cartão de Postagem
                   SqlAux2.FieldByName('sdx_siglaobj').AsString, // Sigla do Serviço
                   Round(SqlAux2.FieldByName('sdx_cmp').ASFloat * 100), // Comprimento do Objeto em cm
                   Round(SqlAux2.FieldByName('sdx_bas').ASFloat * 100), // Largura do Objeto em cm
                   Round(SqlAux2.FieldByName('sdx_alt').ASFloat * 100), // Altura do Objeto em cm
                   LPad(
                      Format('%f', [SqlAux2.FieldByName('sdx_valdec').AsFloat]),
                      8, '0'), // Valor a Cobrar do Destinatário
                   LPad(Trim(SqlAux2.FieldByName('sdx_nomdest').AsString), 40, ' ') // Nome do Destinatário
                  ]);

                  WriteLn(arq, linha);
                  SqlAux2.Next;
                  ProgBar.StepIt;
                  ProgBar.Refresh;
                End;
              // Trailer do arquivo - Ver documentação do Layout
              linha := Format('9%.8d%s', [SqlAux2.RecordCount+1, LPad(' ', 129, ' ')]);
              WriteLn(arq, linha);
              CloseFile(Arq);
              Application.MessageBox(
                PChar('Arquivo ' + filename + ' Gerado com Sucesso!'),
                'ADS', 0);
            end
      else
        Application.MessageBox(
            PChar('Não Há Registros com os Parametros Informados'),
            'ADS', 0);
    end;

End;

procedure TFrmGeraListaPostagem.BtnAbrirClick(Sender: TObject);
var chosenDir : string;

begin
  if SelectDirectory('Selecione o diretório de destino',
      'O:\sedex_ar\retorno\',
      chosenDir)  then
      EdDirDestinoListagem.Text := chosenDir;

end;

procedure TFrmGeraListaPostagem.BtnFecharClick(Sender: TObject);
begin
  Close;
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
      SqlSdxServ.SQL.Add('  tbsdxserv_txasrv, t.sdx_dtenvio ');
      SqlSdxServ.SQL.Add('HAVING COUNT(t.sdx_numobj2) > 0 ');
      SqlSdxServ.SQL.Add('ORDER BY t.sdx_dtenvio DESC ');
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
      EditLotes.Text := IntToStr(SqlSdx7lote.Value);
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
begin
  // Ajustando data de exibição
  DtPickerDtIni.Date := Date;
  DtPickerDtFin.Date := Date;
  AtualizaGridPostagem;
end;

end.
