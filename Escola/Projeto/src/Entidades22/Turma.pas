unit Turma;

interface
uses Banco;
type
   TTurma =class(TObject)
   private
      idTurma :integer;
      desc    :string;
      constructor create;
   published
      con:TBanco;
   public

   end;
implementation



{ TTurma }

constructor TTurma.create;

begin

end;

end.
