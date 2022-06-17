unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  uModel.Dao.Abstraction, uModel.Dao.DaoGeneric, uModel.Entities.Cliente,
  uModel.Entities.Pedido;

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
var
  Dao: IDao<TPedido>;
  Pedido: TPedido;
  Cliente: TCliente;
begin
  Dao:= nil;
  Pedido:= nil;
  Cliente:= nil;
  try
    Cliente:= TCliente.Create;
    Pedido:= TPedido.Create;

    Cliente.Id:= 12;
    Cliente.Nome:= 'Marcio';

    Pedido.Id:= 1;
    Pedido.Data:= Now;
    Pedido.Cliente:= Cliente;
    Pedido.SubTotal:= 1000;
    Pedido.Desconto:= 100;
    Pedido.Total:= Pedido.SubTotal - Pedido.Desconto;

    Dao:= TDao<TPedido>.Create;
    Dao.Save(Pedido);

  finally
    FreeAndNil(Cliente);
    FreeAndNil(Pedido);
  end;
end;

end.
