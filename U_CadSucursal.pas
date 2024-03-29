unit U_CadSucursal;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, Mask, ComCtrls;

type
  TFrmCadSucursal = class(TForm)
    GroupBox2: TGroupBox;
    LabelCodigo: TLabel;
    MKEdCod: TMaskEdit;
    Label1: TLabel;
    EdNomeDestino: TEdit;
    GroupBox3: TGroupBox;
    LabelEndereco: TLabel;
    EdEndereco: TEdit;
    LabelCep: TLabel;
    LabelCidade: TLabel;
    EdCidade: TEdit;
    MKEdCep: TMaskEdit;
    LabelUf: TLabel;
    CBUf: TComboBox;
    BitBtnAlterar: TBitBtn;
    BitBtnLimpar: TBitBtn;
    DBGridAg: TDBGrid;
    BitBtnCancelar: TBitBtn;
    StsRemSdx: TStatusBar;
    MemoTip: TMemo;
    BitBtnSalvar: TBitBtn;
    BitBtnNovo: TBitBtn;
    BitBtnFechar: TBitBtn;
    procedure MKEdCepKeyPress(Sender: TObject; var Key: Char);
    procedure EdCidadeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdEnderecoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MKEdCepKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdNomeDestinoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MKEdCodClick(Sender: TObject);
    procedure MKEdCodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtnFecharClick(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure BitBtnNovoClick(Sender: TObject);
    procedure BitBtnSalvarClick(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure EdCodKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure DBGridAgKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridAgKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridAgCellClick(Column: TColumn);
    procedure altera;
    procedure atualiza;
    procedure salvar;
    procedure limpa;
    procedure BitBtnLimparClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure DBGridAgKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnSairClick(Sender: TObject);
    procedure BitBtnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure selagencia;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadSucursal: TFrmCadSucursal;

implementation

uses DmDados, ZAbstractDataset, ZDataset, U_Func;

{$R *.dfm}
{
  Limpa todos os campos do formul�rio
}
procedure TFrmCadSucursal.limpa;
begin
  if (NOT MKEdCod.ReadOnly) then
    MkEdCod.Clear;

  EdNomeDestino.Clear;
  MKEdCep.Clear;
  EdEndereco.Clear;
  EdCidade.Clear;
  CBUf.ItemIndex := -1;
  MkEdCod.SetFocus;
end;

procedure TFrmCadSucursal.MKEdCepKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
    SelectNext(ActiveControl , true,true);
end;

procedure TFrmCadSucursal.MKEdCepKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Length(StringReplace(MKEdCep.Text, ' ', '', [rfReplaceAll])) > 8)  
    AND NOT MKEdCod.ReadOnly then 
    selagencia;

end;

procedure TFrmCadSucursal.MKEdCodClick(Sender: TObject);
begin
  MKEdCod.SelectAll;
end;

procedure TFrmCadSucursal.MKEdCodKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  selagencia;
end;

procedure TFrmCadSucursal.BitBtnLimparClick(Sender: TObject);
begin
  limpa;
  BitBtnAlterar.Enabled := false;
end;

{
  Prepara o formul�rio para inclus�o de um novo registro
}
procedure TFrmCadSucursal.BitBtnNovoClick(Sender: TObject);
begin
  // Desativando tudo o que n�o precisa estar ativado para criar um novo registro
  BitBtnAlterar.Enabled := false;
  BitBtnNovo.Enabled := false;
  BitBtnSalvar.Enabled := true;
  BitBtnCancelar.Enabled := true;
  MemoTip.Visible := false;
  MKEdCod.ReadOnly := false;
  // Limpando os campos
  limpa;
end;

procedure TFrmCadSucursal.BtnSalvarClick(Sender: TObject);
begin
  salvar;
end;

procedure TFrmCadSucursal.salvar;
var codjuncao : Longint;
var s : String;
begin
  Try
    // Validando o c�digo da Ag�ncia
    if (NOT TryStrToInt(MkEdCod.Text, codjuncao)) then
      begin
        Application.MessageBox('C�digo inv�lido. Utilize somente n�meros.','ADS', ID_OK);
        MkEdCod.SetFocus;
        Exit;
      end;        

    s := MkEdCod.Text;
    // Verificando se j� n�o existe uma Ag�ncia com este c�digo
    with Dm do
      begin
        SqlAux1.close;
        SqlAux1.sql.Clear;
        SqlAux1.sql.Add('SELECT COUNT(1) as qt FROM tbbraddptos ag ');
        SqlAux1.sql.Add('WHERE ag.juncao = :cdjuncao ');
        SqlAux1.ParamByName('cdjuncao').AsInteger := codjuncao;
        SqlAux1.Open;
        if (SqlAux1.FieldByName('qt').AsInteger > 0) then
          begin
            Application.MessageBox('J� existe um cadastro com este C�digo.' + #13#10 +
              'Dica: Adicione um numero ao final caso seja necess�rio utilizar este c�digo mas ' + #13#10 +
              'ATEN��O, n�o se esque�a de utilizar o mesmo c�digo na planilha de envios', 'ADS', ID_OK);
            MkEdCod.SetFocus;
            exit;
          end;
        SqlAux1.close;
        SqlAux1.sql.Clear;
        SqlAux1.sql.Add('INSERT INTO tbbraddptos (juncao, depto, ender, cep, cidade, uf) ');
        SqlAux1.sql.Add('VALUES (:ag, :dpto, :end, :cep, :cid, :uf)');
        SqlAux1.ParamByName('ag').AsInteger := codjuncao;
        SqlAux1.ParamByName('dpto').AsString := Trim(EdNomeDestino.Text);
        SqlAux1.ParamByName('end').AsString := trim(EdEndereco.Text);
        SqlAux1.ParamByName('cep').AsString := trim(MkEdCep.Text);
        SqlAux1.ParamByName('cid').AsString := trim(EdCidade.Text);
        SqlAux1.ParamByName('uf').AsString := trim(CBUf.Text);
    
        SqlAux1.ExecSql;
        SqlTbBradDeptos.Refresh;
        application.MessageBox('Cadastro efetuado com sucesso!', 'ADS', MB_OK + MB_ICONINFORMATION);
        limpa;
        MkEdCod.Text := s;
        selagencia;      
        BitBtnSalvar.Enabled := false;
        BitBtnCancelar.Enabled := false;
        BitBtnAlterar.Enabled := false;
        BitBtnNovo.Enabled := true;
        MKEdCod.ReadOnly := false;
        MemoTip.Visible := true;        
      end;
  except on e: exception do
    begin
      application.MessageBox(PChar(e.Message), 'Ads', MB_OK + MB_ICONERROR);
    end;
  end;
end;


procedure TFrmCadSucursal.altera;
var codjuncao : Longint;
var s : string;
begin
  codjuncao := Dm.SqlTbBradDeptosjuncao.AsInteger;
  s := MKEdCod.Text;
  With Dm Do
    begin
      SqlAux1.Close;
      SqlAux1.Sql.Clear;
      SqlAux1.Sql.Add('UPDATE tbbraddptos SET depto = :nomedestino, ender = :end, ');
      SqlAux1.Sql.Add('cep = :cep, cidade = :cidade, uf = :uf ');
      SqlAux1.Sql.Add('WHERE juncao = :codjuncao');
      SqlAux1.ParamByName('nomedestino').AsString := Trim(EdNomeDestino.Text);
      SqlAux1.ParamByName('end').AsString := trim(EdEndereco.Text);
      SqlAux1.ParamByName('cep').AsString := trim(MkEdCep.Text);
      SqlAux1.ParamByName('cidade').AsString := trim(EdCidade.Text);
      SqlAux1.ParamByName('uf').AsString := trim(CBUf.Text);
      SqlAux1.ParamByName('codjuncao').AsInteger := codjuncao;
      try
        SqlAux1.ExecSql;
        SqlTbBradDeptos.Refresh;
        application.MessageBox('Altera��o conclu�da com sucesso!!!','Ads',MB_OK+MB_ICONINFORMATION);
        limpa;
        MKEdCod.Text := s;
        selagencia;      
        BitBtnSalvar.Enabled := false;
        BitBtnCancelar.Enabled := false;
        BitBtnAlterar.Enabled := false;
        BitBtnNovo.Enabled := true;
        MKEdCod.ReadOnly := false;
        MemoTip.Visible := true;
             
      except on e: exception do
        begin
          application.MessageBox(PChar(e.Message),'ADS', MB_OK + MB_ICONERROR);
        end;
      end;
    end;
end;

procedure TFrmCadSucursal.EdCidadeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if NOT MKEdCod.ReadOnly then 
    selagencia;
end;

procedure TFrmCadSucursal.EdCodKeyPress(Sender: TObject; var Key: Char);
begin
  if KEY = #13 then
    SelectNext(ActiveControl , true,true);
end;

procedure TFrmCadSucursal.EdEnderecoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if NOT MKEdCod.ReadOnly then 
    selagencia;
end;

procedure TFrmCadSucursal.EdNomeDestinoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if NOT MKEdCod.ReadOnly then 
    selagencia;
end;

procedure TFrmCadSucursal.Atualiza;
begin
  with Dm do
    begin
      MkEdCep.Text := SqlTbBradDeptoscep.Text;
      EdNomeDestino.Text := SqlTbBradDeptosdepto.Text;
      MkEdCod.Text := SqlTbBradDeptosjuncao.Text;
      EdEndereco.Text := SqlTbBradDeptosender.Text;
      EdCidade.Text := SqlTbBradDeptoscidade.Text;
      CBUf.ItemIndex := CBUf.Items.IndexOf(SqlTbBradDeptosuf.Text);
      BitBtnAlterar.Enabled := true;
    end;
end;

procedure TFrmCadSucursal.DBGridAgCellClick(Column: TColumn);
begin
  atualiza;
  if BitBtnCancelar.Enabled then
      BitBtnCancelar.Click;  
end;

procedure TFrmCadSucursal.DBGridAgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  atualiza;
  if BitBtnCancelar.Enabled then
      BitBtnCancelar.Click;  
end;

procedure TFrmCadSucursal.DBGridAgKeyPress(Sender: TObject; var Key: Char);
begin
  atualiza;
  if BitBtnCancelar.Enabled then
      BitBtnCancelar.Click;  
end;

procedure TFrmCadSucursal.DBGridAgKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  atualiza;
  if BitBtnCancelar.Enabled then
      BitBtnCancelar.Click;  
end;


procedure TFrmCadSucursal.BtnSairClick(Sender: TObject);
begin
  close;
end;

procedure TFrmCadSucursal.BitBtnSalvarClick(Sender: TObject);
begin
  // Validando Campos
  // Validando o CEP 
  if (Length(trim(MKEdCep.Text)) < 9) then
    begin
       application.MessageBox('CEP inv�lido!', 'Ads', MB_OK + MB_ICONERROR);
       MKEdCep.SetFocus;
       exit;
    end;

  // Validando o nome
  if (trim(EdNomeDestino.Text) = '') then
    begin
      application.MessageBox('Por favor preencha o campo Nome de Destino!', 'Ads', MB_OK + MB_ICONERROR);
      EdNomeDestino.SetFocus;
      exit;
    end;

  // Validando o endere�o
  if (trim(EdEndereco.Text) = '') then
    begin
      application.MessageBox('Por favor preencha o campo Endere�o!', 'Ads', MB_OK + MB_ICONERROR);
      EdEndereco.SetFocus;
      exit;
    end;

  // Validando a cidade
  if (trim(EdCidade.Text) = '') then
    begin
      application.MessageBox('Por favor preencha o campo Cidade!', 'Ads', MB_OK + MB_ICONERROR);
      EdCidade.SetFocus;
      exit;
    end;

  // Validando a UF
  if (CBUf.ItemIndex < 0) then
    begin
      application.MessageBox('Por favor selecione uma UF!', 'Ads', MB_OK + MB_ICONERROR);
      CBUf.SetFocus;
      exit;
    end;
   
  if (MKEdCod.ReadOnly) then   
    altera // edi��o
  else   
    salvar; // inclus�o

end;

procedure TFrmCadSucursal.BitBtnAlterarClick(Sender: TObject);
begin
  // Desativando tudo o que n�o precisa estar ativado para criar um novo registro
  MKEdCod.ReadOnly := true;
  BitBtnNovo.Enabled := false;
  BitBtnCancelar.Enabled := true;
  BitBtnSalvar.Enabled := true;
  MemoTip.Visible := false;
  BitBtnAlterar.Enabled := false;
end;

procedure TFrmCadSucursal.BitBtnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFrmCadSucursal.BitBtnCancelarClick(Sender: TObject);
var s: String;
begin
  if (MKEdCod.ReadOnly) then   // Cancelando uma edi��o
    begin
      s := MKEdCod.Text;
      limpa;
      MKEdCod.ReadOnly := false;
      MKEdCod.Text := s;
      selagencia;
      BitBtnAlterar.Enabled := true;
    end
  else   // Cancelando uma inclus�o
    limpa;

  BitBtnNovo.Enabled := true;
  MemoTip.Visible := true;
  BitBtnSalvar.Enabled := false;
  BitBtnCancelar.Enabled := false;  
  
end;

procedure TFrmCadSucursal.FormClick(Sender: TObject);
begin
  close;
end;

procedure TFrmCadSucursal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := cafree;
  Dm.SqlTbBradDeptos.Close;
end;



procedure TFrmCadSucursal.FormShow(Sender: TObject);
begin
  Dm.SqlTbBradDeptos.Refresh;
  DBGridAg.Refresh;
end;

{

}
procedure TFrmCadSucursal.selagencia;
var codjuncao : Longint;
var s, c : String;
begin

  if NOT TryStrToInt(MkEdCod.Text, codjuncao) then
    codjuncao := 0;

  if codjuncao > 0 then
    s := IntToStr(codjuncao)
  else
    s := '';

  c := trim(MKEdCep.Text);

  With Dm do
    begin
      SqlTbBradDeptos.Close;
      SqlTbBradDeptos.SQL.Clear;
      SqlTbBradDeptos.SQL.Add('SELECT * FROM tbbraddptos ');
      SqlTbBradDeptos.SQL.Add('WHERE CAST(juncao AS VARCHAR) LIKE :codjuncao ');
      SqlTbBradDeptos.SQL.Add(' AND depto ILIKE :depto AND REPLACE(cep, ''-'','''') LIKE :cep ');
      SqlTbBradDeptos.SQL.Add(' AND ender ILIKE :end  AND cidade ILIKE :cid ');
      SqlTbBradDeptos.SQL.Add('ORDER BY juncao LIMIT 100');

      SqlTbBradDeptos.ParamByName('codjuncao').AsString := s + '%';
      SqlTbBradDeptos.ParamByName('depto').AsString := '%' + EdNomeDestino.Text + '%';
      SqlTbBradDeptos.ParamByName('cep').AsString := StringReplace(c, '-', '', [rfReplaceAll]) + '%';
      SqlTbBradDeptos.ParamByName('cid').AsString := '%' + EdCidade.Text + '%';
      SqlTbBradDeptos.ParamByName('end').AsString := '%' + EdEndereco.Text + '%';
      SqlTbBradDeptos.Open;
    end;
  DBGridAg.Refresh;
end;

end.
