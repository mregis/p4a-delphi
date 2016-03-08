unit U_FrmGeraRelatToken;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls;

type
  TFrmGeraRelatToken = class(TForm)
    GroupBoxPeridoCarga: TGroupBox;
    LabelDtFin: TLabel;
    DtPickerDtIni: TDateTimePicker;
    DtPickerDtFin: TDateTimePicker;
    Label1: TLabel;
    BtnImprime: TBitBtn;
    BtnFechar: TBitBtn;
    GroupBox1: TGroupBox;
    LabelDtIni: TLabel;
    EdAgencia: TEdit;
    EdGrm: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EdLote: TEdit;
    StsRemSdx: TStatusBar;
    procedure BtnImprimeClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGeraRelatToken: TFrmGeraRelatToken;

implementation

{$R *.dfm}
uses U_Func, DmDados, UFrTokenBradesco;

procedure TFrmGeraRelatToken.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmGeraRelatToken.BtnImprimeClick(Sender: TObject);
var nlido, ag, v_tipocli : Integer;
begin
  With Dm do
    Begin
      SqlRel.Close;
      SqlRel.SQL.Clear;
      SqlRel.SQL.Add('SELECT SUM(ads05servnlido_qtd) ');
      SqlRel.SQL.Add('FROM ads005_servnaolido ');
      SqlRel.SQL.Add('WHERE ads05servnlido_codserv = :cod ');
      SqlRel.SQL.Add('  AND ads05servnlido_dti BETWEEN :dtini AND :dtfin');
      SqlRel.ParamByName('cod').AsInteger := 13;
      SqlRel.ParamByName('dtini').AsDate :=  DtPickerDtIni.Date;
      SqlRel.ParamByName('dtfin').AsDate :=  DtPickerDtFin.Date;
      SqlRel.Open;
      nlido :=  SqlRel.Fields[0].AsInteger;

      ZOQListaToken.Close;
      ZOQListaToken.Sql.Clear;
      ZOQListaToken.Sql.Add('SELECT cga76.cg76_dtsai, cga76.cg76_ag, ');
      ZOQListaToken.Sql.Add('  cga76.cg76_remes, cga76.cg76_dtb, cg76_numlote, ');
      ZOQListaToken.Sql.Add('  cga20.cg20_descricao, cg76_tipocli ');
      ZOQListaToken.Sql.Add('FROM cga76 ');
      ZOQListaToken.Sql.Add('    INNER JOIN cga20 ON cga76.cg76_codbaixa = cga20.cg20_codbaixa ');
      ZOQListaToken.Sql.Add('WHERE cga76.cg76_dtsai BETWEEN :dtini AND :dtfin ');
      ZOQListaToken.ParamByName('dtini').AsDate :=  DtPickerDtIni.Date;
      ZOQListaToken.ParamByName('dtfin').AsDate :=  DtPickerDtFin.Date;

      if (trim(EdAgencia.Text) <> '') AND (TryStrToInt(Trim(EdAgencia.Text), ag)) then
        begin
          ZOQListaToken.Sql.Add('  AND (cg76_ag = :ag OR cg76_ag = :ag2) ');
          ZOQListaToken.ParamByName('ag').AsString := LPad(Trim(EdAgencia.Text), 4, '0');
          ZOQListaToken.ParamByName('ag2').AsInteger := ag;
        end
      else
        ZOQListaToken.Sql.Add('  AND cg76_ag IS NOT NULL ');

      if (trim(EdGrm.Text) <> '') then
        begin
          ZOQListaToken.Sql.Add('  AND cg76_Dtb = :dtb ');
          ZOQListaToken.ParamByName('dtb').AsString := LPad(Trim(EdGrm.Text), 10, '0');
        end
      else
        ZOQListaToken.Sql.Add('  AND cg76_Dtb IS NOT NULL ');

      if (trim(EdLote.Text) <> '') then
        begin
          ZOQListaToken.Sql.Add('  AND cg76_numlote = :lote ');
          ZOQListaToken.ParamByName('lote').AsString := LPAD(Trim(EdLote.Text), 6, '0');
        end;

      ZOQListaToken.Sql.Add('ORDER BY cga76.cg76_dtsai, cga76.cg76_ag, ');
      ZOQListaToken.Sql.Add('  cga76.cg76_dtb, cg76_numlote, cga76.cg76_remes, ');
      ZOQListaToken.Sql.Add('  cga20.cg20_descricao');

      ZOQListaToken.open;

      if ZOQListaToken.RecordCount > 0 then
        begin
          v_tipocli := ZOQListaTokencg76_tipocli.AsInteger;
          application.CreateForm(TFrmFrTokenBradesco, FrmFrTokenBradesco);

          FrmFrTokenBradesco.Tag := 25;
          FrmFrTokenBradesco.RLLabel1.Caption    := 'Relatório de Tokens por Agência';
          FrmFrTokenBradesco.RLLabel2.Caption    := 'Período de ' +
              FormatDateTime('dd/mm/yyyy', DtPickerDtIni.Date) + ' à ' +
              FormatDateTime('dd/mm/yyyy', DtPickerDtFin.Date);
          FrmFrTokenBradesco.RLLabel12.Caption:= FrmFrTokenBradesco.Caption + 'TIPO DE CLIENTE: PESSOA FISICA / JURIDICA';
          FrmFrTokenBradesco.RLRListaToken.PreviewModal;
        end
      else
        begin
          Application.MessageBox(PChar('Não foi encontrado nenhum registro com os ' +
                'parametros informados'), 'Ads', MB_OK + MB_ICONINFORMATION);
          exit;
        end;
    end;

end;

end.
