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
        Procedure StartWork();
        Destructor Destroy;
    End;

Implementation

{ TCore }

Constructor TCore.Create(ArrayOfUsers: TArrayOfUsers; TickTime, WaitTime: Integer);
Begin
    Queue := TPriorityQueue<TUser>.Create();
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

Procedure TCore.StartWork;
Begin
    //main alghoritm
End;

End.
