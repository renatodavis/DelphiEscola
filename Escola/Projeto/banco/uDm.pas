unit uDm;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr, IdBaseComponent, IdComponent,
  windows,Controls,Forms,IdTCPConnection, IdTCPClient;

type
  TdmGeral = class(TDataModule)
    SQLConnection: TSQLConnection;
    IdTCPClient1: TIdTCPClient;
    procedure SQLConnectionBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }                       
  end;

var
  dmGeral: TdmGeral;

implementation

{$R *.dfm}

procedure TdmGeral.SQLConnectionBeforeConnect(Sender: TObject);
begin
  try
    IdTCPClient1.Connect()
  except on e:Exception do
    if Application.MessageBox('O Firebird na porta(3050), não estar Ativo ou instalado. Deseja instalar ? ( C:\escola\Firebird.exe )','Erro na conexão com o banco de dados',MB_YESNO+MB_ICONERROR) = mryes then
      WinExec('c:\escola\Firebird.exe',SW_NORMAL);
  end;
end;

end.
