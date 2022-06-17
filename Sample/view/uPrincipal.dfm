object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'CygnusORMSample'
  ClientHeight = 377
  ClientWidth = 744
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnUpdate: TButton
    Left = 206
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Update'
    TabOrder = 1
    OnClick = btnUpdateClick
  end
  object btnDeleteById: TButton
    Left = 287
    Top = 72
    Width = 75
    Height = 25
    Caption = 'DeleteById'
    TabOrder = 2
    OnClick = btnDeleteByIdClick
  end
  object btnInsert: TButton
    Left = 125
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Insert'
    TabOrder = 0
    OnClick = btnInsertClick
  end
  object btnDeleteAll: TButton
    Left = 368
    Top = 72
    Width = 75
    Height = 25
    Caption = 'DeleteAll'
    TabOrder = 3
    OnClick = btnDeleteAllClick
  end
  object btnSelectAll: TButton
    Left = 528
    Top = 72
    Width = 75
    Height = 25
    Caption = 'SelectAll'
    TabOrder = 5
    OnClick = btnSelectAllClick
  end
  object btnSelectById: TButton
    Left = 447
    Top = 72
    Width = 75
    Height = 25
    Caption = 'SelectById'
    TabOrder = 4
    OnClick = btnSelectByIdClick
  end
end
