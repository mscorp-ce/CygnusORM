unit uDataManagerFactory;

interface

uses
  uAbstraction, uFireDac;

type
  TDataManagerFactory = class
  public
    class function GetDataManager: TModelFireDAC;
  end;

implementation

{ TDataManagerFactory }

class function TDataManagerFactory.GetDataManager: TModelFireDAC;
begin
  Result:= TModelFireDAC.Create;
end;

end.

