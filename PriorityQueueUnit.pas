Unit PriorityQueueUnit;

Interface

Uses
    SysUtils,
    Generics.Collections,
    UserUnit;

Type
    TPriorityQueueItem<TUser> = Record
        Item: TUser;
        Priority: Integer;
    End;

    TPriorityQueue<TUser> = Class
    Private
        FList: TList<TPriorityQueueItem<TUser>>;
        Procedure SortQueue;
    Public
        Constructor Create;
        Destructor Destroy; Override;

        Procedure Enqueue(Const AItem: TUser; APriority: Integer);
        Function Dequeue: TUser;
        Function Peek: TUser;
        Function IsEmpty: Boolean;
    End;

Implementation

Constructor TPriorityQueue<TUser>.Create;
Begin
    FList := TList < TPriorityQueueItem < TUser >>.Create;
End;

Destructor TPriorityQueue<TUser>.Destroy;
Begin
    FList.Free;
    Inherited;
End;

Procedure TPriorityQueue<TUser>.Enqueue(Const AItem: TUser; APriority: Integer);
Var
    NewItem: TPriorityQueueItem<TUser>;
Begin
    NewItem.Item := AItem;
    NewItem.Priority := APriority;
    FList.Add(NewItem);
    SortQueue;
End;

Procedure TPriorityQueue<TUser>.SortQueue;
Var
    I, J: Integer;
    Temp: TPriorityQueueItem<TUser>;
Begin
    For I := 1 To FList.Count - 1 Do
    Begin
        Temp := FList[I];
        J := I - 1;

        While (J >= 0) And (FList[J].Priority < Temp.Priority) Do
        Begin
            FList[J + 1] := FList[J];
            Dec(J);
        End;

        FList[J + 1] := Temp;
    End;
End;

Function TPriorityQueue<TUser>.Dequeue: TUser;
Begin
    If IsEmpty Then
    Begin
        Raise Exception.Create('Priority Queue is empty');
    End;

    Result := FList.Last.Item;
    FList.Delete(FList.Count - 1);
End;

Function TPriorityQueue<TUser>.Peek: TUser;
Begin
    If IsEmpty Then
    Begin
        Raise Exception.Create('Priority Queue is empty');
    End;

    Result := FList.Last.Item;
End;

Function TPriorityQueue<TUser>.IsEmpty: Boolean;
Begin
    Result := FList.Count = 0;
End;

End.
