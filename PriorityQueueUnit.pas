Unit PriorityQueueUnit;

Interface

Uses
    SysUtils,
    Generics.Collections,
    UserUnit;

Type
    TPriorityQueueItem<TUser> = Record
        Item: TUser;
        Name: String;
        Priority: Integer;
    End;

    TPriorityQueue<TUser> = Class
    Private
        FList: TList<TPriorityQueueItem<TUser>>;
        Procedure SortQueue;
    Public
        Constructor Create;
        Destructor Destroy; Override;

        Procedure Enqueue(AItem: TUser; Name: String; APriority: Integer);
        Function Dequeue: TUser;
        Function Peek: TUser;
        Function IsEmpty: Boolean;
        Function Contain(AItem: TUser): Boolean;
    End;

Implementation

Function TPriorityQueue<TUser>.Contain(AItem: TUser): Boolean;
Begin
    Result := False;
    For Var I := 0 To FList.Count - 1 Do
    Begin
        If (FList[I].Item = AItem) Then
        Begin
            Result := True;
            Exit;
        End;
    End;
End;

Constructor TPriorityQueue<TUser>.Create;
Begin
    FList := TList < TPriorityQueueItem < TUser >>.Create;
End;

Destructor TPriorityQueue<TUser>.Destroy;
Begin
    FList.Free;
    Inherited;
End;

Procedure TPriorityQueue<TUser>.Enqueue(AItem: TUser; Name: String; APriority: Integer);
Var
    NewItem: TPriorityQueueItem<TUser>;
Begin
    NewItem.Item := AItem;
    NewItem.Name := Name;
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

        While (J >= 0) And (FList[J].Priority > Temp.Priority) Do
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

    Result := FList.First.Item;
    FList.Delete(0);
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
