DECLARE @fileLoc nvarchar(max);
declare @hdoc int;
declare @fileCont varchar(max);

set @fileLoc = N'C:/Users/v-magrah/Documents/20210507_GLExport/'
exec sp_xml_preparedocument @hdoc output, @docHandle

SELECT Company
FROM OPENXML(@hdoc, N'GLExportRow/Company')
with (
	Company nvarchar(255)
)



DECLARE @FileName varchar(255)
DECLARE @ExecCmd VARCHAR(255)
DECLARE @y INT
DECLARE @x INT
DECLARE @FileContents VARCHAR(8000)

CREATE TABLE #tempXML(PK INT NOT NULL IDENTITY(1,1), ThisLine VARCHAR(255))

SET @FileName = 'C:/Users/v-magrah/Documents/20210507_GLExport.xml'
SET @ExecCmd = 'type ' + @FileName
SET @FileContents = ''

INSERT INTO #tempXML EXEC master.dbo.xp_cmdshell @ExecCmd
SELECT @y = count(*) from #tempXML

SET @x = 0
WHILE @x <> @y
    BEGIN
        SET @x = @x + 1
        SELECT @FileContents = @FileContents + ThisLine from #tempXML WHERE PK
 = @x
    END

SELECT @FileContents as FileContents
DROP TABLE #tempXML 

exec sp_xml_preparedocument @hdoc output, @docHandle