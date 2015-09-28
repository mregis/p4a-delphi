unit U_FrmRlErrobxaArSdx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport;

type
  TFrmRlErroBxaArSdx = class(TForm)
    RLErroBxaArSdx: TRLReport;
    DetLin: TRLBand;
    RLLin: TRLLabel;
    procedure RLErroBxaArSdxNeedData(Sender: TObject; var MoreData: Boolean);
  private
    { Private declarations }
    lin : string;
  public
    { Public declarations }
    arq :TextFile;
  end;

var
  FrmRlErroBxaArSdx: TFrmRlErroBxaArSdx;

implementation

{$R *.dfm}

procedure TFrmRlErroBxaArSdx.RLErroBxaArSdxNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
 if not Eof(arq) then
    begin
      Readln(arq,lin);
      RlLin.Caption := Trim(lin);
      MoreData:=true;
    end
  else
    begin
      MoreData:=false;
      CloseFile(arq);
    end;
end;

end.
