-------------2018-08-08-字段更新-----------
ALTER TABLE [dbo].[rpt_ticket_CardStore]
ADD [update_date] datetime NULL 
GO

ALTER TABLE [dbo].[rpt_ticket_GetCard]
ADD [update_date] datetime NULL 
GO

ALTER TABLE [dbo].[rpt_ticket_LostCards]
ADD [update_date] datetime NULL 
GO

ALTER TABLE [dbo].[rpt_ticket_T50Tickets]
ADD [update_date] datetime NULL 
GO

ALTER TABLE [dbo].[rpt_ticket_GetCard]
ADD [shift] int NULL 
GO

