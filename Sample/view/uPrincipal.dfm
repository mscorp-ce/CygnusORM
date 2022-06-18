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
    Left = 198
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Update'
    TabOrder = 1
    OnClick = btnUpdateClick
  end
  object btnDeleteById: TButton
    Left = 279
    Top = 24
    Width = 75
    Height = 25
    Caption = 'DeleteById'
    TabOrder = 2
    OnClick = btnDeleteByIdClick
  end
  object btnInsert: TButton
    Left = 117
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Insert'
    TabOrder = 0
    OnClick = btnInsertClick
  end
  object btnDeleteAll: TButton
    Left = 360
    Top = 24
    Width = 75
    Height = 25
    Caption = 'DeleteAll'
    TabOrder = 3
    OnClick = btnDeleteAllClick
  end
  object btnSelectAll: TButton
    Left = 520
    Top = 24
    Width = 75
    Height = 25
    Caption = 'SelectAll'
    TabOrder = 5
    OnClick = btnSelectAllClick
  end
  object btnSelectById: TButton
    Left = 439
    Top = 24
    Width = 75
    Height = 25
    Caption = 'SelectById'
    TabOrder = 4
    OnClick = btnSelectByIdClick
  end
  object grdPedidos: TDBGrid
    Left = 0
    Top = 80
    Width = 744
    Height = 297
    Align = alBottom
    DataSource = dsPedidos
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object dsPedidos: TDataSource
    Left = 616
    Top = 104
  end
end
