USE [master]
GO
/****** Object:  Database [eDiskont]    Script Date: 24.06.2019. 15:27:10 ******/
CREATE DATABASE [eDiskont]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'eDiskont', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\eDiskont.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'eDiskont_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\eDiskont_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [eDiskont] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [eDiskont].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [eDiskont] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [eDiskont] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [eDiskont] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [eDiskont] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [eDiskont] SET ARITHABORT OFF 
GO
ALTER DATABASE [eDiskont] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [eDiskont] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [eDiskont] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [eDiskont] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [eDiskont] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [eDiskont] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [eDiskont] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [eDiskont] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [eDiskont] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [eDiskont] SET  ENABLE_BROKER 
GO
ALTER DATABASE [eDiskont] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [eDiskont] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [eDiskont] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [eDiskont] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [eDiskont] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [eDiskont] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [eDiskont] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [eDiskont] SET RECOVERY FULL 
GO
ALTER DATABASE [eDiskont] SET  MULTI_USER 
GO
ALTER DATABASE [eDiskont] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [eDiskont] SET DB_CHAINING OFF 
GO
ALTER DATABASE [eDiskont] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [eDiskont] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [eDiskont] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'eDiskont', N'ON'
GO
ALTER DATABASE [eDiskont] SET QUERY_STORE = OFF
GO
USE [eDiskont]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [eDiskont]
GO
/****** Object:  Table [dbo].[AuthTokens]    Script Date: 24.06.2019. 15:27:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuthTokens](
	[AuthTokenID] [int] IDENTITY(1,1) NOT NULL,
	[Token] [nvarchar](max) NULL,
	[UserID] [int] NOT NULL,
	[IPAddress] [nvarchar](100) NULL,
 CONSTRAINT [PK_AuthTokens] PRIMARY KEY CLUSTERED 
(
	[AuthTokenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeliveryMethods]    Script Date: 24.06.2019. 15:27:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeliveryMethods](
	[DeliveryMethodID] [int] NOT NULL,
	[MethodName] [nvarchar](20) NULL,
 CONSTRAINT [PK_DeliveryMethods] PRIMARY KEY CLUSTERED 
(
	[DeliveryMethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemTypes]    Script Date: 24.06.2019. 15:27:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemTypes](
	[ItemTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ItemTypes] PRIMARY KEY CLUSTERED 
(
	[ItemTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Items]    Script Date: 24.06.2019. 15:27:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[ItemName] [nvarchar](50) NOT NULL,
	[PackSize] [int] NOT NULL,
	[Price] [decimal](5, 2) NOT NULL,
	[ItemTypeID] [int] NOT NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 24.06.2019. 15:27:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderDataID] [int] NOT NULL,
	[TotalPrice] [decimal](5, 2) NOT NULL,
	[UserID] [int] NOT NULL,
	[OrderDate] [datetime] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrdersData]    Script Date: 24.06.2019. 15:27:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrdersData](
	[FullName] [nvarchar](50) NOT NULL,
	[Company] [nvarchar](50) NULL,
	[DeliveryMethodID] [int] NOT NULL,
	[DeliveryAddress] [nvarchar](50) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[OrderDataID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_OrdersData] PRIMARY KEY CLUSTERED 
(
	[OrderDataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrdersItems]    Script Date: 24.06.2019. 15:27:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrdersItems](
	[OrderID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Amount] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 24.06.2019. 15:27:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Pass] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AuthTokens] ON 

INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (1, N'2727da01-d00e-4ebd-a1f4-583a973e26fb', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (2, N'73de57bd-a66b-4b05-864e-753e5b9adc41', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (3, N'cf55ade2-a46b-43f0-91ba-56f3d158cae8', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (4, N'12927cd8-c753-4dd3-a657-1cd32975e286', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (5, N'82f16531-d257-45f0-bd8f-896acecc34e6', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (6, N'750c022a-3c5c-4835-8780-8401253b1a50', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (7, N'67980702-1ab4-4aa9-adc6-12aba8e24d09', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (8, N'b62e62e3-0618-4a64-b744-8957d63f20b5', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (9, N'608c1477-129a-44d8-bdaa-b35c023e2508', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (10, N'8b44b1f7-37ac-447a-803d-10c3189c5057', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (11, N'3b57c3bc-c635-4164-9e22-309a9562e7ea', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (12, N'a123a6ff-e0ee-48ad-963f-b52cd55eefd5', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (13, N'8121822b-c177-481f-bd25-4629380592e1', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (14, N'27352e9b-ea64-4633-b688-6b31cda958bb', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (15, N'a5add0a4-378b-4a41-aaf2-0e7081f51f54', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (16, N'ce62e88b-974a-49e0-9154-39fe7fbae33a', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (17, N'508a3e84-ae7f-488a-8b97-2c52bcbb0a65', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (18, N'53e5c471-a16c-486e-9849-5c8e5604d017', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (19, N'de355057-5005-4190-a6e0-af491a1fe3c4', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (20, N'510202b7-bd9b-4511-b4e7-6f94367c0754', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (21, N'2daea83b-2975-4468-b6b9-e62f9c923144', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (22, N'46748b10-0bb6-46d5-89ff-c1d3bf036ce6', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (23, N'1ea73088-002f-4814-9075-560bac6988c0', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (24, N'4e269f1f-3214-4c0d-ad42-b5ce4e71d5e0', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (25, N'4a42288e-2e61-474d-97db-a9f1264bca8a', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (26, N'6613e196-abec-41e9-ba95-ab0d9faf96ad', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (27, N'3b37c02a-86bf-4950-ba2c-e3da680435d3', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (28, N'54bb4022-7e24-406d-aec1-b451641bd7aa', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (29, N'83d95901-dfb2-486c-a5a1-5fe322028a3d', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (30, N'05690cf0-9b9d-4c48-902d-73615dd1f91d', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (31, N'17bd3ed0-6b49-484e-a785-a081706a03e8', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (32, N'6b3ee5b0-00d4-42e0-a97e-2e2b45e2c10f', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (35, N'1330f382-89aa-41aa-946f-c34f5401271d', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (37, N'1e8a0a65-abf6-4a0b-b528-beb7e405ba56', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (38, N'9f9390fb-9633-4e4c-9e9e-941894c0eb26', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (39, N'9a27bbad-ab90-45ed-9b7d-5b65180d92b2', 13, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (40, N'ed762f1d-b22f-4579-b1f4-8798da4d4ba7', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (41, N'85786ee3-7673-44f1-a1cd-54ee29820561', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (42, N'aea08db3-23bf-4118-b44e-636b912d5e57', 13, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (43, N'0f35b751-4835-41bf-af8b-c31104a8faa3', 13, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (44, N'7e5a8e6c-b0fd-4d65-b398-548523c2b0e1', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (45, N'78ffc53b-b86b-4095-afe0-9d5b20cd5ab2', 13, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (46, N'08071e20-556e-485a-8946-8e51ad9f3a92', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (47, N'61bdb295-c2a5-4aa4-b344-b880edc32f63', 13, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (48, N'82a0e985-84a6-42b9-8600-0b41e7a3c34a', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (49, N'f7f2ce9d-6a52-4bed-a594-6b6df4fc1bb8', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (50, N'5300bf49-2163-4d28-a01a-0ea2fd4debf7', 13, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (51, N'e29a38a2-eeed-4b29-a831-7157d5840009', 1, N'...')
SET IDENTITY_INSERT [dbo].[AuthTokens] OFF
INSERT [dbo].[DeliveryMethods] ([DeliveryMethodID], [MethodName]) VALUES (1, N'Brzo')
INSERT [dbo].[DeliveryMethods] ([DeliveryMethodID], [MethodName]) VALUES (2, N'Jeftino')
SET IDENTITY_INSERT [dbo].[ItemTypes] ON 

INSERT [dbo].[ItemTypes] ([ItemTypeID], [TypeName]) VALUES (1, N'Sokovi')
INSERT [dbo].[ItemTypes] ([ItemTypeID], [TypeName]) VALUES (2, N'Topli napici')
INSERT [dbo].[ItemTypes] ([ItemTypeID], [TypeName]) VALUES (3, N'Alkohol')
SET IDENTITY_INSERT [dbo].[ItemTypes] OFF
SET IDENTITY_INSERT [dbo].[Items] ON 

INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (1, N'coca cola', 24, CAST(0.80 AS Decimal(5, 2)), 1)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (2, N'fanta', 24, CAST(0.80 AS Decimal(5, 2)), 1)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (3, N'sprite', 24, CAST(0.90 AS Decimal(5, 2)), 1)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (4, N'cockta', 24, CAST(0.90 AS Decimal(5, 2)), 1)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (5, N'schweppes tonic', 24, CAST(1.10 AS Decimal(5, 2)), 1)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (6, N'schweppes bitter lemon', 24, CAST(1.10 AS Decimal(5, 2)), 1)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (7, N'breskva', 12, CAST(0.95 AS Decimal(5, 2)), 1)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (8, N'crni ribiz', 12, CAST(1.05 AS Decimal(5, 2)), 1)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (9, N'jabuka', 12, CAST(0.90 AS Decimal(5, 2)), 1)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (10, N'multivitamin', 12, CAST(0.95 AS Decimal(5, 2)), 1)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (11, N'naranca', 12, CAST(0.95 AS Decimal(5, 2)), 1)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (12, N'kafa julius meinl', 1, CAST(33.00 AS Decimal(5, 2)), 2)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (13, N'ness cokolada', 8, CAST(0.80 AS Decimal(5, 2)), 2)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (15, N'ness vanilija', 8, CAST(0.80 AS Decimal(5, 2)), 2)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (16, N'ness classic', 28, CAST(0.40 AS Decimal(5, 2)), 2)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (17, N'topla cokolada', 8, CAST(0.85 AS Decimal(5, 2)), 2)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (18, N'heineken', 12, CAST(1.30 AS Decimal(5, 2)), 3)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (19, N'ozujsko', 24, CAST(0.90 AS Decimal(5, 2)), 3)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (20, N'karlovacko', 24, CAST(0.95 AS Decimal(5, 2)), 3)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (21, N'sarajevsko', 24, CAST(0.90 AS Decimal(5, 2)), 3)
INSERT [dbo].[Items] ([ItemID], [ItemName], [PackSize], [Price], [ItemTypeID]) VALUES (22, N'preminger', 24, CAST(0.85 AS Decimal(5, 2)), 3)
SET IDENTITY_INSERT [dbo].[Items] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [OrderDataID], [TotalPrice], [UserID], [OrderDate]) VALUES (9, 1, CAST(60.00 AS Decimal(5, 2)), 1, CAST(N'2019-05-17T17:41:00.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [OrderDataID], [TotalPrice], [UserID], [OrderDate]) VALUES (10, 2, CAST(43.20 AS Decimal(5, 2)), 1, CAST(N'2019-05-17T18:01:00.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [OrderDataID], [TotalPrice], [UserID], [OrderDate]) VALUES (11, 3, CAST(60.00 AS Decimal(5, 2)), 1, CAST(N'2019-05-17T18:04:00.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [OrderDataID], [TotalPrice], [UserID], [OrderDate]) VALUES (12, 4, CAST(57.60 AS Decimal(5, 2)), 1, CAST(N'2019-05-17T18:09:00.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [OrderDataID], [TotalPrice], [UserID], [OrderDate]) VALUES (13, 5, CAST(172.80 AS Decimal(5, 2)), 1, CAST(N'2019-05-17T18:20:00.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [OrderDataID], [TotalPrice], [UserID], [OrderDate]) VALUES (31, 24, CAST(96.00 AS Decimal(5, 2)), 13, CAST(N'2019-05-23T13:54:00.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [OrderDataID], [TotalPrice], [UserID], [OrderDate]) VALUES (32, 25, CAST(76.80 AS Decimal(5, 2)), 1, CAST(N'2019-05-23T14:00:00.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [OrderDataID], [TotalPrice], [UserID], [OrderDate]) VALUES (33, 26, CAST(38.40 AS Decimal(5, 2)), 1, CAST(N'2019-05-23T14:25:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[OrdersData] ON 

INSERT [dbo].[OrdersData] ([FullName], [Company], [DeliveryMethodID], [DeliveryAddress], [City], [OrderDataID]) VALUES (N'Arman ', N'Caffe bar oskar', 1, N'Marsala tita ', N'mostar', 1)
INSERT [dbo].[OrdersData] ([FullName], [Company], [DeliveryMethodID], [DeliveryAddress], [City], [OrderDataID]) VALUES (N'das', N'dasd', 1, N'dad', N'sada', 2)
INSERT [dbo].[OrdersData] ([FullName], [Company], [DeliveryMethodID], [DeliveryAddress], [City], [OrderDataID]) VALUES (N'dasda', N'dad', 1, N'ad', N'ada', 3)
INSERT [dbo].[OrdersData] ([FullName], [Company], [DeliveryMethodID], [DeliveryAddress], [City], [OrderDataID]) VALUES (N'dad', N'asdas', 1, N'dasda', N'dda', 4)
INSERT [dbo].[OrdersData] ([FullName], [Company], [DeliveryMethodID], [DeliveryAddress], [City], [OrderDataID]) VALUES (N'dasd', N'dada', 1, N'dasd', N'adsdda', 5)
INSERT [dbo].[OrdersData] ([FullName], [Company], [DeliveryMethodID], [DeliveryAddress], [City], [OrderDataID]) VALUES (N'Amar', N'Caffe bar test', 1, N'novi grad adresa bb', N'Sarajevo', 24)
INSERT [dbo].[OrdersData] ([FullName], [Company], [DeliveryMethodID], [DeliveryAddress], [City], [OrderDataID]) VALUES (N'Amar H', N'Caffe pizzeria Nota', 1, N'Kraljice katarine BB', N'Stolac', 25)
INSERT [dbo].[OrdersData] ([FullName], [Company], [DeliveryMethodID], [DeliveryAddress], [City], [OrderDataID]) VALUES (N'Asmir ', N'Fast food zovicoeka', 1, N'Centar BB', N'Stolac', 26)
SET IDENTITY_INSERT [dbo].[OrdersData] OFF
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (9, 1, 48)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (9, 4, 24)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (10, 4, 48)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (11, 1, 48)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (11, 4, 24)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (12, 2, 72)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (13, 1, 24)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (13, 2, 192)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (31, 1, 48)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (31, 2, 72)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (32, 1, 48)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (32, 2, 48)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (33, 2, 48)
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Email], [Pass]) VALUES (1, N'humast96@gmail.com', N'test123')
INSERT [dbo].[Users] ([UserID], [Email], [Pass]) VALUES (4, N'arman.humackic@hotmail.com', N'tdasdasdasd')
INSERT [dbo].[Users] ([UserID], [Email], [Pass]) VALUES (13, N'amar.h@diskont.ba', N'AmarH123!')
SET IDENTITY_INSERT [dbo].[Users] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Email]    Script Date: 24.06.2019. 15:27:13 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UQ_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AuthTokens]  WITH CHECK ADD  CONSTRAINT [FK_AuthTokens_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[AuthTokens] CHECK CONSTRAINT [FK_AuthTokens_Users]
GO
ALTER TABLE [dbo].[Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_ItemTypes] FOREIGN KEY([ItemTypeID])
REFERENCES [dbo].[ItemTypes] ([ItemTypeID])
GO
ALTER TABLE [dbo].[Items] CHECK CONSTRAINT [FK_Items_ItemTypes]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_OrdersData] FOREIGN KEY([OrderDataID])
REFERENCES [dbo].[OrdersData] ([OrderDataID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_OrdersData]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[OrdersData]  WITH CHECK ADD  CONSTRAINT [FK_OrdersData_DeliveryMethods] FOREIGN KEY([DeliveryMethodID])
REFERENCES [dbo].[DeliveryMethods] ([DeliveryMethodID])
GO
ALTER TABLE [dbo].[OrdersData] CHECK CONSTRAINT [FK_OrdersData_DeliveryMethods]
GO
ALTER TABLE [dbo].[OrdersItems]  WITH CHECK ADD  CONSTRAINT [FK_OrdersItems_Items] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Items] ([ItemID])
GO
ALTER TABLE [dbo].[OrdersItems] CHECK CONSTRAINT [FK_OrdersItems_Items]
GO
ALTER TABLE [dbo].[OrdersItems]  WITH CHECK ADD  CONSTRAINT [FK_OrdersItems_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrdersItems] CHECK CONSTRAINT [FK_OrdersItems_Orders]
GO
USE [master]
GO
ALTER DATABASE [eDiskont] SET  READ_WRITE 
GO
