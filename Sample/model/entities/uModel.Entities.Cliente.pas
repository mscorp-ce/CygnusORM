unit uModel.Entities.Cliente;

interface

uses
  uAttributes;

type
  [TTable('Clientes')]
  TCliente = class(TEntity)
  private
    fId: Integer;
    fNome: String;
    fFone: String;
    fLogradouro: String;
    fIdMunicipio: String;
    fCnpj: String;
    fFantasia: String;
    fBairro: String;
    fEntregaLogradouro: String;
    fIscricaoMunicipal: String;
    fIdestado: Integer;
    fEntregaBairro: String;
    fCep: String;
    fNumero: String;
    fComplemento: String;
    fEntregaCnpjCpf: String;
    fIscricaoEstadual: String;
    fEntregaNumero: String;
    fEntregaComplemento: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    [TId('IdCliente'), TPrimaryKey('IdCliente'), TColumn('IdCliente')]
    property Id: Integer read fId write fId;
    [TColumn('razaosocial')]
    property Nome: String read fNome write fNome;
    [TColumn('Fantasia')]
    property Fantasia: String read fFantasia write fFantasia;
    [TColumn('Cnpj')]
    property Cnpj: String read fCnpj write fCnpj;
    [TColumn('IscricaoEstadual')]
    property IscricaoEstadual: String read fIscricaoEstadual write fIscricaoEstadual;
    [TColumn('IscricaoMunicipal')]
    property IscricaoMunicipal: String read fIscricaoMunicipal write fIscricaoMunicipal;
    [TColumn('Logradouro')]
    property Logradouro: String read fLogradouro write fLogradouro;
    [TColumn('Numero')]
    property Numero: String read fNumero write fNumero;
    [TColumn('Complemento')]
    property Complemento: String read fComplemento write fComplemento;
    [TColumn('Cep')]
    property Cep: String read fCep write fCep;
    [TColumn('Bairro')]
    property Bairro: String read fBairro write fBairro;
    [TColumn('Fone')]
    property Fone: String read fFone write fFone;
    [TColumn('IdEstado')]
    property IdEstado: Integer read fIdestado write fIdEstado;
    [TColumn('IdMunicipio')]
    property IdMunicipio: String read fIdMunicipio write fIdMunicipio;
    [TColumn('EntregaCnpjCpf')]
    property EntregaCnpjCpf: String read fEntregaCnpjCpf write fEntregaCnpjCpf;
    [TColumn('EntregaLogradouro')]
    property EntregaLogradouro: String read fEntregaLogradouro write fEntregaLogradouro;
    [TColumn('EntregaNumero')]
    property EntregaNumero: String read fEntregaNumero write fEntregaNumero;
    [TColumn('EntregaComplemento')]
    property EntregaComplemento: String read fEntregaComplemento write fEntregaComplemento;
    [TColumn('EntregaBairro')]
    property EntregaBairro: String read fEntregaBairro write fEntregaBairro;


  end;

implementation

{ TCliente }

constructor TCliente.Create;
begin
  inherited Create;
end;

destructor TCliente.Destroy;
begin
  inherited Destroy;
end;

end.
