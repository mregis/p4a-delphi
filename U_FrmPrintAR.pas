unit U_FrmPrintAR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, 
  DateUtils;

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
    PanelProgress: TPanel;
    ProgressBar1: TProgressBar;
    DBGridLotes: TDBGrid;
    EditObjeto: TEdit;
    LabelObjeto: TLabel;
    EditLotes: TEdit;
    LabelLote: TLabel;
    procedure DBGridLotesKeyPress(Sender: TObject; var Key: Char);
    procedure BtnImprimeClick(Sender: TObject);
    procedure DBGridLotesCellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    procedure DbGridSelectItem;
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
  // ### VALIDA��O 
  // A data � o �nico campo obrigat�rio
  if (CompareDate(DtPickerDtIni.Date, DtPickerDtFin.Date) > 0) then
    begin
      Application.MessageBox(Pchar('A data final n�o pode ser inferior a data inicial.'), 
          'Address - ADS', MB_OK + MB_ICONWARNING);
      DtPickerDtFin.SetFocus;
      exit;
    end;

  lotes := TStringList.Create;
  // Verificando se foi indicado um ou mais n�meros de lotes
  if (EditLotes.Text <> '') then
        begin
          lotes.DelimitedText := EditLotes.Text;
          for i := 0 to lotes.Count - 1 do
            begin
              if TryStrToInt64(lotes.Strings[i], num_lote) = false then
                begin
                  Application.MessageBox(PChar(Format('O valor ''%s'' � inv�lido para um ' +
                      'N� de Objeto!', [lotes.Strings[i]])), 'Address - ADS', MB_OK + MB_ICONWARNING);
                  EditLotes.SetFocus;
                  exit;
                end;
            end;

        end;

  // Verificar se h� o que imprimir baseado nas op��es do formul�rio
  With Dm do
    begin
      // Iniciando intera��o com o Banco
      SqlSdx3.Close;
      SqlSdx3.SQL.Clear;
      SqlSdx3.SQL.Add('SELECT t.sdx_codcli, t.sdx_idcli, t.sdx_siglaobj, t.sdx_numobj,');
      SqlSdx3.SQL.Add('  t.sdx_paisorigem, t.sdx_codoperacao, t.sdx_numobj3, t.sdx_nomdest,');
      SqlSdx3.SQL.Add('  t.sdx_endedest, t.sdx_cidade, t.sdx_uf, t.sdx_cep, t.sdx_numseqarq,');
      SqlSdx3.SQL.Add('  t.sdx_numseqreg, t.sdx_dtcarga, t.sdx_seqcarga, t.sdx_numobj2, ');
      SqlSdx3.SQL.Add('  t.sdx_cepnet, t.sdx_numobj1, t.sdx_numobj4, t.sdx_numobj5, ');
      SqlSdx3.SQL.Add('  t.sdx_peso, t.sdx_valor, t.sdx_qtde, t.sdx_tvalor, t.sdx_valdec, ');
      SqlSdx3.SQL.Add('  s.tbsdxserv_nrocto, s.tbsdxserv_crtpst ');
      SqlSdx3.SQL.Add('FROM public.tbsdx02 t ');
      SqlSdx3.SQL.Add('    INNER JOIN public.tbsdxserv s ON (t.sdx_siglaobj = s.tbsdxserv_sigla) ');
      
      // A data � o �nico campo obrigat�rio
      SqlSdx3.SQL.Add('WHERE t.sdx_dtcarga BETWEEN :dt1 AND :dt2 ');
      SqlSdx3.ParamByName('dt1').AsDate := DtPickerDtIni.Date;
      SqlSdx3.ParamByName('dt2').AsDate := DtPickerDtFin.Date;      
      // Verificando se foi selecionado um produto
      if (DBMacroProd.KeyValue <> null) then
        begin
          SqlSdx3.SQL.Add(' AND s.tbsdxserv_prod = :codproduto ');
          SqlSdx3.ParamByName('codproduto').AsInteger := DBMacroProd.KeyValue;
        end;
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
        end;

      // Verificando se foi indicado um N� de Objeto
      if (EditObjeto.Text <> '') then
        begin
          SqlSdx3.SQL.Add(' AND t.sdx_numobj2 = :num_obj'); // Abre 
          SqlSdx3.ParamByName('num_obj').AsString := EditObjeto.Text;   
        end;         

      // Antes de recuperar uma lista grande de resultados, conv�m
      // Avaliar se realmente h� o que mostrar, economizando
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('SELECT COUNT(z.sdx_numobj2) as qt FROM (');
      SqlAux2.SQL.Add(SqlSdx3.SQL.GetText);      
      SqlAux2.SQL.Add(') z ');
      SqlAux2.Params := SqlSdx3.Params;
      s := SqlAux2.SQL.GetText;
      SqlAux2.Open;
      i := SqlAux2.FieldByName('qt').AsInteger;
      if (i < 1) then
        begin
          Application.MessageBox(Pchar('N�o h� objetos a terem etiquetas impressas com os ' +
            'par�metros informados!'), 'Address - ADS', MB_OK + MB_ICONWARNING);            
        end
      else
        begin
          SqlSdx3.SQL.Add('ORDER BY t.sdx_nomdest ');
          SqlSdx3.Open; 

          // Gerando o relat�rio de impress�o
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
                Application.MessageBox(Pchar('Ooops! N�o foi selecionado o tipo de ' +
                    'etiqueta?'), 'Address - ADS', MB_OK + MB_ICONWARNING);
                CboTpEtiqueta.SetFocus;
              end;
               
          end;         
          RvRelatorios.ExecuteReport('RpSedexArOl');
          RvRelatorios.Close;
          
        end;

      lotes.Free;
    end;

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
    SqlAux2.Close
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
  begin
    DtPickerDtIni.Date := SqlSdx6Dtini.Value;
    DtPickerDtFin.Date := SqlSdx6Dtfin.Value;
    DBMacroProd.KeyValue := SqlSdx6CodProduto.Value;
    EditLotes.Text := IntToStr(SqlSdx6Lote.Value);
  end;
end;

procedure TFrmPrintAR.FormShow(Sender: TObject);
begin
  with Dm do
    begin
      SqlSdxServ.Close;
      SqlSdxServ.SQL.Clear;
      SqlSdxServ.SQL.Add('SELECT * FROM public.tbsdxserv t ');
      SqlSdxServ.SQL.Add('WHERE t.tbsdxserv_status = 1 AND ');
      SqlSdxServ.SQL.Add('(t.tbsdxserv_dsc ILIKE ''%TOKEN%'' OR ');
      SqlSdxServ.SQL.Add('t.tbsdxserv_dsc ILIKE ''%TANCODE%'' OR ');
      SqlSdxServ.SQL.Add('t.tbsdxserv_dsc ILIKE ''% OL %'')');

      SqlSdxServ.Open;
      SqlSdx6.Open;
    end;
    DBMacroProd.Refresh;
    DBGridLotes.Refresh;


end;


end.