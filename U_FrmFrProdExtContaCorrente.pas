unit U_FrmFrProdExtContaCorrente;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RLReport, RLFilters, RLPDFFilter;

type
  TFrmFrProdExtContaCorrente = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RlTipoRelat: TRLLabel;
    RlPeriodo: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLDraw1: TRLDraw;
    RlBaixa: TRLLabel;
    Rldata: TRLLabel;
    Rlqt: TRLLabel;
    RLBand4: TRLBand;
    RLLabel2: TRLLabel;
    RLBand5: TRLBand;
    RLLabel4: TRLLabel;
    RlRetorno: TRLLabel;
    RlEnvio: TRLLabel;
    RLMemRet: TRLMemo;
    RLBand6: TRLBand;
    RLDraw3: TRLDraw;
    RLLabel6: TRLLabel;
    RLLabel5: TRLLabel;
    RLMemo1: TRLMemo;
    RLDraw2: TRLDraw;
    RLLabel3: TRLLabel;
    RLBand7: TRLBand;
    RLLabel7: TRLLabel;
    RLPDFFilter1: TRLPDFFilter;
    procedure RLBand7BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand6BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLGroup1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand4AfterPrint(Sender: TObject);
    procedure RLBand5BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    v1, v2, v3, v5, v6, v7, v8, v9 : Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFrProdExtContaCorrente: TFrmFrProdExtContaCorrente;

implementation

uses DmDados, U_Func, DB, U_PesqImp, U_Principal;

{$R *.dfm}

procedure TFrmFrProdExtContaCorrente.RLGroup1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  case FrmFrProdExtContaCorrente.Tag of
  4,6,7,8,26,28,38,42,44,46..78:                                              {FATURA DE CARTAO DE CREDITO}
    begin
      RlBaixa.Caption := Dm.SqlRel.Fields.Fields[2].Value;
    end
  else                                 {O QUE NAO FOR FATURA CARTÃO DE CREADITO}
    begin
      RlBaixa.Caption := Dm.SqlRel.Fields[2].Value;
    end;
  end;
end;

procedure TFrmFrProdExtContaCorrente.RLBand3BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  case FrmFrProdExtContaCorrente.Tag of
  4,6,7,8,26,28,38,42,44,45,46..49:                                                 {FATURA CARTAO DE CREDITO}
    begin
      case Dm.SqlRel.Fields[3].AsInteger of
      106: v1  := v1 + Dm.SqlRel.Fields[0].AsInteger;                 {MUDOU-SE}

      103: v2  := v2 + Dm.SqlRel.Fields[0].AsInteger;         {END INSUFICIENTE}

      112: v3  := v3 + Dm.SqlRel.Fields[0].AsInteger;                 {FALECIDO}

      102: v5  := v5 + Dm.SqlRel.Fields[0].AsInteger;             {DESCONHECIDO}

      100: v6  := v6 + Dm.SqlRel.Fields[0].AsInteger;                  {AUSENTE}

      108: v7  := v7 + Dm.SqlRel.Fields[0].AsInteger;          {NUMERO N EXISTE}

      116: v8  := v8 + Dm.SqlRel.Fields[0].AsInteger;                   {OUTROS}

      109: v9  := v9 + Dm.SqlRel.Fields[0].AsInteger;                 {RECUSADO}
      end;
      Rldata.Caption   := FormatDateTime('dd/mm/yyyy',Dm.SqlRel.Fields.Fields[1].AsDateTime);
      Rlqt.Caption     := inttostr(Dm.SqlRel.Fields[0].AsInteger);
      RLLabel4.Caption := inttostr(Dm.SqlRel.Fields[0].AsInteger+strtoint(RLLabel4.Caption));
      RLLabel5.Caption := inttostr(Dm.SqlRel.Fields[0].AsInteger+strtoint(RLLabel5.Caption));
    end;
  5:
    begin
      case Dm.SqlRel.Fields[1].AsInteger of
      106: v1  := v1 + Dm.SqlRel.Fields[0].AsInteger;                 {MUDOU-SE}

      103: v2  := v2 + Dm.SqlRel.Fields[0].AsInteger;         {END INSUFICIENTE}

      112: v3  := v3 + Dm.SqlRel.Fields[0].AsInteger;                 {FALECIDO}

      102: v5  := v5 + Dm.SqlRel.Fields[0].AsInteger;             {DESCONHECIDO}

      100: v6  := v6 + Dm.SqlRel.Fields[0].AsInteger;                  {AUSENTE}

      108: v7  := v7 + Dm.SqlRel.Fields[0].AsInteger;          {NUMERO N EXISTE}

      116: v8  := v8 + Dm.SqlRel.Fields[0].AsInteger;                   {OUTROS}

      109: v9  := v9 + Dm.SqlRel.Fields[0].AsInteger;                 {RECUSADO}
      end;
      Rldata.Caption   := FormatDateTime('dd/mm/yyyy',Dm.SqlRel.Fields.Fields[2].AsDateTime);
      Rlqt.Caption     := inttostr(Dm.SqlRel.Fields[0].AsInteger);
      RLLabel4.Caption := inttostr(Dm.SqlRel.Fields[0].AsInteger+strtoint(RLLabel4.Caption));
      RLLabel5.Caption := inttostr(Dm.SqlRel.Fields[0].AsInteger+strtoint(RLLabel5.Caption));
    end;
  else                               {O QUE NAO FOR FATURA DE CARTAO DE CREDITO}
    begin
      Rldata.caption := formatdatetime('dd/mm/yyyy',Dm.SqlRel.Fields[1].AsDateTime);
      Rlqt.Caption   := inttostr(Dm.SqlRel.Fields[0].AsInteger);
      RLLabel4.Caption := inttostr(Dm.SqlRel.Fields[0].AsInteger+strtoint(RLLabel4.Caption));
      RLLabel5.Caption := inttostr(Dm.SqlRel.Fields[0].AsInteger+strtoint(RLLabel5.Caption));
    end;
  end;
  case tag of
    5:
      begin
        if Dm.SqlRel.Fields[4].Value <> null then
          RlRetorno.Caption := 'Retorno: '+ formatdatetime('dd/mm/yyyy',Dm.SqlRel.Fields[4].Asdatetime)
        else
          RlRetorno.Caption := 'Retorno: Não Gerado';
        if Dm.SqlRel.Fields[5].Value <> null then
          RlEnvio.Caption := 'Data de Envio: '+ formatdatetime('dd/mm/yyyy',Dm.SqlRel.Fields[4].Asdatetime)
        else
          RlEnvio.Caption := 'Data de Envio: Não Enviado';
      end;
  end;
end;

procedure TFrmFrProdExtContaCorrente.RLBand4AfterPrint(Sender: TObject);
begin
  RLLabel4.Caption := '0';
end;

procedure TFrmFrProdExtContaCorrente.RLBand5BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var
  data,dataret : variant;
  qt,qttot     : integer;
begin
  case tag of
    5:
      begin
        Dm.SqlRel.Refresh;
        Dm.SqlRel.First;
        data  := Dm.SqlRel.Fields[2].Value;
        qt    := 0;
        qttot := 0;
        dataret := Dm.SqlRel.Fields[4].Value;
        while not Dm.SqlRel.Eof do
          begin
            if (dataret = Dm.SqlRel.Fields[4].Value) and (data = Dm.SqlRel.Fields[2].Value) then
              begin
                qt    := qt + Dm.SqlRel.Fields[0].Value;
                qttot := qttot + Dm.SqlRel.Fields[0].Value;
                dataret := Dm.SqlRel.Fields[4].Value;
                data := Dm.SqlRel.Fields[2].Value;
                Dm.SqlRel.Next;
              end
            else
              begin
                if dataret <> null then
                  begin
                    if (qttot - qt) = 0 then
                      RLMemRet.Lines.Add('Data de Baixa: '+FormatDateTime('dd/mm/yyyy',data)+'   Data de Transmissão: '+formatdatetime('dd/mm/yyyy',dataret)+'   Quantidade: '+inttostr(qt))
                    else
                      RLMemRet.Lines.Add('Data de Baixa: '+FormatDateTime('dd/mm/yyyy',data)+'   Data de Transmissão: '+formatdatetime('dd/mm/yyyy',dataret)+'   Quantidade: '+inttostr(qt)+'    Duplicados: '+inttostr(qttot-qt));
                  end
                else
                  if (qttot - qt) = 0 then
                    RLMemRet.Lines.Add  ('Data de Baixa: '+FormatDateTime('dd/mm/yyyy',data)+'   Arquivo Transmitido                  Quantidade: '+inttostr(qt))
                  else
                    RLMemRet.Lines.Add  ('Data de Baixa: '+FormatDateTime('dd/mm/yyyy',data)+'   Arquivo Transmitido                  Quantidade: '+inttostr(qt)+'    Duplicados: '+inttostr(qttot-qt));
                    qt    := 0;
                    qttot := 0;
                    dataret := Dm.SqlRel.Fields[4].Value;
                    data := Dm.SqlRel.Fields[2].Value;
              end;
          end;
        if dataret <> null then
          begin
            if (qttot - qt) = 0 then
              RLMemRet.Lines.Add('Data de Baixa: '+FormatDateTime('dd/mm/yyyy',data)+'   Data de Transmissão: '+formatdatetime('dd/mm/yyyy',dataret)+'   Quantidade: '+inttostr(qt))
            else
              RLMemRet.Lines.Add('Data de Baixa: '+FormatDateTime('dd/mm/yyyy',data)+'   Data de Transmissão: '+formatdatetime('dd/mm/yyyy',dataret)+'   Quantidade: '+inttostr(qt)+'    Duplicados: '+inttostr(qttot-qt));
          end
        else
          if (qttot - qt) = 0 then
            RLMemRet.Lines.Add  ('Data de Baixa: '+FormatDateTime('dd/mm/yyyy',data)+'   Arquivo Não Transmitido                  Quantidade: '+inttostr(qt))
          else
            RLMemRet.Lines.Add  ('Data de Baixa: '+FormatDateTime('dd/mm/yyyy',data)+'   Arquivo Transmitido                      Quantidade: '+inttostr(qt)+'    Duplicados: '+inttostr(qttot-qt));
            Dm.SqlRel.IndexFieldNames := '';
      end;
  end;
end;


procedure TFrmFrProdExtContaCorrente.RLBand6BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
  var vtotal : integer;
begin
  case FrmFrProdExtContaCorrente.Tag of
    4,5,6,7,8,26,28,38,42,44,46..49:
      begin
        vtotal  := (v1+v2+v3+v5+v6+v7+v8+v9);
        RLMemo1.Lines.Add(RlPeriodo.Caption);
        RLMemo1.Lines.Add(' _____________________________________');
        RLMemo1.Lines.Add('| MUDOU-SE....................|'+GeraNT(inttostr(v1),7)+'|');
        RLMemo1.Lines.Add('| END INSUFICIENTE............|'+GeraNT(IntToStr(v2),7)+'|');
        RLMemo1.Lines.Add('| FALECIDO....................|'+GeraNT(IntToStr(v3),7)+'|');
        RLMemo1.Lines.Add('| DESCONHECIDO................|'+GeraNT(IntToStr(v5),7)+'|');
        RLMemo1.Lines.Add('| AUSENTE.....................|'+GeraNT(IntToStr(v6),7)+'|');
        RLMemo1.Lines.Add('| NÚMERO NÃO EXISTE...........|'+GeraNT(IntToStr(v7),7)+'|');
        RLMemo1.Lines.Add('| OUTROS......................|'+GeraNT(IntToStr(v8),7)+'|');
        RLMemo1.Lines.Add('| RECUSADO....................|'+GeraNT(IntToStr(v9),7)+'|');
        RLMemo1.Lines.Add('|_____________________________|_______|');
        RLMemo1.Lines.Add('| TOTAL LIDO..................|'+GeraNT(IntToStr(vtotal),7)+'|');
        RLMemo1.Lines.Add('| EXTRATOS GERADOS............|'+GeraNT(IntToStr(FrmPesqImp.vRes),7)+'|');
        RLMemo1.Lines.Add('| EXTRATOS NÃO LIDOS..........|'+GeraNT(IntToStr(FrmPesqImp.nlido),7)+'|');
        RLMemo1.Lines.Add('|_____________________________|_______|');
        RLMemo1.Lines.Add('| TOTAL GERAL.................|'+GeraNT(IntToStr(FrmPesqImp.nlido+vtotal),7)+'|');
        RLMemo1.Lines.Add('|_____________________________|_______|');
      end;
  end;
end;

procedure TFrmFrProdExtContaCorrente.RLBand7BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  RLLabel7.Caption  :=  FormatDateTime('dd/mm/yyyy',date) + ' às '+ FormatDateTime('hh:mm:ss',time)+' '+FrmPrincipal.usuario;;
end;

end.
