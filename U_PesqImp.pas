unit U_PesqImp;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, ExtCtrls, ComObj, ActiveX, Excel2000,
  DB, ZDataset, Grids, DBGrids, ActnList;

type
  TFrmPesqImp = class(TForm)
    ScrollBox1: TScrollBox;
    Panel5: TPanel;
    Panel9: TPanel;
    BtnFechar: TBitBtn;
    Btn_Salvar: TBitBtn;
    MkEdDtIni: TMaskEdit;
    MkEdDtFin: TMaskEdit;
    ChePlanilia: TCheckBox;
    Panel1: TPanel;
    Panel2: TPanel;
    EdAgIni: TEdit;
    EdAgFin: TEdit;
    MkEdDtTIni: TMaskEdit;
    MkEdDtTFin: TMaskEdit;
    Panel3: TPanel;
    Panel4: TPanel;
    RdGrpTipo: TComboBox;
    Panel6: TPanel;
    Panel7: TPanel;
    EdNumlote: TEdit;
    procedure GerarExcel(Consulta:TZQuery;Tipo : integer);
    procedure BtnFecharClick(Sender: TObject);
    procedure Btn_SalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure selplantok;
    procedure gerplantok;
    procedure inseretemp;
    procedure criatemp;
    procedure deltemp;
  private
  msel:string;
  sel : string;
  Matriz : Array of array of String;
  servant : String;
  erro:boolean;
    { Private declarations }
  public
     vRes,nlido : Integer;
     Matriz1: Array[0..14] of integer;
     Matriz2: Array[0..14] of integer;
    { Public declarations }
  end;

var
  FrmPesqImp: TFrmPesqImp;
  v_tipocli : integer;
implementation

uses U_FrRel_Christian_Sience, U_Func, DmDados,
  U_FrmFrProdExtContaCorrente, U_FrRelFaturamentoExt, U_FrmFrEtiqueta,
  U_FrRel_Etiqueta, U_FrmFrRelAgExtCons, U_FrmFrBoleto2, U_Principal,
  U_FrmEtqMLD, U_FrmRelProtocolosDigit, U_FrmRelRelatProtocolos,
  U_FrmRelProtocAddressBrindes, U_FrmRelContratoLimiteCreditoEspecial,
  UFrTokenBradesco, U_FrRelFaturamentoToken, U_FrRelFaturamentoTancode,
  U_FrRelFaturamentoEtica, RelCons, U_FrmRlResumo;

{$R *.dfm}

procedure TFrmPesqImp.GerarExcel(Consulta:TZQuery;Tipo : integer);
var
  coluna, linha, reg : Integer;
  col_aux, col_aux1, j,i,k:integer;
  excel: variant;
  valor: string;
  anterior : string;
  codcli:string;
  nomcpo : String;
begin
  linha:=1;
  k := 0;
  try
    excel:=CreateOleObject('Excel.Application');
//    excel.Workbooks.add(1);
  except
    Application.MessageBox ('Vers�o do Ms-Excel Incompat�vel','Erro',MB_OK+MB_ICONERROR);
  end;
  Consulta.First;
  case Tipo of
    0:
      begin
        try
          anterior:= '';

          for coluna:=1 to consulta.FieldCount-1 do
           begin
            if  (coluna=1) then
              excel.cells[linha,coluna]:='Address N�mero'
            else if (coluna = 3) then
              excel.cells[linha,coluna]:='Primeiro Nome'
            else if (coluna = 4) then
              excel.cells[linha,coluna]:='Sobrenome'
            else if (coluna = 15) then
              excel.cells[linha,coluna]:='Data Assinatura'
            else
              begin
                nomcpo:=consulta.Fields[(coluna-1)].Name;
                nomcpo:=uppercase(copy(nomcpo,12,1))+copy(nomcpo,13,length(nomcpo)-5);
                excel.cells[linha,coluna]:=nomcpo;
              end;
           end;

           Dm.Sqlcga07.Close;
           Dm.Sqlcga07.Sql.Clear;
           Dm.Sqlcga07.Sql.Add('select* from cga07 ');
           Dm.Sqlcga07.Sql.Add('order by cga07.cg07_codedicao');
           Dm.Sqlcga07.Open;
           col_aux1:=dm.SqlCga07.RecordCount;
           for i:=0 to Dm.SqlCga07.RecordCount-1 do
            begin
             valor:=dm.SqlCga07cg07_edicao.AsString;
             excel.cells[linha,coluna]:=valor;
             coluna:=coluna+1;
             dm.SqlCga07.Next;
            end;
          linha:=linha+1;
          for reg:=0 to Consulta.RecordCount-1 do
           begin
            if (anterior <> consulta.Fields[0].AsString) then
              begin
                for coluna:=1 to Consulta.FieldCount - 1 do
                  begin
                    if coluna = 1 then
                      begin
                        valor := Consulta.Fields[coluna-1].AsString;
                        valor := 'HPO-'+GeraNT(valor,5);
                        excel.cells [linha,coluna]:=valor;
                      end
                    else
                      begin
                        valor:= Consulta.Fields[coluna-1].AsString;
                        excel.cells [linha,coluna]:=valor;
                      end;
                  end;
                col_aux:=coluna;
                anterior:=consulta.Fields[0].AsString;
                codcli:=anterior;
                Dm.SqlAux1.Close;
                Dm.SqlAux1.Sql.Clear;
                Dm.SqlAux1.Sql.Add('Select cga08.cg08_codedicao, cga08.cg08_dtimp');
                Dm.SqlAux1.Sql.Add('from cga08 where cga08.cg08_codcli =:codcli');
                Dm.SqlAux1.Sql.Add('order by cga08.cg08_codcli, cga08.cg08_codedicao');
                Dm.SqlAux1.Params[0].AsString:= codcli;
                Dm.SqlAux1.Open;
                if (Dm.SqlAux1.RecordCount > 0) then
                  begin

                   for j:=0 to Dm.SqlAux1.RecordCount-1  do
                     begin
                      if (dm.SqlAux1.RecordCount < col_aux1) then
                        col_aux:=col_aux+(col_aux1 - dm.SqlAux1.RecordCount-1);
                        valor:=formatdatetime('dd/mm/yyyy',dm.SqlAux1.Fields[1].Value);
                        if (k = 0) then
                        excel.cells[linha,col_aux]:=valor
                        else
                         begin
                          excel.cells[linha,col_aux]:=valor;
                          k:=1;
                         end;
                        col_aux:=col_aux+1;
                        Dm.SqlAux1.Next;
                     end;
                  end;
                linha:=linha+1;
              end
              else
                begin
                  anterior:=consulta.Fields[0].AsString;
                end;
             Consulta.Next;

           end;
          excel.columns.AutoFit;
          excel.visible:=true;
        except
          Application.MessageBox ('Aconteceu um erro desconhecido durante a convers�o'+
         'da tabela para o Ms-Excel','Erro',MB_OK+MB_ICONERROR);
        end;
      end;
    1:
      begin
      end;
  end;
end;

procedure TFrmPesqImp.BtnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFrmPesqImp.Btn_SalvarClick(Sender: TObject);
var
  valor : Double;
  i,j:integer;
begin
  with dm do
    begin
      case FrmPesqImp.Tag of
        1:
          begin
            application.CreateForm(TFrFrm_Christian_Science,FrFrm_Christian_Science);
            with FrFrm_Christian_Science do
              begin
                SqlRel.Close;
                SqlRel.Sql.Clear;
                SqlRel.Sql.Add(' select cga10.cg10_codcli,cga11.cg11_sigla,cga10.cg10_pnome,');
                SqlRel.Sql.Add(' cga10.cg10_snome,cga10.cg10_endereco,cga10.cg10_bairro,');
                SqlRel.Sql.Add(' cga10.cg10_cidade,cga10.cg10_uf,cga10.cg10_cep,');
                SqlRel.Sql.Add(' cga10.cg10_pais,cga10.cg10_sexo,cga10.cg10_outros,');
                SqlRel.Sql.Add(' cga10.cg10_internet,cga10.cg10_email,cga10.cg10_dtimp,');
                sqlrel.Sql.Add(' cga10.cg10_dtassinatura, cga10.cg10_caixa,cga08.cg08_dtimp,');
                SqlRel.Sql.Add(' cga08.cg08_codedicao');
                SqlRel.Sql.Add(' from cga10');
                SqlRel.Sql.Add(' full join cga08 on cga10.cg10_codcli =  cga08.cg08_codcli');
    {            //Implementado por valdir em 12/03/04
                SqlRel.Sql.Add(' inner join cga07 on cga08.cg08_codedicao = cga07.cg07_codedicao');
                //Fim do implemento}
                SqlRel.Sql.Add(' inner join cga11 on cga10.cg10_codveiculo = cga11.cg11_cod');
                SqlRel.Sql.Add(' where ');
                SqlRel.Sql.Add(' cga10.cg10_dtdig between :dtini and :dtfin  order by cga10.cg10_codcli');
                SqlRel.Params[0].Value := formatdatetime('mm-dd-yyyy',strtodate(MkEdDtIni.Text));
                SqlRel.Params[1].Value := formatdatetime('mm-dd-yyyy',strtodate(MkEdDtFin.Text));;
                SqlRel.Open;
                case SqlRel.RecordCount of
                  0: application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION);
                else
                  begin
                    if ChePlanilia.Checked = false then
                      RLReport1.PreviewModal
                    else
                      begin
                      GerarExcel(SqlRel,0);
                      end;
                  end;
                end;
              end;
          end;
        2:
          begin
            dm.sqlcga10.Close;
            dm.sqlcga10.Sql.Clear;
            dm.sqlcga10.Sql.Add('select *');
            dm.sqlcga10.Sql.Add('from cga10');
            dm.sqlcga10.Sql.Add(' where ');
            if application.MessageBox('Deseja imprimir boletos j� enviados?','ADS',MB_YESNO+MB_ICONQUESTION)=idno then
              begin
                dm.sqlcga10.Sql.Add(' (cga10.cg10_dtdig between :dtini and :dtfin)  and (cga10.cg10_dtimp is null)');
              end
            else
              begin
                dm.sqlcga10.Sql.Add(' (cga10.cg10_dtdig between :dtini and :dtfin)');
                if application.MessageBox('Deseja Imprimir Assinantes ?','ADS',MB_YESNO+MB_ICONQUESTION)=idno then
                  dm.SqlCga10.Sql.Add(' and (cga10.cg10_assinante = ''N'')');
              end;
            dm.SqlCga10.Sql.Add(' order by cga10.cg10_codcli');
            dm.sqlcga10.Params[0].Value := formatdatetime('mm-dd-yyyy',strtodate(MkEdDtIni.Text));
            dm.sqlcga10.Params[1].Value := formatdatetime('mm-dd-yyyy',strtodate(MkEdDtFin.Text));
            dm.sqlcga10.Open;
            case dm.sqlcga10.RecordCount of
              0: application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION);
            else
              begin
                Dm.SqlAux1.Close;
                Dm.SqlAux1.Sql.Clear;
                Dm.SqlAux1.Sql.Add('update cga10 set cg10_dtimp=:cg10_dtimp where  cga10.cg10_dtdig between :dtini and :dtfin');
                Dm.SqlAux1.Params[0].Value := formatdatetime('mm-dd-yyyy',date);
                Dm.SqlAux1.Params[1].Value := formatdatetime('mm-dd-yyyy',strtodate(MkEdDtIni.Text));
                Dm.SqlAux1.Params[2].Value := formatdatetime('mm-dd-yyyy',strtodate(MkEdDtFin.Text));
                Dm.SqlAux1.ExecSql;
                application.CreateForm(TFrmFrBoleto2,FrmFrBoleto2);
                FrmFrBoleto2.RLReport1.PreviewModal;
              end;
            end;
          end;
        4:    // extrato consolidado
          begin
            with Dm.SqlRel do
              begin
                sel := 'select sum(ads05servnlido_qtd) from ads005_servnaolido where (ads05servnlido_codserv = :cod) and (ads05servnlido_dti between :dti and :dtf)';
                Close;
                SQL.Clear;
                SQL.Add(sel);
                SqlRel.Params[0].Value    :=  1;
                SqlRel.Params[1].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                SqlRel.Params[2].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                Open;
                nlido :=  Dm.SqlRel.Fields[0].AsInteger;
                sel := 'SELECT distinct(cg75_remes),cga20.cg20_codbrad,cga75.cg75_tipo,cg75_dv, cg75_codag,cg75_conta, cg75_dtbaixa FROM cga75 ';
                sel:= sel+'inner join cga20 on cga20.cg20_codbaixa = cga75.cg75_codbaixa WHERE (cg75_dtret is not null) ';
                sel:= sel+'and (cg75_dtbaixa between '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtIni.Text))+Chr(39);
                sel := sel + ' and '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtFin.Text))+Chr(39)+') ';
                sel := sel + 'group by cga20.cg20_codbrad,cga75.cg75_tipo,cg75_dv, cg75_codag, cg75_conta, cg75_dtbaixa,cg75_remes';
                //inputbox('','',sel);
                Close;
                SQL.Clear;
                SQL.Add(sel);
                Open;
              end;
            vRes  := Dm.SqlRel.RecordCount;
            SqlRel.Close;
            SqlRel.Sql.Clear;
            SqlRel.Sql.Add('select count(cga75.cg75_remes),');
            SqlRel.Sql.Add('cga75.cg75_dtbaixa,cga20.cg20_descricao,cga20.cg20_codbaixa');
            SqlRel.Sql.Add(' from cga75 inner join cga20 on cga75.cg75_codbaixa = cga20.cg20_codbaixa');
            SqlRel.Sql.Add(' where cga75.cg75_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
            SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
            SqlRel.Sql.Add(' group by cga75.cg75_dtbaixa,cga20.cg20_descricao,cga20.cg20_codbaixa');
            SqlRel.Sql.Add(' order by cga20.cg20_descricao,cga75.cg75_dtbaixa');
//            inputbox('','',SqlRel.SQL.Text);
            SqlRel.open;
            case SqlRel.RecordCount of
              0:
                begin
                  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                  exit;
                end;
            else
              begin
                application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                FrmFrProdExtContaCorrente.Tag := 4;
                FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Extrato Consolidado';
                FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                FrmFrProdExtContaCorrente.RLBand5.Enabled      := false;
                FrmFrProdExtContaCorrente.RLBand5.Visible      := true;
                FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
                FrmFrProdExtContaCorrente.RLReport1.Destroy;
              end;
            end;
          end;
        5:  // extrato unificado
          begin
            with Dm.SqlRel do
              begin
                sel := 'select sum(ads05servnlido_qtd) from ads005_servnaolido where (ads05servnlido_codserv = :cod) and (ads05servnlido_dti between :dti and :dtf)';
                Close;
                SQL.Clear;
                SQL.Add(sel);
                SqlRel.Params[0].Value    :=  5;
                SqlRel.Params[1].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                SqlRel.Params[2].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                Open;
                nlido :=  Dm.SqlRel.Fields[0].AsInteger;
                sel := 'SELECT distinct(cg68_remes),cg68_codbaixa FROM cga68 ';
                sel := sel + 'inner join cga20 on cga68.cg68_codbaixa = cga20.cg20_codbaixa ';
                sel := sel + 'WHERE (cg68_dtret is not null) ';
//                sel := sel + Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtfin.Text)+1)+Chr(39);
    //            sel := sel + ' and cgafatcrtcrd.cgfatcrtcrd_dtret is not null';
                sel:= sel+'and (cg68_dtbaixa between '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtIni.Text))+Chr(39);
                sel := sel + ' and '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtFin.Text))+Chr(39)+') ';//and (cg68_dtret is not null)';
//                sel := sel + 'group by cga20.cg20_codbrad ';
                //inputbox('','',sel);
                Close;
                SQL.Clear;
                SQL.Add(sel);
                Open;
              end;
            vRes  := Dm.SqlRel.RecordCount ;// .RecordCount;
            Dm.SqlRel.Close;
            Dm.SqlRel.Sql.Clear;
            Dm.SqlRel.Sql.Add('select count(cga68.cg68_remes),');
            Dm.SqlRel.Sql.Add('cg20_codbaixa,cga68.cg68_dtbaixa,cga20.cg20_descricao,cg68_dtret,cg68_dtenv'); //count(distinct(cga68.cg68_remes)),cg20_codbaixa');
            Dm.SqlRel.Sql.Add(' from cga68 inner join cga20 on cga68.cg68_codbaixa = cga20.cg20_codbaixa');
            Dm.SqlRel.Sql.Add(' where cga68.cg68_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' and (cga20.cg20_codbaixa <> ''119'')  group by cga68.cg68_dtbaixa,cga20.cg20_descricao,cg68_dtret,cg68_dtenv,cg20_codbaixa');
            Dm.SqlRel.Sql.Add(' order by cga20.cg20_descricao,cga68.cg68_dtbaixa,cg68_dtret,cg68_dtenv');
            Dm.SqlRel.open;
            case Dm.SqlRel.RecordCount of
              0:
                begin
                  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                  exit;
                end;
            else
              begin
                application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[1].DisplayName;
                FrmFrProdExtContaCorrente.Tag := 5;
                FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Extrato Unificado';
                FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
              end;
            end;
          end;
        6: // extrato conta corrente poupan�a
          begin
            with Dm.SqlRel do
              begin
                sel := 'select sum(ads05servnlido_qtd) from ads005_servnaolido where (ads05servnlido_codserv = :cod) and (ads05servnlido_dti between :dti and :dtf)';
                Close;
                SQL.Clear;
                SQL.Add(sel);
                SqlRel.Params[0].Value    :=  2;
                SqlRel.Params[1].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                SqlRel.Params[2].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                Open;
                nlido :=  Dm.SqlRel.Fields[0].AsInteger;
//                sel := 'SELECT COUNT(cg33_remes) FROM cga33 WHERE ((cg33_dtret is not null) and (cg33_dtret > ''01/01/1950'')) ';
//                sel := 'SELECT COUNT(cg33_remes) FROM cga33 WHERE ((cg33_dtret is Not Null) and(cg33_dtret > ''01/01/1950'')) ';
                sel := 'SELECT COUNT(cg33_remes) FROM cga33 WHERE (cg33_dtbaixa between '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtIni.Text))+Chr(39);
                sel := sel + ' and '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtFin.Text))+Chr(39)+') ';
                //inputbox('','',sel);
                Close;
                SQL.Clear;
                SQL.Add(sel);
                Open;
              end;
            vRes  := Dm.SqlRel.Fields[0].AsInteger;
            Dm.SqlRel.Close;
            Dm.SqlRel.Sql.Clear;
            Dm.SqlRel.Sql.Add('select count(cga33.cg33_dtbaixa),');
            Dm.SqlRel.Sql.Add('cga33.cg33_dtbaixa,cga20.cg20_descricao,cga20.cg20_codbaixa ');
            Dm.SqlRel.Sql.Add(' from cga33 inner join cga20 on cga33.cg33_codbaixa = cga20.cg20_codbaixa');
            Dm.SqlRel.Sql.Add(' where cga33.cg33_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' group by cga33.cg33_dtbaixa,cga20.cg20_descricao,cga20.cg20_codbaixa');
            Dm.SqlRel.Sql.Add(' order by cga20.cg20_descricao,cga33.cg33_dtbaixa');
            Dm.SqlRel.open;
            if ChePlanilia.Checked = false then
              begin
                application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                FrmFrProdExtContaCorrente.Tag := 6;
                FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Extrato Conta Corrente Poupan�a';
                FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
              end
            else
              begin
                GerarExcel(Dm.SqlRel,1);
              end;
          end;
        7: // relatorio drc cobran�a
          begin
            with Dm.SqlRel do
              begin
                sel := 'select sum(ads05servnlido_qtd) from ads005_servnaolido where (ads05servnlido_codserv = :cod) and (ads05servnlido_dti between :dti and :dtf)';
                Close;
                SQL.Clear;
                SQL.Add(sel);
                SqlRel.Params[0].Value    :=  3;
                SqlRel.Params[1].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                SqlRel.Params[2].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                Open;
                nlido :=  Dm.SqlRel.Fields[0].AsInteger;
                sel := 'SELECT COUNT(cg100_remes) FROM cga100 WHERE (cg100_dtbaixa between '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtIni.Text))+Chr(39);
                sel := sel + ' and '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtFin.Text))+Chr(39)+') ';
                Close;
                SQL.Clear;
                SQL.Add(sel);
                Open;
              end;
            vRes  := Dm.SqlRel.Fields[0].AsInteger;
            Dm.SqlRel.Close;
            Dm.SqlRel.Sql.Clear;
            Dm.SqlRel.Sql.Add('select count(cga100.cg100_dtbaixa),');
            Dm.SqlRel.Sql.Add('cga100.cg100_dtbaixa,cga20.cg20_descricao,cga20.cg20_codbaixa ');
            Dm.SqlRel.Sql.Add('from cga100 inner join cga20 on cga100.cg100_codbaixa = cga20.cg20_codbaixa where ');
            Dm.SqlRel.Sql.Add('(cga100.cg100_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39)+')');
            Dm.SqlRel.Sql.Add('group by cga100.cg100_dtbaixa,cga20.cg20_descricao,cga20.cg20_codbaixa' );
            Dm.SqlRel.Sql.Add('order by cga20.cg20_descricao,cga100.cg100_dtbaixa');
//            inputbox('','',SqlRel.Sql.Text);
            Dm.SqlRel.open;

            case Dm.SqlRel.RecordCount of
              0:
                begin
                  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                  exit;
                end;
            else
              begin
                application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'BOLETOS DE RECUPERA��O DE CR�DITO';
                FrmFrProdExtContaCorrente.Tag := 7;
                FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
              end;
            end;
          end;
        8: // faturamento ext Unificado
          begin
            Dm.SqlRel.Close;
            Dm.SqlRel.Sql.Clear;
            Dm.SqlRel.Sql.Add('select count(cg68_dtbaixa),count(cg68_dtbaixa)*:x,');
            Dm.SqlRel.Sql.Add('cg68_dtbaixa from cga68');
            Dm.SqlRel.Sql.Add(' where cga68.cg68_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' group by cg68_dtbaixa order by cg68_dtbaixa');
            valor := StrToFloat(InputBox('Ads','Digite o Valor por Documento'+#10+'Ex: 0,01',''));
            Dm.SqlRel.Params[0].Value:= valor;
            Dm.SqlRel.Open;
            case Dm.SqlRel.RecordCount of
              0:
                begin
                  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                  exit;
                end;
            else
              begin
                Application.CreateForm(TFrmFrRelFaturamentoExt,FrmFrRelFaturamentoExt);
                FrmFrRelFaturamentoExt.RLGroup1.DataFields := Dm.SqlRel.Fields[2].DisplayName;
                FrmFrRelFaturamentoExt.RlTipoRelat.Caption := 'Extrato Unificado';
                FrmFrRelFaturamentoExt.RlPeriodo.Caption   := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                FrmFrRelFaturamentoExt.RlValorFin.DataField := Dm.SqlRel.Fields[1].DisplayName;
                FrmFrRelFaturamentoExt.RlValorUnitario.Caption := 'Valor Unit�rio: R$ '+ FloatToStr(valor);
                FrmFrRelFaturamentoExt.RLReport1.PreviewModal;
                FrmFrRelFaturamentoExt.RLReport1.Destroy;
              end;
            end;
          end;
        9: // faturamento ext cons
          begin
            Dm.SqlRel.Close;
            Dm.SqlRel.Sql.Clear;
            Dm.SqlRel.Sql.Add('select count(cg75_dtbaixa),count(cg75_dtbaixa)*:x,');
            Dm.SqlRel.Sql.Add('cg75_dtbaixa from cga75');
            Dm.SqlRel.Sql.Add(' where cga75.cg75_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' group by cg75_dtbaixa order by cg75_dtbaixa');
            valor := StrToFloat(InputBox('Ads','Digite o Valor por Documento'+#10+'Ex: 0,01',''));
            Dm.SqlRel.Params[0].Value:= valor;
            Dm.SqlRel.Open;
            case Dm.SqlRel.RecordCount of
              0:
                begin
                  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                  exit;
                end;
            else
              begin
                Application.CreateForm(TFrmFrRelFaturamentoExt,FrmFrRelFaturamentoExt);
                FrmFrRelFaturamentoExt.RLGroup1.DataFields := Dm.SqlRel.Fields[2].DisplayName;
                FrmFrRelFaturamentoExt.RlTipoRelat.Caption := 'Extrato Consolidado';
                FrmFrRelFaturamentoExt.RlPeriodo.Caption   := 'Per�odo de '+MkEdDtIni.Text +' a '+MkEdDtFin.Text;
                FrmFrRelFaturamentoExt.RlValorFin.DataField := Dm.SqlRel.Fields[1].DisplayName;
                FrmFrRelFaturamentoExt.RlValorUnitario.Caption := 'Valor Unit�rio: R$ '+ FloatToStr(valor);
                FrmFrRelFaturamentoExt.RLReport1.PreviewModal;
              end;
            end;
          end;
        10: // faturamento ext velho
          begin
            Dm.SqlRel.Close;
            Dm.SqlRel.Sql.Clear;
            Dm.SqlRel.Sql.Add('select count(cg33_dtbaixa),count(cg33_dtbaixa)*:x,');
            Dm.SqlRel.Sql.Add('cg33_dtbaixa from cga33');
            Dm.SqlRel.Sql.Add(' where cga33.cg33_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' group by cg33_dtbaixa order by cg33_dtbaixa');
            valor := StrToFloat(InputBox('Ads','Digite o Valor por Documento'+#10+'Ex: 0,01',''));
            Dm.SqlRel.Params[0].Value:= valor;
            Dm.SqlRel.Open;
            case Dm.SqlRel.RecordCount of
              0:
                begin
                  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                  exit;
                end;
            else
              begin
                Application.CreateForm(TFrmFrRelFaturamentoExt,FrmFrRelFaturamentoExt);
                FrmFrRelFaturamentoExt.RLGroup1.DataFields := Dm.SqlRel.Fields[2].DisplayName;
                FrmFrRelFaturamentoExt.RlTipoRelat.Caption := 'Extrato Conta Corrente Poupan�a';
                FrmFrRelFaturamentoExt.RlPeriodo.Caption   := 'Per�odo de '+MkEdDtIni.Text +' a '+MkEdDtFin.Text;
                FrmFrRelFaturamentoExt.RlValorFin.DataField := Dm.SqlRel.Fields[1].DisplayName;
                FrmFrRelFaturamentoExt.RlValorUnitario.Caption := 'Valor Unit�rio: R$ '+ FloatToStr(valor);
                FrmFrRelFaturamentoExt.RLReport1.PreviewModal;
              end;
            end;
          end;
        11: // faturamento ext drc
           begin
             Dm.SqlRel.Close;
             Dm.SqlRel.Sql.Clear;
             Dm.SqlRel.Sql.Add('select count(cg100_dtbaixa),count(cg100_dtbaixa)*:x,');
             Dm.SqlRel.Sql.Add('cg100_dtbaixa from cga100');
             Dm.SqlRel.Sql.Add(' where cga100.cg100_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
             Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
             Dm.SqlRel.Sql.Add(' group by cg100_dtbaixa order by cg100_dtbaixa');
             valor := StrToFloat(InputBox('Ads','Digite o Valor por Documento'+#10+'Ex: 0,01',''));
             Dm.SqlRel.Params[0].Value:= valor;
             Dm.SqlRel.Open;
             case Dm.SqlRel.RecordCount of
               0:
                 begin
                   Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                   exit;
                 end;
             else
               begin
                 Application.CreateForm(TFrmFrRelFaturamentoExt,FrmFrRelFaturamentoExt);
                 FrmFrRelFaturamentoExt.RLGroup1.DataFields := Dm.SqlRel.Fields[2].DisplayName;
                 FrmFrRelFaturamentoExt.RlTipoRelat.Caption := 'Extrato DRC';
                 FrmFrRelFaturamentoExt.RlPeriodo.Caption   := 'Per�odo de '+MkEdDtIni.Text +' a '+MkEdDtFin.Text;
                 FrmFrRelFaturamentoExt.RlValorFin.DataField := Dm.SqlRel.Fields[1].DisplayName;
                 FrmFrRelFaturamentoExt.RlValorUnitario.Caption := 'Valor Unit�rio: R$ '+ FloatToStr(valor);
                 FrmFrRelFaturamentoExt.RLReport1.PreviewModal;
               end;
             end;
           end;
         12: // etiquetas do arauto
            begin
              Dm.SqlRel.Close;
              Dm.SqlRel.Sql.Clear;
              Dm.SqlRel.Sql.Add('select cg10_pnome,cg10_snome,cg10_endereco,');
              Dm.SqlRel.Sql.Add('cg10_bairro,cg10_cidade,cg10_uf,cg10_cep,cg10_codcli from cga10 where ');
              Dm.SqlRel.Sql.Add(' (cg10_dtdig between :dtini and :dtfin) and (cg10_assinante = '+chr(39)+'N'+chr(39)+') ');
              Dm.SqlRel.Params[0].AsString := FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text));
              Dm.SqlRel.Params[1].AsString := FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtFin.Text));
              Dm.SqlRel.Sql.Add('order by cg10_codcli');
              Dm.SqlRel.Open;
              case Dm.SqlRel.RecordCount of
                0:
                  begin
                    Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                    exit;
                  end;
              else
                begin
                  Application.CreateForm(TFrmFrEtiqueta,FrmFrEtiqueta);
                  FrmFrEtiqueta.RLReport1.PreviewModal;
                end;
              end;
            end;
         13: // consolidado por agencia
            begin
              Dm.SqlRel.Close;
              Dm.SqlRel.Sql.Clear;
              Dm.SqlRel.Sql.Add('select cga75.cg75_codag,cga14.cg14_nome,cga14.cg14_uf from cga75 ');
              Dm.SqlRel.Sql.Add('inner join cga14 on cga14.cg14_codag = cga75.cg75_codag ');
              Dm.SqlRel.Sql.Add('where (cga75.cg75_codag between :num1 and :num2) and (cga75.cg75_dtbaixa between :dtini and :dtfin) ');
              Dm.SqlRel.Sql.Add('group by cga14.cg14_nome,cga14.cg14_uf,cga75.cg75_codag');
              Dm.SqlRel.Sql.Add('order by cga75.cg75_codag');
              Dm.SqlRel.Params[0].AsString := EdAgIni.Text;
              Dm.SqlRel.Params[1].AsString := EdAgFin.Text;
              Dm.SqlRel.Params[2].AsString := FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text));
              Dm.SqlRel.Params[3].AsString := FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtFin.Text));
              Dm.SqlRel.Open;
              case Dm.SqlRel.RecordCount of
                0:
                  begin
                    Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                    exit;
                  end;
              else
                begin
                  Application.CreateForm(TFrmFrRelAgExtCons,FrmFrRelAgExtCons);
                  FrmFrRelAgExtCons.Rldata.Visible    := False;
                  FrmFrRelAgExtCons.RLReport1.PreviewModal;
                end;
              end;
            end;
         14:
            begin
              Dm.SqlRel.Close;
              Dm.SqlRel.Sql.Clear;
              Dm.SqlRel.Sql.Add('select cg10_pnome,cg10_snome,cg10_endereco,');
              Dm.SqlRel.Sql.Add('cg10_bairro,cg10_cidade,cg10_uf,cg10_cep,cg10_codcli from cga10 where ');
              Dm.SqlRel.Sql.Add(' (cg10_dtdig between :dtini and :dtfin) and (cg10_assinante = '+chr(39)+'N'+chr(39)+') ');
              Dm.SqlRel.Params[0].AsString := FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text));
              Dm.SqlRel.Params[1].AsString := FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtFin.Text));
              Dm.SqlRel.Sql.Add('order by cg10_codcli');
              Dm.SqlRel.Open;
              case dm.SqlRel.RecordCount of
                0: application.MessageBox('N�o foi encontrado nenhum registro','Ads',MB_OK+MB_ICONINFORMATION);
              else
                begin
                  application.CreateForm(TFrmEtqMLD,FrmEtqMLD);
                  FrmEtqMLD.RLEtqMLD.PreviewModal;
                  FrmEtqMLD.RLEtqMLD.Destroy;
                end;
              end;
            end;
         15: // faturamento ext velho
            begin
              Dm.SqlRel.Close;
              Dm.SqlRel.Sql.Clear;
              Dm.SqlRel.Sql.Add('select count(cg67_dtbaixa),count(cg67_dtbaixa)*:x,');
              Dm.SqlRel.Sql.Add('cg67_dtbaixa from cga67');
              Dm.SqlRel.Sql.Add(' where cga67.cg67_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
              Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
              Dm.SqlRel.Sql.Add(' group by cg67_dtbaixa order by cg67_dtbaixa');
              valor := StrToFloat(InputBox('Ads','Digite o Valor por Documento'+#10+'Ex: 0,01',''));
              Dm.SqlRel.Params[0].Value:= valor;
              Dm.SqlRel.Open;
              case Dm.SqlRel.RecordCount of
                0:
                  begin
                    Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                    exit;
                  end;
              else
                begin
                  Application.CreateForm(TFrmFrRelFaturamentoExt,FrmFrRelFaturamentoExt);
                  FrmFrRelFaturamentoExt.RLGroup1.DataFields := Dm.SqlRel.Fields[2].DisplayName;
                  FrmFrRelFaturamentoExt.RlTipoRelat.Caption := 'Extrato Cart�o Bradesco';
                  FrmFrRelFaturamentoExt.RlPeriodo.Caption   := 'Per�odo de '+MkEdDtIni.Text +' a '+MkEdDtFin.Text;
                  FrmFrRelFaturamentoExt.RlValorFin.DataField := Dm.SqlRel.Fields[1].DisplayName;
                  FrmFrRelFaturamentoExt.RlValorUnitario.Caption := 'Valor Unit�rio: R$ '+ FloatToStr(valor);
                  FrmFrRelFaturamentoExt.RLReport1.PreviewModal;
                end;
              end;
            end;
          16: // faturamento ext drc
             begin
              Dm.SqlRel.Close;
              Dm.SqlRel.Sql.Clear;
              Dm.SqlRel.Sql.Add('select count(cga67.cg67_dtbaixa),');
              Dm.SqlRel.Sql.Add('cga67.cg67_dtbaixa,cga20.cg20_descricao ');
              Dm.SqlRel.Sql.Add(' from cga67 inner join cga20 on cga67.cg67_codbaixa = cga20.cg20_codbaixa');
              Dm.SqlRel.Sql.Add(' where cga67.cg67_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
              Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
              Dm.SqlRel.Sql.Add(' group by cga67.cg67_dtbaixa,cga20.cg20_descricao');
              Dm.SqlRel.Sql.Add(' order by cga20.cg20_descricao,cga67.cg67_dtbaixa');
              Dm.SqlRel.open;
              case Dm.SqlRel.RecordCount of
                0:
                  begin
                    Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                    exit;
                  end;
              else
                begin
                  application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                  FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                  FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Extrato  Cart�o Bradesco';
                  FrmFrProdExtContaCorrente.Tag := 8;
                  FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' a '+MkEdDtFin.Text;
                  FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
                end;
              end;
           end;
          17:
            begin
              Dm.SqlRel.Close;
              Dm.SqlRel.Sql.Clear;
              Dm.SqlRel.Sql.Add('select cg10_pnome,cg10_endereco,');
              Dm.SqlRel.Sql.Add('cg10_bairro,cg10_cidade,cg10_uf,cg10_cep from cga10 where ');
              Dm.SqlRel.Sql.Add(' (cg10_dtdig between :dtini and :dtfin)');
              Dm.SqlRel.Params[0].AsString := FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text));
              Dm.SqlRel.Params[1].AsString := FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtFin.Text));
              Dm.SqlRel.Sql.Add('order by cg10_codcli');
              Dm.SqlRel.Open;
              case Dm.SqlRel.RecordCount of
                0:
                  begin
                    Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                    exit;
                  end;
              else
                begin
                  Application.CreateForm(TFrmRelProtocDigi,FrmRelProtocDigi);
                  FrmRelProtocDigi.Protocolo.PreviewModal;
                end;
              end;
            end;

          18:
            begin
              Dm.SqlRel.Close;
              Dm.SqlRel.Sql.Clear;
              Dm.SqlRel.Sql.Add('select cg10_pnome,cg10_endereco,');
              Dm.SqlRel.Sql.Add('cg10_bairro from cga10 where ');
              Dm.SqlRel.Sql.Add(' (cg10_dtdig between :dtini and :dtfin)');
              Dm.SqlRel.Params[0].AsString := FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text));
              Dm.SqlRel.Params[1].AsString := FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtFin.Text));
              Dm.SqlRel.Sql.Add('order by cg10_codcli');
              Dm.SqlRel.Open;
              case Dm.SqlRel.RecordCount of
                0:
                  begin
                    Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                    exit;
                  end;
              else
                begin
                  Application.CreateForm(TFrmRelProtocolos,FrmRelProtocolos);
                  FrmRelProtocolos.Relatorio.PreviewModal;
                end;
              end;
            end;
            19:
            begin
              Dm.SqlRel.Close;
              Dm.SqlRel.Sql.Clear;
              Dm.SqlRel.Sql.Add('select cg10_contato,cg10_endereco,');
              Dm.SqlRel.Sql.Add('cg10_cep,cg10_tel from cga10_brindes');
              Dm.SqlRel.Sql.Add('order by cg10_cod');
              Dm.SqlRel.Open;
              case Dm.SqlRel.RecordCount of
                0:
                  begin
                    Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                    exit;
                  end;
              else
                begin
                  Application.CreateForm(TFrmRelProtocAddress,FrmRelProtocAddress);
                  FrmRelProtocAddress.Protocolo.PreviewModal;
                end;
              end;
            end;
            20: // Producao ext CVM
             begin
              with Dm.SqlRel do
                begin
                  sel := 'select sum(ads05servnlido_qtd) from ads005_servnaolido where (ads05servnlido_codserv = :cod) and (ads05servnlido_dti between :dti and :dtf)';
                  Close;
                  SQL.Clear;
                  SQL.Add(sel);
                  SqlRel.Params[0].Value    :=  7;
                  SqlRel.Params[1].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                  SqlRel.Params[2].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                  Open;
                  nlido :=  Fields[0].AsInteger;
                  sel := 'SELECT COUNT(cg69_dtret) FROM cga69 WHERE ';
                  sel:= sel+'(cg69_dtbaixa between '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtIni.Text))+Chr(39);
                  sel := sel + ' and '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtFin.Text))+Chr(39)+') ';
                  Close;
                  SQL.Clear;
                  SQL.Add(sel);
                  Open;
                  vRes  := SqlRel.Fields[0].AsInteger;
                end;
              Dm.SqlRel.Close;
              Dm.SqlRel.Sql.Clear;
              Dm.SqlRel.Sql.Add('select count(cga69.cg69_dtbaixa),');
              Dm.SqlRel.Sql.Add('cga69.cg69_dtbaixa,cga20.cg20_descricao,cga20.cg20_codbaixa ');
              Dm.SqlRel.Sql.Add(' from cga69 inner join cga20 on cga69.cg69_codbaixa = cga20.cg20_codbaixa');
              Dm.SqlRel.Sql.Add(' where cga69.cg69_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
              Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
              Dm.SqlRel.Sql.Add(' group by cga69.cg69_dtbaixa,cga20.cg20_descricao,cga20.cg20_codbaixa');
              Dm.SqlRel.Sql.Add(' order by cga20.cg20_descricao,cga69.cg69_dtbaixa');
              Dm.SqlRel.open;
              case Dm.SqlRel.RecordCount of
                0:
                  begin
                    Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                    exit;
                  end;
              else
                begin
                  application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                  FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                  FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Extrato CVM';
                  FrmFrProdExtContaCorrente.Tag := 8;
                  FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                  FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
                end;
              end;
           end;
            21: //faturamento extrato cvm
            begin
              Dm.SqlRel.Close;
              Dm.SqlRel.Sql.Clear;
              Dm.SqlRel.Sql.Add('select count(cg69_dtbaixa),count(cg69_dtbaixa)*:x,');
              Dm.SqlRel.Sql.Add('cg69_dtbaixa from cga69');
              Dm.SqlRel.Sql.Add(' where cga69.cg69_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
              Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
              Dm.SqlRel.Sql.Add(' group by cg69_dtbaixa order by cg69_dtbaixa');
              valor := StrToFloat(InputBox('Ads','Digite o Valor por Documento'+#10+'Ex: 0,01',''));
              Dm.SqlRel.Params[0].Value:= valor;
              Dm.SqlRel.Open;
              case Dm.SqlRel.RecordCount of
                0:
                  begin
                    Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                    exit;
                  end;
              else
                begin
                  Application.CreateForm(TFrmFrRelFaturamentoExt,FrmFrRelFaturamentoExt);
                  FrmFrRelFaturamentoExt.RLGroup1.DataFields := Dm.SqlRel.Fields[2].DisplayName;
                  FrmFrRelFaturamentoExt.RlTipoRelat.Caption := 'Extrato CVM';
                  FrmFrRelFaturamentoExt.RlPeriodo.Caption   := 'Per�odo de '+MkEdDtIni.Text +' a '+MkEdDtFin.Text;
                  FrmFrRelFaturamentoExt.RlValorFin.DataField := Dm.SqlRel.Fields[1].DisplayName;
                  FrmFrRelFaturamentoExt.RlValorUnitario.Caption := 'Valor Unit�rio: R$ '+ FloatToStr(valor);
                  FrmFrRelFaturamentoExt.RLReport1.PreviewModal;
                end;
              end;
            end;
          22: // Producao ext Banco Postal
             begin
              with Dm.SqlRel do
                begin
                  sel := 'select sum(ads05servnlido_qtd) from ads005_servnaolido where (ads05servnlido_codserv = :cod) and (ads05servnlido_dti between :dti and :dtf)';
                  Close;
                  SQL.Clear;
                  SQL.Add(sel);
                  SqlRel.Params[0].Value    :=  14;
                  SqlRel.Params[1].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                  SqlRel.Params[2].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                  Open;
                  nlido :=  Fields[0].AsInteger;
                end;
              Dm.SqlRel.Close;
              Dm.SqlRel.Sql.Clear;
              Dm.SqlRel.Sql.Add('select count(cga70.cg70_dtbaixa),');
              Dm.SqlRel.Sql.Add('cga70.cg70_dtbaixa,cga20.cg20_descricao ');
              Dm.SqlRel.Sql.Add(' from cga70 inner join cga20 on cga70.cg70_codbaixa = cga20.cg20_codbaixa');
              Dm.SqlRel.Sql.Add(' where cga70.cg70_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
              Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
              Dm.SqlRel.Sql.Add(' group by cga70.cg70_dtbaixa,cga20.cg20_descricao');
              Dm.SqlRel.Sql.Add(' order by cga20.cg20_descricao,cga70.cg70_dtbaixa');
              Dm.SqlRel.open;
              case Dm.SqlRel.RecordCount of
                0:
                  begin
                    Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                    exit;
                  end;
              else
                begin
                  application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                  FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                  FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Extrato Banco Postal';
                  FrmFrProdExtContaCorrente.Tag := 8;
                  FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' a '+MkEdDtFin.Text;
                  FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
                end;
              end;
           end;
            23: //faturamento extrato banco postal
            begin
              Dm.SqlRel.Close;
              Dm.SqlRel.Sql.Clear;
              Dm.SqlRel.Sql.Add('select count(cg70_dtbaixa),count(cg70_dtbaixa)*:x,');
              Dm.SqlRel.Sql.Add('cg70_dtbaixa from cga70');
              Dm.SqlRel.Sql.Add(' where cga70.cg70_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
              Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
              Dm.SqlRel.Sql.Add(' group by cg70_dtbaixa order by cg70_dtbaixa');
              valor := StrToFloat(InputBox('Ads','Digite o Valor por Documento'+#10+'Ex: 0,01',''));
              Dm.SqlRel.Params[0].Value:= valor;
              Dm.SqlRel.Open;
              case Dm.SqlRel.RecordCount of
                0:
                  begin
                    Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                    exit;
                  end;
              else
                begin
                  Application.CreateForm(TFrmFrRelFaturamentoExt,FrmFrRelFaturamentoExt);
                  FrmFrRelFaturamentoExt.RLGroup1.DataFields := Dm.SqlRel.Fields[2].DisplayName;
                  FrmFrRelFaturamentoExt.RlTipoRelat.Caption := 'Extrato Banco Postal';
                  FrmFrRelFaturamentoExt.RlPeriodo.Caption   := 'Per�odo de '+MkEdDtIni.Text +' a '+MkEdDtFin.Text;
                  FrmFrRelFaturamentoExt.RlValorFin.DataField := Dm.SqlRel.Fields[1].DisplayName;
                  FrmFrRelFaturamentoExt.RlValorUnitario.Caption := 'Valor Unit�rio: R$ '+ FloatToStr(valor);
                  FrmFrRelFaturamentoExt.RLReport1.PreviewModal;
                end;
              end;
            end;
           24: // Contrato de Limite de Cr�dito Especial do Banco Postal
            begin

              try
                StrToInt(FrmPesqImp.EdAgIni.Text);
                StrToInt(FrmPesqImp.EdAgFin.Text);
                 Dm.SqlRel.Close;
                Dm.SqlRel.Sql.Clear;
                Dm.SqlRel.Sql.Add('select distinct(cga70.cg70_codbaixa), substring(cga70.cg70_remes from 1 for 5) as agencia,cga14.cg14_nome from cga70 ');
                Dm.SqlRel.Sql.Add('inner join cga14 on cga14.cg14_codag=to_number(substring(cga70.cg70_remes from 1 for 5),'+chr(39)+'99999'+chr(39)+') ');
                Dm.SqlRel.Sql.Add('where to_number(cga14.cg14_codag,'+chr(39)+'99999'+chr(39)+') between '+trim(FrmPesqImp.EdAgIni.Text)+' and '+trim(FrmPesqImp.EdAgFin.Text)+' ');
                Dm.SqlRel.Sql.Add('and cga70.cg70_codbaixa=118 group by cga70.cg70_codbaixa,cga14.cg14_nome,agencia');
                Dm.SqlRel.Open;

                case Dm.SqlRel.RecordCount of
                  0:
                    begin
                      Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                    end;
                  else
                    begin
                      Application.CreateForm(TFrmRelContratoLimiteCreditoEspecial,FrmRelContratoLimiteCreditoEspecial);
                      FrmRelContratoLimiteCreditoEspecial.ReportContrato.PreviewModal;
                    end;
                end;
              except on erro: exception do
                begin
                  Application.MessageBox(PChar('Erro: '+erro.Message),'Ads',MB_OK+MB_ICONERROR);
                end
              end;

            end;
          25: // Producao Tokens Bradesco
          begin
            with Dm.SqlRel do
              begin
                sel := 'select sum(ads05servnlido_qtd) from ads005_servnaolido where (ads05servnlido_codserv = :cod) and (ads05servnlido_dti between :dti and :dtf)';
                Close;
                SQL.Clear;
                SQL.Add(sel);
                SqlRel.Params[0].Value    :=  13;
                SqlRel.Params[1].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                SqlRel.Params[2].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                Open;
                nlido :=  Fields[0].AsInteger;
              end;
            Dm.ZOQListaToken.Close;
            Dm.ZOQListaToken.Sql.Clear;
            Dm.ZOQListaToken.Sql.Add('select cga76.cg76_dtsai,cga76.cg76_ag,cga76.cg76_remes,cga76.cg76_dtb,cg76_numlote,cga20.cg20_descricao,cg76_tipocli ');
            Dm.ZOQListaToken.Sql.Add('from cga76 inner join cga20 on cga76.cg76_codbaixa = cga20.cg20_codbaixa ');
            Dm.ZOQListaToken.Sql.Add('where (cga76.cg76_dtsai between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
            Dm.ZOQListaToken.Sql.Add('and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39)+') ');
            if (trim(EdAgIni.Text) <> '0') and (Trim(EdAgIni.Text) <> '') then
              Dm.ZOQListaToken.Sql.Add('and (cg76_ag = :ag) ')
            else if (trim(EdAgIni.Text) = '0') then
              Dm.ZOQListaToken.Sql.Add('and (cg76_ag >= :ag) ')
            else
              begin
                Application.MessageBox('Digite uma Ag�ncia ou 0','ADS',MB_OK);
                EdAgIni.SetFocus;
                exit;
              end;
            if (trim(EdAgFin.Text) <> '0') and (trim(EdAgFin.Text) <> '') then
              Dm.ZOQListaToken.Sql.Add('and (cg76_Dtb = :dtb) ')
            else if (trim(EdAgFin.Text) = '0') then
              Dm.ZOQListaToken.Sql.Add('and (cg76_Dtb >= :dtb) ')
            else
              begin
                Application.MessageBox('Digite uma DTB ou 0','ADS',MB_OK);
                EdAgFin.SetFocus;
                exit;
              end;
            if (Trim(EdNumlote.Text) <> '') and (trim(EdNumlote.Text) <> '0') then
              Dm.ZOQListaToken.SQL.Add('and (cg76_numlote = '''+GeraNT(EdNumlote.Text,6)+''')');

      //      case self.RdGrpTipo.ItemIndex of
      //        0,1:Dm.SqlRel.Sql.Add('and (cg76_tipocli = :tipocli) ');
      //      end;

            //Dm.ZOQListaToken.Sql.Add('group by cga76.cg76_dtsai,cga76.cg76_ag,cga76.cg76_dtb,cg76_numlote,cga76.cg76_remes,cga20.cg20_descricao,cg76_tipocli ');
            Dm.ZOQListaToken.Sql.Add('order by cga76.cg76_dtsai,to_number(cga76.cg76_ag,''9999''),cga76.cg76_dtb,cg76_numlote,cga76.cg76_remes,cga20.cg20_descricao');
            Dm.ZOQListaToken.Params[0].Value := EdAgIni.Text;

          //  case RdGrpTipo.ItemIndex of
          //    0:Dm.SqlRel.Params[2].Value := 0;
          //    1:Dm.SqlRel.Params[2].Value := 1;
          //  end;

            if (EdAgFin.Text <> '') then
              begin
                if (vernum(EdAgFin.Text) = true) then
                  Dm.ZOQListaToken.Params[1].Value := GeraNt(trim(EdAgFin.Text),10);
              end;
            Dm.ZOQListaToken.open;
            case  Dm.ZOQListaToken.RecordCount of
              0:
                begin
                  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                  exit;
                end;
              else
                begin
                  if ChePlanilia.Checked = false then
                    begin
                      v_tipocli := Dm.ZOQListaTokencg76_tipocli.AsInteger;
                      application.CreateForm(TFrmFrTokenBradesco,FrmFrTokenBradesco);
                      //FrmFrTokenBradesco.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                      FrmFrTokenBradesco.Tag := 25;
                      FrmFrTokenBradesco.RLLabel1.Caption    := 'Relat�rio de Tokens por Ag�ncia';
                      FrmFrTokenBradesco.RLLabel2.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                      {case RdGrpTipo.ItemIndex of
                        0:FrmFrTokenBradesco.RLLabel12.Caption:= FrmFrTokenBradesco.Caption+'PF';
                        1:FrmFrTokenBradesco.RLLabel12.Caption:= FrmFrTokenBradesco.Caption+'CNPJ';
                        else
                          FrmFrTokenBradesco.RLLabel12.Caption:= FrmFrTokenBradesco.Caption+'Todos';
                      end;}
                      FrmFrTokenBradesco.RLLabel12.Caption:= FrmFrTokenBradesco.Caption+'TIPO DE CLIENTE: PESSOA FISICA / JURIDICA';
                      FrmFrTokenBradesco.RLRListaToken.PreviewModal;
                    end
                  else
                    begin
                      GerarExcel(Dm.SqlRel,1);
                    end;
                end;
            end;
          end;
        26: // Relat�rio Produ��o DRC Carta Convite
          begin
            with Dm.SqlRel do
              begin
                sel := 'select sum(ads05servnlido_qtd) from ads005_servnaolido where (ads05servnlido_codserv = :cod) and (ads05servnlido_dti between :dti and :dtf)';
                Close;
                SQL.Clear;
                SQL.Add(sel);
                SqlRel.Params[0].Value    :=  4;
                SqlRel.Params[1].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                SqlRel.Params[2].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                Open;
                nlido :=  Fields[0].AsInteger;
              end;
//            sel := 'SELECT distinct(cg120_remes),cga20.cg20_codbrad_drc FROM cga120 inner join cga20 on cga20.cg20_codbaixa = cga120.cg120_codbaixa WHERE (cg120_dtret is not null) ';
            sel := 'SELECT distinct(cg120_remes),cga20.cg20_codbrad_drc FROM cga120 inner join cga20 on cga20.cg20_codbaixa = cga120.cg120_codbaixa WHERE (cg120_dtbaixa between '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtIni.Text))+Chr(39);
            sel := sel + ' and '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtFin.Text))+Chr(39)+') ';
            //inputbox('','',sel);
            with Dm.SqlRel do
              begin
                Close;
                SQL.Clear;
                SQL.Add(sel);
                Open;
              end;
            vRes  := Dm.SqlRel.RecordCount;
            Dm.SqlRel.Close;
            Dm.SqlRel.Sql.Clear;
//distinct(cga120.cg120_remes),cga20.cg20_codbrad_drc
            Dm.SqlRel.Sql.Add('select count(cga120.cg120_remes),');
            Dm.SqlRel.Sql.Add('cga120.cg120_dtbaixa,cga20.cg20_descricao,cga20.cg20_codbaixa ');
            Dm.SqlRel.Sql.Add(' from cga120 inner join cga20 on cga120.cg120_codbaixa = cga20.cg20_codbaixa');
            Dm.SqlRel.Sql.Add(' where cga120.cg120_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' group by cga20.cg20_descricao,cga120.cg120_dtbaixa,cga20.cg20_codbaixa');
            Dm.SqlRel.Sql.Add(' order by cga20.cg20_descricao,cga120.cg120_dtbaixa');
            Dm.SqlRel.open;
            case Dm.SqlRel.RecordCount of
              0:
                begin
                  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                  exit;
                end;
            else
              begin
                application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'DRC Carta Convite';
                FrmFrProdExtContaCorrente.Tag := 26;
                FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
              end;
            end;
          end;
        27: // Faturamento DRC Carta Convite
           begin
             Dm.SqlRel.Close;
             Dm.SqlRel.Sql.Clear;
             Dm.SqlRel.Sql.Add('select count(cg120_dtbaixa),count(cg120_dtbaixa)*:x,');
             Dm.SqlRel.Sql.Add('cg120_dtbaixa from cga120');
             Dm.SqlRel.Sql.Add(' where cga120.cg120_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
             Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
             Dm.SqlRel.Sql.Add(' group by cg120_dtbaixa order by cg120_dtbaixa');
             valor := StrToFloat(InputBox('Ads','Digite o Valor por Documento'+#10+'Ex: 0,01',''));
             Dm.SqlRel.Params[0].Value:= valor;
             Dm.SqlRel.Open;
             case Dm.SqlRel.RecordCount of
               0:
                 begin
                   Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                   exit;
                 end;
             else
               begin
                 Application.CreateForm(TFrmFrRelFaturamentoExt,FrmFrRelFaturamentoExt);
                 FrmFrRelFaturamentoExt.RLGroup1.DataFields := Dm.SqlRel.Fields[2].DisplayName;
                 FrmFrRelFaturamentoExt.RlTipoRelat.Caption := 'Extrato DRC Carta Convite';
                 FrmFrRelFaturamentoExt.RlPeriodo.Caption   := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                 FrmFrRelFaturamentoExt.RlValorFin.DataField := Dm.SqlRel.Fields[1].DisplayName;
                 FrmFrRelFaturamentoExt.RlValorUnitario.Caption := 'Valor Unit�rio: R$ '+ FloatToStr(valor);
                 FrmFrRelFaturamentoExt.RLReport1.PreviewModal;
               end;
             end;
           end;
        28: // Produ��o Cart�o Seguran�a
           begin
              with Dm.SqlRel do
                begin
                  sel := 'select sum(ads05servnlido_qtd) from ads005_servnaolido where (ads05servnlido_codserv = :cod) and (ads05servnlido_dti between :dti and :dtf)';
                  Close;
                  SQL.Clear;
                  SQL.Add(sel);
                  SqlRel.Params[0].Value    :=  6;
                  SqlRel.Params[1].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                  SqlRel.Params[2].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                  Open;
                  nlido :=  Fields[0].AsInteger;
//                  sel := 'SELECT COUNT(cg130_dtret) FROM cga130 WHERE (cg130_dtret is not null) ';
 //                 sel := sel + Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtfin.Text)+1)+Chr(39);
      //            sel := sel + ' and cgafatcrtcrd.cgfatcrtcrd_dtret is not null';
                  sel := 'SELECT COUNT(cg130_dtret) FROM cga130 WHERE (cg130_dtbaixa between '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtIni.Text))+Chr(39);
                  sel := sel + ' and '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtFin.Text))+Chr(39)+') ';
                  //inputbox('','',sel);
                  Close;
                  SQL.Clear;
                  SQL.Add(sel);
                  Open;
                  vRes  := Fields[0].AsInteger;
                  Close;
                  Sql.Clear;
                  Sql.Add('select count(cga130.cg130_dtbaixa),');
                  Sql.Add('cga130.cg130_dtbaixa,cga20.cg20_descricao,cga20.cg20_codbaixa ');
                  Sql.Add(' from cga130 inner join cga20 on cga130.cg130_codbaixa = cga20.cg20_codbaixa');
                  Sql.Add(' where cga130.cg130_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
                  Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
                  Sql.Add(' group by cga130.cg130_dtbaixa,cga20.cg20_descricao,cga20.cg20_codbaixa');
                  Sql.Add(' order by cga20.cg20_descricao,cga130.cg130_dtbaixa');
                  open;
                  case RecordCount of
                    0:
                      begin
                        Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                        exit;
                      end;
                  else
                    begin
                      application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                      FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Fields[2].DisplayName;
                      FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Extrato Cart�o Seguran�a';
                      FrmFrProdExtContaCorrente.Tag := 28;
                      FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                      FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
                    end;
                  end;
                end;
          end;
        29: // Produ��o C�digo de �tica
           begin
            Dm.SqlRel.Close;
            Dm.SqlRel.Sql.Clear;
            Dm.SqlRel.Sql.Add('select count(cga140.cg140_dtcad),');
            Dm.SqlRel.Sql.Add('cga140.cg140_dtcad,cga140.cg140_codag ');
            Dm.SqlRel.Sql.Add(' from cga140 ');
            Dm.SqlRel.Sql.Add(' where cga140.cg140_dtcad between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' group by cga140.cg140_dtcad,cga140.cg140_codag');
            Dm.SqlRel.Sql.Add(' order by cga140.cg140_dtcad,cga140.cg140_codag');
            Dm.SqlRel.open;
            case Dm.SqlRel.RecordCount of
              0:
                begin
                  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                  exit;
                end;
            else
              begin
                application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Cadastro C�digo de �tica';
                FrmFrProdExtContaCorrente.Tag := 29;
                FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
              end;
            end;
           end;
        31: // Produ��o Brindes Secret�ria
           begin
            Dm.SqlRel.Close;
            Dm.SqlRel.Sql.Clear;
            Dm.SqlRel.Sql.Add('select count(cga145.cg145_remes),cga145.cg145_dtsai,');
            Dm.SqlRel.Sql.Add('cga145.cg145_remes ');
            Dm.SqlRel.Sql.Add(' from cga145 ');
            Dm.SqlRel.Sql.Add(' where cga145.cg145_dtsai between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' group by cga145.cg145_dtsai,cga145.cg145_remes');
            Dm.SqlRel.Sql.Add(' order by cga145.cg145_dtsai');
            Dm.SqlRel.open;
            case Dm.SqlRel.RecordCount of
              0:
                begin
                  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                  exit;
                end;
            else
              begin
                application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[0].DisplayName;
                FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Sa�da de Brindes Secret�ria';
                FrmFrProdExtContaCorrente.Tag := 29;
                FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
              end;
            end;
           end;

        32: // Produ��o Tokens por Tipo de Pessoa
           begin
            Dm.SqlRel.Close;
            Dm.SqlRel.Sql.Clear;
            Dm.SqlRel.Sql.Add('select count(cga76.cg76_dtsai),');
            Dm.SqlRel.Sql.Add('cga76.cg76_dtsai,cga76.cg76_ag,cga76.cg76_tipocli ');
            Dm.SqlRel.Sql.Add(' from cga76 ');
            Dm.SqlRel.Sql.Add(' where (cga76.cg76_dtsai between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39)+'');
            Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39)+') ');
            Dm.SqlRel.Sql.Add('and (cg76_ag between '+chr(39)+trim(EdAgIni.Text)+chr(39)+' and '+chr(39)+trim(EdAgFin.Text)+chr(39)+') ');
            case RdGrpTipo.ItemIndex of
              0:Dm.SqlRel.Sql.Add('and (cg76_tipocli = 0)' );
              1:Dm.SqlRel.Sql.Add('and (cg76_tipocli = 1)' );
            end;
            Dm.SqlRel.Sql.Add(' group by cga76.cg76_dtsai,cga76.cg76_ag,cga76.cg76_tipocli');
            Dm.SqlRel.Sql.Add(' order by cga76.cg76_dtsai,cga76.cg76_ag,cga76.cg76_tipocli');
            Dm.SqlRel.Open;
            case Dm.SqlRel.RecordCount of
              0:
                begin
                  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                  exit;
                end;
            else
              begin
                application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Tokens Bradesco';
                case RdGrpTipo.ItemIndex of
                  0:FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := FrmFrProdExtContaCorrente.RlTipoRelat.Caption  + ' Tipo de Cliente CPF';
                  1:FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := FrmFrProdExtContaCorrente.RlTipoRelat.Caption  + ' Tipo de Cliente CNPJ';
                  2:FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := FrmFrProdExtContaCorrente.RlTipoRelat.Caption  + ' Tipo de Cliente Todos';
                end;
                FrmFrProdExtContaCorrente.Tag := 29;
                FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
              end;
            end;
           end;
        33: // Baixa C�digo de �tica
           begin

            Dm.SqlRel.Close;
            Dm.SqlRel.Sql.Clear;
            Dm.SqlRel.Sql.Add('select count(cga140.cg140_dtbxa),');
            Dm.SqlRel.Sql.Add('cga140.cg140_dtbxa,cga140.cg140_codag ');
            Dm.SqlRel.Sql.Add(' from cga140 ');
            Dm.SqlRel.Sql.Add(' where cga140.cg140_dtbxa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' group by cga140.cg140_dtbxa,cga140.cg140_codag');
            Dm.SqlRel.Sql.Add(' order by cga140.cg140_dtbxa,cga140.cg140_codag');
            Dm.SqlRel.open;
            case Dm.SqlRel.RecordCount of
              0:
                begin
                  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                  exit;
                end;
            else
              begin
                application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Baixa C�digo de �tica';
                FrmFrProdExtContaCorrente.Tag := 29;
                FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
              end;
            end;
           end;
        34: selplantok;// Gera Planilha Token
        35: // Faturamento token
          begin
            Dm.SqlRel.Close;
            Dm.SqlRel.Sql.Clear;
            Dm.SqlRel.Sql.Add('select count(cg76_remes),cg76_dtsai from cga76');
            Dm.SqlRel.Sql.Add(' where cga76.cg76_dtsai between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' group by cg76_dtsai order by cg76_dtsai');
            Dm.SqlRel.Open;
            case Dm.SqlRel.RecordCount of
              0:  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
              else
                begin
                  Application.CreateForm(TFrRelFaturamentoToken,FrRelFaturamentoToken);
                  FrRelFaturamentoToken.RLGroup1.DataFields := Dm.SqlRel.Fields[1].DisplayName;
                  FrRelFaturamentoToken.RlTipoRelat.Caption := 'Leitura de Baixa de Token';
                  FrRelFaturamentoToken.RlPeriodo.Caption   := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                  FrRelFaturamentoToken.RlValorFin.DataField := Dm.SqlRel.Fields[1].DisplayName;
                  FrRelFaturamentoToken.RLReport1.PreviewModal;
                end;
            end;
            Dm.SqlRel.Close;
            Dm.SqlRel.Sql.Clear;
            Dm.SqlRel.Sql.Add('select count(cg76_remes),cg76_dtentr from cga76');
            Dm.SqlRel.Sql.Add(' where cga76.cg76_dtentr between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' group by cg76_dtentr order by cg76_dtentr');
            Dm.SqlRel.Open;
            case Dm.SqlRel.RecordCount of
              0:;//
            else
              begin
                Application.CreateForm(TFrRelFaturamentoToken,FrRelFaturamentoToken);
                FrRelFaturamentoToken.RLGroup1.DataFields := Dm.SqlRel.Fields[1].DisplayName;
                FrRelFaturamentoToken.RlTipoRelat.Caption := 'Leitura de Entrada de Token';
                FrRelFaturamentoToken.RlPeriodo.Caption   := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                FrRelFaturamentoToken.RlValorFin.DataField := Dm.SqlRel.Fields[1].DisplayName;
                FrRelFaturamentoToken.RLReport1.PreviewModal;
              end;
            end;
          end;
        36: // faturamento Tancode
          begin
            Dm.SqlRel.Close;
            Dm.SqlRel.Sql.Clear;
            Dm.SqlRel.Sql.Add('select count(cg130_dtbaixa),count(cg130_dtbaixa)*:x,');
            Dm.SqlRel.Sql.Add('cg130_dtbaixa from cga130');
            Dm.SqlRel.Sql.Add(' where cga130.cg130_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' group by cg130_dtbaixa order by cg130_dtbaixa');
            valor := StrToFloat(InputBox('Ads','Digite o Valor por Documento'+#10+'Ex: 0,01',''));
            Dm.SqlRel.Params[0].Value:= valor;
            Dm.SqlRel.Open;
            case Dm.SqlRel.RecordCount of
              0:
                begin
                  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                  exit;
                end;
            else
              begin
                Application.CreateForm(TFrRelFaturamentoTancode,FrRelFaturamentoTancode);
                FrRelFaturamentoTancode.RLGroup1.DataFields := Dm.SqlRel.Fields[2].DisplayName;
                FrRelFaturamentoTancode.RlTipoRelat.Caption := 'Tancode';
                FrRelFaturamentoTancode.RlPeriodo.Caption   := 'Per�odo de '+MkEdDtIni.Text +' a '+MkEdDtFin.Text;
                FrRelFaturamentoTancode.RlValorFin.DataField := Dm.SqlRel.Fields[1].DisplayName;
                FrRelFaturamentoTancode.RlValorUnitario.Caption := 'Valor Unit�rio: R$ '+ FloatToStr(valor);
                FrRelFaturamentoTancode.RLReport1.PreviewModal;
              end;
            end;
          end;
        37: // faturamento
          begin
            Dm.SqlRel.Close;
            Dm.SqlRel.Sql.Clear;
            Dm.SqlRel.Sql.Add('select count(cg140_dtbxa),count(cg140_dtbxa)*:x,');
            Dm.SqlRel.Sql.Add('cg140_dtbxa from cga140');
            Dm.SqlRel.Sql.Add(' where cga140.cg140_dtbxa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' group by cg140_dtbxa order by cg140_dtbxa');
            valor := StrToFloat(InputBox('Ads','Digite o Valor por Documento'+#10+'Ex: 0,01',''));
            Dm.SqlRel.Params[0].Value:= valor;
            Dm.SqlRel.Open;
            case Dm.SqlRel.RecordCount of
              0:
                begin
                  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                  exit;
                end;
            else
              begin
                Application.CreateForm(TFrRelFaturamentoEtica,FrRelFaturamentoEtica);
                FrRelFaturamentoEtica.RLGroup1.DataFields := Dm.SqlRel.Fields[2].DisplayName;
                FrRelFaturamentoEtica.RlTipoRelat.Caption := 'C�digo de �tica';
                FrRelFaturamentoEtica.RlPeriodo.Caption   := 'Per�odo de '+MkEdDtIni.Text +' a '+MkEdDtFin.Text;
                FrRelFaturamentoEtica.RlValorFin.DataField := Dm.SqlRel.Fields[1].DisplayName;
                FrRelFaturamentoEtica.RlValorUnitario.Caption := 'Valor Unit�rio: R$ '+ FloatToStr(valor);
                FrRelFaturamentoEtica.RLReport1.PreviewModal;
              end;
            end;
          end;
        38: // Cart�o de Cr�dito Bradesco.
          begin
            with Dm.SqlRel do
              begin
                sel := 'select sum(ads05servnlido_qtd) from ads005_servnaolido where (ads05servnlido_codserv = :cod) and (ads05servnlido_dti between :dti and :dtf)';
                Close;
                SQL.Clear;
                SQL.Add(sel);
                SqlRel.Params[0].Value    :=  10;
                SqlRel.Params[1].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                SqlRel.Params[2].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                Open;
                nlido :=  Fields[0].AsInteger;
                sel := 'SELECT COUNT(cgafatcrtcrd.cgfatcrtcrd_dtret) FROM cgafatcrtcrd WHERE (cgafatcrtcrd.cgfatcrtcrd_dtret is not null) ';
//                sel := sel + Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtfin.Text)+1)+Chr(39);
    //            sel := sel + ' and cgafatcrtcrd.cgfatcrtcrd_dtret is not null';
                sel:= sel+'and (cgafatcrtcrd.cgfatcrtcrd_dtbaixa between '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtIni.Text))+Chr(39);
                sel := sel + ' and '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtFin.Text))+Chr(39)+') ';
                //inputbox('','',sel);
                Close;
                SQL.Clear;
                SQL.Add(sel);
                Open;
                vRes  := Dm.SqlRel.Fields[0].AsInteger;
                sel := 'SELECT COUNT (cgafatcrtcrd.cgfatcrtcrd_dtbaixa),cgafatcrtcrd.cgfatcrtcrd_dtbaixa, ';
                sel := sel + 'cga20.cg20_descricao,cga20.cg20_codbaixa FROM cgafatcrtcrd ';
                sel := sel + 'inner join cga_acesso on cga_acesso.codigo = cgafatcrtcrd.cgfatcrtcrd_codusu ';
                sel := sel + 'inner join cga20 on cga20.cg20_codbaixa = cgafatcrtcrd.cgfatcrtcrd_codbaixa ';
                sel := sel + ' WHERE cgafatcrtcrd.cgfatcrtcrd_dtbaixa between '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtIni.Text))+Chr(39);
                sel := sel + ' and '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtFin.Text))+Chr(39);
                sel := sel + ' group by cgafatcrtcrd.cgfatcrtcrd_dtbaixa,cga20.cg20_descricao,cga20.cg20_codbaixa ';
                sel := sel + 'order by cga20.cg20_descricao,cgafatcrtcrd.cgfatcrtcrd_dtbaixa ';
                //InputBox('','',sel);
                {Exit;}
                Close;
                SQL.Clear;
                SQL.Add(sel);
                Open;
                case Dm.SqlRel.RecordCount of
                0: Application.MessageBox('N�o foram Encontrados Registros com Esses Parametros!!!','ADS',MB_ICONINFORMATION);
                else
                  begin
                    application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                    FrmFrProdExtContaCorrente.Tag := 38;
                    FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                    FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Fatura de Cart�o Cr�dito';
                    FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' a '+MkEdDtFin.Text;
                    FrmFrProdExtContaCorrente.RLBand5.Enabled      := false;
                    FrmFrProdExtContaCorrente.RLBand5.Visible      := true;
                    FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
                  end;
                end;
              end;
          end;
        39: // Produ��o Tokens Lidos
           begin
            Dm.SqlRel.Close;
            Dm.SqlRel.Sql.Clear;
            Dm.SqlRel.Sql.Add('select count(cga76.cg76_dtentr),cga76.cg76_dtentr,upper(cga_acesso.nome) ');
            Dm.SqlRel.Sql.Add('from cga76 ');
            Dm.SqlRel.Sql.Add('inner join cga_acesso on cga76.cg76_codusu_dig = cga_acesso.codigo ');
            Dm.SqlRel.Sql.Add('where (cga76.cg76_dtentr between :dtini and :dtfin) ');
            Dm.SqlRel.Sql.Add('group by cga76.cg76_dtentr,cga_acesso.nome ');
            Dm.SqlRel.Sql.Add('order by upper(cga_acesso.nome),cga76.cg76_dtentr ');
            Dm.SqlRel.Params[0].AsDate  :=  strtodate(MkEdDtIni.Text);
            Dm.SqlRel.Params[1].AsDate  :=  strtodate(MkEdDtFin.Text);
            Dm.SqlRel.Open;
            case Dm.SqlRel.RecordCount of
            0:
              begin
                Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                exit;
              end;
            else
              begin
                application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Tokens Lidos Bradesco';
                FrmFrProdExtContaCorrente.Tag := 39;
                FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
              end;
            end;
           end;
        40:
          begin
            sel := 'select  "QTDE","DATA","Usuario", ';
            sel := sel + 'case';
            sel := sel + ' when ("Tipo_Servico" = 00) then '+Chr(39)+'CONTA CORRENTE/POUPAN�A'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 01) then '+Chr(39)+'UNIFICADO'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 02) then '+Chr(39)+'CONSOLIDADO'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 03) then '+Chr(39)+'DRC COBRAN�A'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 04) then '+Chr(39)+'DRC CARTA CONVITE'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 05) then '+Chr(39)+'CART�O SEGURAN�A'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 06) then '+Chr(39)+'BANCO POSTAL'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 07) then '+Chr(39)+'CVM'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 08) then '+Chr(39)+'TOKENS ENTRADA'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 09) then '+Chr(39)+'TOKENS SA�DA'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 10) then '+Chr(39)+'EXTRATO CART�O CR�DITO'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 11) then '+Chr(39)+'C�DIGO �TICA CADASTRO'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 12) then '+Chr(39)+'C�DIGO �TICA BAIXA'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 13) then '+Chr(39)+'BRINDES SECRET�RIA'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 14) then '+Chr(39)+'FATURA CART�O CR�DITO'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 15) then '+Chr(39)+'DRC AVISO DE COBRAN�A'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 16) then '+Chr(39)+'CARTA SENHA'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 17) then '+Chr(39)+'EXTRATO RECIBO CONSORCIADO'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 18) then '+Chr(39)+'EXTRATO FINASA FPE'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 19) then '+Chr(39)+'BOLETO FINASA CLI'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 20) then '+Chr(39)+'CARTA FINASA CLI'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 21) then '+Chr(39)+'DRC PRIVATE LABEL'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 22) then '+Chr(39)+'DRC FATURA CART�O DE CR�DITO'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 23) then '+Chr(39)+'DRC ZOGBI-MCSI'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 24) then '+Chr(39)+'DRC AMEX'+Chr(39);
            sel := sel + ' end ';
            sel := sel + 'from relcons ';
            sel := sel + 'where "DATA" between :dti AND :dtf ';
            sel := sel + ' order by "Usuario","DATA","Tipo_Servico"';
            with Dm.SqlRel do
              begin
                Close;
                SQL.Clear;
                SQL.Add(sel);
                ParamByName('dti').asDate := StrToDate(MkEdDtIni.Text);
                ParamByName('dtf').asDate := StrToDate(MkEdDtFin.Text);
                Open;
              end;
            case Dm.SqlRel.RecordCount of
            0:
              begin
                Application.MessageBox('Registro n�o encontrado!!!','ADS',0);
                Dm.SqlRel.Close;
                Exit;
              end
            else
              begin
                Application.CreateForm(TFrmRelCons,FrmRelCons);
                FrmRelCons.RLReport1.PreviewModal;
                FrmRelCons.RLReport1.Destroy;
              end;
            end;
          end;
        41:
          begin
            sel := 'select sum("QTDE"),"Motivo","CodBaixa","Tipo_Servico" ';
            sel := sel + 'from prod_extratos where ("DATA" between :dtini and :dtfin) ';
            sel := sel + 'group by "Motivo","CodBaixa","Tipo_Servico" ';
            sel := sel + 'order by "CodBaixa" ';
            SqlAux1.Close;
            SqlAux1.SQL.Clear;
            SqlAux1.SQL.Add(sel);
            SqlAux1.Params[0].AsString :=  formatdatetime('mm/dd/yyyy',strtodate(MkEdDtIni.Text));
            SqlAux1.Params[1].AsString :=  formatdatetime('mm/dd/yyyy',strtodate(MkEdDtFin.Text));
            SqlAux1.Open;
            SqlAux1.First;
            servant   :=  dm.SqlAux1.Fields[1].AsString;
            SetLength( Matriz, 9);
{            for i := 0 to 8 do
            SetLength( Matriz[i], 14);
            for i := 0 to 8 do
              begin
                for j := 0 to 13 do
                  Matriz[i,j]  :=  '';
              end;}

            case SqlAux1.Fields[2].AsInteger of
              106 :SetLength( Matriz[0], 15);
              103 :SetLength( Matriz[1], 15);
              112 :SetLength( Matriz[2], 15);
              102 :SetLength( Matriz[3], 15);
              100 :SetLength( Matriz[4], 15);
              108 :SetLength( Matriz[5], 15);
              116 :SetLength( Matriz[6], 15);
              109 :SetLength( Matriz[7], 15);
              120 :SetLength( Matriz[8], 15);
            end;

            //SetLength( Matriz[i], 13);
//            Matriz[0,1]:=dm.SqlAux1.Fields[2].AsString;
            case SqlAux1.Fields[2].AsInteger of
              106 :Matriz[0,0]  :=  'Mudou-se';
              103 :Matriz[1,0]  :=  'End. Insulficiente';
              112 :Matriz[2,0]  :=  'Falecido';
              102 :Matriz[3,0]  :=  'Desconhecido';
              100 :Matriz[4,0]  :=  'Ausente';
              108 :Matriz[5,0]  :=  'N� n�o Existe';
              116 :Matriz[6,0]  :=  'Outros';
              109 :Matriz[7,0]  :=  'Recusado';
              120 :Matriz[8,0]  :=  'Entrada/Sa�da';
            end;

            while not dm.SqlAux1.Eof do
              begin
                if servant   =  dm.SqlAux1.Fields[1].AsString then
                  begin
                    if ((SqlAux1.Fields[2].Value = null) and (SqlAux1.Fields[3].AsInteger = 4)) then
                      Matriz[8,SqlAux1.Fields[3].AsInteger]  :=  inttostr(strtoint(Matriz[8,SqlAux1.Fields[3].AsInteger])+SqlAux1.Fields[0].AsInteger)
                    else
                      begin
                        case SqlAux1.Fields[2].AsInteger of
                          106 :Matriz[0,SqlAux1.Fields[3].AsInteger]  :=  SqlAux1.Fields[0].AsString;
                          103 :Matriz[1,SqlAux1.Fields[3].AsInteger]  :=  SqlAux1.Fields[0].AsString;
                          112 :Matriz[2,SqlAux1.Fields[3].AsInteger]  :=  SqlAux1.Fields[0].AsString;
                          102 :Matriz[3,SqlAux1.Fields[3].AsInteger]  :=  SqlAux1.Fields[0].AsString;
                          100 :Matriz[4,SqlAux1.Fields[3].AsInteger]  :=  SqlAux1.Fields[0].AsString;
                          108 :Matriz[5,SqlAux1.Fields[3].AsInteger]  :=  SqlAux1.Fields[0].AsString;
                          116 :Matriz[6,SqlAux1.Fields[3].AsInteger]  :=  SqlAux1.Fields[0].AsString;
                          109 :Matriz[7,SqlAux1.Fields[3].AsInteger]  :=  SqlAux1.Fields[0].AsString;
                          120 :Matriz[8,SqlAux1.Fields[3].AsInteger]  :=  SqlAux1.Fields[0].AsString;
                        end;
                      end;
                    dm.SqlAux1.Next;
                  end
                else
                  begin
                   servant   :=  dm.SqlAux1.Fields[1].AsString;
                    if ((dm.SqlAux1.Fields[2].Value = null) and (dm.SqlAux1.Fields[3].AsInteger = 4)) then
                      begin
                        SetLength( Matriz[8], 14);
                        Matriz[8,0]  :=  'Entrada/Sa�da';
                      end
                    else
                      begin
                        case dm.SqlAux1.Fields[2].AsInteger of
                          106 :SetLength( Matriz[0], 15);
                          103 :SetLength( Matriz[1], 15);
                          112 :SetLength( Matriz[2], 15);
                          102 :SetLength( Matriz[3], 15);
                          100 :SetLength( Matriz[4], 15);
                          108 :SetLength( Matriz[5], 15);
                          116 :SetLength( Matriz[6], 15);
                          109 :SetLength( Matriz[7], 15);
                          120 :SetLength( Matriz[8], 15);
                        end;
            //            Matriz[0,1]:=dm.SqlAux1.Fields[2].AsString;
                        case dm.SqlAux1.Fields[2].AsInteger of
                          106 :Matriz[0,0]  :=  'Moudou-se';
                          103 :Matriz[1,0]  :=  'End. Insulficiente';
                          112 :Matriz[2,0]  :=  'Falecido';
                          102 :Matriz[3,0]  :=  'Desconhecido';
                          100 :Matriz[4,0]  :=  'Ausente';
                          108 :Matriz[5,0]  :=  'N� n�o Existe';
                          116 :Matriz[6,0]  :=  'Outros';
                          109 :Matriz[7,0]  :=  'Recusado';
                          120 :Matriz[8,0]  :=  'Entrada/Sa�da';
                        end;

                      end;
                    //SetLength( Matriz[i], 13);
                  end;
              end;
              criatemp;
              inseretemp;
              case erro of
                false:
                  begin
                  with dm do
                  begin
                  SqlAux1.Close;
                  SqlAux1.SQL.Clear;
                  SqlAux1.SQL.Add('select sum("QTDE"),"Tipo_Servico" from total_extratos_teste01 where ("Dtlido" between :dtini and :dtfin) ');
                  SqlAux1.SQL.Add('and ("Tipo_Servico" < 4 or "Tipo_Servico" > 5) and ("DATA" is not null) group by "Tipo_Servico" order by "Tipo_Servico"');
                  SqlAux1.Params[0].AsString  :=  formatdatetime('mm/dd/yyyy',strtodate(MkEdDtIni.Text));
                  SqlAux1.Params[1].AsString  :=  formatdatetime('mm/dd/yyyy',strtodate(MkEdDtFin.Text));
                  SqlAux1.Open;
                  SqlAux1.First;
                  while not(SqlAux1.Eof) do
                    begin
                      case SqlAux1.Fields[1].AsInteger of
                        1:Matriz1[2]:=SqlAux1.Fields[0].Value;    //  Consolidado
                        2:Matriz1[1]:=SqlAux1.Fields[0].Value;    //  CCP
                        3:Matriz1[0]:=SqlAux1.Fields[0].Value;    //  Unificado
                        12:Matriz1[3]:=SqlAux1.Fields[0].Value;   //  ?
                        9:Matriz1[4]:=SqlAux1.Fields[0].Value;    //  TanCode
                        7:Matriz1[5]:=SqlAux1.Fields[0].Value;    //  Drc Cobran�a
                        8:Matriz1[6]:=SqlAux1.Fields[0].Value;    //  Dec Carta Convite
                        6:Matriz1[7]:=SqlAux1.Fields[0].Value;    //  Drc Aviso de Cobran�a
                        13:Matriz1[8]:=SqlAux1.Fields[0].Value;   //  Fatura de Cart�o de Credito
                        11:Matriz1[11]:=SqlAux1.Fields[0].Value;  //  Banco Postal
                        10:Matriz1[12]:=SqlAux1.Fields[0].Value;  //  Carta de �tica
                        14:Matriz1[13]:=SqlAux1.Fields[0].Value;  //  Carta Senha Consorcio
                        15:Matriz1[14]:=SqlAux1.Fields[0].Value;  //  Extrato Recibo Consorciado

                      end;
                      SqlAux1.Next;
                    end;
                  SqlAux1.Close;
                  SqlAux1.SQL.Clear;
                  SqlAux1.SQL.Add('select sum("QTDE"),"Tipo_Servico" from total_extratos_teste01 where ("Dtlido" between :dtini and :dtfin) ');
                  SqlAux1.SQL.Add('and ("Tipo_Servico" in (4,5)) group by "Tipo_Servico" order by "Tipo_Servico"');
                  SqlAux1.Params[0].AsString  :=  formatdatetime('mm/dd/yyyy',strtodate(MkEdDtIni.Text));
                  SqlAux1.Params[1].AsString  :=  formatdatetime('mm/dd/yyyy',strtodate(MkEdDtFin.Text));
                  SqlAux1.Open;
                  SqlAux1.First;
                  while not (SqlAux1.Eof) do
                    begin
                      case SqlAux1.Fields[1].AsInteger of
                        4:Matriz1[9]:=SqlAux1.Fields[0].Value;
                        5:Matriz1[10]:=SqlAux1.Fields[0].Value;
                      end;
                      SqlAux1.Next;
                    end;
                  SqlAux1.Close;
                  SqlAux1.SQL.Clear;
                  SqlAux1.SQL.Add('select sum("Qtde"),"Tipo" from vnlido where ("Data" between :dtini and :dtfin) ');
                  SqlAux1.SQL.Add('and ("Tipo" < 12 or "Tipo" > 13) group by "Tipo" order by "Tipo"');
                  SqlAux1.Params[0].AsString  :=  formatdatetime('mm/dd/yyyy',strtodate(MkEdDtIni.Text));
                  SqlAux1.Params[1].AsString  :=  formatdatetime('mm/dd/yyyy',strtodate(MkEdDtFin.Text));
                  SqlAux1.Open;
                  SqlAux1.First;
                  while not(SqlAux1.Eof) do
                    begin
                      case SqlAux1.Fields[1].AsInteger of
                        1:Matriz2[0]:=SqlAux1.Fields[0].Value;    //  Extrato Consolidade n�o Lido
                        2:Matriz2[2]:=SqlAux1.Fields[0].Value;    //  Extrato CCP n�o Lido
                        5:Matriz2[1]:=SqlAux1.Fields[0].Value;    //  Exrato Unificado n�o Lido
                        7:Matriz2[3]:=SqlAux1.Fields[0].Value;    //  Exrato CVM
                        6:Matriz2[4]:=SqlAux1.Fields[0].Value;    //  TanCode
                        3:Matriz2[5]:=SqlAux1.Fields[0].Value;    //  Drc Cobranca
                        4:Matriz2[6]:=SqlAux1.Fields[0].Value;    //  Drc Carta Convite
                        8,9:Matriz2[13]:=SqlAux1.Fields[0].Value; //  C�digo de �tica Bradesco Cadastro e Baixa
                        10:Matriz2[8]:=SqlAux1.Fields[0].Value;   //  Fatura Cart�o de Cr�dido
                        11:Matriz2[7]:=SqlAux1.Fields[0].Value;   //  Drc Avisode Cobran�a
                        14:Matriz2[13]:=SqlAux1.Fields[0].Value;  //  Carta Senha Consorcio
                        15:Matriz2[14]:=SqlAux1.Fields[0].Value;  //  Recibo Extrato Consorciado
                      end;
                      SqlAux1.Next;
                    end;
                  SqlAux1.Close;
                  SqlAux1.SQL.Clear;
                  SqlAux1.SQL.Add('select sum("Qtde"),"Tipo" from vnlido where ("Data" between :dtini and :dtfin) ');
                  SqlAux1.SQL.Add('and ("Tipo" in (12,13)) group by "Tipo" order by "Tipo"');
                  SqlAux1.Params[0].AsString  :=  formatdatetime('mm/dd/yyyy',strtodate(MkEdDtIni.Text));
                  SqlAux1.Params[1].AsString  :=  formatdatetime('mm/dd/yyyy',strtodate(MkEdDtFin.Text));
                  SqlAux1.Open;
                  SqlAux1.First;
                  while not (SqlAux1.Eof) do
                    begin
                      case SqlAux1.Fields[1].AsInteger of
                        12:Matriz2[9]:=SqlAux1.Fields[0].Value;
                        13:Matriz2[10]:=SqlAux1.Fields[0].Value;
                      end;
                      SqlAux1.Next;
                    end;
                  ZRResumo.Open;
                  DtSResumo.DataSet.Refresh;
                  Application.CreateForm(TFrmRlResumo,FrmRlResumo);
                  FrmRlResumo.RLLabel18 .Caption := inttostr(matriz1[0]);
                  FrmRlResumo.RLLabel19 .Caption := inttostr(matriz1[1]);
                  FrmRlResumo.RLLabel20 .Caption := inttostr(matriz1[2]);
                  FrmRlResumo.RLLabel21 .Caption := inttostr(matriz1[3]);
                  FrmRlResumo.RLLabel22 .Caption := inttostr(matriz1[4]);
                  FrmRlResumo.RLLabel23 .Caption := inttostr(matriz1[5]);
                  FrmRlResumo.RLLabel24 .Caption := inttostr(matriz1[6]);
                  FrmRlResumo.RLLabel25 .Caption := inttostr(matriz1[7]);
                  FrmRlResumo.RLLabel26 .Caption := inttostr(matriz1[8]);
                  FrmRlResumo.RLLabel27 .Caption := inttostr(matriz1[9]);
                  FrmRlResumo.RLLabel28 .Caption := inttostr(matriz1[10]);
                  FrmRlResumo.RLLabel29 .Caption := inttostr(matriz1[11]);
                  FrmRlResumo.RLLabel30 .Caption := inttostr(matriz1[12]);
                  FrmRlResumo.RLLabel60 .Caption := inttostr(matriz1[13]);
                  FrmRlResumo.RLLabel65 .Caption := inttostr(matriz1[14]);
                  FrmRlResumo.RLLabel33 .Caption := inttostr(Matriz2[0]);
                  FrmRlResumo.RLLabel34 .Caption := inttostr(Matriz2[1]);
                  FrmRlResumo.RLLabel35 .Caption := inttostr(Matriz2[2]);
                  FrmRlResumo.RLLabel36 .Caption := inttostr(Matriz2[3]);
                  FrmRlResumo.RLLabel37 .Caption := inttostr(Matriz2[4]);
                  FrmRlResumo.RLLabel38 .Caption := inttostr(Matriz2[5]);
                  FrmRlResumo.RLLabel39 .Caption := inttostr(Matriz2[6]);
                  FrmRlResumo.RLLabel40 .Caption := inttostr(Matriz2[7]);
                  FrmRlResumo.RLLabel41 .Caption := inttostr(Matriz2[8]);
                  FrmRlResumo.RLLabel42 .Caption := inttostr(Matriz2[9]);
                  FrmRlResumo.RLLabel43 .Caption := inttostr(Matriz2[10]);
                  FrmRlResumo.RLLabel44 .Caption := inttostr(Matriz2[11]);
                  FrmRlResumo.RLLabel45 .Caption := inttostr(Matriz2[12]);
                  FrmRlResumo.RLLabel61 .Caption := inttostr(Matriz2[13]);
                  FrmRlResumo.RLLabel66 .Caption := inttostr(Matriz2[14]);
                  FrmRLResumo.RLLabel31.Caption :=  'Per�odo de '+MkEdDtIni.Text+' � '+MkEdDtFin.Text;
                  FrmRlResumo.RLReport1.PreviewModal;
                  FrmRlResumo.RLReport1.Destroy;
//                  deltemp;
                  end;
                  end;
              end;
          end;
        42:  // Produ�ao DRC-Aviso de Cobran�a CLLP
          begin
            with Dm.SqlRel do
              begin
                sel := 'select sum(ads05servnlido_qtd) from ads005_servnaolido where (ads05servnlido_codserv = :cod) and (ads05servnlido_dti between :dti and :dtf)';
                Close;
                SQL.Clear;
                SQL.Add(sel);
                SqlRel.Params[0].Value    :=  11;
                SqlRel.Params[1].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                SqlRel.Params[2].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                Open;
                nlido :=  Fields[0].AsInteger;
                sel := 'SELECT COUNT(cg78_dtret) FROM cga78 WHERE (cg78_dtret is not null) ';
//                sel := sel + Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtIni.Text)+1)+Chr(39);
//                sel := sel + Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtfin.Text)+1)+Chr(39);
                sel:= sel+'and (cg78_dtbaixa between '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtIni.Text))+Chr(39);
                sel := sel + ' and '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtFin.Text))+Chr(39)+') ';
                Close;
                SQL.Clear;
                SQL.Add(sel);
                Open;
                vRes  := Dm.SqlRel.Fields[0].AsInteger;
                Dm.SqlRel.Close;
                Dm.SqlRel.Sql.Clear;
                Dm.SqlRel.Sql.Add('select count(cga78.cg78_remes),');
                Dm.SqlRel.Sql.Add('cga78.cg78_dtbaixa,cga20.cg20_descricao,cg20_codbaixa');
                Dm.SqlRel.Sql.Add(' from cga78 inner join cga20 on cga78.cg78_codbaixa = cga20.cg20_codbaixa');
                Dm.SqlRel.Sql.Add(' where cga78.cg78_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
                Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
                Dm.SqlRel.Sql.Add(' and (cga20.cg20_codbaixa <> ''119'')  group by cga78.cg78_dtbaixa,cga20.cg20_descricao,cg20_codbaixa');
                Dm.SqlRel.Sql.Add(' order by cga20.cg20_descricao,cga78.cg78_dtbaixa');
                Dm.SqlRel.open;
                case Dm.SqlRel.RecordCount of
                  0:
                    begin
                      Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                      exit;
                    end;
                else
                  begin
                    application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                    FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                    FrmFrProdExtContaCorrente.Tag := 42;
                    FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'DRC Aviso de Cobran�a - CLLP';
                    FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                    FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
                  end;
                end;
              end;
          end;
        43: // faturamento DRC - Aviso Cobran�a - CLLP
          begin
            Dm.SqlRel.Close;
            Dm.SqlRel.Sql.Clear;
            Dm.SqlRel.Sql.Add('select count(cg78_dtbaixa),count(cg78_dtbaixa)*:x,');
            Dm.SqlRel.Sql.Add('cg78_dtbaixa from cga78');
            Dm.SqlRel.Sql.Add(' where cga78.cg78_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
            Dm.SqlRel.Sql.Add(' group by cg78_dtbaixa order by cg78_dtbaixa');
            valor := StrToFloat(InputBox('Ads','Digite o Valor por Documento'+#10+'Ex: 0,01',''));
            Dm.SqlRel.Params[0].Value:= valor;
            Dm.SqlRel.Open;
            case Dm.SqlRel.RecordCount of
              0:
                begin
                  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                  exit;
                end;
            else
              begin
                Application.CreateForm(TFrmFrRelFaturamentoExt,FrmFrRelFaturamentoExt);
                FrmFrRelFaturamentoExt.RLGroup1.DataFields := Dm.SqlRel.Fields[2].DisplayName;
                FrmFrRelFaturamentoExt.RlTipoRelat.Caption := 'Faturamento DRC - Aviso de Cobran�a - CLLP';
                FrmFrRelFaturamentoExt.RlPeriodo.Caption   := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                FrmFrRelFaturamentoExt.RlValorFin.DataField := Dm.SqlRel.Fields[1].DisplayName;
                FrmFrRelFaturamentoExt.RlValorUnitario.Caption := 'Valor Unit�rio: R$ '+ FloatToStr(valor);
                FrmFrRelFaturamentoExt.RLReport1.PreviewModal;
                FrmFrRelFaturamentoExt.RLReport1.Destroy;
              end;
            end;
          end;
        44:  // Produ�ao Carta Senha
          begin
            with Dm.SqlRel do
              begin
                sel := 'select sum(ads05servnlido_qtd) from ads005_servnaolido where (ads05servnlido_codserv = :cod) and (ads05servnlido_dti between :dti and :dtf)';
                Close;
                SQL.Clear;
                SQL.Add(sel);
                SqlRel.Params[0].Value    :=  15;
                SqlRel.Params[1].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                SqlRel.Params[2].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                Open;
                nlido :=  Fields[0].AsInteger;
//                sel := 'SELECT COUNT(cg035_remes) FROM cga035 WHERE (cg035_dtret is not null) ';
                sel := 'SELECT COUNT(cg035_remes) FROM cga035 WHERE (cg035_dtret is not null) ';
                sel:= sel+'and (cg035_dtbaixa between '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtIni.Text))+Chr(39);
                sel := sel + ' and '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtFin.Text))+Chr(39)+') ';
                Close;
                SQL.Clear;
                SQL.Add(sel);
                Open;
                vRes  := Dm.SqlRel.Fields[0].AsInteger;
                Dm.SqlRel.Close;
                Dm.SqlRel.Sql.Clear;
                Dm.SqlRel.Sql.Add('select count(cga035.cg035_remes),');
                Dm.SqlRel.Sql.Add('cga035.cg035_dtbaixa,cga20.cg20_descricao,cg20_codbaixa');
                Dm.SqlRel.Sql.Add(' from cga035 inner join cga20 on cga035.cg035_codbaixa = cga20.cg20_codbaixa');
                Dm.SqlRel.Sql.Add(' where cga035.cg035_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
                Dm.SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
                Dm.SqlRel.Sql.Add(' group by cga035.cg035_dtbaixa,cga20.cg20_descricao,cg20_codbaixa');
                Dm.SqlRel.Sql.Add(' order by cga20.cg20_descricao,cga035.cg035_dtbaixa');
                Dm.SqlRel.open;
                case Dm.SqlRel.RecordCount of
                  0:
                    begin
                      Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                      exit;
                    end;
                else
                  begin
                    application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                    FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                    FrmFrProdExtContaCorrente.Tag := 44;
                    FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Carta Senha';
                    FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                    FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
                  end;
                end;
              end;
          end;
        45:  // Produ�ao Extrato Recibo Consorciado
          begin
            with Dm.SqlRel do
              begin
                sel := 'select sum(ads05servnlido_qtd) from ads005_servnaolido where (ads05servnlido_codserv = :cod) and (ads05servnlido_dti between :dti and :dtf)';
                Close;
                SQL.Clear;
                SQL.Add(sel);
                SqlRel.Params[0].Value    :=  15;
                SqlRel.Params[1].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                SqlRel.Params[2].AsString :=  formatdatetime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                Open;
                nlido :=  Fields[0].AsInteger;
//                sel := 'SELECT COUNT(cg036_remes) FROM cga036 WHERE (cg036_dtret is not null) ';
                sel := 'SELECT COUNT(cg036_remes) FROM cga036 WHERE (cg036_dtbaixa between '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtIni.Text))+Chr(39) + ' and '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtFin.Text))+Chr(39)+') ';
                Close;
                SQL.Clear;
                SQL.Add(sel);
                Open;
                vRes  := Fields[0].AsInteger;
                Close;
                Sql.Clear;
                Sql.Add('select count(cga036.cg036_remes),');
                Sql.Add('cga036.cg036_dtbaixa,cga20.cg20_descricao,cg20_codbaixa');
                Sql.Add(' from cga036 inner join cga20 on cga036.cg036_codbaixa = cga20.cg20_codbaixa');
                Sql.Add(' where cga036.cg036_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
                Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
                Sql.Add(' group by cga036.cg036_dtbaixa,cga20.cg20_descricao,cg20_codbaixa');
                Sql.Add(' order by cga20.cg20_descricao,cga036.cg036_dtbaixa');
                open;
                case Dm.SqlRel.RecordCount of
                  0:
                    begin
                      Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                      exit;
                    end;
                else
                  begin
                    application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                    FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                    FrmFrProdExtContaCorrente.Tag := 44;
                    FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Extrato/Recibo Consorciado';
                    FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                    FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
                  end;
                end;
              end;
          end;
        46:  // Retorno e Produ�ao Extrato Finasa FPE
          begin
            with Dm.SqlRel do
              begin
//                sel := 'SELECT COUNT(cg038_remes) FROM cga038 WHERE (cg038_dtret is not null) and (cg038_dtbaixa between :dti and :dtf) ';
                sel := 'SELECT COUNT(cg038_remes) FROM cga038 WHERE (cg038_dtbaixa between :dti and :dtf) ';
                Close;
                SQL.Clear;
                SQL.Add(sel);
                Params[0].Text  :=  FormatDateTime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                Params[1].Text  :=  FormatDateTime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                SqlRel.Open;
                vRes  := Dm.SqlRel.Fields[0].AsInteger;
                Close;
                Sql.Clear;
                Sql.Add('select count(cga038.cg038_remes),');
                Sql.Add('cga038.cg038_dtbaixa,cga20.cg20_descricao,cg20_codbaixa');
                Sql.Add(' from cga038 inner join cga20 on cga038.cg038_codbaixa = cga20.cg20_codbaixa');
//                Sql.Add(' where  (cg038_dtret is not null) and (cga038.cg038_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
                Sql.Add(' where  (cga038.cg038_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
                Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39)+') ');
                Sql.Add(' group by cga038.cg038_dtbaixa,cga20.cg20_descricao,cg20_codbaixa');
                Sql.Add(' order by cga20.cg20_descricao,cga038.cg038_dtbaixa');
                open;
                case Dm.SqlRel.RecordCount of
                  0:
                    begin
                      Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                      exit;
                    end;
                else
                  begin
                    application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                    FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                    FrmFrProdExtContaCorrente.Tag := 46;
                    FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Retorno Extrato Finasa FPE';
                    FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                    FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
                  end;
                end;
              end;
          end;
          47:  // Retorno e Produ�ao Boleto Finasa CLI
            begin
              with Dm.SqlRel do
                begin
//                  Sql.Add('where  (cg040_dtret is not null) and (cga040.cg040_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39)+' and ');
                  sel := 'SELECT COUNT(cg039_remes) FROM cga039 WHERE (cg039_dtbaixa between :dti and :dtf) ';
                  Close;
                  SQL.Clear;
                  SQL.Add(sel);
                  Params[0].Text  :=  FormatDateTime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                  Params[1].Text  :=  FormatDateTime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                  SqlRel.Open;
                  vRes  := Dm.SqlRel.Fields[0].AsInteger;
                  Close;
                  Sql.Clear;
                  Sql.Add('select count(cga039.cg039_remes),cga039.cg039_dtbaixa,cga20.cg20_descricao,cg20_codbaixa ');
                  Sql.Add('from cga039 inner join cga20 on cga039.cg039_codbaixa = cga20.cg20_codbaixa ');
//                  Sql.Add('where  (cg039_dtret is not null) and (cga039.cg039_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39)+' and ');
                  Sql.Add('where  (cga039.cg039_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39)+' and ');
                  Sql.Add(chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39)+') ');
                  Sql.Add('group by cga039.cg039_dtbaixa,cga20.cg20_descricao,cg20_codbaixa ');
                  Sql.Add('order by cga20.cg20_descricao,cga039.cg039_dtbaixa ');
                  open;
                  case Dm.SqlRel.RecordCount of
                    0:
                      begin
                        Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                        exit;
                      end;
                  else
                    begin
                      application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                      FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                      FrmFrProdExtContaCorrente.Tag := 47;
                      FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Retorno Boleto Finasa CLI';
                      FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                      FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
                    end;
                  end;
                end;
            end;
          48:  // Retorno e Produ�ao Carta Finasa CLI
            begin
              with Dm.SqlRel do
                begin
//                  sel := 'SELECT COUNT(cg040_remes) FROM cga040 WHERE (cg040_dtret is not null) and (cg040_dtbaixa between :dti and :dtf) ';
                  sel := 'SELECT COUNT(cg040_remes) FROM cga040 WHERE (cg040_dtbaixa between :dti and :dtf) ';
                  Close;
                  SQL.Clear;
                  SQL.Add(sel);
                  Params[0].Text  :=  FormatDateTime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                  Params[1].Text  :=  FormatDateTime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                  SqlRel.Open;
                  vRes  := Dm.SqlRel.Fields[0].AsInteger;
                  Close;
                  Sql.Clear;
                  Sql.Add('select count(cga040.cg040_remes),cga040.cg040_dtbaixa,cga20.cg20_descricao,cg20_codbaixa ');
                  Sql.Add('from cga040 inner join cga20 on cga040.cg040_codbaixa = cga20.cg20_codbaixa ');
//                  Sql.Add('where  (cg040_dtret is not null) and (cga040.cg040_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39)+' and ');
                  Sql.Add('where  (cga040.cg040_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39)+' and ');
                  Sql.Add(chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39)+') ');
                  Sql.Add('group by cga040.cg040_dtbaixa,cga20.cg20_descricao,cg20_codbaixa ');
                  Sql.Add('order by cga20.cg20_descricao,cga040.cg040_dtbaixa ');
                  open;
                  case Dm.SqlRel.RecordCount of
                    0:
                      begin
                        Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                        exit;
                      end;
                  else
                    begin
                      application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                      FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                      FrmFrProdExtContaCorrente.Tag := 48;
                      FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Retorno Carta Finasa CLI';
                      FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                      FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
                    end;
                  end;
                end;
            end;
          49:  // Retorno DRC - Private Label
            begin
              with Dm.SqlRel do
                begin
//                  sel := 'SELECT COUNT(cg041_remes) FROM cga041 WHERE (cg041_dtret is not null) and (cg041_dtbaixa between :dti and :dtf) ';
                  sel := 'SELECT COUNT(cg041_remes) FROM cga041 WHERE (cg041_dtbaixa between :dti and :dtf) ';
                  Close;
                  SQL.Clear;
                  SQL.Add(sel);
                  Params[0].Text  :=  FormatDateTime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                  Params[1].Text  :=  FormatDateTime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                  SqlRel.Open;
                  vRes  := Dm.SqlRel.Fields[0].AsInteger;
                  Close;
                  Sql.Clear;
                  Sql.Add('select count(cga041.cg041_remes),cga041.cg041_dtbaixa,cga20.cg20_descricao,cg20_codbaixa ');
                  Sql.Add('from cga041 inner join cga20 on cga041.cg041_codbaixa = cga20.cg20_codbaixa ');
//                  Sql.Add('where  (cg041_dtret is not null) and (cga041.cg041_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39)+' and ');
                  Sql.Add('where  (cga041.cg041_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39)+' and ');
                  Sql.Add(chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39)+') ');
                  Sql.Add('group by cga041.cg041_dtbaixa,cga20.cg20_descricao,cg20_codbaixa ');
                  Sql.Add('order by cga20.cg20_descricao,cga041.cg041_dtbaixa ');
                  open;
                  case Dm.SqlRel.RecordCount of
                    0:
                      begin
                        Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                        exit;
                      end;
                    else
                      begin
                        application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                        FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                        FrmFrProdExtContaCorrente.Tag := 49;
                        FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Retorno DRC - Private Label';
                        FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                        FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
                      end;
                  end;
                end;
            end;
          50:  // Produ�ao DRC - Private Label
            begin
              SqlRel.Close;
              SqlRel.Sql.Clear;
              SqlRel.Sql.Add('select count(cg041_remes),cg041_dtbaixa from cga041');
              SqlRel.Sql.Add(' where cg041_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
              SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
//              SqlRel.Params[0].Value :=  valor;
              SqlRel.Sql.Add(' group by cg041_dtbaixa order by cg041_dtbaixa');
              SqlRel.Open;
              case SqlRel.RecordCount of
                0:  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                else
                  begin
                    Application.CreateForm(TFrRelFaturamentoToken,FrRelFaturamentoToken);
                    FrmPesqImp.Tag  :=  35;
                    FrRelFaturamentoToken.RLGroup1.DataFields := SqlRel.Fields[1].DisplayName;
                    FrRelFaturamentoToken.RlTipoRelat.Caption := 'Leitura de Baixa DRC - Private Label';
                    FrRelFaturamentoToken.RlPeriodo.Caption   := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                    FrRelFaturamentoToken.RlValorFin.DataField := SqlRel.Fields[1].DisplayName;
                    FrRelFaturamentoToken.RLReport1.PreviewModal;
                  end;
              end;
            end;
        51:
          begin
//            sel := 'select cast(sum("QTDE") as varchar) as "qtde", ';
            sel := 'select sum("QTDE") as "qtde", ';
            sel := sel + 'cast(case';
            sel := sel + ' when ("Tipo_Servico" = 00) then '+Chr(39)+'CONTA CORRENTE/POUPAN�A'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 01) then '+Chr(39)+'UNIFICADO'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 02) then '+Chr(39)+'CONSOLIDADO'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 03) then '+Chr(39)+'DRC COBRAN�A'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 04) then '+Chr(39)+'DRC CARTA CONVITE'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 05) then '+Chr(39)+'CART�O SEGURAN�A'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 06) then '+Chr(39)+'BANCO POSTAL'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 07) then '+Chr(39)+'CVM'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 08) then '+Chr(39)+'TOKENS ENTRADA'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 09) then '+Chr(39)+'TOKENS SA�DA'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 10) then '+Chr(39)+'EXTRATO CART�O CR�DITO'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 11) then '+Chr(39)+'C�DIGO �TICA CADASTRO'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 12) then '+Chr(39)+'C�DIGO �TICA BAIXA'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 13) then '+Chr(39)+'BRINDES SECRET�RIA'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 14) then '+Chr(39)+'FATURA CART�O CR�DITO'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 15) then '+Chr(39)+'DRC AVISO DE COBRAN�A'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 16) then '+Chr(39)+'CARTA SENHA'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 17) then '+Chr(39)+'EXTRATO RECIBO CONSORCIADO'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 18) then '+Chr(39)+'EXTRATO FINASA FPE'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 19) then '+Chr(39)+'BOLETO FINASA CLI'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 20) then '+Chr(39)+'CARTA FINASA CLI'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 21) then '+Chr(39)+'DRC PRIVATE LABEL'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 22) then '+Chr(39)+'DRC CARTAO FATURA'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 23) then '+Chr(39)+'DRC ZOGBI-MCSI'+Chr(39);
            sel := sel + ' when ("Tipo_Servico" = 24) then '+Chr(39)+'DRC AMEX'+Chr(39);
            sel := sel + ' end as varchar) as "servico" ';
            sel := sel + 'from relcons ';
            sel := sel + 'where ("DATA" between '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtIni.Text))+Chr(39);
            sel := sel + ' and '+Chr(39)+FormatDateTime('mm-dd-yyyy',StrToDate(MkEdDtFin.Text))+Chr(39);
            sel := sel + ') group by "Tipo_Servico" ';
            //sel := sel + ' group by "QTDE","Usuario","DATA","Tipo_Servico"';
            //sel := sel + ' order by "Usuario","DATA","Tipo_Servico"';
            with Dm.SqlRel do
              begin
                Close;
                SQL.Clear;
                SQL.Add(sel);
                //inputbox('','',sel);
                Open;
              end;
            case Dm.SqlRel.RecordCount of
            0:
              begin
                Application.MessageBox('Registro n�o encontrado!!!','ADS',0);
                Dm.SqlRel.Close;
                Exit;
              end
            else
              begin
                Application.CreateForm(TFrmRelCons,FrmRelCons);
                FrmRelCons.RLReport2.PreviewModal;
                FrmRelCons.RLReport2.Destroy;
              end;
            end;
          end;
          52:  // Retorno DRC - Cartao Fatura
            begin
              with Dm.SqlRel do
                begin
//                  sel := 'SELECT COUNT(cg042_remes) FROM cga042 WHERE (cg042_dtret is not null) and (cg042_dtbaixa between :dti and :dtf) ';
                  sel := 'SELECT COUNT(cg042_remes) FROM cga042 WHERE (cg042_dtbaixa between :dti and :dtf) ';
                  Close;
                  SQL.Clear;
                  SQL.Add(sel);
                  Params[0].Text  :=  FormatDateTime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                  Params[1].Text  :=  FormatDateTime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                  SqlRel.Open;
                  vRes  := Dm.SqlRel.Fields[0].AsInteger;
                  Close;
                  Sql.Clear;
                  Sql.Add('select count(cga042.cg042_remes),cga042.cg042_dtbaixa,cga20.cg20_descricao,cg20_codbaixa ');
                  Sql.Add('from cga042 inner join cga20 on cga042.cg042_codbaixa = cga20.cg20_codbaixa ');
//                  Sql.Add('where  (cg042_dtret is not null) and (cga042.cg042_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39)+' and ');
                  Sql.Add('where  (cga042.cg042_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39)+' and ');
                  Sql.Add(chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39)+') ');
                  Sql.Add('group by cga042.cg042_dtbaixa,cga20.cg20_descricao,cg20_codbaixa ');
                  Sql.Add('order by cga20.cg20_descricao,cga042.cg042_dtbaixa ');
                  open;
                  case Dm.SqlRel.RecordCount of
                    0:
                      begin
                        Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                        exit;
                      end;
                    else
                      begin
                        application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                        FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                        FrmFrProdExtContaCorrente.Tag := 49;
                        FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Retorno DRC - Cart�o Fatura';
                        FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                        FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
                      end;
                  end;
                end;
            end;
          53:  // Produ�ao DRC - Cartao Fatura
            begin
              SqlRel.Close;
              SqlRel.Sql.Clear;
              SqlRel.Sql.Add('select count(cg042_remes),cg042_dtbaixa from cga042');
              SqlRel.Sql.Add(' where cg042_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
              SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
              SqlRel.Sql.Add(' group by cg042_dtbaixa order by cg042_dtbaixa');
              SqlRel.Open;
              case SqlRel.RecordCount of
                0:  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                else
                  begin
                    Application.CreateForm(TFrRelFaturamentoToken,FrRelFaturamentoToken);
                    FrmPesqImp.Tag  :=  35;
                    FrRelFaturamentoToken.RLGroup1.DataFields := SqlRel.Fields[1].DisplayName;
                    FrRelFaturamentoToken.RlTipoRelat.Caption := 'Leitura de Baixa DRC - Cart�o Fatura';
                    FrRelFaturamentoToken.RlPeriodo.Caption   := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                    FrRelFaturamentoToken.RlValorFin.DataField := SqlRel.Fields[1].DisplayName;
                    FrRelFaturamentoToken.RLReport1.PreviewModal;
                  end;
              end;
            end;
          54:  // Retorno DRC - ZOGBI=MCSI
            begin
              with Dm.SqlRel do
                begin
//                  sel := 'SELECT COUNT(cg042_remes) FROM cga042 WHERE (cg042_dtret is not null) and (cg042_dtbaixa between :dti and :dtf) ';
                  sel := 'SELECT COUNT(cg043_remes) FROM cga043 WHERE (cg043_dtbaixa between :dti and :dtf) ';
                  Close;
                  SQL.Clear;
                  SQL.Add(sel);
                  Params[0].Text  :=  FormatDateTime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                  Params[1].Text  :=  FormatDateTime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                  SqlRel.Open;
                  vRes  := Dm.SqlRel.Fields[0].AsInteger;
                  Close;
                  Sql.Clear;
                  Sql.Add('select count(cga043.cg043_remes),cga043.cg043_dtbaixa,cga20.cg20_descricao,cg20_codbaixa ');
                  Sql.Add('from cga043 inner join cga20 on cga043.cg043_codbaixa = cga20.cg20_codbaixa ');
//                  Sql.Add('where  (cg043_dtret is not null) and (cga043.cg043_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39)+' and ');
                  Sql.Add('where  (cga043.cg043_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39)+' and ');
                  Sql.Add(chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39)+') ');
                  Sql.Add('group by cga043.cg043_dtbaixa,cga20.cg20_descricao,cg20_codbaixa ');
                  Sql.Add('order by cga20.cg20_descricao,cga043.cg043_dtbaixa ');
                  open;
                  case Dm.SqlRel.RecordCount of
                    0:
                      begin
                        Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                        exit;
                      end;
                    else
                      begin
                        application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                        FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                        FrmFrProdExtContaCorrente.Tag := 49;
                        FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Retorno DRC - ZOGBI-MCSI';
                        FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                        FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
                      end;
                  end;
                end;
            end;
          55:  // Produ��o ZOGBI-MCSI
            begin
              SqlRel.Close;
              SqlRel.Sql.Clear;
              SqlRel.Sql.Add('select count(cg043_remes),cg043_dtbaixa from cga043');
              SqlRel.Sql.Add(' where cg043_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
              SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
              SqlRel.Sql.Add(' group by cg043_dtbaixa order by cg043_dtbaixa');
              SqlRel.Open;
              case SqlRel.RecordCount of
                0:  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                else
                  begin
                    Application.CreateForm(TFrRelFaturamentoToken,FrRelFaturamentoToken);
                    FrmPesqImp.Tag  :=  35;
                    FrRelFaturamentoToken.RLGroup1.DataFields := SqlRel.Fields[1].DisplayName;
                    FrRelFaturamentoToken.RlTipoRelat.Caption := 'Leitura de Baixa DRC - ZOGBI-MCSI';
                    FrRelFaturamentoToken.RlPeriodo.Caption   := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                    FrRelFaturamentoToken.RlValorFin.DataField := SqlRel.Fields[1].DisplayName;
                    FrRelFaturamentoToken.RLReport1.PreviewModal;
                  end;
              end;
            end;
          56:  // Retorno DRC - CART�O AMEX
            begin
              with Dm.SqlRel do
                begin
//                  sel := 'SELECT COUNT(cg042_remes) FROM cga042 WHERE (cg042_dtret is not null) and (cg042_dtbaixa between :dti and :dtf) ';
                  sel := 'SELECT COUNT(cg044_remes) FROM cga044 WHERE (cg044_dtbaixa between :dti and :dtf) ';
                  Close;
                  SQL.Clear;
                  SQL.Add(sel);
                  Params[0].Text  :=  FormatDateTime('mm/dd/yyyy',StrToDate(MkEdDtIni.Text));
                  Params[1].Text  :=  FormatDateTime('mm/dd/yyyy',StrToDate(MkEdDtFin.Text));
                  SqlRel.Open;
                  vRes  := Dm.SqlRel.Fields[0].AsInteger;
                  Close;
                  Sql.Clear;
                  Sql.Add('select count(cga044.cg044_remes),cga044.cg044_dtbaixa,cga20.cg20_descricao,cg20_codbaixa ');
                  Sql.Add('from cga044 inner join cga20 on cga044.cg044_codbaixa = cga20.cg20_codbaixa ');
//                  Sql.Add('where  (cg044_dtret is not null) and (cga044.cg044_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39)+' and ');
                  Sql.Add('where  (cga044.cg044_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39)+' and ');
                  Sql.Add(chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39)+') ');
                  Sql.Add('group by cga044.cg044_dtbaixa,cga20.cg20_descricao,cg20_codbaixa ');
                  Sql.Add('order by cga20.cg20_descricao,cga044.cg044_dtbaixa ');
                  open;
                  case Dm.SqlRel.RecordCount of
                    0:
                      begin
                        Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                        exit;
                      end;
                    else
                      begin
                        application.CreateForm(TFrmFrProdExtContaCorrente,FrmFrProdExtContaCorrente);
                        FrmFrProdExtContaCorrente.RLGroup1.DataFields  := Dm.SqlRel.Fields[2].DisplayName;
                        FrmFrProdExtContaCorrente.Tag := 49;
                        FrmFrProdExtContaCorrente.RlTipoRelat.Caption  := 'Retorno DRC - AMEX';
                        FrmFrProdExtContaCorrente.RlPeriodo.Caption    := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                        FrmFrProdExtContaCorrente.RLReport1.PreviewModal;
                      end;
                  end;
                end;
            end;
          57:  // Produ�ao DRC - CARTAO AMEX
            begin
              SqlRel.Close;
              SqlRel.Sql.Clear;
              SqlRel.Sql.Add('select count(cg044_remes),cg044_dtbaixa from cga044');
              SqlRel.Sql.Add(' where cg044_dtbaixa between '+chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtIni.Text))+chr(39));
              SqlRel.Sql.Add(' and ' +chr(39)+FormatDateTime('mm-dd-yyyy',strtodate(MkEdDtfin.Text))+chr(39));
              SqlRel.Sql.Add(' group by cg044_dtbaixa order by cg044_dtbaixa');
              SqlRel.Open;
              case SqlRel.RecordCount of
                0:  Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
                else
                  begin
                    Application.CreateForm(TFrRelFaturamentoToken,FrRelFaturamentoToken);
                    FrmPesqImp.Tag  :=  35;
                    FrRelFaturamentoToken.RLGroup1.DataFields := SqlRel.Fields[1].DisplayName;
                    FrRelFaturamentoToken.RlTipoRelat.Caption := 'Leitura de Baixa DRC - AMEX';
                    FrRelFaturamentoToken.RlPeriodo.Caption   := 'Per�odo de '+MkEdDtIni.Text +' � '+MkEdDtFin.Text;
                    FrRelFaturamentoToken.RlValorFin.DataField := SqlRel.Fields[1].DisplayName;
                    FrRelFaturamentoToken.RLReport1.PreviewModal;
                  end;
              end;
            end;
        end; //fim do case
      //''
    end;
end;


procedure TFrmPesqImp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=Cafree;
  dm.SqlAux1.Close;
  dm.SqlCga07.Close;
  //FrmPrincipal.SetFocus;
end;

procedure TFrmPesqImp.FormShow(Sender: TObject);
begin
  case FrmPesqImp.Tag of
    1:  begin
          ChePlanilia.Visible :=  true;
          ChePlanilia.Enabled :=  true;
        end;
    25: EdAgFin.Text  :=  '0';
    26,27: ChePlanilia.Checked := false;
    32:
      begin
        RdGrpTipo.Enabled  := true;
        RdGrpTipo.Visible := true;
      end;
    38: // Cart�o de Cr�dito Bradesco.
      begin
        MkEdDtIni.Text  := FormatDateTime('dd/mm/yyyy',Date);
        MkEdDtFin.Text  := FormatDateTime('dd/mm/yyyy',Date);
      end;
  end;
end;

procedure TFrmPesqImp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = 13) then
    SelectNext(ActiveControl,True,True);

end;
procedure TFrmPesqImp.selplantok;
begin
  with dm do
    begin
      msel:='select cg76_ag as Agencia,cg76_dtb as DTB,min(cg76_remes) as Inicial,max(cg76_remes) as Final,';
      msel:=msel+'count(cg76_dtb) as Qtde  from cga76 ';
      msel:=msel+'where (cg76_numlote = :numlote) group by cg76_ag,cg76_dtb order by cg76_dtb ';
      ZROQTokExc.Close;
      ZROQTokExc.Sql.Clear;
      ZROQTokExc.Sql.Add(msel);
      ZROQTokExc.Params[0].AsString :=  GeraNt(trim(EdAgIni.Text),6);
      ZROQTokExc.open;
      case ZROQTokExc.RecordCount of
        0:
          begin
            Application.MessageBox('N�o foi encontrado nenhum registro com os parametros informados','Ads',MB_OK+MB_ICONINFORMATION);
            EdAgIni.SetFocus;
            exit;
          end;
        else
          gerplantok;
      end;
    end;
end;

procedure TFrmPesqImp.gerplantok;
var
  linha, reg : Integer;
  j,i : Integer;
  excel: variant;
  nomcpo:string;
begin
  with dm do
    begin
      try
        excel:=CreateOleObject('Excel.Application');
        excel.Workbooks.add(1);
      except
        Application.MessageBox ('Vers�o do Ms-Excel Incompat�vel','Erro',MB_OK+MB_ICONERROR);
      end;
      linha:=1;
      ZROQTokExc.First;
      try
        for i:=0 to ZROQTokExc.FieldCount-1 do
        begin
          nomcpo:=ZROQTokExc.Fields[(i)].Name;
          nomcpo:=copy(nomcpo,11,length(nomcpo)-10);
          excel.cells[linha,i+1]:=Uppercase(copy(nomcpo,1,1))+copy(nomcpo,2,length(nomcpo)-1);

          //consulta.Fields[(coluna-1)].Name;
        end;
        linha :=  2;
        reg := 0;
        while not dm.ZROQTokExc.Eof do
          begin
            for j:=0 to dm.ZROQTokExc.FieldCount-1 do
              begin
                excel.cells[linha,j+1]:= dm.ZROQTokExc.Fields[j].AsString;
              end;
              reg:=reg+ZROQTokExc.Fields[j-1].Value;
              linha:=linha+1;
              dm.ZROQTokExc.Next;
          //consulta.Fields[(coluna-1)].Name;      end;
          end;
          excel.cells[linha,1]:= 'Total ==> ';
          excel.cells[linha,5]:=  inttostr(reg);
          excel.columns.AutoFit;
          excel.visible:=true;
          except
            Application.MessageBox ('Aconteceu um erro desconhecido durante a convers�o'+
           'da tabela para o Ms-Excel','Erro',MB_OK+MB_ICONERROR);
        end;
    end;
end;

procedure TFrmPesqImp.inseretemp;
var i,j: integer;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add('insert into cgatemp (motivo');
      for i := 1 to 15 do
      SqlAux1.SQL.Add(',tipo_serv_'+format('%2.2d',[i])+'');
      SqlAux1.SQL.Add(') values (:motivo');
      for i := 1 to 15 do
      SqlAux1.SQL.Add(',:tipo_serv_'+format('%2.2d',[i])+'');
      SqlAux1.SQL.Add(')');
      SetLength( Matriz, 9 );
      for i := low(matriz) to high(matriz) do
        begin
          SetLength(Matriz[i],14);
          for j := low(matriz[i]) to high(matriz[i]) do
            begin
              case j of
                1..13:
                  begin
                    if (trim(matriz[i,j]) = '') then
                      SqlAux1.Params[j].AsString  := '0'
                    else
                    SqlAux1.Params[j].AsString :=  matriz[i,j];
                  end;
                else
                  begin
                    if matriz[i,j] = '' then
                      begin
                        case i of
                        0:SqlAux1.Params[j].AsString :=  'Mudou-se';
                        1:SqlAux1.Params[j].AsString :=  'End. Insuficiente';
                        2:SqlAux1.Params[j].AsString :=  'Falecido';
                        3:SqlAux1.Params[j].AsString :=  'Desconhecido';
                        4:SqlAux1.Params[j].AsString :=  'Ausente';
                        5:SqlAux1.Params[j].AsString :=  'N� N�o Existe';
                        6:SqlAux1.Params[j].AsString :=  'Outros';
                        7:SqlAux1.Params[j].AsString :=  'Recusado';
                        8:SqlAux1.Params[j].AsString :=  'Entrada/Sa�da';
                        end;
                      end
                    else
                      SqlAux1.Params[j].AsString :=  matriz[i,j];
                  end;
              end;
            end;
            try
              SqlAux1.ExecSQL;
            except on e: exception do
              begin
                Application.MessageBox(Pchar('Houve um erro fatal!'+chr(10)+'Imprime Novamente'),'ISGroup',0);
                erro:=true;
                exit;
              end;
            end;
        end;
    end;
end;
procedure TFrmPesqImp.criatemp;
var i:integer;
begin
  dm.SqlAux1.Close;
  dm.SqlAux1.SQL.Clear;
  dm.SqlAux1.SQL.Add('create temporary table cgatemp ("motivo" varchar(50)');
  for i := 1 to 15 do
    dm.SqlAux1.SQL.Add(',"tipo_serv_'+format('%2.2d',[i])+'" numeric(10)');
    dm.SqlAux1.SQL.Add(') WITHOUT OIDS');

  try
    dm.SqlAux1.ExecSQL;
  except on e: exception do
    begin
      ShowMessage(e.Message);
      deltemp;
    end;
  end;
end;
procedure TFrmPesqImp.deltemp;
begin
  dm.SqlAux1.Close;
  dm.SqlAux1.SQL.Clear;
  dm.SqlAux1.SQL.Add('drop table cgatemp ');
  try
    dm.SqlAux1.ExecSQL;
    criatemp;
  except on e: exception do
    begin
      ShowMessage(e.Message);
      exit;
    end;
  end;
end;

end.
