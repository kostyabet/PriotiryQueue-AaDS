Unit UserUnit;

Interface

Type
    TRequest = Integer;
    TRequests = Array Of TRequest;

    TUser = Class
        Number: Integer;
        IsProcessActive: Boolean;
        TPriorityLvl: Byte;
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

    End;

Implementation

End.
