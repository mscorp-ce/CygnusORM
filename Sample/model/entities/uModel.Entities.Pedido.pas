unit uModel.Entities.Pedido;

interface

uses
  System.SysUtils, System.RTTI, uAttributes, uModel.Entities.Cliente;

type
  [TTable('Pedidos')]
  TPedido = class(TEntity)
  private
    fDesconto: Double;
    fSubTotal: Double;
    //fCliente: TCliente;
    fTotal: Double;
    fId: Integer;
    fData: TDateTime;
    fObservacao: String;
    fIdCliente: Integer;
    fComp: WideString;
    //fCompl: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    [TId('IdPedido'), TPrimaryKey('IdPedido'), TColumn('IdPedido')]
    property Id: Integer read fId write fId;
    [TColumn('DataEmissao')]
    property Data: TDateTime read fData write fData;
    [TForeignKey('IdCliente'), TColumn('IdCliente')]
    property IdCliente: Integer read fIdCliente write fIdCliente;
    [TColumn('Observacao')]
    property Observacao: String read fObservacao write fObservacao;
    [TColumn('SubTotal')]
    property SubTotal: Double read fSubTotal write fSubTotal;
    [TColumn('Desconto')]
    property Desconto: Double read fDesconto write fDesconto;
    [TColumn('Total')]
    property Total: Double read fTotal write fTotal;
    [TColumn('Comp')]
    property Comp: WideString read fComp write fComp;
    //[TColumn('Compl')]
    //property Compl: String read fCompl write fCompl;
  end;

implementation

{ TPedido }

constructor TPedido.Create;
begin
  inherited Create;

  //fCliente:= TCliente.Create;
end;

destructor TPedido.Destroy;
begin
  //FreeAndNil(fCliente);
  inherited Destroy;
end;

end.
