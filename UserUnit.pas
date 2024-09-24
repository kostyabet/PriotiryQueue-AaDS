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
    End;

Implementation

{ TUser }

Constructor TUser.Create(UserName: String; Priority: Integer; Reqs: TRequests);
Begin
    Name := UserName;
    IsProcessActive := False;
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

End.
