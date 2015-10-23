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
    SDListaPostagem: TSaveDialog;
    EditLotes: TEdit;
    LabelLote: TLabel;
    PanelProgress: TPanel;
    ProgBar: TProgressBar;
    BtnImprime: TBitBtn;
    BtnFechar: TBitBtn;
    OpenDialogPostagem: TOpenDialog;
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnImprimeClick(Sender: TObject);
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

var i, seqreg : integer;
  s, linha : String;
  arq : TextFile;
Begin
 i := 0;

  With dm do
    Begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQl.Add('SELECT COUNT(t.sdx_numobj2) AS qt_regs');
            SqlSdxServ.SQL.Add('FROM public.tbsdx_ect e ');
      SqlAux1.SQL.Add('  INNER JOIN public.tbsdxserv s ');
      SqlAux1.SQL.Add('      ON (e.tbsdxect_prod = s.tbsdxserv_prod) ');
      SqlAux1.SQL.Add('  INNER JOIN public.tbsdx02 t ');
      SqlAux1.SQL.Add('      ON (e.tbsdxect_sigla || e.tbsdxect_num || ' +
          'e.tbsdxect_dv || ''BR'' = t.sdx_numobj2) ');
      SqlAux1.SQL.Add('WHERE t.sdx_dtcarga BETWEEN :dtini AND :dtfim ');
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
            SDListaPostagem.InitialDir := 'O:\sedex_ar\retorno\';
            SDListaPostagem.FileName := 'RT' + SqlSdxServtbsdxserv_sigla.AsString +
                FormatDateTime('ddmm', Date) + '.txt';

            if (not SDListaPostagem.Execute) then
              begin
                ShowMessage('Não foi selecionado o diretório de destino. ' +
                        'O processo será abortado!');
                exit;
              end;

          except
            begin
              Application.MessageBox(PChar('Não foi possível utilizar o diretório'),'ADS',0);
              exit;
            end;
          end;
            AssignFile(arq, SDListaPostagem.FileName);

          try
            Rewrite(arq);
          except
            begin
              Application.MessageBox(PChar('Não foi possível criar o arquivo de registros.'), 'ADS', 0);
              Application.MessageBox(PChar('Sua Nova Sequência é: ' +
              IntToStr(i) + ' e ' ), 'ADS', 0);
              exit;
            end;
          end;

              SqlAux2.Close;
              SqlAux2.SQL.Clear;
              //                                  0           1
              SqlAux2.SQL.Add('SELECT DISTINCT sdx_numobj, sdx_paisorigem, ');
              //                  2           3           4           5
              SqlAux2.SQL.Add('sdx_cep, sdx_seqcarga, sdx_numobj1, sdx_peso, ');
              //                6           7                8          9
              SqlAux2.SQL.Add('sdx_valdec, sdx_siglaobj, sdx_cmp, sdx_bas, ');
              //                   10       11            12          13                14
              SqlAux2.SQL.Add('sdx_alt, sdx_cobdest, sdx_numobj2, tbsdxserv_nrocto, tbsdxserv_crtpst ');
              SqlAux2.SQL.Add('FROM public.tbsdx02 t ');
              SqlAux2.SQL.Add('    INNER JOIN public.tbsdx_ect e ON (t.sdx_numobj = CAST(e.tbsdxect_num || e.tbsdxect_dv AS INTEGER)) ');
              SqlAux2.SQL.Add('    INNER JOIN public.tbsdxserv s ON (e.tbsdxect_prod = s.tbsdxserv_prod) ');
              SqlAux2.SQL.Add('WHERE s.tbsdxserv_prod = :codproduto ');
              SqlAux2.SQL.Add('    AND t.sdx_dtenvio between :dtini AND :dtfin ');


              SqlAux2.ParamByName('codproduto').AsInteger := CboPagante.KeyValue;
              SqlAux2.ParamByName('dtini').AsString :=  FormatDateTime('yyyy-mm-dd', DtPickerDtIni.Date);
              SqlAux2.ParamByName('dtfin').AsString :=  FormatDateTime('yyyy-mm-dd', DtPickerDtFin.Date);
              SqlAux2.SQL.Add('ORDER BY sdx_cep');



              SqlAux2.Open;
              SqlAux2.First;
              seqreg := 2;
              ProgBar.Max :=  SqlAux2.RecordCount;
              ProgBar.Position  := 1;
              ProgBar.Refresh;
              While not SqlAux2.Eof do
                Begin
                  linha := '3' + '00' + '0000';
                  linha := linha + '0000';//FormatDateTime('ddmm',Date);
                  linha := linha + '00000000';//'72618060';
                  linha := linha + '0000';//FormatDateTime('ddmm',Date);
                  linha := linha + GeraNt(SqlSdxServtbsdxserv_nrocto.AsString,10);
                  linha := linha + '09036539';   //codigo administrativo
                  linha := linha + SqlAux2.Fields[2].AsString;//cep do destino
                  linha := linha + '40436';//codigo do servico (SFI)
                  linha := linha + '55'; // grupo pais fixo cod pais
                  linha := linha + '01' + '00' + '00';// Filler - Cód Serviço 1 2 e 3  fixo
                  linha := linha + GeraNT(RestauraInteger(FormatFloat('#####0.00', SqlAux2.Fields[6].AsFloat)), 8);  //valor declarado
                  linha := linha + GeraNt('0', 9); // Filler - Cod Embalagem
                  linha := linha + GeraNt('0', 2);// Filler - Qt Embalagem
                  linha := linha + GeraNT(SqlAux2.Fields[0].AsString, 9);
                  linha := linha + GeraNt(RestauraInteger(FormatFloat('00.000', SqlAux2.Fields[5].AsFloat)), 5);
                  linha := linha + GeraNt('0', 8); // filler - Valor a Pagar
                  linha := linha + '00'; // Filler - Seq Folha
                  linha := linha + '00'; // Filler - Seq Lancamentos
                  linha := linha + '00000000'; // filler - Data Processamento
                  linha := linha + '000'; // Filler - Remessa
                  linha := linha + '  '; // Filler
                  linha := linha + GeraNt('0', 8); // Filler - Unidade Prestadora
                  linha := linha + GeraNt('0', 8);// Filler -  FormatDateTime('ddmmyyyy',Date);
                  linha := linha + '00';//Filler - Qtde. Doc no Lote
                  linha := linha + GeraNt(SqlSdxServtbsdxserv_crtpst.AsString, 11); // Nro do Cartão de Postagem houve erro para  pegar o ultimo digito do campo
                  linha := linha + GeraNt('0',7); // Filler - Numero nota fiscal
                  linha := linha + copy(SqlAux2.Fields[12].AsString, 1, 2);// 'SL'; // Filler - Fixo SIGLA DO SERVIÇO
                  linha := linha + GeraNT(SqlAux2.Fields[8].AsString, 5);//  linha := linha+GeraNt('0',5); // Compr do Obj
                  linha := linha + GeraNT(SqlAux2.Fields[9].AsString, 5);//  linha := linha+GeraNt('0',5); // Larg do Obj
                  linha := linha + GeraNT(SqlAux2.Fields[10].AsString, 5);//  linha := linha+GeraNt('0',5); // Altura do Obj
                  linha := linha + GeraNT(RestauraInteger(SqlAux2.Fields[6].AsString), 8);  //valor a cobrar do destinatário
                  WriteLn(arq, linha);
                  seqreg := seqreg + 1;
                  SqlAux2.Next;
                  ProgBar.Position  :=  ProgBar.Position + 1;
                  ProgBar.Refresh;
                End;

              linha := '9';
              linha := linha + GeraNt(IntToStr(seqreg), 8); //Qtde Registros
              GeraArquivo(' ', 129);
              WriteLn(arq, linha);
              CloseFile(Arq);
              Application.MessageBox(
                PChar('Arquivo Gerado com Sucesso!'),
                'ADS', 0);
            end
      else
        Application.MessageBox(
            PChar('Não Há Registros com os Parametros Informados'),
            'ADS', 0);
    end;

End;

procedure TFrmGeraListaPostagem.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmGeraListaPostagem.BtnImprimeClick(Sender: TObject);
var root, dir: String;
begin
  root := GetCurrentDir();
  dir := '';
if (not SelectDirectory('Selecione o diretório de destino.', root, dir, [])) then
  begin
    ShowMessage('Não foi selecionado o diretório de destino. ' +
                        'O processo será abortado!');
    exit;
  end;



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
      SqlSdxServ.SQL.Add('WHERE t.sdx_dtcarga BETWEEN :dtini AND :dtfim ');
      SqlSdxServ.SQL.Add('GROUP BY   s.tbsdxserv_dsc,  s.tbsdxserv_crtpst, ');
      SqlSdxServ.SQL.Add('  s.tbsdxserv_sigla, s.tbsdxserv_cod, ');
      SqlSdxServ.SQL.Add('  s.tbsdxserv_dtcad, s.tbsdxserv_prod, s.tbsdxserv_dtcad,');
      SqlSdxServ.SQL.Add('  s.tbsdxserv_usu, s.tbsdxserv_nrocto, s.tbsdxserv_status,');
      SqlSdxServ.SQL.Add('  tbsdxserv_txasrv ');
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
