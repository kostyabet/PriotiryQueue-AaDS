Unit CoreUnit;

Interface

Uses
    SysUtils,
    UserUnit,
    PriorityQueueUnit;

Type
    TArrayOfUsers = Array Of TUser;

    TCore = Class
    Type
        TCoreWorkResult = Record
            Downtime: Integer;
            TicksCount: Integer;
        End;
    Private
        Users: TArrayOfUsers;
        Queue: TPriorityQueue<TUser>;
        TickTime: Integer;
        WaitTime: Integer;
        CoreWorkResult: TCoreWorkResult;

        Function IsProcessorWork: Boolean;
        Function QueueHasHighestPriority(Priority: Integer): Boolean;
        Procedure AddElementsInQueue;
    Public
        Constructor Create(ArrayOfUsers: TArrayOfUsers; Tick, Wait: Integer);
        Procedure StartWork;
        Procedure OutputInfo;
        Destructor Destroy;
        Function HasAvaliable: Boolean;

        Procedure WriteLog;
    End;

Implementation

{ TCore }

Procedure TCore.AddElementsInQueue;
Begin
    For Var I := 0 To Length(Users) - 1 Do
    Begin
        If (Users[I].IsProcessActive And Not Users[I].IsProcessWork And Not Users[I].IsProcessWait And Not Queue.Contain(Users[I])) Then
        Begin
            Queue.Enqueue(Users[I], Users[I].Name, Users[I].PriorityLvl);
        End;
    End;
End;

Constructor TCore.Create(ArrayOfUsers: TArrayOfUsers; Tick, Wait: Integer);
Begin
    Queue := TPriorityQueue<TUser>.Create();
    Users := ArrayOfUsers;
    For Var I := 0 To Length(Users) - 1 Do
    Begin
        Queue.Enqueue(Users[I], Users[I].Name, Users[I].PriorityLvl);
    End;
    TickTime := Tick;
    WaitTime := Wait;
End;

Destructor TCore.Destroy;
Begin
    Queue.Destroy();
    Users := Nil;
    Inherited;
End;

Function TCore.HasAvaliable: Boolean;
Begin
    Result := False;
    For Var I := 0 To Length(Users) - 1 Do
    Begin
        If (Users[I].IsProcessActive) Then
        Begin
            Result := True;
        End;
    End;
End;

Function TCore.IsProcessorWork: Boolean;
Begin
    For Var I := 0 To Length(Users) - 1 Do
    Begin
        If (Users[I].IsProcessWork) Then
        Begin
            Result := True;
            Exit;
        End;
    End;
    Result := False;
End;

Procedure TCore.OutputInfo;
Var
    CPD: Double;
Begin
    CPD := ((CoreWorkResult.TicksCount - CoreWorkResult.Downtime) / CoreWorkResult.TicksCount) * 100;
    Write(CoreWorkResult.Downtime:3);
    Write('/');
    Write(CPD:5:1);
    Write(' | ');
End;

Function TCore.QueueHasHighestPriority(Priority: Integer): Boolean;
Begin
    Result := False;
    If (Not Queue.IsEmpty) Then
    Begin
        Result := Queue.Peek.PriorityLvl > Priority;
    End;
End;

Procedure TCore.StartWork;
Var
    Temp: TUser;
Begin
    Repeat
        //check waits
        For Var I := 0 To Length(Users) - 1 Do
        Begin
            Users[I].CheckWaitStatus(TickTime);
        End;
        //check works
        For Var I := 0 To Length(Users) - 1 Do
        Begin
            CoreWorkResult.Downtime := CoreWorkResult.Downtime + Users[I].CheckWorkStatus(TickTime, WaitTime,
                QueueHasHighestPriority(Users[I].PriorityLvl));
        End;
        AddElementsInQueue;
        //downtime
        If Queue.IsEmpty And HasAvaliable Then
        Begin
            Inc(CoreWorkResult.Downtime, TickTime);
        End;
        //check new process
        If (Not IsProcessorWork And Not Queue.IsEmpty) Then
        Begin
            Temp := Queue.Dequeue;
            Temp.StartWork;
        End;
        //ticks
        Inc(CoreWorkResult.TicksCount, TickTime);
    Until Not HasAvaliable;
End;

Procedure TCore.WriteLog;
Begin
    Write('Tick ' + IntToStr(CoreWorkResult.TicksCount Div TickTime) + #13#10);
    For Var I := 0 To Length(Users) - 1 Do
    Begin
        Write('| ');
        For Var J := 0 To Length(Users[I].Requests) - 1 Do
        Begin
            Write(IntToStr(Users[I].Requests[J]) + ' | ');
        End;
        Write(#13#10);
    End;
    Write(#13#10#13#10);
End;

End.
