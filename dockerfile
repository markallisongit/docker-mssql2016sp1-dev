# mssql server 2016 SP1 express image
FROM microsoft/windowsservercore

# adapted from the official microsoft image at microsoft/mmsql-server-express
# to build the image unzip the SQL 2016 with SP1 ISO to the same directory
# and then run docker build -t <image_name> .

# set environment variables
ENV sa_password _
ENV attach_dbs "[]"
ENV ACCEPT_EULA _

# make install files accessible
COPY . /setup
COPY *.ps1 /
WORKDIR /

# sql server setup
RUN /setup/setup.exe /q /ACTION=Install /INSTANCENAME=SQL2016DEV /FEATURES=SQLEngine /UPDATEENABLED=0 /SQLSVCACCOUNT="NT AUTHORITY\System" /SQLSYSADMINACCOUNTS="BUILTIN\ADMINISTRATORS" /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS && rd /q /s setup

RUN powershell -Command \
        set-strictmode -version latest ; \
        stop-service MSSQL`$SQL2016DEV ; \
        set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql13.SQL2016DEV\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpdynamicports -value '' ; \
        set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql13.SQL2016DEV\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpport -value 1433 ; \
        set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql13.SQL2016DEV\mssqlserver\' -name LoginMode -value 2 ;

CMD powershell ./start -sa_password \"%sa_password%\" -ACCEPT_EULA %ACCEPT_EULA% -attach_dbs \"%attach_dbs%\" -Verbose