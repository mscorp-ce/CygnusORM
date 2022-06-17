unit uAbstraction;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.PGDef, FireDAC.Phys.PG,
  Data.DB, FireDAC.Comp.Client, uAttributes, uMetaDates,
  System.Generics.Collections, System.JSON;

type
  IDataManager = interface
  ['{EFF5B803-DF01-480E-9681-79E85A0FFF69}']

    function GetConnection: TCustomConnection;

    property Connection: TCustomConnection read GetConnection;
  end;

  IStatement = interface
  ['{17072A71-D95C-4125-B99D-62FAB5167185}']

    function GetQuery: TDataSet;
    function SQL(Value: String): IStatement;
    function OrderBy(Value: String): IStatement;
    function Params(MetaDates: TMetaDates): IStatement;
    function Open: IStatement;
    function ExecSQL: Integer;
    property Query: TDataSet read GetQuery;
  end;

  IEvent = interface
  ['{45A92FFC-C739-435A-84DD-CBEC351E67BF}']
  end;

  IController<T: class> = interface
  ['{99B7DE22-401F-4636-9E01-9BEB7345237D}']
    function Save(Entity: T): Boolean;
    function Update(Entity: T): Boolean;
    function DeleteById(Id: Integer): Boolean;
    function DeleteAll: Boolean;
    function FindById(Id: Integer): T;
    function FindAll: TObjectList<T>;
  end;

  IService<T: class> = interface
  ['{8A964BBB-61A6-408E-8A35-2D1FADA08AD1}']
    function Save(Entity: T): Boolean;
    function Update(Entity: T): Boolean;
    function DeleteById(Id: Integer): Boolean;
    function DeleteAll: Boolean;
    function FindById(Id: Integer): T;
    function FindAll: TObjectList<T>;
  end;

  IBusiness<T: class> = interface
  ['{FD0332F6-8E09-4F9E-BCF5-4EB86E3CB722}']

    function Valid(Entity: T): Boolean; overload;
  end;

  IDao<T: class> = interface
  ['{557CB439-8E45-4FAF-AEF4-1ADBE83590C6}']
    function Save(Entity: T): Boolean;
    function Update(Entity: T): Boolean;
    function DeleteById(Id: Integer): Boolean;
    function DeleteAll: Boolean;
    function FindById(Id: Integer): T;
    function FindExists: Boolean;
    function FindAll: TObjectList<T>;
  end;

  IContainerSQL<T: class> = interface
  ['{1A335FB6-ABFD-496B-93BD-E06B2F74FCC8}']
    function Save(Entity: T): String;
    function Update(Entity: T): String;
    function DeleteById(Entity: T): String;
    function DeleteAll(Entity: T): String;
    function FindById(Entity: T): String;
    function FindAll(Entity: T): String;

    function GetDictionary: TObjectList<TMetaDates>;

    property Dictionary: TObjectList<TMetaDates> read GetDictionary;
  end;

  IDataConverter<T: class> = interface
  ['{CFDC37E4-2511-413D-B852-F3F395E110FB}']
    function DataSetToEntity(Data: TDataSet; var Entity: T): IDataConverter<T>;
    function DataSetToEntities(Data: TDataSet; var List: TObjectList<T>): IDataConverter<T>;
  end;

  IJSONReflect<T: class> = interface
  ['{7044BE9D-2F09-4364-9DCF-0DC67CB70077}']
    function Unmarshal(JSONArray: TJSONArray): T;
  end;

implementation

end.
