Unit CoreUnit;

Interface

Uses
    UserUnit,
    PriorityQueueUnit;

Type
    TArrayOfUsers = Array Of TUser;

    TCore = Class
    Var
        Users: TArrayOfUsers;
        Queue: TPriorityQueue<TUser>;
        TickTime: Integer;
        WaitTime: Integer;
    Private

    Public
        Constructor Create(ArrayOfUsers: TArrayOfUsers; TickTime: Integer; WaitTime: Integer);
        Destructor Destroy;
    End;

Implementation

{ TCore }

Constructor TCore.Create(ArrayOfUsers: TArrayOfUsers; TickTime, WaitTime: Integer);
Begin
    Users := ArrayOfUsers;
    TickTime := TickTime;
    WaitTime := WaitTime;
End;

destructor TCore.Destroy;
begin
    Queue.Destroy();
    Users := Nil;
    inherited;
end;

End.
