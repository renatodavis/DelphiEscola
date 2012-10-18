Unit u_cadastropadrao;

Interface

Uses
   Windows,
   Types, DBCtrls, SysUtils, Classes, Graphics, Controls,
   Forms, Dialogs, ExtCtrls, ComCtrls, Buttons, FMTBcd, DB,
   SqlExpr, Provider, DBClient, StdCtrls, DBGrids,uCores;

Type
   TFormPadrao = Class(TForm)
    pnlTitulo: TPanel;
    btnExcluir: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    dsCadastro: TDataSource;
    cdsCadastro: TClientDataSet;
    dspCadastro: TDataSetProvider;
    btnNovo: TBitBtn;
    btnFechar: TBitBtn;
    sqlCadastro: TSQLQuery;
    sqlMax: TSQLQuery;
    lblError: TLabel;
      Procedure FormKeyDown(Sender: TObject; Var Key: Word;
         Shift: TShiftState);
      Procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure cdsCadastroReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure dsCadastroStateChange(Sender: TObject);
    procedure dspCadastroGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: String);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure cdsCadastroAfterApplyUpdates(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsCadastroAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure cdsCadastroAfterDelete(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsCadastroAfterPost(DataSet: TDataSet);
    procedure btnFecharClick(Sender: TObject);

   private
    iCorFundo:integer;
    iTituloGrid:integer;


    procedure DestacaCamposObrigatorios;
    procedure ActivePageControl;
    procedure Foco(FocoTag: Integer);
    procedure Cores;
    function ValidaPreenchidos(ClientDataSet: TClientDataSet): Boolean;
      { Private declarations }
   public
    DesativaBuffer : Boolean;
   protected
      InsereRegistroManual: Boolean;
      iCodEmpresa : integer;
      iCorLinha,iCorLinhaAtiva:TColor;

      procedure DesativarBuffer();

   End;

Var
   FormPadrao: TFormPadrao;

Implementation

uses uDm;

{$R *.dfm}




procedure TFormPadrao.ActivePageControl;
var
   i : Integer;
begin
   for i:= 0 to ComponentCount -1 do
      if Components[i] is TPageControl then
      begin
         (Components[i] as TPageControl).ActivePageIndex:=0;
         Break;
      end;
end;

Procedure TFormPadrao.FormKeyDown(Sender: TObject; Var Key: Word;
   Shift: TShiftState);
begin
   case Key of

      VK_F2: if btnGravar.Enabled then btnGravar.Click;
      VK_F3: if btnExcluir.Enabled then btnExcluir.Click;
      VK_F5: if btnNovo.Enabled then btnNovo.Click;
      VK_F6: if btnFechar.Enabled then btnFechar.Click;
      VK_F9: if btnCancelar.Enabled then btnCancelar.Click;
      VK_RETURN :SelectNext(ActiveControl,true,true);
      VK_ESCAPE :close;
   end;
End;

Procedure TFormPadrao.FormShow(Sender: TObject);
Begin

   InsereRegistroManual:=False;

   //Destaca os campos obrigatorios
   DestacaCamposObrigatorios;

   //Joga o foco para o campo com a propriedade "TabOrder" igual à 0 (zero)
   //Ao jogar o foco, é setado o "Show" na primeira TabSheet, caso exista!
   {if FormStyle = fsNormal then
   begin
      Foco(0);
   end;}
  //Desativa o buffer
  //Ao desativar o buffer, os botoes sao habilitados, de acordo com sua função
  //A rotina de habilitar botoes está no dsCadastro.OnStateChange

  if DesativaBuffer then
    DesativarBuffer;
  Cores ;


End;

procedure TFormPadrao.btnExcluirClick(Sender: TObject);
begin
   if not messagedlg('Deseja excluir o registro atual?',mtConfirmation,[mbYes,mbNo],0)= mrNo then Exit;

   cdsCadastro.Delete;

   { caso a delecao nao aconteca o metodo "ApplyUpdates" irá retornar um valor
   maior que zero, dai o evento "ReconcileError" será ativado e irá ser
   mostrada uma msg para o usuário }


   if cdsCadastro.ApplyUpdates(0) > 0 then
   begin
      cdsCadastro.CancelUpdates;
      Foco(2);
   end
   else
   begin
      DesativarBuffer;
      //stbPadrao.Panels[0].Text := 'Excluído com sucesso.';
      Foco(1);
   end;

end;

procedure TFormPadrao.btnGravarClick(Sender: TObject);
begin
   { posiciona o cursor no próximo controle ativo. Isto é feito para garantir que,
   o foco sai do campo ativo, caso o usuário use teclas de atalho para gravar o
   registro (F2) }
   SelectNext(ActiveControl, True, True);

   { somente irá passar para a rotina de gravacao se estiver inserindo/alterando algo }
   if not (cdsCadastro.State in [dsEdit, dsInsert]) then Abort;


   //se todos os campos obrigatorios estiverem preenchidos, irá gravar os buffer no BD
    if not ValidaPreenchidos(cdsCadastro) then Abort;


   //grava
   cdsCadastro.Post;

   { caso ocorra algum erro na gravacao do registro, o estado continuará
   sendo o de edicao... e uma msg será mostrada ao usuário }
   if cdsCadastro.ApplyUpdates(0) > 0 then
   begin
      //mantem o registro em modo de edição
      cdsCadastro.Edit;

      //joga o foco para o campo com tabOrder = 0
      Foco(2);

      Abort;
   end;

   Foco(1);

end;

{Essa funcao percorre todos os parametros da sqlQuery e limpa-os. Permitindo
ao usuário digitar nos campos limpos...
Esta rotina é usada no OnShow e no "btnCancelar"}
procedure TFormPadrao.DesativarBuffer();
var
   i: Integer;
begin

   //caso exista algum campo no "cdsCadastro"
   if cdsCadastro.FieldCount > 0 then
   begin

      cdsCadastro.Close;

      //percorre todos os parametros do "sqlCadastro", limpando-os
      for i := 0 to sqlCadastro.Params.Count - 1 do
         sqlCadastro.Params[i].Clear;

      cdsCadastro.Open;

   end;

end;

procedure TFormPadrao.btnCancelarClick(Sender: TObject);
begin
   InsereRegistroManual:=False;
   
   cdsCadastro.Cancel;
   cdsCadastro.CancelUpdates;

   //limpa o buffer local
   DesativarBuffer;

   //joga o foco para o campo com a propriedade "TabOrder" igual à 0 (zero)
   Foco(1);
end;

{esta rotina, vai verificar a existencia de um PageControl, caso exista,
será dado o show na primeira tabsheet }
procedure TFormPadrao.Foco(FocoTag: Integer);


   procedure PercorreContainer(C: TWinControl);
   var
      i: Integer;
   begin
      with C do
      begin
         for i:= 0 to ComponentCount -1 do
         begin

            //se for TSpeedButton
            if Components[i] is TCustomEdit then
            begin
               if (Components[i] as TCustomEdit).Tag = FocoTag then
               begin
                  (Components[i] as TCustomEdit).SetFocus;

                  SysUtils.Abort;
               end;
            end;

            if Components[i] is TFrame then
               PercorreContainer((Components[i] as TFrame));

            if Components[i] is TTabSheet then
               PercorreContainer((Components[i] as TTabSheet));

         end;
      end; //--with
   end;

begin
   ActivePageControl;
   PercorreContainer(Self);

end;


procedure TFormPadrao.cdsCadastroReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError;
  UpdateKind: TUpdateKind; var Action: TReconcileAction);

const
   { esta constante "Acao" vai permitir mostrar ao usuario em qual acao aconteceu
   o erro.
   Exemplo: caso o erro aconteça numa alteracao.. vai aparecer uma mensagem,
   dizendo que nao foi possivel ALTERAR o registro em questao }
   Acao : array [TUpdateKind] of string = ('Alterado','Inserido','Excluído');

var
   sMsg : String; //variavel auxiliar para armazenar a mensagem até que ela seja
                  //totalmente formulada para ser mostrada ao usuário

begin

   {
   Mensagem de tratamento dos relacionamentos

   Qdo é uma mensagem de relacionamentos, ela pode ser originada por dois motivos:
   1) uma delecao: outros registros dependem do registro
   2) uma alteracao/insercao: uma FK não está relacionado corretamente. (Isto é improvável,
   visto que a validacao dos campos é feita para cada chave-estrangeira)
   }

   //Caso seja localizada a string "FK_" dentro da mensagem que a excessão lançou
   if Pos('FK_',E.Message) > 0 then
   begin

      //verificamos em que acao aconteceu o erro
      if UpdateKind = ukDelete then
         sMsg:=''
      else
         sMsg:='';

   end;

   {
   Mensagem de tratamento da chave-primária

   Qdo é uma mensagem de tratamento de chave-primaria, siginifica que os campos
   identificadores do registro (PK) já está sendo utilizado por outro registro.
   (Esta mensagem é improvável, visto que a chave-primaria é gerada pela funcao
   Incrementa no evento ClientDataSet.BeforePost...)
   }

   if Pos('PK_',E.Message) > 0 then
      sMsg:='Código já cadastrado!';

   if Pos('UNQ_', E.Message) >0 then
      sMsg:='O valor digitado para o campo na "cor vermelha" já está sendo usado por outro registro.';

   //Mostra a mensagem (agora totalmente formulada) para o usuário!
   lblError.Caption := E.Message;
   lblError.Visible := true;
   messagedlg('O registro não pode ser '+Acao[UpdateKind]+'!',mtError,[mbOk],0);
   lblError.Visible := false;
end;

procedure TFormPadrao.dsCadastroStateChange(
  Sender: TObject);
begin


   btnNovo.Enabled            := not (dsCadastro.State in [dsEdit, dsInsert]);
   btnExcluir.Enabled         := (dsCadastro.State in [dsBrowse]) and (not cdsCadastro.IsEmpty);
   btnFechar.Enabled         := btnExcluir.Enabled;
   btnGravar.Enabled          := dsCadastro.State in [dsEdit, dsInsert];
   pnlTitulo.TabStop          :=btnGravar.Enabled

   //caso o registro esteja sendo editado/inserido, mostrar mensagem.. caso o
   //usuario pressione a tecla ESC
   //MsgDesejaSair  := dsCadastro.State in [dsEdit, dsInsert];

  //- Controle de Acesso
  {if Sessao.Usuario.Tipo = tuLimitado then
  begin
    if Sessao.Usuario.Permissao(Self.NomePrograma, pmTotal) then Exit;

    btnNovo.Enabled      := Sessao.Usuario.Permissao(NomePrograma, pmIncluir);
    btnAlterar.Enabled   := Sessao.Usuario.Permissao(NomePrograma, pmAlterar);

    btnGravar.Enabled    := btnNovo.Enabled or btnAlterar.Enabled;

    btnExcluir.Enabled   := Sessao.Usuario.Permissao(NomePrograma, pmExcluir);
  end;}
end;




procedure TFormPadrao.dspCadastroGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: String);
begin
   TableName := UpperCase(TableName);
end;

procedure TFormPadrao.DestacaCamposObrigatorios;
var
   i : Integer;



   procedure PercorreContainer(C: TWinControl);
   var
      j: Integer;
      lblDestaca : TLabel;
   begin

      with C do
      begin

         //-- percorrer todos os objetos do container
         for j := 0 to ComponentCount -1 do
         begin

            { DBEdit }
            if Components[j] is TDBEdit then
            begin
               if (Components[j] as TDBEdit).DataField = cdsCadastro.Fields[i].FieldName then
               begin

                  lblDestaca              :=TLabel.Create(Self);
                  lblDestaca.Parent       :=(Components[j] as TDBEdit).Parent;
                  lblDestaca.Transparent  :=True;
                  lblDestaca.AutoSize     :=True;
                  lblDestaca.Left         :=(Components[j] as TDBEdit).Left -5;
                  lblDestaca.Top          :=(Components[j] as TDBEdit).Top + 7;

                  lblDestaca.Font.Name    :='Arial';
                  lblDestaca.Font.Size    :=8;
                  lblDestaca.Font.Color   :=clRed;
                  lblDestaca.Font.Style:=[fsbold];
                  lblDestaca.Caption      :='*';

               end;
            end;

            { DBComboBox }
            if Components[j] is TDBComboBox then
            begin

               if (Components[j] as TDBComboBox).DataField = cdsCadastro.Fields[i].FieldName then
               begin

                  lblDestaca              :=TLabel.Create(Self);
                  lblDestaca.Parent       :=(Components[j] as TDBComboBox).Parent;
                  lblDestaca.Transparent  :=True;
                  lblDestaca.AutoSize     :=True;
                  lblDestaca.Left         :=(Components[j] as TDBComboBox).Left -5;
                  lblDestaca.Top          :=(Components[j] as TDBComboBox).Top + 7;
                  lblDestaca.Font.Name    :='Arial';
                  lblDestaca.Font.Size    :=7;
                  lblDestaca.Font.Color   :=clRed;
                  lblDestaca.Caption      :='*';


               end;
            end;




            //-- caso encontre um outro container, percorre-o
            if C.Components[j] is TFrame then
               PercorreContainer((C.Components[j] as TFrame));

            if C.Components[j] is TTabSheet then
               PercorreContainer((C.Components[j] as TTabSheet));

         end;//-- for
      end;//-- with
   end; //-- procedure

begin

   for i := 0 to cdsCadastro.FieldCount -1 do
   begin

      if not cdsCadastro.Fields[i].Required then Continue;

      PercorreContainer( Self );

   end;

end;

procedure TFormPadrao.btnNovoClick(Sender: TObject);
begin
  cdsCadastro.Append;
end;

procedure TFormPadrao.btnAlterarClick(Sender: TObject);
begin

   cdsCadastro.Edit;

   InsereRegistroManual:=False;

end;

procedure TFormPadrao.cdsCadastroAfterApplyUpdates(
  Sender: TObject; var OwnerData: OleVariant);
begin
  
   InsereRegistroManual:=False;
end;

procedure TFormPadrao.cdsCadastroAfterOpen(
  DataSet: TDataSet);
begin
                                                //and (AuditorLigado)
   if (not DataSet.IsEmpty) and (DataSet.RecordCount = 1)  then
   begin
//      Log.Acao := acSelecionar;
//      Log.Execute(cdsCadastro);
   end;
   cdsCadastro.Filtered := true;
   cdsCadastro.Filter := 'codempresa='+IntToStr(iCodEmpresa);
   
end;

procedure TFormPadrao.FormCreate(Sender: TObject);
begin

  sqlCadastro.SQLConnection := dmGeral.SQLConnection;
  DesativaBuffer := True;

  //*****************   cores    ****************** /
  iCorFundo:= $00F9E9DF;
  iTituloGrid :=$00F9E9DF;
  iCorLinha:= $00FCFCF5;
  iCorLinhaAtiva := $009A5F16;
  //************************************************ /

  sqlMax.Close;
  sqlMax.SQL.Text := 'select codempresa from parametro ';
  sqlMax.Open;
  iCodEmpresa := sqlMax.Fields[0].Value;
  sqlMax.close;
end;

procedure TFormPadrao.cdsCadastroAfterDelete(
  DataSet: TDataSet);
begin
   cdsCadastro.ApplyUpdates(0)
end;

procedure TFormPadrao.FormDestroy(Sender: TObject);
begin

  cdsCadastro.CancelUpdates;
  cdsCadastro.Cancel;
  cdsCadastro.Close;
end;

{ essa rotina percorre todos os "Fields" do ClientDataSet e verifica quais
estao com a propriedade Required = True... em seguida verifica se o valor
dakele campo nao é nulo... }
function TFormPadrao.ValidaPreenchidos(ClientDataSet: TClientDataSet): Boolean;
var
   i, j: Integer;
begin

   Result := True;

   for i := 0 to ClientDataSet.FieldCount - 1 do
   begin

      if ClientDataSet.Fields[i].Required then
      begin

         if (ClientDataSet.Fields[i].IsNull) or (ClientDataSet.Fields[i].AsString = '') then
         begin

            Result := False;
            messagedlg('Atenção, existe 1(um) ou mais campos obrigatórios em branco.',mtInformation,[mbOk],0);

            for j := 0 to ComponentCount - 1 do
            begin

               { DBEdit }
               if Components[j] is TDBEdit then
               begin
                  if (Components[j] as TDBEdit).DataField = ClientDataSet.Fields[i].FieldName then
                  begin
                     if (Components[j] as TDBEdit).Parent is TTabSheet then
                        ((Components[j] as TDBEdit).Parent as TTabSheet).Show;

                     (Components[j] as TDBEdit).SetFocus;

                     Break;
                  end;

               end;

               { DBComboBox }
               if Components[j] is TDBComboBox then
               begin

                  if (Components[j] as TDBComboBox).DataField = ClientDataSet.Fields[i].FieldName then
                  begin
                     if (Components[j] as TDBComboBox).Parent is TTabSheet then
                        ((Components[j] as TDBComboBox).Parent as TTabSheet).Show;

                     (Components[j] as TDBComboBox).SetFocus;

                     Break;
                  end;

               end;
            end; {for}
         end;

      end;

      { abortando o looping principal }
      if not Result then
         Break;
   end;

end;

procedure TFormPadrao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
   //cdsCadastro.Close;
 //-- não remover
end;

procedure TFormPadrao.cdsCadastroAfterPost(DataSet: TDataSet);
begin
   cdsCadastro.ApplyUpdates(0)
end;

procedure TFormPadrao.btnFecharClick(Sender: TObject);
begin
   close;
end;

procedure TFormPadrao.Cores;
var
   i:integer;
begin
   for i:= 0 to ComponentCount -1 do
   begin

      if Components[i].Owner is TFormPadrao then
      begin
         (Components[i].Owner as TFormPadrao).Color:=$+iCorFundo;
      end;

      if Components[i] is TDBComboBox then
      begin
         (Components[i] as TDBComboBox).Color:=$00FCFCF5;
      end;

      if Components[i] is TDBEdit then
      begin
         (Components[i] as TDBEdit).Color:=$00FCFCF5;
      end;
      if Components[i] is TEdit then
      begin
         (Components[i] as TEdit).Color:=$00FCFCF5;
      end;

      if Components[i] is TPanel then
      begin
         (Components[i] as TPanel).Color:=$+iCorFundo;
      end;
      // fundo da grid
      if Components[i] is TDBGrid then
      begin
         (Components[i] as TDBGrid).Color:=clWhite;
      end;
      // titulo da grid
      if Components[i] is TDBGrid then
      begin
         (Components[i] as TDBGrid).FixedColor:=$+iTituloGrid;
         (Components[i] as TDBGrid).Canvas.Brush.Color := iCorLinhaAtiva;

      end;

      if Components[i] is TGroupBox then
      begin
         (Components[i] as TGroupBox).Color:=$+iCorFundo;
      end;

   end;
end;

end.
