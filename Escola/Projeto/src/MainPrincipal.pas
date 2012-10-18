unit MainPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, SqlExpr, StdCtrls, DBClient, SimpleDS, Menus, jpeg,
  ExtCtrls;

type
  TMain = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Aluno1: TMenuItem;
    urma1: TMenuItem;
    N11: TMenuItem;
    urma2: TMenuItem;
    Movimentao1: TMenuItem;
    Mensalidades1: TMenuItem;
    Label1: TLabel;
    EventoAtividade1: TMenuItem;
    FormadePagamento1: TMenuItem;
    Image1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    procedure Aluno1Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure urma2Click(Sender: TObject);
    procedure Mensalidades1Click(Sender: TObject);
    procedure EventoAtividade1Click(Sender: TObject);
    procedure FormadePagamento1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

uses uAluno, uturma, uTurmaAluno, uMensalidade, uPesqPessoa,
  uEventoAtividade, uFormaPagamento;


{$R *.dfm}

procedure TMain.Aluno1Click(Sender: TObject);
begin
   if FormAluno = nil then
      FormAluno := TFormAluno.Create(self);
   FormAluno.show;
end;

procedure TMain.N11Click(Sender: TObject);
begin
   if formTurmaAluno = nil then
      Application.CreateForm(TFormTurmaAluno,FormTurmaAluno);
   FormTurmaAluno.show;
end;

procedure TMain.urma2Click(Sender: TObject);
begin
   if FormTurma = nil then
      FormTurma := TFormTurma.Create(self);
   FormTurma.show;

end;

procedure TMain.Mensalidades1Click(Sender: TObject);
begin
   if FormSelecionaPessoa = nil then
      Application.CreateForm(TFormSelecionaPessoa,FormSelecionaPessoa);

   FormSelecionaPessoa.show;
end;

procedure TMain.EventoAtividade1Click(Sender: TObject);
begin
   if FormEventoAtividade = nil then
      application.CreateForm(TFormEventoAtividade,FormEventoAtividade);
   FormEventoAtividade.show;
end;

procedure TMain.FormadePagamento1Click(Sender: TObject);
begin
   if FormFormaPagamento = nil then
      Application.CreateForm(TFormFormaPagamento,FormFormaPagamento);
    FormFormaPagamento.show;
end;

procedure TMain.FormCreate(Sender: TObject);
begin
   Label2.Font.Color := $009A5F16;
   Label3.Font.Color := $009A5F16;
end;

end.
