unit U_PreCadToken;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExcelXP, StdCtrls, ExtCtrls, ComCtrls,  Buttons, ShlObj,
  OleConst,SysConst, Types, OfficeXP,ComObj, ActiveX,  DB, Math,OleServer;

type
  TFrmPreCadToken = class(TForm)
    ScrollBox1: TScrollBox;
    EdErro: TEdit;
    Panel1: TPanel;
    BtnFechar: TBitBtn;
    StBr: TStatusBar;
    Ednumlote: TEdit;
    OpenArq: TOpenDialog;
    ExcelApplication1: TExcelApplication;
    Panel2: TPanel;
    StrGridDados: TStringGrid;
    EdLocal: TEdit;
    BtnAbrir: TBitBtn;
    BtnLeitura: TBitBtn;
    BtnSalvar: TBitBtn;
    Panel3: TPanel;
    EdQtdreg: TEdit;
    Panel4: TPanel;
    EdGrava: TEdit;
    StrGridErro: TStringGrid;
    RdGrpOpc: TRadioGroup;
    Panel5: TPanel;
    Panel6: TPanel;
    Bevel1: TBevel;
    Lbl001: TLabel;
    procedure BtnAbrirClick(Sender: TObject);
    procedure BtnLeituraClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lertk;
    procedure lertc;
    procedure lerol;
    procedure gravaol;
    procedure gravatk;
    procedure gravatc;
    procedure crgtk;
    procedure lertb;
    procedure gravatb;
  private
    WorkBk : _WorkBook;
    WorkSheet : _WorkSheet;
    v_soma,K, X, Y,K1,R1,t : Integer;
    RangeMatrix : Variant;
    FileName : WideString;
    WorkSheet2 : _WorkSheet;
    mcep,cepr,seldup,agant,insere:string;
    numobj,novolote,lin:string;
    dtmov : TDate;
    arq:    TextFile;

    doc,plan,OpenOffice, OpenDesktopOppenOffice, calcopen, sheetsOpen, sheetopen,corerefl,param: Variant;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPreCadToken: TFrmPreCadToken;

implementation

uses DmDados, U_Func;

{$R *.dfm}

procedure TFrmPreCadToken.BtnAbrirClick(Sender: TObject);
begin
  if FrmPreCadToken.Tag = 3 then
    OpenArq.Filter  :=  '*.*';
  OpenArq.Execute;
  EdLocal.Text := OpenArq.FileName;
end;

procedure TFrmPreCadToken.BtnLeituraClick(Sender: TObject);
begin
  t:= 0;
  Lbl001.Caption  :='';
  if (trim(EdLocal.Text) = '') then
    begin
      Application.MessageBox('Escolha Um Arquivo! ','Ads',MB_OK+MB_ICONERROR);
      BtnAbrir.SetFocus;
      exit;
    end;
  EdQtdreg.Text :=  '0';
  EdErro.Text   :=  '0';
  case FrmPreCadToken.Tag of
    0: lertk;
    1: lerol;
    2: lertc;
    3: crgtk;
    4: lertb;
  end;
end;
procedure TFrmPreCadToken.lertk;
var R:Integer;
begin
  with dm do
    begin
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('select count(tbsdxect_num) from tbsdx_ect where (tbsdx_use is null) and (tbsdxect_prod = :prod)');
      SqlAux2.Params[00].AsString  :=  '1';//
      SqlAux2.Open;
      if (SqlAux2.Fields[0].Value > 0) and (SqlAux2.Fields[0].Value <= 200) then
        Application.MessageBox(PChar('Solicitar ao Correio Novo Range'+chr(10)+'Cont�m 200 ou menos'),'ADS',ID_OK)
      else if (SqlAux2.Fields[0].Value = 0) then
        begin
          Application.MessageBox(PChar('N�o H� Mais Range para esse Produto!'),'ADS',ID_OK);
          BtnAbrir.Enabled :=  false;
          exit;
        end;
    end;
    BtnAbrir.Enabled :=  false;
    FileName := Trim(Edlocal.Text);
    ExcelApplication1.Connect;
    Try
      ExcelApplication1.Workbooks.Open(fileName,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,0);
      WorkBk := ExcelApplication1.WorkBooks.Item[1];
      WorkSheet := WorkBk.WorkSheets.Get_Item(1) as _WorkSheet;
      WorkSheet.Cells.SpecialCells(xlCellTypeLastCell,EmptyParam).Activate;
      X := ExcelApplication1.ActiveCell.Row;
      Y := 10;
      StrGridDados.ColCount := Y;
      RangeMatrix := ExcelApplication1.Range['A1',ExcelApplication1.Cells.Item[X,Y]].Value2;
      // RangeMatrix := ExcelApplication1.Range['A1',
      ExcelApplication1.Quit;
    Finally
      ShowMessage(FileName);
      ExcelApplication1.Disconnect;
    End;
    K := 2;
    repeat
      for R := 1 to Y do
        begin
         If (K = 2) Then
          StrGridDados.Cells[(R-1),(K-1)] := trim(RangeMatrix[K,R])
         else
          begin
            if (trim(RangeMatrix[K,R]) <> '') then
              StrGridDados.Cells[(R-1),(K-1)] := trim(RangeMatrix[K,R]);
            if r = 1 then
              begin
                if ((trim(RangeMatrix[K,2]) <> '') and (vernum(trim(RangeMatrix[K,2])) = true) and (k>3)) and
                   ((trim(RangeMatrix[K,4]) <> '') and (vernum(trim(RangeMatrix[K,4])) = true) and (k>3)) then
                  Inc(t,1)
                else if (((trim(RangeMatrix[K,2]) = '') or (vernum(trim(RangeMatrix[K,2])) = false)) and (k>3)) then
                  begin
                    StrGridErro.Cells[(R-1),(K-1)] := 'Erro Linha: '+ IntToStr(k)+' Coluna: B';
                    EdErro.Text :=  IntToStr(StrToInt(EdErro.Text)+1);
                  end
                else if (((trim(RangeMatrix[K,4]) = '') or (vernum(trim(RangeMatrix[K,4])) = false)) and (k>3)) then
                  begin
                    StrGridErro.Cells[(R-1),(K-1)] := 'Erro Linha: '+ IntToStr(k)+' Coluna: D';
                    EdErro.Text :=  IntToStr(StrToInt(EdErro.Text)+1);
                  end;
              end;
          end;
        end;
      Inc(K,1);
      StrGridDados.RowCount := ((K + 1)-2);
      StrGridDados.Refresh;
    until
    K > X;
    RangeMatrix := Unassigned;
//    EdQtdreg.Text := IntToStr(t div y);
    EdQtdreg.Text := IntToStr(t);
    EdQtdreg.Refresh;
    if (X-1) > 0 then
      begin
        BtnSalvar.Enabled := true;
        BtnLeitura.Enabled := false;
      end;
end;

procedure TFrmPreCadToken.FormShow(Sender: TObject);
begin
  if (FrmPreCadToken.Tag in[0..2,4]) then
    begin
      Lbl001.Color  :=  $00FEE39C;
      Lbl001.Visible:=  false;
      StrGridErro.Cells[0,0] :=  'C�digo';
      StrGridErro.Cells[1,0] :=  'Ag�ncia';
      StrGridErro.Cells[2,0] :=  'Objeto';
      StrGridErro.Cells[3,0] :=  'Lote';
    end;
  if (FrmPreCadToken.Tag in[3]) then
      BtnLeitura.Caption  := 'Grava';
end;

procedure TFrmPreCadToken.BtnSalvarClick(Sender: TObject);
begin
  K  := 1;
  K1 := 1;
  R1 := 0;
  EdGrava.Text :=  '0';
  case FrmPreCadToken.tag of
    0:  gravatk;
    1:  gravaol;
    2:  gravatc;
    4:  gravatb;
  end;
  if (trim(Ednumlote.Text) <> '0') and (trim(Ednumlote.Text) <> '') then
    begin
      Lbl001.Visible  :=  true;
      Lbl001.Color    :=  clRed;
      Lbl001.Font.Size  :=  12;
      Lbl001.Font.Style :=  [fsBold];
      Lbl001.Caption  :=  'Anote os N� Lote: '+trim(Lbl001.Caption)+Ednumlote.Text;
    end;
end;
procedure TFrmPreCadToken.gravatk;
begin
  if (trim(EdErro.Text) <> '0') then
    begin
      Application.MessageBox('Erro na Planilha, verificar','ADS',IDOK);
      BtnSalvar.Enabled   :=    false;
      BtnLeitura.Enabled  :=  true;
      EdErro.Text  :=  '0';
      exit;
    end;
  K:=3;
  x:=1;
  with dm do
    begin
      repeat
        try
        strtoint(trim(StrGridDados.Cells[1,k]));
        VirgPonto2(trim(StrGridDados.Cells[8,k]));
        strtoint(trim(StrGridDados.Cells[3,k]));
        except on e:exception do
          begin
            EdErro.Text := IntToStr(strtoint(EdErro.Text)+1);
            EdErro.Refresh;
            StrGridErro.Cells[R1,K1]   :=  trim(StrGridDados.Cells[0,k]);
            StrGridErro.Cells[R1+1,K1] :=  trim(StrGridDados.Cells[1,k]);
            StrGridErro.Cells[R1+2,K1] :=  trim(StrGridDados.Cells[7,k]);
            StrGridErro.Cells[R1+3,K1] :=  trim(Ednumlote.Text);
            StrGridErro.RowCount := K1 + 1;
            StrGridErro.Refresh;
          end;
        end;
        Inc(k,1);
        Inc(x,1);
      until
      x > StrToInt(EdQtdreg.Text);
      if (strtoint(trim(EdErro.Text)) > 0) then
        begin
          application.MessageBox(PChar('Erro na Planilha, verificar!'),'Ads',MB_OK+MB_ICONERROR);
          BtnSalvar.Enabled  :=  false;
          BtnFechar.Enabled := true;
          exit;
        end;


      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('select count(tbsdxect_num) from tbsdx_ect where (tbsdx_use is null) and (tbsdxect_prod = :prod)');
      SqlAux2.Params[00].AsString  :=  '2241';//
      SqlAux2.Open;
      if (SqlAux2.Fields[0].AsInteger > 0) and (SqlAux2.Fields[0].AsInteger < StrtoInt(EdQtdreg.Text)) then
        begin
          Application.MessageBox(PChar('Solicitar ao Correio Novo Range'+chr(10)+'Cont�m menos que Qtde de Regs.'),'ADS',ID_OK);
          BtnSalvar.Enabled :=  false;
          exit;
        end;

      case RdGrpOpc.ItemIndex of
      0:
        begin
           SqlAux1.Close;
           SqlAux1.SQL.Clear;
           SqlAux1.SQL.Add('select max(cg77_numlote) from cga77');
           SqlAux1.Open;
           Ednumlote.Text   :=  IntToStr(SqlAux1.Fields[0].AsInteger+1);
           Ednumlote.Refresh;
        end;
       1:
         begin
           Ednumlote.Enabled := true;
           Ednumlote.SetFocus;
         end;
      end;
      case strtoint64(trim(Ednumlote.Text)) of
      0:
        begin
          application.MessageBox(PChar('Digite o n� do Lote !'),'Ads',MB_OK+MB_ICONINFORMATION);
          Ednumlote.Enabled := true;
          Ednumlote.SetFocus;
        end;
      else
        begin
          agant :=  '';
          K:=3;
          x:=1;
          repeat
            Begin
              if (trim(StrGridDados.Cells[1,k]) <> '') then
                begin
                  seldup :=  'select count(cg77_dtb) from cga77 where (cg77_dtb = :dtb) and (cg77_ag = :ag) ';
                  seldup :=  seldup + 'and (cg77_numlote = :numlote) and (cg77_tokini > :tokini)';
                  SqlAux1.Close;
                  SqlAux1.SQL.Clear;
                  SqlAux1.SQL.Add(seldup);
                  SqlAux1.Params[0].Value := trim(StrGridDados.Cells[7,K]);
                  SqlAux1.Params[1].Value := trim(StrGridDados.Cells[1,k]);
                  SqlAux1.Params[2].Value := gerant(trim(Ednumlote.Text),6);
                  SqlAux1.Params[3].Value := 0;
                  SqlAux1.Open;
                  if (SqlAux1.Fields[0].Value = null) then
                    Begin
                     EdErro.Text := IntToStr(strtoint(EdErro.Text)+1);
                      EdErro.Refresh;
                      StrGridErro.Cells[R1,K1]   :=  trim(StrGridDados.Cells[0,k]);
                      StrGridErro.Cells[R1+1,K1] :=  trim(StrGridDados.Cells[1,k]);
                      StrGridErro.Cells[R1+2,K1] :=  trim(StrGridDados.Cells[7,k]);
                      StrGridErro.Cells[R1+3,K1] :=  trim(Ednumlote.Text);
                      StrGridErro.RowCount := K1 + 1;
                      StrGridErro.Refresh;
                      Inc(K1,1);
                    End
                  Else
                    Begin
                      SqlAux3.Close;
                      SqlAux3.SQL.Clear;
                      SqlAux3.SQL.Add('select min(tbsdxect_num),tbsdxect_dv from tbsdx_ect where (tbsdxect_prod = ''1'') and (tbsdx_use is null) group by tbsdxect_num,tbsdxect_dv order by tbsdxect_num limit 1');
                      SqlAux3.Open;
                      numobj:= SqlAux3.Fields[0].AsString+SqlAux3.Fields[1].AsString;
                      SqlTbBradDeptos.Close;
                      SqlTbBradDeptos.SQL.Clear;
                      SqlTbBradDeptos.SQL.Add('select * from tbbraddptos where (juncao = :juncao) limit 1');
                      SqlTbBradDeptos.Params[0].AsString  :=  trim(StrGridDados.Cells[1,k]);
                      SqlTbBradDeptos.Open;
                      insere  :='insert into cga77 (cg77_dtb,cg77_ag,cg77_qtd,cg77_numlote,cg77_status,';
                      insere  :=insere  + 'cg77_tokini,cg77_tokfin) values (:dtb,:ag,:qtd,:numlote,';
                      insere  :=insere  + ':status,:tokini,:tokfin)';
                      SqlAux2.Close;
                      SqlAux2.SQL.Clear;
                      SqlAux2.SQL.Add(insere);
                      SqlAux2.Params[0].Value := SqlAux3.Fields[0].AsString+SqlAux3.Fields[1].AsString;
                      SqlAux2.Params[1].Value := trim(StrGridDados.Cells[1,k]);
                      SqlAux2.Params[2].Value := strtoint(trim(StrGridDados.Cells[3,k]));
                      if  agant =  trim(StrGridDados.Cells[1,k]) then
                        begin
                          novolote  :=  IntToStr(StrToInt(Ednumlote.Text)+1);
                          SqlAux2.Params[3].Value := gerant(novolote,6);
                          Lbl001.Caption  :=  Lbl001.Caption+novolote+ ' - '+trim(StrGridDados.Cells[1,k])+ ' - ';
                        end
                      else
                        SqlAux2.Params[3].Value := gerant(trim(Ednumlote.Text),6);
                      agant :=  trim(StrGridDados.Cells[1,k]);
                      SqlAux2.Params[4].Value := '0';
                      SqlAux2.Params[5].Value := '0';
                      SqlAux2.Params[6].Value := '0';
                      try
                        SqlAux2.ExecSQL;
                        EdGrava.Text := inttostr(strtoint(EdGrava.Text)+1);
                        EdGrava.Refresh;
                        SqlAux1.Close;
                        SqlAux1.SQL.Clear;
                        SqlAux1.SQL.Add('update tbsdx_ect set tbsdx_use = ''S'' where (tbsdxect_num = :num)');
                        SqlAux1.Params[0].AsString  :=  SqlAux3.Fields[0].AsString;
                        SqlAux1.ExecSQL;
                        SqlAux1.Close;
                        SqlAux1.SQL.Clear;
                        SqlAux1.SQL.Add('insert into tbsdx02 ');
                        SqlAux1.SQL.Add('(sdx_codcli,sdx_idcli,sdx_siglaobj,sdx_numobj,sdx_paisorigem,');
                        SqlAux1.SQL.Add('sdx_numobj4,sdx_nomdest,sdx_endedest,sdx_cidade,sdx_uf,');
                        SqlAux1.SQL.Add('sdx_cep,sdx_numseqarq,sdx_numseqreg,sdx_dtcarga,sdx_numobj2,');
                        SqlAux1.SQL.Add('sdx_numobj1,sdx_codusu,sdx_valdec,sdx_seqcarga,sdx_qtprod,sdx_dtmov) ');
                        SqlAux1.SQL.Add('values (');
                        //                              0     1
                        SqlAux1.SQL.Add('99,''99'',:sigla,:numobj,''BR'',');
                        //                  2       3         4         5       6
                        SqlAux1.SQL.Add(':numobj4,:nomdest,:enddest,:ciddest,:ufdest,');
                        //                  7            8                            9
                        SqlAux1.SQL.Add(':cepdest,99,:numreg,(select current_date),:numobj2,');
                        //                  10      11       12          13           14      15
                        SqlAux1.SQL.Add(':numobj1,:codusu,:sdx_valdec,:sdx_seqcarga,:qtprod,:sdx_dtmov)');
                        SqlAux1.Params[00].AsString  :=  'KE';//alterado confomr e-mail correios 'TK';//
                        SqlAux1.Params[01].AsString  :=  numobj;
                        SqlAux1.Params[02].AsString  :=  'AR'+ numobj + 'KE'; //'TK';//
                        if (SqlTbBradDeptos.RecordCount = 0) then
                          SqlAux1.Params[03].AsString  :=  gerant(trim(StrGridDados.Cells[1,k]),4)
                        else
                          SqlAux1.Params[03].AsString  :=  gerant(SqlTbBradDeptosjuncao.AsString,4)+': '+SqlTbBradDeptosdepto.AsString;
                        SqlAux1.Params[04].AsString  :=  SqlTbBradDeptosender.AsString;
                        SqlAux1.Params[05].AsString  :=  SqlTbBradDeptoscidade.Text;
                        SqlAux1.Params[06].AsString  :=  SqlTbBradDeptosuf.Text;
                        SqlAux1.Params[07].AsString  :=  copy(SqlTbBradDeptoscep.Text,1,5)+copy(SqlTbBradDeptoscep.Text,7,3);
                        SqlAux1.Params[08].AsString  :=  gerant(inttostr(random(999)),3)+FormatDateTime('yyyymmdd',date)+FormatDateTime('hhmmss',Time)+GeraNT(sqlcga_acessocodigo.AsString,4)+gerant(inttostr(random(999)),3);
//                        SqlAux1.Params[09].AsString  :=  'SL'+ numobj + 'BR';
                        SqlAux1.Params[09].AsString  :=  'DL'+ numobj + 'BR';

                        SqlAux1.Params[10].AsString  :=  'AR'+ numobj + 'KE'; //'TK';//
                        SqlAux1.Params[11].AsString  :=  sqlcga_acessocodigo.AsString;
                        SqlAux1.Params[12].AsString  :=  VirgPonto2(trim(StrGridDados.Cells[8,k]));
                        SqlAux1.Params[13].AsString  :=  trim(Ednumlote.Text);
                        SqlAux1.Params[14].Value     :=  strtoint(trim(StrGridDados.Cells[3,k]));
//                        strtodate(copy(StrGridDados.Cells[4,k],7,4)+'/'+copy(StrGridDados.Cells[4,k],4,2)+'/'+copy(StrGridDados.Cells[4,k],1,2));
                      SqlAux1.Params[15].Text    :=   StrGridDados.Cells[4,k];
                        SqlAux1.ExecSQL;
                      except on e: exception do
                        begin
                          application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                          EdErro.Text := IntToStr(strtoint(EdErro.Text)+1);
                          EdErro.Refresh;
                          StrGridErro.Cells[R1,K1]   :=  trim(StrGridDados.Cells[1,k]);
                          StrGridErro.Cells[R1+1,K1] :=  trim(StrGridDados.Cells[2,k]);
                          StrGridErro.Cells[R1+2,K1] :=  trim(StrGridDados.Cells[7,k]);
                          StrGridErro.Cells[R1+3,K1] :=  trim(Ednumlote.Text);
                          StrGridErro.RowCount := K1 + 1;
                          StrGridErro.Refresh;
                        end;
                      end;
                      Inc(K,1);
                      Inc(x,1);
                      StrGridDados.RowCount := K + 1;
                      StrGridDados.Refresh;
                    end;
                end
              else
                Inc(K,1);
            end;
          until
          x > StrToInt(EdQtdreg.Text);
          if (strtoint(trim(EdErro.Text)) > 0) then
            application.MessageBox(PChar('Registros com erros Verificar!'),'Ads',MB_OK+MB_ICONERROR)
          else
            application.MessageBox(PChar('Registros Gravados com Sucesso!'),'Ads',MB_OK+MB_ICONERROR);
          BtnSalvar.Enabled  :=  false;
          BtnFechar.Enabled := true;
        end;
      end;
    end;
end;

procedure TFrmPreCadToken.BtnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFrmPreCadToken.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with dm do
    begin
    SqlAux1.Close;
    SqlAux2.Close
    end;
  action := cafree;
end;
procedure TFrmPreCadToken.lertc;
var i:Integer;
begin
  with dm do
    begin
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('select count(tbsdxect_num) from tbsdx_ect where (tbsdx_use is null) and (tbsdxect_prod = :prod)');
      SqlAux2.Params[00].AsString  :=  '0';//
      SqlAux2.Open;
      if (SqlAux2.Fields[0].Value > 0) and (SqlAux2.Fields[0].Value <= 200) then
        Application.MessageBox(PChar('Solicite aod Correiod Novo Range'+chr(10)+'Cont�m 200 ou menos'),'ADS',ID_OK)
      else if (SqlAux2.Fields[0].Value > 0) and (SqlAux2.Fields[0].Value <= 200) then
        begin
          Application.MessageBox(PChar('N�o H� Mais Range para esse Produto!'),'ADS',ID_OK);
          BtnAbrir.Enabled :=  false;
          exit;
        end;
    end;
    BtnAbrir.Enabled :=  false;
    FileName := Trim(Edlocal.Text);
  doc:= strtran(filename,'\', '/');
  doc := 'file:///'+doc;
  OpenOffice:=CreateOleObject('com.sun.star.ServiceManager');
  OpenDesktopOppenOffice:=OpenOffice.CreateInstance('com.sun.star.frame.Desktop');
  param          := VarArrayCreate([0, -1],varVariant);
  //  param[0]:=CriaParam('Hidden',True);

  doc:= OpenDesktopOppenOffice.LoadComponentFromUrl(doc,'_blank',0,param);
  plan  := doc.Sheets.GetByIndex(0);
  x:=  0;
  y:=  10;
  k:=  1;
  StrGridDados.ColCount := Y;
  if (trim(plan.getCellByPosition(1,k).String) <> '') then
    begin
      Application.MessageBox('Erro na Planilha,1� Linha tem que estar em branco','ADS',ID_OK);
      exit;
    end;

  k:=2;
  while (trim(plan.getCellByPosition(1,k).String) <> '') do
    begin
      if k > 2 then
        begin
          if (trim(plan.getCellByPosition(3,k).String) <> '') and
          ( StrToInt(plan.getCellByPosition(3,k).String ) > 0)  then
            Inc(x,1)
          else
            EdErro.Text :=  IntToStr(StrToInt(EdErro.Text)+1);
        end;
      Inc(k,1);
    end;
  k:=2;
  EdQtdreg.Text  :=  IntToStr(x);
  while trim(plan.getCellByPosition(1,k).String) <> '' do
    begin
      for i := 0 to Y do
        begin
          If (K = 2) Then
            StrGridDados.Cells[(i),(k-2)] := trim(plan.getCellByPosition(i,k).String)
          else if (i = 8) then
                StrGridDados.Cells[(i),(k-2)] := trim(plan.getCellByPosition(i,k).Value)
          else if (trim(plan.getCellByPosition(i,k).String) <> '') then
                StrGridDados.Cells[(i),(k-2)] := trim(plan.getCellByPosition(i,k).String);
        end;
      Inc(K,1);
//      StrGridDados.RowCount := ((K + 1)-2);
      StrGridDados.Refresh;
    end;
//    K > X;
//    RangeMatrix := Unassigned;
//    EdQtdreg.Text := IntToStr(t div y);
    EdQtdreg.Refresh;
    if (StrToInt(EdErro.Text) = 0) and (StrToInt(EdQtdreg.Text) > 0)  then
      begin
        BtnSalvar.Enabled := true;
        BtnLeitura.Enabled := false;
      end
    else
        Application.MessageBox('Verificar Erro na planilha','ADS',ID_OK);

end;


//******** ol
procedure TFrmPreCadToken.lerol;
var i:Integer;
begin
  with dm do
    begin
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('select count(tbsdxect_num) from tbsdx_ect where (tbsdx_use is null) and (tbsdxect_prod = :prod)');
      SqlAux2.Params[00].AsString  :=  '0';//
      SqlAux2.Open;
      if (SqlAux2.Fields[0].Value > 0) and (SqlAux2.Fields[0].Value <= 200) then
        Application.MessageBox(PChar('Informe ao CPD para Solicitar ao Correio Novo Range'+chr(10)+'Cont�m 200 ou menos'),'ADS',ID_OK)
      else if (SqlAux2.Fields[0].Value > 0) and (SqlAux2.Fields[0].Value <= 200) then
        begin
          Application.MessageBox(PChar('N�o H� Mais Range para esse Produto!'),'ADS',ID_OK);
          BtnAbrir.Enabled :=  false;
          exit;
        end;
    end;
    BtnAbrir.Enabled :=  false;
    FileName := Trim(Edlocal.Text);
  doc:= strtran(filename,'\', '/');
  doc := 'file:///'+doc;
  OpenOffice:=CreateOleObject('com.sun.star.ServiceManager');
  OpenDesktopOppenOffice:=OpenOffice.CreateInstance('com.sun.star.frame.Desktop');
  param          := VarArrayCreate([0, -1],varVariant);
  //  param[0]:=CriaParam('Hidden',True);

  doc:= OpenDesktopOppenOffice.LoadComponentFromUrl(doc,'_blank',0,param);
  plan  := doc.Sheets.GetByIndex(0);
  x:=  0;
  y:=  10;
  k:=  1;
  StrGridDados.ColCount := Y;
  if (trim(plan.getCellByPosition(1,k).String) <> '') then
    begin
      Application.MessageBox('Erro na Planilha,1� Linha tem que estar em branco','ADS',ID_OK);
      exit;
    end;

  k:=2;
  while (trim(plan.getCellByPosition(1,k).String) <> '') do
    begin
      if k > 2 then
        begin
          if (trim(plan.getCellByPosition(3,k).String) <> '') and
          ( StrToInt(plan.getCellByPosition(3,k).String ) > 0)  then
            Inc(x,1)
          else
            EdErro.Text :=  IntToStr(StrToInt(EdErro.Text)+1);
        end;
      Inc(k,1);
    end;
  k:=2;
  EdQtdreg.Text  :=  IntToStr(x);
  while trim(plan.getCellByPosition(1,k).String) <> '' do
    begin
      for i := 0 to Y do
        begin
          If (K = 2) Then
            StrGridDados.Cells[(i),(k-2)] := trim(plan.getCellByPosition(i,k).String)
          else if (i = 8) then
                StrGridDados.Cells[(i),(k-2)] := trim(plan.getCellByPosition(i,k).Value)
          else if (trim(plan.getCellByPosition(i,k).String) <> '') then
                StrGridDados.Cells[(i),(k-2)] := trim(plan.getCellByPosition(i,k).String);
        end;
      Inc(K,1);
//      StrGridDados.RowCount := ((K + 1)-2);
      StrGridDados.Refresh;
    end;
//    K > X;
//    RangeMatrix := Unassigned;
//    EdQtdreg.Text := IntToStr(t div y);
    EdQtdreg.Refresh;
    if (StrToInt(EdErro.Text) = 0) and (StrToInt(EdQtdreg.Text) > 0)  then
      begin
        BtnSalvar.Enabled := true;
        BtnLeitura.Enabled := false;
      end
    else
        Application.MessageBox('Verificar Erro na planilha','ADS',ID_OK);

end;
//****************** fim ol

//********** Inicio Grava OL
procedure TFrmPreCadToken.gravaol;
begin
  K:=1;
  x:=1;
  Ednumlote.Text   :=  IntToStr(Random(99))+gerant(formatdatetime('hhmm',Time),4);
  Ednumlote.Refresh;

  with dm do
    begin
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('select count(tbsdxect_num) from tbsdx_ect where (tbsdx_use is null) and (tbsdxect_prod = :prod)');
      SqlAux2.Params[00].AsString  :=  '1660';//
      SqlAux2.Open;
      if (SqlAux2.Fields[0].AsInteger > 0) and (SqlAux2.Fields[0].AsInteger < StrToInt(EdQtdreg.Text)) then
        begin
          Application.MessageBox(PChar('Solicitar ao Correio Novo Range'+chr(10)+'Cont�m menos que Qtde de Regs.'),'ADS',ID_OK);
          BtnSalvar.Enabled :=  false;
          exit;
        end;

      case RdGrpOpc.ItemIndex of
        0:
          begin
            Ednumlote.Text   :=  IntToStr(Random(99))+gerant(formatdatetime('hhmm',Time),4);
            Ednumlote.Refresh;
          end;
         1:
           begin
             Ednumlote.Enabled := true;
             Ednumlote.SetFocus;
           end;
      end;
      case strtoint64(trim(Ednumlote.Text)) of
      0:
        begin
          application.MessageBox(PChar('Digite o n� do Lote !'),'Ads',MB_OK+MB_ICONINFORMATION);
          Ednumlote.Enabled := true;
          Ednumlote.SetFocus;
        end;
      else
        begin
          agant :=  '';
          repeat
            Begin
              SqlAux3.Close;
              SqlAux3.SQL.Clear;
              SqlAux3.SQL.Add('select min(tbsdxect_num),tbsdxect_dv from tbsdx_ect where (tbsdxect_prod = ''1660'') and (tbsdx_use is null) group by tbsdxect_num,tbsdxect_dv order by tbsdxect_num limit 1');
              SqlAux3.Open;
              numobj:= SqlAux3.Fields[0].AsString+SqlAux3.Fields[1].AsString;
              SqlTbBradDeptos.Close;
              SqlTbBradDeptos.SQL.Clear;
              SqlTbBradDeptos.SQL.Add('select * from tbbraddptos where (juncao = :juncao) limit 1');
              SqlTbBradDeptos.Params[0].AsString  :=  trim(StrGridDados.Cells[1,k]);
              SqlTbBradDeptos.Open;
              if  (agant =  trim(StrGridDados.Cells[1,k])) and (k>=2)then
                begin
                  novolote  :=  IntToStr(StrToInt(Ednumlote.Text)+1);
                  Lbl001.Caption  :=  Lbl001.Caption+novolote+ ' - '+trim(StrGridDados.Cells[1,k])+ ' - ';
                end;

              agant :=  trim(StrGridDados.Cells[1,k]);
              SqlAux1.SQL.Clear;
              SqlAux1.SQL.Add('insert into tbsdx02 ');
              SqlAux1.SQL.Add('(sdx_codcli,sdx_idcli,sdx_siglaobj,sdx_numobj,sdx_paisorigem,');
              SqlAux1.SQL.Add('sdx_numobj4,sdx_nomdest,sdx_endedest,sdx_cidade,sdx_uf,');
              SqlAux1.SQL.Add('sdx_cep,sdx_numseqarq,sdx_numseqreg,sdx_dtcarga,sdx_numobj2,');
              SqlAux1.SQL.Add('sdx_numobj1,sdx_codusu,sdx_valdec,sdx_seqcarga,sdx_qtprod,sdx_dtmov) ');
              SqlAux1.SQL.Add('values (');
              //                              0     1
              SqlAux1.SQL.Add('99,''99'',:sigla,:numobj,''BR'',');
              //                  2       3         4         5       6
              SqlAux1.SQL.Add(':numobj4,:nomdest,:enddest,:ciddest,:ufdest,');
              //                  7            8                            9
              SqlAux1.SQL.Add(':cepdest,99,:numreg,(select current_date),:numobj2,');
              //                  10      11       12          13           14        15
              SqlAux1.SQL.Add(':numobj1,:codusu,:sdx_valdec,:sdx_seqcarga,:qtprod,:sdx_dtmov)');
              SqlAux1.Params[00].AsString  :=  'OL';//
              SqlAux1.Params[01].AsString  :=  numobj;
              SqlAux1.Params[02].AsString  :=  'AR'+ numobj + 'OL';//
              if (SqlTbBradDeptos.RecordCount = 0) then
                SqlAux1.Params[03].AsString  :=  gerant(trim(StrGridDados.Cells[1,k]),4)
              else
                SqlAux1.Params[03].AsString  :=  gerant(SqlTbBradDeptosjuncao.AsString,4)+': '+SqlTbBradDeptosdepto.AsString;
              SqlAux1.Params[04].AsString  :=  SqlTbBradDeptosender.AsString;
              SqlAux1.Params[05].AsString  :=  SqlTbBradDeptoscidade.Text;
              SqlAux1.Params[06].AsString  :=  SqlTbBradDeptosuf.Text;
              SqlAux1.Params[07].AsString  :=  copy(SqlTbBradDeptoscep.Text,1,5)+copy(SqlTbBradDeptoscep.Text,7,3);
              SqlAux1.Params[08].AsString  :=  gerant(inttostr(random(999)),3)+FormatDateTime('yyyymmdd',date)+FormatDateTime('hhmmss',Time)+GeraNT(sqlcga_acessocodigo.AsString,4)+gerant(inttostr(random(999)),3);
              SqlAux1.Params[09].AsString  :=  'DL'+ numobj + 'BR';
              SqlAux1.Params[10].AsString  :=  'AR'+ numobj + 'OL';//
              SqlAux1.Params[11].AsString  :=  sqlcga_acessocodigo.AsString;
              SqlAux1.Params[12].AsString  :=  VirgPonto2(trim(StrGridDados.Cells[8,k]));
              SqlAux1.Params[13].AsString  :=  trim(Ednumlote.Text);
              SqlAux1.Params[14].Value     :=  strtoint(trim(StrGridDados.Cells[3,k]));
              SqlAux1.Params[15].Text      :=  ''''+copy(StrGridDados.Cells[4,k],4,3)+copy(StrGridDados.Cells[4,k],1,3)+copy(StrGridDados.Cells[4,k],7,4)+'''';
              try
                SqlAux1.ExecSQL;
                EdGrava.Text := inttostr(strtoint(EdGrava.Text)+1);
                EdGrava.Refresh;
                SqlAux1.Close;
                SqlAux1.SQL.Clear;
                SqlAux1.SQL.Add('update tbsdx_ect set tbsdx_use = ''S'' where (tbsdxect_num = :num)');
                SqlAux1.Params[0].AsString  :=  SqlAux3.Fields[0].AsString;
                SqlAux1.ExecSQL;
                SqlAux1.Close;
              except on e: exception do
                begin
                  application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message+chr(10)+'Nro Objeto: '+numobj),'Ads',MB_OK+MB_ICONERROR);
                  EdErro.Text := IntToStr(strtoint(EdErro.Text)+1);
                  EdErro.Refresh;
                  StrGridErro.Cells[R1,K1]   :=  trim(StrGridDados.Cells[0,k]);
                  StrGridErro.Cells[R1+1,K1] :=  trim(StrGridDados.Cells[1,k]);
                  StrGridErro.Cells[R1+2,K1] :=  trim(StrGridDados.Cells[4,k]);
                  StrGridErro.Cells[R1+3,K1] :=  trim(Ednumlote.Text);
                  StrGridErro.RowCount := (K1 + 1);
                  StrGridErro.Refresh;
                  Inc(K1,1);
                end;
              end;
              Inc(K,1);
              Inc(x,1);
              StrGridDados.RowCount := K + 1;
              StrGridDados.Refresh;
            end;
          until
          x > StrToInt(EdQtdreg.Text);
          if (strtoint(trim(EdErro.Text)) > 0) then
            application.MessageBox(PChar('Registros com erros Verificar!'),'Ads',MB_OK+MB_ICONERROR)
          else
            application.MessageBox(PChar('Registros Gravados com Sucesso!'),'Ads',MB_OK+MB_ICONERROR);
          BtnSalvar.Enabled  :=  false;
          BtnFechar.Enabled := true;
        end;
      end;
    end;
end;

//********** Fim Grava OL







procedure TFrmPreCadToken.gravatc;
begin
  K:=1;
  x:=1;
  Ednumlote.Text   :=  IntToStr(Random(99))+gerant(formatdatetime('hhmm',Time),4);
  Ednumlote.Refresh;

  with dm do
    begin
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('select count(tbsdxect_num) from tbsdx_ect where (tbsdx_use is null) and (tbsdxect_prod = :prod)');
      SqlAux2.Params[00].AsString  :=  '2240';//
      SqlAux2.Open;
      if (SqlAux2.Fields[0].AsInteger > 0) and (SqlAux2.Fields[0].AsInteger < StrToInt(EdQtdreg.Text)) then
        begin
          Application.MessageBox(PChar('Solicitar ao Correio Novo Range'+chr(10)+'Cont�m menos que Qtde de Regs.'),'ADS',ID_OK);
          BtnSalvar.Enabled :=  false;
          exit;
        end;

      case RdGrpOpc.ItemIndex of
        0:
          begin
            Ednumlote.Text   :=  IntToStr(Random(99))+gerant(formatdatetime('hhmm',Time),4);
            Ednumlote.Refresh;
          end;
         1:
           begin
             Ednumlote.Enabled := true;
             Ednumlote.SetFocus;
           end;
      end;
      case strtoint64(trim(Ednumlote.Text)) of
      0:
        begin
          application.MessageBox(PChar('Digite o n� do Lote !'),'Ads',MB_OK+MB_ICONINFORMATION);
          Ednumlote.Enabled := true;
          Ednumlote.SetFocus;
        end;
      else
        begin
          agant :=  '';
          repeat
            Begin
              SqlAux3.Close;
              SqlAux3.SQL.Clear;
              SqlAux3.SQL.Add('select min(tbsdxect_num),tbsdxect_dv from tbsdx_ect where (tbsdxect_prod = :prod) and (tbsdx_use is null) group by tbsdxect_num,tbsdxect_dv order by tbsdxect_num limit 1');
              SqlAux3.Params[0].AsString  := '0';
              InputBox('','',SqlAux3.SQL.Text);
              SqlAux3.Open;
              if SqlAux3.RecordCount >0 then
              numobj:= SqlAux3.Fields[0].AsString+SqlAux3.Fields[1].AsString
              else
              InputBox('','',numobj);
              SqlTbBradDeptos.Close;
              SqlTbBradDeptos.SQL.Clear;
              SqlTbBradDeptos.SQL.Add('select * from tbbraddptos where (juncao = :juncao) limit 1');
              SqlTbBradDeptos.Params[0].AsString  :=  trim(StrGridDados.Cells[1,k]);
              SqlTbBradDeptos.Open;
              if  (agant =  trim(StrGridDados.Cells[1,k])) and (k>=2)  then
                begin
                  novolote  :=  IntToStr(StrToInt(Ednumlote.Text)+1);
                  Lbl001.Caption  :=  Lbl001.Caption+novolote+ ' - '+trim(StrGridDados.Cells[1,k])+ ' - ';
                end;
              agant :=  trim(StrGridDados.Cells[1,k]);
              SqlAux1.SQL.Clear;
              SqlAux1.SQL.Add('insert into tbsdx02 ');
              SqlAux1.SQL.Add('(sdx_codcli,sdx_idcli,sdx_siglaobj,sdx_numobj,sdx_paisorigem,');
              SqlAux1.SQL.Add('sdx_numobj4,sdx_nomdest,sdx_endedest,sdx_cidade,sdx_uf,');
              SqlAux1.SQL.Add('sdx_cep,sdx_numseqarq,sdx_numseqreg,sdx_dtcarga,sdx_numobj2,');
              SqlAux1.SQL.Add('sdx_numobj1,sdx_codusu,sdx_valdec,sdx_seqcarga,sdx_qtprod,sdx_dtmov) ');
              SqlAux1.SQL.Add('values (');
              //                              0     1
              SqlAux1.SQL.Add('99,''99'',:sigla,:numobj,''BR'',');
              //                  2       3         4         5       6
              SqlAux1.SQL.Add(':numobj4,:nomdest,:enddest,:ciddest,:ufdest,');
              //                  7            8                            9
              SqlAux1.SQL.Add(':cepdest,99,:numreg,(select current_date),:numobj2,');
              //                  10      11       12          13           14        15
              SqlAux1.SQL.Add(':numobj1,:codusu,:sdx_valdec,:sdx_seqcarga,:qtprod,:sdx_dtmov)');
              SqlAux1.Params[00].AsString  :=  'TC';//'KD';//'TC'
              SqlAux1.Params[01].AsString  :=  numobj;
              SqlAux1.Params[02].AsString  :=  'AR'+ numobj + 'TC';//'KD';//'TC';//
              if (SqlTbBradDeptos.RecordCount = 0) then
                SqlAux1.Params[03].AsString  :=  gerant(trim(StrGridDados.Cells[1,k]),4)
              else
                SqlAux1.Params[03].AsString  :=  gerant(SqlTbBradDeptosjuncao.AsString,4)+': '+SqlTbBradDeptosdepto.AsString;
              SqlAux1.Params[04].AsString  :=  SqlTbBradDeptosender.AsString;
              SqlAux1.Params[05].AsString  :=  SqlTbBradDeptoscidade.Text;
              SqlAux1.Params[06].AsString  :=  SqlTbBradDeptosuf.Text;
              SqlAux1.Params[07].AsString  :=  copy(SqlTbBradDeptoscep.Text,1,5)+copy(SqlTbBradDeptoscep.Text,7,3);
              SqlAux1.Params[08].AsString  :=  gerant(inttostr(random(999)),3)+FormatDateTime('yyyymmdd',date)+FormatDateTime('hhmmss',Time)+GeraNT(sqlcga_acessocodigo.AsString,4)+gerant(inttostr(random(999)),3);
//              SqlAux1.Params[09].AsString  :=  'SL'+ numobj + 'BR';
              SqlAux1.Params[09].AsString  :=  'DL'+ numobj + 'BR';
              SqlAux1.Params[10].AsString  :=  'AR'+ numobj + 'TC';//'KD';//'TC';//
              SqlAux1.Params[11].AsString  :=  sqlcga_acessocodigo.AsString;
              SqlAux1.Params[12].AsString  :=  VirgPonto2(trim(StrGridDados.Cells[8,k]));
              SqlAux1.Params[13].AsString  :=  trim(Ednumlote.Text);
              SqlAux1.Params[14].Value     :=  strtoint(trim(StrGridDados.Cells[3,k]));
              SqlAux1.Params[15].Text      :=  ''''+copy(StrGridDados.Cells[4,k],4,3)+copy(StrGridDados.Cells[4,k],1,3)+copy(StrGridDados.Cells[4,k],7,4)+'''';
              try
                SqlAux1.ExecSQL;
                EdGrava.Text := inttostr(strtoint(EdGrava.Text)+1);
                EdGrava.Refresh;
                SqlAux1.Close;
                SqlAux1.SQL.Clear;
                SqlAux1.SQL.Add('update tbsdx_ect set tbsdx_use = ''S'' where (tbsdxect_num = :num)');
                SqlAux1.Params[0].AsString  :=  SqlAux3.Fields[0].AsString;
                SqlAux1.ExecSQL;
                SqlAux1.Close;
              except on e: exception do
                begin
                  application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message+chr(10)+'Nro Objeto: '+numobj),'Ads',MB_OK+MB_ICONERROR);
                  EdErro.Text := IntToStr(strtoint(EdErro.Text)+1);
                  EdErro.Refresh;
                  StrGridErro.Cells[R1,K1]   :=  trim(StrGridDados.Cells[0,k]);
                  StrGridErro.Cells[R1+1,K1] :=  trim(StrGridDados.Cells[1,k]);
                  StrGridErro.Cells[R1+2,K1] :=  trim(StrGridDados.Cells[4,k]);
                  StrGridErro.Cells[R1+3,K1] :=  trim(Ednumlote.Text);
                  StrGridErro.RowCount := (K1 + 1);
                  StrGridErro.Refresh;
                  Inc(K1,1);
                end;
              end;
              Inc(K,1);
              Inc(x,1);
              StrGridDados.RowCount := K + 1;
              StrGridDados.Refresh;
            end;
          until
          x > StrToInt(EdQtdreg.Text);
          if (strtoint(trim(EdErro.Text)) > 0) then
            application.MessageBox(PChar('Registros com erros Verificar!'),'Ads',MB_OK+MB_ICONERROR)
          else
            application.MessageBox(PChar('Registros Gravados com Sucesso!'),'Ads',MB_OK+MB_ICONERROR);
          BtnSalvar.Enabled  :=  false;
          BtnFechar.Enabled := true;
        end;
      end;
    end;
end;
procedure TFrmPreCadToken.crgtk;
begin
  EdErro.Text   :=  '0';
  EdQtdreg.Text :=  '0';
  EdGrava.Text :=  '0';
  StrGridErro.ColCount  :=  2;
  StrGridErro.ColWidths[1]  :=  150;
  with Dm do
    begin
      if EdLocal.Text = '' then
        begin
          Application.MessageBox('Escolha O Arquivo','ADS',IDOK);
          exit;
        end
      else
        begin
          AssignFile(arq,EdLocal.Text);
          reset(arq);
          Readln(arq,lin);
          while not(Eof(arq)) do
            begin
              EdQtdreg.Text :=  IntToStr(StrToInt(EdQtdreg.Text)+1);
              EdQtdreg.Refresh;
              SqlAux1.Close;
              SqlAux1.SQL.Clear;
              SqlAux1.SQL.Add('insert into cga76 values (:remes) ');//values ('''+lin+''')');
              SqlAux1.Params[0].AsString  :=  IntToStr(StrToInt64(trim(lin)));
              try
                SqlAux1.ExecSQL;
                EdGrava.Text  :=  IntToStr(StrToInt(EdGrava.Text)+1);
              except on e:exception do
                begin
                  EdErro.Text :=  IntToStr(StrToInt(EdErro.Text)+1);
                  EdErro.Refresh;
                  StrGridErro.Cells[R1,K1]   :=  trim(lin);
                  StrGridErro.Cells[R1+1,K1]   :=  e.Message;
                  StrGridErro.Refresh;
                  StrGridErro.RowCount := K1 + 1;
                  Inc(k1,1);
                end;
              end;
              Readln(arq,lin);
            end;
          Application.MessageBox('Fim de Leitura','ADS',IDOK);
        end;
    end;
end;
procedure TFrmPreCadToken.lertb;
var R:Integer;
begin
  with dm do
    begin
      SqlAux2.Close;
      SqlAux2.SQL.Clear;
      SqlAux2.SQL.Add('select count(tbsdxect_num) from tbsdx_ect where (tbsdx_use is null) and (tbsdxect_prod = :prod)');
      SqlAux2.Params[00].AsString  :=  '1953';//
      SqlAux2.Open;
      if (SqlAux2.Fields[0].Value > 0) and (SqlAux2.Fields[0].Value <= 200) then
        Application.MessageBox(PChar('Solicitar ao Correio Novo Range'+chr(10)+'Cont�m 200 ou menos'),'ADS',ID_OK)
      else if (SqlAux2.Fields[0].Value = 0) then
        begin
          Application.MessageBox(PChar('N�o H� Mais Range para esse Produto!'),'ADS',ID_OK);
          BtnAbrir.Enabled :=  false;
          exit;
        end;
    end;
    BtnAbrir.Enabled :=  false;
    FileName := Trim(Edlocal.Text);
    ExcelApplication1.Connect;
    Try
      ExcelApplication1.Workbooks.Open(fileName,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,0);
      WorkBk := ExcelApplication1.WorkBooks.Item[1];
      WorkSheet := WorkBk.WorkSheets.Get_Item(1) as _WorkSheet;
      WorkSheet.Cells.SpecialCells(xlCellTypeLastCell,EmptyParam).Activate;
      X := ExcelApplication1.ActiveCell.Row;
      Y := 7;
      StrGridDados.ColCount := Y;
      RangeMatrix := ExcelApplication1.Range['A1',ExcelApplication1.Cells.Item[X,Y]].Value2;
      // RangeMatrix := ExcelApplication1.Range['A1',
      ExcelApplication1.Quit;
    Finally
      ShowMessage(FileName);
      ExcelApplication1.Disconnect;
    End;
    K := 2;
    repeat
      for R := 1 to Y do
        begin
         If (K = 2) Then
          StrGridDados.Cells[(R-1),(K-1)] := trim(RangeMatrix[K,R])
         else
          begin
            if (trim(RangeMatrix[K,R]) <> '') then
              StrGridDados.Cells[(R-1),(K-1)] := trim(RangeMatrix[K,R]);
            if (trim(RangeMatrix[K,2]) <> '') and (vernum(trim(RangeMatrix[K,2])) = true) then
              Inc(t,1);
          end;
        end;
      Inc(K,1);
      StrGridDados.RowCount := ((K + 1)-2);
      StrGridDados.Refresh;
    until
    K > X;
    RangeMatrix := Unassigned;
    EdQtdreg.Text := IntToStr(k-1);//IntToStr(t div y);
    EdQtdreg.Refresh;
    if (X-1) > 0 then
      begin
        BtnSalvar.Enabled := true;
        BtnLeitura.Enabled := false;
      end;

end;
procedure TFrmPreCadToken.gravatb;
var i:Integer;
begin
  K:=1;
  x:=1;
  Ednumlote.Text   :=  IntToStr(Random(99))+gerant(formatdatetime('hhmm',Time),4);
  Ednumlote.Refresh;
  with dm do
    begin
      case RdGrpOpc.ItemIndex of
      0:
        begin
          Ednumlote.Text   :=  IntToStr(Random(99))+gerant(formatdatetime('hhmm',Time),4);
          Ednumlote.Refresh;
        end;
       1:
         begin
           Ednumlote.Enabled := true;
           Ednumlote.SetFocus;
         end;
      end;
      case strtoint64(trim(Ednumlote.Text)) of
      0:
        begin
          application.MessageBox(PChar('Digite o n� do Lote !'),'Ads',MB_OK+MB_ICONINFORMATION);
          Ednumlote.Enabled := true;
          Ednumlote.SetFocus;
        end;
      else
        begin
          agant :=  '';
          repeat
            begin
              SqlAux3.Close;
              SqlAux3.SQL.Clear;
              SqlAux3.SQL.Add('select min(tbsdxect_num),tbsdxect_dv from tbsdx_ect where (tbsdxect_prod = ''1953'') and (tbsdx_use is null) group by tbsdxect_num,tbsdxect_dv order by tbsdxect_num limit 1');
              SqlAux3.Open;
              numobj:= SqlAux3.Fields[0].AsString+SqlAux3.Fields[1].AsString;
              if  (agant =  trim(StrGridDados.Cells[0,k])) and (k>=2)  then
                begin
                  novolote  :=  IntToStr(StrToInt(Ednumlote.Text)+1);
                  agant :=  trim(StrGridDados.Cells[0,k]);
                end
              else
                agant :=  trim(StrGridDados.Cells[0,k]);
                v_soma := 0;
                i := 0;
                mcep  :=  copy(StrGridDados.Cells[5,k],1,5)+copy(StrGridDados.Cells[5,k],7,3);
                for i:= 1 to 8 do
                  v_soma := v_soma + strtoint(copy(mcep,i,1));
                v_soma := strtoint(copy(intTostr(v_soma),length(inttostr(v_soma)),1));
                if v_soma = 0 then
                  cepr := mcep + '0'
                else
                  begin
                    v_soma := 10 - v_soma;
                    cepr := '/'+mcep + intToStr(v_soma)+'\';
                  end;
                SqlAux1.SQL.Clear;
                SqlAux1.SQL.Add('insert into tbsdx02 ');
                SqlAux1.SQL.Add('(sdx_codcli,sdx_idcli,sdx_siglaobj,sdx_numobj,sdx_paisorigem,');
                SqlAux1.SQL.Add('sdx_numobj4,sdx_nomdest,sdx_endedest,sdx_cidade,sdx_uf,');
                SqlAux1.SQL.Add('sdx_cep,sdx_numseqarq,sdx_numseqreg,sdx_dtcarga,sdx_numobj2,');
                SqlAux1.SQL.Add('sdx_numobj1,sdx_codusu,sdx_seqcarga,sdx_peso,sdx_dtmov) ');
                SqlAux1.SQL.Add('values (');
                //                              0     1
                SqlAux1.SQL.Add('99,''99'',:sigla,:numobj,''BR'',');
                //                  2       3         4         5       6
                SqlAux1.SQL.Add(':numobj4,:nomdest,:enddest,:ciddest,:ufdest,');
                //                  7            8                            9
                SqlAux1.SQL.Add(':cepdest,99,:numreg,(select current_date),:numobj2,');
                //                  10      11       12          13
                SqlAux1.SQL.Add(':numobj1,:codusu,:sdx_seqcarga,:sdx_peso,(select current_date))');
                SqlAux1.Params[00].AsString  :=  'KB';//
                SqlAux1.Params[01].AsString  :=  numobj;
                SqlAux1.Params[02].AsString  :=  'AR'+ numobj + 'KB';//
                SqlAux1.Params[03].AsString  :=  trim(StrGridDados.Cells[0,k]);
                SqlAux1.Params[04].AsString  :=  trim(StrGridDados.Cells[1,k]);
                SqlAux1.Params[05].AsString  :=  trim(StrGridDados.Cells[3,k]);
                SqlAux1.Params[06].AsString  :=  trim(StrGridDados.Cells[4,k]);
                SqlAux1.Params[07].AsString  :=  copy(StrGridDados.Cells[5,k],1,5)+copy(StrGridDados.Cells[5,k],7,3);
                SqlAux1.Params[08].AsString  :=  gerant(inttostr(random(999)),3)+FormatDateTime('yyyymmdd',date)+FormatDateTime('hhmmss',Time)+GeraNT(sqlcga_acessocodigo.AsString,4)+gerant(inttostr(random(999)),3);
                SqlAux1.Params[09].AsString  :=  'SL'+ numobj + 'BR';
                SqlAux1.Params[10].AsString  :=  'AR'+ numobj + 'KB';//
                SqlAux1.Params[11].AsString  :=  sqlcga_acessocodigo.AsString;
                SqlAux1.Params[12].AsString  :=  trim(Ednumlote.Text);
                SqlAux1.Params[13].AsString  :=  '0.010';
              try
                SqlAux1.ExecSQL;
                EdGrava.Text := inttostr(strtoint(EdGrava.Text)+1);
                EdGrava.Refresh;
                SqlAux1.Close;
                SqlAux1.SQL.Clear;
                SqlAux1.SQL.Add('update tbsdx_ect set tbsdx_use = ''S'' where (tbsdxect_num = :num)');
                SqlAux1.Params[0].AsString  :=  SqlAux3.Fields[0].AsString;
                SqlAux1.ExecSQL;
                SqlAux1.Close;
              except on e: exception do
                begin
                  application.MessageBox(PChar('Ocorreu um erro fatal: '+e.Message),'Ads',MB_OK+MB_ICONERROR);
                  EdErro.Text := IntToStr(strtoint(EdErro.Text)+1);
                  EdErro.Refresh;
                  StrGridErro.Cells[R1,K1]   :=  trim(StrGridDados.Cells[0,k]);
                  StrGridErro.Cells[R1+1,K1] :=  trim(StrGridDados.Cells[1,k]);
                  StrGridErro.Cells[R1+2,K1] :=  trim(StrGridDados.Cells[4,k]);
                  StrGridErro.Cells[R1+3,K1] :=  trim(Ednumlote.Text);
                  StrGridErro.RowCount := (K1 + 1);
                  StrGridErro.Refresh;
                  Inc(K1,1);
                end;
              end;
            Inc(K,1);
            Inc(x,1);
            StrGridDados.RowCount := K + 1;
            StrGridDados.Refresh;
            end;
          until
          x > StrToInt(EdQtdreg.Text);
          if (strtoint(trim(EdErro.Text)) > 0) then
            application.MessageBox(PChar('Registros com erros Verificar!'),'Ads',MB_OK+MB_ICONERROR)
          else
            application.MessageBox(PChar('Registros Gravados com Sucesso!'),'Ads',MB_OK+MB_ICONERROR);
          BtnSalvar.Enabled  :=  false;
          BtnFechar.Enabled := true;
        end;
      end;
    end;
end;
end.
