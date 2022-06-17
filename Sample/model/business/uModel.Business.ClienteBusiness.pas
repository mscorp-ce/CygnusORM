unit uModel.Business.ClienteBusiness;

interface

uses
  uModel.Entities.Cliente;

type
  TClienteBuiBusiness = class
  public
    function Valid(var Cliente: TCliente): Boolean;
  end;

implementation

{ TClienteBuiBusiness }

function TClienteBuiBusiness.Valid(var Cliente: TCliente): Boolean;
begin
  Result:= False;
end;

end.
