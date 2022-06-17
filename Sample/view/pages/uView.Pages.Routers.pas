unit uView.Pages.Routers;

interface

uses
  Router4D;

type
  TRouters = class
  private

  public
    constructor Creatre;
    destructor Destroy; override;
  end;

var
  Routers: TRouters;

implementation

uses
  System.SysUtils, uView.Page.App;

{ TRouters }

constructor TRouters.Creatre;
begin
  TRouter4D.Switch.Router('App', TPageApp)
end;

destructor TRouters.Destroy;
begin

  inherited;
end;

initialization
  Routers:= TRouters.Creatre;

finalization
  FreeAndNil(Routers);
end.
