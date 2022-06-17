unit uModel.Entities.Auditoria;

interface

uses
  System.Classes, uAttributes;

type
  [TTable('Auditorias')]
  TAuditoria = class(TEntity)
  private
    fDados: TStrings;
    fIdEmpresa: Integer;
    fIdUsuario: Integer;
    fIdAuditoria: Integer;
    fDtOcorrencia: TDateTime;
    fIdFuncionario: Integer;
    fTela: String;
  public
    [TColumn('IdEmpresa')]
    property IdEmpresa: Integer read fIdEmpresa write fIdEmpresa;
    [TId('IdAuditoria'), TPrimaryKey('IdAuditoria'), TColumn('IdAuditoria')]
    property IdAuditoria: Integer read fIdAuditoria write fIdAuditoria;
    [TColumn('DtOcorrencia')]
    property DtOcorrencia: TDateTime read fDtOcorrencia write fDtOcorrencia;
    [TColumn('IdUsuario')]
    property IdUsuario: Integer read fIdUsuario write fIdUsuario;
    [TColumn('IdFuncionario')]
    property IdFuncionario: Integer read fIdFuncionario write fIdFuncionario;
    [TColumn('Tela')]
    property Tela: String read fTela write fTela;
    [TColumn('Dados')]
    property Dados: TStrings read fDados write fDados;
  end;

implementation

end.
