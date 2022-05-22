use master
exec Happybits.Recreate 'Demo'
use Demo
GO

CREATE TABLE [dbo].[Book](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](100) NULL,
	[ISBN] [varchar](50) NULL,
	[Published] [date] NULL,
	[NrOfPages] [smallint] NULL,
	[Weight] [smallint] NULL,
	[AuthorId] [int] NOT NULL,
	[PublisherId] [int] NOT NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Company]    Script Date: 5/28/2020 3:09:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person]    Script Date: 5/28/2020 3:09:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Review]    Script Date: 5/28/2020 3:09:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[BookId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Text] [varchar](4000) NOT NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[BookId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 5/28/2020 3:09:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LoginName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Book] ON 
GO
INSERT [dbo].[Book] ([Id], [Title], [ISBN], [Published], [NrOfPages], [Weight], [AuthorId], [PublisherId]) VALUES (2, N'New York triologin', N'9789113076997', CAST(N'2017-01-19' AS Date), 400, 213, 1, 1)
GO
INSERT [dbo].[Book] ([Id], [Title], [ISBN], [Published], [NrOfPages], [Weight], [AuthorId], [PublisherId]) VALUES (4, N'1984', N'9789173539678', CAST(N'2017-12-01' AS Date), 283, 200, 2, 3)
GO
INSERT [dbo].[Book] ([Id], [Title], [ISBN], [Published], [NrOfPages], [Weight], [AuthorId], [PublisherId]) VALUES (5, N'Animal Farm', N'9780141036137', CAST(N'2008-07-01' AS Date), 112, 70, 2, 2)
GO
SET IDENTITY_INSERT [dbo].[Book] OFF
GO
SET IDENTITY_INSERT [dbo].[Company] ON 
GO
INSERT [dbo].[Company] ([Id], [Name], [Phone]) VALUES (1, N'Norstedts', N'031-22 33 44')
GO
INSERT [dbo].[Company] ([Id], [Name], [Phone]) VALUES (2, N'Peguin Books Ltd', N'0012 3456789')
GO
INSERT [dbo].[Company] ([Id], [Name], [Phone]) VALUES (3, N'Bokförlaget Atlantis', N'08-55 66 77')
GO
SET IDENTITY_INSERT [dbo].[Company] OFF
GO
SET IDENTITY_INSERT [dbo].[Person] ON 
GO
INSERT [dbo].[Person] ([Id], [Name]) VALUES (1, N'Paul Auster')
GO
INSERT [dbo].[Person] ([Id], [Name]) VALUES (2, N'George Orwell')
GO
SET IDENTITY_INSERT [dbo].[Person] OFF
GO
INSERT [dbo].[Review] ([BookId], [UserId], [Text]) VALUES (2, 1, N'En mycket bra bok med ett väldigt personligt anslag i språket.')
GO
INSERT [dbo].[Review] ([BookId], [UserId], [Text]) VALUES (2, 2, N'Bla bla bla')
GO
INSERT [dbo].[Review] ([BookId], [UserId], [Text]) VALUES (4, 1, N'Denna samhällsorienterande bok borde vara obligatorisk läsning under skolans högstadieår.')
GO
INSERT [dbo].[Review] ([BookId], [UserId], [Text]) VALUES (4, 2, N'Bla bla bla')
GO
INSERT [dbo].[Review] ([BookId], [UserId], [Text]) VALUES (5, 1, N'Fantastisk bok! Den kan varmt rekommenderas.')
GO
SET IDENTITY_INSERT [dbo].[User] ON 
GO
INSERT [dbo].[User] ([Id], [LoginName], [Password]) VALUES (1, N'oscols', N'1234')
GO
INSERT [dbo].[User] ([Id], [LoginName], [Password]) VALUES (2, N'zelda', N'7777')
GO
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Company] FOREIGN KEY([PublisherId])
REFERENCES [dbo].[Company] ([Id])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Company]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Person] FOREIGN KEY([AuthorId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Person]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Book] FOREIGN KEY([BookId])
REFERENCES [dbo].[Book] ([Id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Book]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_User]
GO
