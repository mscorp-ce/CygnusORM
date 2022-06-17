program CygnusORMSample;

uses
  Vcl.Forms,
  uPrincipal in 'view\uPrincipal.pas' {frmPrincipal},
  uModel.Entities.Auditoria in 'model\entities\uModel.Entities.Auditoria.pas',
  uModel.Entities.Cliente in 'model\entities\uModel.Entities.Cliente.pas',
  uModel.Entities.Pedido in 'model\entities\uModel.Entities.Pedido.pas',
  uController.PedidoController in 'controller\uController.PedidoController.pas',
  uModel.Service.PedidoService in 'model\services\uModel.Service.PedidoService.pas',
  uModel.Business.PedidoBusiness in 'model\business\uModel.Business.PedidoBusiness.pas',
  uDataManager in 'model\dao\uDataManager.pas',
  uModel.Dao.PedidoDao in 'model\dao\uModel.Dao.PedidoDao.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown:= true;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
