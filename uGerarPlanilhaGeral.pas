unit uGerarPlanilhaGeral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ComObj, DateUtils, Mask;

type
  arrayDate = Array of TDate;

type
  TfGerarPlanilhaGeral = class(TForm)
    group: TGroupBox;
    lbldata: TLabel;
    Status: TStatusBar;
    panelBarra: TPanel;
    ProgressBar: TProgressBar;
    btnGerar: TBitBtn;
    CGA035: TZQuery;
    CGA036: TZQuery;
    CGA039: TZQuery;
    CGA040: TZQuery;
    CGA038: TZQuery;
    CGA120: TZQuery;
    CGA100: TZQuery;
    CGA044: TZQuery;
    SaveDialog: TSaveDialog;
    lblPlanilha: TLabel;
    cbdtini: TDateTimePicker;
    cbdtfim: TDateTimePicker;
    CGA78: TZQuery;
    CGA043: TZQuery;
    CGA042: TZQuery;
    CGA041: TZQuery;
    CGA130: TZQuery;
    CGA69: TZQuery;
    CGA68: TZQuery;
    CGA33: TZQuery;
    CGA75: TZQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGerarClick(Sender: TObject);
  private
    { Private declarations }
    xDtInicial, xDtFinal : TDate;
    listOfQuery : TList;
    tabelasExcecao : Array[0..1] of String;

    Function AjustarProgressBar(progress : TProgressBar; arrayQuery : TList) : Boolean;
    Function AbrirTabelas(dtini : TDate; dtfim : TDate) : Boolean;
    Function GerarExcel(Query : TZQuery; nomeProduto : String; excel : Variant; var linha : Integer) : Boolean;

    Function VerificarTabelaExcecao(nome : String) : Boolean;
  public
    { Public declarations }
  end;

var
  fGerarPlanilhaGeral: TfGerarPlanilhaGeral;

implementation

uses DmDados;

{$R *.dfm}

Function TfGerarPlanilhaGeral.VerificarTabelaExcecao(nome : String) : Boolean;
var
  I: Integer;
begin
  try
    for I := 0 to Length(tabelasExcecao) - 1 do
    begin
      if nome = tabelasExcecao[I] then
      begin
        Result := True;
        Exit;
      end;
    end;

    Result := False;
  except
    on E: Exception do
    begin
      Result := True;
    end;
  end;
end;

Function TfGerarPlanilhaGeral.AjustarProgressBar(progress : TProgressBar; arrayQuery : TList) : Boolean;
var
  I: Integer;
begin
  try
    progress.Min      := 0;
    progress.Max      := 0;
    progress.Position := 0;
    progress.Step     := 1;

    for I := 0 to arrayQuery.Count - 1 do
    begin
      progress.Max := progress.Max + TZQuery(arrayQuery.Items[I]).RecordCount;
    end;

    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
    end;
  end;
end;

Function TfGerarPlanilhaGeral.AbrirTabelas(dtini : TDate; dtfim : TDate) : Boolean;
var
  Query : TZQuery;
  I: Integer;
  xComponente : TComponent;
  xCampoData, xCampoCodBaixa : String;
begin
  try
    for I := 0 to Self.ComponentCount - 1 do
    begin
      xComponente := Self.Components[I];
      if UpperCase(xComponente.ClassName) = 'TZQUERY' then
      begin
        Query := TZQuery(xComponente);
        if not VerificarTabelaExcecao(Query.Name) then
        begin
          if UpperCase(Copy(Query.Name, 1, 3)) = 'CGA' then
          begin
            xCampoData := 'CG'+Trim(Copy(Query.Name, 4, 100))+'_DTBAIXA';

            Query.Close;
            Query.SQL.Clear;
            Query.Params.Clear;
            Query.SQL.Add('SELECT');
            Query.SQL.Add('   COUNT(*) AS QTD, '+xCampoData+' AS DATA');
            Query.SQL.Add('FROM');
            Query.SQL.Add('   '+Query.Name+' CGA');
            Query.SQL.Add('WHERE');
            Query.SQL.Add('       CGA.'+xCampoData+' >= :XPDTINI');
            Query.SQL.Add('   AND CGA.'+xCampoData+' <= :XPDTFIM');
            Query.SQL.Add('GROUP BY');
            Query.SQL.Add('   '+xCampoData);
            Query.SQL.Add('ORDER BY');
            Query.SQL.Add('   '+xCampoData);
            Query.ParamByName('XPDTINI').AsDate    := dtini;
            Query.ParamByName('XPDTFIM').AsDate    := dtfim;
            Query.Open;
            Query.First;
          end;
        end
        else
        begin
          //exce��o encontrada nos relat�rios em U_PesqImp
          //TAG 5:  // extrato unificado
          //TAG 42:  // Produ�ao DRC-Aviso de Cobran�a CLLP

          xCampoData     := 'CG'+Trim(Copy(Query.Name, 4, 100))+'_DTBAIXA';
          xCampoCodBaixa := 'CG'+Trim(Copy(Query.Name, 4, 100))+'_CODBAIXA';

          Query.Close;
          Query.SQL.Clear;
          Query.Params.Clear;
          Query.SQL.Add('SELECT');
          Query.SQL.Add('   COUNT(*) AS QTD, '+xCampoData+' AS DATA');
          Query.SQL.Add('FROM');
          Query.SQL.Add('   '+Query.Name+' CGA');
          Query.SQL.Add('WHERE');
          Query.SQL.Add('       CGA.'+xCampoData+' >= :XPDTINI');
          Query.SQL.Add('   AND CGA.'+xCampoData+' <= :XPDTFIM');
          Query.SQL.Add('   AND CGA.'+xCampoCodBaixa+' <> :XPCODBAIXA');
          Query.SQL.Add('GROUP BY');
          Query.SQL.Add('   '+xCampoData);
          Query.SQL.Add('ORDER BY');
          Query.SQL.Add('   '+xCampoData);
          Query.ParamByName('XPDTINI').AsDate      := dtini;
          Query.ParamByName('XPDTFIM').AsDate      := dtfim;
          Query.ParamByName('XPCODBAIXA').AsString := '119';
          Query.Open;
          Query.First;
        end;
      end;
    end;

    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
    end;
  end;
end;

Function TfGerarPlanilhaGeral.GerarExcel(Query : TZQuery; nomeProduto : String; excel : Variant; var linha : Integer) : Boolean;
var
  xLinha :integer;
  xPlanilha : Variant;
  xTotal: Integer;
begin

  try
    xLinha := linha;

    {
    xPlanilha.Cells[xLinha,1]           := 'Produto';
    xPlanilha.Cells[xLinha,1].Font.Bold := True;

    xPlanilha.Cells[xLinha,2]           := 'Data';
    xPlanilha.Cells[xLinha,2].Font.Bold := True;

    xPlanilha.Cells[xLinha,3]           := 'Qtde.';
    xPlanilha.Cells[xLinha,3].Font.Bold := True;
    }

    lblPlanilha.Caption := nomeProduto;
    Application.ProcessMessages;

    xPlanilha := excel.WorkBooks[1].WorkSheets['Relat_Geral'];

    if (Query.IsEmpty) or
       (Query.RecordCount <= 0) then
    begin
      Result := False;
      Exit;
    end;


    xLinha := xLinha + 1;
    Query.First;
    while not Query.Eof do
    begin
      Application.ProcessMessages;

      if Query.RecNo = 1 then
      begin
        xPlanilha.Cells[xLinha, 1] := nomeProduto;
      end;

      xPlanilha.Cells[xLinha, 2] := Query.FieldByName('DATA').AsDateTime;
      xPlanilha.Cells[xLinha, 3] := Query.FieldByName('QTD').AsInteger;

      xTotal := xTotal + Query.FieldByName('QTD').AsInteger;
      xLinha := xLinha + 1;
      Query.Next;

      Application.ProcessMessages;
      Status.Panels[0].Text := 'Processando '+IntToStr(ProgressBar.Position)+' de '+IntToStr(ProgressBar.Max);
      ProgressBar.StepIt;
      Application.ProcessMessages;
    end;

    xPlanilha.Cells[xLinha, 4].Font.Color := clred;
    xPlanilha.Cells[xLinha, 4].Font.Bold  := True;
    xPlanilha.Cells[xLinha, 4] := xTotal;
    xLinha := xLinha + 1;

    Status.Panels[0].Text := '';
    Excel.columns.AutoFit;
    Result := True;
    linha := xLinha;
  except
    on E: Exception do
    begin
      Result := False;
    end;
  end;
end;

procedure TfGerarPlanilhaGeral.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I: Integer;
begin
  if panelBarra.Visible then
  begin
    Action := caNone;
    Exit;
  end;

  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Trim(UpperCase(Self.Components[I].ClassName)) = 'TZQUERY' then
    begin
      try
        TZQuery(Self.Components[I]).Close;
      except on E: Exception do
      end;
    end;
  end;
end;

procedure TfGerarPlanilhaGeral.FormCreate(Sender: TObject);
begin
  cbdtini.Date := Trunc(Now);
  cbdtfim.Date := Trunc(Now);

  tabelasExcecao[0] := 'CGA78';
  tabelasExcecao[1] := 'CGA68';
end;

procedure TfGerarPlanilhaGeral.btnGerarClick(Sender: TObject);
var
  xDiretorio : String;
  xDtAux : TDate;
  excel : Variant;
  xInstallExcel : Boolean;
  xPlanilha : Variant;
  xLinha : Integer;
begin
  try
    if panelBarra.Visible then
    begin
      Exit;
    end;

    if cbdtini.Date = 0 then
    begin
      Application.MessageBox('Selecione a data inicial do per�odo !', 'Aten��o', MB_OK+MB_ICONWARNING);
      cbdtini.SetFocus;
      Exit;
    end;

    if cbdtfim.Date = 0 then
    begin
      Application.MessageBox('Selecione a data final do per�odo !', 'Aten��o', MB_OK+MB_ICONWARNING);
      cbdtfim.SetFocus;
      Exit;
    end;

    cbdtini.Date := Trunc(cbdtini.Date);
    cbdtfim.Date := Trunc(cbdtfim.Date);

    if cbdtini.Date > cbdtfim.Date then
    begin
      if Application.MessageBox('As datas aparentemente est�o invertidas, deseja que o sistema inverta ou prefere corrigi-la manualmente ? Sim(Autom�tico) ou N�o(Manual).', 'Confirma��o', MB_YESNO+MB_ICONQUESTION) = ID_YES then
      begin
        xDtAux       := cbdtini.Date;
        cbdtini.Date := cbdtfim.Date;
        cbdtfim.Date := xDtAux;
      end
      else
      begin
        cbdtini.SetFocus;
        Exit;
      end;
    end;

    SaveDialog.Execute;
    xDiretorio := ExtractFilePath(SaveDialog.FileName);
    if (Trim(xDiretorio) = '') or
       (not DirectoryExists(xDiretorio)) then
    begin
      Application.MessageBox('Defina o local onde os arquivos ser�o salvos !', 'Aten��o', MB_OK+MB_ICONWARNING);
      Exit;
    end;

    Application.Minimize;
    xDtInicial := Trunc(cbdtini.Date);
    xDtFinal   := Trunc(cbdtfim.Date);
    if not AbrirTabelas(xDtInicial, xDtFinal) then
    begin
      Application.MessageBox('N�o foi poss�vel abrir as tabelas necess�rias !', 'ERRO', MB_OK+MB_ICONERROR);
      Exit;
    end;

    try
      excel := CreateOleObject('\excel.application\');
      excel.WorkBooks.Add;

      excel.WorkBooks[1].WorkSheets.Add;
      excel.WorkBooks[1].WorkSheets[1].Name := 'Relat_Geral';
      xPlanilha                             := excel.WorkBooks[1].WorkSheets['Relat_Geral'];
      xPlanilha.Cells[1,1]                  := 'Produto';
      xPlanilha.Cells[1,1].Font.Bold        := True;
      xPlanilha.Cells[1,2]                  := 'Data';
      xPlanilha.Cells[1,2].Font.Bold        := True;
      xPlanilha.Cells[1,3]                  := 'Qtde.';
      xPlanilha.Cells[1,3].Font.Bold        := True;

      xInstallExcel := True;
    except
      on E: Exception do
      begin
        xInstallExcel := False;
      end;
    end;

    if xInstallExcel then
    begin
      listOfQuery := TList.Create;
      listOfQuery.Add(CGA035);
      listOfQuery.Add(CGA036);
      listOfQuery.Add(CGA100);
      listOfQuery.Add(CGA120);
      listOfQuery.Add(CGA039);
      listOfQuery.Add(CGA038);
      listOfQuery.Add(CGA040);
      listOfQuery.Add(CGA044);
      listOfQuery.Add(CGA043);
      listOfQuery.Add(CGA042);
      listOfQuery.Add(CGA041);
      listOfQuery.Add(CGA78);
      listOfQuery.Add(CGA75);
      listOfQuery.Add(CGA33);
      listOfQuery.Add(CGA68);
      listOfQuery.Add(CGA69);
      listOfQuery.Add(CGA130);


      AjustarProgressBar(ProgressBar, listOfQuery);
      panelBarra.Visible := True;

      xLinha := 2;
      GerarExcel(CGA035, 'Cons�rcio -> Produ��o Carta Senha', excel, xLinha);
      GerarExcel(CGA036, 'Cons�rcio -> Extrato Consorciado', excel, xLinha);
      GerarExcel(CGA100, 'Boleto de Recupera��o de Cr�dito', excel, xLinha);
      GerarExcel(CGA120, 'DRC Carta Convite', excel, xLinha);
      GerarExcel(CGA039, 'Extrato Finasa -> Boleto - CLI', excel, xLinha);
      GerarExcel(CGA038, 'Extrato Finasa -> Extrato - FPE', excel, xLinha);
      GerarExcel(CGA040, 'Extrato Finasa -> Carta - CLI', excel, xLinha);
      GerarExcel(CGA044, 'DRC Amex', excel, xLinha);
      GerarExcel(CGA043, 'DRC ZOGBI - MCSI', excel, xLinha);
      GerarExcel(CGA042, 'DRC Cart�o Fatura', excel, xLinha);
      GerarExcel(CGA041, 'DRC Private Label', excel, xLinha);
      GerarExcel(CGA78,  'DRC Aviso de Cobran�a - CLLP', excel, xLinha);
      GerarExcel(CGA75,  'Extrato Consolidado', excel, xLinha);
      GerarExcel(CGA33,  'Extrato Conta Corrente Poupan�a', excel, xLinha);
      GerarExcel(CGA68,  'Extrato Unificado', excel, xLinha);
      GerarExcel(CGA69,  'Extrato CVM / INVE', excel, xLinha);
      GerarExcel(CGA130, 'TanCode', excel, xLinha);

      excel.WorkBooks[1].Sheets[2].Delete;
      excel.WorkBooks[1].Sheets[2].Delete;
      excel.WorkBooks[1].Sheets[2].Delete;

      panelBarra.Visible   := False;
      ProgressBar.Position := 0;

      Application.Restore;

      try
        excel.WorkBooks[1].SaveAs(SaveDialog.FileName);
      except
        Application.MessageBox('N�o foi poss�vel salvar a planilha, salve-a antes de fech�-la !', 'Informa��o', MB_OK+MB_ICONINFORMATION);
      end;

      excel.Visible :=True;
      Application.MessageBox('Planilha(s) gerada(s) com sucesso !', 'Sucesso', MB_OK+MB_ICONINFORMATION);
    end
    else
    begin
      Application.MessageBox('Para gerar planilhas � necess�rio ter o Excel instalado na m�quina! Verifique.', 'Aten��o', MB_OK+MB_ICONWARNING);
    end;
  except
    on E: Exception do
    begin
      Application.MessageBox(PCHAR('Ocorreu um problema durante a gera��o da(s) planilhas! Erro:'+E.Message), 'ERRO', MB_OK+MB_ICONERROR);
      panelBarra.Visible    := False;
      Status.Panels[0].Text := '';
      Exit;
    end;
  end;
end;

{
    m�todo anterior (pega todos os dias entre as datas)
    xDias := 0;
    while IncDay(xDtFinal, -xDias) >= xDtInicial do
    begin
      xPlanilha.Cells[1,3+xDias] := StrToDate(FormatDateTime('DD/MM/YYYY', (xDtFinal-xDias)));
      xDias                      := xDias + 1;
    end;}

{
    Query.First;
    xFamiliaAtu := Query.FieldByName('DESCRICAO').AsString;
    xMotivoAtu  := Query.FieldByName('DS_MOTIVO').AsString;
    while not Query.Eof do
    begin
      if Query.FieldByName('DESCRICAO').AsString <> '' then
      begin
        if (xFamiliaAnt <> xFamiliaAtu) then
        begin
          xLinha := xLinha + 1;
          xPlanilha.Cells[xLinha, 1] := Query.FieldByName('DESCRICAO').AsString;
          xPlanilha.Cells[xLinha, 2] := Query.FieldByName('DS_MOTIVO').AsString;
        end
        else
        begin
          if (xMotivoAnt <> xMotivoAtu) then
          begin
            xLinha := xLinha + 1;
            xPlanilha.Cells[xLinha, 2] := Query.FieldByName('DS_MOTIVO').AsString;
          end;
        end;

        for I := 0 to Length(datas)-1 do
        begin
          if Query.FieldByName('DT_DEVOLUCAO').AsDateTime = datas[I] then
          begin
            xPlanilha.Cells[xLinha,colunaDias+I]:= Query.FieldByName('QTDDIA').AsInteger;
          end
          else
          begin
            xPlanilha.Cells[xLinha,colunaDias+I]:= 0;
          end;
        end;
      end
      else
      begin
        xLinha := xLinha + 1;
        xPlanilha.Cells[xLinha, 2] := Query.FieldByName('DS_MOTIVO').AsString;

        for I := 0 to Length(datas)-1 do
        begin
          xPlanilha.Cells[xLinha,colunaDias+I]:= 0;
        end;
      end;

      xFamiliaAnt := Query.FieldByName('DESCRICAO').AsString;
      xMotivoAnt  := Query.FieldByName('DS_MOTIVO').AsString;
      Query.Next;
      xFamiliaAtu := Query.FieldByName('DESCRICAO').AsString;
      xMotivoAtu  := Query.FieldByName('DS_MOTIVO').AsString;
    end;
    }

end.

