unit U_PesqImpSedex;

interface

uses
  Windows, Messages,Types, Controls, StdCtrls, ComCtrls, Buttons, ExtCtrls, Classes,
  Forms , SysUtils, Variants, Graphics, Dialogs, Mask, DB,OleServer,OleCtrls,
  ComObj, ActiveX, OleDB,OfficeXP,ExcelXP,Math,SysConst,ShlObj,OleConst,
  DBCtrls, DateUtils, StrUtils;
type
  TFrmPesqImpSedex = class(TForm)
    fff: TScrollBox;
    Panel5: TPanel;
    Panel9: TPanel;
    BtnFechar: TBitBtn;
    BtnSalvar: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    EdSeqIni: TEdit;
    EdSeqFin: TEdit;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    ProgBar: TProgressBar;
    Panel3: TPanel;
    DateTimePicker3: TDateTimePicker;
    CboBoxTipoPostal: TComboBox;
    Panel4: TPanel;
    Panel6: TPanel;
    EdQtde: TEdit;
    Panel7: TPanel;
    DBServSedex: TDBLookupComboBox;
    EdArq: TEdit;
    Panel8: TPanel;
    Panel10: TPanel;
    EdArObjeto: TEdit;
    Panel11: TPanel;
    CboBoxGer: TComboBox;
    Panel12: TPanel;
    Panel13: TPanel;
    MkEdHrI: TMaskEdit;
    MkEdHrF: TMaskEdit;
    Panel14: TPanel;
    OpcRel: TComboBox;
    SaveDialog1: TSaveDialog;
    procedure DBServSedexEnter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EdSeqFinEnter(Sender: TObject);
    procedure EdSeqFinKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure gerimp;
    procedure gerimp2;
    procedure gerret;
    procedure gerretol;
    procedure inivars;
    procedure gerexcel;
    procedure prevarol;
    procedure repoltctk;
    procedure plansedex; // Arquivo em Excel Para o Manuseio
    procedure arpend;    // Relat�rio de Ar Pendentes - N�o Baixados.
    procedure retoltctk;  //  Arquivo Retorno Entregues Ar-Sexed Ol-Tc-Tk
    procedure pedoltctk;
    procedure gerlisoltctk;
    procedure gerfat;
    procedure relpendoltctk;//Arquivo Pendentes Ar-Sedex Ol-Tc-TK
    private
    { Private declarations }
    cab,sel,selexcel,locarq,arqexcel,linha,Caminho,sigla,dta:string;
    arq:TextFile;
    seqreg,lin:integer;
    dtaux: Tdate;
    document,mexcel:variant;
    vlsigla,totgeral,vldata:Real;
  public
  qtdar,totfol,ind : integer;
  qtdcepcap,qtdcepest,qtdcepnac1,qtdcepnac2:integer;
  qtdfxa01,qtdfxa02,qtdfxa03,qtdfxa04,qtdfxa05,qtdfxa06,qtdfxa07,qtdfxa08,qtdfxa09,qtdfxa10:integer;
  fxaini,fxafim:string;
  marray  : ARRAY of string;
//  texto:string;
    { Public declarations }
  end;

var
  FrmPesqImpSedex: TFrmPesqImpSedex;

implementation

uses U_FrmRelArSedex, U_FrmRelArSedexLista, U_FrmRlTotRa,
  U_CadEdicao, U_Func, DmDados, UFrmRelArSedexOL, U_FrmRelArSedexListaOL,
  U_FrmRelARPend, U_FrmRelSedex;

{$R *.dfm}

procedure TFrmPesqImpSedex.BtnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFrmPesqImpSedex.BtnSalvarClick(Sender: TObject);
begin
  inivars;
  if (trim(EdSeqIni.text) <> '') and (trim(EdSeqFin.Text) = '') then
    EdSeqFin.Text := EdSeqIni.Text;
        case tag of
          00..02: gerimp;   // Impress�o Protocolo e Resumo Ar-Digital Kit Def. Visual
          06..07: gerimp2;   // Impress�o Protocolo e Resumo Ar-OL-TC-TK
          03    : gerret;    // Arquivo de Previs�o de Postagem Ar-Digital Kit Def. Visual
          04    : gerfat;    // Arquivo de Faturamento Kit Visual;

          08:    gerretol;  // Arquivo ao Correio Ar-Sedex-OL-TC-Tk
          09:    prevarol;  // Arquivo de Previs�o de Postagem Ar-Sedex-OL-TC-TK
          10:    repoltctk; // Arquivo em Excel AR-Sedex Ol-Tc-Tk Repasse por Ag�ncia e Por Tipo
          11:    plansedex; // Arquivo em Excel AR-Sedex Ol-Tc-Tk Para o Manuseio
          12:    arpend;    // Relat�rio de Pendentes AR-Sedex Ol-Tc-Tk - N�o Baixados.
          13:    retoltctk ;// Arquivo de Retorno de AR-Sedex Ol-Tc-Tk Entregues
          14:    pedoltctk;  //Arquivo de Pedido Diario Ar-Sedex Ol-Tc-Tk
          15:    relpendoltctk; //Arquivo Excel Pendentes Ar-Sedex Ol-Tc-Tk
        end;
end;
procedure TFrmPesqImpSedex.DBServSedexEnter(Sender: TObject);
begin
  DBServSedex.DropDownWidth :=  tamlookcbo(2);
end;

procedure TFrmPesqImpSedex.EdSeqFinEnter(Sender: TObject);
begin
  case tag of
    3:
      begin
        if (trim(EdSeqIni.Text) = '') then
          begin
            Application.MessageBox('Seq Inicial dever� ser preenchida','ADS',0);
            EdSeqIni.SetFocus;
          end;
        end;
  end;
end;

procedure TFrmPesqImpSedex.EdSeqFinKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      case tag of
        3:
          begin
          if (EdSeqIni.Text <> '') and (EdSeqFin.Text <> '') and
            (StrToInt64(EdSeqIni.Text) > StrToInt64(EdSeqFin.Text)) then
             EdSeqIni.SetFocus;
          end;
      end;
    end;
end;

procedure TFrmPesqImpSedex.gerimp;

var s1, dbg, tblname, dtfldname:string;

Begin
  if (DBServSedex.KeyValue = NULL) then
    begin
      ShowMessage('Selecione um produto!');
      DBServSedex.SetFocus;
      exit;
    end;

  qtdfxa01   :=  0;
  qtdfxa02   :=  0;
  qtdfxa03   :=  0;
  qtdfxa04   :=  0;
  qtdfxa05   :=  0;
  qtdfxa06   :=  0;
  qtdfxa07   :=  0;
  qtdfxa08   :=  0;
  qtdfxa09   :=  0;
  qtdfxa10   :=  0;
  dtfldname := 'sdx_dtcarga'; // Valor padr�o
  With Dm do
    Begin
      case FrmPesqImpSedex.Tag  of
        0..2:
            tblname := 'tbsdx';

        6..7:
          begin
            tblname := 'tbsdx02';            
            if (FrmPesqImpSedex.Tag = 7) then
                dtfldname := 'sdx_dtenvio';            
          end;
      End;
      sel := 'SELECT COUNT(t.sdx_numobj) AS qt_post, t.sdx_uf, ' + 
        'SUBSTRING(t.sdx_cep, 1, 1) as prefixo FROM ' + 
        tblname + ' t INNER JOIN public.tbsdx_ect e ON (t.sdx_numobj = CAST(e.tbsdxect_num || e.tbsdxect_dv AS INTEGER)) ' +
          ' INNER JOIN public.tbsdxserv s ON (e.tbsdxect_prod = s.tbsdxserv_prod) ' +
          'WHERE s.tbsdxserv_prod = :codproduto AND t.' + dtfldname + ' BETWEEN :dt1 AND :dt2 ';        
      // Iniciando intera��o com o Banco
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add(sel);
      SqlAux1.ParamByName('codproduto').AsInteger := DBServSedex.KeyValue;
      SqlAux1.ParamByName('dt1').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
      SqlAux1.ParamByName('dt2').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);
      
      If (Trim(EdSeqIni.Text) <> '') then
        begin
          if ( (Trim(EdSeqFin.Text) <> '') and
            (StrToInt64(EdSeqFin.Text) < StrToInt64(EdSeqIni.Text)) ) then
            begin
              Application.MessageBox(Pchar('Sequencial Final deve ser maior ou igual a Sequencial Inicial.'), 'Ads', IDOK);
              EdSeqFin.SetFocus;
              exit;
            end
          else 
            EdSeqFin.Text := EdSeqIni.Text;

          SqlAux1.SQL.Add('  AND t.sdx_seqcarga between :seq1 AND :seq2 ');
          SqlAux1.ParamByName('seq1').AsInteger := StrToInt64(EdSeqIni.Text);
          SqlAux1.ParamByName('seq2').AsInteger := StrToInt64(EdSeqFin.Text);
        end;

      if (Trim(EdArObjeto.Text) <> '') then
        begin
          SqlAux1.SQL.Add('  AND sdx_numobj4 = :numobj ');
          SqlAux1.ParamByName('numobj').AsString := EdArObjeto.Text;
        end;
      if ((FrmPesqImpSedex.Tag in [6,7]) and
        (MkEdHrI.Text <> '  :  :  ') ) then
        begin
          if ((MkEdHrF.Text = '  :  :  ') OR 
            (CompareTime(StrToTime(MkEdHrI.Text), StrToTime(MkEdHrF.Text) ) > 0)) then
            begin
              Application.MessageBox(Pchar('Hora Final deve ser maior ou igual a Hora Inicial.'), 'Ads', IDOK);
              exit;            
            end;          
          SqlAux1.SQL.Add('  AND sdx_horaenvio between :hr1 AND :hr2 ');
          SqlAux1.ParamByName('hr1').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrI.Text));
          SqlAux1.ParamByName('hr2').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrF.Text));
        end;
          
      SqlAux1.SQL.Add('GROUP BY 2, 3');                                                                                                                                              
      SqlAux1.Open;
      if (SqlAux1.RecordCount < 1) then
        begin
          ShowMessage('N�o h� registros com os par�metros informados.');
          exit;
        end;
      
      while not SqlAux1.Eof do
        begin
          // Delphi n�o tem Switch CASE para Strings
          // Por isso � necess�rio ser criativo para 
          // Instru��es que dependem de um valor em uma lista
          s1 := SqlAux1.FieldByName('sdx_uf').AsString;
          if ( s1 = 'SP') then                  
            if (SqlAux1.FieldByName('prefixo').AsString = '0') then                     
              qtdfxa01 := qtdfxa01 + SqlAux1.FieldByName('qt_post').AsInteger
            else
              qtdfxa02 := qtdfxa02 + SqlAux1.FieldByName('qt_post').AsInteger
          else if (AnsiIndexStr(s1, ['RJ', 'MG', 'PR', 'SC']) > -1) then
            qtdfxa03 := qtdfxa03 + SqlAux1.FieldByName('qt_post').AsInteger
          else if (AnsiIndexStr(s1, ['ES', 'DF', 'MS', 'RS']) > -1) then
            qtdfxa04 := qtdfxa04 + SqlAux1.FieldByName('qt_post').AsInteger
          else if (AnsiIndexStr(s1, ['GO', 'TO']) > -1) then
            qtdfxa05 := qtdfxa05 + SqlAux1.FieldByName('qt_post').AsInteger
          else if (AnsiIndexStr(s1, ['BA', 'MT']) > -1) then
            qtdfxa06 := qtdfxa06 + SqlAux1.FieldByName('qt_post').AsInteger                    
          else if (AnsiIndexStr(s1, ['SE', 'AL']) > -1) then
            qtdfxa07 := qtdfxa07 + SqlAux1.FieldByName('qt_post').AsInteger
          else if (AnsiIndexStr(s1, ['PE', 'PB', 'PI', 'RO']) > -1) then
            qtdfxa08 := qtdfxa08 + SqlAux1.FieldByName('qt_post').AsInteger  
          else if (s1 = 'RR') then
            qtdfxa10 := qtdfxa10 + SqlAux1.FieldByName('qt_post').AsInteger  
          else // Todos os outros [RN, CE, MA, PA, AP, AM, AC 
            qtdfxa09 := qtdfxa09 + SqlAux1.FieldByName('qt_post').AsInteger;

          SqlAux1.Next;
        end;                          
      SqlAux1.Close;
      SqlAux1.SQL.Clear;

      Case FrmPesqImpSedex.Tag  of
        0..2:          
          SqlAux1.SQL.Add('SELECT COUNT(t.sdx_codcli) FROM tbsdx t ' +
              'WHERE t.sdx_dtcarga BETWEEN :dt1 AND :dt2 ');
        
        6..7:
          Begin
            SqlAux1.SQL.Add('SELECT COUNT(t.sdx_codcli) FROM tbsdx02 t ');
            SqlAux1.SQL.Add('    INNER JOIN public.tbsdx_ect e ON (t.sdx_numobj = CAST(e.tbsdxect_num || e.tbsdxect_dv AS INTEGER)) ');
            SqlAux1.SQL.Add('    INNER JOIN public.tbsdxserv s ON (e.tbsdxect_prod = s.tbsdxserv_prod) ');
            SqlAux1.SQL.Add('WHERE s.tbsdxserv_prod = :codproduto ');
            SqlAux1.ParamByName('codproduto').AsInteger := DBServSedex.KeyValue;

            if FrmPesqImpSedex.Tag = 6 then
              SqlAux1.SQL.Add(' AND t.sdx_dtcarga BETWEEN :dt1 AND :dt2 ')
            else
              SqlAux1.SQL.Add(' AND t.sdx_dtenvio BETWEEN :dt1 AND :dt2 ');
            
            if ((MkEdHrI.Text <> '  :  :  ') and (MkEdHrF.Text <> '  :  :  ')) then
              begin
                SqlAux1.SQL.Add(' AND sdx_horaenvio BETWEEN :hr1 AND :hr2 ');
                SqlAux1.ParamByName('hr1').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrI.Text));
                SqlAux1.ParamByName('hr2').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrF.Text));
              end;
          End;
      End;
      SqlAux1.ParamByName('dt1').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
      SqlAux1.ParamByName('dt2').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);

      Case FrmPesqImpSedex.Tag  of
        0..2:
          Begin
            SqlAux2.Close;
            SqlAux2.SQL.Clear;
            SqlAux2.SQL.Add('SELECT DISTINCT t.sdx_numobj5 FROM tbsdx t ' +
                  'WHERE t.sdx_dtcarga BETWEEN :dt1 AND :dt2 ');
          End;
        6..7:
          Begin
            SqlAux2.Close;
            SqlAux2.SQL.Clear;
            SqlAux2.SQL.Add('SELECT DISTINCT o.sdx_numobj FROM public.tbsdx_ect e ');
            SqlAux2.SQL.Add('INNER JOIN public.tbsdxserv s ON (e.tbsdxect_prod = s.tbsdxserv_prod) ');
            SqlAux2.SQL.Add('INNER JOIN public.tbsdx02 o ON (CAST(e.tbsdxect_num || e.tbsdxect_dv AS INTEGER) = o.sdx_numobj) ');
            SqlAux2.SQL.Add('WHERE s.tbsdxserv_prod = :codproduto ');
            SqlAux2.ParamByName('codproduto').AsInteger := DBServSedex.KeyValue;

            if FrmPesqImpSedex.Tag = 6 then
              SqlAux2.SQL.Add('AND o.sdx_dtcarga BETWEEN :dt1 AND :dt2 ')
            else
              SqlAux2.SQL.Add(' AND o.sdx_dtenvio BETWEEN :dt1 AND :dt2 ');

            if ((MkEdHrI.Text <> '  :  :  ') and (MkEdHrF.Text <> '  :  :  ')) then
              begin
                SqlAux2.SQL.Add(' AND o.sdx_horaenvio BETWEEN :hr1 AND :hr2 ');
                SqlAux2.ParamByName('hr1').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrI.Text));
                SqlAux2.ParamByName('hr2').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrF.Text));
              end;

          End;
      End;
      SqlAux2.ParamByName('dt1').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
      SqlAux2.ParamByName('dt2').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);

      SqlSdx2.Close;
      SqlSdx2.SQL.Clear;
      Case FrmPesqImpSedex.Tag  of
        0..2:
          Begin
            SqlSdx2.SQL.Add('SELECT sdx_codcli, sdx_idcli, sdx_siglaobj, sdx_numobj,');
            SqlSdx2.SQL.Add('sdx_paisorigem, sdx_codoperacao, sdx_numobj3, sdx_nomdest, sdx_endedest, sdx_cidade, ');
            SqlSdx2.SQL.Add('sdx_uf, sdx_cep, sdx_numseqarq, sdx_numseqreg, sdx_dtcarga, sdx_seqcarga, ');
            SqlSdx2.SQL.Add('sdx_numobj2, sdx_cepnet, sdx_numobj1, sdx_numobj4, sdx_numobj5');
            SqlSdx2.SQL.Add('FROM tbsdx WHERE sdx_dtcarga between :dt1 and :dt2 ');
            SqlSdx2.ParamByName('dt1').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
            SqlSdx2.ParamByName('dt2').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);
          End;
        6..7:
          Begin
            SqlSdx3.Close;
            SqlSdx3.SQL.Clear;
            SqlSdx3.SQL.Add('SELECT sdx_codcli, sdx_idcli, sdx_siglaobj, sdx_numobj,');
            SqlSdx3.SQL.Add('sdx_paisorigem, sdx_codoperacao, sdx_numobj3, sdx_nomdest, sdx_endedest, sdx_cidade, ');
            SqlSdx3.SQL.Add('sdx_uf, sdx_cep, sdx_numseqarq, sdx_numseqreg, sdx_dtcarga, sdx_seqcarga, ');
            SqlSdx3.SQL.Add('sdx_numobj2, sdx_cepnet, sdx_numobj1, sdx_numobj4, sdx_numobj5, sdx_peso, sdx_valor, sdx_qtde, sdx_tvalor, sdx_valdec, ');
            SqlSdx3.SQL.Add('p.tbsdxserv_nrocto, p.tbsdxserv_crtpst ');
            SqlSdx3.SQL.Add('FROM public.tbsdx_ect e ');
            SqlSdx3.SQL.Add('  INNER JOIN public.tbsdxserv p ON (e.tbsdxect_prod = p.tbsdxserv_prod) ');
            SqlSdx3.SQL.Add('  INNER JOIN public.tbsdx02 t ON (CAST(e.tbsdxect_num || e.tbsdxect_dv AS INTEGER) = t.sdx_numobj)');
            SqlSdx3.SQL.Add('WHERE p.tbsdxserv_prod = :codproduto ');
            SqlSdx3.ParamByName('codproduto').AsInteger := DBServSedex.KeyValue;

          if FrmPesqImpSedex.Tag = 6 then
            SqlSdx3.SQL.Add('AND sdx_dtcarga BETWEEN :dt1 AND :dt2 ')
          else
            SqlSdx3.SQL.Add('AND t.sdx_dtenvio BETWEEN :dt1 AND :dt2 ');
            SqlSdx3.ParamByName('dt1').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
            SqlSdx3.ParamByName('dt2').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);

          if ((MkEdHrI.Text <> '  :  :  ') and (MkEdHrF.Text <> '  :  :  ')) then
            begin
              SqlSdx3.SQL.Add('AND sdx_horaenvio BETWEEN :hr1 AND :hr2 ');
              SqlSdx3.ParamByName('hr1').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrI.Text));
              SqlSdx3.ParamByName('hr2').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrF.Text));
            end;

          End;
      End;

      If ((EdSeqIni.Text <> '') and (EdSeqFin.Text <> ''))  then
        Begin
          // Validando os dados do formul�rio
          if (StrToInt64(EdSeqIni.Text) > StrToInt64(EdSeqFin.Text)) then
            begin
              Application.MessageBox('Informa��es de Sequ�ncia inv�lidos. ' +
                    'Sequencial Final deve ser superior ao sequencial inicial','ADS',IDOK);
              exit;
            end;

          if (Trim(EdSeqIni.Text) <> '') then          
            begin
              if (Trim(EdSeqFin.Text) = '') then
                EdSeqFin.Text := EdSeqIni.Text;
              SqlAux1.SQL.Add(' AND sdx_seqcarga BETWEEN :seq1 AND :seq2');
              SqlAux2.SQL.Add(' AND sdx_seqcarga BETWEEN :seq1 AND :seq2');
              SqlAux1.ParamByName('seq1').AsInteger   := StrToInt64(EdSeqIni.Text);
              SqlAux1.ParamByName('seq2').AsInteger   := StrToInt64(EdSeqFin.Text);
              SqlAux2.ParamByName('seq1').AsInteger   := StrToInt64(EdSeqIni.Text);
              SqlAux2.ParamByName('seq2').AsInteger   := StrToInt64(EdSeqFin.Text);
            end;

          if (Trim(EdArObjeto.Text) <> '') then
            begin
              SqlAux1.SQL.Add(' AND sdx_numobj4 = :numobj ');
              SqlAux2.SQL.Add(' AND sdx_numobj4 = :numobj ');
              SqlAux1.ParamByName('numobj').AsString := EdArObjeto.Text;
              SqlAux2.ParamByName('numobj').AsString := EdArObjeto.Text;
            End;

          Case FrmPesqImpSedex.Tag  of
            0..2:
              Begin
                SqlSdx2.SQL.Add(' AND sdx_seqcarga BETWEEN :seq1 AND :seq2 ');
                SqlSdx2.ParamByName('seq1').AsInteger   := StrToInt64(EdSeqIni.Text);
                SqlSdx2.ParamByName('seq2').AsInteger   := StrToInt64(EdSeqFin.Text);

                if (Trim(EdArObjeto.Text) <> '') then
                  begin
                    SqlSdx2.SQL.Add(' AND sdx_numobj4 = :numobj ');
                    SqlSdx2.ParamByName('numobj').AsString := EdArObjeto.Text;
                  end;

                SqlSdx2.SQL.Add('ORDER BY sdx_cep ');
              End;

            6..7:
              Begin
                if (Trim(EdSeqIni.Text) <> '')  and ( Trim(EdSeqFin.Text) <> '') then
                  begin
                    SqlSdx3.SQL.Add(' AND sdx_seqcarga BETWEEN :seq1 AND :seq2');
                    SqlSdx3.ParamByName('seq1').AsInteger   := StrToInt64(EdSeqIni.Text);
                    SqlSdx3.ParamByName('seq2').AsInteger   := StrToInt64(EdSeqFin.Text);
                  end
                else if (Trim(EdSeqIni.Text) <> '') then
                  begin
                    SqlSdx3.SQL.Add(' AND sdx_seqcarga = :seq1 ');
                    SqlSdx3.ParamByName('seq1').AsInteger   := StrToInt64(EdSeqIni.Text);
                  end
                else if (Trim(EdSeqFin.Text) <> '') then
                  begin
                    SqlSdx3.SQL.Add(' AND sdx_seqcarga = :seq2');
                    SqlSdx3.ParamByName('seq2').AsInteger := StrToInt64(EdSeqFin.Text);
                  end;

                if (Trim(EdArObjeto.Text) <> '') then
                  begin
                    SqlSdx3.SQL.Add('AND sdx_numobj4 = :numobj ');
                    SqlSdx3.ParamByName('numobj').AsString := EdArObjeto.Text;
                  end;

                if ((MkEdHrI.Text <> '  :  :  ') and (MkEdHrF.Text <> '  :  :  ')) then
                  begin
                    SqlSdx3.SQL.Add(' AND sdx_horaenvio BETWEEN :hr1 AND :hr2 ');
                    SqlSdx3.ParamByName('hr1').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrI.Text));
                    SqlSdx3.ParamByName('hr2').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrF.Text));
                  end;

                if FrmPesqImpSedex.Tag = 6 then
                  SqlSdx3.SQL.Add('ORDER BY sdx_nomdest ')
                else
                  SqlSdx3.SQL.Add('ORDER BY sdx_cep ');
              End;
          End;
        End
      Else
        Begin
          if (Trim(EdArObjeto.Text) <> '') then
                begin
                  SqlAux1.SQL.Add(' AND sdx_numobj4 = :numobj ');
                  SqlAux2.SQL.Add(' AND sdx_numobj4 = :numobj ');
                  SqlAux1.ParamByName('numobj').AsString := EdArObjeto.Text;
                  SqlAux2.ParamByName('numobj').AsString := EdArObjeto.Text;
                end;
              SqlAux2.SQL.Add('ORDER BY sdx_numobj');
              Case FrmPesqImpSedex.Tag  of
                0..2:
                  Begin
                    if (Trim(EdArObjeto.Text) <> '') then
                      begin
                        SqlSdx2.SQL.Add('AND sdx_numobj4 = :numobj ');
                       SqlSdx2.ParamByName('numobj').AsString := EdArObjeto.Text;
                      end;
                    SqlSdx2.SQL.Add('ORDER BY sdx_cep ');
                  End;
                6..7:
                  Begin
                    if (Trim(EdArObjeto.Text) <> '') then
                      begin
                        SqlSdx3.SQL.Add('AND sdx_numobj4 = :numobj ');
                        SqlSdx3.ParamByName('numobj').AsString := EdArObjeto.Text;
                      end;
                    if FrmPesqImpSedex.Tag = 6 then
                      begin
                        if DBServSedex.KeyValue = 1953 then
                          SqlSdx3.SQL.Add('ORDER BY sdx_cep ')
                        else
                          SqlSdx3.SQL.Add('ORDER BY sdx_nomdest ')
                      end
                    else
                      SqlSdx3.SQL.Add('ORDER BY sdx_cep ');
                  End;
              End;
          End;
        dbg := SqlAux1.SQL.getText;
        dbg := SqlAux2.SQL.getText;

        SqlAux1.Open;
        SqlAux2.Open;
        Case FrmPesqImpSedex.Tag  of
          0..2:
            begin
              SqlSdx2.Open;
            end;
          6..7:
          begin
            dbg := SqlSdx3.SQL.getText;
            SqlSdx3.Open;
          end;
        End;
        case   FrmPesqImpSedex.Tag of
          0:
           Begin
             Application.CreateForm(TFrmRelArSedex,FrmRelArSedex);
             frmRelArSedex.RLReport1.PreviewModal;
           End;
          1:
           Begin
             Application.CreateForm(TFrmRelArSedexLista,FrmRelArSedexLista);
             qtdar  :=  SqlAux1.Fields[0].Value;
             SqlAux2.Last;
             fxafim  :=  SqlAux2.Fields[0].Text ;
             SqlAux2.First;
             fxaini  :=  SqlAux2.Fields[0].Text;
             totfol  :=  round(qtdar/3);
             FrmRelArSedexLista.RLReport1.PreviewModal;
             FrmRelArSedexLista.RLReport1.Destroy;
             SqlSdx2.First;
             Application.CreateForm(TFrmRlTotalRa,FrmRlTotalRa);
             FrmRlTotalRa.RLRTotalRa.PreviewModal;
             FrmRlTotalRa.RLRTotalRa.Destroy;
           End;
          2:
           Begin
             Application.CreateForm(TFrmRlTotalRa,FrmRlTotalRa);
             FrmRlTotalRa.RLRTotalRa.PreviewModal;
             FrmRlTotalRa.RLRTotalRa.Destroy;
           End;
          6:
            Begin
             Caminho := ExtractFilePath(Application.ExeName);
             
              case OpcRel.ItemIndex of
               0 :
                begin
                 RvRelatorios.ProjectFile := Caminho+'RelatoriosAds.rav';
                 RvRelatorios.ExecuteReport('RpSedexArOl');
                 RvRelatorios.Close;
                end;
               1:
                begin
                  RvRelatorios.ProjectFile := Caminho+'RelatoriosAds01.rav';
                  RvRelatorios.ExecuteReport('RpSedexArOl');
                  RvRelatorios.Close;
                end;
               2:  // Ar Digital
                begin
                  RvRelatorios.ProjectFile := Caminho + 'ARDigital.rav';
                  RvRelatorios.ExecuteReport('RpSedexArOl');
                  RvRelatorios.Close;
                end
               else Application.MessageBox('N�o foi definido','ADS',ID_OK);
              end;
            End;
          7:
             Begin
               SqlAux3.Close;
               SqlAux3.SQL.Clear;
               SqlAux3.SQL.Add('SELECT SUM(t.sdx_peso) AS sdx_peso, SUM(t.sdx_valdec) AS sdx_valdec ');
               SqlAux3.SQL.Add('FROM tbsdx02 t ');
               SqlAux3.SQL.Add('    INNER JOIN public.tbsdx_ect e ON (t.sdx_numobj = CAST(e.tbsdxect_num || e.tbsdxect_dv AS INTEGER)) ');
               SqlAux3.SQL.Add('    INNER JOIN public.tbsdxserv s ON (e.tbsdxect_prod = s.tbsdxserv_prod) ');
               SqlAux3.SQL.Add('WHERE s.tbsdxserv_prod = :codproduto ');
               SqlAux3.ParamByName('codproduto').AsInteger := DBServSedex.KeyValue;

               SqlAux3.SQL.Add('AND t.sdx_dtenvio BETWEEN :dt1 and :dt2 ');
               SqlAux3.ParamByName('dt1').AsString :=  FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
               SqlAux3.ParamByName('dt2').AsString :=  FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);
               if (trim(EdSeqIni.Text) <> '') and (Trim(EdSeqFin.Text) <> '')then
                 begin
                   SqlAux3.SQL.Add(' AND t.sdx_seqcarga BETWEEN :seq1 AND :seq2 ');
                   SqlAux3.ParamByName('seq1').AsInteger   := StrToInt64(EdSeqIni.Text);
                   SqlAux3.ParamByName('seq2').AsInteger   := StrToInt64(EdSeqFin.Text);
                 end;
                if ((MkEdHrI.Text <> '  :  :  ') and (MkEdHrF.Text <> '  :  :  ')) then
                  begin
                    SqlAux3.SQL.Add(' AND t.sdx_horaenvio BETWEEN :hr1 AND :hr2 ');
                    SqlAux3.ParamByName('hr1').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrI.Text));
                    SqlAux3.ParamByName('hr2').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrF.Text));
                  end;
               if (Trim(EdArObjeto.Text) <> '') then
                begin
                  SqlAux3.SQL.Add(' AND t.sdx_numobj4 = :numobj ');
                  SqlAux3.ParamByName('numobj').AsString := EdArObjeto.Text;
                end;
                
               SqlAux3.Open;

               Application.CreateForm(TFrmRelArSedexListaOL,FrmRelArSedexListaOL);
               qtdar  :=  SqlAux1.Fields[0].Value;
               SqlAux2.Last;
               fxafim  :=  SqlAux2.Fields[0].Text;
               SqlAux2.First;
               fxaini  :=  SqlAux2.Fields[0].Text;
               totfol  :=  round(qtdar/3);
               FrmRelArSedexListaOL.RLReport1.PreviewModal;
               FrmRelArSedexListaOL.RLReport1.Destroy;
               SqlSdx3.First;
               gerlisoltctk;
             End;
        End;
     End;
end;
procedure TFrmPesqImpSedex.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    SelectNext(ActiveControl,true,true);
end;

procedure TFrmPesqImpSedex.FormShow(Sender: TObject);
begin
  DateTimePicker1.Date  := Date;
  DateTimePicker2.Date  := Date;
  DateTimePicker3.Date  := Date;

  With Dm Do
    begin
      SqlSdxServ.Close;
      SqlSdxServ.SQL.Clear;
      SqlSdxServ.SQL.Add('SELECT * FROM public.tbsdxserv t ');
      SqlSdxServ.SQL.Add('WHERE t.tbsdxserv_status = 1 AND ');
      SqlSdxServ.SQL.Add('(t.tbsdxserv_dsc ILIKE ''%TOKEN%'' OR ');
      SqlSdxServ.SQL.Add('t.tbsdxserv_dsc ILIKE ''%TANCODE%'' OR ');
      SqlSdxServ.SQL.Add('t.tbsdxserv_dsc ILIKE ''% OL %'')');

      SqlSdxServ.Open;
      DBServSedex.Refresh;
    end;

  case TAG of
    0..2: ProgBar.Enabled :=  FALSE;
    3..4: begin
            ProgBar.Enabled :=  TRUE;
            BtnSalvar.Caption  := '&Gerar';
          end;
    6..7: begin
            MkEdHrI.Enabled :=  True;
            MkEdHrF.Enabled :=  True;
          end;
  end;
end;
procedure TFrmPesqImpSedex.gerret;
var
i:integer;
begin
  with dm do
    begin
      dtaux := DateTimePicker1.Date;
      for I := StrToInt64(EdSeqIni.Text) to StrToInt64(EdSeqFin.Text) do
        begin
          SqlAux1.Close;
          SqlAux1.SQL.Clear;
          SqlAux1.SQL.Add('select count(sdx_seqcarga) from tbsdx where (sdx_dtcarga between :dtini and :dtfin) and (sdx_seqcarga = :seqini)');
          SqlAux1.Params[0].AsDate :=  DateTimePicker1.Date;
          SqlAux1.Params[1].AsDate :=  DateTimePicker2.Date;
          SqlAux1.Params[2].Value  :=  i;
          SqlAux1.Open;
          if SqlAux1.fields[0].Value > 0 then
            begin
              try
              locarq  :=  'F:\sistemas\posta\';
              except
                begin
                  Application.MessageBox(PChar('Erro de Conex�o Rede ou pasta n�o existe'),'ADS',0);
                  exit;
                end;
              end;

              arqexcel:= locarq+'BR'+formatdatetime('ddmmyy',dtaux)+inttostr(i)+'.xls';
              case i of
              00..09:locarq  :=  locarq+'BP1'+formatdatetime('ddmm',DateTimePicker3.Date)+inttostr(i)+'.SD1';// vou alterar qdo estiver ok
              65..90:locarq  :=  locarq+'BP1'+formatdatetime('ddmm',DateTimePicker3.Date)+'''+char(inttostr(i))+'''+'.SD1';// vou alterar qdo estiver ok
              end;
              AssignFile(arq,locarq);
              try
              Rewrite(arq);
              except
                begin
                  Application.MessageBox(PChar('N�o Pode Acessar Arquivo'+linha),'ADS',0);
                  EdSeqIni.Text  := inttostr(i);
                  Application.MessageBox(PChar('Sua Nova Sequ�ncia �: '+inttostr(i)+' e '+EdSeqFin.Text),'ADS',0);
                  exit;
                end;
              end;
              linha:='81015'+GeraNt('0',15)+GeraArquivo('BRADESCO PRIME',40)+formatdatetime('yyyymmdd',DateTimePicker3.Date)+GeraNT(inttostr(dm.SqlAux1.fields[0].Value+1),6);
              linha:=linha+GeraNT('0',94)+GeraNT(inttostr(i),5)+GeraNT('1',7);
              WriteLn(arq,linha);
              sel :=  'select sdx_numobj2,sdx_paisorigem,sdx_nomdest,sdx_endedest,sdx_cidade,sdx_uf,sdx_cep,sdx_seqcarga,sdx_numobj5 from tbsdx where (sdx_dtcarga between :dtini and :dtfin) and (sdx_seqcarga = :seq) order by sdx_cep';
              //                  0            1               2          3            4         5       6       7         8
             selexcel :=  'select sdx_numobj2 as "OBJETO",sdx_nomdest as "Nome Destinat�rio",';
             //                           0                                      1
             selexcel :=  selexcel  + 'sdx_endedest as "Endere�o Destinat�rio",sdx_cidade as "Cidade",sdx_uf as "UF",';
             //                                       2                                   3                  4
             selexcel :=  selexcel  + 'sdx_cep as "Cep",sdx_seqcarga as "Sequ�ncia Arquivo" from tbsdx where (sdx_dtcarga between :dtini and :dtfin) and (sdx_seqcarga = :seq) order by sdx_cep';
                  //                           5               6
              SqlAux2.Close;
              SqlAux2.SQL.Clear;
              SqlAux2.SQL.Add(sel);
              SqlAux2.Params[0].AsDate :=  DateTimePicker1.Date;
              SqlAux2.Params[1].AsDate :=  DateTimePicker2.Date;
              SqlAux2.Params[2].Value  :=  i;
              SqlAux3.Close;
              SqlAux3.SQL.Clear;
              SqlAux3.SQL.Add(selexcel);
              SqlAux3.Params[0].AsDate :=  DateTimePicker1.Date;
              SqlAux3.Params[1].AsDate :=  DateTimePicker2.Date;
              SqlAux3.Params[2].Value  :=  i;
              SqlAux2.Open;
//              inputbox('','',selexcel);
              SqlAux3.Open;
//              inputbox('','',inttostr(SqlAux3.RecordCount));
              SqlAux2.First;
              seqreg:=2;
              ProgBar.Max :=  SqlAux2.RecordCount;
              ProgBar.Position  := 1;
              ProgBar.Refresh;
              while not SqlAux2.Eof do
                begin
                linha:= '91015BP'+SqlAux2.Fields[0].AsString+'1101';
                linha:= linha+format('%-16.16s%',[' '])+format('%-40.40s%',[SqlAux2.Fields[2].AsString])+format('%-40.40s%',[SqlAux2.Fields[3].AsString]);
                linha:= linha+format('%-30.30s%',[SqlAux2.Fields[4].AsString])+SqlAux2.Fields[5].AsString+SqlAux2.Fields[6].AsString;
                linha:= linha+format('%8.8d',[0])+format('%5.5d',[i])+format('%7.7d',[seqreg]);
                WriteLn(arq,linha);
                seqreg:=seqreg+1;
                SqlAux2.Next;
                ProgBar.Position  :=  ProgBar.Position + 1;
                ProgBar.Refresh;
                end;
              gerexcel;
              ProgBar.Position :=  0;
              ProgBar.Refresh;
              CloseFile(Arq);
              Application.MessageBox(PChar('Arquivo Gerado com Sucesso: '+locarq+#10+' Excel: '+arqexcel),'ADS',0);
              dtaux := DateTimePicker1.Date+1;
            end
          else
          Application.MessageBox(PChar('N�o H� Registros com os Parametros Informados'),'ADS - Ar-Digital',0);
        end;
    end;
end;

procedure TFrmPesqImpSedex.gerretol;
var i: integer;
  s: String;
Begin
  i := 0;
  with dm do
    Begin
          SqlAux1.Close;
          SqlAux1.SQL.Clear;
          SqlAux1.SQL.Add('SELECT COUNT(t.sdx_numobj2) as qt_regs ');
          SqlAux1.SQL.Add('FROM public.tbsdx02 t ');
          SqlAux1.SQL.Add('    INNER JOIN public.tbsdx_ect e ON (t.sdx_numobj = CAST(e.tbsdxect_num || e.tbsdxect_dv AS INTEGER)) ');
          SqlAux1.SQL.Add('    INNER JOIN public.tbsdxserv s ON (e.tbsdxect_prod = s.tbsdxserv_prod) ');
          SqlAux1.SQL.Add('WHERE s.tbsdxserv_prod = :codproduto ');
          SqlAux1.SQL.Add(' AND t.sdx_dtenvio BETWEEN :dtini AND :dtfin ');
          SqlAux1.ParamByName('codproduto').AsInteger := DBServSedex.KeyValue;
          SqlAux1.ParamByName('dtini').AsString :=  FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
          SqlAux1.ParamByName('dtfin').AsString :=  FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);

          if EdSeqIni.Text <> '' then
            begin
              if (EdSeqFin.Text = '') then
                EdSeqFin.Text := EdSeqIni.Text;
              if (StrToInt64(EdSeqFin.Text) > StrToInt64(EdSeqIni.Text)) then
                begin
                  ShowMessage('N�mero Sequencial Final deve ser maior que o Inicial');
                  exit;
                end;
              s := ' AND t.sdx_seqcarga BETWEEN :seqini AND :seqfin ';
              SqlAux1.SQL.Add(s);
              SqlAux1.ParamByName('seqini').AsString := EdSeqIni.Text;
              SqlAux1.ParamByName('seqfin').AsString := EdSeqFin.Text;
            end;

          SqlAux1.Open;
          if (SqlAux1.FieldByName('qt_regs').AsInteger > 0) then
            Begin
              try
                // H� registros para gerar o arquivo. Criando-o...
                //locarq  :=  'O:\sedex_ar\retorno\';
                SaveDialog1.InitialDir := 'O:\sedex_ar\retorno\';
                SaveDialog1.FileName := 'RT' + SqlSdxServtbsdxserv_sigla.AsString +
                      FormatDateTime('ddmm', DateTimePicker3.Date ) + '.txt';

                if (SaveDialog1.Execute) then
                  EdArq.Text  :=  SaveDialog1.FileName
                else
                  begin
                    ShowMessage('N�o foi selecionado um arquivo de destino. ' +
                        'O Processo foi abortado!');
                    exit;
                  end;

              except
                begin
                  Application.MessageBox(PChar('Erro de Conex�o Rede'),'ADS',0);
                  exit;
                end;
              end;
              AssignFile(arq, EdArq.Text);
              try
                Rewrite(arq);
              except
                begin
                  Application.MessageBox(PChar('N�o foi poss�vel criar o arquivo de registros.'), 'ADS', 0);
                  EdSeqIni.Text  := intToStr(i);
                  Application.MessageBox(PChar('Sua Nova Sequ�ncia �: ' +
                      IntToStr(i) + ' e ' + EdSeqFin.Text), 'ADS', 0);
                  exit;
                end;
              end;

              SqlAux2.Close;
              SqlAux2.SQL.Clear;
              //                                  0           1
              SqlAux2.SQL.Add('SELECT DISTINCT sdx_numobj, sdx_paisorigem, ');
              //                  2           3           4           5
              SqlAux2.SQL.Add('sdx_cep, sdx_seqcarga, sdx_numobj1, sdx_peso, ');
              //                6           7                8          9
              SqlAux2.SQL.Add('sdx_valdec, sdx_siglaobj, sdx_cmp, sdx_bas, ');
              //                   10       11            12          13                14
              SqlAux2.SQL.Add('sdx_alt, sdx_cobdest, sdx_numobj2, tbsdxserv_nrocto, tbsdxserv_crtpst ');
              SqlAux2.SQL.Add('FROM public.tbsdx02 t ');
              SqlAux2.SQL.Add('    INNER JOIN public.tbsdx_ect e ON (t.sdx_numobj = CAST(e.tbsdxect_num || e.tbsdxect_dv AS INTEGER)) ');
              SqlAux2.SQL.Add('    INNER JOIN public.tbsdxserv s ON (e.tbsdxect_prod = s.tbsdxserv_prod) ');
              SqlAux2.SQL.Add('WHERE s.tbsdxserv_prod = :codproduto ');
              SqlAux2.SQL.Add('    AND t.sdx_dtenvio between :dtini AND :dtfin ');

              if (s <> '') then
                begin
                   SqlAux2.SQL.Add(s);
                   SqlAux2.ParamByName('seqini').AsString := EdSeqIni.Text;
                   SqlAux2.ParamByName('seqfin').AsString :=  EdSeqFin.Text;
                end;

              SqlAux2.ParamByName('codproduto').AsInteger := DBServSedex.KeyValue;
              SqlAux2.ParamByName('dtini').AsString :=  FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
              SqlAux2.ParamByName('dtfin').AsString :=  FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);
              SqlAux2.SQL.Add('ORDER BY sdx_cep');



              SqlAux2.Open;
              SqlAux2.First;
              seqreg := 2;
              EdQtde.Text :=  IntToStr(SqlAux2.RecordCount);
              EdQtde.Refresh;
              ProgBar.Max :=  SqlAux2.RecordCount;
              ProgBar.Position  := 1;
              ProgBar.Refresh;
              While not SqlAux2.Eof do
                Begin
                  linha := '3' + '00' + '0000';
                  linha := linha + '0000';//FormatDateTime('ddmm',Date);
                  linha := linha + '00000000';//'72618060';
                  linha := linha + '0000';//FormatDateTime('ddmm',Date);
                  linha := linha + GeraNt(SqlSdxServtbsdxserv_nrocto.AsString,10);
                  linha := linha + '09036539';   //codigo administrativo
                  linha := linha + SqlAux2.Fields[2].AsString;//cep do destino
//                    linha := linha+'40096';
//                  alterado conforme gestor nro 5084
                  linha := linha + '40436';//codigo do servico (SFI)
                  linha := linha + '55'; // grupo pais fixo cod pais
                    //alterado � pedido dos correios para identificar o servi�co ar-sedex
//                    if (DBServSedex.KeyValue = 1660) then
//                       linha := linha+'00'+'00'+'00'// C�d Servi�o 1 2 e 3
//                    else
                  linha := linha + '01' + '00' + '00';// Filler - C�d Servi�o 1 2 e 3  fixo
                  linha := linha + GeraNT(RestauraInteger(FormatFloat('#####0.00', SqlAux2.Fields[6].AsFloat)), 8);  //valor declarado
                  linha := linha + GeraNt('0', 9); // Filler - Cod Embalagem
                  linha := linha + GeraNt('0', 2);// Filler - Qt Embalagem
                  linha := linha + GeraNT(SqlAux2.Fields[0].AsString, 9);
                  linha := linha + GeraNt(RestauraInteger(FormatFloat('00.000', SqlAux2.Fields[5].AsFloat)), 5);
                  linha := linha + GeraNt('0', 8); // filler - Valor a Pagar
                  linha := linha + '00'; // Filler - Seq Folha
                  linha := linha + '00'; // Filler - Seq Lancamentos
                  linha := linha + '00000000'; // filler - Data Processamento
                  linha := linha + '000'; // Filler - Remessa
                  linha := linha + '  '; // Filler
                  linha := linha + GeraNt('0', 8); // Filler - Unidade Prestadora
                  linha := linha + GeraNt('0', 8);// Filler -  FormatDateTime('ddmmyyyy',Date);
                  linha := linha + '00';//Filler - Qtde. Doc no Lote
                  linha := linha + GeraNt(SqlSdxServtbsdxserv_crtpst.AsString, 11); // Nro do Cart�o de Postagem houve erro para  pegar o ultimo digito do campo
                  linha := linha + GeraNt('0',7); // Filler - Numero nota fiscal
                  linha := linha + copy(SqlAux2.Fields[12].AsString, 1, 2);// 'SL'; // Filler - Fixo SIGLA DO SERVI�O
                  linha := linha + GeraNT(SqlAux2.Fields[8].AsString, 5);//  linha := linha+GeraNt('0',5); // Compr do Obj
                  linha := linha + GeraNT(SqlAux2.Fields[9].AsString, 5);//  linha := linha+GeraNt('0',5); // Larg do Obj
                  linha := linha + GeraNT(SqlAux2.Fields[10].AsString, 5);//  linha := linha+GeraNt('0',5); // Altura do Obj
                  linha := linha + GeraNT(RestauraInteger(SqlAux2.Fields[6].AsString), 8);  //valor a cobrar do destinat�rio
                  WriteLn(arq, linha);
                  seqreg := seqreg + 1;
                  SqlAux2.Next;
                  ProgBar.Position  :=  ProgBar.Position + 1;
                  ProgBar.Refresh;
                End;

              linha := '9';
              linha := linha + GeraNt(IntToStr(seqreg), 8); //Qtde Registros
              GeraArquivo(' ', 129);
              WriteLn(arq, linha);
              CloseFile(Arq);
              Application.MessageBox(PChar('Arquivo Gerado com Sucesso!'), 'ADS', 0);
            end
          else
            Application.MessageBox(PChar('N�o H� Registros com os Parametros Informados'), 'ADS - Ar-Digital', 0);
    end;
End;

procedure TFrmPesqImpSedex.inivars;
begin
  qtdar:=0;
  qtdcepcap:=0;
  qtdcepest:=0;
  qtdcepnac1:=0;
  qtdcepnac2:=0;
  cab:='';
  seqreg:=1;
end;
procedure TFrmPesqImpSedex.gerexcel;
var
  XL : TDataSetToExcel;
begin

  with dm do
    begin
      SqlAux3.First;
      XL := TDataSetToExcel.Create(SqlAux3,arqexcel,cab);
      XL.WriteFile;
      XL.Free;
    end;
end;

procedure TFrmPesqImpSedex.prevarol;
{var
i:integer;
begin
  with dm do
    begin
      dtaux := DateTimePicker1.Date;
      for I := 0 to 99 do
        begin
          SqlAux1.Close;
          SqlAux1.SQL.Clear;
          SqlAux1.SQL.Add('select count(sdx_seqcarga) from tbsdx02 where (sdx_dtcarga between :dtini and :dtfin) and (sdx_seqcarga = :seqini)');
          SqlAux1.Params[0].AsDate :=  DateTimePicker1.Date;
          SqlAux1.Params[1].AsDate :=  DateTimePicker2.Date;
          SqlAux1.Params[2].Value  :=  i;
          SqlAux1.Open;
          if SqlAux1.fields[0].Value > 0 then
            begin
              try
              locarq  :=  'F:\sistemas\SedexOl\';
              except
                begin
                  Application.MessageBox(PChar('Erro de Conex�o Rede'),'ADS',0);
                  exit;
                end;
              end;
              arqexcel:= locarq+'BR'+formatdatetime('ddmmyy',dtaux)+inttostr(i)+'.xls';
              case i of
              00..09:locarq  :=  locarq+'BP1'+formatdatetime('ddmm',DateTimePicker3.Date)+inttostr(i)+'.SD1';// vou alterar qdo estiver ok
              65..90:locarq  :=  locarq+'BP1'+formatdatetime('ddmm',DateTimePicker3.Date)+'''+char(inttostr(i))+'''+'.SD1';// vou alterar qdo estiver ok
              end;
              AssignFile(arq,locarq);
              try
              Rewrite(arq);
              except
                begin
                  Application.MessageBox(PChar('N�o Pode Acessar Arquivo'+linha),'ADS',0);
                  EdSeqIni.Text  := inttostr(i);
                  Application.MessageBox(PChar('Sua Nova Sequ�ncia �: '+inttostr(i)+' e '+EdSeqFin.Text),'ADS',0);
                  exit;
                end;
              end;
              linha:='81660'+GeraNt('0',15)+GeraArquivo('BRADESCO PRIME',40)+formatdatetime('yyyymmdd',DateTimePicker3.Date)+GeraNT(inttostr(dm.SqlAux1.fields[0].Value+1),6);
              linha:=linha+GeraNT('0',94)+GeraNT(inttostr(i),5)+GeraNT('1',7);
              WriteLn(arq,linha);
              sel :=  'select sdx_numobj2,sdx_paisorigem,sdx_nomdest,sdx_endedest,sdx_cidade,sdx_uf,sdx_cep,sdx_seqcarga,sdx_numobj5 from tbsdx02 where (sdx_dtcarga between :dtini and :dtfin) and (sdx_seqcarga = :seq) order by sdx_cep';
              //                  0            1               2          3            4         5       6       7         8
             selexcel :=  'select sdx_numobj2 as "OBJETO",sdx_nomdest as "Nome Destinat�rio",';
             //                           0                                      1
             selexcel :=  selexcel  + 'sdx_endedest as "Endere�o Destinat�rio",sdx_cidade as "Cidade",sdx_uf as "UF",';
             //                                       2                                   3                  4
             selexcel :=  selexcel  + 'sdx_cep as "Cep",sdx_seqcarga as "Sequ�ncia Arquivo" from tbsdx02 where (sdx_dtcarga between :dtini and :dtfin) and (sdx_seqcarga = :seq) order by sdx_cep';
                  //                           5               6
              SqlAux2.Close;
              SqlAux2.SQL.Clear;
              SqlAux2.SQL.Add(sel);
              SqlAux2.Params[0].AsDate :=  DateTimePicker1.Date;
              SqlAux2.Params[1].AsDate :=  DateTimePicker2.Date;
              SqlAux2.Params[2].Value  :=  i;
              SqlAux3.Close;
              SqlAux3.SQL.Clear;
              SqlAux3.SQL.Add(selexcel);
              SqlAux3.Params[0].AsDate :=  DateTimePicker1.Date;
              SqlAux3.Params[1].AsDate :=  DateTimePicker2.Date;
              SqlAux3.Params[2].Value  :=  i;
              SqlAux2.Open;
//              inputbox('','',selexcel);
              SqlAux3.Open;
//              inputbox('','',inttostr(SqlAux3.RecordCount));
              SqlAux2.First;
              seqreg:=2;
              ProgBar.Max :=  SqlAux2.RecordCount;
              EdQtde.Text :=  IntToStr(SqlAux2.RecordCount);
              ProgBar.Position  := 1;
              ProgBar.Refresh;
              while not SqlAux2.Eof do
                begin
                linha:= '91660BP'+SqlAux2.Fields[0].AsString+'1101';
                linha:= linha+format('%-16.16s%',[' '])+format('%-40.40s%',[SqlAux2.Fields[2].AsString])+format('%-40.40s%',[SqlAux2.Fields[3].AsString]);
                linha:= linha+format('%-30.30s%',[SqlAux2.Fields[4].AsString])+SqlAux2.Fields[5].AsString+SqlAux2.Fields[6].AsString;
                linha:= linha+format('%8.8d',[0])+format('%5.5d',[i])+format('%7.7d',[seqreg]);
                WriteLn(arq,linha);
                seqreg:=seqreg+1;
                SqlAux2.Next;
                ProgBar.Position  :=  ProgBar.Position + 1;
                ProgBar.Refresh;
                end;
              gerexcel;
              ProgBar.Position :=  0;
              ProgBar.Refresh;
              CloseFile(Arq);
              Application.MessageBox(PChar('Arquivo Gerado com Sucesso: '+locarq+#10+' Excel: '+arqexcel),'ADS',0);
              dtaux := DateTimePicker1.Date+1;
            end
          else
          Application.MessageBox(PChar('N�o H� Registros com os Parametros Informados'),'ADS - Ar-Digital',0);
        end;
    end;}

var i:integer;
Begin
  i := 0;
  with dm do
    Begin
      try
        SqlAux1.Close;
        SqlAux1.SQL.Clear;
        SqlAux1.SQL.Add('select count(sdx_seqcarga) from tbsdx02 where (sdx_dtenvio between :dtini and :dtfin) ');
        if DBServSedex.KeyValue <> null then
          SqlAux1.SQL.Add('and (sdx_siglaobj = '+chr(39)+SqlSdxServtbsdxserv_sigla.AsString+chr(39)+') ');
        SqlAux1.Params[0].AsDate :=  DateTimePicker1.Date;
        SqlAux1.Params[1].AsDate :=  DateTimePicker2.Date;
        SqlAux1.Open;
        if SqlAux1.fields[0].Value = 0 then
          Application.MessageBox(PChar('N�o H� Registros com os Parametros Informados'),'ADS - Ar-Digital',0)
        else
          Begin
            try
              locarq  :=  'F:\sistemas\SedexOl';
              if (not(DirectoryExists(locarq))) then
                MkDir(locarq);
              SqlAux1.Close;
              SqlAux1.SQL.Clear;
              SqlAux1.SQL.Add('select max(sdx_nro)+1 from tbseqarqsdx where (sdxdata = (select current_date)) and (sdxprod= '+SqlSdxServtbsdxserv_cod.AsString+') ');
              SqlAux1.Open;

              if (Not(DirectoryExists(locarq))) then
                MkDir(locarq);
              try
    //                              0           1             2         3           4           5         6           7         8       9
                sel :=  'select sdx_numobj,sdx_paisorigem,sdx_cep,sdx_seqcarga,sdx_numobj1,sdx_peso,sdx_valdec,sdx_siglaobj,sdx_cmp,sdx_bas,';
    //                                10       11         12              13
                sel :=  sel + 'sdx_alt,sdx_cobdest,sdx_numobj2,(SELECT to_char(CURRENT_DATE,''yyyymmdd''))  AS dtger,';
    //                          14             15          16            17       18
                sel :=  sel + 'sdx_siglaobj,sdx_nomdest,sdx_endedest,sdx_cidade,sdx_uf from tbsdx02 where (sdx_dtenvio between :dtini and :dtfin) ';
    //              and (sdx_seqcarga between :seqini and :seqfin) ';
                sel :=  sel + 'and (sdx_siglaobj = '+chr(39)+ SqlSdxServtbsdxserv_sigla.AsString+chr(39)+') ';
                sel :=  sel + 'order by sdx_cep';
                SqlAux2.Close;
                SqlAux2.SQL.Clear;
                SqlAux2.SQL.Add(sel);
                SqlAux2.Params[0].AsDate :=  DateTimePicker1.Date;
                SqlAux2.Params[1].AsDate :=  DateTimePicker2.Date;
    //                SqlAux2.Params[2].Value  :=  StrToInt64(EdSeqIni.Text);
    //                SqlAux2.Params[3].Value  :=  StrToInt64(EdSeqFin.Text);
                SqlAux2.Open;
                SqlAux2.First;
                locarq  :=  locarq+'\'+ SqlSdxServtbsdxserv_sigla.AsString+'1'+formatdatetime('ddmm',DateTimePicker3.Date)+EdSeqIni.Text+'.SD1';
                EdArq.Text  :=  locarq;
                AssignFile(arq,locarq);
                Rewrite(arq);
                seqreg:=2;
                EdQtde.Text :=  IntToStr(SqlAux2.RecordCount);
                EdQtde.Refresh;
                ProgBar.Max :=  SqlAux2.RecordCount;
                ProgBar.Position  := 1;
                ProgBar.Refresh;
                linha := '8'+format('%4.4d',[SqlSdxServtbsdxserv_prod.AsInteger])+StringOfChar('0',15);
                linha := linha + format('%-40.40s%',['BRADESCO SA'])+  SqlAux2.Fields[13].AsString+format('%6.6d',[(SqlAux2.RecordCount+1)]);
                linha := linha + StringOfChar('0',94);
                linha := linha + format('%5.5d',[StrToInt64(EdSeqIni.Text)])+format('%7.7d',[1]);
                WriteLn(arq,linha);
                While not SqlAux2.Eof do
                  Begin
//                    linha:= '9'+format('%4.4d',[SqlSdxServtbsdxserv_prod.AsInteger])+format('%-4.4s%',['BP'+SqlAux2.Fields[14].AsString]);
//                    linha:= '9'+format('%4.4d',[SqlSdxServtbsdxserv_prod.AsInteger])+format('%-4.4s%',[SqlAux2.Fields[12].AsString+SqlAux2.Fields[14].AsString]);
                    linha:= '9'+format('%4.4d',[SqlSdxServtbsdxserv_prod.AsInteger])+format('%-4.4s%',[SqlAux2.Fields[14].AsString+SqlAux2.Fields[12].AsString]);
                    linha:= linha+format('%-15.15s%',[SqlAux2.Fields[0].AsString+SqlAux2.Fields[1].AsString+'1101']);
                    linha:= linha+format('%-16.16s%',[SqlSdxServtbsdxserv_dsc.AsString]);
                    linha:= linha+format('%-40.40s%',[SqlAux2.Fields[15].AsString])+format('%-40.40s%',[SqlAux2.Fields[16].AsString]);
                    linha:= linha+format('%-30.30s%',[copy(SqlAux2.Fields[17].AsString,1,30)])+format('%-10.10s%',[SqlAux2.Fields[18].AsString+SqlAux2.Fields[2].AsString]);
                    linha:= linha+format('%8.8d',[0])+format('%5.5d',[StrToInt64(EdSeqIni.Text)])+format('%7.7d',[seqreg]);
                    WriteLn(arq,linha);
                    Inc(seqreg,1);
                    SqlAux2.Next;
                    ProgBar.Position  :=  ProgBar.Position + 1;
                    ProgBar.Refresh;
                  end;
                try
                    CloseFile(Arq);

                //                  0            1               2          3            4         5       6       7         8
                 selexcel :=  'select sdx_numobj2 as "OBJETO",sdx_nomdest as "Nome Destinat�rio",';
                 //                           0                                      1
                 selexcel :=  selexcel  + 'sdx_endedest as "Endere�o Destinat�rio",sdx_cidade as "Cidade",sdx_uf as "UF",';
                 //                                       2                                   3                  4
                 selexcel :=  selexcel  + 'sdx_cep as "Cep",sdx_seqcarga as "Sequ�ncia Arquivo" from tbsdx02 where (sdx_dtcarga between :dtini and :dtfin) and (sdx_seqcarga = :seq) order by sdx_cep';
                      //                           5               6
                  SqlAux3.Close;
                  SqlAux3.SQL.Clear;
                  SqlAux3.SQL.Add(selexcel);
                  SqlAux3.Params[0].AsDate :=  DateTimePicker1.Date;
                  SqlAux3.Params[1].AsDate :=  DateTimePicker2.Date;
                  SqlAux3.Params[2].Value  :=  i;
                  SqlAux2.Open;
    //              inputbox('','',selexcel);
                  SqlAux3.Open;
                  gerexcel;
                  SqlAux1.Close;
                  SqlAux1.SQL.Clear;
                  SqlAux1.SQL.Add('update tbseqarqsdx set sdx_nro ='+EdSeqIni.Text+' ,sdxdata=(select current_date)  where (sdxprod= '+SqlSdxServtbsdxserv_cod.AsString+')');
                  //InputBox('','',SqlAux1.sql.Text);
                  SqlAux1.ExecSQL;
                  //CloseFile(Arq);
                  ProgBar.Position :=  0;
                  ProgBar.Refresh;
                  Application.MessageBox(PChar('Arquivo Gerado com Sucesso!'),'ADS',0);
                except on e: exception do
                  Application.MessageBox(PChar(e.Message),'ADS',0);
    //                    EdSeqIni.Text  := inttostr(i);
                end;
              except on e: exception do
                  Application.MessageBox(PChar(e.Message),'ADS',0);
              end;
            except on e: exception do
                Application.MessageBox(PChar(e.Message),'ADS',0);
            end;
          end;
      except on e: exception do
          Application.MessageBox(PChar(e.Message),'ADS',0);
      end;
    end;

end;
procedure TFrmPesqImpSedex.repoltctk;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
//                                  0         1           2         3           4       5         6           7         8
      SqlAux1.SQL.Add('select sdx_siglaobj,sdx_nomdest,sdx_numobj1,sdx_dtenvio,sdx_qtde,sdx_peso,sdx_valor,sdx_tvalor,sdx_numobj2 from tbsdx02 where (sdx_dtenvio between :dt1 and :dt2) ');
      if DBServSedex.KeyValue <> null then
        SqlAux1.SQL.Add('and (sdx_siglaobj = '+chr(39)+SqlSdxServtbsdxserv_sigla.AsString+chr(39)+') ');
      SqlAux1.SQL.Add('order by sdx_siglaobj,sdx_dtenvio,substr(sdx_nomdest,1,4)');
      SqlAux1.Params[0].AsDate  :=  DateTimePicker1.Date;
      SqlAux1.Params[1].AsDate  :=  DateTimePicker2.Date;
      SqlAux1.Open;
      EdQtde.Text  := IntToStr(SqlAux1.RecordCount);
      EdQtde.Refresh;
      ProgBar.Max :=  SqlAux1.RecordCount;
      ProgBar.Position  :=  0;
      ProgBar.Refresh;
      if SqlAux1.RecordCount = 0 then
        begin
          Application.MessageBox('Nenhum Registro Encontrado','ADS',ID_OK);
          exit;
        end
      else
      begin
        try
        mexcel:=CreateOleObject('Excel.Application');
        mexcel.Visible :=false;
        mexcel.WorkBooks.add(1);
 //       mexcel.WorkBooks.Open('d:\pasta1.xls');

//        mexcel

        {          OpenOffice:=CreateOleObject('com.sun.star.ServiceManager');
          OpenDesktopOppenOffice:=OpenOffice.CreateInstance('com.sun.star.frame.Desktop');
          coreRefl       := OpenOffice.createInstance('com.sun.star.reflection.CoreReflection');
          param          := VarArrayCreate([0, -1],varVariant);}
//          EdArq.Text  :='d:\ArqAds\';
//          EdArq.Text  :='f:\Sistemas\SedexOl\';
          EdArq.Text  :='O:\sedex_ar\Repasse';
          if not(DirectoryExists(EdArq.Text)) then
            //MkDir(document);
            MkDir(EdArq.Text);
          EdArq.Text:=EdArq.Text+'\REPSDX';
          if DBServSedex.KeyValue <> null then
            EdArq.Text:=EdArq.Text+SqlSdxServtbsdxserv_sigla.AsString;
          EdArq.Text:=EdArq.Text+ FormatDateTime('ddmmyyyy',DateTimePicker3.Date) +'.xls';
          EdArq.Refresh;

{          document:=document+'pasta01.ods';
          document:=strtran(document,'\', '/');
          document:='File:///'+document;
          CalcOpen:= OpenDesktopOppenOffice.LoadComponentFromUrl(document,'_blank',0,param);
//          x:=
          SheetOpen:=CalcOpen.Sheets.getByIndex(0);
          sigla :=  SqlAux1.Fields[0].AsString;
          dtaux :=  SqlAux1.Fields[3].Value;
          lin:=0;
          SheetOpen.GetCellByPosition(lin,3).String :=  'DATA DA POSTAGEM: '+ FormatDateTime('dd/mm/yyyy',SqlAux1.Fields[3].AsDateTime);
          SheetOpen.GetCellByPosition(lin,4).String :=  'JUN��O DA AG�NCIA DE DESTINO';
          lin:=lin+1;
          SheetOpen.GetCellByPosition(lin,3).String :=  'PRODUTO';
          SheetOpen.GetCellByPosition(lin,4).String :=  'NUMERO DO SEDEX';
          SheetOpen.GetCellByPosition(lin,5).String :=  'VALOR';}
          SqlAux1.First;
          sigla :=  SqlAux1.Fields[0].AsString;
          dtaux :=  SqlAux1.Fields[3].Value;
          lin:=1;
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,3] := 'DATA DA POSTAGEM: '+ FormatDateTime('dd/mm/yyyy',SqlAux1.Fields[3].AsDateTime);
          lin:=lin+1;
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,2].ColumnWidth  :=  7.30;
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,2] :=  'JUN��O ';
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,3].ColumnWidth  :=  8.86;
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,3] :=  'PRODUTO';
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,4].ColumnWidth  :=  14;
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,4] :=  'N� DO SEDEX';
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,5].ColumnWidth  :=  11;
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,5].HorizontalAlignment   :=  4;
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,5] :=  'VALOR';
          lin:=lin+1;
          while not (SqlAux1.eof) do
            begin
              if (sigla = SqlAux1.Fields[0].AsString) then
                begin
                  if  (sigla = SqlAux1.Fields[0].AsString) and (dtaux =  SqlAux1.Fields[3].Value) then
                    begin
                      ProgBar.Position  :=  ProgBar.Position+1;
                      ProgBar.Refresh;
                      mexcel.WorkBooks[1].Sheets[1].Cells[lin,2].NumberFormat  := '0000';
//                      (GeraNT(Copy(SqlAux1.Fields[1].AsString,1,4),4));
                      mexcel.WorkBooks[1].Sheets[1].Cells[lin,2]  :=  GeraNT(Copy(SqlAux1.Fields[1].AsString,1,4),4);
                      if SqlAux1.Fields[0].AsString = 'OL' then
                        mexcel.WorkBooks[1].Sheets[1].Cells[lin,3]  :=  '770'
                      else  if SqlAux1.Fields[0].AsString = 'TK' then
                        mexcel.WorkBooks[1].Sheets[1].Cells[lin,3]  :=  '2791'
                      else  if SqlAux1.Fields[0].AsString = 'TC' then
                        mexcel.WorkBooks[1].Sheets[1].Cells[lin,3]  :=  '2792'
                      else  if SqlAux1.Fields[0].AsString = 'KD' then
                        mexcel.WorkBooks[1].Sheets[1].Cells[lin,3]  :=  '2792'
                      else  if SqlAux1.Fields[0].AsString = 'KE' then
                        mexcel.WorkBooks[1].Sheets[1].Cells[lin,3]  :=  '2791'
                      else
                        mexcel.WorkBooks[1].Sheets[1].Cells[lin,3]  :=  '';
                      mexcel.WorkBooks[1].Sheets[1].Cells[lin,4]   :=  SqlAux1.Fields[8].AsString;
                      mexcel.WorkBooks[1].Sheets[1].Cells[lin,5].HorizontalAlignment   :=  4;
                      mexcel.WorkBooks[1].Sheets[1].Cells[lin,5]  :=  FormatFloat('#,##0.00;;',SqlAux1.Fields[7].AsFloat);
                      vldata :=  vldata + SqlAux1.Fields[7].Value;
                      lin:=lin+1;
                      SqlAux1.Next;
                    end
                  else
                    begin
                      mexcel.WorkBooks[1].Sheets[1].Cells[lin,4] :=  'Total Postagem : '+FormatDateTime('dd/mm/yyyy',dtaux);
                      mexcel.WorkBooks[1].Sheets[1].Cells[lin,5] :=  FormatFloat('#,##0.00;;',vldata);
                      vlsigla :=  vlsigla+vldata;
                      vldata  :=  0;
                      lin:=lin+1;
                      dtaux :=  SqlAux1.Fields[3].Value;
                      mexcel.WorkBooks[1].Sheets[1].Cells[lin,3] := 'DATA DA POSTAGEM: '+ FormatDateTime('dd/mm/yyyy',SqlAux1.Fields[3].AsDateTime);
                      lin:=lin+1;
                      mexcel.WorkBooks[1].Sheets[1].Cells[lin,2] :=  'JUN��O ';
                      mexcel.WorkBooks[1].Sheets[1].Cells[lin,3] :=  'PRODUTO';
                      mexcel.WorkBooks[1].Sheets[1].Cells[lin,4] :=  'N� DO SEDEX';
                      mexcel.WorkBooks[1].Sheets[1].Cells[lin,5] :=  'VALOR';
                      lin:=lin+1;
                    end;
                end
              else
                begin
                  mexcel.WorkBooks[1].Sheets[1].Cells[lin,4] :=  'Total Postagem : '+FormatDateTime('dd/mm/yyyy',dtaux);
                  mexcel.WorkBooks[1].Sheets[1].Cells[lin,5].HorizontalAlignment   :=  4;
                  mexcel.WorkBooks[1].Sheets[1].Cells[lin,5]  :=  FormatFloat('#,##0.00;;',SqlAux1.Fields[7].AsFloat);
                  vlsigla :=  vlsigla+vldata;
                  totgeral:=  totgeral + vlsigla;
                  lin:=lin+1;
                  mexcel.WorkBooks[1].Sheets[1].Cells[lin,4]  :=  'Total Postagem : '+sigla;
                  mexcel.WorkBooks[1].Sheets[1].Cells[lin,5].HorizontalAlignment   :=  4;
                  mexcel.WorkBooks[1].Sheets[1].Cells[lin,5]  :=  FormatFloat('#,##0.00;;',vlsigla);
                  vldata  :=  0;
                  vlsigla :=  0;
                  dtaux :=  SqlAux1.Fields[3].Value;
                  sigla :=  SqlAux1.Fields[0].AsString;
                  lin:=lin+1;
                  mexcel.WorkBooks[1].Sheets[1].Cells[lin,3] := 'DATA DA POSTAGEM: '+ FormatDateTime('dd/mm/yyyy',SqlAux1.Fields[3].AsDateTime);
                  lin:=lin+1;
                  mexcel.WorkBooks[1].Sheets[1].Cells[lin,2] :=  'JUN��O ';
                  mexcel.WorkBooks[1].Sheets[1].Cells[lin,3] :=  'PRODUTO';
                  mexcel.WorkBooks[1].Sheets[1].Cells[lin,4] :=  'N� DO SEDEX';
                  mexcel.WorkBooks[1].Sheets[1].Cells[lin,5] :=  'VALOR';
                  lin:=lin+1;
                end;

            end;
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,4] :=  'Total Postagem : '+FormatDateTime('dd/mm/yyyy',dtaux);
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,5].HorizontalAlignment   :=  4;
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,5] :=  FormatFloat('#,##0.00;;',vldata);
          vlsigla :=  vlsigla+vldata;
          totgeral:=  totgeral + vlsigla;
          lin:=lin+1;
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,4]  :=  'Total Postagem : '+sigla;
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,5].HorizontalAlignment   :=  4;
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,5]  :=  FormatFloat('#,##0.00;;',vlsigla);
          lin:=lin+1;
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,4] :=  'Total Geral: ==>';
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,5].HorizontalAlignment   :=  4;
          mexcel.WorkBooks[1].Sheets[1].Cells[lin,5] :=  FormatFloat('#,##0.00;;',totgeral);
          vldata  :=  0;
          vlsigla :=  0;
          totgeral:=  0;
          mexcel.WorkBooks[1].SaveAs(EdArq.Text);
//          Application.MessageBox('Arquivo Gerado :'+ chr(10)+document,'ADS',ID_OK);
          mexcel.WorkBooks[1].Close;
          Finalize(mexcel);
          Application.MessageBox('Arquivo Gerado','ADS',IDOK);
        except on e: exception do
          begin
            Application.MessageBox (PChar('Erro ao Abrir Ms-Excel: '+e.Message),'ADS',MB_OK+MB_ICONERROR);
            exit;
          end;
        end;

      end;
    end;
end;
procedure TFrmPesqImpSedex.plansedex; // Arquivo em Excel Para o Manuseio
var
  XL : TDataSetToExcel;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
//                                  0                             1                                       2                   3                     4                       5
      SqlAux1.SQL.Add('select sdx_siglaobj as "Produto",cast(sdx_numobj as text) as "AR-Sedex",substr(sdx_nomdest,1,4) as "Ag-Jun��o",sdx_qtde as "Volume",sdx_peso as "Peso",sdx_dtcarga as "Data-Sedex",cast(sdx_seqcarga as text) as "Lote" ');
      SqlAux1.SQL.Add('from tbsdx02 where (sdx_dtcarga between :dt1 and :dt2) ');
      SqlAux1.Params[0].AsDate  :=  DateTimePicker1.Date;
      SqlAux1.Params[1].AsDate  :=  DateTimePicker2.Date;
      if DBServSedex.KeyValue <> null then
        SqlAux1.SQL.Add('and (sdx_siglaobj = '''+ SqlSdxServtbsdxserv_sigla.AsString+''') ');
      SqlAux1.SQL.Add('order by sdx_siglaobj,sdx_dtcarga');
//      InputBox('','',SqlAux1.SQL.Text);
      SqlAux1.Open;
      EdQtde.Text  := IntToStr(SqlAux1.RecordCount);
      if SqlAux1.RecordCount = 0 then
        begin
          Application.MessageBox('Nenhum Registro Encontrado','ADS',ID_OK);
          exit;
        end
      else
      begin
      EdArq.Text  :='f:\Sistemas\SedexOl\';
      if not(DirectoryExists(EdArq.Text)) then
        MkDir(EdArq.Text);
      EdArq.Text  :=EdArq.Text  + 'ARSedex'+SqlSdxServtbsdxserv_sigla.AsString+FormatDateTime('ddmmyyyy',DateTimePicker3.Date )+FormatDateTime('hhmmss',DateTimePicker3.Time);
      SqlAux1.First;
      XL := TDataSetToExcel.Create(SqlAux1,EdArq.Text,cab);
      XL.WriteFile;
      XL.Free;
      end;
    end;
end;
procedure TFrmPesqImpSedex.arpend;    // Relat�rio de Ar Pendentes - N�o Baixados.
begin
  with dm do
    begin
      SqlSdx4.Close;
      SqlSdx4.SQL.Clear;
//                                                                      0          1
      SqlSdx4.SQL.Add('select * from tbsdx02 where (sdx_dtcarga between :dt1 and :dt2) ');
      SqlSdx4.Params[0].AsDate  :=  DateTimePicker1.Date;
      SqlSdx4.Params[1].AsDate  :=  DateTimePicker2.Date;
      if DBServSedex.KeyValue <> null then
        SqlSdx4.SQL.Add('and (sdx_siglaobj = '''+ SqlSdxServtbsdxserv_sigla.AsString+''') ');
      SqlSdx4.SQL.Add('and (sdx_dtbaixa is null) ');
      SqlSdx4.SQL.Add('order by sdx_siglaobj,sdx_dtcarga');
//      InputBox('','',SqlSdx4.SQL.Text);
      SqlSdx4.Open;
      EdQtde.Text  := IntToStr(SqlSdx4.RecordCount);
      if SqlSdx4.RecordCount = 0 then
        begin
          Application.MessageBox('Nenhum Registro Encontrado','ADS',ID_OK);
          exit;
        end
      else
        begin
          SqlSdx4.First;
          Application.CreateForm(TFrmRelArPend,FrmRelArPend);
          FrmRelARPend.RLARPend.PreviewModal;
          FrmRelARPend.RLARPend.Destroy;
        end;
    end;
end;
procedure TFrmPesqImpSedex.retoltctk ;// Arquivo de Retorno de AR-Sedex Ol-Tc-Tk Entregues
var
   R, Y : Integer;
begin
  ind :=  -1;
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
//                                  0         1           2         3           4       5         6           7           8
      SqlAux1.SQL.Add('select sdx_siglaobj,sdx_nomdest,sdx_numobj1,sdx_dtenvio,sdx_qtde,sdx_peso,sdx_valor,sdx_tvalor,sdx_dtentrega,');
//                          9             10        11      12          13          14          15
      SqlAux1.SQL.Add('sdx_nomrecebe,sdx_qtprod,sdx_uf,sdx_dtcarga,sdx_numseqreg,sdx_numobj2,sdx_dtmov from tbsdx02 where (sdx_dtbaixa is not null) ');
      if DBServSedex.KeyValue <> null then
        SqlAux1.SQL.Add('and (sdx_siglaobj = '+chr(39)+SqlSdxServtbsdxserv_sigla.AsString+chr(39)+') ');
      SqlAux1.SQL.Add('and (sdx_dtenvio is not null) ');
      if (EdSeqIni.Text <> '') and (EdSeqFin.Text = '') then
        SqlAux1.SQL.Add('and (sdx_seqcarga = '+EdSeqIni.Text+') ')
      else  if (EdSeqIni.Text = '') and (EdSeqFin.Text <> '') then
        SqlAux1.SQL.Add('and (sdx_seqcarga = '+EdSeqFin.Text+') ')
      else  if (EdSeqIni.Text <> '') and (EdSeqFin.Text <> '') then
        SqlAux1.SQL.Add('and (sdx_seqcarga between '+EdSeqIni.Text+' and '+EdSeqFin.Text+') ');
      if CboBoxGer.ItemIndex = 0 then
        SqlAux1.SQL.Add('and (sdx_dtarqret is null) ')
      else if CboBoxGer.ItemIndex = 1 then
        SqlAux1.SQL.Add('and (sdx_dtarqret is not null) ');
      SqlAux1.SQL.Add('order by sdx_dtmov,sdx_siglaobj,substr(sdx_nomdest,1,4)');
      SqlAux1.Open;
      EdQtde.Text   := IntToStr(SqlAux1.RecordCount);
      EdQtde.Refresh;
      if SqlAux1.RecordCount = 0 then
        begin
          Application.MessageBox('Nenhum Registro Encontrado','ADS',ID_OK);
          exit;
        end
      else
        begin
          try
            SetLength(marray,SqlAux1.RecordCount);
            mexcel:=CreateOleObject('Excel.Application');
            mexcel.Visible :=false;
            mexcel.WorkBooks.add(1);
  //        EdArq.Text  :='D:\ArqAds\';
            ProgBar.Position  :=  0;
            ProgBar.Max :=  SqlAux1.RecordCount;
            ProgBar.Refresh;
            EdArq.Text  :='f:\Sistemas\SedexOl\';
            if not(DirectoryExists(EdArq.Text)) then
              MkDir(document);
            EdArq.Text:=EdArq.Text+'LSTSDX';
            if DBServSedex.KeyValue <> null then
              EdArq.Text:=EdArq.Text+SqlSdxServtbsdxserv_sigla.AsString;
            EdArq.Text:=EdArq.Text+ FormatDateTime('ddmmyyyy',DateTimePicker3.Date);
            locarq  :=  EdArq.Text+format('%3.3d',[seqreg])+'.txt';
            EdArq.Text:=EdArq.Text + '.xls';
            EdArq.Refresh;
            SqlAux1.First;
            lin:=1;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,1].font.bold  :=  true;
            if SqlAux1.Fields[0].AsString = 'KD' then
              sel :=  'TAN-CODE - 2240'
            else  if SqlAux1.Fields[0].AsString = 'KE' then
              sel :=  'TOKEN - 2241'
            else  if SqlAux1.Fields[0].AsString = 'TC' then
              sel :=  'TAN-CODE'
            else  if SqlAux1.Fields[0].AsString = 'TK' then
              sel :=  'TOKEN'
            else  if SqlAux1.Fields[0].AsString = 'OL' then
              sel :=  'OP.LOGISTICO'
            else
              sel  :=  SqlAux1.Fields[0].AsString;
            sel  := sel  + ' - Movimento ';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,1]  :=  sel;
            lin:=lin+1;
            for r := 1 to 12 do
              begin
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,r].font.bold  :=  true;
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,r].Interior.Color := $00CECECE//  :=  clSilver;
              end;

            mexcel.WorkBooks[1].Sheets[1].Cells[lin,1] :=  'UF';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,2].ColumnWidth  :=  7.30;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,2] :=  'Cod-AG';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,3].ColumnWidth  :=  45;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,3] :=  'Ag�ncia';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,4].ColumnWidth  :=  6;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,4] :=  'Cart�o';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,5].ColumnWidth  :=  9.43;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,5] :=  'Pedido';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,6].ColumnWidth  :=  3;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,6] :=  'Vol';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,7].ColumnWidth  :=  5;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,7] :=  'Peso';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,8].ColumnWidth  :=  14.30;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,8] :=  'DTB';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,9].ColumnWidth  :=  11;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,9].HorizontalAlignment   :=  4;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,9] :=  'VALOR';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,10].ColumnWidth  :=  9.43;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,10] :=  'Postagem';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,11].ColumnWidth  :=  9.43;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,11] :=  'Entregue';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,12].ColumnWidth  :=  40;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,12] :=  'Recebedor';
            AssignFile(arq,locarq);
            Rewrite(arq);
            dta :=  SqlAux1.Fields[15].AsString;
            lin:=lin+1;
            while not (SqlAux1.eof) do
              begin
                Inc(ind,1);
                marray[ind] :=  SqlAux1.Fields[13].Value;
                ProgBar.Position  :=  ProgBar.Position+1;
                ProgBar.Refresh;
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,1]  :=  SqlAux1.Fields[11].AsString;
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,2].NumberFormat  := '0000';
  //                      (GeraNT(Copy(SqlAux1.Fields[1].AsString,1,4),4));
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,2]  :=  GeraNT(Copy(SqlAux1.Fields[1].AsString,1,4),4);
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,3]  :=  Copy(SqlAux1.Fields[1].AsString,6,75);
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,4]  :=  SqlAux1.Fields[10].AsString;
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,5]  :=  ''''+SqlAux1.Fields[15].AsString;
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,6]  :=  SqlAux1.Fields[4].AsString;
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,7]  :=  FormatFloat('##0.00;;',SqlAux1.Fields[5].AsFloat);
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,8]  :=  SqlAux1.Fields[14].AsString;
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,9].HorizontalAlignment   :=  4;
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,9]  :=  FormatFloat('#,##0.00;;',SqlAux1.Fields[7].AsFloat);
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,10]   :=  ''''+FormatDateTime('dd/mm/yyyy',SqlAux1.Fields[3].AsDateTime);
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,11]   :=  ''''+FormatDateTime('dd/mm/yyyy',SqlAux1.Fields[8].AsDateTime);
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,12]  :=  SqlAux1.Fields[9].AsString;
                vldata :=  vldata + SqlAux1.Fields[7].Value;
                lin:=lin+1;
                SqlAux1.Next;
              end;
            mexcel.WorkBooks[1].SaveAs(EdArq.Text);
            mexcel.WorkBooks[1].Close;
            Finalize(mexcel);
            SqlAux1.First;
            dta :=  SqlAux1.Fields[15].AsString;
            while not (SqlAux1.eof) do
              begin
                // formata��es '%-16.16s%'/ -> string //'%8.8d'/->numerico
                linha :=  Format('%-2.2s%',[SqlAux1.Fields[11].AsString]);
                linha :=  linha + Format('%4.4d',[StrToInt(copy(SqlAux1.Fields[1].AsString,1,4))]);
                linha :=  linha + Format('%-100.100s%',[trim(copy(SqlAux1.Fields[1].AsString,6,75))]);
                linha :=  linha + Format('%5.5d',[SqlAux1.Fields[10].AsInteger]);
                linha :=  linha + Format('%-10.10s%',[SqlAux1.Fields[15].AsString]);
                linha :=  linha + Format('%5.5d%',[SqlAux1.Fields[4].AsInteger]);
                linha :=  linha + Format('%5.5s%',[FormatFloat('#,##0.000;;',SqlAux1.Fields[5].AsFloat)]);
                linha :=  linha + Format('%-100.100s%',[SqlAux1.Fields[14].AsString]);
                linha :=  linha + Format('%13.13s%',[FormatFloat('#,##0.00;;',SqlAux1.Fields[7].AsFloat)]);
                linha :=  linha + FormatDateTime('dd/mm/yyyy',SqlAux1.Fields[3].AsDateTime);
                linha :=  linha + FormatDateTime('dd/mm/yyyy',SqlAux1.Fields[8].AsDateTime);
                linha :=  linha + Format('%-100.100s%',[SqlAux1.Fields[9].AsString]);
                Writeln(arq,linha);
                lin:=lin+1;
                SqlAux1.Next;
              end;
            CloseFile(arq);
            for y := 0 to ind do
              begin
                SqlAux2.Close;
                SqlAux2.SQL.Clear;
                SqlAux2.SQL.Add('update tbsdx02 set sdx_dtarqret = (select current_date) where (sdx_numseqreg = :seqreg) and (sdx_dtarqret is null) ');
                SqlAux2.Params[0].Value :=  marray[y];
                SqlAux2.ExecSQL;
              end;
            Application.MessageBox('Arquivo Gerado','ADS',IDOK);
            Finalize(marray);
          except on e: exception do
            begin
              Application.MessageBox (PChar('Erro ao Abrir Ms-Excel: '+e.Message),'ADS',MB_OK+MB_ICONERROR);
              exit;
            end;
          end;
        end;
    end;
end;
procedure TFrmPesqImpSedex.pedoltctk;
var
  r:Integer;
begin
  ind :=  -1;
  seqreg  :=  1;
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
//                                  0         1           2         3             4       5         6           7           8
      SqlAux1.SQL.Add('select sdx_siglaobj,sdx_nomdest,sdx_numobj1,sdx_dtenvio,sdx_qtde,sdx_peso,sdx_valor,sdx_tvalor,sdx_dtentrega,');
//                          9             10        11      12          13          14                          15
      SqlAux1.SQL.Add('sdx_nomrecebe,sdx_qtprod,sdx_uf,sdx_dtcarga,sdx_numseqreg,sdx_numobj2,cast(to_char(sdx_dtmov,''dd/mm/yyyy'') as Text) as "DtPed" from tbsdx02 where (sdx_dtenvio between :dti and :dtf) ');
      SqlAux1.Params[0].AsDate  :=  DateTimePicker1.Date;
      SqlAux1.Params[1].AsDate  :=  DateTimePicker2.Date;
      if DBServSedex.KeyValue <> null then
        SqlAux1.SQL.Add('and (sdx_siglaobj = '+chr(39)+SqlSdxServtbsdxserv_sigla.AsString+chr(39)+') ');
      if (EdSeqIni.Text <> '') and (EdSeqFin.Text = '') then
        SqlAux1.SQL.Add('and (sdx_seqcarga = '+EdSeqIni.Text+') ')
      else  if (EdSeqIni.Text = '') and (EdSeqFin.Text <> '') then
        SqlAux1.SQL.Add('and (sdx_seqcarga = '+EdSeqFin.Text+') ')
      else if (EdSeqIni.Text <> '') and (EdSeqFin.Text <> '') then
        SqlAux1.SQL.Add('and (sdx_seqcarga between '+EdSeqIni.Text+' and '+EdSeqFin.Text+') ');
//      SqlAux1.SQL.Add('and (sdx_dtenvio is not null) ');
      SqlAux1.SQL.Add('order by "DtPed",sdx_siglaobj,substr(sdx_nomdest,1,4)');
      SqlAux1.Open;
      EdQtde.Text   := IntToStr(SqlAux1.RecordCount);
      EdQtde.Refresh;
      if SqlAux1.RecordCount = 0 then
        begin
          Application.MessageBox('Nenhum Registro Encontrado','ADS',ID_OK);
          exit;
        end
      else
        begin
          try
            mexcel:=CreateOleObject('Excel.Application');
            mexcel.Visible :=false;
            mexcel.WorkBooks.add(1);
//            EdArq.Text  :='C:\';
            ProgBar.Position  :=  0;
            ProgBar.Max :=  SqlAux1.RecordCount;
            ProgBar.Refresh;
            EdArq.Text  :='f:\Sistemas\SedexOl\';
            if not(DirectoryExists(EdArq.Text)) then
              MkDir(document);
            EdArq.Text:=EdArq.Text+'LSTPEDSDX';
            if DBServSedex.KeyValue <> null then
              EdArq.Text:=EdArq.Text+SqlSdxServtbsdxserv_sigla.AsString;
            EdArq.Text:=EdArq.Text+ FormatDateTime('ddmmyyyy',DateTimePicker3.Date);
            locarq  :=  EdArq.Text+format('%3.3d',[seqreg])+'.txt';
            EdArq.Text:=EdArq.Text + '.xls';
            EdArq.Refresh;
            SqlAux1.First;
            sigla :=  SqlAux1.Fields[0].AsString;
            dtaux :=  SqlAux1.Fields[12].Value;
            lin:=1;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,1].font.bold  :=  true;
            if SqlAux1.Fields[0].AsString = 'KD' then
              sel :=  'TAN-CODE - 2240'
            else  if SqlAux1.Fields[0].AsString = 'KE' then
              sel :=  'TOKEN - 2241'
            else  if SqlAux1.Fields[0].AsString = 'TC' then
              sel :=  'TAN-CODE'
            else  if SqlAux1.Fields[0].AsString = 'TK' then
              sel :=  'TOKEN'
            else  if SqlAux1.Fields[0].AsString = 'OL' then
              sel :=  'OP.LOGISTICO'
            else
              sel  :=  SqlAux1.Fields[0].AsString;
            sel  := sel  + ' - Movimento: '+ SqlAux1.Fields[15].AsString ;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,1]  :=  sel;
            lin:=lin+1;
            for r := 1 to 12 do
              begin
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,r].font.bold  :=  true;
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,r].Interior.Color := $00CECECE//  :=  clSilver;
              end;

            mexcel.WorkBooks[1].Sheets[1].Cells[lin,1] :=  'UF';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,2].ColumnWidth  :=  7.30;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,2] :=  'Cod_AG';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,3].ColumnWidth  :=  45;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,3] :=  'Ag�ncia Descri�ao';

            mexcel.WorkBooks[1].Sheets[1].Cells[lin,4].ColumnWidth  :=  6;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,4] :=  'Cart�o';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,5].ColumnWidth  :=  9.43;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,5] :=  'Pedido';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,6].ColumnWidth  :=  3;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,6] :=  'Vol';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,7].ColumnWidth  :=  5;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,7] :=  'Peso';

            mexcel.WorkBooks[1].Sheets[1].Cells[lin,8].ColumnWidth  :=  14.30;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,8] :=  'DTB';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,9].ColumnWidth  :=  11;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,9].HorizontalAlignment   :=  4;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,9] :=  'VALOR';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,10].ColumnWidth  :=  9.43;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,10] :=  'Postagem';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,11].ColumnWidth  :=  9.43;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,11] :=  'Entregue';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,12].ColumnWidth  :=  40;
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,12] :=  'Recebedor';
            mexcel.WorkBooks[1].Sheets[1].Cells[lin,12].ColumnWidth  :=  40;

            lin:=lin+1;
            while not (SqlAux1.eof) do
              begin
                ProgBar.Position  :=  ProgBar.Position+1;
                ProgBar.Refresh;
//                                  0         1           2             3             4       5         6           7           8
//      SqlAux1.SQL.Add('select sdx_siglaobj,sdx_nomdest,sdx_numobj1,sdx_dtenvio,sdx_qtde,sdx_peso,sdx_valor,sdx_tvalor,sdx_dtentrega,');
//                          9             10        11      12          13          14                          15
//      SqlAux1.SQL.Add('sdx_nomrecebe,sdx_qtprod,sdx_uf,sdx_dtcarga,sdx_numseqreg,sdx_numobj2,cast(to_char(sdx_dtmov,''dd/mm/yyyy'') as Text) as "DtPed" from tbsdx02 where (sdx_dtenvio between :dti and :dtf) ');
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,1]  :=  SqlAux1.Fields[11].AsString;
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,2].NumberFormat  := '0000';
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,2]  :=  GeraNT(Copy(SqlAux1.Fields[1].AsString,1,4),4);
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,3]  :=  Copy(SqlAux1.Fields[1].AsString,6,75);
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,4]  :=  SqlAux1.Fields[10].AsString;
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,5]  :=  ''''+SqlAux1.Fields[15].AsString;
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,6]  :=  SqlAux1.Fields[4].AsString;
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,7]  :=  FormatFloat('##0.00;;',SqlAux1.Fields[5].AsFloat);
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,8]  :=  SqlAux1.Fields[14].AsString;
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,9].HorizontalAlignment   :=  4;
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,9]  :=  FormatFloat('#,##0.00;;',SqlAux1.Fields[7].AsFloat);
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,10]:= ''''+FormatDateTime('dd/mm/yyyy',SqlAux1.Fields[3].AsDateTime);
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,11]   :=  '';//FormatDateTime('dd/mm/yyyy',SqlAux1.Fields[8].AsDateTime);
                mexcel.WorkBooks[1].Sheets[1].Cells[lin,12]  :=  '';////SqlAux1.Fields[9].AsString;
                vldata :=  vldata + SqlAux1.Fields[7].Value;
                lin:=lin+1;
                SqlAux1.Next;
              end;
            mexcel.WorkBooks[1].SaveAs(EdArq.Text);
            mexcel.WorkBooks[1].Close;
            Finalize(mexcel);
            AssignFile(arq,locarq);
            Rewrite(arq);
            SqlAux1.First;
            dta :=  SqlAux1.Fields[15].AsString;
            while not (SqlAux1.eof) do
              begin
                if (dta =  SqlAux1.Fields[15].AsString) then
                  begin
                    //'%-16.16s%''%8.8d'
                    linha :=  Format('%-2.2s%',[SqlAux1.Fields[11].AsString]);
                    linha :=  linha + Format('%4.4d',[StrToInt(copy(SqlAux1.Fields[1].AsString,1,4))]);
                    linha :=  linha + Format('%-100.100s%',[trim(copy(SqlAux1.Fields[1].AsString,6,75))]);
                    linha :=  linha + Format('%5.5d',[SqlAux1.Fields[10].AsInteger]);
                    linha :=  linha + Format('%-10.10s%',[SqlAux1.Fields[15].AsString]);
                    linha :=  linha + Format('%5.5d',[SqlAux1.Fields[4].AsInteger]);
                    linha :=  linha + Format('%5.5s%',[FormatFloat('#,##0.000;;',SqlAux1.Fields[5].AsFloat)]);
                    linha :=  linha + Format('%-100.100s%',[SqlAux1.Fields[14].AsString]);
                    linha :=  linha + Format('%13.13s%',[FormatFloat('#,##0.00;;',SqlAux1.Fields[7].AsFloat)]);
                    linha :=  linha + FormatDateTime('dd/mm/yyyy',SqlAux1.Fields[3].AsDateTime);
                    linha :=  linha + Format('%-10.10s%',[' ']);
                    linha :=  linha + Format('%-100.100s%',[' ']);
                    Writeln(arq,linha);
                    lin:=lin+1;
                  end
                else
                  begin
                      CloseFile(arq);
                      seqreg:=seqreg+1;
                      locarq  :=  copy(EdArq.Text,1,39)+format('%3.3d',[seqreg])+'.txt';
                      AssignFile(arq,locarq);
                      Rewrite(arq);
                    dta :=  SqlAux1.Fields[15].AsString;
                    SqlAux1.Prior;
                  end;
                SqlAux1.Next;
              end;
            CloseFile(arq);
            Application.MessageBox('Arquivo Gerado','ADS',IDOK);
          except on e: exception do
            begin
              Application.MessageBox (PChar('Erro ao Abrir Ms-Excel: '+e.Message),'ADS',MB_OK+MB_ICONERROR);
              exit;
            end;
          end;
        end;
    end;
end;

procedure TFrmPesqImpSedex.gerlisoltctk;
var
  XL : TDataSetToExcel;
begin
  with Dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add('SELECT DISTINCT t.sdx_siglaobj as "TIPO", t.sdx_numobj2 as "AR", ');
      SqlAux1.SQL.Add('SUBSTR(t.sdx_nomdest, 1, 4) AS "AG.", SUBSTR(t.sdx_nomdest, 7, 40) AS "DESTINO", ') ;
      SqlAux1.SQL.Add('t.sdx_endedest as "ENDERECO", t.sdx_cidade as "CIDADE",');
      SqlAux1.SQL.Add('t.sdx_uf as "UF", t.sdx_cep as "CEP", t.sdx_dtmov as "DATA ENVIO", ');
      SqlAux1.SQL.Add('t.sdx_peso as "PESO" ');
      SqlAux1.SQL.Add('FROM tbsdx02 t ');
      SqlAux1.SQL.Add('    INNER JOIN public.tbsdx_ect e ON (t.sdx_numobj = CAST(e.tbsdxect_num || e.tbsdxect_dv AS INTEGER)) ');
      SqlAux1.SQL.Add('    INNER JOIN public.tbsdxserv s ON (e.tbsdxect_prod = s.tbsdxserv_prod) ');
      SqlAux1.SQL.Add('WHERE s.tbsdxserv_prod = :codproduto ');
      SqlAux1.ParamByName('codproduto').AsInteger := DBServSedex.KeyValue;

      SqlAux1.SQL.Add('AND t.sdx_dtenvio BETWEEN :dt1 and :dt2 ');
      SqlAux1.ParamByName('dt1').AsString :=  FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
      SqlAux1.ParamByName('dt2').AsString :=  FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);

      if (trim(EdSeqFin.Text) <> '') then
        EdSeqFin.Text := EdSeqIni.Text;
        
      if (trim(EdSeqIni.Text) <> '')  and (trim(EdSeqFin.Text) <> '') then
        begin
          SqlAux1.SQL.Add('AND sdx_seqcarga BETWEEN :seq1 AND :seq2 ');
          SqlAux1.ParamByName('seq1').AsInteger   := StrToInt64(EdSeqIni.Text);
          SqlAux1.ParamByName('seq2').AsInteger   := StrToInt64(EdSeqFin.Text);
        end;

      if (Trim(EdArObjeto.Text) <> '') then
        begin
          SqlAux1.SQL.Add('AND sdx_numobj4 = :numobj');
          SqlAux1.ParamByName('numobj').AsString := EdArObjeto.Text;
        end;
        
      SqlAux1.SQL.Add('ORDER BY t.sdx_cep ');
      SqlAux1.Open;
      cab:='LISTA DE POSTAGEM - CONTRATO ESPECIAL - SEDEX: ' +
        SqlSdxServtbsdxserv_sigla.AsString + ' - ' +
        FormatDateTime('ddmmyyyy', DateTimePicker3.Date ) +
        FormatDateTime('hhmmss', DateTimePicker3.Time) +'.xls';

      // Salvando o arquivo
      SaveDialog1.InitialDir := 'o:\sedex_ar\';
      SaveDialog1.FileName := 'Sdx' + SqlSdxServtbsdxserv_sigla.AsString +
        FormatDateTime('ddmmyyyy', DateTimePicker3.Date ) +
        FormatDateTime('hhmmss', DateTimePicker3.Time);

      if (SaveDialog1.Execute) then
        begin
          SqlAux1.First;
          XL := TDataSetToExcel.Create(SqlAux1, EdArq.Text, cab);
          XL.WriteFile;
          XL.Free;
          ShowMessage('Arquivo ' + saveDialog1.Filename + ' criado.');
        end
      else
        ShowMessage('O Arquivo de postagem n�o foi criado.');

    end;
end;

procedure TFrmPesqImpSedex.gerfat;
begin
  with Dm do
    begin
      sel :=  'select DISTINCT sdx_numobj2,sdx_paisorigem,sdx_nomdest,sdx_endedest,sdx_cidade,sdx_uf,sdx_cep,sdx_seqcarga,sdx_numobj5,sdx_dtcarga,cast(substr(sdx_numobj2,3,9) as Integer),sdx_numobj2,sdx_peso,sdx_qtd from tbsdx ';
      //                  0            1               2          3            4         5       6       7         8            9           10                                      11           12       13
      sel :=  sel +  'where (sdx_dtcarga between :dtini and :dtfin) and (sdx_seqcarga between :seqini and :seqfim) order by sdx_cep';
      //Parametros Condicao                         0         1                                 2           3

      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add(sel);
      SqlAux1.Params[0].AsDate :=  DateTimePicker1.Date;
      SqlAux1.Params[1].AsDate :=  DateTimePicker2.Date;
      SqlAux1.Params[2].Value  :=  StrToInt64(EdSeqIni.Text);
      SqlAux1.Params[3].Value  :=  StrToInt64(EdSeqFin.Text);
      SqlAux1.Open;
      //              inputbox('','',selexcel);
      SqlAux1.First;
      seqreg:=2;
      ProgBar.Max :=  SqlAux1.RecordCount;
      ProgBar.Position  := 1;
      ProgBar.Refresh;
      if (SqlAux1.RecordCount > 0) then
        begin
          //StringOfChar(' ',13
          locarq  :=  'O:\sedex_ar\Repasse\';
          //locarq  :=  'C:\';
          if (not (DirectoryExists(locarq))) then
            begin
              Application.MessageBox(PChar('Erro de Conex�o Rede'),'ADS',0);
              exit;
            end;
          dtaux := DateTimePicker1.Date;
          locarq:= locarq+'BRADESCOADDRESS_'+formatdatetime('ddmmyyyy',dtaux)+'.txt';
          EdArq.Text  :=  locarq;
          AssignFile(arq,locarq);
          try
          Rewrite(arq);
          except
            begin
              Application.MessageBox(PChar('N�o Pode Acessar Arquivo'+linha),'ADS',0);
              exit;
            end;
          end;
          linha:='1'+Format('%13.13d%',[0])+formatdatetime('ddmmyyyy',dtaux);
          WriteLn(arq,linha);
          SqlAux1.First;
          while not SqlAux1.Eof do
            begin
            //            nro contrado      codigo do cliente         codigo servi�o                  Data da Carga(Prestacao do Servico)                        Nro do Documento                                Peso do Produto
              linha:= '2'+'9912232238'+format('%11.11d',[0])   +       format('%09.09d',[40622]) + formatdatetime('ddmmyyyy',SqlAux1.Fields[09].AsDateTime)+format('%10.10d%',[SqlAux1.Fields[10].AsInteger])+format('%9.9d%',[StrToInt(RestauraInteger(FormatFloat('00.000',SqlAux1.Fields[12].AsFloat)))]);
              //                    cep destino                                                 servv ad 1 � serv  ad 4    valor declarado
              linha:= linha+format('%5.5d',[ StrToInt(copy(SqlAux1.Fields[06].AsString,1,5))])+format('%8.8d',[0])    +   format('%12.12d',[0]) ; //  .AsString +StringOfChar('0',11)  +  FormatDateTime('ddmmyyyy', SqlAux1.Fields[9].AsDateTime); //SqlAux1.Fields[0].AsString+'1101';
              //              Quantidade � o proprio registro                    Cod Grupo Pais de destino ou zero     Nome Pais Destino                   C�digo Administrativo
              linha:= linha+format('%9.9d',[SqlAux1.Fields[13].AsInteger])  +   format('%2.2d',[0])                   +       format('%-15.15s%',[' ']) + format('%-8.8s%',['09036539']);//
              //              C�digo

//              Cart�o - Cart�o Postagem         Valor Unit�rio             Valor do Servi�o           Unidade de Postagem STO
//              linha:= linha+format('%11.11d%',[60631481])    +   format('%12.12d',[0])   +   format('%12.12d',[0])   +   format('%-08.08s%',['72625058']);// SqlAux1.Fields[5].AsString+SqlAux1.Fields[6].AsString;
              linha:= linha+format('%11.11d%',[61215600])    +   format('%12.12d',[0])   +   format('%12.12d',[0])   +   format('%-08.08s%',['72625007']);// SqlAux1.Fields[5].AsString+SqlAux1.Fields[6].AsString;
              //        N�mero do Lote             C�digo Etiqueta    Nro do Objeto com as siglas       IMP_NU_REGISTRO_ORIGEM      IMP_NU_SISTEMA_ORIGEM
              linha:= linha+format('%9.9d',[15]) + format('%-13.13s',[SqlAux1.Fields[11].AsString])   +  format('%12.12d',[0])   +   format('%-12.12s',[' ']);
              WriteLn(arq,linha);
              Inc(seqreg,1);
              SqlAux1.Next;
              ProgBar.Position  :=  ProgBar.Position + 1;
              ProgBar.Refresh;
            end;
          linha:= '3' + format('%10.10d',[SqlAux1.RecordCount]);
          Writeln(arq,linha);
          CloseFile(arq);
          Application.MessageBox(Pchar('Arquivo Gerado!'),'ADS',ID_OK);
        end
      else
        Application.MessageBox(Pchar('Nenhum Registro Encontrado com esses Parametros!'),'ADS',ID_OK);
    end;
end;
procedure TFrmPesqImpSedex.relpendoltctk;
var  XL : TDataSetToExcel;
begin
  with Dm do
    begin
      sel :=  'select ''CNPJ'' as "TipoDocumento", ''60.746.948/0001-12'' as "CPF/CNPJ",''ADDRESS'' as ';
      sel :=  sel +'"Remetente",''05311-030'' as "CepRemetente",''RUA MERGENTHALER'' as "EnderecoRemetente",';
      sel :=  sel +'''1177'' as "N�Remetente",'''' as "Complemento",''VILA LEOPOLDINA'' as "BairroRemetente",''S�O PAULO'' as ';
      sel :=  sel +'"CidadeRemetente", ''SP'' as "UFRemetente",''BRASIL'' as "PaisRemetente",''11'' as';
      sel :=  sel +'"DDDRemetente",''38390063'' as "TelRemetente",'''' as "FazRemetente",''BANCO BRADESCO'' as "EmpresaRemetente",';
      sel :=  sel +'''expedicao@address.com.br'' as "EmailRemetente",''114'' AS "Servico",''148'' as "Motivo",tbsdx02.sdx_numobj2 ';
      sel :=  sel +' as "CodigoRegistro",''CAIXA'' as "Embalagem",''S'' as "ClientePossuiContrato",tbsdxserv_nrocto as "Contrato",';
      sel :=  sel +chr(39)+'AGENCIA BRADESCO' +chr(39)+ '||sdx_nomdest as "Nome_Destino",sdx_cep as "Cep_Destino",sdx_endedest as "End_Destino",';
      sel :=  sel +chr(39)+chr(39)+'as "Numero_Destino",'''' as "Compl_Dest",'''' as "Bairro_Dest",sdx_cidade as "Cidade_Destino",sdx_uf as "UF_Destino",sdx_paisorigem as "Pais_Dest",';
      sel :=  sel +chr(39)+chr(39)+' as "DDD_Dest",case when ((trim(tbbraddptos.tel) = '''') or (trim(tbbraddptos.tel) is Null)) then '+chr(39)+chr(39);
      sel :=  sel +' else trim(tbbraddptos.tel) end as "Tel",tbbraddptos.tel,''CTE JAGUARE/GCCAP'' as "Agencia_Postagem",';
      sel :=  sel +chr(39)+'S�O PAULO'+chr(39)+' as "Local_Postagem",sdx_dtenvio as "Data_Envio",sdx_valdec as "Valor_Declarado",';
      sel :=  sel +chr(39)+'S'+chr(39)+' as "Aviso_Recebimento",'''' as "Banco_Nome",'''' as "CodigoBanco",'''' as "Agencia",';
      sel :=  sel +chr(39)+chr(39)+' as "Conta",sdx_siglaobj as "Sigla_Objeto",''DADOS DO RECEBEDOR'' as "Obs" ';
      sel :=  sel +'from tbsdx02 ';
      sel :=  sel +'inner join tbbraddptos on to_number(substr(tbsdx02.sdx_nomdest,1,4),''9999'') = cast(tbbraddptos.juncao as char(04)) ';
      sel :=  sel +'inner join tbsdxserv on sdx_siglaobj=tbsdxserv.tbsdxserv_sigla ';
      sel :=  sel +'WHERE (sdx_dtmov between :dtini and :dtfin) AND (sdx_siglaobj = :sigla) and (sdx_dtentrega is null) ';
      sel :=  sel +'ORDER BY sdx_dtmov,sdx_siglaobj,substr(sdx_nomdest,1,4),tbsdxserv_cod';
      //Parametros Condicao                         0         1                                 2           3

      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add(sel);
      //inputbox('','',sel);
      SqlAux1.Params[0].AsDate    :=  DateTimePicker1.Date;
      SqlAux1.Params[1].AsDate    :=  DateTimePicker2.Date;
      SqlAux1.Params[2].AsString  :=  SqlSdxServtbsdxserv_sigla.AsString;
      SqlAux1.Open;
      SqlAux1.First;
      seqreg:=2;
      EdQtde.Text :=  IntToStr(SqlAux1.RecordCount);
      ProgBar.Max :=  SqlAux1.RecordCount;
      ProgBar.Position  := 1;
      ProgBar.Refresh;
      if (SqlAux1.RecordCount > 0) then
        begin
          locarq  :=  'F:\sistemas\arsedexpend';
          if (not (DirectoryExists(locarq))) then
            MkDir(locarq);
          EdArq.Text  :=  locarq+'\Pend'+SqlSdxServtbsdxserv_sigla.AsString+FormatDateTime('ddmmyyyy', DateTimePicker3.Date)+'.xls';
          SqlAux1.First;
          XL := TDataSetToExcel.Create(SqlAux1,EdArq.Text,'0');
          XL.WriteFile;
          XL.Free;
          ShowMessage('Arquivo gerado: '+EdArq.Text);
        end
      else
        Application.MessageBox(Pchar('Nenhum Registro Encontrado com esses Parametros!'),'ADS',ID_OK);
    end;
    DateTimePicker1.SetFocus;
end;

procedure TFrmPesqImpSedex.gerimp2;
var i:integer; s1, s2, s3, dbg, dtfldname : string;
args : Array of String;
lotes : TStringList;
Begin

  // Preenchimento do Per�odo para pesquisa � obrigat�rio
  if (CompareDate(DateTimePicker1.Date, DateTimePicker2.Date) > 0) then
    begin
      ShowMessage('A data final n�o pode ser inferior a data inicial.');
      exit;
    end;

  qtdfxa01 := 0;
  qtdfxa02 := 0;
  qtdfxa03 := 0;
  qtdfxa04 := 0;
  qtdfxa05 := 0;
  qtdfxa06 := 0;
  qtdfxa07 := 0;
  qtdfxa08 := 0;
  qtdfxa09 := 0;
  qtdfxa10 := 0;
  dtfldname := 'sdx_dtcarga'; // Valor padr�o

  if (FrmPesqImpSedex.Tag = 7) then
    dtfldname := 'sdx_dtenvio';

      {
    A impress�o das etiquetas de AR precisam seguir o proposto
    pela opera��o.
    No caso de TOKENS e TANCODES o processo � mais simples, podendo
    ser utilizado filtro por Data + Lote, vinculado ao produto, por�m
    para o OL, que engloba 15 produtos (pagantes) diferentes n�o devemos
    utilizar o filtro por produto, para que seja poss�vel imprimir todas as
    etiquetas de um mesmo lote ou envio.
    Para tanto deve ser permitido filtros mais simples como DATA+LOTE
}
    // SQL B�sica para verifica��o de exist�ncia de elementos a serem impressos
    // Com as condi��es passadas
    sel := 'SELECT COUNT(t.sdx_numobj) AS qt_post, t.sdx_uf, ' +
            'SUBSTRING(t.sdx_cep, 1, 1) as prefixo FROM public.tbsdx02 t ' + #13#10 +
            '    INNER JOIN public.tbsdx_ect e ON (t.sdx_numobj2 = e.tbsdxect_sigla e.tbsdxect_num || e.tbsdxect_dv AS INTEGER)) ' +
            ' INNER JOIN public.tbsdxserv s ON (e.tbsdxect_prod = s.tbsdxserv_prod) ' +
          'WHERE t.' + dtfldname + ' BETWEEN :dt1 AND :dt2 ';
    // Inicializando lista para Campo de N�meros de Lote
    lotes := TStringList.Create;
    // ##### Verificando as condi��es
    // N�mero de Lote preenchido?
    If (Trim(EdSeqIni.Text) <> '') then  // ### N�meros de Lotes
      begin
        lotes.CommaText := Trim(EdSeqIni.Text);
        if (lotes.Count > 0) then
          begin
            sel := sel +
              Format(#13#10 + '   AND t.sdx_seqcarga IN (E' + QuotedStr('%s') +
                DupeString(', E' + QuotedStr('%s'), lotes.Count - 1) + ')',
                [lotes.GetEnumerator]
              );

          end;
      end;

    // N�mero de Objeto Preenchido??
    if (Trim(EdArObjeto.Text) <> '') then
      begin
        sel := sel + Format(#13#10 +
            '  AND sdx_numobj2 = %s ', [QuotedStr(trim(EdArObjeto.Text))]);
      end;

    With dm do
      begin
        // Iniciando intera��o com o Banco
        SqlAux1.Close;
        SqlAux1.SQL.Clear;
        SqlAux1.SQL.Add(sel);
        SqlAux1.ParamByName('dt1').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
        SqlAux1.ParamByName('dt2').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);


        // Produto Preenchido
        if (DBServSedex.KeyValue <> null) then
          begin
            // A lista de produtos ficar�
            if AnsiPos(' OL ', SqlSdxServtbsdxserv_dsc.Value) < 1 then
              begin // Pagantes de TOKEN OU TANCODE
                SqlAux1.SQL.Add('  AND e.tbsdxect_prod = :codproduto ');
                SqlAux1.ParamByName('codproduto').AsInteger := DBServSedex.KeyValue;
              end
            // else // Demais pagantes nao utilizar filtro
          end;

      // Hor�rio de Postagem
      if ((MkEdHrF.Text = '  :  :  ') OR
            (CompareTime(StrToTime(MkEdHrI.Text), StrToTime(MkEdHrF.Text) ) > 0)) then
            begin
              Application.MessageBox(Pchar('Hora Final deve ser maior ou igual a Hora Inicial.'), 'Ads', IDOK);
              exit;
            end;
          SqlAux1.SQL.Add('  AND sdx_horaenvio between :hr1 AND :hr2 ');
          SqlAux1.ParamByName('hr1').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrI.Text));
          SqlAux1.ParamByName('hr2').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrF.Text));







      if ((FrmPesqImpSedex.Tag in [6,7]) and
        (MkEdHrI.Text <> '  :  :  ') ) then
        begin
          if ((MkEdHrF.Text = '  :  :  ') OR
            (CompareTime(StrToTime(MkEdHrI.Text), StrToTime(MkEdHrF.Text) ) > 0)) then
            begin
              Application.MessageBox(Pchar('Hora Final deve ser maior ou igual a Hora Inicial.'), 'Ads', IDOK);
              exit;
            end;
          SqlAux1.SQL.Add('  AND sdx_horaenvio between :hr1 AND :hr2 ');
          SqlAux1.ParamByName('hr1').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrI.Text));
          SqlAux1.ParamByName('hr2').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrF.Text));
        end;

      SqlAux1.SQL.Add('GROUP BY 2, 3');
      SqlAux1.Open;
      if (SqlAux1.RecordCount < 1) then
        begin
          ShowMessage('N�o h� registros com os par�metros informados.');
          exit;
        end;

      while not SqlAux1.Eof do
        begin
          // Delphi n�o tem Switch CASE para Strings
          // Por isso � necess�rio ser criativo para
          // Instru��es que dependem de um valor em uma lista
          s1 := SqlAux1.FieldByName('sdx_uf').AsString;
          if ( s1 = 'SP') then
            if (SqlAux1.FieldByName('prefixo').AsString = '0') then
              qtdfxa01 := qtdfxa01 + SqlAux1.FieldByName('qt_post').AsInteger
            else
              qtdfxa02 := qtdfxa02 + SqlAux1.FieldByName('qt_post').AsInteger
          else if (AnsiIndexStr(s1, ['RJ', 'MG', 'PR', 'SC']) > -1) then
            qtdfxa03 := qtdfxa03 + SqlAux1.FieldByName('qt_post').AsInteger
          else if (AnsiIndexStr(s1, ['ES', 'DF', 'MS', 'RS']) > -1) then
            qtdfxa04 := qtdfxa04 + SqlAux1.FieldByName('qt_post').AsInteger
          else if (AnsiIndexStr(s1, ['GO', 'TO']) > -1) then
            qtdfxa05 := qtdfxa05 + SqlAux1.FieldByName('qt_post').AsInteger
          else if (AnsiIndexStr(s1, ['BA', 'MT']) > -1) then
            qtdfxa06 := qtdfxa06 + SqlAux1.FieldByName('qt_post').AsInteger
          else if (AnsiIndexStr(s1, ['SE', 'AL']) > -1) then
            qtdfxa07 := qtdfxa07 + SqlAux1.FieldByName('qt_post').AsInteger
          else if (AnsiIndexStr(s1, ['PE', 'PB', 'PI', 'RO']) > -1) then
            qtdfxa08 := qtdfxa08 + SqlAux1.FieldByName('qt_post').AsInteger
          else if (s1 = 'RR') then
            qtdfxa10 := qtdfxa10 + SqlAux1.FieldByName('qt_post').AsInteger
          else // Todos os outros [RN, CE, MA, PA, AP, AM, AC
            qtdfxa09 := qtdfxa09 + SqlAux1.FieldByName('qt_post').AsInteger;

          SqlAux1.Next;
        end;
      SqlAux1.Close;
      SqlAux1.SQL.Clear;

      Case FrmPesqImpSedex.Tag  of
        0..2:
          SqlAux1.SQL.Add('SELECT COUNT(t.sdx_codcli) FROM tbsdx t ' +
              'WHERE t.sdx_dtcarga BETWEEN :dt1 AND :dt2 ');

        6..7:
          Begin
            SqlAux1.SQL.Add('SELECT COUNT(t.sdx_codcli) FROM tbsdx02 t ');
            SqlAux1.SQL.Add('    INNER JOIN public.tbsdx_ect e ON (t.sdx_numobj = CAST(e.tbsdxect_num || e.tbsdxect_dv AS INTEGER)) ');
            SqlAux1.SQL.Add('    INNER JOIN public.tbsdxserv s ON (e.tbsdxect_prod = s.tbsdxserv_prod) ');
            SqlAux1.SQL.Add('WHERE s.tbsdxserv_prod = :codproduto ');
            SqlAux1.ParamByName('codproduto').AsInteger := DBServSedex.KeyValue;

            if FrmPesqImpSedex.Tag = 6 then
              SqlAux1.SQL.Add(' AND t.sdx_dtcarga BETWEEN :dt1 AND :dt2 ')
            else
              SqlAux1.SQL.Add(' AND t.sdx_dtenvio BETWEEN :dt1 AND :dt2 ');

            if ((MkEdHrI.Text <> '  :  :  ') and (MkEdHrF.Text <> '  :  :  ')) then
              begin
                SqlAux1.SQL.Add(' AND sdx_horaenvio BETWEEN :hr1 AND :hr2 ');
                SqlAux1.ParamByName('hr1').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrI.Text));
                SqlAux1.ParamByName('hr2').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrF.Text));
              end;
          End;
      End;
      SqlAux1.ParamByName('dt1').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
      SqlAux1.ParamByName('dt2').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);

      Case FrmPesqImpSedex.Tag  of
        0..2:
          Begin
            SqlAux2.Close;
            SqlAux2.SQL.Clear;
            SqlAux2.SQL.Add('SELECT DISTINCT t.sdx_numobj5 FROM tbsdx t ' +
                  'WHERE t.sdx_dtcarga BETWEEN :dt1 AND :dt2 ');
          End;
        6..7:
          Begin
            SqlAux2.Close;
            SqlAux2.SQL.Clear;
            SqlAux2.SQL.Add('SELECT DISTINCT o.sdx_numobj FROM public.tbsdx_ect e ');
            SqlAux2.SQL.Add('INNER JOIN public.tbsdxserv s ON (e.tbsdxect_prod = s.tbsdxserv_prod) ');
            SqlAux2.SQL.Add('INNER JOIN public.tbsdx02 o ON (CAST(e.tbsdxect_num || e.tbsdxect_dv AS INTEGER) = o.sdx_numobj) ');
            SqlAux2.SQL.Add('WHERE s.tbsdxserv_prod = :codproduto ');
            SqlAux2.ParamByName('codproduto').AsInteger := DBServSedex.KeyValue;

            if FrmPesqImpSedex.Tag = 6 then
              SqlAux2.SQL.Add('AND o.sdx_dtcarga BETWEEN :dt1 AND :dt2 ')
            else
              SqlAux2.SQL.Add(' AND o.sdx_dtenvio BETWEEN :dt1 AND :dt2 ');

            if ((MkEdHrI.Text <> '  :  :  ') and (MkEdHrF.Text <> '  :  :  ')) then
              begin
                SqlAux2.SQL.Add(' AND o.sdx_horaenvio BETWEEN :hr1 AND :hr2 ');
                SqlAux2.ParamByName('hr1').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrI.Text));
                SqlAux2.ParamByName('hr2').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrF.Text));
              end;

          End;
      End;
      SqlAux2.ParamByName('dt1').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
      SqlAux2.ParamByName('dt2').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);

      SqlSdx2.Close;
      SqlSdx2.SQL.Clear;
      Case FrmPesqImpSedex.Tag  of
        0..2:
          Begin
            SqlSdx2.SQL.Add('SELECT sdx_codcli, sdx_idcli, sdx_siglaobj, sdx_numobj,');
            SqlSdx2.SQL.Add('sdx_paisorigem, sdx_codoperacao, sdx_numobj3, sdx_nomdest, sdx_endedest, sdx_cidade, ');
            SqlSdx2.SQL.Add('sdx_uf, sdx_cep, sdx_numseqarq, sdx_numseqreg, sdx_dtcarga, sdx_seqcarga, ');
            SqlSdx2.SQL.Add('sdx_numobj2, sdx_cepnet, sdx_numobj1, sdx_numobj4, sdx_numobj5');
            SqlSdx2.SQL.Add('FROM tbsdx WHERE sdx_dtcarga between :dt1 and :dt2 ');
            SqlSdx2.ParamByName('dt1').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
            SqlSdx2.ParamByName('dt2').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);
          End;
        6..7:
          Begin
            SqlSdx3.Close;
            SqlSdx3.SQL.Clear;
            SqlSdx3.SQL.Add('SELECT sdx_codcli, sdx_idcli, sdx_siglaobj, sdx_numobj,');
            SqlSdx3.SQL.Add('sdx_paisorigem, sdx_codoperacao, sdx_numobj3, sdx_nomdest, sdx_endedest, sdx_cidade, ');
            SqlSdx3.SQL.Add('sdx_uf, sdx_cep, sdx_numseqarq, sdx_numseqreg, sdx_dtcarga, sdx_seqcarga, ');
            SqlSdx3.SQL.Add('sdx_numobj2, sdx_cepnet, sdx_numobj1, sdx_numobj4, sdx_numobj5, sdx_peso, sdx_valor, sdx_qtde, sdx_tvalor, sdx_valdec, ');
            SqlSdx3.SQL.Add('p.tbsdxserv_nrocto, p.tbsdxserv_crtpst ');
            SqlSdx3.SQL.Add('FROM public.tbsdx_ect e ');
            SqlSdx3.SQL.Add('  INNER JOIN public.tbsdxserv p ON (e.tbsdxect_prod = p.tbsdxserv_prod) ');
            SqlSdx3.SQL.Add('  INNER JOIN public.tbsdx02 t ON (CAST(e.tbsdxect_num || e.tbsdxect_dv AS INTEGER) = t.sdx_numobj)');
            SqlSdx3.SQL.Add('WHERE p.tbsdxserv_prod = :codproduto ');
            SqlSdx3.ParamByName('codproduto').AsInteger := DBServSedex.KeyValue;

          if FrmPesqImpSedex.Tag = 6 then
            SqlSdx3.SQL.Add('AND sdx_dtcarga BETWEEN :dt1 AND :dt2 ')
          else
            SqlSdx3.SQL.Add('AND t.sdx_dtenvio BETWEEN :dt1 AND :dt2 ');
            SqlSdx3.ParamByName('dt1').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
            SqlSdx3.ParamByName('dt2').AsString := FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);

          if ((MkEdHrI.Text <> '  :  :  ') and (MkEdHrF.Text <> '  :  :  ')) then
            begin
              SqlSdx3.SQL.Add('AND sdx_horaenvio BETWEEN :hr1 AND :hr2 ');
              SqlSdx3.ParamByName('hr1').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrI.Text));
              SqlSdx3.ParamByName('hr2').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrF.Text));
            end;

          End;
      End;

      If ((EdSeqIni.Text <> '') and (EdSeqFin.Text <> ''))  then
        Begin
          // Validando os dados do formul�rio
          if (StrToInt64(EdSeqIni.Text) > StrToInt64(EdSeqFin.Text)) then
            begin
              Application.MessageBox('Informa��es de Sequ�ncia inv�lidos. ' +
                    'Sequencial Final deve ser superior ao sequencial inicial','ADS',IDOK);
              exit;
            end;

          if (Trim(EdSeqIni.Text) <> '') then          
            begin
              if (Trim(EdSeqFin.Text) = '') then
                EdSeqFin.Text := EdSeqIni.Text;
              SqlAux1.SQL.Add(' AND sdx_seqcarga BETWEEN :seq1 AND :seq2');
              SqlAux2.SQL.Add(' AND sdx_seqcarga BETWEEN :seq1 AND :seq2');
              SqlAux1.ParamByName('seq1').AsInteger   := StrToInt64(EdSeqIni.Text);
              SqlAux1.ParamByName('seq2').AsInteger   := StrToInt64(EdSeqFin.Text);
              SqlAux2.ParamByName('seq1').AsInteger   := StrToInt64(EdSeqIni.Text);
              SqlAux2.ParamByName('seq2').AsInteger   := StrToInt64(EdSeqFin.Text);
            end;

          if (Trim(EdArObjeto.Text) <> '') then
            begin
              SqlAux1.SQL.Add(' AND sdx_numobj4 = :numobj ');
              SqlAux2.SQL.Add(' AND sdx_numobj4 = :numobj ');
              SqlAux1.ParamByName('numobj').AsString := EdArObjeto.Text;
              SqlAux2.ParamByName('numobj').AsString := EdArObjeto.Text;
            End;

          Case FrmPesqImpSedex.Tag  of
            0..2:
              Begin
                SqlSdx2.SQL.Add(' AND sdx_seqcarga BETWEEN :seq1 AND :seq2 ');
                SqlSdx2.ParamByName('seq1').AsInteger   := StrToInt64(EdSeqIni.Text);
                SqlSdx2.ParamByName('seq2').AsInteger   := StrToInt64(EdSeqFin.Text);

                if (Trim(EdArObjeto.Text) <> '') then
                  begin
                    SqlSdx2.SQL.Add(' AND sdx_numobj4 = :numobj ');
                    SqlSdx2.ParamByName('numobj').AsString := EdArObjeto.Text;
                  end;

                SqlSdx2.SQL.Add('ORDER BY sdx_cep ');
              End;

            6..7:
              Begin
                if (Trim(EdSeqIni.Text) <> '')  and ( Trim(EdSeqFin.Text) <> '') then
                  begin
                    SqlSdx3.SQL.Add(' AND sdx_seqcarga BETWEEN :seq1 AND :seq2');
                    SqlSdx3.ParamByName('seq1').AsInteger   := StrToInt64(EdSeqIni.Text);
                    SqlSdx3.ParamByName('seq2').AsInteger   := StrToInt64(EdSeqFin.Text);
                  end
                else if (Trim(EdSeqIni.Text) <> '') then
                  begin
                    SqlSdx3.SQL.Add(' AND sdx_seqcarga = :seq1 ');
                    SqlSdx3.ParamByName('seq1').AsInteger   := StrToInt64(EdSeqIni.Text);
                  end
                else if (Trim(EdSeqFin.Text) <> '') then
                  begin
                    SqlSdx3.SQL.Add(' AND sdx_seqcarga = :seq2');
                    SqlSdx3.ParamByName('seq2').AsInteger := StrToInt64(EdSeqFin.Text);
                  end;

                if (Trim(EdArObjeto.Text) <> '') then
                  begin
                    SqlSdx3.SQL.Add('AND sdx_numobj4 = :numobj ');
                    SqlSdx3.ParamByName('numobj').AsString := EdArObjeto.Text;
                  end;

                if ((MkEdHrI.Text <> '  :  :  ') and (MkEdHrF.Text <> '  :  :  ')) then
                  begin
                    SqlSdx3.SQL.Add(' AND sdx_horaenvio BETWEEN :hr1 AND :hr2 ');
                    SqlSdx3.ParamByName('hr1').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrI.Text));
                    SqlSdx3.ParamByName('hr2').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrF.Text));
                  end;

                if FrmPesqImpSedex.Tag = 6 then
                  SqlSdx3.SQL.Add('ORDER BY sdx_nomdest ')
                else
                  SqlSdx3.SQL.Add('ORDER BY sdx_cep ');
              End;
          End;
        End
      Else
        Begin
          if (Trim(EdArObjeto.Text) <> '') then
                begin
                  SqlAux1.SQL.Add(' AND sdx_numobj4 = :numobj ');
                  SqlAux2.SQL.Add(' AND sdx_numobj4 = :numobj ');
                  SqlAux1.ParamByName('numobj').AsString := EdArObjeto.Text;
                  SqlAux2.ParamByName('numobj').AsString := EdArObjeto.Text;
                end;
              SqlAux2.SQL.Add('ORDER BY sdx_numobj');
              Case FrmPesqImpSedex.Tag  of
                0..2:
                  Begin
                    if (Trim(EdArObjeto.Text) <> '') then
                      begin
                        SqlSdx2.SQL.Add('AND sdx_numobj4 = :numobj ');
                       SqlSdx2.ParamByName('numobj').AsString := EdArObjeto.Text;
                      end;
                    SqlSdx2.SQL.Add('ORDER BY sdx_cep ');
                  End;
                6..7:
                  Begin
                    if (Trim(EdArObjeto.Text) <> '') then
                      begin
                        SqlSdx3.SQL.Add('AND sdx_numobj4 = :numobj ');
                        SqlSdx3.ParamByName('numobj').AsString := EdArObjeto.Text;
                      end;
                    if FrmPesqImpSedex.Tag = 6 then
                      begin
                        if DBServSedex.KeyValue = 1953 then
                          SqlSdx3.SQL.Add('ORDER BY sdx_cep ')
                        else
                          SqlSdx3.SQL.Add('ORDER BY sdx_nomdest ')
                      end
                    else
                      SqlSdx3.SQL.Add('ORDER BY sdx_cep ');
                  End;
              End;
          End;
        dbg := SqlAux1.SQL.getText;
        dbg := SqlAux2.SQL.getText;

        SqlAux1.Open;
        SqlAux2.Open;
        Case FrmPesqImpSedex.Tag  of
          0..2:
            begin
              SqlSdx2.Open;
            end;
          6..7:
          begin
            dbg := SqlSdx3.SQL.getText;
            SqlSdx3.Open;
          end;
        End;
        case   FrmPesqImpSedex.Tag of
          0:
           Begin
             Application.CreateForm(TFrmRelArSedex,FrmRelArSedex);
             frmRelArSedex.RLReport1.PreviewModal;
           End;
          1:
           Begin
             Application.CreateForm(TFrmRelArSedexLista,FrmRelArSedexLista);
             qtdar  :=  SqlAux1.Fields[0].Value;
             SqlAux2.Last;
             fxafim  :=  SqlAux2.Fields[0].Text ;
             SqlAux2.First;
             fxaini  :=  SqlAux2.Fields[0].Text;
             totfol  :=  round(qtdar/3);
             FrmRelArSedexLista.RLReport1.PreviewModal;
             FrmRelArSedexLista.RLReport1.Destroy;
             SqlSdx2.First;
             Application.CreateForm(TFrmRlTotalRa,FrmRlTotalRa);
             FrmRlTotalRa.RLRTotalRa.PreviewModal;
             FrmRlTotalRa.RLRTotalRa.Destroy;
           End;
          2:
           Begin
             Application.CreateForm(TFrmRlTotalRa,FrmRlTotalRa);
             FrmRlTotalRa.RLRTotalRa.PreviewModal;
             FrmRlTotalRa.RLRTotalRa.Destroy;
           End;
          6:
            Begin
             Caminho := ExtractFilePath(Application.ExeName);
             
              case OpcRel.ItemIndex of
               0 :
                begin
                 RvRelatorios.ProjectFile := Caminho+'RelatoriosAds.rav';
                 RvRelatorios.ExecuteReport('RpSedexArOl');
                 RvRelatorios.Close;
                end;
               1:
                begin
                  RvRelatorios.ProjectFile := Caminho+'RelatoriosAds01.rav';
                  RvRelatorios.ExecuteReport('RpSedexArOl');
                  RvRelatorios.Close;
                end;
               2:  // Ar Digital
                begin
                  RvRelatorios.ProjectFile := Caminho + 'ARDigital.rav';
                  RvRelatorios.ExecuteReport('RpSedexArOl');
                  RvRelatorios.Close;
                end
               else Application.MessageBox('N�o foi definido','ADS',ID_OK);
              end;
            End;
          7:
             Begin
               SqlAux3.Close;
               SqlAux3.SQL.Clear;
               SqlAux3.SQL.Add('SELECT SUM(t.sdx_peso) AS sdx_peso, SUM(t.sdx_valdec) AS sdx_valdec ');
               SqlAux3.SQL.Add('FROM tbsdx02 t ');
               SqlAux3.SQL.Add('    INNER JOIN public.tbsdx_ect e ON (t.sdx_numobj = CAST(e.tbsdxect_num || e.tbsdxect_dv AS INTEGER)) ');
               SqlAux3.SQL.Add('    INNER JOIN public.tbsdxserv s ON (e.tbsdxect_prod = s.tbsdxserv_prod) ');
               SqlAux3.SQL.Add('WHERE s.tbsdxserv_prod = :codproduto ');
               SqlAux3.ParamByName('codproduto').AsInteger := DBServSedex.KeyValue;

               SqlAux3.SQL.Add('AND t.sdx_dtenvio BETWEEN :dt1 and :dt2 ');
               SqlAux3.ParamByName('dt1').AsString :=  FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
               SqlAux3.ParamByName('dt2').AsString :=  FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);
               if (trim(EdSeqIni.Text) <> '') and (Trim(EdSeqFin.Text) <> '')then
                 begin
                   SqlAux3.SQL.Add(' AND t.sdx_seqcarga BETWEEN :seq1 AND :seq2 ');
                   SqlAux3.ParamByName('seq1').AsInteger   := StrToInt64(EdSeqIni.Text);
                   SqlAux3.ParamByName('seq2').AsInteger   := StrToInt64(EdSeqFin.Text);
                 end;
                if ((MkEdHrI.Text <> '  :  :  ') and (MkEdHrF.Text <> '  :  :  ')) then
                  begin
                    SqlAux3.SQL.Add(' AND t.sdx_horaenvio BETWEEN :hr1 AND :hr2 ');
                    SqlAux3.ParamByName('hr1').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrI.Text));
                    SqlAux3.ParamByName('hr2').AsString := FormatDateTime('hh:mm:ss', StrToTime(MkEdHrF.Text));
                  end;
               if (Trim(EdArObjeto.Text) <> '') then
                begin
                  SqlAux3.SQL.Add(' AND t.sdx_numobj4 = :numobj ');
                  SqlAux3.ParamByName('numobj').AsString := EdArObjeto.Text;
                end;

               SqlAux3.Open;

               Application.CreateForm(TFrmRelArSedexListaOL, FrmRelArSedexListaOL);
               qtdar  :=  SqlAux1.Fields[0].Value;
               SqlAux2.Last;
               fxafim  :=  SqlAux2.Fields[0].Text;
               SqlAux2.First;
               fxaini  :=  SqlAux2.Fields[0].Text;
               totfol  :=  round(qtdar/3);
               FrmRelArSedexListaOL.RLReport1.PreviewModal;
               FrmRelArSedexListaOL.RLReport1.Destroy;
               SqlSdx3.First;
               gerlisoltctk;
             End;
        End;
     End;
end;

end.

