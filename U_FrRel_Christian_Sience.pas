unit U_FrRel_Christian_Sience;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RLReport, RLFilters, RLXLSFilter, RLPDFFilter, DB,
  ZAbstractRODataset, ZAbstractDataset,ZDataset;

type
  TFrFrm_Christian_Science = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLXLSFilter1: TRLXLSFilter;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLDraw4: TRLDraw;
    RLDraw2: TRLDraw;
    RLDraw3: TRLDraw;
    RLDraw5: TRLDraw;
    RLDraw9: TRLDraw;
    RLLabel12: TRLLabel;
    RLDraw10: TRLDraw;
    RLDraw11: TRLDraw;
    RLDraw13: TRLDraw;
    RLDraw15: TRLDraw;
    RLBand2: TRLBand;
    RLDraw16: TRLDraw;
    RLDraw17: TRLDraw;
    RLDraw18: TRLDraw;
    RLDraw19: TRLDraw;
    RLDraw20: TRLDraw;
    RLDraw21: TRLDraw;
    RLDraw22: TRLDraw;
    RLDraw23: TRLDraw;
    RLDraw24: TRLDraw;
    RLDraw25: TRLDraw;
    RLDraw1: TRLDraw;
    RLDraw26: TRLDraw;
    RLDraw27: TRLDraw;
    RLDraw28: TRLDraw;
    RlHpo: TRLLabel;
    RLDBText1: TRLDBText;
    SqlRel: TZQuery;
    DtsRel: TDataSource;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLPDFFilter1: TRLPDFFilter;
    RLDraw7: TRLDraw;
    RLDraw6: TRLDraw;
    RLDraw12: TRLDraw;
    RLDraw8: TRLDraw;
    RLDraw14: TRLDraw;
    RLDraw29: TRLDraw;
    SqlRelcg10_codcli: TIntegerField;
    SqlRelcg11_sigla: TStringField;
    SqlRelcg10_pnome: TStringField;
    SqlRelcg10_snome: TStringField;
    SqlRelcg10_endereco: TStringField;
    SqlRelcg10_bairro: TStringField;
    SqlRelcg10_cidade: TStringField;
    SqlRelcg10_uf: TStringField;
    SqlRelcg10_cep: TStringField;
    SqlRelcg10_pais: TStringField;
    SqlRelcg10_sexo: TStringField;
    SqlRelcg10_outros: TStringField;
    SqlRelcg10_internet: TStringField;
    SqlRelcg10_email: TStringField;
    SqlRelcg10_dtassinatura: TDateField;
    SqlRelcg10_dtimp: TDateField;
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrFrm_Christian_Science: TFrFrm_Christian_Science;

implementation

uses DmDados, U_Func;

{$R *.dfm}

procedure TFrFrm_Christian_Science.RLBand2BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  RlHpo.Caption := 'HPO-'+ GeraNT(SqlRelcg10_codcli.AsString,5);
end;

end.
