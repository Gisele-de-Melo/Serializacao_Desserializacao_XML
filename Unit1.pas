//------------------------------------------------------------------------------------------------------------
//********* Sobre ************
//Autor: Gisele de Melo
//Esse c�digo foi desenvolvido com o intuito de aprendizado para o blog codedelphi.com, portanto n�o me
//responsabilizo pelo uso do mesmo.
//
//********* About ************
//Author: Gisele de Melo
//This code was developed for learning purposes for the codedelphi.com blog, therefore I am not responsible for
//its use.
//------------------------------------------------------------------------------------------------------------


unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, XMLDoc, XMLIntf;

type

  TPessoa = class
  public
    Nome: string;
    Idade: Integer;
    Email: string;
  end;

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure SerializarPessoa(Pessoa: TPessoa; var XMLDoc: IXMLDocument);
    procedure CarregarXML;
    procedure DesserializarPessoa(var Pessoa: TPessoa; XMLDoc: IXMLDocument);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  xmlDoc : IXMLDocument;
  Pessoa : TPessoa;
begin

 Pessoa := TPessoa.Create;
 try

   Pessoa.Nome := 'Maria Aparecida';
   Pessoa.Idade := 56;
   Pessoa.Email := 'mariaap@exemplo.com.br';

   SerializarPessoa(Pessoa, xmlDoc);

   Memo1.Clear;
   Memo1.Lines.Add(xmlDoc.XML.Text);

 finally

   if Assigned(Pessoa) then//Verifica se o objeto Pessoa esta em uso e libera da mem�ria
     FreeAndNil(Pessoa);

   if Assigned(xmlDoc) then //Verifica se o objeto xmlDoc esta em uso e libera da mem�ria
     xmlDoc := Nil;
 end;


end;

procedure TForm1.SerializarPessoa(Pessoa: TPessoa; var XMLDoc: IXMLDocument);
var
  RootNode, PessoaNode: IXMLNode;
begin
  // Cria o documento XML
  XMLDoc := TXMLDocument.Create(Self);
  XMLDoc.Active := True;
  XMLDoc.Version := '1.0';
  XMLDoc.Encoding := 'UTF-8';

  // Cria o n� raiz
  RootNode := XMLDoc.AddChild('Pessoas');

  // Cria o n� para o objeto pessoa
  PessoaNode := RootNode.AddChild('Pessoa');

  // Adiciona os atributos do objeto como n�s XML
  PessoaNode.AddChild('Nome').Text := Pessoa.Nome;
  PessoaNode.AddChild('Idade').Text := IntToStr(Pessoa.Idade);
  PessoaNode.AddChild('Email').Text := Pessoa.Email;

  // Salva o XML em um arquivo ou retorna em formato string
  XMLDoc.SaveToFile('Pessoa.xml');
end;

procedure TForm1.DesserializarPessoa(var Pessoa: TPessoa; XMLDoc: IXMLDocument);
var
  PessoaNode: IXMLNode;
begin
  // Acessa o n� raiz do XML
  PessoaNode := XMLDoc.DocumentElement.ChildNodes['Pessoa'];

  // Atribui os valores XML �s propriedades do objeto
  Pessoa.Nome := PessoaNode.ChildValues['Nome'];
  Pessoa.Idade := StrToInt(PessoaNode.ChildValues['Idade']);
  Pessoa.Email := PessoaNode.ChildValues['Email'];
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  CarregarXML;
end;

procedure TForm1.CarregarXML;
var
  Pessoa: TPessoa;
  XMLDoc: IXMLDocument;
begin
  // Cria a inst�ncia da pessoa
  Pessoa := TPessoa.Create;
  try
    // Carrega o documento XML
    XMLDoc := TXMLDocument.Create(nil);

    try
      XMLDoc.LoadFromFile('Pessoa.xml');

      // Desserializa o XML para o objeto
      DesserializarPessoa(Pessoa, XMLDoc);

      Memo1.Clear;
      // Exibe as informa��es do objeto
      Memo1.Lines.Add('Nome: ' + Pessoa.Nome);
      Memo1.Lines.Add('Idade: ' + IntToStr(Pessoa.Idade));
      Memo1.Lines.Add('Email: ' + Pessoa.Email);

    except
      ShowMessage('XML Pessoa n�o encontrado! Utilize o bot�o Serializar primeiro.');
    end;

  finally
    if Assigned(Pessoa) then//Verifica se o objeto Pessoa esta em uso e libera da mem�ria
      FreeAndNil(Pessoa);

    XMLDoc := Nil;
  end;

end;

end.
