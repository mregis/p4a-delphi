unit UFrTokenBradesco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport;

type
  TFrmFrTokenBradesco = class(TForm)
    FrTokenBradesco: TRLReport;
    RLBand1: TRLBand;
    RlTipoRelat: TRLLabel;
    RlPeriodo: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    Rldata: TRLLabel;
    Rlqt: TRLLabel;
    RlRetorno: TRLLabel;
    RlEnvio: TRLLabel;
    RLBand4: TRLBand;
    RLLabel2: TRLLabel;
    RLLabel4: TRLLabel;
    RLBand6: TRLBand;
    RLLabel6: TRLLabel;
    RLLabel5: TRLLabel;
    RLMemo1: TRLMemo;
    RlRemes: TRLLabel;
    RlAgencia: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RlTipoCli: TRLLabel;
    RLImage1: TRLImage;
    RLRListaToken: TRLReport;
    RLBand5: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLImage2: TRLImage;
    RLGroup2: TRLGroup;
    RLBand7: TRLBand;
    RLLabel14: TRLLabel;
    RLDBText1: TRLDBText;
    RLLabel13: TRLLabel;
    RLDBText2: TRLDBText;
    RLGroup3: TRLGroup;
    RLBand11: TRLBand;
    RLBand8: TRLBand;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLDBText3: TRLDBText;
    RLLabel18: TRLLabel;
    RLDBText4: TRLDBText;
    RLDraw2: TRLDraw;
    RLDBText5: TRLDBText;
    RLLabel21: TRLLabel;
    RLDraw8: TRLDraw;
    RLBand9: TRLBand;
    RLLabel19: TRLLabel;
    RLDBResult1: TRLDBResult;
    RLDraw6: TRLDraw;
    RLBand10: TRLBand;
    RLLabel20: TRLLabel;
    RLDBResult2: TRLDBResult;
    RLDraw4: TRLDraw;
    RLLabel22: TRLLabel;
    procedure RLBand8BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand5BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand4AfterPrint(Sender: TObject);
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFrTokenBradesco: TFrmFrTokenBradesco;

implementation

uses DmDados,U_pesqImp;

{$R *.dfm}

procedure TFrmFrTokenBradesco.RLBand3BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  Rldata.caption := formatdatetime('dd/mm/yyyy',Dm.SqlRel.Fields[2].AsDateTime);
  Rlqt.Caption   := inttostr(Dm.SqlRel.Fields[0].AsInteger);
  RLLabel4.Caption := inttostr(Dm.SqlRel.Fields[0].AsInteger+strtoint(RLLabel4.Caption));
  RLLabel5.Caption := inttostr(Dm.SqlRel.Fields[0].AsInteger+strtoint(RLLabel5.Caption));
  RlRemes.Caption  := Dm.SqlRel.Fields[1].Value;
  case tag of
    //4:
    5:
      begin
        if Dm.SqlRel.Fields[3].Value <> null then
          RlRetorno.Caption := 'Retorno: '+ formatdatetime('dd/mm/yyyy',Dm.SqlRel.Fields[3].Asdatetime)
        else
          RlRetorno.Caption := 'Retorno: Não Gerado';
        if Dm.SqlRel.Fields[4].Value <> null then
          RlEnvio.Caption := 'Data de Envio: '+ formatdatetime('dd/mm/yyyy',Dm.SqlRel.Fields[3].Asdatetime)
        else
          RlEnvio.Caption := 'Data de Envio: Não Enviado';
      end;

    //6:
    //7:
  end;
end;

procedure TFrmFrTokenBradesco.RLBand4AfterPrint(Sender: TObject);
begin
  RLLabel4.Caption := '0';
end;

procedure TFrmFrTokenBradesco.RLBand5BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
{  case v_tipocli of
    0: RLLabel12.Caption := 'Pessoa Física';
    1: RLLabel12.Caption := 'Pessoa Jurídica';
    2: RLLabel12.Caption := 'Todos';
  end;}
  RLLabel12.Caption := 'PESSOA FISICA / JURIDICA';
end;

procedure TFrmFrTokenBradesco.RLBand8BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add('select cg77_tokini,cg77_tokfin from cga77 where ');
      SqlAux1.SQL.Add('(cg77_dtb = :dtb) and (cg77_ag = :ag) and (cg77_numlote = :numlote)');
      SqlAux1.Params[0].AsString :=  trim(dm.ZOQListaTokencg76_dtb.AsString);
      SqlAux1.Params[1].AsString :=  trim(dm.ZOQListaTokencg76_ag.AsString);
      SqlAux1.Params[2].AsString :=  trim(dm.ZOQListaTokencg76_numlote.AsString);
      SqlAux1.Open;
      if SqlAux1.RecordCount = 1 then
        RLLabel21.Caption := 'Token Inicial: '+SqlAux1.Fields[0].AsString+ ' Token Final: '+SqlAux1.Fields[1].AsString;
    end;

end;

procedure TFrmFrTokenBradesco.RLBand2BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  RlAgencia.Caption := 'Agência : '+FrmPesqImp.EdAgIni.Text + '     DTB: '+dm.SqlRel.Fields[3].AsString;
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add('select cg77_tokini,cg77_tokfin from cga77 where ');
      SqlAux1.SQL.Add('(cg77_dtb = :dtb) and (cg77_ag = :ag) and (cg77_numlote = :numlote)');
      SqlAux1.Params[0].AsString :=  trim(dm.ZOQListaTokencg76_dtb.AsString);
      SqlAux1.Params[1].AsString :=  trim(dm.ZOQListaTokencg76_ag.AsString);
      SqlAux1.Params[2].AsString :=  trim(dm.ZOQListaTokencg76_numlote.AsString);
      SqlAux1.Open;
      case SqlAux1.RecordCount of
        1:RlAgencia.Caption := RlAgencia.Caption+' '+'Token Inicial: '+SqlAux1.Fields[0].AsString+
        ' '+'Token Final: '+SqlAux1.Fields[1].AsString;
      end;
    end;
end;

procedure TFrmFrTokenBradesco.RLBand1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
{  case v_tipocli of
    0: RlTipoCli.Caption := 'Pessoa Física';
    1: RlTipoCli.Caption := 'Pessoa Jurídica';
    2: RlTipoCli.Caption := 'Todos';
  end;}
RlTipoCli.Caption := 'PESSOA FISICA / JURIDICA';
end;

end.
