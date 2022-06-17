unit uController.PedidoController;

interface

uses
  System.Generics.Collections, uAbstraction, uModel.Entities.Pedido;

type
  TPedidoController<T: class, constructor> = class(TInterfacedObject, IController<TPedido>)
  private
    PedidoService: IService<TPedido>;
  public
    constructor Create;
    destructor Destroy; override;

    function Save(Entity: TPedido): Boolean;
    function Update(Entity: TPedido): Boolean;
    function DeleteById(Id: Integer): Boolean;
    function DeleteAll: Boolean;
    function FindById(Id: Integer): TPedido;
    function FindAll: TObjectList<TPedido>;
  end;

implementation

uses
  System.SysUtils, uModel.Service.PedidoService;

{ TPedidoController<T> }

constructor TPedidoController<T>.Create;
begin
  PedidoService:= TPedidoService<TPedido>.Create;
end;

function TPedidoController<T>.DeleteAll: Boolean;
begin
  Result:= PedidoService.DeleteAll;
end;

function TPedidoController<T>.DeleteById(Id: Integer): Boolean;
begin
  Result:= PedidoService.DeleteById(Id);
end;

destructor TPedidoController<T>.Destroy;
begin
  inherited Destroy;
end;

function TPedidoController<T>.FindAll: TObjectList<TPedido>;
begin
  Result:= PedidoService.FindAll;
end;

function TPedidoController<T>.FindById(Id: Integer): TPedido;
begin
  Result:= PedidoService.FindById(Id);
end;

function TPedidoController<T>.Save(Entity: TPedido): Boolean;
begin
  Result:= PedidoService.Save(Entity);
end;

function TPedidoController<T>.Update(Entity: TPedido): Boolean;
begin
  Result:= PedidoService.Update(Entity);
end;

end.
