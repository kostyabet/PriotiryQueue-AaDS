Unit UserUnit;

Interface

Uses
    System.SysUtils;

Type
    TRequest = Integer;
    TRequests = Array Of TRequest;

    TUser = Class
        Name: String;
        IsProcessActive: Boolean;
        PriorityLvl: Byte;
        //Requests
        Requests: TRequests;
        RequestPointer: Integer;
        //Work
        IsProcessWork: Boolean;
        ProcessorWorkLength: Integer;
        //Wait
        IsProcessWait: Boolean;
        ProcessorWaitLength: Integer;
    Private

    Public
        Constructor Create(UserName: String; Priority: Integer; Reqs: TRequests);
        Destructor Free();
        Procedure CheckWaitStatus(TickTime: Integer);
        Function CheckWorkStatus(TickTime, WaitTime: Integer; NextHighPrior: Boolean): Integer;
        Procedure StartWork;
    End;

Implementation

{ TUser }

Procedure TUser.CheckWaitStatus(TickTime: Integer);
Begin
    If Not(IsProcessWait) Then
    Begin
        Exit;
    End;

    Dec(ProcessorWaitLength, TickTime);

    If (ProcessorWaitLength < 1) Then
    Begin
        ProcessorWaitLength := -1;
        IsProcessWait := False;
    End;
End;

Function TUser.CheckWorkStatus(TickTime, WaitTime: Integer; NextHighPrior: Boolean): Integer;
Begin
    Result := 0;
    If Not(IsProcessWork) Then
    Begin
        Exit;
    End;

    Dec(ProcessorWorkLength, TickTime);
    If (ProcessorWorkLength < 1) Then
    Begin
        Result := Abs(ProcessorWorkLength);
        Inc(RequestPointer);
        If (RequestPointer = Length(Requests)) Then
            IsProcessActive := False;
        ProcessorWaitLength := WaitTime - Abs(ProcessorWorkLength);
        IsProcessWait := True;
        If (ProcessorWaitLength < 1) Then
        Begin
            ProcessorWaitLength := -1;
            IsProcessWait := False;
        End;
        ProcessorWorkLength := -1;
        IsProcessWork := False;
    End
    Else
        Begin
            Requests[RequestPointer] := ProcessorWorkLength;
            ProcessorWorkLength := -1;
            IsProcessWork := False;
        End;
End;

Constructor TUser.Create(UserName: String; Priority: Integer; Reqs: TRequests);
Begin
    Name := UserName;
    IsProcessActive := True;
    PriorityLvl := Priority;
    SetLength(Requests, Length(Reqs));
    For Var I := 0 To Length(Requests) - 1 Do
    Begin
        Requests[I] := Reqs[I];
    End;
    RequestPointer := 0;
    IsProcessWork := False;
    ProcessorWorkLength := -1;
    IsProcessWait := False;
    ProcessorWaitLength := -1;
End;

Destructor TUser.Free;
Begin
    Requests := Nil;
End;

Procedure TUser.StartWork;
Begin
    ProcessorWorkLength := Requests[RequestPointer];
    IsProcessWork := True;
End;

End.
