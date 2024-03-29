{$WARN UNIT_PLATFORM OFF}
unit U_FrmBxaArqSdx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExcelXP, StdCtrls, ExtCtrls, ComCtrls,  Buttons, ShlObj,
  OleConst,SysConst, Types, OfficeXP,ComObj, ActiveX, DB, Math,OleServer, DBCtrls, FileCtrl;

type
  TFrmBxaArqSdx = class(TForm)
    BtnLerArq:    TBitBtn;
    Edarq:        TEdit;
    ExcelApp:     TExcelApplication;
    edGrava: TEdit;
    Bevel:        TBevel;
    Label5:       TLabel;
    RegTotal:     TLabel;
    FileListBox:  TFileListBox;
    diretorio:    TDirectoryListBox;
    DriveCboBox:  TDriveComboBox;
    DBCboSdxServ: TDBLookupComboBox;
    Painel:       TPanel;
    Label1:       TLabel;
    EdLido: TEdit;
    Label2: TLabel;
    procedure FileListBoxChange(Sender: TObject);
    procedure BtnLerArqClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bxasdx;
    procedure procrel;
    procedure bxasdxexcel;

  private
    { Private declarations }
   WorkBk : _WorkBook;
   WorkSheet : _WorkSheet;
   K, X, Y : Integer;
   RangeMatrix : Variant;
   FileName : WideString;
   dtrecebe  : Variant;//TDate;//
  arqrel           :TextFile;
  arqtxt           :TextFile;
  Lin001           :String;
  linrel           :  array of string;
  indrel           :  Integer;

  public
    { Public declarations }
  dirrel           :String;
  end;

var
  FrmBxaArqSdx: TFrmBxaArqSdx;

implementation

uses DmDados, U_FrmRlErrobxaArSdx, U_Func;

{$R *.dfm}
procedure TFrmBxaArqSdx.procrel;
var i:Integer;
begin
  dirrel  :=  'F:\sistemas\errobxasdx';
//   ;
  if(Not(DirectoryExists(dirrel)))  then
    MkDir(dirrel);
  dirrel  :=  dirrel+'\relbxasdx';
  Dm.SqlAux2.Close;
  Dm.SqlAux2.SQL.Clear;
  Dm.SqlAux2.SQL.Add('select current_date');
  Dm.SqlAux2.Open;
  dirrel  :=  dirrel+FormatDateTime('ddmmyyyy',Dm.SqlAux2.Fields[0].AsDateTime)+FormatDateTime('hhmm',Time);
  linrel[0]  :=  format('%-80.80s%',['Address - Erros Baixa AR-Sedex: '+Edarq.Text+' - '+FormatDateTime('dd/mm/yyyy',Dm.SqlAux2.Fields[0].AsDateTime)] );
  linrel[1]  :=  format('%-15.15s%',['Objeto'])+format('%-11.11s%',['Data'])+format('%-60.60s%',['Entregador'])+format('%-30.30s%',['Erro']);
  linrel[2]  :=  format('%-148.148s%',[StringOfChar('-',148)]);
  //Inc(indrel,1);
  linrel[indrel]  :=  format('%-50.50s%',['Total de Erros: '+IntToStr(indrel-2)]);
  AssignFile(arqrel,dirrel);
  Rewrite(arqrel);
  for i := 0 to  indrel do
    Writeln(arqrel,linrel[i]);
  Painel.Caption  :=  'Relat�rio de erro: '+dirrel;
  CloseFile(arqrel);
  Application.CreateForm(TFrmRlErroBxaArSdx,FrmRlErroBxaArSdx);
  AssignFile(FrmRlErroBxaArSdx.arq, FrmBxaArqSdx.dirrel);
  Reset(FrmRlErroBxaArSdx.arq);
  FrmRlErroBxaArSdx.RLErroBxaArSdx.PreviewModal;
 // CloseFile(FrmRlErroBxaArSdx.arq);
  FrmRlErroBxaArSdx.Destroy;
//  CloseFile(arqrel);
  //self.Painel.Caption  :=  'Arquivo de erros:'+dirrel;
end;
procedure TFrmBxaArqSdx.bxasdx;

begin
  EdLido.Text     :=  '0';
  edGrava.Text    :=  '0';
//  try
    with dm do
      begin
        indrel  :=  3;
        BtnLerArq.Enabled :=  false;
        AssignFile(arqtxt,Edarq.Text);
        Reset(arqtxt);
        Readln(arqtxt,lin001);
        while (not Eof(arqtxt)) do
          begin
            EdLido.Text :=  IntToStr(StrToInt(EdLido.Text)+1);
            EdLido.Refresh;
            Readln(arqtxt,lin001);
          end;
        SetLength(linrel,StrToInt(EdLido.Text)*3);
        Reset(arqtxt);
        EdLido.Text :=  '0';
        Readln(arqtxt,lin001);
        Readln(arqtxt,lin001);
        while (not Eof(arqtxt)) do
          begin
          //if (copy(Lin001,1,1)='') or (copy(Lin001,1,1)='') or (copy(Lin001,1,1)='') then
          //begin
          //
          //end;
              EdLido.Text :=  IntToStr(StrToInt(EdLido.Text)+1);
              EdLido.Refresh;
              SqlAux1.Close;
              SqlAux1.SQL.Clear;
              SqlAux1.SQL.Add('update tbsdx02 set sdx_dtentrega=:dtentrega,sdx_nomrecebe=:nomrecebe, ');
              SqlAux1.SQL.Add('sdx_codbxa=10,sdx_dtbaixa=(select current_date),sdx_codusu_bxa = :usuario ');
              SqlAux1.SQL.Add('where (sdx_numobj2=:numobj2) and (sdx_dtbaixa is Null) and (sdx_dtentrega is Null)');
              SqlAux1.ParamByName('dtentrega').AsString :=  trim(copy(Lin001,18,03))+trim(copy(Lin001,15,03))+trim(copy(Lin001,21,04));
              SqlAux1.ParamByName('nomrecebe').AsString :=  trim(copy(Lin001,27,50));
              SqlAux1.ParamByName('numobj2').AsString   :=  trim(copy(Lin001,1,13));
              SqlAux1.ParamByName('usuario').Value      :=  sqlcga_acessocodigo.Value;
              try
                SqlAux1.ExecSQL;
                if SqlAux1.RowsAffected = 1 then
                  edGrava.Text  :=  IntToStr(StrToInt(edGrava.Text)+1);
                edGrava.Refresh;
              except on e:exception do
                begin
                  linrel[indrel]  :=  format('%-14.14s%',[trim(copy(lin001,1,14))])+format('%-11.11s%',[trim(copy(lin001,15,10))]);
                  linrel[indrel]  :=  linrel[indrel]+format('%-60.60s%',[trim(copy(lin001,26,50))])+format('%-80.80s%',[e.Message]);
                  Inc(indrel,1);
                end;
              end;
              Readln(arqtxt,lin001);
          end;
        CloseFile(arqtxt);
        BtnLerArq.Enabled :=  true;
      end;
  if indrel  >  3 then
    procrel;
end;
{procedure TFrmBxaArqSdx.bxasdx;
var R:Integer;
begin
  EdLido.Text     :=  '0';
  edGrava.Text    :=  '0';
//  try
    with dm do
      begin
        indrel  :=  3;
        BtnLerArq.Enabled :=  false;
        AssignFile(arqtxt,Edarq.Text);
        Reset(arqtxt);
        Readln(arqtxt,lin001);
        while (not Eof(arqtxt)) do
          begin
            EdLido.Text :=  IntToStr(StrToInt(EdLido.Text)+1);
            EdLido.Refresh;
            Readln(arqtxt,lin001);
          end;
        SetLength(linrel,StrToInt(EdLido.Text)*3);
        Reset(arqtxt);
        EdLido.Text :=  '0';
        Readln(arqtxt,lin001);
        Readln(arqtxt,lin001);
        while (not Eof(arqtxt)) do
          begin
          //if (copy(Lin001,1,1)='') or (copy(Lin001,1,1)='') or (copy(Lin001,1,1)='') then
          //begin
          //
          //end;
              EdLido.Text :=  IntToStr(StrToInt(EdLido.Text)+1);
              EdLido.Refresh;
              SqlAux1.Close;
              SqlAux1.SQL.Clear;
              SqlAux1.SQL.Add('update tbsdx02 set sdx_dtentrega=:dtentrega,sdx_nomrecebe=:nomrecebe, ');
              SqlAux1.SQL.Add('sdx_codbxa=10,sdx_dtbaixa=(select current_date),sdx_codusu_bxa = :usuario ');
              SqlAux1.SQL.Add('where (sdx_numobj2=:numobj2) and (sdx_dtbaixa is Null) and (sdx_dtentrega is Null)');
              SqlAux1.ParamByName('dtentrega').AsString :=  trim(copy(Lin001,18,03))+trim(copy(Lin001,15,03))+trim(copy(Lin001,21,04));
              SqlAux1.ParamByName('nomrecebe').AsString :=  trim(copy(Lin001,27,50));
              SqlAux1.ParamByName('numobj2').AsString   :=  trim(copy(Lin001,1,13));
              SqlAux1.ParamByName('usuario').Value      :=  sqlcga_acessocodigo.Value;
              try
                SqlAux1.ExecSQL;
                if SqlAux1.RowsAffected = 1 then
                  edGrava.Text  :=  IntToStr(StrToInt(edGrava.Text)+1);
                edGrava.Refresh;
              except on e:exception do
                begin
                  linrel[indrel]  :=  format('%-14.14s%',[trim(copy(lin001,1,14))])+format('%-11.11s%',[trim(copy(lin001,15,10))]);
                  linrel[indrel]  :=  linrel[indrel]+format('%-60.60s%',[trim(copy(lin001,26,50))])+format('%-80.80s%',[e.Message]);
                  Inc(indrel,1);
                end;
              end;
              Readln(arqtxt,lin001);
          end;
        CloseFile(arqtxt);
        BtnLerArq.Enabled :=  true;
      end;
  if indrel  >  3 then
    procrel;
end;}
procedure TFrmBxaArqSdx.bxasdxexcel;

begin
    indrel    :=  3;
    dtrecebe  :=  '';
    BtnLerArq.Enabled :=  false;
    FileName := Trim(Edarq.Text);
    ExcelApp.Connect;
    Try
      ExcelApp.Workbooks.Open(fileName,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,0);
      WorkBk := ExcelApp.WorkBooks.Item[1];
      WorkSheet := WorkBk.WorkSheets.Get_Item(1) as _WorkSheet;
      WorkSheet.Cells.SpecialCells(xlCellTypeLastCell,EmptyParam).Activate;
      X := ExcelApp.ActiveCell.Row;
      EdLido.Text :=  IntToStr(StrToInt(EdLido.Text)+1);
      SetLength(linrel,X*3);
      Y := 47;
      RangeMatrix := ExcelApp.Range['A1',ExcelApp.Cells.Item[X,Y]].Value2;
      // RangeMatrix := ExcelApp.Range['A1',
      ExcelApp.Quit;
    Finally
    //  ShowMessage(FileName);
     ExcelApp.Disconnect;
    end;
    K := 2;
    try
      repeat
          EdLido.Text :=  IntToStr(k-1);
          try
            if (trim(RangeMatrix[K,46])<>'') and (dtrecebe='')then
              dtrecebe  :=  FormatDateTime('mm/dd/yyyy',trunc(RangeMatrix[K,46]));
            with dm do
              begin
                if (UpperCase(RangeMatrix[K,45])<> 'EM APURA��O')  then
                  BEGIN
                    SqlAux1.Close;
                    SqlAux1.SQL.Clear;
                    SqlAux1.SQL.Add('update tbsdx02 set ');
                    //sdx_dtentrega=:dtentrega,
                    SqlAux1.SQL.Add('sdx_dtentrega = :dtentrega,sdx_nomrecebe = :nomrecebe,sdx_codusu_bxa = :usuario, sdx_dtbaixa=(select current_date),sdx_codbxa = 10 ');
                    SqlAux1.SQL.Add('where (sdx_numobj2 = :numobj2) and (sdx_dtentrega is Null)');
                    SqlAux1.ParamByName('dtentrega').AsString :=  dtrecebe;//FormatDateTime('mm/dd/yyyy', StrToDate(trim(RangeMatrix[K,46])));
                    SqlAux1.ParamByName('nomrecebe').AsString :=  trim(RangeMatrix[K,45]);
                    SqlAux1.ParamByName('usuario').AsString   :=  sqlcga_acessocodigo.AsString;
                    SqlAux1.ParamByName('numobj2').AsString   :=  trim(RangeMatrix[K,19]);
                    //InputBox('','',SqlAux1.SQL.Text);
                    try
                      SqlAux1.ExecSQL;
                      dtrecebe:='';
                      case SqlAux1.RowsAffected of
                        1:
                          begin
                            edGrava.Text  :=  IntToStr(StrToInt(edGrava.Text)+1);
                            edGrava.Refresh;
                          end;
                      end;
                    except on e:exception do
                      begin
                        linrel[indrel]  :=  format('%-15.15s%',[RangeMatrix[k,19]])+format('%-50.50s%',[trim(RangeMatrix[K,45])])+format('%-100.100s%',['Erro:'+e.Message]);
  //                      linrel[indrel]  :=
                        Inc(indrel,1);
                      end;
                    end;
                  end;
              end;
          except on e:exception do
            begin
              try
                dtrecebe  :=  FormatDateTime('mm/dd/yyyy',trunc(strtoint((RangeMatrix[K,45]))));
                k :=  k-1;
//                EdLido.Text :=  IntToStr(k);
              except on e:exception do
                begin
                  linrel[indrel]  :=  format('%-15.15s%',[RangeMatrix[k,19]])+format('%-50.50s%',[trim(RangeMatrix[K,45])])+format('%-100.100s%',['Erro:'+e.Message]);
                  Inc(indrel,1);
                  BtnLerArq.Enabled :=  true;
                end;
              end;
            end;
          end;
//          dtrecebe:='';
          Inc(K,1);
          until
          K > X;
    except on e:exception do
      begin
        linrel[indrel]  :=  format('%-15.15s%',[RangeMatrix[k,19]])+format('%-50.50s%',[trim(RangeMatrix[K,45])])+format('%-100.100s%',['Erro:'+e.Message]);
//        linrel[indrel]  :=  linrel[indrel];
        Inc(indrel,1);
        BtnLerArq.Enabled :=  true;
      end;
    end;
    if (indrel  > 3) then
      begin
        procrel;
        CloseFile(arqrel);
      end;
    BtnLerArq.Enabled :=  True;
end;
procedure TFrmBxaArqSdx.BtnLerArqClick(Sender: TObject);
begin
  inherited;
  EdLido.Text :=  '0';
  indrel      :=  0;
  Painel.Caption  :=  '';
  if (trim(Edarq.Text)='') then
    begin
      Application.MessageBox('Escolha um Arquivo','ADS',IDOK);
      exit;
    end
  else
   bxasdxexcel;
   //bxasdx;

end;
procedure TFrmBxaArqSdx.FileListBoxChange(Sender: TObject);
begin
  FileListBox.FileEdit;
  Edarq.Text  :=  diretorio.FileList.FileName;

end;

procedure TFrmBxaArqSdx.FormShow(Sender: TObject);
begin
//  inherited;
  EdLido.Text   :=  '0';
  edGrava.Text  :=  '0';
  RegTotal.Caption  :=  'Baixados';
end;

end.
