unit uStatementFactory;

interface

uses
  uAbstraction, uStatement, FireDAC.Comp.Client;

type
  TStatementFactory = class
  public
    class function GetStatement(DataManager: IDataManager): TStatement;
  end;

implementation

{ TStatementFactory }

class function TStatementFactory.GetStatement(DataManager: IDataManager): TStatement;
begin
  Result:= TStatement.Create(DataManager);
end;

end.




