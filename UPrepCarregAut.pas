unit UPrepCarregAut;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons, ShellCtrls;

type
  TFrmPrepCarregAut = class(TForm)
    ScrollBox1: TScrollBox;
    Bevel1: TBevel;
    prog: TProgressBar;
    BitBtn5: TBitBtn;
    EdQt: TEdit;
    Panel11: TPanel;
    BitBtn3: TBitBtn;
    ListEmail: TListBox;
    procedure BitBtn3Click(Sender: TObject);
    procedure FileArquivosDblClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FileArquivosAddFolder(Sender: TObject; AFolder: TShellFolder;
      var CanAdd: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrepCarregAut: TFrmPrepCarregAut;

implementation

uses U_Func, U_CadAuto_Christian_Science;

{$R *.dfm}

procedure TFrmPrepCarregAut.BitBtn3Click(Sender: TObject);
var
  email,novoarq : textfile;
  linha : string;
  conta : integer;
  arq   : string;
begin
 // assignfile(email,{FileArquivos.Root+FileArquivos.Selected.Caption});
  reset(email);
  readln(email,linha);
  EdQt.Text := '0';
  prog.Position := 0;
  conta := 0;
  prog.Max := ListEmail.Items.Count;
  while not eof(email) do
    begin
      if ('Message-ID:' = (copy(linha,1,11))) then
        begin
          if conta <> 1 then
            begin
              if EdQt.Text = '0' then
                begin
                  conta := 1;
                end;
            end
          else
            begin
              arq := 'c:\arauto\arq'+formatdatetime('ddmmyyyy',date)+formatdatetime('hhmmsszzz',time)+'.txt';
              AssignFile(novoarq,arq);
              Rewrite(novoarq);
              while '------_=_NextPart' <> copy(linha,1,17) do
                begin
                  linha := acerta(linha);
                  Writeln(novoarq,linha);
                  readln(email,linha);
                  prog.Position := prog.Position + 1;
                  prog.Refresh;
                end;
              EdQt.Text := inttostr(1+strtoint(EdQt.Text));
              closefile(novoarq);
            end;
        end;
      readln(email,linha);
      prog.Position := prog.Position + 1;
      prog.Refresh;
    end;
    CloseFile(email);
  {renamefile(FileArquivos.Root+FileArquivos.Selected.Caption,FileArquivos.Root+FileArquivos.Selected.Caption+'.xxx');
  FileArquivos.Refresh; }
  application.MessageBox('Geração finalizada com sucesso','Ads',MB_OK+MB_ICONINFORMATION);
end;

procedure TFrmPrepCarregAut.FileArquivosDblClick(Sender: TObject);
begin
 { ListEmail.Items.LoadFromFile(FileArquivos.Root+FileArquivos.Selected.Caption); }
end;

procedure TFrmPrepCarregAut.BitBtn5Click(Sender: TObject);
begin
  {FrmCadAutoChristianSciense.FileArquivos.Refresh; }
  close;
end;

procedure TFrmPrepCarregAut.FileArquivosAddFolder(Sender: TObject;
  AFolder: TShellFolder; var CanAdd: Boolean);
var
XFilterExt, XExt: string;

begin
XFilterExt := ExtractFileExt('*.eml');
XExt := ExtractFileExt(AFolder.PathName);
if (CompareText(XExt, XFilterExt) = 0) or AFolder.IsFolder then
CanAdd := True
else
CanAdd := False;
end;

end.

