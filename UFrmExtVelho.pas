unit UFrmExtVelho;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, StdCtrls, DB, ExtCtrls;

type
  TFrmExtVelho = class(TForm)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    LblMot: TLabel;
    Label6: TLabel;
    EdBaixa: TEdit;
    EdCaixa: TEdit;
    EdRem: TEdit;
    DbgExt: TDBGrid;
    EdQt: TEdit;
    Label2: TLabel;
    EdCodFun: TEdit;
    procedure EdCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure EdBaixaKeyPress(Sender: TObject; var Key: Char);
    procedure EdRemKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdCodFunKeyPress(Sender: TObject; var Key: Char);
  private
    CodInt : STRING;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExtVelho: TFrmExtVelho;

implementation

Uses UDmDados,UFrmConsPv, UFrmCargPv,URelSulAm,UComplPv,UFrmConsultaPv,
     UImpRelSul,URImpPv,UReparar,UFunc, UFrmAds1;

{$R *.dfm}

procedure TFrmExtVelho.EdCaixaKeyPress(Sender: TObject; var Key: Char);
Begin
  If Key = #13 Then
     Begin
       If Not Dmdados.TbCga91.{FindKey}([EdCaixa.Text])Then
          Begin
            DmDados.TbCga91.Append;
            DmDados.TbCga91.Edit;
            DmDados.TbCga91CG91_CAIXA.Value := EdCaixa.Text;
            EdQt.Text := IntToStr(DmDados.TbCga33.RecordCount);
            EdQt.Refresh;
            DmDados.TbCga91.Edit;
            DmDados.TbCga91.Post;
            EdBaixa.SetFocus;
          End
       Else
          Begin
            EdBaixa.SetFocus;
            EdQt.Text := IntToStr(DmDados.TbCga33.RecordCount);
            EdQt.Refresh;
          End;
     End;
End;

procedure TFrmExtVelho.EdBaixaKeyPress(Sender: TObject; var Key: Char);
Begin
  If Key = #13 Then
    Begin
      If Not Dmdados.TbCga06.{FindKey}([EdBaixa.Text]) Then
        Begin
          ShowMessage('Baixa não Cadastrada');
          EdBaixa.Text := '';
          EdBaixa.SetFocus;
        End
      Else
        Begin
          LblMot.Caption := Dmdados.TbCga06CG05_MOT.Value;
          EdRem.SetFocus;
        End;
    End;
End;

procedure TFrmExtVelho.EdRemKeyPress(Sender: TObject; var Key: Char);
Var Dup: Real;
Begin
  If Key = #13 Then
    Begin
      Verifica(EdRem.Text);
      DmDados.TbCgaAcesso.Locate('CGA_Login',FrmAds1.StsMenu.Panels[1].Text,[LoCaseInsensitive]);
     if CodInt <> EdRem.Text then
       begin
      If Length(EdRem.Text) = 22 Then
        Begin
//////////////////////////Se número de remessa for encontrado/////////////////////////////
          CodInt:=EdRem.Text;
          If DmDados.TbCga33A.{FindKey}([Copy(EdRem.Text,1,14)])Then
            Begin
              Dmdados.TbCga33B.Last;
              {If(DmDados.TbCga33BCG33_DUP.Value=20)Then
                Begin
                  ShowMessage('Numero de Duplicidades Excedidas');
                  EdRem.Text := '';
                  EdRem.SetFocus;
                End
              Else}
                Begin
                  Dup := (DmDados.TbCga33BCG33_DUP.Value+1);
//                ShowMessage('Remessa já Cadastrada pela  '+(FloatToStr(DmDados.TbCga33BCG33_DUP.Value+1))+'ª  vez');
                  Dmdados.TbCga33A.Edit;
                  Dmdados.TbCga33A.Append;
                  DmDados.TbCga33ACG33_REMES.Value    := Copy(EdRem.Text,1,14);
                  Dmdados.TbCga33ACG33_DUP.Value      := Dup;
                  Dmdados.TbCga33ACG33_DTEXT.Value    := StrToDate(Copy(EdRem.Text,15,2)+'/'+Copy(EdRem.Text,17,2)+'/'+Copy(EdRem.Text,19,4));
                  DmDados.TbCga33ACG33_CODBAIXA.Value := Edbaixa.Text;
                  DmDados.TbCga33ACG33_BAIXA.Value    := LblMot.Caption;
                  DmDados.TbCga33ACG33_DTBAIXA.Value  := Date;
                  Dmdados.TbCga33ACG33_CODBRAD.Value  := Dmdados.TbCga06CG05_CODBRAD.Value;
                  Dmdados.TbCga33ACG33_CAIXA.Value    := EdCaixa.Text;
                  Dmdados.TbCga33ACG33_CODUSU.Value   := DmDados.TbCgaAcessoCGA_Codigo.Value;
                  Dmdados.TbCga33A.Edit;
                  Dmdados.TbCga33A.Post;
                  Dmdados.TbCga33.Refresh;
                  Dmdados.TbCga33B.Refresh;
                  Dmdados.TbCga33A.Refresh;
                  DbgExt.Refresh;
                  EdQt.Text := IntToStr(DmDados.TbCga33.RecordCount);
                  EdQt.Refresh;
                  EdRem.Text := '';
                  EdRem.SetFocus;
                End;
            End
          Else
            Begin
              Dmdados.TbCga33A.Append;
              Dmdados.TbCga33A.Edit;
              DmDados.TbCga33ACG33_REMES.Value    := Copy(EdRem.Text,1,14);
              Dmdados.TbCga33ACG33_DUP.Value      := 1;
              Dmdados.TbCga33ACG33_DTEXT.Value    := StrToDate(Copy(EdRem.Text,15,2)+'/'+Copy(EdRem.Text,17,2)+'/'+Copy(EdRem.Text,19,4));
              DmDados.TbCga33ACG33_CODBAIXA.Value := Edbaixa.Text;
              DmDados.TbCga33ACG33_BAIXA.Value    := LblMot.Caption;
              DmDados.TbCga33ACG33_CODBRAD.Value  := DmDados.TbCga06CG05_CODBRAD.Value;
              DmDados.TbCga33ACG33_DTBAIXA.Value  := Date;
              Dmdados.TbCga33ACG33_CAIXA.Value    := EdCaixa.Text;
              Dmdados.TbCga33ACG33_CODUSU.Value   := DmDados.TbCgaAcessoCGA_Codigo.Value;
              Dmdados.TbCga33A.Edit;
              Dmdados.TbCga33A.Post;
              Dmdados.TbCga33.Refresh;
              Dmdados.TbCga33B.Refresh;
              Dmdados.TbCga33A.Refresh;
              DbgExt.Refresh;
              EdQt.Text := IntToStr(DmDados.TbCga33.RecordCount);
              EdQt.Refresh;
              EdRem.Text := '';
              EdRem.SetFocus;
            End
        End
      Else
        Begin
          ShowMessage('Numero de Remessa incorreto');
          EdRem.Text := '';
          EdRem.SetFocus;
        End
    End
   Else
     Begin
       EdRem.Clear;
       EdRem.SetFocus;
     END;
    END;
End;
procedure TFrmExtVelho.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Dmdados.TbCga91.Close;
  DmDados.TbCga33.Close;
  DmDados.TbCga33A.Close;
  DmDados.TbCga33B.Close;
  DmDados.TblCga62.Close;
  Action := CaFree;
end;

procedure TFrmExtVelho.EdCodFunKeyPress(Sender: TObject; var Key: Char);
Begin
  If Key = #13 Then
    Begin
      If Not DmDados.TblCga62.{FindKey}([EdCodFun.Text]) Then
        Begin
          ShowMessage('Funcionário Não Cadastrado');
          EdCodFun.Text := '';
          EdCodFun.SetFocus;
        End
      Else
       Begin
         FrmExtVelho.Caption := DmDados.TblCga62CG62_NOME.Value;
         EdCaixa.SetFocus;
       End;
    End;
End;

End.
