unit uModel.Service.PedidoService;

interface

uses
  uAbstraction, uModel.Entities.Pedido, System.Generics.Collections,
  uModel.Business.PedidoBusiness;

type
  TPedidoService<T: class> = class(TInterfacedObject, IService<TPedido>)
  private
    PedidoBusiness: IBusiness<TPedido>;
    Dao: IDao<TPedido>;
  public
    constructor Create; reintroduce;
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
  uCygnusDao, System.SysUtils, uModel.Dao.PedidoDao, uDataManager;

{ PedidoService<T> }

constructor TPedidoService<T>.Create;
begin
  inherited Create;
  PedidoBusiness:= TPedidoBusiness<TPedido>.Create;
  Dao:= TPedidoDao.Create(DataManager);
end;

function TPedidoService<T>.DeleteAll: Boolean;
var
  IsNotEmpty: Boolean;
begin
  IsNotEmpty:= Dao.FindExists;
  if IsNotEmpty then
    begin
      Result:= Dao.DeleteAll;
    end;
end;

function TPedidoService<T>.DeleteById(Id: Integer): Boolean;
var
  Entity: TPedido;
begin
  Entity:= Dao.FindById(Id);
  try
    if PedidoBusiness.Valid(Entity) then
      begin
        Result:= Dao.DeleteById(Id);
      end;

  finally
    FreeAndNil(Entity);
  end;
end;

destructor TPedidoService<T>.Destroy;
begin
  inherited Destroy;
end;

function TPedidoService<T>.FindAll: TObjectList<TPedido>;
begin
  Result:= Dao.FindAll;
end;

function TPedidoService<T>.FindById(Id: Integer): TPedido;
begin
  Result:= Dao.FindById(Id);
end;

function TPedidoService<T>.Save(Entity: TPedido): Boolean;
begin
  if PedidoBusiness.Valid(Entity) then
    begin
      Result:= Dao.Save(Entity);
    end;
end;

function TPedidoService<T>.Update(Entity: TPedido): Boolean;
begin
  if PedidoBusiness.Valid(Entity) then
    begin
      Result:= Dao.Update(Entity);
    end;
end;

end.
