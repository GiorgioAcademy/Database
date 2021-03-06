USE [master]
GO
/****** Object:  Database [Banca2]    Script Date: 12/05/2021 13:07:53 ******/
CREATE DATABASE [Banca2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Banca2', FILENAME = N'C:\Users\Giorgio\Banca2.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Banca2_log', FILENAME = N'C:\Users\Giorgio\Banca2_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Banca2] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Banca2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Banca2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Banca2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Banca2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Banca2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Banca2] SET ARITHABORT OFF 
GO
ALTER DATABASE [Banca2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Banca2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Banca2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Banca2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Banca2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Banca2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Banca2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Banca2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Banca2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Banca2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Banca2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Banca2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Banca2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Banca2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Banca2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Banca2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Banca2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Banca2] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Banca2] SET  MULTI_USER 
GO
ALTER DATABASE [Banca2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Banca2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Banca2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Banca2] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Banca2] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Banca2]
GO
/****** Object:  UserDefinedFunction [dbo].[Eta]    Script Date: 12/05/2021 13:07:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Eta] 
(
	-- Add the parameters for the function here
	@dataNascita date
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int

	-- trasformazione della data in un intero di tipo 19930513
	declare @dataN int = year(@dataNascita) * 10000 + month(@dataNascita) * 100 + day(@dataNascita)
	-- trasformazione della data in un intero di tipo 20210512
	declare @dataOggi int = year(getdate()) * 10000 + month(getdate()) * 100 + day(getdate())

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = (@dataOggi - @dataN) / 10000	-- 279999 => 27

	-- Return the result of the function
	RETURN @Result

END
GO
/****** Object:  UserDefinedFunction [dbo].[Somma]    Script Date: 12/05/2021 13:07:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Somma](@a int, @b int) returns int
as
begin
	declare @c as int = @a + @b

	return @c
end
GO
/****** Object:  Table [dbo].[Calciatori]    Script Date: 12/05/2021 13:07:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Calciatori](
	[IdCalciatore] [int] NOT NULL,
	[Ruolo] [nvarchar](20) NOT NULL,
	[NumeroMaglia] [int] NOT NULL,
 CONSTRAINT [PK_Calciatori] PRIMARY KEY CLUSTERED 
(
	[IdCalciatore] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clienti]    Script Date: 12/05/2021 13:07:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clienti](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL,
	[Cognome] [nvarchar](30) NOT NULL,
	[Nome] [nvarchar](30) NOT NULL,
	[DataDiNascita] [date] NOT NULL,
 CONSTRAINT [PK_Clienti] PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Conti]    Script Date: 12/05/2021 13:07:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conti](
	[IdConto] [int] IDENTITY(1,1) NOT NULL,
	[Numero] [nvarchar](10) NOT NULL,
	[DataApertura] [date] NOT NULL,
 CONSTRAINT [PK_Conti] PRIMARY KEY CLUSTERED 
(
	[IdConto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Intestazioni]    Script Date: 12/05/2021 13:07:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Intestazioni](
	[IdCliente] [int] NOT NULL,
	[idConto] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Operazioni]    Script Date: 12/05/2021 13:07:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Operazioni](
	[IdOperazione] [int] IDENTITY(1,1) NOT NULL,
	[Causale] [nvarchar](50) NOT NULL,
	[DataOperazione] [date] NOT NULL,
	[Importo] [money] NOT NULL,
	[IdConto] [int] NOT NULL,
 CONSTRAINT [PK_Operazioni] PRIMARY KEY CLUSTERED 
(
	[IdOperazione] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ContiConIntestatari]    Script Date: 12/05/2021 13:07:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ContiConIntestatari]
AS
SELECT        TOP (100) PERCENT ct.IdConto, ct.Numero, ct.DataApertura, cl.Cognome + ' ' + cl.Nome AS Intestatario
FROM            dbo.Conti AS ct INNER JOIN
                         dbo.Intestazioni AS i ON ct.IdConto = i.idConto INNER JOIN
                         dbo.Clienti AS cl ON i.IdCliente = cl.IdCliente
ORDER BY ct.IdConto
GO
/****** Object:  View [dbo].[ContiConSaldo]    Script Date: 12/05/2021 13:07:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[ContiConSaldo] as
select c.IdConto, c.Numero, c.DataApertura, c.Intestatario, ISNULL(sum(o.Importo), 0) as Saldo 
from ContiConIntestatari c left join Operazioni o on c.IdConto = o.IdConto
group by c.IdConto, c.Numero, c.DataApertura, c.Intestatario
GO
/****** Object:  View [dbo].[ClientiConEta]    Script Date: 12/05/2021 13:07:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[ClientiConEta] as
select *, dbo.Eta(DataDiNascita) Eta from Clienti
GO
ALTER TABLE [dbo].[Calciatori]  WITH CHECK ADD  CONSTRAINT [FK_Calciatori_Clienti] FOREIGN KEY([IdCalciatore])
REFERENCES [dbo].[Clienti] ([IdCliente])
GO
ALTER TABLE [dbo].[Calciatori] CHECK CONSTRAINT [FK_Calciatori_Clienti]
GO
ALTER TABLE [dbo].[Intestazioni]  WITH CHECK ADD  CONSTRAINT [FK_Intestazioni_Clienti] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clienti] ([IdCliente])
GO
ALTER TABLE [dbo].[Intestazioni] CHECK CONSTRAINT [FK_Intestazioni_Clienti]
GO
ALTER TABLE [dbo].[Intestazioni]  WITH CHECK ADD  CONSTRAINT [FK_Intestazioni_Conti] FOREIGN KEY([idConto])
REFERENCES [dbo].[Conti] ([IdConto])
GO
ALTER TABLE [dbo].[Intestazioni] CHECK CONSTRAINT [FK_Intestazioni_Conti]
GO
ALTER TABLE [dbo].[Operazioni]  WITH CHECK ADD  CONSTRAINT [FK_Operazioni_Conti] FOREIGN KEY([IdConto])
REFERENCES [dbo].[Conti] ([IdConto])
GO
ALTER TABLE [dbo].[Operazioni] CHECK CONSTRAINT [FK_Operazioni_Conti]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ct"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "i"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cl"
            Begin Extent = 
               Top = 102
               Left = 246
               Bottom = 232
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ContiConIntestatari'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ContiConIntestatari'
GO
USE [master]
GO
ALTER DATABASE [Banca2] SET  READ_WRITE 
GO
