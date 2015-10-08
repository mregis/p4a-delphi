unit U_FrmCadNLido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, Grids, DBGrids, Buttons, ComCtrls;

type
  TFrmCadNlido = class(TForm)
    ScrollBox1: TScrollBox;
    Bevel1: TBevel;
    BtnIncluir: TBitBtn;
    BtnSalvar: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnDeletar: TBitBtn;
    BtnSair: TBitBtn;
    DBGridServnLido: TDBGrid;
    Panel3: TPanel;
    Qtde: TEdit;
    Servico: TDBLookupComboBox;
    Panel2: TPanel;
    BtnConsulta: TBitBtn;
    GrpBoxConsulta: TGroupBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    DateTimePicker1: TDateTimePicker;
    Panel4: TPanel;
    DateTimePicker2: TDateTimePicker;
    BtnPrint: TBitBtn;
    procedure BtnPrintClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure BtnConsultaClick(Sender: TObject);
    procedure DBGridServnLidoCellClick(Column: TColumn);
    procedure DBGridServnLidoDblClick(Sender: TObject);
    procedure BtnDeletarClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure DBGridServnLidoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridServnLidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridServnLidoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSairClick(Sender: TObject);
    procedure ServicoEnter(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure atudados;
    procedure vercpos(vez:integer);
  private
  aux:integer;
  erro:boolean;
  par0, par1 : String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadNlido: TFrmCadNlido;

implementation

uses DmDados, U_Func, U_FrmRlNLido;

{$R *.dfm}

procedure TFrmCadNlido.BtnAlterarClick(Sender: TObject);
begin
vercpos(aux);
  if erro=false then
    begin
      with dm do
        begin
          SqlAux1.Close;
          SqlAux1.SQL.Clear;
          SqlAux1.SQL.Add('update ads005_servnaolido set ads05servnlido_codserv = :codserv,ads05servnlido_qtd = :qtde,');
          SqlAux1.SQL.Add('ads05servnlido_dti = :dti where (ads05servnlido_id = :cod)');
          SqlAux1.Params[0].Value  :=  SqlServico.Fields[1].Value;
          SqlAux1.Params[1].Value  :=  strtoint64(Qtde.Text);
          SqlAux1.Params[2].AsDate :=  DateTimePicker1.Date;
          SqlAux1.Params[3].Value  :=  dm.SqlServNLido.Fields[0].Value;
          try
            SqlAux1.ExecSQL;
            SqlServNLido.Refresh;
            DBGridServnLido.Refresh;
            BtnIncluir.OnClick(self);
          except on e: exception do
            begin
              Application.MessageBox(PChar('Erro ao Cadastrar! '+e.Message),'ADS - Cadastro de Não Lidos',64);
              exit;
            end;
          end;
        end;
    end;
end;

procedure TFrmCadNlido.BtnConsultaClick(Sender: TObject);
var i: integer;
begin
  with dm do
    begin
      SqlAux1.Close;
      SqlAux1.SQL.Clear;
      SqlAux1.SQL.Add('Select * from ads005_servnaolido ');
      for i := 1 to GrpBoxConsulta.ControlCount do
        begin
          case i of
            1:  if (CheckBox2.Checked = true) then par0 :=  '(ads05servnlido_dti between :dt1 and :dt)';
            2:  if (CheckBox3.Checked = true) then par1 :=  '(ads05servnlido_codserv = :cod)';
          end;
        end;
      if (par0 <> '') then
      SqlAux1.SQL.Add('where '+par0)
      else if (par1 <> '') then
      SqlAux1.SQL.Add('where '+par1)
      else if ((par0 <> '') and (par1 <> '')) then
      SqlAux1.SQL.Add('where '+par1+' and '+par0);
      if (par0 <> '') then
        begin
          if ((DateTimePicker1.Date < DateTimePicker2.Date) or (DateTimePicker1.Date = DateTimePicker2.Date)) then
            begin
              SqlAux1.Params[0].AsDate  :=  DateTimePicker1.Date;
              SqlAux1.Params[1].AsDate  :=  DateTimePicker2.Date;
            end
          else if (DateTimePicker1.Date > DateTimePicker2.Date) then
            begin
              SqlAux1.Params[0].AsDate  :=  DateTimePicker2.Date;
              SqlAux1.Params[1].AsDate  :=  DateTimePicker1.Date;
            end;
        end
      else if (par1 <> '') then
      SqlAux1.Params[0].Value :=  SqlServico.Fields[1].Value
      else if ((par0 <> '') and (par1 <> ''))then
        begin
          SqlAux1.Params[0].Value  :=  SqlServico.Fields[1].Value;
          if ((DateTimePicker1.Date < DateTimePicker2.Date) or (DateTimePicker1.Date = DateTimePicker2.Date)) then
            begin
              SqlAux1.Params[1].AsDate  :=  DateTimePicker1.Date;
              SqlAux1.Params[2].AsDate  :=  DateTimePicker2.Date;
            end
          else if (DateTimePicker1.Date > DateTimePicker2.Date) then
            begin
              SqlAux1.Params[1].AsDate  :=  DateTimePicker2.Date;
              SqlAux1.Params[2].AsDate  :=  DateTimePicker1.Date;
            end;
        end;
      SqlAux1.Open;
      case SqlAux1.RecordCount of
        0: Application.MessageBox('Não Registro para os parametros!','ADS',64);
        else
          begin
            DtSServNLido.DataSet  :=  SqlAux1;
            DBGridServnLido.Refresh;
          end;
      end;
    end;
end;

procedure TFrmCadNlido.BtnDeletarClick(Sender: TObject);
begin
  if (Qtde.Text = '') then
    begin
      Application.MessageBox('Selecione um registro para deletar','ADS - Não Lidos',64);
      exit
    end
  else
    begin
      with dm do
        begin
          SqlAux1.Close;
          SqlAux1.SQL.Clear;
          SqlAux1.SQL.Add('delete from ads005_servnaolido where (ads05servnlido_id = :cod)');
          SqlAux1.Params[0].Value :=  dm.SqlServNLido.Fields[0].Value;
          try SqlAux1.ExecSQL;
              Application.MessageBox('Registro excluído com sucesso','ADS - Não Lidos',64);
              BtnIncluir.OnClick(self);
              SqlServNLido.Refresh;
              DBGridServnLido.Refresh;
          except on e: exception do
            begin
              Application.MessageBox(PChar('Erro para Excluir Registro! '+e.Message),'ADS - Não Lidos',48);
              SqlAux1.Free;
              exit;
            end;
          end;
        end;
    end;
end;

procedure TFrmCadNlido.BtnIncluirClick(Sender: TObject);
begin
  with dm do
    begin
      DtSServNLido.DataSet       :=  SqlServNLido;
      DBGridServnLido.Refresh;
    end;
  erro:=false;
  aux:=0;
  Qtde.Clear;
  Servico.KeyValue  :=  null;
end;

procedure TFrmCadNlido.BtnPrintClick(Sender: TObject);
var i:integer;
begin
  with dm do
    begin
      SqlTotNLido.Close;
      SqlTotNLido.SQL.Clear;
      SqlTotNLido.SQL.Add('Select * from totnlido ');
      for i := 1 to GrpBoxConsulta.ControlCount do
        begin
          case i of
            1:  if (CheckBox2.Checked = true) then par0 :=  '("Data" between :dt1 and :dt)';
            2:  if (CheckBox3.Checked = true) then par1 :=  '("Tipo" = :cod)';
          end;
        end;
      if (par0 <> '') then
      SqlTotNLido.SQL.Add('where '+par0)
      else if (par1 <> '') then
      SqlTotNLido.SQL.Add('where '+par1)
      else if ((par0 <> '') and (par1 <> '')) then
      SqlTotNLido.SQL.Add('where '+par1+' and '+par0);
      SqlTotNLido.SQL.Add('order by "Data"');
      if (par0 <> '') then
        begin
          if ((DateTimePicker1.Date < DateTimePicker2.Date) or (DateTimePicker1.Date = DateTimePicker2.Date)) then
            begin
              SqlTotNLido.Params[0].AsDate  :=  DateTimePicker1.Date;
              SqlTotNLido.Params[1].AsDate  :=  DateTimePicker2.Date;
            end
          else if (DateTimePicker1.Date > DateTimePicker2.Date) then
            begin
              SqlTotNLido.Params[0].AsDate  :=  DateTimePicker2.Date;
              SqlTotNLido.Params[1].AsDate  :=  DateTimePicker1.Date;
            end;
        end
      else if (par1 <> '') then
      SqlTotNLido.Params[0].Value :=  SqlServico.Fields[1].Value
      else if ((par0 <> '') and (par1 <> ''))then
        begin
          SqlTotNLido.Params[0].Value  :=  SqlServico.Fields[1].Value;
          if ((DateTimePicker1.Date < DateTimePicker2.Date) or (DateTimePicker1.Date = DateTimePicker2.Date)) then
            begin
              SqlTotNLido.Params[1].AsDate  :=  DateTimePicker1.Date;
              SqlTotNLido.Params[2].AsDate  :=  DateTimePicker2.Date;
            end
          else if (DateTimePicker1.Date > DateTimePicker2.Date) then
            begin
              SqlTotNLido.Params[1].AsDate  :=  DateTimePicker2.Date;
              SqlTotNLido.Params[2].AsDate  :=  DateTimePicker1.Date;
            end;
        end;
      SqlTotNLido.Open;
      case SqlTotNLido.RecordCount of
        0: Application.MessageBox('Não Há Registro para os parametros!','ADS',64);
        else
          begin
            Application.CreateForm(TFrmRlNLido,FrmRlNlido);
            FrmRlNLido.RLReport1.PreviewModal;
            FrmRlNLido.RLReport1.Destroy;
//            DBGridServnLido.Refresh;
          end;
      end;
    end;

end;

procedure TFrmCadNlido.BtnSairClick(Sender: TObject);
begin
close
end;

procedure TFrmCadNlido.BtnSalvarClick(Sender: TObject);
begin
vercpos(aux);
  if erro=false then
    begin
      with dm do
        begin
          SqlAux1.Close;
          SqlAux1.SQL.Clear;
          SqlAux1.SQL.Add('insert into ads005_servnaolido (ads05servnlido_codserv,ads05servnlido_codusu,ads05servnlido_qtd,');
          SqlAux1.SQL.Add('ads05servnlido_dti,ads05servnlido_dtc) values (:codserv,:usu,:qtde,:dti,:dtc)');
          SqlAux1.Params[0].Value  :=  dm.SqlServico.Fields[1].Value;
          SqlAux1.Params[1].Value  :=  dm.sqlcga_acessocodigo.Value;
          SqlAux1.Params[2].Value  :=  strtoint64(Qtde.Text);
          SqlAux1.Params[3].AsDate :=  DateTimePicker1.Date;
          SqlAux1.Params[4].AsDate :=  Date;
          try
            SqlAux1.ExecSQL;
            SqlServNLido.Refresh;
            DBGridServnLido.Refresh;
            //DBGridServnLido
            BtnIncluir.OnClick(self);
          except on e: exception do
            begin
              Application.MessageBox(PChar('Erro ao Cadastrar! '+e.Message),'ADS - Cadastro de Não Lidos',64);
              exit;
            end;
          end;
        end;
    end;
end;

procedure TFrmCadNlido.CheckBox1Click(Sender: TObject);
begin
DateTimePicker2.Enabled :=  true;
DateTimePicker2.Visible :=  true;
DateTimePicker2.Date    :=  date;
end;

procedure TFrmCadNlido.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked = true then
    begin
      DateTimePicker2.Enabled := true;
      DateTimePicker2.Visible := true;
      DateTimePicker2.Date    := date;
    end
  else
    begin
      DateTimePicker2.Enabled := false;
      DateTimePicker2.Visible := false;
    end;
end;

procedure TFrmCadNlido.ServicoEnter(Sender: TObject);
begin
  Servico.DropDownWidth :=  U_func.tamlookcbo(0);
  Servico.DropDownRows  :=  dm.SqlServico.RecordCount;
end;

procedure TFrmCadNlido.DBGridServnLidoCellClick(Column: TColumn);
begin
atudados;
end;

procedure TFrmCadNlido.DBGridServnLidoDblClick(Sender: TObject);
begin
atudados;
end;

procedure TFrmCadNlido.DBGridServnLidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
atudados;
end;

procedure TFrmCadNlido.DBGridServnLidoKeyPress(Sender: TObject; var Key: Char);
begin
atudados;
end;

procedure TFrmCadNlido.DBGridServnLidoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
atudados;
end;

procedure TFrmCadNlido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := cafree;
  Dm.SqlServico.Close;
  Dm.SqlServNLido.Close;
end;

procedure TFrmCadNlido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = 13) then
    SelectNext(ActiveControl,True,True);

end;

procedure TFrmCadNlido.FormShow(Sender: TObject);
begin
DateTimePicker1.Date  := date;
end;

procedure TFrmCadNlido.atudados;
  begin
  with dm do
    begin
      Qtde.Text               :=  SqlServNLido.Fields[3].AsString;
      Servico.KeyValue        :=  SqlServNLido.Fields[1].Value;
    end;
  end;
procedure TFrmCadNlido.vercpos(vez:integer);
var i: integer;
  begin
    for I := 0 to FrmCadNlido.ComponentCount - 1 do
      begin
        if Components[i] is TEdit then
          begin
            if trim(TEdit(Components[i]).Text) = '' then
              begin
                erro:=true;
                Application.MessageBox(PChar('Preencher o campo: '+Components[i].Name),'ADS',64);
                aux:=aux+1;
              end;
          end;
        if Components[i] is TDBLookupComboBox then
          begin
            if (TDBLookupComboBox(Components[i]).KeyValue = null) then
              begin
                erro:=true;
                Application.MessageBox(PChar('Escolha um Serviço: '+Components[i].Name),'ADS',64);
                aux:=aux+1;
              end;
          end;
      end;
  end;
end.
