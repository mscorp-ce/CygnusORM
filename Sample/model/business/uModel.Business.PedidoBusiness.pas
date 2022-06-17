unit uModel.Business.PedidoBusiness;

interface

uses
  uAbstraction, uModel.Entities.Pedido;

type
  TPedidoBusiness<T: class, constructor> = class(TInterfacedObject, IBusiness<TPedido>)
  private

  public
    constructor Create;
    destructor Destroy; override;

    function Valid(Entity: TPedido): Boolean; overload;
  end;

implementation

{ TPedidoBusiness<T> }

constructor TPedidoBusiness<T>.Create;
begin
  inherited Create;
end;

destructor TPedidoBusiness<T>.Destroy;
begin
  inherited Destroy;
end;

function TPedidoBusiness<T>.Valid(Entity: TPedido): Boolean;
begin
  Result:= False;

  if Entity.Id <= 0 then
    Exit;

  if Entity.IdCliente <= 0 then
    Exit;

  if Entity.Desconto > Entity.SubTotal then
    Exit;

  Result:= True;
end;

end.
