object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Serializa'#231#227'o e Desserializa'#231#227'o de XML'
  ClientHeight = 326
  ClientWidth = 244
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object Button1: TButton
    Left = 8
    Top = 24
    Width = 105
    Height = 42
    Caption = 'Serializar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 119
    Top = 24
    Width = 114
    Height = 42
    Caption = 'Desserializar'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 72
    Width = 225
    Height = 241
    TabOrder = 2
  end
end
