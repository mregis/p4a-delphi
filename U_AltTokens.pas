unit U_AltTokens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ComCtrls, Buttons, ExtCtrls;

type
  TFrmAltToken = class(TForm)
    ScrollBox1: TScrollBox;
    Panel4: TPanel;
    BtnFechar: TBitBtn;
    StBr: TStatusBar;
    EdAgencia: TMaskEdit;
    EdNumlote: TEdit;
    Panel6: TPanel;
    BtnLiberar: TBitBtn;
    EdDTB: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    MkEdDtSai: TMaskEdit;
    RadioGroup1: TRadioGroup;
    procedure EdAgenciaKeyPress(Sender: TObject; var Key: Char);
    procedure EdNumloteKeyPress(Sender: TObject; var Key: Char);
    procedure BtnLiberarClick(Sender: TObject);
    procedure EdDTBKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure limpa;
    procedure proccga76_cga77;
    procedure proccga77;
  private
  msel,dtsai,dtb,dtb1,delreg:string;

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
          end;
      end
  end;

end;

procedure TFrmAltToken.EdNumloteKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    #13:
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
end;

procedure TFrmAltToken.BtnLiberarClick(Sender: TObject);
begin
  if (trim(EdDTB.Text) <> '') then
    begin
      dtb  := 'and (cg76_dtb = '+chr(39)+trim(EdDTB.Text)+chr(39)+') ';
      dtb1:= 'and (cg77_dtb = '+chr(39)+trim(EdDTB.Text)+chr(39)+') ';
    end;
  if (MkEdDtSai.Text <> ('  /  /    ')) then
    begin
//    self.MkEdDtSai.EditMask :=
    dtsai  :=  'and (cg76_dtsai = '+chr(39)+formatdatetime('mm/dd/yyyy',strtodate(MkEdDtSai.Text))+char(39)+') ';
    end;
  case RadioGroup1.ItemIndex of
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
          application.MessageBox('Necessário Digitar o nr da Agência e nr do Lote','SPT',MB_OK+MB_ICONERROR);
          EdAgencia.SetFocus;
          exit;
        end
      else
        begin
          msel :=  'select count(cg76_ag) from cga76 where (cg76_ag = :ag) and (cg76_numlote = :lote) ';
          msel :=  msel+dtb+dtsai;
          SqlAux1.Close;
          SqlAux1.SQL.Clear;
          SqlAux1.SQL.Add(msel);
          SqlAux1.Params[0].AsString :=  trim(EdAgencia.Text);
          SqlAux1.Params[1].AsString :=  trim(EdNumlote.Text);
          SqlAux1.Open;
          case SqlAux1.Fields[0].Value of
            0:  begin
                  application.MessageBox('Não há Registro Baixado!','SPT',MB_OK+MB_ICONERROR);
                  EdAgencia.SetFocus;
                  exit;
                end;
            else
              begin
                delreg  :=  'update cga76 set cg76_codbaixa=null,cg76_dtb=null,';
                delreg  :=  delreg  +'cg76_ag = null,cg76_numlote=null,cg76_dtsai=null ';
                delreg  :=  delreg  +'where (cg76_ag = :ag) and (cg76_numlote = :lote) ';
                delreg  :=  delreg  + dtb + dtsai;
                SqlAux1.Close;
                SqlAux1.SQL.Clear;
                SqlAux1.SQL.Add(delreg);
                SqlAux1.Params[0].AsString :=  trim(EdAgencia.Text);
                SqlAux1.Params[1].AsString :=  trim(EdNumlote.Text);
                try
                  SqlAux1.ExecSQL;
                  delreg  :=  'update cga77 set cg77_tokini = 0,cg77_tokfin = 0,cg77_status = 0 where (cg77_ag = :ag) and (cg77_numlote = :lote) ';
                  delreg  :=  delreg  + dtb1;
                  SqlAux1.Close;
                  SqlAux1.SQL.Clear;
                  SqlAux1.SQL.Add(delreg);
                  SqlAux1.Params[0].AsString :=  trim(EdAgencia.Text);
                  SqlAux1.Params[1].AsString :=  gerant(trim(EdNumlote.Text),6);
                  try
                    SqlAux1.ExecSQL;
                  except on e: exception do
                    begin
                      application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
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
  case key of
    #13:
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

end;

procedure TFrmAltToken.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (KEY = 13) then //(key = 4100 or key = 4101) then
  SelectNext(ActiveControl,True,True);
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
procedure TFrmAltToken.limpa;
begin
  EdAgencia.Clear;
  EdNumlote.Clear;
  EdDTB.Clear;
  MkEdDtSai.Clear
end;
procedure TFrmAltToken.proccga77;
begin
  with dm do
    begin
      delreg  :=  'update cga77 set cg77_tokini = 0,cg77_tokfin = 0,cg77_status = 0 where (cg77_ag = :ag) and (cg77_numlote = :lote) ';
      delreg  :=  delreg  + dtb1;
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add(delreg);
      SqlAux1.Params[0].AsString :=  trim(EdAgencia.Text);
      SqlAux1.Params[1].AsString :=  gerant(trim(EdNumlote.Text),6);
      try
        SqlAux1.ExecSQL;
        if (SqlAux1.RowsAffected = 0) then
          begin
            Application.MessageBox(PChar('Não há registro para esses parametros !'+chr(10)+'Verifique com o CPD'),'ADS',0);
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
