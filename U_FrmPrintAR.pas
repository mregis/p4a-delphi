unit U_FrmPrintAR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, DBCtrls, Buttons, ExtCtrls, Grids, DBGrids,
  DateUtils, Math;

type
  TFrmPrintAR = class(TForm)
    BtnFechar: TBitBtn;
    BtnImprime: TBitBtn;
    CboTpEtiqueta: TComboBox;
    DBMacroProd: TDBLookupComboBox;
    LabelProd: TLabel;
    GroupBoxPeridoCarga: TGroupBox;
    LabelDtIni: TLabel;
    DtPickerDtIni: TDateTimePicker;
    LabelDtFin: TLabel;
    DtPickerDtFin: TDateTimePicker;
    LabelTipo: TLabel;
    PanelProgressImpressao: TPanel;
    ProgressBarImpressao: TProgressBar;
    DBGridLotes: TDBGrid;
    EditObjeto: TEdit;
    LabelObjeto: TLabel;
    EditLotes: TEdit;
    LabelLote: TLabel;
    BitBtnReset: TBitBtn;
    procedure BitBtnResetClick(Sender: TObject);
    procedure DBMacroProdCloseUp(Sender: TObject);
    procedure DtPickerDtIniChange(Sender: TObject);
    procedure DBGridLotesKeyPress(Sender: TObject; var Key: Char);
    procedure BtnImprimeClick(Sender: TObject);
    procedure DBGridLotesCellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ProgressBarStepItOne;
  private
    procedure DbGridSelectItem;
    procedure DBGridRefreshListItens;
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FrmPrintAR: TFrmPrintAR;



implementation

uses DmDados, U_Func, ZDataset, DB;

{$R *.dfm}
{
  Imprimir etiquetas de AR
}
procedure TFrmPrintAR.BtnImprimeClick(Sender: TObject);
var s : String;
  lotes : TStringList;
  i: Integer;
  num_lote: Int64;
begin
  // ### VALIDAÇÃO 
  // A data é o único campo obrigatório
  if (CompareDate(DtPickerDtIni.Date, DtPickerDtFin.Date) > 0) then
    begin
      Application.MessageBox(Pchar('A data final não pode ser inferior a data inicial.'), 
          'Address - ADS', MB_OK + MB_ICONWARNING);
      DtPickerDtFin.SetFocus;
      exit;
    end;

  lotes := TStringList.Create;
  // Verificando se foi indicado um ou mais números de lotes
  if (EditLotes.Text <> '') then
        begin
          lotes.DelimitedText := EditLotes.Text;
          for i := 0 to lotes.Count - 1 do
            begin
              if TryStrToInt64(lotes.Strings[i], num_lote) = false then
                begin
                  Application.MessageBox(PChar(Format('O valor ''%s'' é inválido para um ' +
                      'Nº de Objeto!', [lotes.Strings[i]])), 'Address - ADS', MB_OK + MB_ICONWARNING);
                  EditLotes.SetFocus;
                  exit;
                end;
            end;

        end;

  // Verificar se há o que imprimir baseado nas opções do formulário
  With Dm do
    begin
      // Iniciando interação com o Banco
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
      SqlSdx3.SQL.Add('WHERE t.sdx_dtcarga BETWEEN :dt1 AND :dt2 ');
      SqlSdx3.ParamByName('dt1').AsDate := DtPickerDtIni.Date;
      SqlSdx3.ParamByName('dt2').AsDate := DtPickerDtFin.Date;
      // Verificando se foi selecionado um produto
      if (DBMacroProd.KeyValue <> null) then
        begin
          SqlSdx3.SQL.Add(' AND s.tbsdxserv_prod = :codproduto ');
          SqlSdx3.ParamByName('codproduto').AsInteger := DBMacroProd.KeyValue;
        end;
      // Verificando se foi indicado um ou mais números de lotes
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
        end;

      // Verificando se foi indicado um Nº de Objeto
      if (EditObjeto.Text <> '') then
        begin
          SqlSdx3.SQL.Add(' AND t.sdx_numobj2 = :num_obj'); // Abre 
          SqlSdx3.ParamByName('num_obj').AsString := EditObjeto.Text;   
        end;         

      // Antes de recuperar uma lista grande de resultados, convém
      // Avaliar se realmente há o que mostrar, economizando
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('SELECT COUNT(z.sdx_numobj2) as qt FROM (');
      SqlAux2.SQL.Add(SqlSdx3.SQL.GetText);      
      SqlAux2.SQL.Add(') z ');
      SqlAux2.Params := SqlSdx3.Params;
      SqlAux2.Open;
      i := SqlAux2.FieldByName('qt').AsInteger;
      if (i < 1) then
        begin
          Application.MessageBox(Pchar('Não há objetos a terem etiquetas impressas com os ' +
            'parâmetros informados!'), 'Address - ADS', MB_OK + MB_ICONWARNING);            
        end
      else
        begin
          ProgressBarImpressao.Max := Min(i, 2);
          ProgressBarImpressao.Position := 0;
          PanelProgressImpressao.Show;
          SqlSdx3.SQL.Add('ORDER BY t.sdx_nomdest ');
          SqlSdx3.Open;

          // Gerando o relatório de impressão
          s := ExtractFilePath(Application.ExeName);
          case CboTpEtiqueta.ItemIndex of
            0 :
              RvRelatorios.ProjectFile := s + 'RelatoriosAds.rav';

            1:
              RvRelatorios.ProjectFile := s + 'RelatoriosAds01.rav';

            2:  // Ar Digital
              RvRelatorios.ProjectFile := s + 'ARDigital.rav';

            else
              begin
                Application.MessageBox(Pchar('Ooops! Não foi selecionado o tipo de ' +
                    'etiqueta?'), 'Address - ADS', MB_OK + MB_ICONWARNING);
                CboTpEtiqueta.SetFocus;
              end;

          end;
          ProgressBarImpressao.Position := i div 2;
          RvRelatorios.ExecuteReport('RpSedexArOl');
          ProgressBarImpressao.Position := ProgressBarImpressao.Max;
          RvRelatorios.Close;
        end;

      lotes.Free;
    end;
  PanelProgressImpressao.Hide;
end;

procedure TFrmPrintAR.BitBtnResetClick(Sender: TObject);
begin
  DBMacroProd.KeyValue := null;
  EditLotes.Clear;
  EditObjeto.Clear;
  DBMacroProd.Refresh;
  DBGridRefreshListItens;
end;

procedure TFrmPrintAR.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPrintAR.DBGridLotesCellClick(Column: TColumn);
begin
  DbGridSelectItem;  
end;

procedure TFrmPrintAR.DBGridLotesKeyPress(Sender: TObject; var Key: Char);
begin
  DbGridSelectItem;
end;

procedure TFrmPrintAR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with Dm do
    begin
      SqlAux1.Close;
      SqlAux2.Close;
      SqlSdx6.Close;
    end;

  Action := Cafree;
end;

procedure TFrmPrintAR.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    SelectNext(ActiveControl, True, True);
end;

procedure TFrmPrintAR.DbGridSelectItem;
begin
    with Dm do
      if (SqlSdx6Lote.Value > 0) then
        begin
          DtPickerDtIni.Date := SqlSdx6Dtini.Value;
          DtPickerDtFin.Date := SqlSdx6Dtfin.Value;
          DBMacroProd.KeyValue := SqlSdx6CodProduto.Value;
          EditLotes.Text := IntToStr(SqlSdx6Lote.Value);
        end;
end;

procedure TFrmPrintAR.DBGridRefreshListItens;
begin
  With Dm do
    begin
      SqlSdx6.Close;
      SqlSdx6.SQL.Clear;
      SqlSdx6.SQL.Add('SELECT sdx02.sdx_seqcarga AS lote, ');
      SqlSdx6.SQL.Add('  serv.tbsdxserv_prod AS codproduto, serv.tbsdxserv_dsc as produto, ');
      SqlSdx6.SQL.Add('  COUNT(*) as qtitens, ');
      SqlSdx6.SQL.Add('  MIN(sdx02.sdx_dtcarga) AS dtini, ');
      SqlSdx6.SQL.Add('  MAX(sdx02.sdx_dtcarga) AS dtfin ');
      SqlSdx6.SQL.Add('FROM tbsdx02 sdx02 ');
      SqlSdx6.SQL.Add('  INNER JOIN public.tbsdx_ect e ON (sdx02.sdx_numobj2 = e.tbsdxect_sigla || e.tbsdxect_num || e.tbsdxect_dv || ''BR'') ');
      SqlSdx6.SQL.Add('  INNER JOIN public.tbsdxserv serv ON (e.tbsdxect_prod = serv.tbsdxserv_prod) ');
      SqlSdx6.SQL.Add('WHERE sdx02.sdx_dtcarga BETWEEN :dtini AND :dtfin ');
      if (DBMacroProd.KeyValue <> null) and (DBMacroProd.KeyValue > 0) then
        begin
          SqlSdx6.SQL.Add('    AND serv.tbsdxserv_prod = :prod');
          SqlSdx6.ParamByName('prod').AsInteger := DBMacroProd.KeyValue;
        end;
      SqlSdx6.SQL.Add('GROUP BY 1, 2, 3 ');
      SqlSdx6.SQL.Add('ORDER BY 6 DESC, sdx_seqcarga DESC');
      SqlSdx6.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlSdx6.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
      SqlSdx6.Open;
      DBGridLotes.Refresh;
    end;
end;

procedure TFrmPrintAR.DBMacroProdCloseUp(Sender: TObject);
begin
  DBGridRefreshListItens;
end;

procedure TFrmPrintAR.DtPickerDtIniChange(Sender: TObject);
begin
  with Dm do
    begin
      SqlSdx6.Close;
      SqlSdx6.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlSdx6.ParamByName('dtfin').AsDate := DtPickerDtFin.Date;
      SqlSdx6.Open;
      SqlSdx6.Refresh;
      DBGridLotes.Refresh;
    end;
end;

procedure TFrmPrintAR.FormShow(Sender: TObject);
begin
  with Dm do
    begin
      SqlSdxServ.Close;
      SqlSdxServ.SQL.Clear;
      SqlSdxServ.SQL.Add('SELECT * FROM public.tbsdxserv t ');
      SqlSdxServ.SQL.Add('WHERE t.tbsdxserv_status = 1 ');
      SqlSdxServ.Open;

      SqlSdx6.Close;
      SqlSdx6.ParamByName('dtini').AsDate := Date;
      SqlSdx6.ParamByName('dtfin').AsDate := Date;
      SqlSdx6.Open;
    end;
    DBMacroProd.Refresh;
    DBGridLotes.Refresh;
    // Ajustando data de exibição
    DtPickerDtIni.Date := Date;
    DtPickerDtFin.Date := Date;
end;

{ Método que incrementa a Barra de Progresso }
procedure TFrmPrintAR.ProgressBarStepItOne;
begin
  ProgressBarImpressao.StepBy(1);
  ProgressBarImpressao.StepBy(-1);
  ProgressBarImpressao.StepBy(1);
  ProgressBarImpressao.Update;
  ProgressBarImpressao.Refresh;
end;

end.
