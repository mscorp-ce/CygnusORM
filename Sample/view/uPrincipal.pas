unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ExceptionLog, Vcl.StdCtrls,
  System.Generics.Collections, Data.DB, Vcl.Grids, Vcl.DBGrids,

  uAbstraction, uController.PedidoController, uModel.Entities.Pedido;

type
  TfrmPrincipal = class(TForm)
    btnUpdate: TButton;
    btnDeleteById: TButton;
    btnInsert: TButton;
    btnDeleteAll: TButton;
    btnSelectAll: TButton;
    btnSelectById: TButton;
    dsPedidos: TDataSource;
    grdPedidos: TDBGrid;
    procedure btnInsertClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnDeleteByIdClick(Sender: TObject);

    procedure btnDeleteAllClick(Sender: TObject);
    procedure btnSelectByIdClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Pedidos: TObjectList<TPedido>; //TManagerPointer<
    PedidoController: IController<TPedido>;
    Query: TDataSet;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  uModel.Entities.Cliente;

{$R *.dfm}

procedure TfrmPrincipal.btnInsertClick(Sender: TObject);
var
  Pedido: TPedido;
  Cliente: TCliente;
begin
  Pedido:= nil;
  try
    Pedido:= TPedido.Create;
    Cliente:= TCliente.Create;

    Cliente.Id:= 12;
    Cliente.Nome:= 'Marcio';

    Pedido.Id:= 2;
    Pedido.Data:= Now;
    Pedido.IdCliente:= 12; //Cliente;
    Pedido.Observacao:= 'End. entrega: Rua Vicente Lopes, Nº 1001';
    Pedido.SubTotal:= 1000.00;
    Pedido.Desconto:= 100.00;
    Pedido.Total:= Pedido.SubTotal - Pedido.Desconto;
    Pedido.Comp:= '[Codigo: 11, Marcio]';

    PedidoController.Save(Pedido);

    Cliente.Id:= 11;
    Cliente.Nome:= 'Julia';

    Pedido.Id:= 3;
    Pedido.Data:= Now;
    Pedido.IdCliente:= 11; //Cliente;
    Pedido.Observacao:= 'End. entrega: Av. Carlos Vasconcelos, Nº 501';
    Pedido.SubTotal:= 700.00;
    Pedido.Desconto:= 50.00;
    Pedido.Total:= Pedido.SubTotal - Pedido.Desconto;
    Pedido.Comp:= '[Codigo: 12, Julia]';

    PedidoController.Save(Pedido);

    Query:= PedidoController.Bind;

  finally
    FreeAndNil( Pedido );
    FreeAndNil(Cliente);
  end;
end;

procedure TfrmPrincipal.btnSelectAllClick(Sender: TObject);
var
  Id: Integer;
  DataEmissao: TDateTime;
  IdCliente: Integer;
  SubTotal: Double;
  Desconto: Double;
  Total: Double;
  Comp: WideString;
  i: Word;
begin
  Pedidos:= PedidoController.FindAll();

  if Pedidos.Count > 0 then
    begin
      for i:= 0 to Pred(Pedidos.Count) do
        begin
          Id:= Pedidos.Items[i].Id;
          DataEmissao:= Pedidos.Items[i].Data;
          IdCliente:= Pedidos.Items[i].IdCliente;
          SubTotal:= Pedidos.Items[i].SubTotal;
          Desconto:= Pedidos.Items[i].Desconto;
          Total:= Pedidos.Items[i].Total;
          Comp:= Pedidos.Items[i].Comp;
          ShowMessage('id: ' + IntToStr(id) + #13+
                      'DataEmissao: ' + DateTimeToStr(DataEmissao) + #13+
                      'IdCliente: ' + IntToStr(IdCliente) + #13+
                      'SubTotal: ' + FloatToStr(SubTotal) + #13+
                      'Desconto: ' + FloatToStr(Desconto) + #13+
                      'Total: ' + FloatToStr(Total) + #13+
                      'Comp: ' + Comp
                      );
        end;
    end;
end;

procedure TfrmPrincipal.btnSelectByIdClick(Sender: TObject);
var
  Pedido: TPedido;
  Id: Integer;
  DataEmissao: TDateTime;
  IdCliente: Integer;
  SubTotal: Double;
  Desconto: Double;
  Total: Double;
  Comp: WideString;
begin
  try
    Pedido:= PedidoController.FindById(2);

    if Pedido.Id > 0 then
      begin
        Id:= Pedido.Id;
        DataEmissao:= Pedido.Data;
        IdCliente:= Pedido.IdCliente;
        SubTotal:= Pedido.SubTotal;
        Desconto:= Pedido.Desconto;
        Total:= Pedido.Total;
        Comp:= Pedido.Comp;

        ShowMessage('id: ' + IntToStr(id) + #13+
                    'DataEmissao: ' + DateTimeToStr(DataEmissao) + #13+
                    'IdCliente: ' + IntToStr(IdCliente) + #13+
                    'SubTotal: ' + FloatToStr(SubTotal) + #13+
                    'Desconto: ' + FloatToStr(Desconto) + #13+
                    'Total: ' + FloatToStr(Total) + #13+
                    'Comp: ' + Comp
                    );
      end;

  finally
    FreeAndNil(Pedido);
  end;
end;

procedure TfrmPrincipal.btnUpdateClick(Sender: TObject);
var
  Pedido: TPedido;
  Cliente: TCliente;
begin
  Pedido:= nil;
  try
    Pedido:= TPedido.Create;
    Cliente:= TCliente.Create;

    Cliente.Id:= 12;
    Cliente.Nome:= 'Marcio';

    Pedido.Id:= 2;
    Pedido.Data:= Now + 1;
    Pedido.IdCliente:= 12; //Cliente;
    Pedido.Observacao:= 'End. entrega: Rua Vicente Lopes, Nº 1001';
    Pedido.SubTotal:= 1000.00;
    Pedido.Desconto:= 100.00;
    Pedido.Total:= Pedido.SubTotal - Pedido.Desconto;
    Pedido.Comp:= '[Codigo: 11, Marcios]';

    PedidoController.Update(Pedido);

    Query:= PedidoController.Bind;

  finally
    FreeAndNil(Pedido);
    FreeAndNil(Cliente);
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  PedidoController:= TPedidoController<TPedido>.Create;

  Query:= PedidoController.Bind;

  dsPedidos.DataSet:= Query;
end;

procedure TfrmPrincipal.btnDeleteAllClick(Sender: TObject);
begin
  PedidoController.DeleteAll;

  Query:= PedidoController.Bind;
end;

procedure TfrmPrincipal.btnDeleteByIdClick(Sender: TObject);
begin
  PedidoController.DeleteById(2);

  Query:= PedidoController.Bind;
end;

end.
