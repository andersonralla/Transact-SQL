
-- Anderson R Oliveira / 24.09.2023

-- loop While para realizar o tuning de queries para extracoes massivas de grande periodo de datas. 

DECLARE @DataInicio DATE = '2023-01-01';
DECLARE @DataFinal DATE = CONVERT(DATE, GETDATE() - 1);

CREATE TABLE #Datas (Data DATE);

WHILE @DataInicio <= @DataFinal

BEGIN
    
	INSERT INTO #Datas (Data) VALUES (@DataInicio);
    SET @DataInicio = DATEADD(DAY, 1, @DataInicio);

PRINT('Data Atual ' + CONVERT(NVARCHAR(10), @DataInicio, 120))


IF OBJECT_ID('Tempdb..#Temp1') IS NOT NULL DROP TABLE #Temp1;

SELECT
    a.[Data],
    b.[Data],
    CONVERT(VARCHAR(2), a.[Hora], 108) AS 'Hora',
    a.[Coluna1],
    SUM(a.[Coluna2]) AS 'SomaColuna2',
    SUM(a.[Coluna3]) AS 'SomaColuna3',
    SUM(a.[Coluna4]) AS 'SomaColuna4',
    SUM(a.[Coluna5]) AS 'SomaColuna5'
INTO #Temp1
FROM [BANCO_DADOS].[dbo].[TABELA] a WITH (NOLOCK)
INNER JOIN #Datas AS b
ON a.[Data] = b.Data
GROUP BY
    a.[Data], CONVERT(VARCHAR(2), a.[Hora], 108), a.[Coluna1];

END;

SELECT * FROM #Temp1 a
INNER JOIN #Datas b
ON a.[Data] = b.Data
ORDER BY a.[Data] ASC;

drop table #Datas;