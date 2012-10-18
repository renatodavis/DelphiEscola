//$00C5E9FA
unit uMensalidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, u_cadastropadrao, FMTBcd, SqlExpr, Provider, DB, DBClient,
  StdCtrls, Buttons, ExtCtrls, SimpleDS, DBCtrls, Grids, DBGrids, Mask;

type
  TFormMensalidade = class(TFormPadrao)
    DBGrid1: TDBGrid;
    cdsCadastroID: TIntegerField;
    cdsCadastroCODALUNO: TIntegerField;
    cdsCadastroPAGAMENTO: TDateField;
    cdsCadastroVALOR_MENSALIDADE: TFMTBCDField;
    cdsCadastroVALOR_PAGO: TFMTBCDField;
    cdsCadastroOBSER: TStringField;
    Label6: TLabel;
    cdsCadastroSITUACAO: TStringField;
    cdsCadastroVENCIMENTO: TDateField;
    pnlDados: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    cdsCadastroNome: TStringField;
    DBMemo1: TDBMemo;
    lblValorPago: TLabel;
    lblValorPagar: TLabel;
    cdsCadastroCODEMPRESA: TIntegerField;
    sqlCadastroID: TIntegerField;
    sqlCadastroCODALUNO: TIntegerField;
    sqlCadastroVENCIMENTO: TDateField;
    sqlCadastroPAGAMENTO: TDateField;
    sqlCadastroVALOR_MENSALIDADE: TFMTBCDField;
    sqlCadastroVALOR_PAGO: TFMTBCDField;
    sqlCadastroOBSER: TStringField;
    sqlCadastroSITUACAO: TStringField;
    sqlCadastroCODEMPRESA: TIntegerField;
    sqlCadastroCOD_TURMA: TIntegerField;
    cdsCadastroCOD_TURMA: TIntegerField;
    sdsTurma: TSimpleDataSet;
    sdsTurmaIDTURMA: TIntegerField;
    sdsTurmaDESCRICAO: TStringField;
    sdsTurmaVALOR_MENSALIDADE: TFMTBCDField;
    Label7: TLabel;
    Label8: TLabel;
    cdsCadastroNomeTurma: TStringField;
    Bevel1: TBevel;
    cdsCadastroEndecoAluno: TStringField;
    lblEnde: TLabel;
    lblFone: TLabel;
    cdsCadastroFoneAluno: TStringField;
    cdsCadastroBairroAluno: TStringField;
    lblBairro: TLabel;
    lblTurmaAtual: TLabel;
    Label9: TLabel;
    Bevel2: TBevel;
    Label10: TLabel;
    Label3: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    lblVencido: TLabel;
    sdsPessoa: TSimpleDataSet;
    sdsPessoaIDALUNO: TIntegerField;
    sdsPessoaNOME: TStringField;
    sdsPessoaENDE: TStringField;
    sdsPessoaBAIRRO: TStringField;
    sdsPessoaCIDADE: TStringField;
    sdsPessoaUF: TStringField;
    sdsPessoaFONE: TStringField;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    Label14: TLabel;
    cbbAlunos: TComboBox;
    chFiltro: TCheckBox;
    sdsTurmaCODEMPRESA: TIntegerField;
    sdsPessoaCODEMPRESA: TIntegerField;
    sdsFormaPagamento: TSimpleDataSet;
    sdsFormaPagamentoDESCRICAO: TStringField;
    DBLookupComboBox1: TDBLookupComboBox;
    sqlCadastroFORMA_PAGAMENTO: TIntegerField;
    cdsCadastroFORMA_PAGAMENTO: TIntegerField;
    dsForma: TDataSource;
    sdsFormaPagamentoIDPAGAMENTO: TIntegerField;
    Label15: TLabel;
    procedure sdsAlunoAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure cbbAlunoDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure cbbAlunoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsCadastroPAGAMENTOSetText(Sender: TField;
      const Text: String);
    procedure DBEdit1Exit(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dsCadastroStateChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsCadastroAfterOpen(DataSet: TDataSet);
    procedure cdsCadastroBeforePost(DataSet: TDataSet);
    procedure cdsCadastroAfterPost(DataSet: TDataSet);
    procedure DBEdit2Enter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBEdit4Enter(Sender: TObject);
    procedure dsCadastroDataChange(Sender: TObject; Field: TField);
    procedure cdsCadastroAfterScroll(DataSet: TDataSet);
    procedure chFiltroClick(Sender: TObject);
    procedure cbbAlunosCloseUp(Sender: TObject);
    procedure cbbAlunosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure sdsPessoaAfterOpen(DataSet: TDataSet);
    procedure sdsTurmaAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TCorLinha = Class(TCustomDBGrid);

var
  FormMensalidade: TFormMensalidade;

implementation

uses uPesqPessoa, uDm, DateUtils;

{$R *.dfm}

procedure TFormMensalidade.sdsAlunoAfterOpen(DataSet: TDataSet);
begin
  inherited;
{   sdsAluno.First;
   while not sdsAluno.Eof do
   begin
      cbbAluno.AddItem(sdsAlunoNOME.AsString,self);
      sdsAluno.Next;
   end;
}
end;

procedure TFormMensalidade.FormShow(Sender: TObject);
begin
  inherited;
  sdsTurma.Open;
  sdsFormaPagamento.open;
  lblVencido.Caption := '';
  chFiltro.OnClick(self);
{  sdsAluno.close;
  sdsAluno.DataSet.Params[0].Value := iCodEmpresa;
  sdsAluno.open;}
//  cbbAluno.SetFocus;
end;

procedure TFormMensalidade.cbbAlunoDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  inherited;
//   cdsCadastro.Filter := 'CODALUNO  LIKE '+''''+'%'+sdsAlunoIDALUNO.AsString+'%'+'''';
end;

procedure TFormMensalidade.cbbAlunoChange(Sender: TObject);
begin
  inherited;
//  sdsAluno.Locate('NOME',cbbAluno.Text,[]);
//  cdsCadastro.close;
//  sqlCadastro.Params[0].AsString :=sdsAlunoIDALUNO.AsString;
//  cdsCadastro.Open;
//  cbbAluno.DroppedDown := true;
end;

procedure TFormMensalidade.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   inherited;
   FormMensalidade := nil;
   if FormSelecionaPessoa <> nil then
      FreeAndNil(FormSelecionaPessoa);
   sdsTurma.close;
end;

procedure TFormMensalidade.cdsCadastroPAGAMENTOSetText(Sender: TField;
  const Text: String);
begin
  inherited;
  if (Text = '  /  /    ')then
     sender.Value := null
  else
     sender.AsString := Text;

end;

procedure TFormMensalidade.DBEdit1Exit(Sender: TObject);
begin
  inherited;
//  cdsCadastro.Filtered := true;
//  cdsCadastro.Filter := 'VENCIMENTO LIKE '+''''+TDBEdit(sender).Text+'''';

end;

procedure TFormMensalidade.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
   inherited;


   with TCorLinha(Sender) do
   begin
      if DataLink.ActiveRecord = Row -1  then
      begin
         Canvas.Font.Color  := $00F4F4EA;
         Canvas.Brush.Color := iCorLinhaAtiva;
         if cdsCadastroPAGAMENTO.AsString = '' then
         begin
            Canvas.Font.Color  := iCorLinha;
            Canvas.Brush.Color  := clRed;
         end;

      end
      else
      begin
         Canvas.Font.Color  := clWindowText;
         Canvas.Brush.Color := clSilver;
         if cdsCadastroPAGAMENTO.AsString = '' then
         begin
            Canvas.Font.Color  := clRed;
            Canvas.Brush.Color  := clBtnFace;
         end;
      end;

   end;

   TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFormMensalidade.dsCadastroStateChange(Sender: TObject);
begin
   inherited;
   pnlDados.Enabled :=  dsCadastro.State <> dsBrowse;
end;

procedure TFormMensalidade.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
   cdsCadastro.Edit;
   
   DBEdit2.SetFocus;
end;

procedure TFormMensalidade.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
   case key of
      VK_RETURN:DBGrid1.OnDblClick(Self);
      VK_F5 :cbbAlunos.SetFocus;

   end;
end;

procedure TFormMensalidade.cdsCadastroAfterOpen(DataSet: TDataSet);
begin
    inherited;
   cdsCadastro.Filtered:=true;
   cdsCadastro.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa);

   if not cdsCadastroVALOR_PAGO.IsNull then
      lblValorPago.Caption := FormatCurr('#,##0.00',cdsCadastro.Aggregates.Items[0].Value);
   if not cdsCadastroVALOR_MENSALIDADE.IsNull then
      lblValorPagar.Caption := FormatCurr('#,##0.00',cdsCadastro.Aggregates.Items[1].Value);
   lblEnde.Caption := cdsCadastroEndecoAluno.AsString;
   lblFone.Caption := cdsCadastroFoneAluno.AsString;
   lblBairro.Caption := cdsCadastroBairroAluno.AsString;
   lblTurmaAtual.Caption := cdsCadastroNomeTurma.AsString;
      
end;

procedure TFormMensalidade.cdsCadastroBeforePost(DataSet: TDataSet);
begin
  inherited;
  cdsCadastro.FieldByName('CODEMPRESA').Value := iCodEmpresa;
end;

procedure TFormMensalidade.cdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  cdsCadastro.Refresh;
   if not cdsCadastroVALOR_PAGO.IsNull then
      lblValorPago.Caption := FormatCurr('#,##0.00',cdsCadastro.Aggregates.Items[0].Value);
   if not cdsCadastroVALOR_MENSALIDADE.IsNull then
      lblValorPagar.Caption := FormatCurr('#,##0.00',cdsCadastro.Aggregates.Items[1].Value);
  
end;

procedure TFormMensalidade.DBEdit2Enter(Sender: TObject);
begin
   inherited;
   if (DBEdit2.Text = '  /  /    ') then
      DBEdit2.Text := DateToStr(DATE);
end;

procedure TFormMensalidade.FormCreate(Sender: TObject);
begin
  inherited;
  sdsTurma.Connection := dmGeral.SQLConnection;
  sdsFormaPagamento.Connection := dmGeral.SQLConnection;
end;

procedure TFormMensalidade.DBEdit4Enter(Sender: TObject);
begin
  inherited;
   if ((cdsCadastroVALOR_PAGO.IsNull) or (cdsCadastroVALOR_PAGO.AsCurrency =0)) then
      cdsCadastroVALOR_PAGO.AsCurrency := cdsCadastroVALOR_MENSALIDADE.AsCurrency;
   DBEdit4.SelectAll;


end;

procedure TFormMensalidade.dsCadastroDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
   lblEnde.Caption := cdsCadastroEndecoAluno.AsString;
   lblFone.Caption := cdsCadastroFoneAluno.AsString;
   lblBairro.Caption := cdsCadastroBairroAluno.AsString;
   lblTurmaAtual.Caption := cdsCadastroNomeTurma.AsString;

end;

procedure TFormMensalidade.cdsCadastroAfterScroll(DataSet: TDataSet);
begin
   inherited;
//   Panel1.Caption := ' Aluno : '+cdsCadastroNome.AsString;
   if cdsCadastroPAGAMENTO.IsNull then
   begin
      if now >cdsCadastroVENCIMENTO.AsDateTime then
         lblVencido.Caption:= 'Vencido a '+intToStr(DaysBetween(now,cdsCadastroVENCIMENTO.AsDateTime))+' dias.'
      else
         lblVencido.Caption := '';
   end
   else
   begin
      if cdsCadastroPAGAMENTO.AsDateTime >cdsCadastroVENCIMENTO.AsDateTime then
         lblVencido.Caption := 'Pago com atraso de '+intToStr(DaysBetween(cdsCadastroPAGAMENTO.AsDateTime,cdsCadastroVENCIMENTO.AsDateTime))+' dias.'
      else
         lblVencido.Caption := '';      
   end;
end;

procedure TFormMensalidade.chFiltroClick(Sender: TObject);
begin
  inherited;
   if chFiltro.Checked then
   begin


      chFiltro.Caption := '&Mostrar Todas ou Somente as em aberto';
      cdsCadastro.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa)+' and pagamento is null';
   end
   else
   begin
      chFiltro.Caption := '&Mostrar Todas ou Somente as em aberto';
      cdsCadastro.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa);
   end;
   cbbAlunos.OnCloseUp(self);
   DBGrid1.SetFocus;
end;

procedure TFormMensalidade.cbbAlunosCloseUp(Sender: TObject);
begin
   inherited;
   if cbbAlunos.ItemIndex > 0 then
   begin
      sdsPessoa.close;
      sdsPessoa.DataSet.Params[0].AsString := cbbAlunos.Text;
      sdsPessoa.open;
      if chFiltro.Checked then
         FormMensalidade.cdsCadastro.Filter   :='CODEMPRESA='+IntToStr(iCodEmpresa)+' and CODALUNO ='+sdsPessoaIDALUNO.AsString+' and pagamento is null '
      else
         FormMensalidade.cdsCadastro.Filter   :='CODEMPRESA='+IntToStr(iCodEmpresa)+ 'and CODALUNO ='+sdsPessoaIDALUNO.AsString;
      sdsPessoa.close;
   end
   else
   begin
      if chFiltro.Checked then
      begin
         chFiltro.Caption := '&Mostrar Todas ou Somente as em aberto';
         cdsCadastro.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa)+' and pagamento is null';
      end
      else
      begin
         chFiltro.Caption := '&Mostrar Todas ou Somente as em aberto';
         cdsCadastro.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa);
      end;
   end;
end;

procedure TFormMensalidade.cbbAlunosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   inherited;
   case key of
      VK_RETURN:cbbAlunos.OnCloseUp(self);
   end;
end;

procedure TFormMensalidade.btnGravarClick(Sender: TObject);
begin
  inherited;
  DBGrid1.SetFocus;
end;

procedure TFormMensalidade.sdsPessoaAfterOpen(DataSet: TDataSet);
begin
  inherited;
   sdsPessoa.Filtered:=true;
   sdsPessoa.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa);

end;

procedure TFormMensalidade.sdsTurmaAfterOpen(DataSet: TDataSet);
begin
  inherited;
   sdsTurma.Filtered:=true;
   sdsTurma.Filter := 'CODEMPRESA='+IntToStr(iCodEmpresa);

end;

end.
