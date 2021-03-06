USE [DBFirstDemo]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/24/2019 5:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[First_Name] [nvarchar](50) NULL,
	[Last_Name] [nvarchar](50) NULL,
	[Email_Address] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[Password] [nvarchar](300) NULL,
	[Created_Date] [datetime] NULL,
	[RoleId] [int] NULL,
	[Address] [nvarchar](500) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](10) NULL,
	[Zip] [nvarchar](10) NULL,
	[Company] [int] NULL,
	[Image_Path] [varchar](200) NULL,
	[Is_Locked] [bit] NULL,
	[Is_Active] [bit] NULL,
	[Edit_Date] [datetime] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [First_Name], [Last_Name], [Email_Address], [Description], [Password], [Created_Date], [RoleId], [Address], [City], [State], [Zip], [Company], [Image_Path], [Is_Locked], [Is_Active], [Edit_Date]) VALUES (1, N'Faisal', N'Pathan', N'test@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([UserId], [First_Name], [Last_Name], [Email_Address], [Description], [Password], [Created_Date], [RoleId], [Address], [City], [State], [Zip], [Company], [Image_Path], [Is_Locked], [Is_Active], [Edit_Date]) VALUES (2, N'Faisal', N'Pathan', N'test@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Users] ([UserId], [First_Name], [Last_Name], [Email_Address], [Description], [Password], [Created_Date], [RoleId], [Address], [City], [State], [Zip], [Company], [Image_Path], [Is_Locked], [Is_Active], [Edit_Date]) VALUES (3, N'test', N'test1', N'test2@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Users] ([UserId], [First_Name], [Last_Name], [Email_Address], [Description], [Password], [Created_Date], [RoleId], [Address], [City], [State], [Zip], [Company], [Image_Path], [Is_Locked], [Is_Active], [Edit_Date]) VALUES (4, N'test3', N'test4', N'test5@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[Users] ([UserId], [First_Name], [Last_Name], [Email_Address], [Description], [Password], [Created_Date], [RoleId], [Address], [City], [State], [Zip], [Company], [Image_Path], [Is_Locked], [Is_Active], [Edit_Date]) VALUES (5, N'test6', N'test7', N'test8@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
/****** Object:  StoredProcedure [dbo].[GetUserDetails]    Script Date: 5/24/2019 5:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserDetails] 
@Pageno INT=1,
@filter VARCHAR(500)='',
@pagesize INT=20,	
@Sorting VARCHAR(500)='UserId',
@SortOrder VARCHAR(500)='desc' 
AS
BEGIN
SET NOCOUNT ON;
DECLARE @SqlCount INT
DECLARE @From INT = @pageno
DECLARE @SQLQuery VARCHAR(5000)
IF(@filter !='')
BEGIN
SET @SqlCount= ( SELECT COUNT(*) FROM Users as USR WHERE USR.Is_Active=1 AND (USR.First_Name LIKE '%'+@filter+'%' OR USR.Last_Name LIKE '%'+ @filter+'%' OR USR.Email_Address LIKE '%'+@filter+'%' OR USR.Created_Date LIKE '%' + @filter+'%'))
SET @SQLQuery ='select usr.UserId as UserId,usr.First_Name,usr.Last_Name,usr.Email_Address,usr.Created_Date ,'+CONVERT(VARCHAR,@SqlCount)+' as TotalRecords
from Users as usr 
where usr.Is_Active=1 
and(usr.First_Name like ''%'+CONVERT(VARCHAR,@filter)+'%'' 
or usr.Last_Name like ''%'+CONVERT(VARCHAR,@filter)+'%'' 
or usr.Email_Address like ''%'+CONVERT(VARCHAR,@filter)+'%'') 
order by usr.'+ CONVERT(VARCHAR,@Sorting) +' '+ @SortOrder +'
OFFSET '+CONVERT(varchar,@From)+' ROWS
FETCH NEXT '+CONVERT(varchar,@pagesize)+' ROWS ONLY OPTION (RECOMPILE)'
END
ELSE
BEGIN
SET @SqlCount=( SELECT COUNT(*) FROM Users as USR WHERE USR.Is_Active=1)

SET @SQLQuery ='select usr.UserId as UserId,usr.First_Name,usr.Last_Name,usr.Email_Address,usr.Created_Date,'+CONVERT(VARCHAR,@SqlCount)+' as TotalRecords
from Users as usr
where usr.Is_Active=1	
order by usr.'+ CONVERT(VARCHAR,@Sorting) +' '+ @SortOrder +'
OFFSET '+CONVERT(varchar,@From)+' ROWS
FETCH NEXT '+CONVERT(varchar,@pagesize)+' ROWS ONLY OPTION (RECOMPILE)'
end

print @SQLQuery
exec (@SQLQuery)

END
GO
