unit U_FrmCadToken;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TFrmCadToken = class(TForm)
    EdtCaixa: TEdit;
    LblCaixa: TLabel;
    BtnFechar: TBitBtn;
    LblTokenIni: TLabel;
    EdtTokenIni: TEdit;
    MemoDica: TMemo;
    LblTokenFin: TLabel;
    EdtTokenFin: TEdit;
    EdtQtde: TEdit;
    LblQtde: TLabel;
    BitBtnIncluir: TBitBtn;
    GroupBoxInfo: TGroupBox;
    LblCx: TLabel;
    LblTkn: TLabel;
    LblDt: TLabel;
    LblNmrCx: TLabel;
    LblNmrTkn: TLabel;
    LblDtUltCdstr: TLabel;
    StsRemSdx: TStatusBar;
    GroupBoxContagem: TGroupBox;
    LblTotalSessao: TLabel;
    LblTotal: TLabel;
    LblTotalSessaoNum: TLabel;
    LblTotalNum: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    LblCaixas: TLabel;
    LblCaixasNum: TLabel;
    procedure EdtTokenFinKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure BitBtnIncluirClick(Sender: TObject);
    procedure EdtTokenFinChange(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure EdtTokenFinExit(Sender: TObject);
    procedure EdtTokenIniKeyPress(Sender: TObject; var Key: Char);
    procedure EdtCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure EdtQtdeEnter(Sender: TObject);
  private
    { Private declarations }
    qtTknsSess : Integer;
  public
    { Public declarations }
  end;

var
  FrmCadToken: TFrmCadToken;

implementation

uses DmDados, U_Func;
{$R *.dfm}

procedure TFrmCadToken.BitBtnIncluirClick(Sender: TObject);
var sqlInsTk, cod, dv : String;
  qt, i : Integer;
  tkini, tkfin, cx : Int64;
begin
  sqlInsTk := 'INSERT INOT cga76 (cg76_remes,cg76_dtentr,cg76_caixa,cg76_codusu_dig,cg76_codentr) ' +#13#10 +
              'VALUES (:remes, CURRENT_DATE,:cxa, :codusudig, :codentr)';

  // ####### Validações
  // Caixa
  if Not TryStrToInt64(EdtCaixa.Text, cx) then
    begin
      Application.MessageBox(Pchar('O código da Caiax é inválido!'),
              'Address - ADS', MB_OK + MB_ICONWARNING);
      exit;
    end;

  // Token inicial
  if Not TryStrToInt64(Copy(EdtTokenIni.Text, 1, StrLen(Pchar(EdtTokenIni.Text))-1), tkini) then
    begin
      Application.MessageBox(Pchar('O código de Token Inicial é inválido.'),
              'Address - ADS', MB_OK + MB_ICONWARNING);
      exit;
    end;

  // Token Final
  if Not TryStrToInt64(Copy(EdtTokenFin.Text, 1, StrLen(PChar(EdtTokenfin.Text))-1), tkfin) then
    begin
      Application.MessageBox(Pchar('O código de Token Final é inválido.'),
              'Address - ADS', MB_OK + MB_ICONWARNING);
      exit;
    end;

  // Verificando valores
  if tkini >= tkfin then
    begin
      Application.MessageBox(Pchar('O código de Token Final deve ser maior que o de Token Inicial.'),
              'Address - ADS', MB_OK + MB_ICONWARNING);
      exit;
    end;

  qt := 1 + (tkfin - tkini);

  With Dm do
    begin
      // Iniciando uma transação
      SqlAux1.Close;
      SqlAux1.SQL.Text := 'START TRANSACTION';
      SqlAux1.ExecSQL;

      SqlAux1.SQL.Clear;
      SqlAux1.Sql.Add('INSERT INTO cga76 (cg76_remes, cg76_dtentr, cg76_caixa, cg76_codusu_dig, cg76_codentr) ');
      SqlAux1.Sql.Add('VALUES(:remes, CURRENT_DATE, :cxa, :codusudig, :codentr)');

      for i := 0 to qt - 1 do
        begin
          cod := IntToStr(i + tkini);
          dv := getTokenDV(cod);
          SqlAux1.ParamByName('remes').AsString := cod + dv;
          SqlAux1.ParamByName('cxa').AsInteger := cx;
          SqlAux1.ParamByName('codusudig').AsInteger := sqlcga_acessocodigo.Value;
          SqlAux1.ParamByName('codentr').AsString  :=  '119';
          try
            SqlAux1.ExecSQL;
            qtTknsSess := qtTknsSess + 1;
            LblTotalSessaoNum.Caption := IntToStr(qtTknsSess);
            LblTotalNum.Caption := IntToStr(StrToInt(LblTotalNum.Caption) + 1);
          except on e: exception do
            begin
              Application.MessageBox(
                  Pchar(
                    Format('O código de Token [%s-%s] já foi cadastrado anteriormente.', [cod, dv])
                    ), 'Address - ADS', MB_OK + MB_ICONWARNING);
              SqlAux1.SQL.Text := 'ROLLBACK';
              SqlAux1.ExecSQL;
              exit;
            end; // end except
          end; // end try
        end; // end for
      try
        SqlAux1.SQL.Text := 'COMMIT';
        SqlAux1.ExecSQL; // Terminando a transação
        // Reajustando o formulário
        BitBtnIncluir.Enabled := False;
        LblNmrCx.Caption := EdtCaixa.Text;
        LblNmrTkn.Caption := cod + '-' + dv;
        LblDtUltCdstr.Caption := FormatDateTime('dd/mm/yyyy', Date);
        LblCaixasNum.Caption := IntToStr(StrToInt(LblCaixasNum.Caption) + 1);
        EdtCaixa.Clear;
        EdtCaixa.SetFocus;
        EdtTokenIni.Clear;
        EdtTokenFin.Clear;
        EdtQtde.Text := '0';

        Application.MessageBox(
            Pchar(Format('%d Tokens cadastrados com sucesso parar a caixa %d.', [qt, cx])),
                'Address - ADS', MB_OK + MB_ICONWARNING);
      except on e: Exception do
        begin
          Application.MessageBox(
                  Pchar('Houve um problema ao concluir a operação! Contate o administrador do sistema.'),
                    'Address - ADS', MB_OK + MB_ICONWARNING);
        end;
      end;
    end; //end with
end;

procedure TFrmCadToken.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadToken.EdtCaixaKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Ord(Key) in [31..126]) and not (Key in ['0'..'9'])) then
    begin
      EdtTokenIni.SetFocus;
      Key := #0;
    end
  else
    if Key = #13 then
      EdtTokenIni.SetFocus;

end;

procedure TFrmCadToken.EdtQtdeEnter(Sender: TObject);
begin
    EdtQtde.SelectAll;
end;

procedure TFrmCadToken.EdtTokenFinChange(Sender: TObject);
var tkini, tkfin : Int64;
begin
  if (TryStrToInt64(Copy(EdtTokenIni.Text, 1, StrLen(Pchar(EdtTokenIni.Text))-1), tkini)) And
     TryStrToInt64(Copy(EdtTokenFin.Text, 1, StrLen(PChar(EdtTokenfin.Text))-1), tkfin)then
    begin
      if tkfin >= tkini then
        EdtQtde.Text := IntToStr(1 + tkfin - tkini);
        BitBtnIncluir.Enabled := True;
    end;
end;

procedure TFrmCadToken.EdtTokenFinExit(Sender: TObject);
var tkini, tkfin : Int64;
begin
  if Not TryStrToInt64(Copy(EdtTokenIni.Text, 1, StrLen(Pchar(EdtTokenIni.Text))-1), tkini) then
      begin
          Application.MessageBox(Pchar('O código de Token Inicial é inválido.'),
              'Address - ADS', MB_OK + MB_ICONWARNING);
          BitBtnIncluir.Enabled := False;
          exit;
      end;

  if Not TryStrToInt64(Copy(EdtTokenFin.Text, 1, StrLen(PChar(EdtTokenfin.Text))-1), tkfin) then
      begin
          Application.MessageBox(Pchar('O código de Token Final é inválido.'),
              'Address - ADS', MB_OK + MB_ICONWARNING);
          BitBtnIncluir.Enabled := False;
          exit;
      end;

  if tkini >= tkfin then
      begin
          Application.MessageBox(Pchar('O código de Token Final deve ser maior que o de Token Inicial.'),
              'Address - ADS', MB_OK + MB_ICONWARNING);
          BitBtnIncluir.Enabled := False;
          exit;
      end;

  EdtQtde.Text := IntToStr(1 + tkfin - tkini);
  BitBtnIncluir.Enabled := True;
end;

procedure TFrmCadToken.EdtTokenFinKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      BitBtnIncluir.SetFocus;

end;

procedure TFrmCadToken.EdtTokenIniKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Ord(Key) in [31..126]) and not (Key in ['0'..'9','-'])) then
    begin
      EdtTokenFin.SetFocus;
      Key := #0;
    end
  else
    if Key = #13 then
      EdtTokenFin.SetFocus;

end;

procedure TFrmCadToken.FormShow(Sender: TObject);
var tst : String;
begin
  qtTknsSess := 0;
  With Dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add('SELECT c.cg76_remes as num_token, ' );
      SqlAux1.SQL.Add('    c.cg76_dtentr as dt_entrada, c.cg76_caixa as caixa, ');
      SqlAux1.SQL.Add('    qtCxs, qtTkns ');
      SqlAux1.SQL.Add('FROM public.cga76 c ');
      SqlAux1.SQL.Add('INNER JOIN (');
      SqlAux1.SQL.Add('		 SELECT MAX(b.cg76_remes) as remess, ');
      SqlAux1.SQL.Add('        COUNT(DISTINCT b.cg76_remes) as qtTkns, ');
      SqlAux1.SQL.Add('        COUNT(DISTINCT b.cg76_caixa) as qtCxs ');
      SqlAux1.SQL.Add('		 FROM public.cga76 b ');
      SqlAux1.SQL.Add('		 	INNER JOIN (');
      SqlAux1.SQL.Add('		 	  SELECT MAX(a.cg76_dtentr) as dt ');
      SqlAux1.SQL.Add('		 	  FROM public.cga76 a ) dtmax ON (b.cg76_dtentr = dtmax.dt) ');
      SqlAux1.SQL.Add('		) d ON (c.cg76_remes = d.remess)');
      tst := SqlAux1.SQL.Text;
      SqlAux1.Open;
      if SqlAux1.RecordCount > 0 then
        begin
          LblNmrCx.Caption := SqlAux1.FieldByName('caixa').AsString;
          LblNmrTkn.Caption := SqlAux1.FieldByName('num_token').AsString;
          LblNmrTkn.Caption := Format('%s-%s', [copy(LblNmrTkn.Caption, 1, Length(LblNmrTkn.Caption) -1),
              copy(LblNmrTkn.Caption, Length(LblNmrTkn.Caption) - 1, 1)]);
          LblDtUltCdstr.Caption := SqlAux1.FieldByName('dt_entrada').AsString;
          LblTotalNum.Caption := SqlAux1.FieldByName('qtTkns').AsString;
          LblCaixasNum.Caption := SqlAux1.FieldByName('qtCxs').AsString;
        end;
    end;

end;

end.
