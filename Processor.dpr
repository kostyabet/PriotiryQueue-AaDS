Program Processor;

{$APPTYPE CONSOLE}
{$R *.res}

Uses
    System.SysUtils,
    CoreUnit In 'CoreUnit.pas',
    UserUnit In 'UserUnit.pas',
    PriorityQueueUnit In 'PriorityQueueUnit.pas';

Const
    COUNT_OF_USERS: Integer = 6;

Var
    ArrayOfUsers: TArrayOfUsers;
    Core: TCore;

Begin
    Writeln(' __________________________________________________________________________________________________________________________________________ ');
    Write('|      |');
    For Var I := 0 To 10 Do
    Begin
        Write(I:6);
        Write('     |');
    End;
    Writeln(#13#10'|------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|');

    For Var Tick := 1 To 10 Do
    Begin
        Write('|');
        Write(Tick:4);
        Write('  | ');
        For Var Wait := 0 To 10 Do
        Begin
            SetLength(ArrayOfUsers, COUNT_OF_USERS);
            ArrayOfUsers[0] := TUser.Create('1', 1, [9, 6, 3, 2, 8, 7, 4]);
            ArrayOfUsers[1] := TUser.Create('2', 2, [3, 7, 2, 4, 7, 3, 1]);
            ArrayOfUsers[2] := TUser.Create('3', 2, [4, 5, 6, 4, 2, 3, 4, 5]);
            ArrayOfUsers[3] := TUser.Create('4', 2, [3, 5, 4, 2, 1, 6, 8, 3]);
            ArrayOfUsers[4] := TUser.Create('5', 3, [2, 3, 2, 1, 4, 2, 3, 4]);
            ArrayOfUsers[5] := TUser.Create('6', 3, [3, 2, 1, 2, 3, 4, 3, 4]);

            Core := TCore.Create(ArrayOfUsers, Tick, Wait);
            Core.StartWork;
            Core.OutputInfo;
            Core.Destroy;
        End;
        Writeln;
    End;
    Writeln('|______|___________|___________|___________|___________|___________|___________|___________|___________|___________|___________|___________|');
    Readln;

End.
