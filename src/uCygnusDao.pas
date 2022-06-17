unit uCygnusDao;

interface

uses
  System.Rtti, System.Generics.Collections, uAttributes, uMetaDates, uAbstraction,
  Data.DB;

type
  TDao<T : class, constructor> = class(TInterfacedObject, IDao<T>)
  private
    List: TObjectList<T>;
    Dictionary: TObjectList<TMetaDates>;
    Statement: IStatement;
    {CommandSQLInsert: String;
    CommandSQLUpdate: String;
    CommandSQLDeleteById: String;
    CommandSQLDeleteAll: String;
    CommandSQLFindById: String;
    CommandSQLFindAll: String;}
  public
    constructor Create(Manager: IDataManager);
    destructor Destroy; override;

    function Save(Entity: T): Boolean;
    function Update(Entity: T): Boolean;
    function DeleteById(Id: Integer): Boolean;
    function DeleteAll: Boolean;
    function FindById(Id: Integer): T;
    function FindExists: Boolean;
    function FindAll: TObjectList<T>;
  end;

const
  ctInteger = 0;
  ctString = 1;
  ctFloat = 2;
  ctDateTime = 3;
  ctDate = 4;
  ctTime = 5;
  ctBlob = 6;
  ctVariant = 7;
  ctReturnedSuccessFully = 1;

implementation

{ TDao<T> }

uses
  System.TypInfo, System.SysUtils, Vcl.Dialogs, System.Variants,
  uDataManagerFactory, uStatementFactory, uContainerSQL, System.JSON,
  uDataConverter;


constructor TDao<T>.Create(Manager: IDataManager);
{var
  Container: IContainerSQL<T>;
  Entity: T; }
begin
  inherited Create;

  Statement:= TStatementFactory.GetStatement(Manager);
  {Container:= TContainerSQL<T>.Create;

  Entity:= T.Create;
  try
    CommandSQLInsert:= Container.Save(Entity);
    CommandSQLUpdate:= Container.Update(Entity);
    CommandSQLDeleteById:= Container.DeleteById(Entity);
    CommandSQLDeleteAll:= Container.DeleteAll(Entity);
    CommandSQLFindById:= Container.FindById(Entity);
    CommandSQLFindAll:= Container.FindAll(Entity);

  finally
    FreeAndNil(Entity);
  end; }

  List:= TObjectList<T>.Create;
end;

destructor TDao<T>.Destroy;
begin
  FreeAndNil(List);
  inherited Destroy;
end;

function TDao<T>.DeleteAll: Boolean;
var
  Entity: T;
  Container: IContainerSQL<T>;
  CommadSQL: String;
  i: Word;
begin
  Entity := T.Create;
  try
    Container:= TContainerSQL<T>.Create;

    CommadSQL:= Container.DeleteAll(Entity);

    Statement.SQL(CommadSQL);

    Result:= Statement.ExecSQL >= ctReturnedSuccessFully ;
  finally
    FreeAndNil(Entity);
  end;
end;

function TDao<T>.DeleteById(Id: Integer): Boolean;
var
  Entity: T;
  Container: IContainerSQL<T>;
  CommadSQL: String;
  i: Word;
begin
  Entity := T.Create;
  try
    Container:= TContainerSQL<T>.Create;

    CommadSQL:= Container.DeleteById(Entity);

    Dictionary:= Container.Dictionary;

    Statement.SQL(CommadSQL);

    for i:= 0 to Pred(Dictionary.Count) do
      begin
        Dictionary.Items[i].Value:= Id;
        Statement.Params(Dictionary.Items[i]);
      end;

    Result:= Statement.ExecSQL = ctReturnedSuccessFully;
  finally
    FreeAndNil(Entity);
  end;
end;

function TDao<T>.FindAll: TObjectList<T>;
var
  Entity: T;
  Container: IContainerSQL<T>;
  DataConverter: IDataConverter<T>;
  CommadSQL: String;
begin
  List.Clear;
  Entity:= T.Create;
  try
    Container:= TContainerSQL<T>.Create;

    CommadSQL:= Container.FindAll(Entity);

    Statement.SQL(CommadSQL); //.OrderBy('DataEmissao');

    DataConverter:= TDataConverter<T>.Create;

    DataConverter.DataSetToEntities(Statement.Open.Query, List);

    Result:= List;
  finally
    FreeAndNil(Entity);
  end;
end;

function TDao<T>.FindById(Id: Integer): T;
var
  Entity: T;
  Container: IContainerSQL<T>;
  DataConverter: IDataConverter<T>;
  CommadSQL: String;
  i, k: Word;
begin
  Entity := T.Create;

  Container:= TContainerSQL<T>.Create;

  CommadSQL:= Container.FindById(Entity);

  Dictionary:= Container.Dictionary;

  Statement.SQL(CommadSQL);

  for i:= 0 to Pred(Dictionary.Count) do
    begin
      Dictionary.Items[i].Value:= Id;
      Statement.Params(Dictionary.Items[i]);
    end;

  DataConverter:= TDataConverter<T>.Create;

  DataConverter.DataSetToEntity(Statement.Open.Query, Entity);

  Result:= Entity;
end;

function TDao<T>.FindExists: Boolean;
var
  Entity: T;
  Container: IContainerSQL<T>;
  CommadSQL: String;
begin
  Entity:= T.Create;
  try
    Container:= TContainerSQL<T>.Create;

    CommadSQL:= Container.FindAll(Entity);

    Statement.SQL(CommadSQL); //.OrderBy('DataEmissao');

    Result:= not Statement.Open.Query.IsEmpty;
  finally
    FreeAndNil(Entity);
  end;
end;

function TDao<T>.Save(Entity: T): Boolean;
var
  Container: IContainerSQL<T>;
  CommadSQL: String;
  i: Word;
begin
  Container:= TContainerSQL<T>.Create;

  CommadSQL:= Container.Save(Entity);
  Dictionary:= Container.Dictionary;

  Statement.SQL(CommadSQL);

  for i:= 0 to Pred(Dictionary.Count) do
    begin
      Statement.Params(Dictionary.Items[i]);
    end;

  Result:= Statement.ExecSQL = ctReturnedSuccessFully;
end;

function TDao<T>.Update(Entity: T): Boolean;
var
  Container: IContainerSQL<T>;
  CommadSQL: String;
  i: Word;
begin
  Container:= TContainerSQL<T>.Create;

  CommadSQL:= Container.Update(Entity);
  Dictionary:= Container.Dictionary;

  Statement.SQL(CommadSQL);

  for i:= 0 to Pred(Dictionary.Count) do
    begin
      Statement.Params(Dictionary.Items[i]);
    end;

  Result:= Statement.ExecSQL = ctReturnedSuccessFully;
end;

end.
