unit uDataConverter;

interface

uses
  uAbstraction, Data.DB, System.Generics.Collections;

type
  TDataConverter<T : class, constructor> = class(TInterfacedObject, IDataConverter<T>)
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    function DataSetToEntity(Data: TDataSet; var Entity: T): IDataConverter<T>;
    function DataSetToEntities(Data: TDataSet; var List: TObjectList<T>): IDataConverter<T>;
  end;

implementation

uses
  System.Rtti, System.Variants, uAttributes, System.TypInfo,
  System.SysUtils;

{ TDataConverter<T> }

constructor TDataConverter<T>.Create;
begin
  inherited Create;
end;

function TDataConverter<T>.DataSetToEntities(Data: TDataSet; var List: TObjectList<T>): IDataConverter<T>;
var
  Entity: T;
  Field : TField;
  Context   : TRttiContext;
  Types   : TRttiType;
  Propertie   : TRttiProperty;
  Attribute: TCustomAttribute;
  Info     : PTypeInfo;
  Value : TValue;
  Name: String;
  i: Word;
begin
  List.Clear;
  Data.First;
  i:= 0;

  try
    Info := System.TypeInfo(T);
    Context := TRttiContext.Create;
    Types := Context.GetType(Info); // Types.TypeKind for tkClass Ref
    while not Data.Eof do
      begin
        Entity:= T.Create;
        for Propertie in Types.GetProperties do
          begin
            Attribute:= Propertie.GetAttributes[i];
            Field:= Data.Fields[i];
            Name:= Field.FieldName;
            case Data.Fields[i].DataType of
              ftString, ftWideString: Value := Field.AsString;
              ftInteger: Value := Field.AsInteger;
              ftDate: Value := Field.AsDateTime;
              ftDateTime: Value := Field.AsDateTime;
              ftTimeStamp: Value := Field.AsDateTime;
              ftTime: Value := Field.AsDateTime;
              ftFloat, ftBCD: Value := Field.AsFloat;
              ftVariant: Value := TValue.FromVariant( Field.AsVariant );
              ftWideMemo:
                begin
                  Value := Field.AsWideString;
                end;
              ftBlob:
                begin
                  //Value := Field.AsBytes;
                end;

            end;
            Propertie.SetValue(Pointer(Entity), Value);
            Inc(i);
          end;
        i:= 0;

        List.Add(Entity);

        Data.Next;
      end;

  Result:= Self;

  finally
    Context.Free;
  end;
end;

function TDataConverter<T>.DataSetToEntity(Data: TDataSet;
  var Entity: T): IDataConverter<T>;
var
  Field : TField;
  Context   : TRttiContext;
  Types   : TRttiType;
  Propertie   : TRttiProperty;
  Attribute: TCustomAttribute;
  Info     : PTypeInfo;
  Value : TValue;
  Name: String;
  Blob: String;
  i: Word;
begin
  Data.First;
  i:= 0;
  while not Data.Eof do
    begin
      Info := System.TypeInfo(T);
      Context := TRttiContext.Create;
      try
        Types := Context.GetType(Info); // Types.TypeKind for tkClass Ref
        for Propertie in Types.GetProperties do
          begin
            Attribute:= Propertie.GetAttributes[i];
            Field:= Data.Fields[i];
            Name:= Field.FieldName;
            case  Data.Fields[i].DataType of
              ftString, ftWideString: Value := Field.AsString;
              ftInteger: Value := Field.AsInteger;
              ftDate: Value := Field.AsDateTime;
              ftDateTime: Value := Field.AsDateTime;
              ftTimeStamp: Value := Field.AsDateTime;
              ftTime: Value := Field.AsDateTime;
              ftFloat, ftBCD: Value := Field.AsFloat;
              ftWideMemo:
                begin
                  Value := Field.AsWideString;
                  Blob:= 'WideMemo';
                end;
              ftBlob:
                begin
                  //Value := Field.AsBytes;
                  Blob:= 'Blob';
                end;
              ftVariant: Value := TValue.FromVariant( Field.AsVariant );
            end;

            Propertie.SetValue(Pointer(Entity), Value);
            inc(i);
            Data.Next;
          end;

      finally
        Context.Free;
      end;
    end;
  Result:= Self;
end;

destructor TDataConverter<T>.Destroy;
begin
  inherited Destroy;
end;

end.
