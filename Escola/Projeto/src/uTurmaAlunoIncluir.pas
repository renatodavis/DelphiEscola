unit uTurmaAlunoIncluir;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CheckLst, Grids, DBGrids, FMTBcd, DB, SqlExpr;

type
  TFormTurmaAlunoIncluir = class(TForm)
    BitBtn1: TBitBtn;
    DBGrid1: TDBGrid;
    sql: TSQLQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
   iEmpresa:integer;

    { Private declarations }
  public
   property Empresa :integer write iEmpresa;
    { Public declarations }
  end;
  TCorLinha = Class(TCustomDBGrid);

var
  FormTurmaAlunoIncluir: TFormTurmaAlunoIncluir;

implementation

uses uTurmaAluno, u_cadastropadrao, uDm;

{$R *.dfm}

procedure TFormTurmaAlunoIncluir.BitBtn1Click(Sender: TObject);
var
   i:integer;
begin

   for i:= 0 to Pred(DBGrid1.SelectedRows.Count) do
   Begin

      FormTurmaAluno.dsAluno.Dataset.Bookmark:= DBGrid1.SelectedRows[i]; // posiciona nos registros selecionados do DBGrid
      if not FormTurmaAluno.cdsCadastro.Locate('COD_ALUNO',FormTurmaAluno.sdsAlunoIDALUNO.Value,[]) then
      begin
         FormTurmaAluno.btnNovo.Click;

         FormTurmaAluno.cdsCadastroCOD_ALUNO.Value := FormTurmaAluno.sdsAlunoIDALUNO.Value;
         FormTurmaAluno.cdsCadastroCOD_TURMA.Value := FormTurmaAluno.sdsTurmaIDTURMA.Value;
         FormTurmaAluno.cdsCadastroANO.AsString       := FormTurmaAluno.Edit1.text;
         FormTurmaAluno.cdsCadastroPERIODO.AsString   := FormTurmaAluno.ComboBox1.Text;
         FormTurmaAluno.cdsCadastroCOBRAR_EVENTO.AsString := 'Sim';
         FormTurmaAluno.cdsCadastro.Post;
      end;
   end;
   FormTurmaAluno.cdsCadastro.Refresh;
   close;

end;

procedure TFormTurmaAlunoIncluir.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
   
   FormTurmaAluno.sdsAluno.Filtered := true;
   FormTurmaAluno.sdsAluno.Filter := 'codempresa='+IntToStr(iEmpresa)+' and nome like '+''''+'%'+upperCase(Key)+'%'+'''';
end;

procedure TFormTurmaAlunoIncluir.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
   FormTurmaAlunoIncluir := nil;
end;

procedure TFormTurmaAlunoIncluir.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin

   with TCorLinha(Sender) do
   begin
      sql.close;
      sql.Params[0].Value := FormTurmaAluno.sdsAlunoIDALUNO.Value;
      sql.Open;
      if (sql.Fields[0].AsInteger <>0)  then;
      begin
         Canvas.Font.Color  := clSilver;//$00F4F4EA;
         Canvas.Brush.Color := clBtnFace;
      exit;
      end;

      if DataLink.ActiveRecord = Row -1  then
      begin
         Canvas.Font.Color  := $00F4F4EA;
         Canvas.Brush.Color := clBlack;
      end
      else
      begin
         Canvas.Font.Color  := clBlack;
         Canvas.Brush.Color := clSilver;
      end;
   end;
   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

end.

