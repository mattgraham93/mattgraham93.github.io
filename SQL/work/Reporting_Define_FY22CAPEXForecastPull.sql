select CapexProjectId, CapExBudget, FiscalYearName, FiscalQtrNumber, FiscalMonthNumber, CapexBudgetVersion, 'Budget' ItemType
from Fact_Build_CapexPerspective
where CapexBudgetVersion like 'FY22 Budget'
union all
select CapexProjectId, CapExForecast, FiscalYearName, FiscalQtrNumber, FiscalMonthNumber, CapexForecastVersion, 'Forecast' ItemType
from Fact_Build_CapexPerspective
where CapexForecastVersion like 'Live Version'