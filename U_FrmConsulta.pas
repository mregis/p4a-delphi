unit U_FrmConsulta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls;

type
  TFrmConsulta = class(TForm)
    ScrollBox1: TScrollBox;
    EditToken: TLabeledEdit;
    EdNumLote: TLabeledEdit;
    DBGridToken: TDBGrid;
    BtnFechar: TBitBtn;
    BtnConsulta: TBitBtn;
    LabEdQtde: TLabeledEdit;
    EdDTB: TLabeledEdit;
    procedure EdNumLoteKeyPress(Sender: TObject; var Key: Char);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnConsultaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
  dtb,remes,lote,msel:string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConsulta: TFrmConsulta;

implementation

uses DmDados, U_Func;

{$R *.dfm}

procedure TFrmConsulta.EdNumLoteKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
  begin
    if (trim(EdNumLote.Text) <> '') and (vernum(trim(EdNumLote.Text)) = true) then
      begin
       EdNumLote.Text  :=  GeraNT(trim(EdNumLote.Text),6);
       BtnConsulta.SetFocus;
     end;
   end;
end;

procedure TFrmConsulta.BtnFecharClick(Sender: TObject);
begin
close;
end;

procedure TFrmConsulta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := cafree;
end;

procedure TFrmConsulta.BtnConsultaClick(Sender: TObject);
begin
  remes  := '';
  lote   := '';
  dtb    := '';
  LabEdQtde.Text  :=  '0';
  if (trim(EditToken.Text) <> '') and (vernum(trim(EditToken.Text)) = true) then
    remes  := '(cg76_remes = '+chr(39)+trim(EditToken.Text)+chr(39)+')';
  if (trim(EdNumLote.Text) <> '') and (vernum(trim(EdNumLote.Text)) = true) then
    lote := '(cg76_numlote = '+chr(39)+trim(EdNumLote.Text)+chr(39)+')';
  if (trim(EdDTB.Text) <> '') and (vernum(trim(EdDTB.Text)) = true) then
    dtb :=  '(cg76_dtb = '+chr(39)+trim(EdDTB.Text) + chr(39) +' )';
  msel:= 'select cg76_remes as Token,cg76_ag as Agência,cg76_dtb as DTB,cg76_dtsai as Data,';
  msel:=msel+'cg76_numlote as Lote,cga_acesso.nome as Usuário from cga76 ';
  msel:=msel+'full join cga_acesso on cga76.cg76_codusu = cga_acesso.codigo where ';
  if (trim(EditToken.Text) = '') and (trim(EdNumLote.Text) = '') and (trim(EdDTB.Text) = '') then
    begin
      Application.MessageBox('Digite Token ou Nr do Lote ou DTB','ADS',MB_OK+MB_ICONERROR);
      EditToken.SetFocus;
      exit;
    end
  else
    begin
      if (trim(remes) = '') and (trim(lote) <> '') and (trim(dtb) = '') then
          msel:=msel+lote
      else
        begin
          if (trim(remes) <> '') and (trim(lote) = '') and (trim(dtb) = '') then
            msel:=msel+remes
          else
            begin
              if (trim(remes) = '') and (trim(lote) = '') and (trim(dtb) <> '') then
                msel:= msel+dtb
                else
                  begin
                    if (trim(remes) <> '') and (trim(lote) = '') and (trim(dtb) <> '') then
                        msel:=msel+remes+' and '+dtb
                      else
                        begin
                          if (trim(remes) = '') and (trim(lote) <> '') and (trim(dtb) <> '') then
                            msel:=msel+dtb+' and '+lote
                          else
                            begin
                              if (trim(remes) <> '') and (trim(lote) <> '') and (trim(dtb) = '') then
                                msel:=msel+remes+' and '+lote
                              else
                                msel:=msel+remes+' and '+dtb+' and '+lote;
                            end;
                        end;
                  end;
            end;
        end;
    end;
    msel:=msel+' order by cg76_remes';
    with dm do
      begin
        dm.ZROQToken.Close;
        dm.ZROQToken.SQL.Clear;
        dm.ZROQToken.SQL.Add(msel);
        dm.ZROQToken.Open;
        case dm.ZROQToken.RecordCount of
          0:
            begin
              Application.MessageBox('Sem Registros para os Parametros acima','ADS',MB_OK+MB_ICONERROR);
              EditToken.SetFocus;
              exit;
            end;
          else
          LabEdQtde.Text  :=  GeraNt(inttostr(ZROQToken.RecordCount),6);
            DBGridToken.Refresh;
        end;
      end;
end;

procedure TFrmConsulta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=13)then
    SelectNext(ActiveControl,True,True);

end;

end.
