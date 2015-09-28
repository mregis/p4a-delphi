unit RelCons;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport;

type
  TFrmRelCons = class(TForm)
    RLReport1: TRLReport;
    RLGroup1: TRLGroup;
    RLGroup2: TRLGroup;
    RLBand1: TRLBand;
    RLLabel2: TRLLabel;
    RLBand2: TRLBand;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLBand4: TRLBand;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLBand3: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDraw1: TRLDraw;
    RLBand5: TRLBand;
    RLDBResult2: TRLDBResult;
    RLLabel1: TRLLabel;
    RLBand6: TRLBand;
    RLLabel11: TRLLabel;
    RLReport2: TRLReport;
    RLBand11: TRLBand;
    RLBand9: TRLBand;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel21: TRLLabel;
    RLBand8: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBResult3: TRLDBResult;
    RLDraw2: TRLDraw;
    RLDraw3: TRLDraw;
    RLDraw4: TRLDraw;
    procedure RLBand9BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand12BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand6BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand6AfterPrint(Sender: TObject);
    procedure RLBand4BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLGroup2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLGroup1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelCons: TFrmRelCons;

implementation

uses DmDados, DB, U_PesqImp;

{$R *.dfm}

procedure TFrmRelCons.RLBand12BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
RLLabel21.Caption  :='Produção Ref. Período:'+FrmPesqImp.MkEdDtIni.Text + ' À '+ FrmPesqImp.MkEdDtFin.Text;
end;

procedure TFrmRelCons.RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin

//RLLabel2.Caption  := UpperCase(Dm.SqlRel.Fields[1].AsString);// usuario
end;

procedure TFrmRelCons.RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
RLLabel3.Caption  := Dm.SqlRel.Fields[3].AsString;
RLLabel4.Caption  := FormatFloat('##.###.###;;',Dm.SqlRel.Fields[0].Value);
RLLabel5.Caption  := formatdatetime('dd/mm/yyyy',Dm.SqlRel.Fields[1].AsDateTime);
end;

procedure TFrmRelCons.RLBand4BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
//RLLabel11.Caption :=  RLLabel11.Caption + FrmPesqImp.MkEdDtIni.Text + ' À '+ FrmPesqImp.MkEdDtFin.Text;
RLLabel1.Caption  := UpperCase(Dm.SqlRel.Fields[2].AsString);// usuario
end;

procedure TFrmRelCons.RLBand6AfterPrint(Sender: TObject);
begin
//if dm.  then

RLLabel11.Caption  :='Produção Ref. Período:'
end;

procedure TFrmRelCons.RLBand6BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
RLLabel11.Caption  :='Produção Ref. Período:'+FrmPesqImp.MkEdDtIni.Text + ' À '+ FrmPesqImp.MkEdDtFin.Text;
end;

procedure TFrmRelCons.RLBand9BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
RLLabel21.Caption  :='Produção Ref. Período:'+FrmPesqImp.MkEdDtIni.Text + ' À '+ FrmPesqImp.MkEdDtFin.Text;
end;

procedure TFrmRelCons.RLGroup1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  {
   0    quantidade
   1    data
   2    usuario
   3    tipo serviço
  }
  RLGroup1.DataFields := Dm.SqlRel.Fields[2].FieldName;
end;

procedure TFrmRelCons.RLGroup2BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  RLGroup2.DataFields := Dm.SqlRel.Fields[2].FieldName+';'+Dm.SqlRel.Fields[1].FieldName;
end;

end.
