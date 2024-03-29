{$WARN UNIT_PLATFORM OFF}
unit U_CadSedex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ShellCtrls, StdCtrls, Buttons, FileCtrl, ExtCtrls, DBCtrls,OleServer, ExcelXP;

type
  TFrmCadSedex = class(TForm)
    captot: TLabel;
    edTot: TEdit;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    diretorio: TDirectoryListBox;
    FileListBox1: TFileListBox;
    DriveComboBox1: TDriveComboBox;
    EdRangeIni: TEdit;
    EdRangeFin: TEdit;
    BtnCarrega: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Edarq: TEdit;
    EdSeqArq: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    DBCboSdxServ: TDBLookupComboBox;
    Label5: TLabel;
    procedure FileListBox1Click(Sender: TObject);
    procedure EdRangeFinKeyPress(Sender: TObject; var Key: Char);
    procedure EdRangeFinEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FileListBox1Change(Sender: TObject);
    procedure diretorioClick(Sender: TObject);
    procedure BtnCarregaClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure cargaarqar;
    procedure cargarange;
    procedure altseq;
  private

  erro:boolean;
  Lista           :TextFile;
  Linha           :String;
  Conta     : integer;
  dtseq     : string;
  mCEP              : string;
  ContVirg              : integer;
  sel         : string;
  virgant      : integer;
  NOME,LOGRADOURO,BAIRRO,CIDADE,ESTADO,CEP5  : variant;
  v_soma : integer;
  CEPr,mteste  : string;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadSedex: TFrmCadSedex;

implementation

uses DmDados, U_Func;

{$R *.dfm}

procedure TFrmCadSedex.BtnCarregaClick(Sender: TObject);

var
  Lista           :TextFile;
  Linha           :String;
  Conta :Integer;
  v_tothead : string;
  v_dtgera  : String;
  v_maxseq  : integer;
begin
  Conta := 0;
  AssignFile(Lista,diretorio.FileList.FileEdit.Text);
  Reset(lista);
  ReadLn(Lista,Linha);
  v_tothead := trim(copy(Linha,69,6));
  v_dtgera  := copy(Linha,61,8);
  if copy(Linha,1,1) <> '8' then
    begin
      showmessage('Arquivo fora do Lay-Out');
      exit;
    end;

  BtnCarrega.Enabled := false;

  With dm do
    Begin
       SqlAux1.Close;
       SqlAux1.SQL.Clear;
       SqlAux1.SQL.Add('select distinct(Max(sdx_seqcarga)) from tbsdx');
       SqlAux1.Open;
    end;

  if (Dm.SqlAux1.Fields[0].Value = Null ) then
    begin
      v_maxseq := 0;
    end
  else
    v_maxseq := StrToInt(Dm.SqlAux1.Fields[0].value);

  ReadLn(Lista,Linha);
  While copy (Linha,1,1) = '9' do
    Begin
      Conta := Conta+1;
      edTot.Text := InttoStr(conta);
      edtot.Refresh;
      Dm.SqlSdx1.Close;
      Dm.SqlSdx1.Sql.Clear;
      Dm.SqlSdx1.Sql.Add('insert into tbsdx (sdx_codcli,sdx_idcli,sdx_siglaobj,sdx_numobj,');
      Dm.SqlSdx1.Sql.Add('sdx_paisorigem,sdx_codoperacao,sdx_numobj3,sdx_nomdest,sdx_endedest,sdx_cidade,');
      Dm.SqlSdx1.Sql.Add('sdx_uf,sdx_cep,sdx_numseqarq,sdx_numseqreg,sdx_dtcarga,sdx_seqcarga)');
      Dm.SqlSdx1.Sql.Add('values (:sdx_codcli,:sdx_idcli,:sdx_siglaobj,:sdx_numobj,:sdx_paisorigem,');
      //                                  0          1          2            3              4
      Dm.SqlSdx1.Sql.Add(':sdx_codoperacao,:sdx_conteudo,:sdx_nomdest,:sdx_endedest,:sdx_cidade,:sdx_uf,');
      //                           5               6             7            8             9         10
      Dm.SqlSdx1.Sql.Add(':sdx_cep,:sdx_numseqarq,:sdx_numseqreg,(SELECT CURRENT_DATE),:seqcarga)');
      //                         11          12           13                                14
      Dm.SqlSdx1.Params[0].Value  := copy(Linha,2,4);
      Dm.SqlSdx1.Params[1].Value  := copy(Linha,6,2);
      Dm.SqlSdx1.Params[2].Value  := copy(Linha,8,2);
      Dm.SqlSdx1.Params[3].Value  := copy(Linha,10,9);
      Dm.SqlSdx1.Params[4].Value  := copy(Linha,19,2);
      Dm.SqlSdx1.Params[5].Value  := copy(Linha,21,4);
      Dm.SqlSdx1.Params[6].Value  := copy(Linha,25,16);
      Dm.SqlSdx1.Params[7].Value  := copy(Linha,41,40);
      Dm.SqlSdx1.Params[8].Value  := copy(Linha,81,40);
      Dm.SqlSdx1.Params[9].Value := copy(Linha,121,30);
      Dm.SqlSdx1.Params[10].Value := copy(Linha,151,2);
      Dm.SqlSdx1.Params[11].Value := copy(Linha,153,8);
      Dm.SqlSdx1.Params[12].Value := copy(Linha,169,5);
      Dm.SqlSdx1.Params[13].Value := copy(Linha,174,7);
      Dm.SqlSdx1.Params[14].AsInteger := v_maxseq + 1;
      Dm.SqlSdx1.ExecSql;
      ReadLn(Lista,Linha);
    end;
      if conta =  StrToInt(v_tothead) then
        Begin
         showmessage('Registros Carregados!');
        end
      else
        Begin
         Application.MessageBox('Total carregado n�o confere com o Header!','Aten��o !',MB_OK+MB_ICONERROR);
        end
end;



procedure TFrmCadSedex.DiretorioClick(Sender: TObject);
begin
// BtnCarrega.Enabled := true;
end;

procedure TFrmCadSedex.EdRangeFinEnter(Sender: TObject);
begin
if (trim(EdRangeIni.Text) = '') then
  begin
    Application.MessageBox('Range Inicial dever� estar preechido','ADS',0);
    EdRangeIni.SetFocus;
  end;
end;

procedure TFrmCadSedex.EdRangeFinKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    if (strtoint(EdRangeIni.Text) > strtoint(EdRangeFin.Text)) then
    begin
      Application.MessageBox('Range Inicial dever� ser menor que Range Final','ADS',0);
      EdRangeIni.SetFocus;
    end;
  end;
end;

procedure TFrmCadSedex.FileListBox1Change(Sender: TObject);
begin
  FileListBox1.FileEdit;
  //BtnCarrega.Enabled  := true;
end;

procedure TFrmCadSedex.FileListBox1Click(Sender: TObject);
begin
  Edarq.Text  :=  diretorio.FileList.FileName;
end;

procedure TFrmCadSedex.FormShow(Sender: TObject);
begin
  with dm do
    begin
      SqlSdxServ.Open;
      case FrmCadSedex.tag of
        0:
          begin
            EdRangeIni.Enabled  :=  false;
            EdRangeIni.Visible  :=  false;
            EdRangeFin.Enabled  :=  false;
            EdRangeFin.Visible  :=  false;
            EdSeqArq.ReadOnly   :=  false;
            Label1.Visible      :=  false;
            Label2.Visible      :=  false;
          end;
        1:
          begin
            DriveComboBox1.Enabled  :=  false;
            diretorio.Enabled       :=  false;
            FileListBox1.Enabled    :=  false;
            edTot.Text              :=  '0';
          end;
      end;
    end;
end;
procedure TFrmCadSedex.BitBtn1Click(Sender: TObject);

begin
if DBCboSdxServ.KeyValue = null then
  begin
    Application.MessageBox(PChar('Escolha Um Servi�o'),'ADS',0);
    DBCboSdxServ.SetFocus;
    exit;
  end
else
  begin
    case tag of
      0:
        begin
          if DBCboSdxServ.KeyValue = 1015 then
            cargaarqar;
        end;
      1:  cargarange;
    end;
  end;
end;
procedure TFrmCadSedex.cargaarqar;
var i:integer;
  msg : string;
begin
  erro:=false;
  Conta := 0;
  if (diretorio.FileList.FileName = '') then
    begin
        Application.MessageBox('Selecione um Arquivo','ADS',0);
        FileListBox1.SetFocus;
    end
  else
    begin
      AssignFile(Lista,Diretorio.FileList.FileName);
      Reset(lista);
      While Not Eof(Lista) do
        Begin
          conta:=conta+1;
          edTot.Text  :=  inttostr(conta);
          ReadLn(Lista,Linha);
          Linha := Linha + ';';
          ContVirg   := 0;
          virgant    := 1;
          for i:=1 to length(Trim(linha)) do
            begin
              if copy(linha,i,1) = ';' then
                begin
                  ContVirg  := ContVirg + 1;
                  case ContVirg of
                    1: NOME        := Trim(copy(linha,virgant,(i-virgant)));
                    2: LOGRADOURO  := Trim(copy(linha,virgant,(i -virgant)));
                    //3: NUM         := Trim(copy(linha,virgant,(i -virgant)));
                    //4: COMPL       := Trim(copy(linha,virgant,(i -virgant)));
    //                    6: CEP3        := Trim(copy(linha,virgant,(i -virgant)));
                    3: BAIRRO      := Trim(copy(linha,virgant,(i -virgant)));
                    4: CIDADE      := Trim(copy(linha,virgant,(i -virgant)));
                    5: ESTADO      := Trim(copy(linha,virgant,(i -virgant)));
                    6: CEP5        := Trim(copy(linha,virgant,(i -virgant)));
                  end;
                  virgant             := i + 1;
                end;
            end;

            mCEP:= copy(CEP5,1,5)+copy(cep5,7,3);//+CEP3;
            LOGRADOURO := LOGRADOURO;// + ' ' + NUM + ' '+ COMPL;
            v_soma := 0;
            if copy(mcep,1,2) = '00' then
              begin
                erro := true;
                msg	 := msg+'Linha: '+ edTot.Text + ' CEP: '+mCEP;
              end
            else if copy(mcep,1,3) = '000' then
              begin
                erro := true;
                msg	 := msg+'Linha: '+ edTot.Text + ' CEP: '+mCEP;
              end
            else if copy(mcep,1,4) = '0000' then
              begin
                erro := true;
                msg	 := msg+'Linha: '+ edTot.Text + ' CEP: '+mCEP;
              end
            else if copy(mcep,1,5) = '00000' then
              begin
                erro := true;
                msg	 := msg+'Linha: '+ edTot.Text + ' CEP: '+mCEP;
              end
            else if copy(mcep,1,6) = '000000' then
              begin
                erro := true;
                msg	 := msg+'Linha: '+ edTot.Text + ' CEP: '+mCEP;
              end
            else if copy(mcep,1,7) = '0000000' then
              begin
                erro := true;
                msg	 := msg+'Linha: '+ edTot.Text + ' CEP: '+mCEP;
              end
            else if copy(mcep,1,8) = '00000000' then
              begin
                erro := true;
                msg	 := msg+'Linha: '+ edTot.Text + ' CEP: '+mCEP;
              end;

            for i:= 1 to 8 do
              begin
                try
                  v_soma := v_soma + strtoint(copy(mCEP,i,1));

                except on e: exception do
                  begin
                    Application.MessageBox(PChar('Favor verificar o Arquivo.'+chr(10)+'Coluna CEP Disposicionada '+'Linha: '+edTot.Text),'ADS',0);
                    erro:=true;
                    SetFocus;
                    exit;
                  end;
                end;
              end;
        end;
   if erro=false then
     begin
        With dm do
          Begin
             //Busca a �ltima sequ�ncia de Carga utilizada
             SqlAux1.Close;
             SqlAux1.SQL.Clear;
             SqlAux1.SQL.Add('select current_date');
             SqlAux1.Open;
             dtseq  := SqlAux1.Fields[0].AsString;
             SqlAux1.Close;
             SqlAux1.SQL.Clear;
             SqlAux1.SQL.Add('select seq from seqarq where (dat = :dt)');
             SqlAux1.Params[0].AsString :=  formatdatetime('mm/dd/yyyy',strtodate(dtseq));
             SqlAux1.Open;
             case SqlAux1.RecordCount of
               0: EdSeqArq.Text  :=  '0';
               1: begin
                    case SqlAux1.Fields[0].Value of
                     0..8 : EdSeqArq.Text  :=  inttostr(SqlAux1.Fields[0].Value+1);
                     9:EdSeqArq.Text  :=  '65';
                     65..89:EdSeqArq.Text  :=  inttostr(SqlAux1.Fields[0].Value+1);
                     90:  begin
                           Application.MessageBox('Sequ�ncia do Arquivo Ultrapassou o limite','ADS',64);
                           exit;
                          end;
                    end;
                  end;
             end;
             //Busca os ranges dos correios n�o usados.
             SqlAux2.Close;
             SqlAux2.SQL.Clear;
             SqlAux2.SQL.Add('select tbsdxect_num,tbsdxect_dv from tbsdx_ect where (tbsdx_use is null) and (tbsdxect_prod = :prod ) order by tbsdxect_num');
             SqlAux2.Params[0].AsString :=  SqlSdxServtbsdxserv_prod.AsString;
             SqlAux2.Open;
             if (SqlAux2.RecordCount = 0) or (SqlAux2.RecordCount < Conta) then
               begin
                 Application.MessageBox(Pchar('Quantidade de Ranges Menor que Qtde de AR'+chr(10)+'Informe o CPD'),'ADS',0);
                 exit;
               end
          else
            begin
             SqlAux2.First;
          mteste :=SqlAux2.Fields[0].AsString+SqlAux2.Fields[1].AsString;
          Reset(lista);
          Conta :=0;
          While Not Eof(Lista) do
            Begin
              conta:=conta+1;
              edTot.Text  :=  inttostr(conta);
              ReadLn(Lista,Linha);
              Linha := Linha + ';';
              ContVirg   := 0;
              virgant    := 1;
              for i:=1 to length(Trim(linha)) do
                begin
                  if copy(linha,i,1) = ';' then
                    begin
                      ContVirg  := ContVirg + 1;
                      case ContVirg of
                        1: NOME        := Trim(copy(linha,virgant,(i-virgant)));
                        2: LOGRADOURO  := Trim(copy(linha,virgant,(i -virgant)));
                        //3: NUM         := Trim(copy(linha,virgant,(i -virgant)));
                        //4: COMPL       := Trim(copy(linha,virgant,(i -virgant)));
        //                    6: CEP3        := Trim(copy(linha,virgant,(i -virgant)));
                        3: BAIRRO      := Trim(copy(linha,virgant,(i -virgant)));
                        4: CIDADE      := Trim(copy(linha,virgant,(i -virgant)));
                        5: ESTADO      := Trim(copy(linha,virgant,(i -virgant)));
                        6: CEP5        := Trim(copy(linha,virgant,(i -virgant)));
                      end;
                      virgant             := i + 1;
                    end;
                end;

                mCEP:= copy(CEP5,1,5)+copy(cep5,7,3);//+CEP3;
                LOGRADOURO := LOGRADOURO;// + ' ' + NUM + ' '+ COMPL;
                v_soma := 0;
                  for i:= 1 to 8 do
                  begin
                    try
                      v_soma := v_soma + strtoint(copy(mCEP,i,1));
                    except on e: exception do
                      begin
                        Application.MessageBox(PChar('Favor verificar o Arquivo.'+chr(10)+'Coluna CEP Disposicionada'),'ADS',0);
                        SetFocus;
                        exit;
                      end;
                    end;
                  end;
                v_soma := strtoint(copy(intTostr(v_soma),length(inttostr(v_soma)),1));
                if v_soma = 0 then
                  CEPr := mCEP + '0'
                else
                  begin
                    v_soma := 10 - v_soma;
                    CEPr := '\/'+mCEP + intToStr(v_soma)+'\\';
                  end;
              //Gravar dados
                SqlSdx1.Close;
                SqlSdx1.Sql.Clear;
                SqlSdx1.Sql.Add('insert into tbsdx (sdx_codcli,sdx_idcli,sdx_numobj1,sdx_numobj5,');
                SqlSdx1.Sql.Add('sdx_paisorigem,sdx_numseqreg,sdx_numseqarq,sdx_nomdest,sdx_endedest,sdx_cidade,');
                SqlSdx1.Sql.Add('sdx_uf,sdx_cep,sdx_numobj3,sdx_numobj4,sdx_dtcarga,sdx_seqcarga,sdx_numobj2,sdx_cepnet,sdx_numobj,sdx_codusu,sdx_qtd,sdx_peso)');
                SqlSdx1.Sql.Add('values (:sdx_codcli,:sdx_idcli,:sdx_numobj1,:sdx_numobj5,:sdx_paisorigem,');
                //                                0           1           2           3            4
                SqlSdx1.Sql.Add(':sdx_codoperacao,:sdx_conteudo,:sdx_nomdest,:sdx_endedest,:sdx_cidade,:sdx_uf,:sdx_cep,:sdx_numobj3,');
                //                        5                 6            7            8            9       10     11        12
                SqlSdx1.Sql.Add(':sdx_numobj4,(SELECT CURRENT_DATE),:seqcarga,:sdx_numobj2,E:sdx_cepnet,:sdx_numobj,:sdx_codusu,:sdx_qtd,0.058)');
                //                    13                            14         15           16            17            18         19      20
                SqlSdx1.Params[0].AsString  := '99';
                SqlSdx1.Params[1].AsString  := '99';
                SqlSdx1.Params[2].AsString  := 'AR'+ SqlAux2.Fields[0].AsString + SqlAux2.Fields[1].AsString+ 'BP' ;
                SqlSdx1.Params[3].AsString  :=  SqlAux2.Fields[0].AsString + SqlAux2.Fields[1].AsString;
                SqlSdx1.Params[4].AsString  := 'BR';
                SqlSdx1.Params[5].AsString  := '99'; // NUMSEQREG
                SqlSdx1.Params[6].AsString  := '99';//NUMSEQARQ
                SqlSdx1.Params[7].AsString  := copy(NOME,1,50);
                SqlSdx1.Params[8].AsString  := copy(LOGRADOURO,1,50);
                SqlSdx1.Params[9].AsString  := copy(CIDADE,1,30);
                SqlSdx1.Params[10].AsString := copy(ESTADO,1,2);
                SqlSdx1.Params[11].AsString := mCEP;
                SqlSdx1.Params[12].AsString := 'DB'+ SqlAux2.Fields[0].AsString + SqlAux2.Fields[1].AsString + 'BR';// LADO ESQUERDO
//                  SqlSdx1.Params[12].AsString := 'SY'+ SqlAux2.Fields[0].AsString + SqlAux2.Fields[1].AsString + 'BR';// LADO ESQUERDO
                SqlSdx1.Params[13].AsString := 'AR'+ SqlAux2.Fields[0].AsString + SqlAux2.Fields[1].AsString + 'BP'; // LADO DIREITO
                SqlSdx1.Params[14].AsInteger := strtoint(EdSeqArq.Text);
                SqlSdx1.Params[15].AsString := 'DB'+ SqlAux2.Fields[0].AsString + SqlAux2.Fields[1].AsString + 'BR' ;
//                  SqlSdx1.Params[15].AsString := 'SY'+ SqlAux2.Fields[0].AsString + SqlAux2.Fields[1].AsString + 'BR' ;
                SqlSdx1.Params[16].AsString := cepr;
                SqlSdx1.Params[17].AsString  :=  SqlAux2.Fields[0].AsString + SqlAux2.Fields[1].AsString;
                SqlSdx1.Params[18].AsInteger :=  sqlcga_acessocodigo.AsInteger;
                SqlSdx1.Params[19].AsInteger :=  1; // fixo
                SqlSdx1.ExecSql;
                SqlAux3.Close;
                SqlAux3.SQL.Clear;
                SqlAux3.SQL.Add('update tbsdx_ect set tbsdx_use = :S where (tbsdxect_num = :num) and (tbsdxect_prod = :prod)');
                SqlAux3.Params[0].AsString := 'S';
                SqlAux3.Params[1].AsString := SqlAux2.Fields[0].AsString;
                SqlAux3.Params[2].AsString := SqlSdxServtbsdxserv_prod.AsString;
                SqlAux3.ExecSQL;
                SqlAux2.Next;
              end;
            end;
        altseq;
        end;
        Showmessage('Fim de Carga!');
     end
   else
    Application.MessageBox(PChar('Erro Na Carga!'+chr(10)+msg),'ADS',MB_ICONINFORMATION);
  end;
end;
procedure TFrmCadSedex.cargarange;
var
i:integer;
begin
  edTot.Text  :=  '0';
  if (((trim(EdRangeIni.Text) = '') or (trim(EdRangeFin.Text) = '')) or
     (StrToInt64(EdRangeIni.Text) > StrToInt64(EdRangeFin.Text))) then
      begin
       Application.MessageBox('Ranges Incopat�veis','ADS',0);
       EdRangeIni.SetFocus;
       exit;
      end
  else
    begin
      with dm do
        begin
          for I := StrToInt64(EdRangeIni.Text) to StrToInt64(EdRangeFin.Text) do
            begin
              sel :=  'insert into tbsdx_ect (tbsdxect_num,tbsdxect_dv,tbsdxect_prod) values (:ectnum,:dv,:prod)';
              SqlAux1.Close;
              SqlAux1.SQL.Clear;
              SqlAux1.SQL.Add(sel);
              SqlAux1.Params[0].AsString  :=  GeraNT(inttostr(i),8);
              SqlAux1.Params[1].AsString  :=  vcobjnet(gerant(inttostr(i),8));
              SqlAux1.Params[2].AsString  :=  SqlSdxServtbsdxserv_prod.AsString;
              try
                SqlAux1.ExecSQL;
                edTot.Text  :=  IntToStr(strtoint(edTot.Text)+1);
                edTot.Refresh;
              except
                begin
                  Application.MessageBox(PChar('Houve Erro ao incluir o Range: '+inttostr(i)+chr(10)+'Carregue Novamente'),'ADS',0);
                  EdRangeIni.Text := inttostr(i);
                  BtnCarrega.SetFocus;
                end;
              end;
            end;
          Application.MessageBox('Carga de Range Ok','ADS',ID_OK);
        end;
    end;

end;

procedure TFrmCadSedex.altseq;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      case strtoint(EdSeqArq.Text) of
        0:  SqlAux1.SQL.Add('insert into seqarq (seq,dat) values (:seq,:dat)');
        else   SqlAux1.SQL.Add('update seqarq set seq = :seq where (dat = :dat)');
      end;
      SqlAux1.Params[0].Value     :=  StrToInt(EdSeqArq.Text);
      SqlAux1.Params[1].AsString  :=  formatdatetime('mm/dd/yyyy',strtodate(dtseq));
      try SqlAux1.ExecSQL;
      except on e: exception do
        begin
          Application.MessageBox('N�o foi poss�vel incluir ou altera sequ�ncia do arquivo,'+#10+
          'Mas foi conclu�do a carga, Avise o CPD','ADS',64);
          exit;
        end;
      end;
    end;
end;
end.
