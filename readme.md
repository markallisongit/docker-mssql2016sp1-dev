# SQL Server 2016 SP1 Developer Edition docker image
This was created because the Microsoft one was only available as Express Edition at the time.

> It is recommended you use the Microsoft version instead available from [docker hub](https://hub.docker.com/r/microsoft/mssql-server-windows-developer/)

[More info here](https://blogs.msdn.microsoft.com/sqlserverstorageengine/2017/02/21/sql-server-2016-developer-edition-in-windows-containers/)

## To Build
Unzip the SQL Server 2016 with SP1 Dev Edition ISO to the root of this directory
run ```docker build -t mssql-2016-dev .```
run ```docker run -d -p 1433:1433 -e sa_password=<very_secure_password> -e ACCEPT_EULA=Y mssql-2016-sp1-dev```

## Ports
If you want to run more than one container, then change the first port number after -p
