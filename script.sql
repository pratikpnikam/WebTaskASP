USE [patientDB]
GO
/****** Object:  Table [dbo].[appointmentinfo]    Script Date: 31-03-2021 04:46:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[appointmentinfo](
	[patid] [int] NOT NULL,
	[apptid] [int] NOT NULL,
	[apptdate] [date] NOT NULL,
	[operatory] [nvarchar](50) NOT NULL,
	[provider] [nvarchar](50) NOT NULL,
	[appttime] [nvarchar](50) NOT NULL,
	[apptlength] [nvarchar](50) NOT NULL,
	[amount] [float] NOT NULL,
	[clinicid] [int] NOT NULL,
 CONSTRAINT [PK_appointmentinfo] PRIMARY KEY CLUSTERED 
(
	[patid] ASC,
	[apptid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[clinicinfo]    Script Date: 31-03-2021 04:46:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clinicinfo](
	[clinicid] [int] NOT NULL,
	[clinicname] [nvarchar](50) NOT NULL,
	[city] [nvarchar](50) NOT NULL,
	[state] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_clinicinfo] PRIMARY KEY CLUSTERED 
(
	[clinicid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[doctorinfo]    Script Date: 31-03-2021 04:46:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[doctorinfo](
	[IDNo] [int] NOT NULL,
	[lastname] [nvarchar](50) NOT NULL,
	[firstname] [nvarchar](50) NOT NULL,
	[city] [nvarchar](50) NOT NULL,
	[state] [nvarchar](50) NOT NULL,
	[clinicid] [int] NOT NULL,
 CONSTRAINT [PK_doctorinfo] PRIMARY KEY CLUSTERED 
(
	[IDNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[patientinfo]    Script Date: 31-03-2021 04:46:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[patientinfo](
	[PatID] [int] NOT NULL,
	[practiceid] [int] NOT NULL,
	[lastname] [nvarchar](50) NOT NULL,
	[firstname] [nvarchar](50) NOT NULL,
	[city] [nvarchar](50) NOT NULL,
	[state] [nvarchar](50) NOT NULL,
	[gender] [nvarchar](50) NULL,
	[patientagegroup] [nvarchar](50) NULL,
	[birthdate] [date] NOT NULL,
	[age] [int] NULL,
 CONSTRAINT [PK_patientinfo] PRIMARY KEY CLUSTERED 
(
	[PatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transactioninfo]    Script Date: 31-03-2021 04:46:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transactioninfo](
	[transid] [int] NOT NULL,
	[patid] [int] NOT NULL,
	[proceduretype] [nvarchar](50) NOT NULL,
	[proceduredate] [date] NOT NULL,
	[prov] [nvarchar](50) NOT NULL,
	[amount] [float] NOT NULL,
	[clinicid] [int] NOT NULL,
 CONSTRAINT [PK_transactioninfo] PRIMARY KEY CLUSTERED 
(
	[transid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[appointmentinfo]  WITH CHECK ADD FOREIGN KEY([clinicid])
REFERENCES [dbo].[clinicinfo] ([clinicid])
GO
ALTER TABLE [dbo].[doctorinfo]  WITH CHECK ADD FOREIGN KEY([clinicid])
REFERENCES [dbo].[clinicinfo] ([clinicid])
GO
ALTER TABLE [dbo].[patientinfo]  WITH CHECK ADD FOREIGN KEY([practiceid])
REFERENCES [dbo].[clinicinfo] ([clinicid])
GO
ALTER TABLE [dbo].[transactioninfo]  WITH CHECK ADD FOREIGN KEY([clinicid])
REFERENCES [dbo].[clinicinfo] ([clinicid])
GO
/****** Object:  StoredProcedure [dbo].[pr_query1]    Script Date: 31-03-2021 04:46:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[pr_query1]
as
begin
select clinicname,year(apptdate) as Year,month(apptdate) as Month from clinicinfo,appointmentinfo
where clinicinfo.clinicid=appointmentinfo.clinicid
group by clinicname,year(apptdate),month(apptdate);
end
GO
/****** Object:  StoredProcedure [dbo].[pr_query2]    Script Date: 31-03-2021 04:46:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[pr_query2]
as
begin
select *from patientinfo,appointmentinfo
where patientinfo.PatID=appointmentinfo.patid
and apptdate<GETDATE()
end
GO
/****** Object:  StoredProcedure [dbo].[pr_query3]    Script Date: 31-03-2021 04:46:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[pr_query3]
as
begin

update t1
set t1.age=(select DATEDIFF(YEAR,birthdate,GETDATE()) from patientinfo t2 where t2.PatID=t1.PatID)
from patientinfo t1;


update patientinfo set patientagegroup='minor'
where age<18;

update patientinfo set patientagegroup='Adult'
where age>=18;

select lastname,firstname,DATEDIFF(YEAR,birthdate,GETDATE()) as Age,patientagegroup
from patientinfo;


end
GO
/****** Object:  StoredProcedure [dbo].[pr_query4]    Script Date: 31-03-2021 04:46:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[pr_query4]
as
begin

select proceduretype,clinicname,prov,
YEAR(transactioninfo.proceduredate) as Procedur_YEAR,
month(transactioninfo.proceduredate) as Procedur_MONTH,
sum(transactioninfo.amount) as Procedur_SUM
from clinicinfo,appointmentinfo,transactioninfo
where clinicinfo.clinicid=appointmentinfo.clinicid and transactioninfo.clinicid=clinicinfo.clinicid
group by proceduretype,clinicname,prov,YEAR(transactioninfo.proceduredate),month(transactioninfo.proceduredate);


end
GO
/****** Object:  StoredProcedure [dbo].[pr_query5_part1]    Script Date: 31-03-2021 04:46:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[pr_query5_part1]
as
begin
select appointmentinfo.patid,patientinfo.firstname,patientinfo.lastname,appointmentinfo.amount from appointmentinfo,patientinfo where 
appointmentinfo.patid=patientinfo.PatID and amount<50;
end
GO
/****** Object:  StoredProcedure [dbo].[pr_query5_part2]    Script Date: 31-03-2021 04:46:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[pr_query5_part2]
as
begin

delete from appointmentinfo
where patid IN(select patid from transactioninfo where amount <50)

end
GO
