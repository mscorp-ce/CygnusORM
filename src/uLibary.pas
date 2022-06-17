unit uLibary;

interface

type
  TLibary = class
  public
    class function GetINI(Session, Key: String): String;
    class function GetNameAppToINI: String;
  end;

implementation

{ TLibary }

uses
  System.SysUtils, System.IniFiles, Vcl.Forms;

class function TLibary.GetINI(Session, Key: String): String;
var
  Ini: TIniFile;
begin
  Ini:= TIniFile.Create(GetNameAppToINI);
  try
    Result:= Ini.ReadString(Session, Key, '');
  finally
    FreeAndNil(Ini);
  end;
end;

class function TLibary.GetNameAppToINI: String;
begin
  Result:= ChangeFileExt(Application.ExeName, '.ini');
end;

end.
