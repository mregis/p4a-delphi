unit U_FrmExtVelho;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleServer, ExcelXP, ExtCtrls, StdCtrls, Buttons, DBCtrls, FileCtrl;

type
  TFrmBxaArqSdx = class(TForm)
    Bevel1: TBevel;
    DriveComboBox1: TDriveComboBox;
    diretorio: TDirectoryListBox;
    FileListBox1: TFileListBox;
    Edarq: TEdit;
    Label5: TLabel;
    DBCboSdxServ: TDBLookupComboBox;
    BtnLerArq: TBitBtn;
    edTot: TEdit;
    captot: TLabel;
    Painel: TPanel;
    ExcelApp: TExcelApplication;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBxaArqSdx: TFrmBxaArqSdx;

implementation

{$R *.dfm}

end.
