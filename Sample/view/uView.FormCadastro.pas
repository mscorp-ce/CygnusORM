unit uView.FormCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus;

type
  TfrmFormCadastro = class(TForm)
    pnlAcoes: TPanel;
    btnIncluir: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnConsultar: TSpeedButton;
    btnIrPara: TSpeedButton;
    btnRelatorio: TSpeedButton;
    btnFuncoes: TSpeedButton;
    btnSair: TSpeedButton;
    ppOpcoes: TPopupMenu;
    Opes1: TMenuItem;
    Faturar1: TMenuItem;
    procedure btnFuncoesClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnIrParaClick(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  protected
    procedure Controls(Actions: array of Boolean);

    procedure Incluir; virtual; abstract;
    procedure Alterar; virtual; abstract;
    procedure Cancelar; virtual; abstract;
    procedure Salvar; virtual; abstract;
    procedure Exluir; virtual; abstract;
    procedure Consultar; virtual; abstract;
    procedure IrPara; virtual; abstract;
    procedure Relatorio; virtual; abstract;
    procedure Close; virtual; abstract;
  public
    { Public declarations }
  end;

const
  ctIncluir = 0;
  ctAlterar = 1;
  ctCancelar = 2;
  ctSalvar = 3;
  ctExcluir = 4;
  ctConsultar = 5;
  ctIrPara = 6;
  ctRelatorio = 7;
  ctFuncoes = 8;
  ctSair = 9;

var
  frmFormCadastro: TfrmFormCadastro;

implementation

{$R *.dfm}

procedure TfrmFormCadastro.btnIncluirClick(Sender: TObject);
begin
  Controls([True, False, True, True, False, False, False, False, True, True]);
end;

procedure TfrmFormCadastro.btnIrParaClick(Sender: TObject);
begin
  Controls([True, True, False, False, True, True, True, True, True, True]);
end;

procedure TfrmFormCadastro.btnRelatorioClick(Sender: TObject);
begin
  Controls([True, True, False, False, True, True, True, True, True, True]);
end;

procedure TfrmFormCadastro.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmFormCadastro.btnSalvarClick(Sender: TObject);
begin
  Controls([True, True, False, False, True, True, True, True, True, True]);
end;

procedure TfrmFormCadastro.Controls(Actions: array of Boolean);
begin
  btnIncluir.Enabled:= Actions[ctIncluir];
  btnAlterar.Enabled:= Actions[ctAlterar];
  btnCancelar.Enabled:= Actions[ctCancelar];
  btnSalvar.Enabled:= Actions[ctSalvar];
  btnExcluir.Enabled:= Actions[ctExcluir];
  btnConsultar.Enabled:= Actions[ctConsultar];
  btnIrPara.Enabled:= Actions[ctIrPara];
  btnRelatorio.Enabled:= Actions[ctRelatorio];
  btnFuncoes.Enabled:= Actions[ctFuncoes];
  btnSair.Enabled:= Actions[ctSair];
end;

procedure TfrmFormCadastro.FormCreate(Sender: TObject);
begin
  Self.KeyPreview:= True;
end;

procedure TfrmFormCadastro.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      SelectNext(ActiveControl as TWinControl,True,True);
      Key:= #0;
    end;
end;

procedure TfrmFormCadastro.btnAlterarClick(Sender: TObject);
begin
  Controls([False, True, True, True, False, False, False, False, True, True]);
end;

procedure TfrmFormCadastro.btnCancelarClick(Sender: TObject);
begin
  Controls([True, True, False, True, False, True, True, True, True, True]);
end;

procedure TfrmFormCadastro.btnConsultarClick(Sender: TObject);
begin
  Controls([True, True, False, False, True, True, True, True, True, True]);
end;

procedure TfrmFormCadastro.btnExcluirClick(Sender: TObject);
begin
  Controls([True, False, False, False, True, True, False, False, True, True]);
end;

procedure TfrmFormCadastro.btnFuncoesClick(Sender: TObject);
var
  PLeft, PHeight: TPoint;
begin
  PLeft.X := TSpeedButton(Sender).Left;
  PLeft.Y := TSpeedButton(Sender).Top + TSpeedButton(Sender).Height;
  PHeight := ClientToScreen(PLeft);
  ppOpcoes.PopUp(PHeight.X, PHeight.Y);

  Controls([True, True, False, False, True, True, True, True, True, True]);
end;

end.
