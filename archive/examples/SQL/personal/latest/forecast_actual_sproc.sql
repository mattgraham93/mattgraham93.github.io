alter procedure sp_Update_ForecastActuals
AS
begin
-- Delete rows from raw actuals with matching project IDs and periods between view and raw actuals
    begin transaction;
    begin try
        delete ra
        from Fact_Build_Manual_FcstTool_RawActuals ra
            inner join vw_CPS_ForecastActuals_Recon rec
                on ra.project_id = rec.Project_ID and ra.Period_date = rec.period
    end try
    begin catch
        select 
            ERROR_NUMBER() ErrorNumber  
            ,ERROR_SEVERITY() ErrorSeverity  
            ,ERROR_STATE() ErrorState  
            ,ERROR_PROCEDURE() ErrorProcedure  
            ,ERROR_LINE() ErrorLine  
            ,ERROR_MESSAGE() ErrorMessage; 

            if @@TRANCOUNT > 0
                ROLLBACK TRANSACTION;
        end CATCH
    if @@TRANCOUNT > 0
        COMMIT TRANSACTION;
end
-- Insert into raw actuals all reported actuals 
begin
    begin transaction;
    begin try
        insert into Fact_Build_Manual_FcstTool_RawActuals (
            project_id, Period_date, actuals
        ) select Project_ID, period, BTActuals
        from vw_CPS_ForecastActuals_Recon
    end try
    begin catch
        select 
            ERROR_NUMBER() ErrorNumber  
            ,ERROR_SEVERITY() ErrorSeverity  
            ,ERROR_STATE() ErrorState  
            ,ERROR_PROCEDURE() ErrorProcedure  
            ,ERROR_LINE() ErrorLine  
            ,ERROR_MESSAGE() ErrorMessage; 

            if @@TRANCOUNT > 0
                ROLLBACK TRANSACTION;
        end CATCH
    if @@TRANCOUNT > 0
        COMMIT TRANSACTION;
end

begin
    begin transaction;
    begin try
        execute [dbo].[s_pr_ProjectName_update_actuals]
        execute [dbo].[s_pr_Build_ForecastPmProj]
    end try
    begin catch
        select 
            ERROR_NUMBER() ErrorNumber  
            ,ERROR_SEVERITY() ErrorSeverity  
            ,ERROR_STATE() ErrorState  
            ,ERROR_PROCEDURE() ErrorProcedure  
            ,ERROR_LINE() ErrorLine  
            ,ERROR_MESSAGE() ErrorMessage; 

            if @@TRANCOUNT > 0
                ROLLBACK TRANSACTION;
        end CATCH
    if @@TRANCOUNT > 0
        COMMIT TRANSACTION;
end
go