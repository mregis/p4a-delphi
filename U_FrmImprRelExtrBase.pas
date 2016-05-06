unit U_FrmImprRelExtrBase;

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
    EdAgencia: TEdit;
    LblAgencia: TLabel;
    GrpBxTpPessoa: TGroupBox;
    ChckBxPessoaFisica: TCheckBox;
    ChckBxPessoaJuridica: TCheckBox;
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
uses DmDados, U_Func;

procedure TFrmImprRelExtrBase.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmImprRelExtrBase.BtnGerarClick(Sender: TObject);
var tblnum, relTitle,
  // queries
  sqlCheckCount, sqlRelDet, sqlRelBase, sqlSumario,
  // Diversas
  tpf, tpj, whereag : String;
  ag : Integer;
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

  // consulta verificação de resultados
  sqlcheckcount := 'SELECT COUNT(a.*) as qtde, ' + #13#10 +
        ' b.cg20_descricao as descricao, b.cg20_codbaixa as codbaixa ' + #13#10 +
        'FROM cga%s a ' + #13#10 + '  INNER JOIN cga20 b ON (a.cg%0:s_codbaixa = b.cg20_codbaixa) ' + #13#10 +
        'WHERE a.cg%0:s_dtbaixa BETWEEN :dtini AND :dtfim ' + #13#10 +
        'GROUP BY b.cg20_descricao, b.cg20_codbaixa ' + #13#10 +
        'ORDER BY b.cg20_descricao';

  // Consulta total de resultados
  sqlrelbase := 'SELECT COUNT(z.*) AS total ' + #13#10 +
        'FROM (SELECT DISTINCT a.cg%s_remes, b.cg20_codbrad,  ' + #13#10 +
        '    a.cg%0:s_dtbaixa' + #13#10 +
        '  FROM cga%0:s a INNER JOIN cga20 b ON a.cg%0:s_codbaixa = b.cg20_codbaixa ' + #13#10 +
        '  WHERE a.cg%0:s_dtret IS NOT NULL AND a.cg%0:s_dtbaixa ' +
        'BETWEEN :dti AND :dtf ' + #13#10 +
        '  GROUP BY b.cg20_codbrad, ' + #13#10 +
        '    a.cg%0:s_dtbaixa, a.cg%0:s_remes) z';

    // consulta do relatório
    sqlRelDet := 'SELECT COUNT(a.*) as qtde, ' + #13#10 +
              ' a.cg%s_dtbaixa as dtbaixa, ' + #13#10 +
              ' b.cg20_descricao as descricao, b.cg20_codbaixa as codbaixa' + #13#10 +
              'FROM cga%0:s a ' + #13#10 +
              '  INNER JOIN cga20 b ON (a.cg%0:s_codbaixa = b.cg20_codbaixa) ' + #13#10 +
              'WHERE a.cg%0:s_dtbaixa BETWEEN :dtini AND :dtfim ' + #13#10 +
              'GROUP BY a.cg%0:s_dtbaixa, b.cg20_descricao, ' + #13#10 +
              ' b.cg20_codbaixa ' + #13#10 +
              'ORDER BY b.cg20_descricao, a.cg%0:s_dtbaixa';

    sqlSumario := 'SELECT (SELECT COALESCE(SUM(ads05servnlido_qtd), 0) ' + #13#10 +
              '  FROM ads005_servnaolido ' + #13#10 +
              '  WHERE ads05servnlido_codserv = :cod AND ' + #13#10 +
              '      ads05servnlido_dti BETWEEN :dti1 and :dtf1' + #13#10 + ') as nlido,' + #13#10 +
              '(SELECT COUNT(a.*) ' + #13#10 + '  FROM cga%s a ' + #13#10 +
              ' WHERE a.cg%0:s_dtbaixa ' + #13#10 +
              ' BETWEEN :dti2 and :dtf2) as lido';

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

    32:
      begin
        if (NOT ChckBxPessoaFisica.Checked AND NOT ChckBxPessoaJuridica.Checked)  then
          begin
            Application.MessageBox(Pchar('Selecione ao menos um tipo para gerar o relatório.'),
              'Address - ADS', MB_OK + MB_ICONWARNING);
            ChckBxPessoaFisica.SetFocus;
            exit;
          end;
        tblnum := '76';
        tpf := '99';
        tpj := '99';
        RvPrjRelExtrBase.ProjectFile := ExtractFilePath(Application.ExeName) +
      'RelExtratoTokensBaixados.rav';
        relTitle := 'Tokens Baixados - Pessoa';
        if ChckBxPessoaFisica.Checked then
          begin
            relTitle := relTitle + ' Física e';
            tpf := '0';
          end;
        if ChckBxPessoaJuridica.Checked then
          begin
            relTitle := relTitle + ' Jurídica';
            tpj := '1';
          end
        else
          StringReplace(relTitle, ' e', '', []);

        if EdAgencia.Text <> '' then
          begin
            if not TryStrToInt(EdAgencia.Text, ag) then
              ag := 0;
            whereag := Format('    AND a.cg%s_ag IN(%s,%s,%s) ' + #13#10,
                        [tblnum, QuotedStr(EdAgencia.Text),
                        QuotedStr(IntToStr(ag)),
                        QuotedStr(LPad(IntToStr(ag), 4, '0'))]);

          end;
        // SQL de verificação de resultados e de cabeçalhos para cada
        // Agência
        sqlcheckcount := 'SELECT COUNT(a.cg%s_remes) as qtde, ' + #13#10 +
              '    CAST(a.cg%0:s_ag || '' - '' || COALESCE(b.depto, '''') AS VARCHAR) as descricao, ' + #13#10 +
              '    CAST(b.juncao as VARCHAR) as codbaixa ' + #13#10 +
              'FROM cga%0:s a ' + #13#10 +
              '        INNER JOIN tbbraddptos b ON (CAST(a.cg%0:s_ag AS INTEGER) = b.juncao) ' + #13#10 +
              'WHERE a.cg%0:s_dtsai BETWEEN :dtini AND :dtfim ' + #13#10 +
              '    AND cg76_tipocli IN ' +
              Format('(%s, %s) ' + #13#10, [tpf, tpj]) +
              whereag;

        sqlcheckcount := sqlcheckcount + 'GROUP BY b.juncao, a.cg%0:s_ag '  + #13#10 +
              'ORDER BY b.juncao';

        // SQL de registros
        sqlRelDet := 'SELECT COUNT(a.cg%s_remes) as qtde,  ' + #13#10 +
              '    CAST((CASE WHEN cg76_tipocli = 1 THEN ''Pessoa Juridica'' ELSE ''Pessoa Fisica'' END) AS VARCHAR) as descricao, ' + #13#10 +
              '    CAST(b.juncao AS VARCHAR) as codbaixa, ' + #13#10 +
              '    a.cg%0:s_dtsai as dtbaixa, a.cg76_tipocli ' + #13#10 +
              'FROM cga%0:s a ' + #13#10 +
              '        INNER JOIN tbbraddptos b ON (CAST(a.cg%0:s_ag AS INTEGER) = b.juncao) ' + #13#10 +
              'WHERE a.cg%0:s_dtsai BETWEEN :dtini AND :dtfim ' + #13#10 +
              '    AND cg%0:s_tipocli IN ' +
              Format('(%s, %s) ' + #13#10, [tpf, tpj]) +
              whereag;

        sqlRelDet := sqlRelDet + 'GROUP BY b.juncao, a.cg%0:s_dtsai, a.cg%0:s_tipocli ' + #13#10 +
              'ORDER BY b.juncao, a.cg%0:s_dtsai, a.cg%0:s_tipocli ';


        // SQL de sumário para Tokens Baixados
        sqlSumario := 'SELECT :cod as cod,  :dti1, :dtf1, '+ #13#10 +
              '    SUM(CASE WHEN cg76_tipocli = 1 THEN 1 ELSE 0 END) as lido, ' + #13#10 +
              '    SUM(CASE WHEN cg76_tipocli = 0 THEN 1 ELSE 0 END) as nlido ' + #13#10 +
              'FROM cga76 a ' + #13#10 +
              'WHERE a.cg76_dtsai BETWEEN :dti2 and :dtf2 ' + #13#10 +
              '    AND cg76_tipocli IN ' +
              Format('(%s, %s) ' + #13#10, [tpf, tpj]) + whereag;

        // SQL de sumário para Total de Agências Presentes no relatório
        sqlRelBase := 'SELECT COUNT(DISTINCT a.cg%s_ag) as total ' + #13#10 +
              'FROM cga%0:s a ' + #13#10 +
              'WHERE a.cg%0:s_dtsai BETWEEN :dti AND :dtf ' +
              '    AND cg76_tipocli IN ' +
              Format('(%s, %s) ' + #13#10, [tpf, tpj]) + whereag;
      end;

    39:
      begin
        tblnum := '76';
        relTitle := 'Tokens Lidos';
        sqlcheckcount := 'SELECT COUNT(a.*) as qtde, ' + #13#10 +
              '    b.nome as descricao, CAST(b.codigo AS VARCHAR) as codbaixa ' + #13#10 +
              'FROM cga76 a ' + #13#10 +
              '    INNER JOIN cga_acesso b on a.cg76_codusu_dig = b.codigo ' + #13#10 +
              'WHERE a.cg76_dtentr BETWEEN :dtini AND :dtfim ' + #13#10 +
              'GROUP BY b.nome, b.codigo ' + #13#10 +
              'ORDER BY b.nome';

        sqlRelDet := 'SELECT COUNT(a.*) as qtde, a.cg%s_dtentr as dtbaixa, ' + #13#10 +
              '    b.nome as descricao, CAST(b.codigo as VARCHAR) as codbaixa ' + #13#10 +
              'FROM cga%0:s a ' + #13#10 +
              '    INNER JOIN cga_acesso b on a.cg%0:s_codusu_dig = b.codigo ' + #13#10 +
              'WHERE a.cg%0:s_dtentr BETWEEN :dtini AND :dtfim ' + #13#10 +
              'GROUP BY a.cg%0:s_dtentr, b.nome, b.codigo ' + #13#10 +
              'ORDER BY b.nome, a.cg%0:s_dtentr ';

        // SQL de sumário para Tokens Lidos
        sqlSumario := 'SELECT 0 as nlido, :cod as cod,  :dti1, :dtf1, ' + #13#10 +
              '(SELECT COUNT(a.*) ' + #13#10 + '  FROM cga%s a ' + #13#10 +
              ' WHERE a.cg%0:s_dtentr BETWEEN :dti2 and :dtf2) as lido';

        // SQL de sumário para Total de Tokens Lidos
        sqlRelBase := 'SELECT COUNT(a.*) as total ' + #13#10 +
              'FROM cga%s a ' + #13#10 +
              '    INNER JOIN cga_acesso b on a.cg%0:s_codusu_dig = b.codigo ' + #13#10 +
              'WHERE a.cg%0:s_dtentr BETWEEN :dti AND :dtf ';
      end;
  end;

  sqlcheckcount := Format(sqlcheckcount, [tblnum]);
  With Dm Do
    Begin
      SqlSdx8.Close;
      SqlSdx8.Sql.Clear;
      SqlSdx8.SQL.Add(sqlcheckcount);
      SqlSdx8.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
      SqlSdx8.ParamByName('dtfim').AsDate := DtPickerDtFin.Date;

      SqlSdx8.Open;
      if (SqlSdx8.RecordCount > 0 ) then
        Begin

          sqlRelDet := Format(sqlRelDet, [tblnum]);
          SqlSdx9.Close;
          SqlSdx9.Sql.Clear;
          SqlSdx9.SQL.Add(sqlRelDet);
          SqlSdx9.ParamByName('dtini').AsDate := DtPickerDtIni.Date;
          SqlSdx9.ParamByName('dtfim').AsDate := DtPickerDtFin.Date;
          // Necessário executar o Open antes de definir parâmetros internos
          RvPrjRelExtrBase.Open;
          // Recuperando a soma total dos lidos e não lidos para o período
          SqlRel.Close;
          SqlRel.Sql.Clear;
          sqlSumario := Format(sqlSumario, [tblnum]);
          SqlRel.Sql.Add(sqlSumario);
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
          SqlRel.Sql.Add( Format(sqlRelBase, [tblnum]));
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
  case Tag of 
    32:
      begin
        FrmImprRelExtrBase.GrpBxTpPessoa.Visible := true;
        FrmImprRelExtrBase.LblAgencia.Visible := true;
        FrmImprRelExtrBase.EdAgencia.Visible := true;
      end;  
  end;
end;

end.
