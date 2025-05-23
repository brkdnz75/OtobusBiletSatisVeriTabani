USE [master]
GO
/****** Object:  Database [Bilet_Satış]    Script Date: 29.03.2025 12:48:21 ******/
CREATE DATABASE [Bilet_Satış]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Bilet_Satış', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Bilet_Satış.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Bilet_Satış_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Bilet_Satış_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Bilet_Satış] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Bilet_Satış].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Bilet_Satış] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Bilet_Satış] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Bilet_Satış] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Bilet_Satış] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Bilet_Satış] SET ARITHABORT OFF 
GO
ALTER DATABASE [Bilet_Satış] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Bilet_Satış] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Bilet_Satış] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Bilet_Satış] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Bilet_Satış] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Bilet_Satış] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Bilet_Satış] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Bilet_Satış] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Bilet_Satış] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Bilet_Satış] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Bilet_Satış] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Bilet_Satış] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Bilet_Satış] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Bilet_Satış] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Bilet_Satış] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Bilet_Satış] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Bilet_Satış] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Bilet_Satış] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Bilet_Satış] SET  MULTI_USER 
GO
ALTER DATABASE [Bilet_Satış] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Bilet_Satış] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Bilet_Satış] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Bilet_Satış] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Bilet_Satış] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Bilet_Satış] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Bilet_Satış] SET QUERY_STORE = ON
GO
ALTER DATABASE [Bilet_Satış] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Bilet_Satış]
GO
/****** Object:  UserDefinedFunction [dbo].[ToplamFiyat]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ToplamFiyat] (@SeferID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @ToplamFiyat DECIMAL(10,2);

    SELECT @ToplamFiyat = SUM(Fiyat)
    FROM Biletler
    WHERE SeferID = @SeferID;

    RETURN @ToplamFiyat;
END;

GO
/****** Object:  UserDefinedFunction [dbo].[ToplamGelir]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ToplamGelir] (@KampanyaID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @ToplamGelir DECIMAL(10,2);

    SELECT @ToplamGelir = SUM(İndirimMiktarı)
    FROM KampanyaUygulamaları
    WHERE KampanyaID = @KampanyaID;

    RETURN @ToplamGelir;
END;
GO
/****** Object:  Table [dbo].[Seferler]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seferler](
	[SeferID] [int] IDENTITY(1,1) NOT NULL,
	[OtobüsID] [int] NULL,
	[ŞoförID] [int] NULL,
	[KalkışYeri] [nvarchar](30) NULL,
	[VarışYeri] [nvarchar](30) NULL,
	[KalkışTarihi] [datetime] NULL,
	[VarışTarihi] [datetime] NULL,
	[KoltukSayısı] [int] NULL,
	[Fiyat] [decimal](10, 2) NULL,
 CONSTRAINT [PK__Seferler__B989AA1111BBF83C] PRIMARY KEY CLUSTERED 
(
	[SeferID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Otobüsler]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Otobüsler](
	[OtobüsID] [int] NOT NULL,
	[Plaka] [nvarchar](50) NOT NULL,
	[Marka] [nvarchar](20) NULL,
	[Model] [nvarchar](20) NULL,
	[KoltukSayısı] [int] NULL,
	[Durum] [nvarchar](15) NULL,
 CONSTRAINT [PK__Otobüsle__818CC24A41C9B533] PRIMARY KEY CLUSTERED 
(
	[OtobüsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Şoförler]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Şoförler](
	[ŞoförID] [int] NOT NULL,
	[Ad] [nvarchar](50) NULL,
	[Soyad] [nvarchar](50) NULL,
	[TC] [nvarchar](50) NOT NULL,
	[Telefon] [nvarchar](50) NULL,
	[Adres] [nvarchar](100) NULL,
 CONSTRAINT [PK__Şoförler__6EC9979A5F4DE9F5] PRIMARY KEY CLUSTERED 
(
	[ŞoförID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[InnerJ]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[InnerJ] AS
SELECT Otobüsler.OtobüsID, Otobüsler.Marka, Otobüsler.Model, Otobüsler.KoltukSayısı,
       Şoförler.Ad AS ŞoförAdı, Şoförler.Soyad AS ŞoförSoyadı
FROM Otobüsler
INNER JOIN Seferler ON Otobüsler.OtobüsID = Seferler.OtobüsID
INNER JOIN Şoförler ON Seferler.ŞoförID = Şoförler.ŞoförID;
-- seferlerde görev alan şoförlerin bilgilerini içerir
GO
/****** Object:  Table [dbo].[Müşteriler]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Müşteriler](
	[MüşteriID] [int] NOT NULL,
	[Ad] [nvarchar](50) NULL,
	[Soyad] [nvarchar](50) NULL,
	[TC] [nvarchar](50) NOT NULL,
	[Telefon] [nvarchar](50) NULL,
	[Adres] [nvarchar](100) NULL,
 CONSTRAINT [PK__Müşteril__8F1B3EFDD6E15E38] PRIMARY KEY CLUSTERED 
(
	[MüşteriID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Biletler]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Biletler](
	[BiletID] [int] NOT NULL,
	[SeferID] [int] NULL,
	[MüşteriID] [int] NULL,
	[KoltukNo] [int] NULL,
	[Fiyat] [decimal](10, 2) NULL,
	[İşlemTarihi] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[BiletID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[LeftOuterJ]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LeftOuterJ] AS
SELECT Otobüsler.OtobüsID, Otobüsler.Marka, Otobüsler.Model, Otobüsler.KoltukSayısı,
       Müşteriler.Ad AS MüşteriAdı, Müşteriler.Soyad AS MüşteriSoyadı
FROM Otobüsler
LEFT JOIN Seferler ON Otobüsler.OtobüsID = Seferler.OtobüsID
LEFT JOIN Biletler ON Seferler.SeferID = Biletler.SeferID
LEFT JOIN Müşteriler ON Biletler.MüşteriID = Müşteriler.MüşteriID;

-- otobüslerde bilet alan müşterilerin bilgilerini içerir.
GO
/****** Object:  Table [dbo].[KampanyaUygulamaları]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KampanyaUygulamaları](
	[UygulamaID] [int] NOT NULL,
	[KampanyaID] [int] NULL,
	[SeferID] [int] NULL,
	[İndirimMiktarı] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[UygulamaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kampanyalar]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kampanyalar](
	[KampanyaID] [int] NOT NULL,
	[KampanyaAdı] [nvarchar](100) NULL,
	[İndirimOranı] [decimal](5, 2) NULL,
	[BaşlangıçTarihi] [date] NULL,
	[BitişTarihi] [date] NULL,
 CONSTRAINT [PK__Kampanya__1B92F8DD3A07F055] PRIMARY KEY CLUSTERED 
(
	[KampanyaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[RightOuterJ]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[RightOuterJ] AS
SELECT Seferler.SeferID, Seferler.KalkışYeri, Seferler.VarışYeri,
       Kampanyalar.KampanyaAdı, Kampanyalar.İndirimOranı
FROM Seferler
RIGHT JOIN KampanyaUygulamaları ON Seferler.SeferID = KampanyaUygulamaları.SeferID
RIGHT JOIN Kampanyalar ON KampanyaUygulamaları.KampanyaID = Kampanyalar.KampanyaID;
GO
/****** Object:  View [dbo].[FullOuterJ]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FullOuterJ] AS
SELECT Otobüsler.OtobüsID, Otobüsler.Marka, Otobüsler.Model, Otobüsler.KoltukSayısı,
       Seferler.KalkışYeri, Seferler.VarışYeri
FROM Otobüsler
FULL OUTER JOIN Seferler ON Otobüsler.OtobüsID = Seferler.OtobüsID;

GO
/****** Object:  UserDefinedFunction [dbo].[AktifSeferler]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AktifSeferler] ()
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM Seferler
    WHERE KalkışTarihi >= GETDATE()
);



GO
/****** Object:  UserDefinedFunction [dbo].[GeçmişSeferleriAl]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GeçmişSeferleriAl] ()
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM Seferler
    WHERE KalkışTarihi < GETDATE()
);
GO
/****** Object:  Table [dbo].[Biletİptalleri]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Biletİptalleri](
	[İptalID] [int] NOT NULL,
	[BiletID] [int] NULL,
	[İptalTarihi] [datetime] NULL,
	[İptalNedeni] [nvarchar](250) NULL,
 CONSTRAINT [PK__Biletİpt__5048529AE030AC41] PRIMARY KEY CLUSTERED 
(
	[İptalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Biletler_Yedek]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Biletler_Yedek](
	[BiletID] [int] NOT NULL,
	[SeferID] [int] NULL,
	[MüşteriID] [int] NULL,
	[KoltukNo] [int] NULL,
	[Fiyat] [decimal](10, 2) NULL,
	[İşlemTarihi] [datetime] NULL,
	[KaydedenKullanıcı] [varchar](50) NULL,
	[Silindi] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[BiletID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departmanlar]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departmanlar](
	[DepartmanID] [int] NOT NULL,
	[DepartmanAdı] [nvarchar](20) NULL,
 CONSTRAINT [PK__Departma__3A2312366D89A040] PRIMARY KEY CLUSTERED 
(
	[DepartmanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Duraklar]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Duraklar](
	[DurakID] [int] NOT NULL,
	[DurakAdı] [nvarchar](50) NULL,
	[GüzergahID] [int] NULL,
 CONSTRAINT [PK__Duraklar__495C71A5DAFF993A] PRIMARY KEY CLUSTERED 
(
	[DurakID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DurakSeferleri]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DurakSeferleri](
	[DurakSeferID] [int] NOT NULL,
	[SeferID] [int] NULL,
	[DurakID] [int] NULL,
	[VarışSaat] [time](7) NULL,
	[KalkışSaat] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[DurakSeferID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Güzergahlar]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Güzergahlar](
	[GüzergahID] [int] NOT NULL,
	[GüzergahAdı] [nvarchar](100) NULL,
 CONSTRAINT [PK__Güzergah__8EC95C634999BC18] PRIMARY KEY CLUSTERED 
(
	[GüzergahID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[İşlemler]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[İşlemler](
	[İşlemID] [int] NOT NULL,
	[BiletID] [int] NULL,
	[İşlemTipi] [nvarchar](50) NULL,
	[İşlemTarihi] [datetime] NULL,
 CONSTRAINT [PK__İşlemler__39970A2B0DC314A2] PRIMARY KEY CLUSTERED 
(
	[İşlemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KoltukDurumu]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KoltukDurumu](
	[DurumID] [int] NOT NULL,
	[KoltukNo] [int] NULL,
	[SeferID] [int] NULL,
	[Durum] [nvarchar](50) NULL,
 CONSTRAINT [PK__KoltukDu__E6B16D64C5B211A0] PRIMARY KEY CLUSTERED 
(
	[DurumID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kullanıcılar]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kullanıcılar](
	[KullanıcıID] [int] NOT NULL,
	[KullanıcıAdı] [nvarchar](20) NULL,
	[Şifre] [nvarchar](15) NULL,
	[YetkiSeviyesi] [int] NULL,
	[PersonelID] [int] NULL,
 CONSTRAINT [PK__Kullanıc__C36316212548F8C5] PRIMARY KEY CLUSTERED 
(
	[KullanıcıID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personel]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personel](
	[PersonelID] [int] NOT NULL,
	[Ad] [nvarchar](50) NULL,
	[Soyad] [nvarchar](50) NULL,
	[TC] [nvarchar](50) NOT NULL,
	[Telefon] [nvarchar](50) NULL,
	[Adres] [nvarchar](100) NULL,
	[DepartmanID] [int] NULL,
 CONSTRAINT [PK__Personel__0F0C5751BD003DCB] PRIMARY KEY CLUSTERED 
(
	[PersonelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Şikayetler]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Şikayetler](
	[ŞikayetID] [int] NOT NULL,
	[MüşteriID] [int] NULL,
	[ŞikayetMetni] [nvarchar](250) NULL,
	[ŞikayetTarihi] [datetime] NULL,
 CONSTRAINT [PK__Şikayetl__AB57FCB482560516] PRIMARY KEY CLUSTERED 
(
	[ŞikayetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[YetkiSeviyeleri]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[YetkiSeviyeleri](
	[YetkiID] [int] NOT NULL,
	[YetkiAdı] [nvarchar](50) NULL,
 CONSTRAINT [PK__YetkiSev__349614066344B78C] PRIMARY KEY CLUSTERED 
(
	[YetkiID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Yorumlar]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Yorumlar](
	[YorumID] [int] NOT NULL,
	[MüşteriID] [int] NULL,
	[YorumMetni] [nvarchar](255) NULL,
	[YorumTarihi] [datetime] NULL,
 CONSTRAINT [PK__Yorumlar__F2BE14C83AA1959C] PRIMARY KEY CLUSTERED 
(
	[YorumID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Yöneticiler]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Yöneticiler](
	[YöneticiID] [int] NOT NULL,
	[Ad] [nvarchar](50) NULL,
	[Soyad] [nvarchar](50) NULL,
	[TC] [nvarchar](50) NOT NULL,
	[Telefon] [nvarchar](50) NULL,
	[Adres] [nvarchar](100) NULL,
	[KullanıcıID] [int] NULL,
 CONSTRAINT [PK__Yönetici__32023E40B8CE2A87] PRIMARY KEY CLUSTERED 
(
	[YöneticiID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Biletİptalleri] ADD  CONSTRAINT [DF__Biletİpta__İptal__08B54D69]  DEFAULT (getdate()) FOR [İptalTarihi]
GO
ALTER TABLE [dbo].[Biletler] ADD  DEFAULT (getdate()) FOR [İşlemTarihi]
GO
ALTER TABLE [dbo].[Biletler_Yedek] ADD  DEFAULT (getdate()) FOR [İşlemTarihi]
GO
ALTER TABLE [dbo].[İşlemler] ADD  CONSTRAINT [DF__İşlemler__İşlemT__7E37BEF6]  DEFAULT (getdate()) FOR [İşlemTarihi]
GO
ALTER TABLE [dbo].[Şikayetler] ADD  CONSTRAINT [DF__Şikayetle__Şikay__25518C17]  DEFAULT (getdate()) FOR [ŞikayetTarihi]
GO
ALTER TABLE [dbo].[Yorumlar] ADD  CONSTRAINT [DF__Yorumlar__YorumT__2180FB33]  DEFAULT (getdate()) FOR [YorumTarihi]
GO
ALTER TABLE [dbo].[Biletİptalleri]  WITH CHECK ADD  CONSTRAINT [FK__Biletİpta__Bilet__09A971A2] FOREIGN KEY([BiletID])
REFERENCES [dbo].[Biletler] ([BiletID])
GO
ALTER TABLE [dbo].[Biletİptalleri] CHECK CONSTRAINT [FK__Biletİpta__Bilet__09A971A2]
GO
ALTER TABLE [dbo].[Biletler]  WITH CHECK ADD  CONSTRAINT [FK__Biletler__Müşter__75A278F5] FOREIGN KEY([MüşteriID])
REFERENCES [dbo].[Müşteriler] ([MüşteriID])
GO
ALTER TABLE [dbo].[Biletler] CHECK CONSTRAINT [FK__Biletler__Müşter__75A278F5]
GO
ALTER TABLE [dbo].[Biletler]  WITH CHECK ADD  CONSTRAINT [FK__Biletler__SeferI__74AE54BC] FOREIGN KEY([SeferID])
REFERENCES [dbo].[Seferler] ([SeferID])
GO
ALTER TABLE [dbo].[Biletler] CHECK CONSTRAINT [FK__Biletler__SeferI__74AE54BC]
GO
ALTER TABLE [dbo].[Duraklar]  WITH CHECK ADD  CONSTRAINT [FK__Duraklar__Güzerg__1AD3FDA4] FOREIGN KEY([GüzergahID])
REFERENCES [dbo].[Güzergahlar] ([GüzergahID])
GO
ALTER TABLE [dbo].[Duraklar] CHECK CONSTRAINT [FK__Duraklar__Güzerg__1AD3FDA4]
GO
ALTER TABLE [dbo].[DurakSeferleri]  WITH CHECK ADD  CONSTRAINT [FK__DurakSefe__Durak__1EA48E88] FOREIGN KEY([DurakID])
REFERENCES [dbo].[Duraklar] ([DurakID])
GO
ALTER TABLE [dbo].[DurakSeferleri] CHECK CONSTRAINT [FK__DurakSefe__Durak__1EA48E88]
GO
ALTER TABLE [dbo].[DurakSeferleri]  WITH CHECK ADD  CONSTRAINT [FK__DurakSefe__Sefer__1DB06A4F] FOREIGN KEY([SeferID])
REFERENCES [dbo].[Seferler] ([SeferID])
GO
ALTER TABLE [dbo].[DurakSeferleri] CHECK CONSTRAINT [FK__DurakSefe__Sefer__1DB06A4F]
GO
ALTER TABLE [dbo].[İşlemler]  WITH CHECK ADD  CONSTRAINT [FK__İşlemler__BiletI__7F2BE32F] FOREIGN KEY([BiletID])
REFERENCES [dbo].[Biletler] ([BiletID])
GO
ALTER TABLE [dbo].[İşlemler] CHECK CONSTRAINT [FK__İşlemler__BiletI__7F2BE32F]
GO
ALTER TABLE [dbo].[KampanyaUygulamaları]  WITH CHECK ADD  CONSTRAINT [FK__KampanyaU__Kampa__04E4BC85] FOREIGN KEY([KampanyaID])
REFERENCES [dbo].[Kampanyalar] ([KampanyaID])
GO
ALTER TABLE [dbo].[KampanyaUygulamaları] CHECK CONSTRAINT [FK__KampanyaU__Kampa__04E4BC85]
GO
ALTER TABLE [dbo].[KampanyaUygulamaları]  WITH CHECK ADD  CONSTRAINT [FK__KampanyaU__Sefer__05D8E0BE] FOREIGN KEY([SeferID])
REFERENCES [dbo].[Seferler] ([SeferID])
GO
ALTER TABLE [dbo].[KampanyaUygulamaları] CHECK CONSTRAINT [FK__KampanyaU__Sefer__05D8E0BE]
GO
ALTER TABLE [dbo].[KoltukDurumu]  WITH CHECK ADD  CONSTRAINT [FK__KoltukDur__Sefer__7A672E12] FOREIGN KEY([SeferID])
REFERENCES [dbo].[Seferler] ([SeferID])
GO
ALTER TABLE [dbo].[KoltukDurumu] CHECK CONSTRAINT [FK__KoltukDur__Sefer__7A672E12]
GO
ALTER TABLE [dbo].[Kullanıcılar]  WITH CHECK ADD  CONSTRAINT [FK__Kullanıcı__Perso__114A936A] FOREIGN KEY([PersonelID])
REFERENCES [dbo].[Personel] ([PersonelID])
GO
ALTER TABLE [dbo].[Kullanıcılar] CHECK CONSTRAINT [FK__Kullanıcı__Perso__114A936A]
GO
ALTER TABLE [dbo].[Personel]  WITH CHECK ADD  CONSTRAINT [FK__Personel__Depart__0E6E26BF] FOREIGN KEY([DepartmanID])
REFERENCES [dbo].[Departmanlar] ([DepartmanID])
GO
ALTER TABLE [dbo].[Personel] CHECK CONSTRAINT [FK__Personel__Depart__0E6E26BF]
GO
ALTER TABLE [dbo].[Seferler]  WITH CHECK ADD  CONSTRAINT [FK__Seferler__Otobüs__6EF57B66] FOREIGN KEY([OtobüsID])
REFERENCES [dbo].[Otobüsler] ([OtobüsID])
GO
ALTER TABLE [dbo].[Seferler] CHECK CONSTRAINT [FK__Seferler__Otobüs__6EF57B66]
GO
ALTER TABLE [dbo].[Seferler]  WITH CHECK ADD  CONSTRAINT [FK_Seferler_Soforler] FOREIGN KEY([ŞoförID])
REFERENCES [dbo].[Şoförler] ([ŞoförID])
GO
ALTER TABLE [dbo].[Seferler] CHECK CONSTRAINT [FK_Seferler_Soforler]
GO
ALTER TABLE [dbo].[Şikayetler]  WITH CHECK ADD  CONSTRAINT [FK__Şikayetle__Müşte__2645B050] FOREIGN KEY([MüşteriID])
REFERENCES [dbo].[Müşteriler] ([MüşteriID])
GO
ALTER TABLE [dbo].[Şikayetler] CHECK CONSTRAINT [FK__Şikayetle__Müşte__2645B050]
GO
ALTER TABLE [dbo].[Yorumlar]  WITH CHECK ADD  CONSTRAINT [FK__Yorumlar__Müşter__22751F6C] FOREIGN KEY([MüşteriID])
REFERENCES [dbo].[Müşteriler] ([MüşteriID])
GO
ALTER TABLE [dbo].[Yorumlar] CHECK CONSTRAINT [FK__Yorumlar__Müşter__22751F6C]
GO
ALTER TABLE [dbo].[Yöneticiler]  WITH CHECK ADD  CONSTRAINT [FK__Yöneticil__Kulla__160F4887] FOREIGN KEY([KullanıcıID])
REFERENCES [dbo].[Kullanıcılar] ([KullanıcıID])
GO
ALTER TABLE [dbo].[Yöneticiler] CHECK CONSTRAINT [FK__Yöneticil__Kulla__160F4887]
GO
ALTER TABLE [dbo].[Biletler]  WITH CHECK ADD  CONSTRAINT [CHK_Fiyat] CHECK  (([Fiyat]>(0)))
GO
ALTER TABLE [dbo].[Biletler] CHECK CONSTRAINT [CHK_Fiyat]
GO
ALTER TABLE [dbo].[Biletler]  WITH CHECK ADD  CONSTRAINT [CHK_KoltukNo] CHECK  (([KoltukNo]>(0)))
GO
ALTER TABLE [dbo].[Biletler] CHECK CONSTRAINT [CHK_KoltukNo]
GO
ALTER TABLE [dbo].[Kampanyalar]  WITH CHECK ADD  CONSTRAINT [CHK_İndirimOranı] CHECK  (([İndirimOranı]>=(0)))
GO
ALTER TABLE [dbo].[Kampanyalar] CHECK CONSTRAINT [CHK_İndirimOranı]
GO
ALTER TABLE [dbo].[KoltukDurumu]  WITH CHECK ADD  CONSTRAINT [CHK_KoltukNoo] CHECK  (([KoltukNo]>(0)))
GO
ALTER TABLE [dbo].[KoltukDurumu] CHECK CONSTRAINT [CHK_KoltukNoo]
GO
ALTER TABLE [dbo].[Otobüsler]  WITH CHECK ADD  CONSTRAINT [CHK_KoltukSayısi] CHECK  (([KoltukSayısı]>(0)))
GO
ALTER TABLE [dbo].[Otobüsler] CHECK CONSTRAINT [CHK_KoltukSayısi]
GO
ALTER TABLE [dbo].[Seferler]  WITH CHECK ADD  CONSTRAINT [CHK_Fıyat] CHECK  (([Fiyat]>(0)))
GO
ALTER TABLE [dbo].[Seferler] CHECK CONSTRAINT [CHK_Fıyat]
GO
ALTER TABLE [dbo].[Seferler]  WITH CHECK ADD  CONSTRAINT [CHK_KoltukSayısıı] CHECK  (([KoltukSayısı]>(0)))
GO
ALTER TABLE [dbo].[Seferler] CHECK CONSTRAINT [CHK_KoltukSayısıı]
GO
/****** Object:  StoredProcedure [dbo].[SeferDüzenle]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SeferDüzenle]
    @SeferID INT,
    @OtobüsID INT,
	 @ŞoförID INT,
    @KalkışYeri VARCHAR(100),
    @VarışYeri VARCHAR(100),
    @KalkışTarihi DATETIME,
    @VarışTarihi DATETIME,
    @KoltukSayısı INT,
    @Fiyat DECIMAL(10,2)
AS
BEGIN
    UPDATE Seferler
    SET OtobüsID = @OtobüsID,
	     ŞoförID=@ŞoförID,
        KalkışYeri = @KalkışYeri,
        VarışYeri = @VarışYeri,
        KalkışTarihi = @KalkışTarihi,
        VarışTarihi = @VarışTarihi,
        KoltukSayısı = @KoltukSayısı,
        Fiyat = @Fiyat
    WHERE SeferID = @SeferID;
END;

GO
/****** Object:  StoredProcedure [dbo].[SeferEkle]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SeferEkle]
    @OtobüsID INT,
	@ŞoförID INT,
    @KalkışYeri VARCHAR(30),
    @VarışYeri VARCHAR(30),
    @KalkışTarihi DATETIME,
    @VarışTarihi DATETIME,
    @KoltukSayısı INT,
    @Fiyat DECIMAL(10,2)
AS
BEGIN
    INSERT INTO Seferler (OtobüsID, KalkışYeri, VarışYeri, KalkışTarihi, VarışTarihi, KoltukSayısı, Fiyat,ŞoförID)
    VALUES (@OtobüsID, @KalkışYeri, @VarışYeri, @KalkışTarihi, @VarışTarihi, @KoltukSayısı, @Fiyat,@ŞoförID);
END;
GO
/****** Object:  StoredProcedure [dbo].[SeferSil]    Script Date: 29.03.2025 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SeferSil]
    @SeferID INT
AS
BEGIN
    DELETE FROM Seferler WHERE SeferID = @SeferID;
END;

GO
USE [master]
GO
ALTER DATABASE [Bilet_Satış] SET  READ_WRITE 
GO
