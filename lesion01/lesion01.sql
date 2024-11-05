CREATE DATABASE Dev_01
ON 
(
    NAME = Dev_01_Data,
    FILENAME = 'D:\SQL_dev\lesion01\Dev2410_LM_SQL_01.mdf',
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
LOG ON 
(	
    NAME = Dev_01_Log,
    FILENAME = 'D:\SQL_dev\lesion01\Dev2410_LM_SQL_01_Log.ldf',
    SIZE = 5MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 5MB
);
