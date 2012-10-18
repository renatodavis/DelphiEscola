unit Aluno;

interface
uses Classes,Banco,Turma,Dialogs,DBClient, SimpleDS;
Type

   TAluno = class
      private
         idAluno : integer;
         nome    : string;
         ende    : string;
         turma   : integer;
         banco : TBanco;
         constructor create;

      published
      public
         procedure insereAluno(valores:OleVariant);

      end;
   { TAluno }




implementation



{ TAluno }

constructor TAluno.create;
begin
   banco := TBanco.Create(nil);
end;

procedure TAluno.insereAluno(valores:OleVariant);
var
   campos : TStringList;
begin
   campos := TStringList.Create;

   banco.GetFieldsValues('ALUNO',campos,true);
   banco.ExecutaSQL('insert into ALUNO ('+campos.Text + ')VALUES('+valores.Text+')');

end;

end.
