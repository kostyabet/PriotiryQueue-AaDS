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
    For Var I := 0 To Length(Users) - 1 Do
    Begin
        Queue.Enqueue(Users[I], Users[I].PriorityLvl);
    End;
    TickTime := TickTime;
    WaitTime := WaitTime;
End;

Destructor TCore.Destroy;
Begin
    Queue.Destroy();
    Users := Nil;
    Inherited;
End;

End.
