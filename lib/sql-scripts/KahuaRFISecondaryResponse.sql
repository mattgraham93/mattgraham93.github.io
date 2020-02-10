select *
from test_msft_rfi_secondaryresponses as sr
	inner join test_msft_rfi_detail as rd
		on sr.Record_Key = rd.Record_Key
	inner join Dim_ProjNoAssoc as proj
		on rd.Project = proj.Kahua_BldgProjNo