unit U_Cartao;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPClient, IdSNTP, IdTCPConnection, IdTCPClient, IdTime, IdDayTime,
  IdTimeUDP, IdTCPServer, IdTimeServer, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  Tfrm_cartao = class(TForm)
    ScrollBox1: TScrollBox;
    BtnIni: TButton;
    BtnFim: TButton;
    Button3: TButton;
    ScrollBox2: TScrollBox;
    Label1: TLabel;
    HoraLocal: TStaticText;
    Label2: TLabel;
    RLData: TLabel;
    Usuario: TLabel;
    ScrollBox3: TScrollBox;
    Label3: TLabel;
    Label4: TLabel;
    RLDataServ: TLabel;
    Usuario1: TLabel;
    HoraServidor: TStaticText;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure BtnIniClick(Sender: TObject);
    procedure BtnFimClick(Sender: TObject);
  private
  horaserv : tdatetime;
  dataserv : tdatetime;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_cartao: Tfrm_cartao;

implementation

uses DmDados;

{$R *.dfm}

procedure Tfrm_cartao.Timer1Timer(Sender: TObject);
begin
  HoraLocal.Caption :=  timetostr(time);
  RLData.Caption  :=  formatdatetime('dddddd',date);
end;

procedure Tfrm_cartao.Button3Click(Sender: TObject);
begin
  close;
end;

procedure Tfrm_cartao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frm_cartao := nil;
  action := cafree;
end;

procedure Tfrm_cartao.FormCreate(Sender: TObject);
begin
  Dm.sqlhora.Close;
  Dm.sqlhora.SQL.Clear;
  Dm.sqlhora.SQL.Add('select current_time,current_date');
  Dm.sqlhora.Open;
  horaserv := strtotime(copy(Dm.sqlhoratimetz.AsString,1,8));
  dataserv := Dm.sqlhoradate.AsDateTime;
  Usuario.Caption := Dm.sqlcga_acessonome.Value;
  Usuario1.Caption := Dm.sqlcga_acessonome.Value;
end;

procedure Tfrm_cartao.Timer2Timer(Sender: TObject);
begin
  RLDataServ.Caption := FormatDateTime('dddddd',dataserv);
  horaserv := horaserv + strtotime('00:00:01');
  HoraServidor.Caption := timetostr(HoraServ);
  HoraServidor.Refresh;
end;

procedure Tfrm_cartao.BtnIniClick(Sender: TObject);
begin
  Dm.SqlAux1.Close;
  Dm.SqlAux1.Sql.Clear;
  Dm.SqlAux1.Sql.Add('select * from cga50 where cg50_codusu =:codusu and cg50_data =:data');
  Dm.SqlAux1.Params[0].Value := Dm.sqlcga_acessocodigo.Value;
  Dm.SqlAux1.Params[1].Value := formatdatetime('mm-dd-yyyy',dataserv);
  Dm.SqlAux1.Open;
  case Dm.SqlAux1.RecordCount of
    0:
      begin
        Dm.SqlAux1.Close;
        Dm.SqlAux1.Sql.Clear;
        Dm.SqlAux1.Sql.Add('insert into cga50 (cg50_codusu,cg50_horaini,cg50_data) values (:cg50_codusu,:cg50_horaini,:cg50_data)');
        Dm.SqlAux1.Params[0].Value    := Dm.sqlcga_acessocodigo.Value;
        Dm.SqlAux1.Params[1].AsString := formatdatetime('hh:mm',horaserv);
        Dm.SqlAux1.Params[2].AsString := formatdatetime('mm-dd-yyyy',dataserv);
        try
          Dm.SqlAux1.ExecSql;
          Application.MessageBox('Bom Serviço','Ads',MB_OK+MB_ICONINFORMATION);
        except on e: exception do
          begin
            Application.messagebox(PChar('Erro '+e.Message),'Ads',MB_OK+MB_ICONERROR);
          end;
        end;
      end;
    1:
      begin
        application.MessageBox('Você já se logou hoje!!!','Ads',MB_OK+MB_ICONINFORMATION);
      end;
   else
     begin
       application.MessageBox('Erro!!!','Ads',MB_OK+MB_ICONERROR);
     end;
  end;
end;

procedure Tfrm_cartao.BtnFimClick(Sender: TObject);
begin
  Dm.SqlAux1.Close;
  Dm.SqlAux1.Sql.Clear;
  Dm.SqlAux1.Sql.Add('select * from cga50 where cg50_codusu =:codusu and cg50_data =:data');
  Dm.SqlAux1.Params[0].Value := Dm.sqlcga_acessocodigo.Value;
  Dm.SqlAux1.Params[1].Value := formatdatetime('mm-dd-yyyy',dataserv);;
  Dm.SqlAux1.Open;
  case Dm.SqlAux1.RecordCount of
    0:
      begin
        application.MessageBox('Você não se logou hoje!!!','Ads',MB_OK+MB_ICONINFORMATION);
      end;
    1:
      begin
        Dm.SqlAux1.Close;
        Dm.SqlAux1.Sql.Clear;
        Dm.SqlAux1.Sql.Add(' update cga50 set cg50_horafin=:cg50_horafin where cg50_codusu=:cg50_codusu and cg50_data=:cg50_data');
        Dm.SqlAux1.Params[0].AsString := formatdatetime('hh:mm',horaserv);
        Dm.SqlAux1.Params[1].Value    := Dm.sqlcga_acessocodigo.Value;
        Dm.SqlAux1.Params[2].AsString := formatdatetime('mm-dd-yyyy',dataserv);;
        try
          Dm.SqlAux1.ExecSql;
          Application.MessageBox('Bom Descanço','Ads',MB_OK+MB_ICONINFORMATION);
        except on e: exception do
          begin
            Application.messagebox(PChar('Erro '+e.Message),'Ads',MB_OK+MB_ICONERROR);
          end;
        end;
      end;
   else
     begin
       application.MessageBox('Erro!!!','Ads',MB_OK+MB_ICONERROR);
     end;
  end;
end;

end.

