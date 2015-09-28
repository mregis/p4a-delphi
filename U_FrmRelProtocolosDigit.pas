unit U_FrmRelProtocolosDigit;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RLReport, RLBarcode, DmDados;

type
  TFrmRelProtocDigi = class(TForm)
    Protocolo: TRLReport;
    RLDetailGrid1: TRLDetailGrid;
    cep1: TRLLabel;
    cidade1: TRLLabel;
    bairro1: TRLLabel;
    uf1: TRLLabel;
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
    bairro2: TRLLabel;
    cidade2: TRLLabel;
    uf2: TRLLabel;
    cep2: TRLLabel;
    RLImage1: TRLImage;
    RLImage3: TRLImage;
    RLImage4: TRLImage;
    RLImage2: TRLImage;
    RLImage5: TRLImage;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLImage6: TRLImage;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    procedure RLDetailGrid1BeforePrint(Sender: TObject;
      var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelProtocDigi: TFrmRelProtocDigi;

implementation

{$R *.dfm}

procedure TFrmRelProtocDigi.RLDetailGrid1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  pnome1.Caption       := Dm.SqlRel.Fields[0].AsString;
  pnome2.Caption       := Dm.SqlRel.Fields[0].AsString;

  endereco1.Caption        := Dm.SqlRel.Fields[1].AsString;
  endereco2.Caption        := Dm.SqlRel.Fields[1].AsString;


  bairro1.Caption := Dm.SqlRel.Fields[2].AsString;
  bairro2.Caption := Dm.SqlRel.Fields[2].AsString;

  cidade1.Caption    := Dm.SqlRel.Fields[3].AsString;
  cidade2.Caption    := Dm.SqlRel.Fields[3].AsString;

  uf1.Caption      := Dm.SqlRel.Fields[4].AsString;
  uf2.Caption      := Dm.SqlRel.Fields[4].AsString;

  if Dm.SqlRel.Fields[5].AsString<>'     -' then
      begin
        cep1.Caption     := Dm.SqlRel.Fields[5].AsString;
        cep2.Caption     := Dm.SqlRel.Fields[5].AsString;
      end
    else
      begin
        cep1.Caption     := '';
        cep2.Caption     := '';
      end;
end;

end.
