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
    End;

Implementation

{ TCore }

Constructor TCore.Create(ArrayOfUsers: TArrayOfUsers; TickTime, WaitTime: Integer);
Begin
    Users := ArrayOfUsers;
    TickTime := TickTime;
    WaitTime := WaitTime;
End;

End.
