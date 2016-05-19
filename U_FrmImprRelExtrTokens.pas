unit U_FrmImprRelExtrTokens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, DateUtils, RpDefine, RpRave;

type
  TFrmImprRelExtrBase = class(TForm)
    GroupBoxPeridoCarga: TGroupBox;
    LabelDtIni: TLabel;
    LabelDtFin: TLabel;
    DtPickerDtIni: TDateTimePicker;
    DtPickerDtFin: TDateTimePicker;
    BtnGerar: TBitBtn;
    BtnFechar: TBitBtn;
    RvPrjRelExtrBase: TRvProject;
    StsMenu: TStatusBar;
    MemoDica: TMemo;
    procedure BtnGerarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmImprRelExtrBase: TFrmImprRelExtrBase;

implementation

{$R *.dfm}
uses DmDados;

procedure TFrmImprRelExtrBase.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmImprRelExtrBase.BtnGerarClick(Sender: TObject);
var tblnum, sqlcount, relTitle, sqlrelbase : String;
begin
  if (CompareDate(DtPickerDtIni.Date, DtPickerDtFin.Date) > 0) then
    begin
      Application.MessageBox(Pchar('A data final não pode ser inferior a data inicial.'),
          'Address - ADS', MB_OK + MB_ICONWARNING);
      DtPickerDtFin.SetFocus;
      exit;
    end;

  RvPrjRelExtrBase.ProjectFile := ExtractFilePath(Application.ExeName) +
      'RelExtratoBase.rav';

  sqlcount := 'SELECT COUNT(a.*) as qtde, ' + #13#10 +
        ' b.cg20_descricao as descricao, b.cg20_codbaixa as codbaixa ' + #13#10 +
        'FROM cga%s a ' + #13#10 + '  INNER JOIN cga20 b ON (a.cg%0:s_codbaixa = b.cg20_codbaixa) ' + #13#10 +
        'WHERE a.cg%0:s_dtbaixa BETWEEN :dtini AND :dtfim ' + #13#10 +
        'GROUP BY b.cg20_descricao, b.cg20_codbaixa ' + #13#10 +
        'ORDER BY b.cg20_descricao';

  sqlrelbase := 'SELECT COUNT(z.*) AS total ' + #13#10 +
        'FROM (SELECT DISTINCT a.cg%s_remes, b.cg20_codbrad,  ' + #13#10 +
        '    a.cg%0:s_dtbaixa' + #13#10 +
        '  FROM cga%0:s a INNER JOIN cga20 b ON a.cg%0:s_codbaixa = b.cg20_codbaixa ' + #13#10 +
        '  WHERE a.cg%0:s_dtret IS NOT NULL AND a.cg%0:s_dtbaixa ' +
        'BETWEEN :dti AND :dtf ' + #13#10 +
        '  GROUP BY b.cg20_codbrad, ' + #13#10 +
        '    a.cg%0:s_dtbaixa, a.cg%0:s_remes) z';

  case Tag of
    1: // Consolidado
      begin
        tblnum := '75';
        relTitle := 'Consolidado';
      end;
    5: // Unificado
      begin
        tblnum := '68';
        relTitle := 'Unificado';
      end;
    6: // Tancode
      begin
        tblnum := '130';
        relTitle := 'Cartão Segurança';
      end;
    7:
      begin
        tblnum := '69';
        relTitle := 'CVM';
        sqlrelbase := 'SELECT COUNT(z.*) AS total ' + #13#10 +
          'FROM (SELECT DISTINCT a.cg%s_remes1, b.cg20_codbrad,  ' + #13#10 +
          '    a.cg%0:s_dtbaixa' + #13#10 +
          '  FROM cga%0:s a INNER JOIN cga20 b ON a.cg%0:s_codbaixa = b.cg20_codbaixa ' + #13#10 +
          '  WHERE a.cg%0:s_dtret IS NOT NULL AND a.cg%0:s_dtbaixa ' +
          'BETWEEN :dti AND :dtf ' + #13#10 +
          '  GROUP BY b.cg20_codbrad, ' + #13#10 +
          '    a.cg%0:s_dtbaixa, a.cg%0:s_remes1) z';
      end;
    39:
      begin
        tlbnum := '76';
        relTitle := 'Tokens Lidos';
        sqlcount := 'SELECT COUNT(a.*) as qtde, ' + #13#10 +
            ' b.cg20_descricao as descricao, b.cg20_codbaixa as codbaixa ' + #13#10 +
            'FROM cga76 a ' + #13#10 + '  INNER JOIN cga20 b ON (a.cg76_codbaixa = b.cg20_codbaixa) ' + #13#10 +
            'WHERE a.cg76_dtentr BETWEEN :dtini AND :dtfim ' + #13#10 +
            'GROUP BY b.cg20_descricao, b.cg20_codbaixa ' + #13#10 +
            'ORDER BY b.cg20_descricao';

        sqlrelbase := 'SELECT COUNT(a.cg%s_dtentr), cga76.cg76_dtentr, upper(cga_acesso.nome) ';
                    Dm.SqlRel.Sql.Add('select count(cga76.cg76_dtentr),cga76.cg76_dtentr,upper(cga_acesso.nome) ');
            Dm.SqlRel.Sql.Add('from cga76 ');
            Dm.SqlRel.Sql.Add('inner join cga_acesso on cga76.cg76_codusu_dig = cga_acesso.codigo ');
            Dm.SqlRel.Sql.Add('where (cga76.cg76_dtentr between :dtini and :dtfin) ');
            Dm.SqlRel.Sql.Add('group by cga76.cg76_dtentr,cga_acesso.nome ');
            Dm.SqlRel.Sql.Add('order by upper(cga_acesso.nome),cga76.cg76_dtentr ');
            Dm.SqlRel.Params[0].AsDate  :=  strtodate(MkEdDtIni.Text);
            Dm.SqlRel.Params[1].AsDate  :=  strtodate(MkEdDtFin.Text);
      end;
  end;

  sqlcount := Format(sqlcount, [tblnum]);
  With Dm Do
    Begin
      SqlSdx8.Close;
      SqlSdx8.Sql.Clear;
      SqlSdx8.SQL.Add(sqlcount);
      SqlSdx8.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlSdx8.ParamByName('dtfim').AsDate := DtPickerDtFin.Date;

      SqlSdx8.Open;
      if (SqlSdx8.RecordCount > 0 ) then
        Begin
          // Preparando a consulta do relatório
          sqlcount := 'SELECT COUNT(a.*) as qtde, ' + #13#10 +
              ' a.cg%s_dtbaixa as dtbaixa, ' + #13#10 +
              ' b.cg20_descricao as descricao, b.cg20_codbaixa as codbaixa' + #13#10 +
              'FROM cga%0:s a ' + #13#10 +
              '  INNER JOIN cga20 b ON (a.cg%0:s_codbaixa = b.cg20_codbaixa) ' + #13#10 +
              'WHERE a.cg%0:s_dtbaixa BETWEEN :dtini AND :dtfim ' + #13#10 +
              'GROUP BY a.cg%0:s_dtbaixa, b.cg20_descricao, ' + #13#10 +
              ' b.cg20_codbaixa ' + #13#10 +
              'ORDER BY b.cg20_descricao, a.cg%0:s_dtbaixa';
          sqlcount := Format(sqlcount, [tblnum]);
          SqlSdx9.Close;
          SqlSdx9.Sql.Clear;
          SqlSdx9.SQL.Add(sqlcount);
          SqlSdx9.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
          SqlSdx9.ParamByName('dtfim').AsDate := DtPickerDtFin.Date;
          // Necessário executar o Open antes de definir parâmetros internos
          RvPrjRelExtrBase.Open;
          // Recuperando a soma total dos lidos e não lidos para o período
          SqlRel.Close;
          SqlRel.Sql.Clear;
          SqlRel.Sql.Add('SELECT (SELECT COALESCE(SUM(ads05servnlido_qtd), 0) ');
          SqlRel.Sql.Add('  FROM ads005_servnaolido ');
          SqlRel.Sql.Add('  WHERE ads05servnlido_codserv = :cod AND ');
          SqlRel.Sql.Add('      ads05servnlido_dti BETWEEN :dti1 and :dtf1');
          SqlRel.Sql.Add(') as nlido,');
          SqlRel.Sql.Add(Format('(SELECT COUNT(a.*) ' + #13#10 +
                '  FROM cga%s a ' + #13#10 + '  WHERE a.cg%0:s_dtbaixa ' +
                'BETWEEN :dti2 and :dtf2) as lido', [tblnum]));
          SqlRel.ParamByName('cod').AsInteger := Tag;
          SqlRel.ParamByName('dti1').AsDate := DtPickerDtIni.Date;
          SqlRel.ParamByName('dtf1').AsDate := DtPickerDtFin.Date;
          SqlRel.ParamByName('dti2').AsDate := DtPickerDtIni.Date;
          SqlRel.ParamByName('dtf2').AsDate := DtPickerDtFin.Date;

          SqlRel.Open;
          RvPrjRelExtrBase.SetParam('NomeRelatorio', relTitle);
          RvPrjRelExtrBase.SetParam('NLidos', SqlRel.FieldByName('nlido').AsString);
          RvPrjRelExtrBase.SetParam('Lidos', SqlRel.FieldByName('Lido').AsString);
          RvPrjRelExtrBase.SetParam('TotalGeral',
            IntToStr(SqlRel.FieldByName('Lido').AsInteger + SqlRel.FieldByName('nlido').AsInteger));

          // Quantidade de registros
          SqlRel.Close;
          SqlRel.Sql.Clear;
          SqlRel.Sql.Add( Format(sqlrelbase, [tblnum]));
          SqlRel.ParamByName('dti').AsDate := DtPickerDtIni.Date;
          SqlRel.ParamByName('dtf').AsDate := DtPickerDtFin.Date;
          SqlRel.Open;
          RvPrjRelExtrBase.SetParam('Gerados', SqlRel.FieldByName('total').AsString);

          RvPrjRelExtrBase.SetParam('di', FormatDateTime('dd/mm/yyyy', DtPickerDtIni.Date));
          RvPrjRelExtrBase.SetParam('df', FormatDateTime('dd/mm/yyyy', DtPickerDtFin.Date));
          RvPrjRelExtrBase.ExecuteReport('Report1');
          RvPrjRelExtrBase.Close;
        end
      else
        Application.MessageBox(Pchar('Não há registros para o período informado.'),
          'Address - ADS', MB_OK + MB_ICONWARNING);
          
      SqlSdx8.Close;
    end;

  // ### VALIDAÇÃO
  // A data é o único campo obrigatório
{
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
                  'Nº de Lote!', [lotes.Strings[i]])), 'Address - ADS', MB_OK + MB_ICONWARNING);
              EditLotes.SetFocus;
              exit;
            end;
        end;
    end;


  agencias := TStringList.Create;
  // Verificando se foi indicado um ou mais números de lotes
  if (EditAgencias.Text <> '') then
    begin
      agencias.DelimitedText := EditAgencias.Text;
      for i := 0 to agencias.Count - 1 do
        begin
          if TryStrToInt(agencias.Strings[i], num_agencia) = false then
            begin
              Application.MessageBox(PChar(Format('O valor ''%s'' é inválido para um ' +
                  'Nº de Agência!', [lotes.Strings[i]])), 'Address - ADS', MB_OK + MB_ICONWARNING);
              EditLotes.SetFocus;
              exit;
            end;
        end;
    end;



  With Dm do
    begin
      // Recuperando a soma total dos não lidos para o período
      SqlRel.Close;
      SqlRel.Sql.Clear;
      SqlRel.Sql.Add('SELECT COALESCE(SUM(ads05servnlido_qtd), 0) as total ');
      SqlRel.Sql.Add('FROM ads005_servnaolido ');
      SqlRel.Sql.Add('WHERE ads05servnlido_codserv = 1 AND ');
      SqlRel.Sql.Add('  ads05servnlido_dti BETWEEN :dti and :dtf');
      SqlRel.ParamByName('dti').AsDate := DtPickerDtIni.Date;
      SqlRel.ParamByName('dtf').AsDate := DtPickerDtFin.Date;
      SqlRel.Open;
      nlido :=  SqlRel.FieldByName('total').AsInteger;

      // Quantidade de registros
      SqlRel.Close;
      SqlRel.Sql.Clear;
      SqlRel.Sql.Add('SELECT COUNT(z.*) AS total ');
      SqlRel.Sql.Add('FROM (SELECT a.cg75_remes, b.cg20_codbrad, a.cg75_tipo, ');
      SqlRel.Sql.Add('    a.cg75_dv, a.cg75_codag, a.cg75_conta, a.cg75_dtbaixa ');
      SqlRel.Sql.Add('  FROM cga75 a ');
      SqlRel.Sql.Add('    INNER JOIN cga20 b ON a.cg75_codbaixa = b.cg20_codbaixa ');
      SqlRel.Sql.Add('  WHERE a.cg75_dtret IS NOT NULL ');
      SqlRel.Sql.Add('    AND a.cg75_dtbaixa BETWEEN :dti AND :dtf ');
      SqlRel.Sql.Add('  GROUP BY b.cg20_codbrad, a.cg75_tipo, a.cg75_dv, ');
      SqlRel.Sql.Add('    a.cg75_codag, a.cg75_conta, ');
      SqlRel.Sql.Add('    a.cg75_dtbaixa, a.cg75_remes) z');
      SqlRel.ParamByName('dti').AsDate := DtPickerDtIni.Date;
      SqlRel.ParamByName('dtf').AsDate := DtPickerDtFin.Date;
      SqlRel.Open;
      vRes  := SqlRel.FieldByName('total').AsInteger;

      SqlRel.Close;
      SqlRel.Sql.Clear;
      SqlRel.Sql.Add('SELECT COUNT(a.cg75_remes), a.cg75_dtbaixa, ');
      SqlRel.Sql.Add('  b.cg20_descricao, b.cg20_codbaixa ');
      SqlRel.SQL.Add('FROM cga75 a ');
      SqlRel.SQL.Add('  INNER JOIN cga20 b ON (a.cg75_codbaixa = b.cg20_codbaixa)');
      SqlRel.SQL.Add('WHERE a.cg75_dtbaixa BETWEEN :dtini AND :dtfim ');
      SqlRel.SQL.Add('GROUP BY a.cg75_dtbaixa, b.cg20_descricao, b.cg20_codbaixa');
      SqlRel.Sql.Add('ORDER BY b.cg20_descricao, a.cg75_dtbaixa');
      SqlRel.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlRel.ParamByName('dtfim').AsDate := DtPickerDtFin.Date;
      SqlRel.Open;
      if (SqlRel.RecordCount > 0 ) Then
        begin
{          application.CreateForm(TFrmFrProdExtContaCorrente, FrmFrProdExtContaCorrente);
          FrmFrProdExtContaCorrente.Tag := 4;
          FrmFrProdExtContaCorrente.vRes := vRes;
          FrmFrProdExtContaCorrente.nLido := nLido;
          FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
          FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Extrato Unificado';
          FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Período de ' +
              FormatDateTime('dd/mm/yyyy', DtPickerDtIni.Date) +' à ' +
              FormatDateTime('dd/mm/yyyy', DtPickerDtFin.Date);
          FrmFrProdExtContaCorrente.RLBand5.Enabled      := false;
          FrmFrProdExtContaCorrente.RLBand5.Visible      := true;
          FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
          FrmFrProdExtContaCorrente.RLReport1.Destroy;
        end
      else
        begin
          Application.MessageBox('Não foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
          Exit;
        end;

    end;
    }
end;

procedure TFrmImprRelExtrBase.FormShow(Sender: TObject);
begin
  DtPickerDtIni.Date := Date - 30;
  DtPickerDtFin.Date := Date;
end;

end.
