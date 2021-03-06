USE [master]
GO
/****** Object:  Database [eDiskont]    Script Date: 14.08.2019. 17:19:42 ******/
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
/****** Object:  Table [dbo].[AuthTokens]    Script Date: 14.08.2019. 17:19:43 ******/
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
/****** Object:  Table [dbo].[DeliveryMethods]    Script Date: 14.08.2019. 17:19:44 ******/
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
/****** Object:  Table [dbo].[ItemTypes]    Script Date: 14.08.2019. 17:19:44 ******/
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
/****** Object:  Table [dbo].[Items]    Script Date: 14.08.2019. 17:19:44 ******/
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
/****** Object:  Table [dbo].[Orders]    Script Date: 14.08.2019. 17:19:45 ******/
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
/****** Object:  Table [dbo].[OrdersData]    Script Date: 14.08.2019. 17:19:45 ******/
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
/****** Object:  Table [dbo].[OrdersItems]    Script Date: 14.08.2019. 17:19:45 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 14.08.2019. 17:19:45 ******/
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
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (52, N'252d6fbf-46dd-4c12-991c-5e787f3e0a38', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (53, N'54eefdcd-a8d6-4ae2-abeb-f1ffcdfdc0f2', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (54, N'0ec27482-9a70-44fe-9009-bdbb9087c506', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (55, N'688d071c-2fae-4537-95cd-41c4e9955890', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (56, N'c8d5c528-0835-4c04-b53b-7f41d754c6a5', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (57, N'5f206066-d419-422b-9365-50078e1a0f34', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (58, N'9e30e90f-f856-46e5-8a56-ab4a962cdbd5', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (59, N'f3ad8821-ebbe-41d5-9c30-da8757a3a512', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (60, N'a2f649e9-fffe-42d8-b941-40d0db74df5d', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (61, N'261fd080-113e-4401-b31d-4becc95dba73', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (62, N'4fd1a72c-6882-446a-9468-9bbbe41a2387', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (63, N'ef855e6d-9cc4-4b91-b2d8-1ccefb5fe277', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (64, N'd281bf9f-0496-4afe-bc1c-c21a1b6b59cb', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (65, N'53097364-148d-43a3-9da7-8a68b97ab741', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (66, N'1c53090d-ba2e-4c2a-9e66-b896164f580f', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (67, N'1c0e4ab4-330d-42b7-b185-5a9c02f49c28', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (68, N'bb5f90c9-e0c9-47fa-9e98-962ffe5d9757', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (69, N'b67b9bb6-8e04-4e47-ac1c-4382878daaf7', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (70, N'811159f8-8584-448d-866e-d8946f99c376', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (71, N'913ad062-266a-446c-a977-42811d1da891', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (72, N'2011da60-9b66-4c4b-98e6-baf106671b77', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (73, N'd034a291-9a81-4dcd-b28a-83208954434f', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (74, N'6b1b3938-4e4f-489b-835d-d8592f4251a0', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (75, N'66ac070c-aa59-4e70-a757-3e6646d40a63', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (76, N'01b64c3b-6c0f-461d-b861-05546db20253', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (77, N'84977040-f047-48d5-b0e7-61e97cc8fd28', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (78, N'36ef0771-6fdc-4b33-b074-d8e9aba0162f', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (79, N'19787435-75e3-4d32-b696-68c6170d3482', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (80, N'45bab2da-b4c5-48df-b6f2-d7cc5ba6226b', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (81, N'33875f80-3ebd-4499-b8fc-0ebe4cd3088e', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (82, N'da11d203-4248-4b58-9fa1-59fefb649286', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (83, N'84698e5b-8386-4f34-bde2-cf628562fd01', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (84, N'c05bfd42-c0d6-4afa-983d-8a044dee637c', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (85, N'be874db3-3d50-4150-b1bb-daebce1e2313', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (86, N'9da1ef15-6456-4209-948d-509973a128cb', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (87, N'76a6ab13-9e69-4b90-af94-2a4dc8fe3496', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (88, N'b1fbee22-07ec-4298-aad7-6ec96464985d', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (89, N'df51b32a-40f8-419d-bf69-ff72a7cf8314', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (90, N'6e38907c-807a-46ef-9763-92d81b408984', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (91, N'6df2db46-f00a-4cc3-83b4-f29e2381c137', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (92, N'df00d74a-8e80-497e-86e5-e4d321232cfe', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (93, N'6dbc8cc6-0f2d-4892-8696-43ca844d94ca', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (94, N'f2cceb2a-adcc-4fe9-9061-592cc7b39249', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (95, N'ab856b71-c721-427b-80ff-f6023695cf0d', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (96, N'fc6d5ed6-852f-4342-9776-9e5e9eb13b4b', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (97, N'9ec95998-9f90-450d-85b6-e621fb9ed490', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (98, N'bee626b0-ef51-46ff-b7de-b50f0aa28860', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (99, N'e0df43c0-58f5-4ca7-8b4a-fdc0ae818527', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (100, N'2e9bcb79-7d82-4d25-9c47-620b358613f9', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (101, N'6e68251e-cbaa-438f-b189-fe1291e4ea55', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (102, N'6b861dbc-0dda-4953-a096-f670ad5ca7e8', 1, N'...')
GO
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (103, N'a4a02103-728a-41b6-b984-a4595968f074', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (104, N'9a132f86-e88d-44cb-8604-2817e5436595', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (105, N'95eed2d7-05a6-43da-8997-d41314daca3a', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (106, N'e243a225-0354-4f1e-9499-5d1128752ec9', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (107, N'4baccb75-a07f-4fe3-98d3-5d2326711525', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (108, N'ad6b3dec-6eaa-4cdd-baa7-6bc368ed11b1', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (109, N'f4e6a10d-b1ae-4ca6-b4d8-ae1a8daf630d', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (110, N'005c719b-b32e-429e-9169-747cb14f8400', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (111, N'8c334101-e2ca-4b9e-95ea-694bfb397186', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (112, N'70159f70-cc9b-42cc-b621-3f80c97deec0', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (113, N'af84d9fc-b642-44cc-9721-11adaa6ecc06', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (114, N'eb732421-e56f-417c-9d28-81058ec957c7', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (115, N'962091ed-f07f-4ecf-b905-9355792dd947', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (116, N'4c73cd14-e8bf-434f-b184-ad66150c5827', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (117, N'ba5982ae-d399-4482-a5af-72d779cd92f3', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (118, N'af6db53b-c503-45ed-856c-2fb74991711e', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (119, N'b9ae837c-7412-4d34-875c-070221941aa4', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (120, N'6334f99b-5533-4bca-a9d4-dbd622e9b2ac', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (121, N'99504edf-69ee-484b-9e26-7db97a614906', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (122, N'9792a9cc-2e2c-4c00-b96c-3d0cb5bf06ad', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (123, N'e179e576-ab79-4a1a-bcd7-9cd1f0daac61', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (124, N'9a56bca0-68ee-4167-92e2-77df3701f35e', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (125, N'46d32afd-c04a-4e9b-ba38-17fa19cec19a', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (126, N'035b10b9-04b9-4e3f-b2e5-44b4d5fc2a05', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (127, N'b79ce529-44fc-46a0-a2f6-44e24039bcb6', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (128, N'ba4aeaec-7bf8-4588-bac2-53e84355e8e8', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (129, N'e0f1f821-6288-4cca-9a41-4348f7b5807c', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (130, N'5fe36412-c0dc-4a02-9555-e6991b920487', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (131, N'ba0b2510-daf1-4761-8855-533ab859b087', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (132, N'056c4567-c8ec-4ef6-a62e-b33b7f760c2f', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (133, N'e1732c70-23c5-43f5-8817-590b2ee0eb76', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (134, N'd7937f7e-cb0e-47ac-b3ea-a9c83b3328c6', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (135, N'75992184-78b4-4764-8b0f-6a33dabbc5b9', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (136, N'a2bfcb9c-7c38-4915-8841-843b7f4752aa', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (137, N'2ad75185-7fbf-46cb-81c4-8b77909dc5be', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (138, N'650bd6ea-7351-4e9b-91cf-210a3fddabfa', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (139, N'a0d6abfb-8413-4577-be41-4053c11c9e1a', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (140, N'33645731-d9db-436d-b710-1e9221b72579', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (141, N'e0d7ff00-dbb9-4ca3-851a-76c982fcfcd7', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (142, N'eda64eeb-c2b0-4980-9f1b-9b45dd454681', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (143, N'030bf5b5-9db1-429f-9299-9e3df014c908', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (144, N'306fd97a-3695-4655-a5ed-116c30d5bebc', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (145, N'a702f40a-c244-4908-9ff8-ca8d350026e4', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (146, N'3f8d526b-db2c-4715-8b50-61e8acde8b07', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (147, N'87f112a7-0166-4130-9e20-0d18fe79ede2', 15, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (148, N'2373284a-ad9b-485e-8e29-60e9a02cd3a8', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (149, N'3b13a303-0baa-4715-acbb-a4548ef7ff26', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (1096, N'3a7a9598-7390-49a6-acf9-883546ff44fc', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (2096, N'1a2a6993-82dd-4664-b619-763782b3b193', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (2097, N'969fbf25-f333-4f8e-a3ec-4912472f4f65', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (2098, N'f665867e-5b75-4fb4-a930-e5e0b16e67d7', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (2099, N'8a2ba4e9-9603-4c4f-8e21-8e5eaeaca15c', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (2100, N'728607b5-056f-40c4-98d9-119ec847604e', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (2101, N'726845f6-0b31-4f6e-a27d-21ded265b64a', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (2102, N'b687053b-98bc-4225-af29-63528c883dc1', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (2103, N'fae1b3ac-bcb6-475f-88f8-6b2e9328d17c', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (2104, N'cc2eb808-9789-4517-ba8e-da8bcea9ae93', 1, N'...')
INSERT [dbo].[AuthTokens] ([AuthTokenID], [Token], [UserID], [IPAddress]) VALUES (2105, N'2ce0ca4c-1874-4480-be9b-f724a0ddb8da', 1, N'...')
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

INSERT [dbo].[Orders] ([OrderID], [OrderDataID], [TotalPrice], [UserID], [OrderDate]) VALUES (1054, 1047, CAST(120.00 AS Decimal(5, 2)), 1, CAST(N'2019-07-12T20:02:00.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [OrderDataID], [TotalPrice], [UserID], [OrderDate]) VALUES (1055, 1048, CAST(38.40 AS Decimal(5, 2)), 1, CAST(N'2019-07-14T15:55:00.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [OrderDataID], [TotalPrice], [UserID], [OrderDate]) VALUES (1056, 1049, CAST(136.00 AS Decimal(5, 2)), 1, CAST(N'2019-07-14T15:58:00.000' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [OrderDataID], [TotalPrice], [UserID], [OrderDate]) VALUES (1057, 1050, CAST(96.80 AS Decimal(5, 2)), 1, CAST(N'2019-07-14T16:08:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[OrdersData] ON 

INSERT [dbo].[OrdersData] ([FullName], [Company], [DeliveryMethodID], [DeliveryAddress], [City], [OrderDataID]) VALUES (N'Arman Humačkić', N'Caffe Pizzeria Krypton', 1, N'Ada br. 129 ', N'Stolac', 1047)
INSERT [dbo].[OrdersData] ([FullName], [Company], [DeliveryMethodID], [DeliveryAddress], [City], [OrderDataID]) VALUES (N'Ivan', N'Fast food Čaršija', 2, N'Centar BB', N'Stolac', 1048)
INSERT [dbo].[OrdersData] ([FullName], [Company], [DeliveryMethodID], [DeliveryAddress], [City], [OrderDataID]) VALUES (N'Amar', N'Caffe pizzeria Krypton', 1, N'Ada 127', N'Stolac', 1049)
INSERT [dbo].[OrdersData] ([FullName], [Company], [DeliveryMethodID], [DeliveryAddress], [City], [OrderDataID]) VALUES (N'Asmir', N'Caffe Pizzeria Krypton', 1, N'Ada 127', N'Stolac', 1050)
SET IDENTITY_INSERT [dbo].[OrdersData] OFF
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (1054, 1, 72)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (1054, 2, 24)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (1054, 4, 48)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (1055, 1, 24)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (1055, 2, 24)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (1056, 1, 24)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (1056, 3, 24)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (1056, 6, 24)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (1056, 15, 32)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (1056, 21, 48)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (1057, 1, 30)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (1057, 2, 28)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (1057, 6, 40)
INSERT [dbo].[OrdersItems] ([OrderID], [ItemID], [Amount]) VALUES (1057, 13, 8)
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Email], [Pass]) VALUES (1, N'humast96@gmail.com', N'test123')
INSERT [dbo].[Users] ([UserID], [Email], [Pass]) VALUES (4, N'arman.humackic@hotmail.com', N'tdasdasdasd')
INSERT [dbo].[Users] ([UserID], [Email], [Pass]) VALUES (13, N'amar.h@diskont.ba', N'AmarH123!')
INSERT [dbo].[Users] ([UserID], [Email], [Pass]) VALUES (14, N'test123@test.com', N'Test123')
INSERT [dbo].[Users] ([UserID], [Email], [Pass]) VALUES (15, N'amar@test.com', N'Amar123')
INSERT [dbo].[Users] ([UserID], [Email], [Pass]) VALUES (16, N'dis@dis.com', N'Dis123')
INSERT [dbo].[Users] ([UserID], [Email], [Pass]) VALUES (17, N'disk@disk.com', N'Disk123')
SET IDENTITY_INSERT [dbo].[Users] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Email]    Script Date: 14.08.2019. 17:19:45 ******/
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
