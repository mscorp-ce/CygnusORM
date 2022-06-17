unit uDataManager;

interface

uses
  uAbstraction;

var
  DataManager: IDataManager;

implementation

uses
  uDataManagerFactory;

initialization
  DataManager:= TDataManagerFactory.GetDataManager;

end.
