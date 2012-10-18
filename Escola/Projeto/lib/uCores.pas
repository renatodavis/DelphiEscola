unit uCores;

interface
uses
   Graphics;

type
   TCores = class
      FFormulario : TColor;
      FTituloGrid : TColor;
      FPainel     : TColor;
      FGrupoBox   : TColor;
    private
      constructor Create;
    public
      property getCorFormulario :TColor read FFormulario;
      property getCortituloGrid :TColor read FTituloGrid;
      property getCorPainel     :TColor read FPainel;
      property getCorGrupBox    :TColor read FGrupoBox;


   end;

implementation

{ TCores }

constructor TCores.Create;
begin
end;

end.
