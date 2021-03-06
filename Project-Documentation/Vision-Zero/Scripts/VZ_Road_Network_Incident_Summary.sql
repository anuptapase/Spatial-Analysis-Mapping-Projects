/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
      RDS.[NAME]
      ,[SHIELDNUM]
      ,ROUND(([KPH] * .621371),0) MPH 
      ,[L_PC]
      ,[R_PC]
      ,RDS.[COUNTYNAME]
      ,RDS.[CountyFIP]
	  ,SUM([Killed]) Sum_Killed
	  ,SUM([Sevinj]) Sum_Sevinjured 
	  ,Count(*) Sum_Incidents
	  ,geometry::UnionAggregate(RDS.Shape) as Shape
  INTO VZ_HIN_BAY_AREA_2006_2017 
  FROM [Analysis].[dbo].[VZ_MN_NW_BAYAREA] AS RDS
  LEFT JOIN [dbo].[VZ_MN_GC_BAYAREA] AS GC
  ON GC.[ID] = RDS.ID
  LEFT JOIN [dbo].[VZ_BAYAREAACCIDENTS2006_2016_PROJECT] AS PTS
  ON RDS.OBJECTID = PTS.NEAR_FID
  GROUP BY 
  RDS.NAME,
  SHIELDNUM,
  KPH,
  L_PC,
  R_PC,
  RDS.COUNTYNAME, 
  RDS.CountyFIP
