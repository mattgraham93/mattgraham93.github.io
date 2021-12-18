use DATProd01

SELECT distinct Month as 'Month',
Monthtext as 'Month(Text)',
concat(monthtextabbrev,', ',Clientfiscalyear) as 'Fiscal Month MSRA',
Year as 'Calendar Year',
concat(Year,' - ',monthtextabbrev) as 'Calendar FYM',
(SELECT CASE WHEN Month  < 10 THEN  RIGHT('00'+ CAST(Month AS VARCHAR),2) ELSE cast(month as varchar)END) as 'Calender Period',
Concat('FY',Substring(cast(clientfiscalyear as varchar),3,4),' - ',monthtextabbrev)  as 'Reporting FYM',
Clientfiscalyear as 'Fiscal Year',
concat('FY',Substring(cast(clientfiscalyear as varchar),3,4)) AS 'Fiscal year FY',
clientfiscalquarter as 'Fiscal Quarter',
concat('Q',clientfiscalquarter) as 'FIscal Quarter Q',
 (SELECT CASE WHEN clientFiscalPeriod  < 10 THEN  RIGHT('00'+ CAST(clientFiscalPeriod AS VARCHAR),2) ELSE cast(clientFiscalPeriod as varchar)END)as 'Fiscal Period',
concat('P',(SELECT CASE WHEN clientFiscalPeriod  < 10 THEN  RIGHT('00'+ CAST(clientFiscalPeriod AS VARCHAR),2) ELSE cast(clientFiscalPeriod as varchar) END)) as 'Fiscal Period P',
clientPeriod as 'Fiscal Period Date',
(SELECT CASE SUBSTRING(CAST(clientPeriod AS nvarchar),5,2) WHEN 12 THEN clientPeriod+89 ELSE clientPeriod+1 END) as 'Reversal Fiscal Period',
concat(clientfiscalyear,'M', (SELECT CASE WHEN clientFiscalPeriod  < 10 THEN  RIGHT('00'+ CAST(clientFiscalPeriod AS VARCHAR),2) ELSE cast(clientFiscalPeriod as varchar) END) ) AS 'Prophix Fiscal Period',
concat('FY',SUBSTRING(CAST(clientfiscalyear AS VARCHAR),3,4),' P', (SELECT CASE WHEN clientFiscalPeriod  < 10 THEN  RIGHT('00'+ CAST(clientFiscalPeriod AS VARCHAR),2) ELSE cast(clientFiscalPeriod as varchar)END )) as 'Finance FYFP',
concat('FY',clientfiscalyear,'/','P',(SELECT CASE WHEN clientFiscalPeriod  < 10 THEN  RIGHT('00'+ CAST(clientFiscalPeriod AS VARCHAR),2) ELSE cast(clientFiscalPeriod as varchar) END)) as 'Fiscal Period Year',
CONCAT('FY',SUBSTRING(CAST(clientfiscalyear AS VARCHAR),3,4),' Q', clientfiscalquarter) as 'Fiscal Year Quarter',[SQLdate]
from [dbo].[Dim_Build_Date]
order by SQLdate desc