USE [master]
GO
/****** Object:  Database [Travel_Agency]    Script Date: 4/2/2020 9:32:02 PM ******/
CREATE DATABASE [Travel_Agency]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Travel_Agency', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Travel_Agency.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Travel_Agency_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Travel_Agency_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Travel_Agency] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Travel_Agency].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Travel_Agency] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Travel_Agency] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Travel_Agency] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Travel_Agency] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Travel_Agency] SET ARITHABORT OFF 
GO
ALTER DATABASE [Travel_Agency] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Travel_Agency] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Travel_Agency] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Travel_Agency] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Travel_Agency] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Travel_Agency] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Travel_Agency] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Travel_Agency] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Travel_Agency] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Travel_Agency] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Travel_Agency] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Travel_Agency] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Travel_Agency] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Travel_Agency] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Travel_Agency] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Travel_Agency] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Travel_Agency] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Travel_Agency] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Travel_Agency] SET  MULTI_USER 
GO
ALTER DATABASE [Travel_Agency] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Travel_Agency] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Travel_Agency] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Travel_Agency] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Travel_Agency] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Travel_Agency] SET QUERY_STORE = OFF
GO
USE [Travel_Agency]
GO
/****** Object:  UserDefinedFunction [dbo].[checkBudget]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[checkBudget](@n real)
returns int as
begin
declare @no int
if @n>500
set @no=1
else
set @no=0
return @no
end
GO
/****** Object:  UserDefinedFunction [dbo].[checkCNP]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[checkCNP](@n bigint)
returns int as
begin
declare @no int
if @n>1000000000000 and @n<=9999999999999
set @no=1
else
set @no=0
return @no
end
GO
/****** Object:  UserDefinedFunction [dbo].[checkDate]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[checkDate](@start date, @end date)
returns int as
begin
declare @no int
if  CONVERT (date, GETDATE())   between  @start and @end
set @no=1
else
set @no=0
return @no
end
GO
/****** Object:  UserDefinedFunction [dbo].[checkVarchar]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- check a varchar
create function [dbo].[checkVarchar](@v varchar(50))
returns bit as
begin
declare @b bit
if @v LIKE '[a-z]%[a-z]'
set @b=1
else
set @b=0
return @b
end
GO
/****** Object:  Table [dbo].[Destination]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Destination](
	[dest_id] [int] IDENTITY(1,1) NOT NULL,
	[country] [varchar](50) NOT NULL,
	[city] [varchar](max) NULL,
	[type] [varchar](50) NULL,
	[price] [real] NULL,
 CONSTRAINT [PK_Destination_1] PRIMARY KEY CLUSTERED 
(
	[dest_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Restaurant]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restaurant](
	[Rid] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](500) NULL,
	[name] [varchar](50) NULL,
	[dest_id] [int] NULL,
 CONSTRAINT [pk_Restaurant] PRIMARY KEY CLUSTERED 
(
	[Rid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Review]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[dest_id] [int] NOT NULL,
	[username] [varchar](50) NOT NULL,
	[stars] [float] NOT NULL,
	[text] [varchar](max) NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[dest_id] ASC,
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Attraction]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attraction](
	[dest_id] [int] NOT NULL,
	[a_name] [varchar](50) NOT NULL,
	[type] [varchar](50) NULL,
	[description] [varchar](max) NULL,
 CONSTRAINT [PK_Attraction] PRIMARY KEY CLUSTERED 
(
	[dest_id] ASC,
	[a_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[viewDestAttr]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- show coresponding to each destination its rating and the attractions and restaurants there
create view [dbo].[viewDestAttr]
as
SELECT d.dest_id,d.country,d.city,d.type,d.price, r.stars,a.a_name,rs.name,rs.Description
from Destination d inner join Review r on d.dest_id=r.dest_id
inner join Attraction a on a.dest_id=d.dest_id
inner join Restaurant rs on rs.dest_id=d.dest_id
GO
/****** Object:  Table [dbo].[Airline]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Airline](
	[company_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Airline] PRIMARY KEY CLUSTERED 
(
	[company_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AirlineCopy]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AirlineCopy](
	[company] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[company] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[dest_id] [int] NOT NULL,
	[p_id] [bigint] NOT NULL,
	[period] [varchar](50) NULL,
 CONSTRAINT [PK_Booking_1] PRIMARY KEY CLUSTERED 
(
	[dest_id] ASC,
	[p_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DestinationCopy]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DestinationCopy](
	[dest_id] [int] NOT NULL,
	[country] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[typ] [varchar](50) NULL,
	[price] [real] NULL,
PRIMARY KEY CLUSTERED 
(
	[dest_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Flight]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Flight](
	[dest_id] [int] NOT NULL,
	[company_name] [varchar](50) NOT NULL,
	[class] [varchar](50) NOT NULL,
	[time] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Flight] PRIMARY KEY CLUSTERED 
(
	[dest_id] ASC,
	[company_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Hotel]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hotel](
	[name] [varchar](50) NOT NULL,
	[dest_id] [int] NOT NULL,
	[stars] [int] NULL,
 CONSTRAINT [PK_Hotel] PRIMARY KEY CLUSTERED 
(
	[name] ASC,
	[dest_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log](
	[l_id] [int] IDENTITY(1,1) NOT NULL,
	[trigger_date] [datetime] NULL,
	[trigger_type] [varchar](50) NULL,
	[name_of_affected_table] [varchar](50) NULL,
	[no_amd_rows] [int] NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[l_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Passport]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Passport](
	[p_id] [bigint] NOT NULL,
	[date_of_issue] [date] NULL,
	[date_of_expiration] [date] NULL,
 CONSTRAINT [PK_Passport] PRIMARY KEY CLUSTERED 
(
	[p_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[p_id] [bigint] NOT NULL,
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[budget] [real] NULL,
	[preference] [varchar](50) NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[p_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Versions]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Versions](
	[version] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Attraction]  WITH CHECK ADD  CONSTRAINT [FK_Attraction_Destination] FOREIGN KEY([dest_id])
REFERENCES [dbo].[Destination] ([dest_id])
GO
ALTER TABLE [dbo].[Attraction] CHECK CONSTRAINT [FK_Attraction_Destination]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Destination] FOREIGN KEY([dest_id])
REFERENCES [dbo].[Destination] ([dest_id])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Destination]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Person] FOREIGN KEY([p_id])
REFERENCES [dbo].[Person] ([p_id])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Person]
GO
ALTER TABLE [dbo].[Flight]  WITH CHECK ADD  CONSTRAINT [FK_Flight_Airline] FOREIGN KEY([company_name])
REFERENCES [dbo].[Airline] ([company_name])
GO
ALTER TABLE [dbo].[Flight] CHECK CONSTRAINT [FK_Flight_Airline]
GO
ALTER TABLE [dbo].[Flight]  WITH CHECK ADD  CONSTRAINT [FK_Flight_Destination] FOREIGN KEY([dest_id])
REFERENCES [dbo].[Destination] ([dest_id])
GO
ALTER TABLE [dbo].[Flight] CHECK CONSTRAINT [FK_Flight_Destination]
GO
ALTER TABLE [dbo].[Hotel]  WITH CHECK ADD  CONSTRAINT [FK_Hotel_Destination] FOREIGN KEY([dest_id])
REFERENCES [dbo].[Destination] ([dest_id])
GO
ALTER TABLE [dbo].[Hotel] CHECK CONSTRAINT [FK_Hotel_Destination]
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_Passport] FOREIGN KEY([p_id])
REFERENCES [dbo].[Passport] ([p_id])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Passport]
GO
ALTER TABLE [dbo].[Restaurant]  WITH CHECK ADD  CONSTRAINT [fk_Restaurant_Destination] FOREIGN KEY([dest_id])
REFERENCES [dbo].[Destination] ([dest_id])
GO
ALTER TABLE [dbo].[Restaurant] CHECK CONSTRAINT [fk_Restaurant_Destination]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Destination] FOREIGN KEY([dest_id])
REFERENCES [dbo].[Destination] ([dest_id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Destination]
GO
/****** Object:  StoredProcedure [dbo].[add_columns]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[add_columns]
AS
BEGIN
 -- the code
 ALTER TABLE Restaurant
 ADD name varchar(50), rating real
  
END
GO
/****** Object:  StoredProcedure [dbo].[add_fk]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[add_fk]
as
begin
ALTER TABLE Restaurant
ADD CONSTRAINT fk_Restaurant_Destination FOREIGN KEY(dest_id) REFERENCES Destination(dest_id)

end
GO
/****** Object:  StoredProcedure [dbo].[add_pk]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[add_pk]
as
begin
alter table Restaurant
add constraint pk_Restaurant primary key (Rid)
end
GO
/****** Object:  StoredProcedure [dbo].[add_table_restaurant]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[add_table_restaurant]
AS
BEGIN
 -- the code
	 CREATE TABLE Restaurant(
	Rid int NOT NULL,
	Description varchar(500)
	);

END
GO
/****** Object:  StoredProcedure [dbo].[add_version]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[add_version]
as 

begin

create table version (version int);
insert into version values (0)

end
GO
/****** Object:  StoredProcedure [dbo].[addPassport]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[addPassport] @cnp bigint, @date_of_issue date, @date_of_expiration date
AS
Begin
-- validate the parameters
if dbo.checkCNP(@cnp)=1 and dbo.checkDate(@date_of_issue,@date_of_expiration)=1
begin

INSERT INTO Passport(p_id,date_of_issue,date_of_expiration) Values (@cnp,@date_of_issue,@date_of_expiration)
print 'value added'
select * from Passport
end
else
begin
print 'the parameters are not correct'
select * from Passport
end
end
GO
/****** Object:  StoredProcedure [dbo].[addPerson]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[addPerson] @cnp bigint, @begin date,@end date, @first_name varchar(50),@last_name varchar(50), @budget real, @preference varchar(50)
AS
Begin
-- validate the parameters
if dbo.checkBudget(@budget)=1 and dbo.checkVarchar(@first_name)=1 and dbo.checkVarchar(@last_name)=1
	and dbo.checkCNP(@cnp)=1 and dbo.checkDate(@begin,@end)=1
begin

--DECLARE @cnp bigint
--SELECT TOP 1 @cnp=p_id FROM Passport
--PRINT @cnp
--SET @cnp=(SELECT Top 1 p_id FROM Passport)
--PRINT @cnp

INSERT INTO Passport(p_id,date_of_issue,date_of_expiration) Values (@cnp,@begin,@end)
INSERT INTO Person(p_id,first_name,last_name,budget,preference) Values (@cnp, @first_name,@last_name, @budget, @preference)

select * from Passport

select * from Person


end
end
GO
/****** Object:  StoredProcedure [dbo].[main]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[main]
@vers int
AS
BEGIN

 declare @current_version int = (select V.version from Versions V)
 PRINT @current_version

 while @current_version < @vers
 begin

	 IF @current_version=0
	 BEGIN
	 EXECUTE add_table_restaurant
	 DELETE FROM Versions
	 insert into Versions values (1) 
	 END

	 ELSE IF @current_version=1
	 BEGIN
	 EXECUTE add_pk
	 DELETE FROM Versions
	 insert into Versions values (2) 
	 END

	 ELSE IF @current_version=2
	 BEGIN
	 EXECUTE add_columns
	 DELETE FROM Versions
	 insert into Versions values (3) 
	 END

	 ELSE IF @current_version=3
	 BEGIN
	 EXECUTE add_fk
	 DELETE FROM Versions
	 insert into Versions values (4) 
	 END

	set @current_version = @current_version+1

	end


	
 while @current_version > @vers
 begin

	 IF @current_version=1
	 BEGIN
	 EXECUTE remove_table_restaurant
	 DELETE FROM Versions
	 insert into Versions values (0) 
	 END

	 ELSE IF @current_version=2
	 BEGIN
	 EXECUTE remove_pk
	 DELETE FROM Versions
	 insert into Versions values (1) 
	 END

	 ELSE IF @current_version=3
	 BEGIN
	 EXECUTE remove_column
	 DELETE FROM Versions
	 insert into Versions values (2) 
	 END

	 ELSE IF @current_version=4
	 BEGIN
	 EXECUTE remove_fk
	 DELETE FROM Versions
	 insert into Versions values (3) 
	 END

	set @current_version = @current_version-1

	end

 END
GO
/****** Object:  StoredProcedure [dbo].[remove_column]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[remove_column]
AS
	BEGIN

	ALTER TABLE Restaurant
	DROP COLUMN rating

	END
GO
/****** Object:  StoredProcedure [dbo].[remove_fk]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[remove_fk]
as
begin
alter table Restaurant
drop constraint fk_Restaurant_Destination
end
GO
/****** Object:  StoredProcedure [dbo].[remove_pk]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[remove_pk]
as
begin
alter table Restaurant
drop constraint pk_Restaurant 
end
GO
/****** Object:  StoredProcedure [dbo].[remove_table_restaurant]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[remove_table_restaurant]
AS
BEGIN
	DROP TABLE Restaurant
END
GO
/****** Object:  StoredProcedure [dbo].[v1]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[v1] as
select * from person

print 'msg'
print 'msg'
GO
/****** Object:  StoredProcedure [dbo].[v2]    Script Date: 4/2/2020 9:32:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[v2] as
select * from person 
GO
USE [master]
GO
ALTER DATABASE [Travel_Agency] SET  READ_WRITE 
GO
