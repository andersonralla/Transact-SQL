
-- Cursor para exec de procedure entre datas

USE [seuBanco]

 DECLARE @DataInicio DATE 
 DECLARE @DataFim DATE
 DECLARE @CurrentDate DATE

 SET @DataInicio =  '2024-01-01'
 SET @DataFim =  '2024-03-08'
 SET @CurrentDate = @DataInicio

 WHILE (@CurrentDate <= @DataFim)
BEGIN

			select @CurrentDate

   exec [suaProc] @CurrentDate

 SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate); 
 END