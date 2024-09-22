# Лабораторная работа 1 по Алгоритмам и Структурам Данных.

`TUser` - класс реализующий процесс:
- `Number` - порядковый номер процесса;
- `IsProccessActive` - хранит статус активности процесса (есть ли ещё активные запросы у процесса);
- `TPriorityLvl : Byte` описывающий уровень приоритета у процесса (__1__ - самый важный, __255__ - самый неважный);
- `TRequests - Array Of Request`, где `Request : Integer` кол-во запросов у процесса;
- `RequestPointer : Integer` - хранит порядковый номер следующего запроса у процессора;
- `IsProcessWork : Boolean` - хранит статус работы с процессором ( если `True` - процессор сейчас работает с процессом);
  - `ProcessWorkLength : Integer` - хранит количество условных единиц до завершения процесса; 
- `IsProcessWriting : Boolean` - хранит статус обдумывания процессора (если `True` - то процесс пишет, иначе процесс свободен); 
  - _*После завершения работ с последним процессом время на обдумывание не учитывается.*_
- `ProcessWritingLength: Integer` - хранит количество условных единиц до завершения обдумывания.
`TArrayOfUsers` - хранит список `TUser` который будет использоваться в реализации у `TQueueOfUsers`;
`TQueueOfUsers` - очередь процессов
  - `TUser` - составляющая очереди
  - _*Место добавления элемента в очередь определяется относительно приоритета процесса. Процессы с большим приоритетом добавляются в начало очереди и так далее...*_

`TCore` - ядро реализующая часть процессора принимающая запросы.
- `Users: TArrayOfUsers` - хранит все процессы
- `QueueOfUsers: TQueueOfUsers` очередь процессов
- `TickTime: Integer` - время такта ядра процессора
- `WaitTime: Integer` - время на обдумывание у ядра процессора