Unit UserUnit;

Interface

Type
    TRequest = Integer;
    TRequests = Array Of TRequest;

    TUser = Class
    Private
        Name: Integer;
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
    Public
        Constructor Create(Name: Integer; PriorityLvl: Integer; Requests: TRequests);
        Destructor Free();
    End;

Implementation

{ TUser }

Constructor TUser.Create(Name: Integer; PriorityLvl: Integer; Requests: TRequests);
Begin
    Name := Name;
    IsProcessActive := False;
    PriorityLvl := PriorityLvl;
    Requests := Requests;
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
