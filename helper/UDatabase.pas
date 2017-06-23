unit UDatabase;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls,
  Dialogs, StdCtrls, JvJCLUtils, Math, ADODB, ADOX_TLB, JvStringHolder;

type
  TDatabase = class
    protected
      query : TADOQuery;
      ms_access: TADOXCatalog;
      SQLSchema: TJvMultiStringHolder;
    private
      procedure DBSchema_get;
      function DBSchema_check: boolean;
      function DBCreate: boolean;
      procedure init;
    public
      server: TADOConnection;
      server_cmd: TADOCommand;
      
      SQLQuery: TJvMultiStringHolder;
      DBFileName: string;

      constructor Create;
      destructor Destroy; override;

      function DBInit: boolean;
      procedure create_table(tableName: string; const fields: TStrings = nil;const seeds: TStrings = nil);
  end;

implementation

uses HelperGeneral;

constructor TDatabase.Create;
begin
  server:= TADOConnection.Create(nil);
  server_cmd:= TADOCommand.Create(nil);
  query := TADOQuery.Create(nil);
  ms_access:= TADOXCatalog.Create(nil);
  SQLQuery:= TJvMultiStringHolder.Create(nil);
  SQLSchema:= TJvMultiStringHolder.Create(nil);

  init;
end;

destructor TDatabase.Destroy;
begin
  if server.Connected then
    server.Connected:= false;

  server.Free;
  server_cmd.Free;
  ms_access.Free;
  SQLQuery.Free;
  SQLSchema.Free;
end;

procedure TDatabase.init;
const
  strSql: array [0..1] of string = ('create','select');
var
  S: TJvMultiStringHolderCollectionItem;
  i: integer;
begin
  server.LoginPrompt:= false;
  server_cmd.Connection:= server;
  query.Connection:= server;

  for i:= 0 to 1 do
  begin
    S:= SQLQuery.MultipleStrings.Add;
    S.Name:= StrSql[i];
  end;
end;

{ CONVERT SQLQUERY TO SQLSCHEMA STRING HOLDER }
procedure TDatabase.DBSchema_get;
var sql, table, sField: string;
    i, pos: integer;
    lstSplit: TStrings;
    ST, SC: TJvMultiStringHolderCollectionItem;
begin
  lstSplit:= TStringList.Create;
  try
  if (SQLQuery.ItemByName['create'].Strings.Count > 0) then
  begin
    SQLSchema.MultipleStrings.Clear;
    for pos:= 0 to (SQLQuery.ItemByName['create'].Strings.Count - 1) do
    begin
      sql:= SQLQuery.ItemByName['create'].Strings[pos];
      sql:= StringReplace(sql,'CREATE TABLE ','',[rfReplaceAll,rfIgnoreCase]);
      table:= Trim(AnsiLeftStr(sql,AnsiPos(' ',sql)));
      sql:= StringReplace(sql,table+' (','',[rfReplaceAll,rfIgnoreCase]);
      sql:= StringReplace(sql,');','',[rfReplaceAll,rfIgnoreCase]);;
      lstSplit:= explode(',',sql);
      if lstSplit.Count > 0 then
      begin
        ST:= SQLSchema.MultipleStrings.Add;
        SC:= SQLSchema.MultipleStrings.Add;
        ST.Name:= table;
        SC.Name:= table+'_schema';
        for i:= 0 to lstSplit.Count - 1 do
        begin
          sField:= AnsiLeftStr(lstSplit.Strings[i],AnsiPos(' ',lstSplit.Strings[i]));
          ST.Strings.Add(Trim(sField));
          SC.Strings.Add(Trim(lstSplit.Strings[i]));
        end;
      end;
    end;
  end;
  finally
    lstSplit.Free;
    //ST.Free;
    //SC.Free;
  end;
end;

{ PERFORM CHECK TABLE AND FIELD FROM SQLSCHEMA }
function TDatabase.DBSchema_check: boolean;
var lstSplit: TStringList;
    i, ii: integer;
    getTable, getField,
    newTable, newField: TStringList;
    oldTable, oldField: array of string;
    schema: string;
begin
  result:= false;
  lstSplit:= TStringList.Create;
  newTable:= TStringList.Create;
  getTable:= TStringList.Create;
  getField:= TStringList.Create;
  newField:= TStringList.Create;
  try
  DBSchema_get;
  if (SQLSchema.MultipleStrings.Count > 0)
    and (Server.Connected) then
  begin
    // begin to check table in database
    Server.GetTableNames(getTable, false);
    if (getTable.Count > 0) then
    begin
      // get new table from scatch to tstring
      for i:= 0 to SQLSchema.MultipleStrings.Count - 1 do
        if (AnsiPos('_schema',SQLSchema.MultipleStrings.Items[i].Name) = 0) then
          newTable.Add(SQLSchema.MultipleStrings.Items[i].Name);

      // parse old table to array
      SetLength(oldTable, 0);
      for i:= 0 to getTable.Count - 1 do
      begin
        SetLength(oldTable, length(oldTable)+1);
        oldTable[length(oldTable)-1]:= getTable.Strings[i];
      end;

      result:= true;
      for i:= 0 to newTable.Count - 1 do
      begin
        // table not exist in current database
        if not(ArrayContainText(newTable.Strings[i],oldTable,true)) then
        begin
          // create it
          Server_cmd.CommandText:= SQLQuery.ItemByName['create'].Strings[i];
          Server_cmd.Execute;
        end else
        begin
          // get new field to tstring
          newField.clear;
          newField.AddStrings(SQLSchema.StringsByName[newTable.Strings[i]]);

          getField.clear;
          Server.GetFieldNames(newTable.Strings[i], getField);
          if (getField.Count > 0) and (newField.Count > 0) then
          begin
            // parse old field to array
            SetLength(oldField, 0);
            for ii:= 0 to getField.Count - 1 do
            begin
              SetLength(oldField, length(oldField)+1);
              oldField[length(oldField)-1]:= getField.Strings[ii];
            end;

            for ii:= 0 to newField.Count - 1 do
            begin
              // field not exist in current table
              if not(ArrayContainText(newField.Strings[ii],oldField,true)) then
              begin
                // create it
                schema:= SQLSchema.StringsByName[newTable.Strings[i]+'_schema'].Strings[ii];
                Server_cmd.CommandText:= 'ALTER TABLE '+newTable.Strings[i]+' ADD '+schema;
                Server_cmd.Execute;
              end;
            end;
          end;
        end;

        // create seed table
        //DBSeed(newTable.Strings[i]);
      end;
    end else
    // empty table in database
    begin
      for i:= 0 to (SQLQuery.ItemByName['create'].Strings.Count - 1) do
      begin
        Server_cmd.CommandText:= SQLQuery.ItemByName['create'].Strings[i];
        Server_cmd.Execute;
      end;
      Result:= true;
    end;
  end;
  finally
    lstSplit.Free;
    getTable.Free;
    getField.Free;
    newTable.Free;
    newField.Free;
  end;
end;

function TDatabase.DBCreate: boolean;
var DataSource: string;
begin
  Result:= false;
  if not(FileExists(DBFileName)) then
  begin
    DataSource :=
    'Provider=Microsoft.Jet.OLEDB.4.0' +
    ';Data Source=' + DBFileName +
    ';Jet OLEDB:Engine Type=5;'; // 4: ms97, 5: ms2000

    ms_access.Create1(DataSource);
  end;

  if FileExists(DBFileName) then
    Result:= true;
end;

{ INITIALING DATABASE STRUCTURE }
function TDatabase.DBInit: boolean;
begin
  Result:= false;

  if (Server.Connected) then
    Server.Connected:= false;

  if (DBCreate) then
  begin
    Server.ConnectionString:= 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+DBFileName+';Persist Security Info=False;';
    Server.Connected:= true;

    if (Server.Connected) then
      if (DBSchema_check) then
        Result:= true;
  end;
end;

{ ============================================================================================================================ }

procedure TDatabase.create_table(tableName: string; const fields: TStrings = nil; const seeds: TStrings = nil);
var
  getTable, getField, getSch: TStrings;
  i, start: integer;
begin
  if not(server.Connected) then exit;

  getTable:= TStringList.Create;
  Server.GetTableNames(getTable, false);
  if Not(ArrayContainTextList(tableName, getTable, true)) then
  begin
    Server_cmd.CommandText:= 'CREATE TABLE '+tableName+' ('+implode(', ',fields)+');';
    Server_cmd.Execute;
  end;

  getField:= TStringList.Create;
  Server.GetFieldNames(tableName, getField);
  if (fields <> nil) AND (fields.Count > 0) then
  for i:= 0 to (fields.Count-1) do
  begin
    getSch:= explode(' ',fields.Strings[i]);
    if (getSch.Count > 0) then
    if Not(ArrayContainTextList(getSch.Strings[0], getField, true)) then
    begin
      Server_cmd.CommandText:= 'ALTER TABLE '+tableName+' ADD '+fields.Strings[i]+';';
      Server_cmd.Execute;
    end;
  end;

  if (seeds.Count > 0) AND (fields.Count = seeds.Count) then
  begin
    getField.Clear;
    for i:= 0 to (fields.Count-1) do
      getField.Add(explode(' ',fields.Strings[i]).Strings[0]);

    try
      start:= 1;
      query.SQL.Text:= 'SELECT * FROM '+tableName+' WHERE id = '+seeds.Strings[0];
      if ArrayContainTextList('id2',getField,true) then
      begin
        start:= 2;
        query.SQL.Text:= 'SELECT * FROM '+tableName+' WHERE id = '+seeds.Strings[0]+' AND id2 = '+seeds.Strings[1];
      end;

      query.Open;
      if not(query.IsEmpty) then
      for i:= start to (fields.Count-1) do
      begin
        Server_cmd.CommandText:= 'UPDATE '+tableName+' SET '+getField.Strings[i]+' = '+seeds.Strings[i]+' WHERE id = '+seeds.Strings[0];
        if ArrayContainTextList('id2',getField,true) then
          Server_cmd.CommandText:= 'UPDATE '+tableName+' SET '+getField.Strings[i]+' = '+seeds.Strings[i]+' WHERE id = '+seeds.Strings[0]+' AND id2 = '+seeds.Strings[1];

        Server_cmd.Execute;
      end else
      begin
        Server_cmd.CommandText:= 'INSERT INTO '+tableName+' ('+implode(', ',getField)+') VALUES ('+implode(', ',seeds)+');';
        Server_cmd.Execute;
      end;
    finally
      query.Close;
    end;
  end;
end;

end.
