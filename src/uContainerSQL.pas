unit uContainerSQL;

interface

uses
  System.Generics.Collections, System.Rtti, uAbstraction, uMetaDates;

type
  TContainerSQL<T : class, constructor> = class(TInterfacedObject, IContainerSQL<T>)
  private
    fDictionary: TObjectList<TMetaDates>;
    MetaDates: TMetaDates;

    procedure AddPrimaryKeyDictionary(Entity: T; Properties: TRttiProperty; Name: String; Value: Variant; Kind: TTypeKind);
    procedure AddDictionary(Entity: T; Name: String; Properties: TRttiProperty; Kinds: Word);
    procedure GetPropertiesReferenceValue(Entitie: TObject; var Dictionary: TObjectList<TMetaDates>; Name: String);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    function Save(Entity: T): String;
    function Update(Entity: T): String;
    function DeleteById(Entity: T): String;
    function DeleteAll(Entity: T): String;
    function FindById(Entity: T): String;
    function FindAll(Entity: T): String;

    function GetDictionary: TObjectList<TMetaDates>;

    property Dictionary: TObjectList<TMetaDates> read GetDictionary;
  end;

const
  ctInteger = 0;
  ctString = 1;
  ctFloat = 2;
  ctDateTime = 3;
  ctDate = 4;
  ctTime = 5;
  ctWideString = 6;
  ctBlob = 7;
  ctVariant = 8;

implementation

uses
  uAttributes, System.SysUtils, System.Variants, System.TypInfo;

{ TContainerSQL<T> }

procedure TContainerSQL<T>.AddDictionary(Entity: T; Name: String;
  Properties: TRttiProperty; Kinds: Word);
begin
  MetaDates.Name:= Name;
  MetaDates.Value:= Properties.GetValue(Pointer(Entity)).AsVariant;

  case Kinds of
    ctInteger: MetaDates.Kind:= tpInteger;
    ctString: MetaDates.Kind:= tpString;
    ctFloat: MetaDates.Kind:= tpFloat;
    ctDateTime: MetaDates.Kind:= tpDateTime;
    ctDate: MetaDates.Kind:= tpDate;
    ctTime: MetaDates.Kind:= tpTime;
    ctWideString: MetaDates.Kind:= tpWideString;
    ctBlob: MetaDates.Kind:= tpBlob;
    ctVariant: MetaDates.Kind:= tpVariant;
  end;

  Dictionary.Add(MetaDates);
end;

procedure TContainerSQL<T>.AddPrimaryKeyDictionary(Entity: T; Properties: TRttiProperty; Name: String; Value: Variant;
  Kind: TTypeKind);
begin
  MetaDates:= TMetaDates.Create;
  MetaDates.Name:= Name;
  MetaDates.Value:= Value;

  case Kind of
    tkInteger: MetaDates.Kind:= tpInteger;

    tkFloat:
      begin
        if Properties.GetValue(Pointer(Entity)).TypeInfo = TypeInfo(TDateTime) then
          begin
            MetaDates.Kind:= tpDateTime;
          end
        else if Properties.GetValue(Pointer(Entity)).TypeInfo = TypeInfo(TDate) then
          begin
            MetaDates.Kind:= tpDate;
          end
        else if Properties.GetValue(Pointer(Entity)).TypeInfo = TypeInfo(TTime) then
          begin
            MetaDates.Kind:= tpTime;
          end
        else
          begin
            MetaDates.Kind:= tpFloat;
          end;
      end;

    tkWChar,
    tkLString,
    tkUString,
    tkString:
      begin
        MetaDates.Kind:= tpString;
      end;

    tkWString: MetaDates.Kind:= tpWideString;

    //tkBlob: MetaDates.Kind:= tpBlob;

    tkVariant:
      begin
        MetaDates.Kind:= tpVariant;
      end;
  end;

  Dictionary.Add(MetaDates);
end;

constructor TContainerSQL<T>.Create;
begin
  inherited Create;

  fDictionary:= TObjectList<TMetaDates>.Create;
end;

function TContainerSQL<T>.DeleteAll(Entity: T): String;
var
  Context    : TRttiContext;
  Types      : TRttiType;
  Attribute  : TCustomAttribute;
  CommadSQL  : String;
begin
  Context := TRttiContext.Create;
  try
    Types := Context.GetType(Entity.ClassType);

    for Attribute in Types.GetAttributes do
      begin
        if Attribute is TTable then
          begin
            CommadSQL:= 'DELETE FROM ' + (Attribute as TTable).Name;
            Break
          end;
      end;

    Result:= CommadSQL;

  finally
    Context.Free;
  end;
end;

function TContainerSQL<T>.DeleteById(Entity: T): String;
var
  Context    : TRttiContext;
  Types      : TRttiType;
  Attribute  : TCustomAttribute;
  Properties : TRttiProperty;
  PKProperties: TRttiProperty;
  Name: String;
  CommadSQL  : String;
  PKName: String;
  PKTypeKind: TTypeKind;
begin
  Context := TRttiContext.Create;
  try
    Types := Context.GetType(Entity.ClassType);

    for Attribute in Types.GetAttributes do
      begin
        if Attribute is TTable then
          begin
            CommadSQL:= 'DELETE FROM ' + (Attribute as TTable).Name;
            Break
          end;
      end;

    for Properties in Types.GetProperties do
      begin
        for Attribute in Properties.GetAttributes do
          begin
            if (Attribute is TAutoIncrement) or (Attribute is TPrimaryKey) then
              begin
                PKName:= (Attribute as TPrimaryKey).Name;
                PKTypeKind:= Properties.PropertyType.TypeKind;
                PKProperties:= Properties;

                Break;
              end;
          end;

        if not PKName.IsEmpty  then
          Break;
      end;

    CommadSQL:= CommadSQL + ' Where '+ PKName + ' = :'+ PKName;

    AddPrimaryKeyDictionary(Entity, PKProperties, PKName, 0, PKTypeKind);

    Result:= CommadSQL;

  finally
    Context.Free;
  end;
end;

destructor TContainerSQL<T>.Destroy;
begin
  FreeAndNil(fDictionary);

  inherited Destroy;
end;

function TContainerSQL<T>.FindAll(Entity: T): String;
var
  Context    : TRttiContext;
  Types      : TRttiType;
  Attribute  : TCustomAttribute;
  Properties : TRttiProperty;
  Name: String;
  CommadSQL  : String;
  Attributes: String;
  Sep: String;
  i: Integer;
begin
  Context := TRttiContext.Create;
  try
    Types := Context.GetType(Entity.ClassType);

    for Attribute in Types.GetAttributes do
      begin
        if Attribute is TTable then
          begin
            CommadSQL:= 'SELECT @Attributes@ FROM ' + (Attribute as TTable).Name;
            Break
          end;
      end;

    for Properties in Types.GetProperties do
      begin
        for Attribute in Properties.GetAttributes do
          begin
            if (Attribute is TColumn) then
              begin
                Name:= (Attribute as TColumn).Name;
                Attributes:= Attributes+ Sep + Name;
                Sep:= ', ';
              end;
          end;
      end;

    CommadSQL:= StringReplace(CommadSQL, '@Attributes@', Attributes, [rfReplaceAll]);

    Result:= CommadSQL;

  finally
    Context.Free;
  end;
end;

function TContainerSQL<T>.FindById(Entity: T): String;
var
  Context    : TRttiContext;
  Types      : TRttiType;
  Attribute  : TCustomAttribute;
  Properties : TRttiProperty;
  PKProperties: TRttiProperty;
  Info       : PTypeInfo;
  List: TPropList;
  ChildObj: TObject;
  Name: String;
  PKName: String;
  PKValue: Variant;
  PKTypeKind: TTypeKind;
  CommadSQL  : String;
  Attributes: String;
  Sep: String;
  Count, i: Integer;
begin
  Context := TRttiContext.Create;
  try
    Types := Context.GetType(Entity.ClassType);

    for Attribute in Types.GetAttributes do
      begin
        if Attribute is TTable then
          begin
            CommadSQL:= 'SELECT @Attributes@ FROM ' + (Attribute as TTable).Name;
            Break
          end;
      end;

    for Properties in Types.GetProperties do
      begin
        for Attribute in Properties.GetAttributes do
          begin
            if (Attribute is TAutoIncrement) or (Attribute is TPrimaryKey) then
              begin
                PKName:= (Attribute as TPrimaryKey).Name;
                PKValue:= Properties.GetValue(Pointer(Entity)).AsVariant;
                PKTypeKind:= Properties.PropertyType.TypeKind;
                PKProperties:= Properties;
              end;

            if (Attribute is TColumn) then
              begin
                Name:= (Attribute as TColumn).Name;
                Attributes:= Attributes+ Sep + Name;
                Sep:= ', ';
              end;
          end;
      end;

    CommadSQL:= StringReplace(CommadSQL, '@Attributes@', Attributes, [rfReplaceAll]);

    CommadSQL:= CommadSQL + ' Where '+ PKName + ' = :'+ PKName;

    AddPrimaryKeyDictionary(Entity, PKProperties, PKName, PKValue, PKTypeKind);

    Result:= CommadSQL;

  finally
    Context.Free;
  end;
end;

function TContainerSQL<T>.GetDictionary: TObjectList<TMetaDates>;
begin
  Result:= fDictionary;
end;

procedure TContainerSQL<T>.GetPropertiesReferenceValue(Entitie: TObject;
  var Dictionary: TObjectList<TMetaDates>; Name: String);
var
  Context: TRttiContext;
  Types: TRttiType;
  Attribute: TCustomAttribute;
  Properties: TRttiProperty;
  Cont: Word;
begin
  Context:= TRttiContext.Create;
  Types:= Context.GetType(Entitie.ClassType);

  Cont:= Dictionary.Count;
  for Properties in Types.GetProperties do
    begin
      for Attribute in Properties.GetAttributes do
        begin
          if (Attribute is TPrimaryKey) then
            begin
              if (Properties.GetValue(Entitie).AsInteger <> 0) then
                begin
                  MetaDates.Name:= Name;
                  MetaDates.Value:= Properties.GetValue(Entitie).AsInteger;
                  MetaDates.Kind:= tpInteger;
                  Dictionary.Add(MetaDates);
                  Break
                end
              else
                begin
                  MetaDates.Name:= Name;
                  MetaDates.Value:= Null;
                  MetaDates.Kind:= tpInteger;
                  Break
                end;
            end;
        end;
      if Dictionary.Count > Cont then
        Break
    end;
end;

function TContainerSQL<T>.Save(Entity: T): String;
var
  Context    : TRttiContext;
  Types      : TRttiType;
  Attribute  : TCustomAttribute;
  Properties : TRttiProperty;
  ChildObj: TObject;
  Name: String;
  CommadSQL  : String;
  Params: String;
  Sep: String;
  i: Integer;
begin
  Context := TRttiContext.Create;
  try
    Types := Context.GetType(Entity.ClassType);

    for Attribute in Types.GetAttributes do
      begin
        if Attribute is TTable then
          begin
            CommadSQL:= 'INSERT INTO ' + (Attribute as TTable).Name + '(';
            Break
          end;
      end;

    for Properties in Types.GetProperties do
      begin
        for Attribute in Properties.GetAttributes do
          begin
            if Attribute is TAutoIncrement then
              Continue;

            if Attribute is TColumn then
              begin
                Name:= (Attribute as TColumn).Name;
                CommadSQL:= CommadSQL + Sep + Name;
                Params:= Params + Sep + ':' + Name;
                Sep:= ', ';
                MetaDates:= TMetaDates.Create;
                case Properties.PropertyType.TypeKind of
                  tkClass:
                    begin
                      ChildObj:= Properties.GetValue(Pointer(Entity)).AsObject;
                      try
                        GetPropertiesReferenceValue(ChildObj, fDictionary, Name );
                      finally
                        FreeAndNil(ChildObj);
                      end;
                    end;

                  tkInteger:
                    begin
                      AddDictionary(Entity, Name, Properties, ctInteger);
                    end;

                  tkFloat:
                    begin
                      if Properties.GetValue(Pointer(Entity)).TypeInfo = TypeInfo(TDateTime) then
                        begin
                          AddDictionary(Entity, Name, Properties, ctDateTime);
                        end
                      else if Properties.GetValue(Pointer(Entity)).TypeInfo = TypeInfo(TDate) then
                        begin
                          AddDictionary(Entity, Name, Properties, ctDate);
                        end
                      else if Properties.GetValue(Pointer(Entity)).TypeInfo = TypeInfo(TTime) then
                        begin
                          AddDictionary(Entity, Name, Properties, ctTime);
                        end
                      else
                        begin
                          AddDictionary(Entity, Name, Properties, ctFloat);
                        end;
                    end;

                  tkWChar,
                  tkLString,
                  tkUString,
                  tkString:
                    begin
                      AddDictionary(Entity, Name, Properties, ctString);
                    end;

                  tkWString: AddDictionary(Entity, Name, Properties, ctWideString);

                  {ftWideMemo:
                    begin
                      Value := Field.AsWideString;
                    end;
                  tkBlob:
                    begin
                      //Value := Field.AsBytes;
                    end;}

                  tkVariant:
                    begin
                      AddDictionary(Entity, Name, Properties, ctVariant);
                    end;
                end;
             end;
          end;
      end;

    CommadSQL:= CommadSQL + ' ) VALUES(' + Params + ');';

    Result:= CommadSQL;

  finally
    Context.Free;
  end;
end;

function TContainerSQL<T>.Update(Entity: T): String;
var
  Context    : TRttiContext;
  Types      : TRttiType;
  Attribute  : TCustomAttribute;
  Properties : TRttiProperty;
  PKProperties: TRttiProperty;
  Info       : PTypeInfo;
  List: TPropList;
  ChildObj: TObject;
  Name: String;
  PKName: String;
  PKValue: Variant;
  PKTypeKind: TTypeKind;
  CommadSQL  : String;
  Sep: String;
  Count, i: Integer;
begin
  Info:= System.TypeInfo(T);

  Count:= GetPropList(TypeInfo(T), tkAny, @List);

  Context := TRttiContext.Create;
  try
    Types := Context.GetType(Entity.ClassType);

    for Attribute in Types.GetAttributes do
      begin
        if Attribute is TTable then
          begin
            CommadSQL:= 'UPDATE ' + (Attribute as TTable).Name + ' SET ';
            Break
          end;
      end;

    for Properties in Types.GetProperties do
      begin
        for Attribute in Properties.GetAttributes do
          begin
            if (Attribute is TAutoIncrement) or (Attribute is TPrimaryKey) then
              begin
                PKName:= (Attribute as TPrimaryKey).Name;

                PKValue:= Properties.GetValue(Pointer(Entity)).AsVariant;
                PKTypeKind:= Properties.PropertyType.TypeKind;
                PKProperties:= Properties;

                Continue;
              end;

            if (Attribute is TColumn) then
              begin
                Name:= (Attribute as TColumn).Name;

                if PKName = Name then
                  Continue;

                CommadSQL:= CommadSQL + Sep + Name + ' = :' + Name;
                Sep:= ', ';
                MetaDates:= TMetaDates.Create;

                case Properties.PropertyType.TypeKind of
                  tkClass:
                    begin
                      ChildObj:= Properties.GetValue(Pointer(Entity)).AsObject;
                      try
                        GetPropertiesReferenceValue(ChildObj, fDictionary, Name );
                      finally
                        FreeAndNil(ChildObj);
                      end;
                    end;

                  tkInteger:
                    begin
                      AddDictionary(Entity, Name, Properties, ctInteger);
                    end;

                  tkFloat:
                    begin
                      if Properties.GetValue(Pointer(Entity)).TypeInfo = TypeInfo(TDateTime) then
                        begin
                          AddDictionary(Entity, Name, Properties, ctDateTime);
                        end
                      else if Properties.GetValue(Pointer(Entity)).TypeInfo = TypeInfo(TDate) then
                        begin
                          AddDictionary(Entity, Name, Properties, ctDate);
                        end
                      else if Properties.GetValue(Pointer(Entity)).TypeInfo = TypeInfo(TTime) then
                        begin
                          AddDictionary(Entity, Name, Properties, ctTime);
                        end
                      else
                        begin
                          AddDictionary(Entity, Name, Properties, ctFloat);
                        end;
                    end;

                  tkWChar,
                  tkLString,
                  tkUString,
                  tkString:
                    begin
                      AddDictionary(Entity, Name, Properties, ctString);
                    end;

                  tkWString: AddDictionary(Entity, Name, Properties, ctWideString);

                  tkVariant:
                    begin
                      AddDictionary(Entity, Name, Properties, ctVariant);
                    end;
                end;
              end;
          end;
      end;

    CommadSQL:= CommadSQL + ' Where '+ PKName + ' = :'+ PKName;

    AddPrimaryKeyDictionary(Entity, PKProperties, PKName, PKValue, PKTypeKind);

    Result:= CommadSQL;

  finally
     Context.Free;
  end;
end;

end.
