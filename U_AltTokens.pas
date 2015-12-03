unit U_AltTokens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ComCtrls, Buttons, ExtCtrls;

type
  TFrmAltToken = class(TForm)
    GrpBxInfoEnvio: TGroupBox;
    LabelDtIni: TLabel;
    DtPickerDtBaixa: TDateTimePicker;
    LabelAgencia: TLabel;
    EdAgencia: TEdit;
    Label1: TLabel;
    EdNumLote: TEdit;
    LabelGRM: TLabel;
    EdDTB: TEdit;
    RdGrpTpCadastro: TRadioGroup;
    BtnDesvincular: TBitBtn;
    BtnFechar: TBitBtn;
    StBr: TStatusBar;
    BitBtnLimpar: TBitBtn;
    procedure BitBtnLimparClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdAgenciaKeyPress(Sender: TObject; var Key: Char);
    procedure EdNumloteKeyPress(Sender: TObject; var Key: Char);
    procedure BtnDesvincularClick(Sender: TObject);
    procedure EdDTBKeyPress(Sender: TObject; var Key: Char);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure limpa;
    procedure proccga76_cga77;
    procedure proccga77;
  private
  dtsai, dtb, dtb1 : String;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAltToken: TFrmAltToken;

implementation

uses U_Func, DmDados;

{$R *.dfm}

procedure TFrmAltToken.EdAgenciaKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    #13:
      begin
        if (vernum(trim(EdAgencia.Text))= false) then
          begin
            Application.MessageBox('Digite apenas Números !','ADS',MB_OK+MB_ICONERROR);
            EdAgencia.SetFocus;
          end
        else
          EdAgencia.Text := LPad(EdAgencia.Text, 4, '0');
      end
  end;

end;

procedure TFrmAltToken.EdNumloteKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
      begin
        if (vernum(trim(EdNumlote.Text)) = false) then
          begin
            application.MessageBox('Digite apenas Números "','ADS',MB_OK+MB_ICONERROR);
            EdAgencia.SetFocus;
          end
          else
            Ednumlote.Text:=GeraNt(trim(Ednumlote.Text),6);
      end;
end;

procedure TFrmAltToken.BitBtnLimparClick(Sender: TObject);
begin
  limpa;
end;

procedure TFrmAltToken.BtnDesvincularClick(Sender: TObject);
begin
  if (trim(EdDTB.Text) <> '') then
    begin
      dtb  := 'and (cg76_dtb = '+chr(39)+trim(EdDTB.Text)+chr(39)+') ';
      dtb1:= 'and (cg77_dtb = '+chr(39)+trim(EdDTB.Text)+chr(39)+') ';
    end;
  if (DtPickerDtBaixa.Checked) then
    dtsai  :=  'and (cg76_dtsai = ''' +
        formatdatetime('yyyy-mm-dd', DtPickerDtBaixa.Date) + ''') ';

  case RdGrpTpCadastro.ItemIndex of
    0: proccga76_cga77;
    1: proccga77;
  end;
end;

procedure TFrmAltToken.proccga76_cga77;
begin
  with dm do
    begin
      if (trim(EdAgencia.Text) = '') or (trim(EdNumlote.Text) = '')then
        begin
          application.MessageBox('Necessário Digitar o Nº da Agência e Nº do Lote', 'ADS', MB_OK + MB_ICONERROR);
          EdAgencia.SetFocus;
          exit;
        end
      else
        begin
          SqlAux1.Close;
          SqlAux1.SQL.Clear;
          SqlAux1.SQL.Add('SELECT COUNT(cg76_ag) ');
          SqlAux1.SQL.Add('FROM cga76 ');
          SqlAux1.SQL.Add('WHERE (cg76_ag = :ag OR cg76_ag = :ag2)');
          SqlAux1.SQL.Add('    AND cg76_numlote = :lote');
          if (trim(EdDTB.Text) <> '') then
            begin
              SqlAux1.SQL.Add('    AND cg76_dtb = :dtb ');
              SqlAux1.ParamByName('dtb').AsString := trim(EdDTB.Text);
            end;

          if (DtPickerDtBaixa.Checked) then
            begin
              SqlAux1.SQL.Add('    AND cg76_dtsai = :dtsai');
              SqlAux1.ParamByName('dtsai').AsDate := DtPickerDtBaixa.Date;
            end;

          SqlAux1.ParamByName('ag').AsString :=  LPad(trim(EdAgencia.Text), 4, '0');
          SqlAux1.ParamByName('ag2').AsInteger :=  StrToInt(EdAgencia.Text);
          SqlAux1.ParamByName('lote').AsString :=  LPad(trim(EdNumlote.Text), 6, '0');
          SqlAux1.Open;
          case SqlAux1.Fields[0].Value of
            0:  begin
                  application.MessageBox('Não há Registro Baixado!','ADS', MB_OK+MB_ICONERROR);
                  EdAgencia.SetFocus;
                  exit;
                end;
            else
              begin
                SqlAux1.Close;
                SqlAux1.SQL.Clear;
                SqlAux1.SQL.Add('UPDATE cga76 ');
                SqlAux1.SQL.Add('SET cg76_codbaixa = null, cg76_dtb=null, ');
                SqlAux1.SQL.Add(' cg76_ag = null, cg76_numlote=null, cg76_dtsai=null');
                SqlAux1.SQL.Add('WHERE (cg76_ag = :ag OR cg76_ag = :ag2) ');
                SqlAux1.SQL.Add('   AND cg76_numlote = :lote');
                if (trim(EdDTB.Text) <> '') then
                  begin
                    SqlAux1.SQL.Add('    AND cg76_dtb = :dtb ');
                    SqlAux1.ParamByName('dtb').AsString := trim(EdDTB.Text);
                  end;

                if (DtPickerDtBaixa.Checked) then
                  begin
                    SqlAux1.SQL.Add('    AND cg76_dtsai = :dtsai');
                    SqlAux1.ParamByName('dtsai').AsDate := DtPickerDtBaixa.Date;
                  end;

                SqlAux1.ParamByName('ag').AsString :=  LPad(trim(EdAgencia.Text), 4, '0');
                SqlAux1.ParamByName('ag2').AsInteger :=  StrToInt(EdAgencia.Text);
                SqlAux1.ParamByName('numlote').AsString :=  LPad(trim(EdNumlote.Text), 6, '0');

                try
                  SqlAux1.ExecSQL;

                  SqlAux1.Close;
                  SqlAux1.SQL.Clear;
                  SqlAux1.SQL.Add('UPDATE cga77 ');
                  SqlAux1.SQL.Add('SET cg77_tokini = 0, cg77_tokfin = 0, cg77_status = 0 ');
                  SqlAux1.SQL.Add('WHERE (cg77_ag = :ag OR cg77_ag = :ag2) ');
                  SqlAux1.SQL.Add('   AND cg77_numlote = :lote');
                  if (trim(EdDTB.Text) <> '') then
                    begin
                      SqlAux1.SQL.Add('    AND cg77_dtb = :dtb ');
                      SqlAux1.ParamByName('dtb').AsString := trim(EdDTB.Text);
                    end;

                  SqlAux1.ParamByName('ag').AsString :=  LPad(trim(EdAgencia.Text), 4, '0');
                  SqlAux1.ParamByName('ag2').AsInteger :=  StrToInt(EdAgencia.Text);
                  SqlAux1.ParamByName('lote').AsString :=  LPad(trim(EdNumlote.Text), 6, '0');

                  try
                    SqlAux1.ExecSQL;
                  except on e: exception do
                    begin
                      application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'ADS',MB_OK+MB_ICONERROR);
                      EdAgencia.SetFocus;
                      exit;
                    end;
                  end;

                except on e: exception do
                  begin
                    application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                    EdAgencia.SetFocus;
                    exit;
                  end;
                end;
                limpa;
                EdAgencia.SetFocus;
              end;
          end;
        end;
    end;
end;

procedure TFrmAltToken.EdDTBKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      if (trim(EdDTB.Text) <> '') then
        begin
          if (vernum(trim(EdDTB.Text)) = false) then
            begin
              application.MessageBox('Digite apenas Números, ou deixe em branco "','ADS',MB_OK+MB_ICONERROR);
              EdAgencia.SetFocus;
            end;
        end;
    end;

end;


procedure TFrmAltToken.BtnFecharClick(Sender: TObject);
begin
close;
end;

procedure TFrmAltToken.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
action := cafree;
end;
procedure TFrmAltToken.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (Key = VK_RETURN) then //(key = 4100 or key = 4101) then
  SelectNext(ActiveControl,True,True);
end;

procedure TFrmAltToken.limpa;
begin
  EdAgencia.Clear;
  EdNumlote.Clear;
  EdDTB.Clear;
  DtPickerDtBaixa.Checked := false;
  RdGrpTpCadastro.ItemIndex := -1;
end;

procedure TFrmAltToken.proccga77;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;

      SqlAux1.SQL.Add('UPDATE cga77 ');
      SqlAux1.SQL.Add('SET cg77_tokini = 0, cg77_tokfin = 0, cg77_status = 0 ');
      SqlAux1.SQL.Add('WHERE (cg77_ag = :ag OR cg77_ag = :ag2) ');
      SqlAux1.SQL.Add('   AND cg77_numlote = :lote');
      if (trim(EdDTB.Text) <> '') then
        begin
          SqlAux1.SQL.Add('    AND cg77_dtb = :dtb ');
          SqlAux1.ParamByName('dtb').AsString := trim(EdDTB.Text);
        end;

      SqlAux1.ParamByName('ag').AsString :=  LPad(trim(EdAgencia.Text), 4, '0');
      SqlAux1.ParamByName('ag2').AsInteger :=  StrToInt(EdAgencia.Text);
      SqlAux1.ParamByName('numlote').AsString :=  LPad(trim(EdNumlote.Text), 6, '0');

      try
        SqlAux1.ExecSQL;
        if (SqlAux1.RowsAffected = 0) then
          begin
            Application.MessageBox(PChar('Nenhum registro foi alterado!'+ #13#10 +
                'Verifique com o CPD'), 'ADS', MB_OK + MB_ICONWARNING);
            EdAgencia.SetFocus;
          end;
      except on e: exception do
        begin
          application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
          EdAgencia.SetFocus;
          exit;
        end;
      end;

    end;
end;
end.
