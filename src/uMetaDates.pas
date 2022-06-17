unit uMetaDates;

interface

type
  TTypeKinds = (tpInteger, tpString, tpFloat, tpDateTime, tpDate, tpTime, tpWideString, tpBlob, tpVariant);

  TMetaDates = class
  public
    Name: String;
    Value: Variant;
    Kind: TTypeKinds;
  end;

implementation

end.
