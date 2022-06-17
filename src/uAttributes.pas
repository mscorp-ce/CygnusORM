unit uAttributes;

interface

uses
  System.RTTI;

type
  TEntity = class(TCustomAttribute);

  TTable = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(Name: string);
    property Name: string read FName;
  end;

  TColumn = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(Name: string);
    property Name: string read FName;
  end;

  TId = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(Name: string);
    property Name: string read FName;
  end;

  TPrimaryKey = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(Name: string);
    property Name: string read FName;
  end;

  TAutoIncrement = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(Name: string);
    property Name: string read FName;
  end;

  TForeignKey = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(Name: string);
    property Name: string read FName;
  end;

  TClassRefs = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(Name: string);
    property Name: string read FName;
  end;

implementation

{ TId }

constructor TId.Create(Name: string);
begin
  inherited Create;

  FName:= Name;
end;

{ TPrimaryKey }

constructor TPrimaryKey.Create(Name: string);
begin
  inherited Create;

  FName:= Name;
end;

{ TForeignKey }

constructor TForeignKey.Create(Name: string);
begin
  inherited Create;

  FName:= Name;
end;

{ TColumn }

constructor TColumn.Create(Name: string);
begin
  inherited Create;

  FName:= Name;
end;

{ TTable }

constructor TTable.Create(Name: string);
begin
  inherited Create;

  FName:= Name;
end;

{ TAutoIncrement }

constructor TAutoIncrement.Create(Name: string);
begin
  inherited Create;

  FName:= Name;
end;

{ TClassRefs }

constructor TClassRefs.Create(Name: string);
begin
  inherited Create;

  FName:= Name;
end;

end.
