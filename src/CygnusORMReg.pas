unit CygnusORMReg;

interface

uses
  System.SysUtils, System.Classes, System.Actions, Vcl.ActnList;

type
  TCygnus = class(TComponent)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Cygnus', [TCygnus]);
end;

end.
