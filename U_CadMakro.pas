{$WARN UNIT_PLATFORM OFF}
unit U_CadMakro;

interface

uses
  SysUtils,Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DBCtrls, Buttons, ExtCtrls,
  FileCtrl, ShellCtrls;

type
  Tfrmmkmakro = class(TForm)
    dblcLoja: TDBLookupComboBox;
    dblcEdicao: TDBLookupComboBox;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    dblcDivisao: TDBLookupComboBox;
    lbLoja: TLabel;
    lbdivisao: TLabel;
    lbedicao: TLabel;
    Edarq: TEdit;
    edTot: TEdit;
    captot: TLabel;
    procedure BitBtn3Click(Sender: TObject);
    procedure dblcLojaClick(Sender: TObject);
    procedure dblcLojaMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dblcDivisaoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dblcEdicaoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dblcLojaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dblcLojaMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dblcDivisaoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dblcEdicaoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DirectoryTreeView1MouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn1Click(Sender: TObject);
    procedure FileListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure BitBtn2Click(Sender: TObject);
    procedure FileListKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure diretorioKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure diretorioChange(Sender: TObject; Node: TTreeNode);
    procedure diretorioClick(Sender: TObject);
    procedure dblcDivisaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmmkmakro: Tfrmmkmakro;
  key :integer;

implementation

Uses Dmdados,U_Func;

{$R *.dfm}

procedure Tfrmmkmakro.BitBtn3Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmmkmakro.dblcLojaClick(Sender: TObject);
  begin
    Dm.SqlCgaLojaDivi.Close;
    Dm.SqlCgaLojaDivi.Sql.Clear;
    Dm.SqlCgaLojaDivi.Sql.Add('select * from cga106divisao inner join cga109cadloja');
    Dm.SqlCgaLojaDivi.Sql.Add('on cga109cadloja.codloja = cga106divisao.codloja where');
    Dm.SqlCgaLojaDivi.Sql.Add('cga106divisao.codloja = :cgadivi  ');
    Dm.SqlCgaLojaDivi.Sql.Add('order by cga106divisao.coddiv');
    Dm.SqlCgaLojaDivi.Params[0].Value := dm.SqlCga109.Fields[0].Value;
    Dm.SqlCgaLojaDivi.ExecSql;
    Dm.SqlCgaLojaDivi.Open;
    {Escolha da Loja}
//     if dblcloja.KeyValue < 10 then
//       FileList.Directory.FileMask :=  '?????0'+intToStr(dblcLoja.KeyValue)+'.txt'
//      else
//        FileList.Directory.FileMask :=  '?????'+intToStr(dblcLoja.KeyValue)+'.txt';
  end;
procedure Tfrmmkmakro.dblcLojaMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 lbLoja.Font.Color    := clNavy;
 lbdivisao.Font.Color := clWhite;
 lbedicao.Font.Color  := clWhite;
end;

procedure Tfrmmkmakro.dblcDivisaoMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 lbLoja.Font.Color    := clWhite;
 lbdivisao.Font.Color := clNavy;
 lbedicao.Font.Color  := clWhite;
end;

procedure Tfrmmkmakro.dblcEdicaoMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 lbLoja.Font.Color    := clWhite;
 lbdivisao.Font.Color := clWhite;
 lbedicao.Font.Color  := clNavy;
end;

procedure Tfrmmkmakro.dblcLojaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 lbLoja.Font.Color    := clNavy;
 lbdivisao.Font.Color := clWhite;
 lbedicao.Font.Color  := clWhite;
end;

procedure Tfrmmkmakro.dblcLojaMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 lbLoja.Font.Color    := $00FEF0CB;
 lbdivisao.Font.Color := clWhite;
 lbedicao.Font.Color  := clWhite;
end;

procedure Tfrmmkmakro.dblcDivisaoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 lbLoja.Font.Color    := clWhite;
 lbdivisao.Font.Color := $00FEF0CB;
 lbedicao.Font.Color  := clWhite;
end;

procedure Tfrmmkmakro.dblcEdicaoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 lbLoja.Font.Color    := clWhite;
 lbdivisao.Font.Color := clWhite;
 lbedicao.Font.Color  := $00FEF0CB;
end;

procedure Tfrmmkmakro.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 lbLoja.Font.Color    := clWhite;
 lbdivisao.Font.Color := clWhite;
 lbedicao.Font.Color  := clWhite;
end;

procedure Tfrmmkmakro.DirectoryTreeView1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 lbLoja.Font.Color    := clWhite;
 lbdivisao.Font.Color := clWhite;
 lbedicao.Font.Color  := clWhite;
end;

procedure Tfrmmkmakro.BitBtn1Click(Sender: TObject);
{Ler arquivos TXT e carregar na tabela cga110makro}
var
  Lista           :TextFile;
  Linha           :String;
  Conta :Integer;

begin
  dm.SqlCgaMakro.Close;
  dm.SqlCgaMakro.Sql.Clear;
  Conta := 0;

  // Na linha abaixo n�o foi poss�vel fazer a convers�o

  //AssignFile(Lista,FileList.Directory.Location+FileList.Selected.Caption);
  Reset(lista);
  While Not Eof(Lista) do
      Begin
      Conta := Conta+1;
      edTot.Text := InttoStr(conta);
      edtot.Refresh;
      dm.Sqlaux1.Close;
      dm.Sqlaux1.Sql.Clear;
      Dm.Sqlaux1.Sql.Add('insert into cga110makro (mkcod,mkempresa,mkendereco,mkcomplemento,mkcep,mkcep1,mkcodfilial,mkcoddiv,mkcodloja,mkedicao)');
      Dm.Sqlaux1.Sql.Add('values (:mkcod,:mkempresa,:mkendereco,:mkcomplemento,:mkcep,:mkcep1,:mkcodfilial,:mkcoddiv,:mkcodloja,:mkedicao)');
      ReadLn(Lista,Linha);
      Dm.Sqlaux1.Params[0].Value  := Remove(Trim(Linha));
      ReadLn(Lista,Linha);
      Dm.Sqlaux1.Params[1].Value  := Remove(Trim(Linha));
      ReadLn(Lista,Linha);
      Dm.Sqlaux1.Params[2].Value  := Remove(Linha);
      ReadLn(Lista,Linha);
      Dm.Sqlaux1.Params[3].Value  := Remove(Linha);
      ReadLn(Lista,Linha);
      Dm.Sqlaux1.Params[4].Value  := Remove(Linha);
      Dm.Sqlaux1.Params[5].Value  := copy(Linha,1,9);
      {Verificar Cep - Filial}
      Dm.SqlCga108.Close;
      Dm.SqlCga108.Sql.Clear;
      Dm.SqlCga108.Sql.Add('select * from cga108cadfaixacep where :cep between cepini and cepfim');
      Dm.SqlCga108.Params[0].AsString := copy(Linha,1,5)+Copy(Linha,7,9);
      Dm.SqlCga108.Open;
      Dm.Sqlaux1.Params[6].Value  := dm.SqlCga108codfilial.Value;
      {Cep Verificado}

      Dm.Sqlaux1.Params[7].Value  := dm.SqlCgaLojaDivicoddiv.Value;
      Dm.Sqlaux1.Params[8].Value  := dm.SqlCga109codloja.Value;
      Dm.Sqlaux1.Params[9].Value := dm.SqlCga105numedi.Value;
      Dm.SqlAux1.ExecSql;
      ReadLn(Lista,Linha);
      end;
      showmessage('Registros Carregados!');
    end;


procedure Tfrmmkmakro.FileListSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected = true then
    begin
      // Nas linhas abaixo n�o foi feita convers�o
      //EdArq.Text := filelist.directory.Location;
      //EdArq.Text := edarq.Text+filelist.Selected.Caption;
      EdArq.Refresh;
    end;
end;


procedure Tfrmmkmakro.BitBtn2Click(Sender: TObject);
begin
 // Nas linhas abaixo n�o foi feita a convers�o
 //self.Edarq.Text  := (FileList.Directory.Location+diretorio.Directory);
end;

procedure Tfrmmkmakro.FileListKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);

begin
if (key = 4115) or (key = 4117) then
    begin
     { tamanho := length(Diretorio.Path);
      tamanho := tamanho - 1;
      Diretorio.Update; }
      // Nas linhas abaixo n�o foram feitas as convers�es
      //Diretorio.Refresh;
      //filelist.Directory.Location := copy(Diretorio.Directory,1,tamanho);
    end;
end;

procedure Tfrmmkmakro.diretorioKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);

 begin
   if (key = 4115) or (key = 4117) then
      {tamanho := length(Diretorio.Path);
      tamanho := tamanho - 1;
      Diretorio.Update; }

      // Na linha abaixo n�o foi feita a convers�o
      //Diretorio.Refresh;
      //filelist.Directory.Location := copy(Diretorio.Directory,1,tamanho);
    end;
procedure Tfrmmkmakro.diretorioChange(Sender: TObject; Node: TTreeNode);

begin
      {tamanho := length(Diretorio.Path);
      tamanho := tamanho - 1;
      Diretorio.Update; }

      // nas linhas abaixo n�o foram feitas as convers�es
      //Diretorio.Refresh;
      //filelist.Directory.Location := copy(Diretorio.Directory,1,tamanho);
end;

procedure Tfrmmkmakro.diretorioClick(Sender: TObject);

 begin
   //tamanho := length(Diretorio.Path);
   // na linha abaixo n�o foi feita a convers�o
   //filelist.Directory.Location := copy(Diretorio.Directory,1,tamanho);
end;

procedure Tfrmmkmakro.dblcDivisaoClick(Sender: TObject);
begin
// Nas linhas abaixo n�o foram feitas as convers�es

{   if (dblcloja.KeyValue < 10) and (dblcdivisao.KeyValue <> null) then
//    FileList.Directory.FileMask := dblcdivisao.KeyValue+'LJ'+intToStr(dblcLoja.KeyValue)+'.txt'
    FileList.Directory.FileMask := dblcdivisao.KeyValue+'??0'+intToStr(dblcLoja.KeyValue)+'.txt'
    else
     if  dblcdivisao.KeyValue <> null then
      FileList.Directory.FileMask := dblcdivisao.KeyValue+'LJ'+intToStr(dblcLoja.KeyValue)+'.txt' }
   end;

end.
