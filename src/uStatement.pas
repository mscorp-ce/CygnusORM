unit uStatement;

interface

uses
  uAbstraction, uMetaDates, FireDAC.Comp.Client, FireDAC.DApt, Data.DB;

type
  TStatement = class(TInterfacedObject, IStatement)
  private
    FQuery: TFDQuery;
  public
    constructor Create(DataManager: IDataManager);
    destructor Destroy; override;

    function GetQuery: TDataSet;
    function SQL(Value: String): IStatement;
    function OrderBy(Value: String): IStatement;
    function Params(MetaDates: TMetaDates): IStatement;
    function Open: IStatement;
    function ExecSQL: Integer;

    property Query: TDataSet read GetQuery;
  end;

implementation

uses
  System.SysUtils, FireDAC.Stan.Param;

{ TStatement }

constructor TStatement.Create(DataManager: IDataManager);
begin
  inherited Create;

  FQuery:= TFDQuery.Create(nil);
  FQuery.Connection:= TFDConnection(DataManager.Connection);
end;

destructor TStatement.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

function TStatement.ExecSQL: Integer;
begin
  FQuery.ExecSQL;

  Result:= FQuery.RowsAffected;
end;

function TStatement.GetQuery: TDataSet;
begin
  Result:= FQuery;
end;

function TStatement.Open: IStatement;
begin
  FQuery.Active := True;
  Result:= Self;
end;

function TStatement.OrderBy(Value: String): IStatement;
begin
  FQuery.SQL.Add(' ' + Value);
  Result:= Self;
end;

function TStatement.Params(MetaDates: TMetaDates): IStatement;
begin
  case MetaDates.Kind of
    tpInteger:
      begin
        FQuery.Params.ParamByName(MetaDates.Name).DataType:= ftInteger;
        FQuery.Params.ParamByName(MetaDates.Name).Value   := MetaDates.Value;
      end;

    tpString:
      begin
        FQuery.Params.ParamByName(MetaDates.Name).DataType:= ftString;
        FQuery.Params.ParamByName(MetaDates.Name).Value   := MetaDates.Value;
      end;

    tpFloat:
      begin
        FQuery.Params.ParamByName(MetaDates.Name).DataType:= ftFloat;
        FQuery.Params.ParamByName(MetaDates.Name).Value   := MetaDates.Value;
      end;

    tpDateTime:
      begin
        FQuery.Params.ParamByName(MetaDates.Name).DataType:= ftDateTime;
        FQuery.Params.ParamByName(MetaDates.Name).Value   := MetaDates.Value;
      end;

    tpDate:
      begin
        FQuery.Params.ParamByName(MetaDates.Name).DataType:= ftDate;
        FQuery.Params.ParamByName(MetaDates.Name).Value   := MetaDates.Value;
      end;


    tpTime:
      begin
        FQuery.Params.ParamByName(MetaDates.Name).DataType:= ftTime;
        FQuery.Params.ParamByName(MetaDates.Name).Value   := MetaDates.Value;
      end;

    tpWideString:
      begin
        FQuery.Params.ParamByName(MetaDates.Name).DataType:= ftWideMemo;
        FQuery.Params.ParamByName(MetaDates.Name).Value   := MetaDates.Value;
      end;

    tpBlob: ;

    tpVariant:
      begin
        FQuery.Params.ParamByName(MetaDates.Name).DataType:= ftVariant;
        FQuery.Params.ParamByName(MetaDates.Name).Value   := MetaDates.Value;
      end;
  end;
end;

function TStatement.SQL(Value: String): IStatement;
begin
  FQuery.SQL.Clear;
  FQuery.SQL.Add(Value);
  Result:= Self;
end;

end.

