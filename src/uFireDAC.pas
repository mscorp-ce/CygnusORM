unit uFireDAC;

interface

uses
  uAbstraction, FireDAC.Comp.Client, Data.DB, FireDAC.Phys.PG;

type
  TModelFireDAC = class(TInterfacedObject, IDataManager)
  private
    FConexao : TFDConnection;
    FPgDriverLink: TFDPhysPgDriverLink;
  public
    constructor Create;
    destructor Destroy; override;

    function GetConnection: TCustomConnection;
    property Connection: TCustomConnection read GetConnection;
  end;

implementation

uses
  System.SysUtils, uLibary;

{ TModelFireDAC }

constructor TModelFireDAC.Create;
begin
  inherited Create;
  FConexao := TFDConnection.Create(nil);

  FConexao.DriverName                := TLibary.GetINI('DATA_POSTGRES', 'DriverName');
  FConexao.Params.Values['Server']   := TLibary.GetINI('DATA_POSTGRES', 'Server');
  FConexao.Params.Values['Port']     := TLibary.GetINI('DATA_POSTGRES', 'Port');
  FConexao.Params.Values['Database'] := TLibary.GetINI('DATA_POSTGRES', 'Database');
  FConexao.Params.Values['User_Name']:= TLibary.GetINI('DATA_POSTGRES', 'User_Name');
  FConexao.Params.Values['Password'] := TLibary.GetINI('DATA_POSTGRES', 'Password');

  FPgDriverLink:= TFDPhysPgDriverLink.Create(nil);
  FPgDriverLink.VendorHome:= TLibary.GetINI('LIBARY_POSTGRES', 'PATH_VENDOR_HOME_APP');
  FPgDriverLink.VendorLib:= TLibary.GetINI('LIBARY_POSTGRES', 'PATH_VENDOR_LIB_DB_APP');

  FConexao.Connected:= True;
end;

destructor TModelFireDAC.Destroy;
begin
  FConexao.Close;
  FreeAndNil( FConexao );
  FreeAndNil( FPgDriverLink );
  inherited Destroy;
end;

function TModelFireDAC.GetConnection: TCustomConnection;
begin
  Result:= FConexao;
end;

end.
