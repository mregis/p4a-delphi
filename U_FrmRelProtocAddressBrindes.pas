unit U_FrmRelProtocAddressBrindes;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RLReport;

type
  TFrmRelProtocAddress = class(TForm)
    Protocolo: TRLReport;
    RLDetailGrid1: TRLDetailGrid;
    cep1: TRLLabel;
    RLLabel1: TRLLabel;
    endereco1: TRLLabel;
    pnome1: TRLLabel;
    RLLabel9: TRLLabel;
    RLDraw2: TRLDraw;
    RLLabel10: TRLLabel;
    RLDraw3: TRLDraw;
    RLLabel11: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel15: TRLLabel;
    pnome2: TRLLabel;
    endereco2: TRLLabel;
    tel2: TRLLabel;
    cep2: TRLLabel;
    RLImage1: TRLImage;
    RLImage3: TRLImage;
    RLImage4: TRLImage;
    RLImage2: TRLImage;
    RLImage5: TRLImage;
    RLImage6: TRLImage;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLBand1: TRLBand;
    tel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    procedure RLDetailGrid1BeforePrint(Sender: TObject;
      var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelProtocAddress: TFrmRelProtocAddress;

implementation

uses DmDados;

{$R *.dfm}

procedure TFrmRelProtocAddress.RLDetailGrid1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  pnome1.Caption       := Dm.SqlRel.Fields[0].AsString;
  pnome2.Caption       := Dm.SqlRel.Fields[0].AsString;

  endereco1.Caption        := Dm.SqlRel.Fields[1].AsString;
  endereco2.Caption        := Dm.SqlRel.Fields[1].AsString;


  if Dm.SqlRel.Fields[2].AsString<>'     -' then
      begin
        cep1.Caption     := Dm.SqlRel.Fields[2].AsString;
        cep2.Caption     := Dm.SqlRel.Fields[2].AsString;
      end
    else
      begin
        cep1.Caption     := '';
        cep2.Caption     := '';
      end;

  tel1.Caption    := Dm.SqlRel.Fields[3].AsString;
  tel2.Caption    := Dm.SqlRel.Fields[3].AsString;

end;

end.
