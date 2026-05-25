USE [master]
GO
/****** Object:  Database [MindSpaceDB]    Script Date: 25/5/2026 8:50:54 PM ******/
CREATE DATABASE [MindSpaceDB]
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MindSpaceDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MindSpaceDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MindSpaceDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MindSpaceDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MindSpaceDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MindSpaceDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [MindSpaceDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [MindSpaceDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MindSpaceDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MindSpaceDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MindSpaceDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MindSpaceDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MindSpaceDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MindSpaceDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MindSpaceDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MindSpaceDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MindSpaceDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MindSpaceDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MindSpaceDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MindSpaceDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MindSpaceDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MindSpaceDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MindSpaceDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MindSpaceDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MindSpaceDB] SET  MULTI_USER 
GO
ALTER DATABASE [MindSpaceDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MindSpaceDB] SET DB_CHAINING OFF 
GO
USE [MindSpaceDB]
GO
/****** Object:  Table [dbo].[Bookmarks]    Script Date: 25/5/2026 8:50:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bookmarks](
	[BookmarkID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[CourseID] [int] NOT NULL,
	[DateBookmarked] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BookmarkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BugReports]    Script Date: 25/5/2026 8:50:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BugReports](
	[ReportID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[ReportText] [nvarchar](max) NOT NULL,
	[UserAgent] [nvarchar](500) NULL,
	[DateSubmitted] [datetime] NOT NULL,
	[Status] [nvarchar](40) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 25/5/2026 8:50:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[CourseID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Category] [nvarchar](100) NULL,
	[ThumbnailURL] [nvarchar](255) NULL,
	[DifficultyLevel] [nvarchar](50) NULL,
	[Duration] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enrollments]    Script Date: 25/5/2026 8:50:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollments](
	[EnrollmentID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[CourseID] [int] NOT NULL,
	[EnrollDate] [datetime] NULL,
	[Progress] [int] NULL,
	[IsCompleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[EnrollmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ForumComments]    Script Date: 25/5/2026 8:50:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ForumComments](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[PostID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[DatePosted] [datetime] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ForumPosts]    Script Date: 25/5/2026 8:50:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ForumPosts](
	[PostID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[DatePosted] [datetime] NULL,
	[IsActive] [bit] NULL,
	[ViewCount] [int] NULL,
	[IsResolved] [bit] NOT NULL,
	[EditedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionOptions]    Script Date: 25/5/2026 8:50:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionOptions](
	[OptionID] [int] IDENTITY(1,1) NOT NULL,
	[QuestionID] [int] NOT NULL,
	[OptionLabel] [char](1) NOT NULL,
	[OptionText] [nvarchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 25/5/2026 8:50:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[QuestionID] [int] IDENTITY(1,1) NOT NULL,
	[QuizID] [int] NOT NULL,
	[QuestionText] [nvarchar](max) NOT NULL,
	[QuestionType] [nvarchar](20) NULL,
	[CorrectAnswer] [nvarchar](255) NOT NULL,
	[OrderNum] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuizResults]    Script Date: 25/5/2026 8:50:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuizResults](
	[ResultID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[QuizID] [int] NOT NULL,
	[Score] [int] NOT NULL,
	[TotalQuestions] [int] NOT NULL,
	[Percentage] [decimal](5, 2) NULL,
	[Feedback] [nvarchar](max) NULL,
	[DateTaken] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ResultID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quizzes]    Script Date: 25/5/2026 8:50:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quizzes](
	[QuizID] [int] IDENTITY(1,1) NOT NULL,
	[CourseID] [int] NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[PassingScore] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[QuizID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Resources]    Script Date: 25/5/2026 8:50:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Resources](
	[ResourceID] [int] IDENTITY(1,1) NOT NULL,
	[CourseID] [int] NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[ResourceType] [nvarchar](50) NULL,
	[Content] [nvarchar](max) NULL,
	[URL] [nvarchar](500) NULL,
	[OrderNum] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ResourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SuccessStories]    Script Date: 25/5/2026 8:50:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SuccessStories](
	[StoryID] [int] IDENTITY(1,1) NOT NULL,
	[CourseID] [int] NOT NULL,
	[UserID] [int] NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[Achievement] [nvarchar](200) NOT NULL,
	[WhatLearned] [nvarchar](max) NOT NULL,
	[Result] [nvarchar](max) NOT NULL,
	[IsApproved] [bit] NOT NULL,
	[DatePosted] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserProgress]    Script Date: 25/5/2026 8:50:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProgress](
	[ProgressID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[EventType] [nvarchar](50) NOT NULL,
	[ReferenceID] [int] NULL,
	[ProgressPct] [int] NULL,
	[ScoreValue] [decimal](5, 2) NULL,
	[MinutesSpent] [int] NOT NULL,
	[RecordedAt] [datetime] NOT NULL,
	[CourseID] [int] NULL,
	[QuizID] [int] NULL,
	[ActionType] [nvarchar](50) NULL,
	[Score] [decimal](5, 2) NULL,
	[DateCreated] [datetime] NOT NULL,
	[IsCompleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProgressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 25/5/2026 8:50:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[PasswordHash] [nvarchar](255) NOT NULL,
	[Role] [nvarchar](20) NOT NULL,
	[ProfilePicture] [nvarchar](255) NULL,
	[Bio] [nvarchar](max) NULL,
	[DateRegistered] [datetime] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bookmarks] ON 

INSERT [dbo].[Bookmarks] ([BookmarkID], [UserID], [CourseID], [DateBookmarked]) VALUES (5, 10, 10, CAST(N'2026-05-24T02:11:48.693' AS DateTime))
SET IDENTITY_INSERT [dbo].[Bookmarks] OFF
GO
SET IDENTITY_INSERT [dbo].[BugReports] ON 

INSERT [dbo].[BugReports] ([ReportID], [UserID], [ReportText], [UserAgent], [DateSubmitted], [Status]) VALUES (1, 2, N'Test bug report submitted via Playwright on the new ReportBug page.', N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', CAST(N'2026-05-20T11:15:55.900' AS DateTime), N'open')
INSERT [dbo].[BugReports] ([ReportID], [UserID], [ReportText], [UserAgent], [DateSubmitted], [Status]) VALUES (2, 10, N'ok.', N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', CAST(N'2026-05-22T17:48:24.710' AS DateTime), N'open')
INSERT [dbo].[BugReports] ([ReportID], [UserID], [ReportText], [UserAgent], [DateSubmitted], [Status]) VALUES (3, 10, N'h', N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', CAST(N'2026-05-23T23:38:09.190' AS DateTime), N'open')
SET IDENTITY_INSERT [dbo].[BugReports] OFF
GO
SET IDENTITY_INSERT [dbo].[Courses] ON 

INSERT [dbo].[Courses] ([CourseID], [Title], [Description], [Category], [ThumbnailURL], [DifficultyLevel], [Duration], [IsActive], [CreatedBy], [DateCreated]) VALUES (1, N'Stress Management Fundamentals', N'Learn evidence-based techniques to identify, manage, and reduce stress in your daily life. This course covers the science of stress, practical coping strategies, time management, and relaxation techniques.', N'Stress Management', NULL, N'Beginner', N'4 weeks', 1, 1, CAST(N'2026-05-16T17:43:06.053' AS DateTime))
INSERT [dbo].[Courses] ([CourseID], [Title], [Description], [Category], [ThumbnailURL], [DifficultyLevel], [Duration], [IsActive], [CreatedBy], [DateCreated]) VALUES (2, N'Mindfulness & Meditation', N'Explore the practice of mindfulness and meditation to cultivate present-moment awareness, reduce anxiety, and improve focus. Includes guided exercises and daily practice routines.', N'Mindfulness', NULL, N'Beginner', N'6 weeks', 1, 1, CAST(N'2026-05-16T17:43:06.053' AS DateTime))
INSERT [dbo].[Courses] ([CourseID], [Title], [Description], [Category], [ThumbnailURL], [DifficultyLevel], [Duration], [IsActive], [CreatedBy], [DateCreated]) VALUES (3, N'Understanding Anxiety', N'A comprehensive guide to understanding anxiety disorders, their causes, symptoms, and effective management strategies. Learn cognitive-behavioural techniques to challenge anxious thoughts.', N'Anxiety', NULL, N'Intermediate', N'5 weeks', 1, 1, CAST(N'2026-05-16T17:43:06.053' AS DateTime))
INSERT [dbo].[Courses] ([CourseID], [Title], [Description], [Category], [ThumbnailURL], [DifficultyLevel], [Duration], [IsActive], [CreatedBy], [DateCreated]) VALUES (4, N'Sleep Hygiene & Restoration', N'Discover the critical role of sleep in mental health and learn practical strategies to improve sleep quality, establish healthy routines, and overcome common sleep challenges.', N'Sleep Hygiene', NULL, N'Beginner', N'3 weeks', 1, 1, CAST(N'2026-05-16T17:43:06.053' AS DateTime))
INSERT [dbo].[Courses] ([CourseID], [Title], [Description], [Category], [ThumbnailURL], [DifficultyLevel], [Duration], [IsActive], [CreatedBy], [DateCreated]) VALUES (5, N'Building Emotional Resilience', N'Develop the skills to bounce back from adversity, manage difficult emotions, and thrive under pressure. This course teaches resilience frameworks used by mental health professionals.', N'Resilience', NULL, N'Intermediate', N'8 weeks', 1, 1, CAST(N'2026-05-16T17:43:06.053' AS DateTime))
INSERT [dbo].[Courses] ([CourseID], [Title], [Description], [Category], [ThumbnailURL], [DifficultyLevel], [Duration], [IsActive], [CreatedBy], [DateCreated]) VALUES (7, N'Self-Care & Emotional Wellbeing', N'Discover the science and practice of self-care as a foundation for mental health. This course covers evidence-based self-care strategies including boundary setting, emotional needs, rest and recovery, and building sustainable daily routines for lasting wellbeing.', N'Self-Care', NULL, N'Beginner', N'3 weeks', 1, NULL, CAST(N'2026-05-17T17:40:59.283' AS DateTime))
INSERT [dbo].[Courses] ([CourseID], [Title], [Description], [Category], [ThumbnailURL], [DifficultyLevel], [Duration], [IsActive], [CreatedBy], [DateCreated]) VALUES (8, N'Cognitive Behavioural Therapy Techniques', N'An advanced deep-dive into the techniques clinicians use to challenge unhelpful thinking patterns and rebuild healthier responses. Drawing on six decades of research, this course teaches the cognitive model, the major cognitive distortions, thought records, behavioural activation, and exposure-based methods you can begin applying immediately.', N'Cognitive Therapy', N'https://images.unsplash.com/photo-1593811167562-9cef47bfc4d7?w=1200', N'Advanced', N'6 weeks', 1, NULL, CAST(N'2026-05-19T14:52:07.963' AS DateTime))
INSERT [dbo].[Courses] ([CourseID], [Title], [Description], [Category], [ThumbnailURL], [DifficultyLevel], [Duration], [IsActive], [CreatedBy], [DateCreated]) VALUES (9, N'Trauma and Post-Traumatic Growth', N'Trauma rewires the nervous system, but it does not write the final story. This advanced course explores how traumatic experiences shape the brain and body, why traditional talk therapy is only part of the answer, and how meaningful growth becomes possible alongside (not instead of) the wound.', N'Trauma Recovery', N'https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=1200', N'Advanced', N'8 weeks', 1, NULL, CAST(N'2026-05-19T14:52:08.320' AS DateTime))
INSERT [dbo].[Courses] ([CourseID], [Title], [Description], [Category], [ThumbnailURL], [DifficultyLevel], [Duration], [IsActive], [CreatedBy], [DateCreated]) VALUES (10, N'Emotional Regulation and DBT Skills', N'Dialectical Behaviour Therapy (DBT) is the most rigorously studied skills-based approach to intense emotion. This advanced course teaches the four interlocking modules — mindfulness, distress tolerance, emotion regulation, and interpersonal effectiveness — and shows how to apply them in real moments of overwhelm.', N'Emotional Regulation', N'https://images.unsplash.com/photo-1518602164578-cd0074062767?w=1200', N'Advanced', N'6 weeks', 1, NULL, CAST(N'2026-05-19T14:52:08.493' AS DateTime))
SET IDENTITY_INSERT [dbo].[Courses] OFF
GO
SET IDENTITY_INSERT [dbo].[Enrollments] ON 

INSERT [dbo].[Enrollments] ([EnrollmentID], [UserID], [CourseID], [EnrollDate], [Progress], [IsCompleted]) VALUES (1, 2, 1, CAST(N'2026-05-16T17:43:06.060' AS DateTime), 100, 1)
INSERT [dbo].[Enrollments] ([EnrollmentID], [UserID], [CourseID], [EnrollDate], [Progress], [IsCompleted]) VALUES (2, 2, 2, CAST(N'2026-05-16T17:43:06.060' AS DateTime), 50, 0)
INSERT [dbo].[Enrollments] ([EnrollmentID], [UserID], [CourseID], [EnrollDate], [Progress], [IsCompleted]) VALUES (3, 3, 1, CAST(N'2026-05-16T17:43:06.060' AS DateTime), 100, 1)
INSERT [dbo].[Enrollments] ([EnrollmentID], [UserID], [CourseID], [EnrollDate], [Progress], [IsCompleted]) VALUES (4, 3, 3, CAST(N'2026-05-16T17:43:06.060' AS DateTime), 30, 0)
INSERT [dbo].[Enrollments] ([EnrollmentID], [UserID], [CourseID], [EnrollDate], [Progress], [IsCompleted]) VALUES (5, 4, 2, CAST(N'2026-05-16T17:43:06.060' AS DateTime), 60, 0)
INSERT [dbo].[Enrollments] ([EnrollmentID], [UserID], [CourseID], [EnrollDate], [Progress], [IsCompleted]) VALUES (6, 2, 3, CAST(N'2026-05-16T18:35:26.683' AS DateTime), 100, 1)
INSERT [dbo].[Enrollments] ([EnrollmentID], [UserID], [CourseID], [EnrollDate], [Progress], [IsCompleted]) VALUES (7, 9, 1, CAST(N'2026-05-17T15:18:46.480' AS DateTime), 50, 0)
INSERT [dbo].[Enrollments] ([EnrollmentID], [UserID], [CourseID], [EnrollDate], [Progress], [IsCompleted]) VALUES (8, 9, 2, CAST(N'2026-05-17T15:19:28.787' AS DateTime), 50, 0)
INSERT [dbo].[Enrollments] ([EnrollmentID], [UserID], [CourseID], [EnrollDate], [Progress], [IsCompleted]) VALUES (9, 9, 5, CAST(N'2026-05-17T15:20:25.530' AS DateTime), 50, 0)
INSERT [dbo].[Enrollments] ([EnrollmentID], [UserID], [CourseID], [EnrollDate], [Progress], [IsCompleted]) VALUES (10, 2, 7, CAST(N'2026-05-17T20:05:10.067' AS DateTime), 50, 0)
INSERT [dbo].[Enrollments] ([EnrollmentID], [UserID], [CourseID], [EnrollDate], [Progress], [IsCompleted]) VALUES (11, 10, 7, CAST(N'2026-05-18T17:28:01.700' AS DateTime), 50, 0)
INSERT [dbo].[Enrollments] ([EnrollmentID], [UserID], [CourseID], [EnrollDate], [Progress], [IsCompleted]) VALUES (17, 10, 10, CAST(N'2026-05-23T23:37:34.163' AS DateTime), 50, 0)
SET IDENTITY_INSERT [dbo].[Enrollments] OFF
GO
SET IDENTITY_INSERT [dbo].[ForumComments] ON 

INSERT [dbo].[ForumComments] ([CommentID], [PostID], [UserID], [Content], [DatePosted], [IsActive]) VALUES (1, 1, 3, N'I find the 5-minute morning meditation works great! Just sitting quietly and focusing on breathing before starting the day sets a positive tone. Also, the mindful eating practice from the course helped me be more present during meals.', CAST(N'2026-05-16T17:43:06.060' AS DateTime), 1)
INSERT [dbo].[ForumComments] ([CommentID], [PostID], [UserID], [Content], [DatePosted], [IsActive]) VALUES (2, 1, 4, N'Box breathing is my go-to! 4 counts in, 4 hold, 4 out, 4 hold. I use it during stressful moments throughout the day. Apps like Calm or Headspace also have great guided sessions if you prefer audio guidance.', CAST(N'2026-05-16T17:43:06.060' AS DateTime), 1)
INSERT [dbo].[ForumComments] ([CommentID], [PostID], [UserID], [Content], [DatePosted], [IsActive]) VALUES (3, 2, 2, N'The Pomodoro technique is a game changer! I also started keeping a worry journal - writing down anxious thoughts before studying helps clear my mind. And please remember to eat well and sleep enough - they make a huge difference!', CAST(N'2026-05-16T17:43:06.060' AS DateTime), 1)
INSERT [dbo].[ForumComments] ([CommentID], [PostID], [UserID], [Content], [DatePosted], [IsActive]) VALUES (4, 3, 2, N'Yes! I tried it last night when I couldn''t sleep. It took about 3-4 cycles but I definitely felt more relaxed. I think the key is the extended exhale which activates the parasympathetic nervous system. Really effective!', CAST(N'2026-05-16T17:43:06.060' AS DateTime), 1)
INSERT [dbo].[ForumComments] ([CommentID], [PostID], [UserID], [Content], [DatePosted], [IsActive]) VALUES (5, 1, 3, N'I find the 5-minute morning meditation works great! Just sitting quietly and focusing on breathing before starting the day sets a positive tone. Also, the mindful eating practice from the course helped me be more present during meals.', CAST(N'2026-05-23T19:59:34.357' AS DateTime), 1)
INSERT [dbo].[ForumComments] ([CommentID], [PostID], [UserID], [Content], [DatePosted], [IsActive]) VALUES (6, 1, 4, N'Box breathing is my go-to! 4 counts in, 4 hold, 4 out, 4 hold. I use it during stressful moments throughout the day. Apps like Calm or Headspace also have great guided sessions if you prefer audio guidance.', CAST(N'2026-05-23T19:59:34.357' AS DateTime), 1)
INSERT [dbo].[ForumComments] ([CommentID], [PostID], [UserID], [Content], [DatePosted], [IsActive]) VALUES (7, 2, 2, N'The Pomodoro technique is a game changer! I also started keeping a worry journal - writing down anxious thoughts before studying helps clear my mind. And please remember to eat well and sleep enough - they make a huge difference!', CAST(N'2026-05-23T19:59:34.357' AS DateTime), 1)
INSERT [dbo].[ForumComments] ([CommentID], [PostID], [UserID], [Content], [DatePosted], [IsActive]) VALUES (8, 3, 2, N'Yes! I tried it last night when I couldn''t sleep. It took about 3-4 cycles but I definitely felt more relaxed. I think the key is the extended exhale which activates the parasympathetic nervous system. Really effective!', CAST(N'2026-05-23T19:59:34.357' AS DateTime), 1)
INSERT [dbo].[ForumComments] ([CommentID], [PostID], [UserID], [Content], [DatePosted], [IsActive]) VALUES (9, 1, 3, N'I find the 5-minute morning meditation works great! Just sitting quietly and focusing on breathing before starting the day sets a positive tone. Also, the mindful eating practice from the course helped me be more present during meals.', CAST(N'2026-05-23T23:18:43.217' AS DateTime), 1)
INSERT [dbo].[ForumComments] ([CommentID], [PostID], [UserID], [Content], [DatePosted], [IsActive]) VALUES (10, 1, 4, N'Box breathing is my go-to! 4 counts in, 4 hold, 4 out, 4 hold. I use it during stressful moments throughout the day. Apps like Calm or Headspace also have great guided sessions if you prefer audio guidance.', CAST(N'2026-05-23T23:18:43.217' AS DateTime), 1)
INSERT [dbo].[ForumComments] ([CommentID], [PostID], [UserID], [Content], [DatePosted], [IsActive]) VALUES (11, 2, 2, N'The Pomodoro technique is a game changer! I also started keeping a worry journal - writing down anxious thoughts before studying helps clear my mind. And please remember to eat well and sleep enough - they make a huge difference!', CAST(N'2026-05-23T23:18:43.217' AS DateTime), 1)
INSERT [dbo].[ForumComments] ([CommentID], [PostID], [UserID], [Content], [DatePosted], [IsActive]) VALUES (12, 3, 2, N'Yes! I tried it last night when I couldn''t sleep. It took about 3-4 cycles but I definitely felt more relaxed. I think the key is the extended exhale which activates the parasympathetic nervous system. Really effective!', CAST(N'2026-05-23T23:18:43.217' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[ForumComments] OFF
GO
SET IDENTITY_INSERT [dbo].[ForumPosts] ON 

INSERT [dbo].[ForumPosts] ([PostID], [UserID], [Title], [Content], [DatePosted], [IsActive], [ViewCount], [IsResolved], [EditedAt]) VALUES (1, 2, N'What mindfulness technique works best for you?', N'Hi everyone! I''ve been struggling with exam stress lately and started practising mindfulness. I''ve tried the body scan meditation and find it helpful before bed. What techniques have worked best for you? Any tips for beginners?', CAST(N'2026-05-16T17:43:06.060' AS DateTime), 1, 0, 0, NULL)
INSERT [dbo].[ForumPosts] ([PostID], [UserID], [Title], [Content], [DatePosted], [IsActive], [ViewCount], [IsResolved], [EditedAt]) VALUES (2, 3, N'Managing anxiety during exam season - share your tips!', N'As final exams approach, I know many of us are feeling the pressure. I wanted to create a space for us to share what''s been helping us cope. For me, it''s been: 1) Breaking study sessions into 25-minute blocks (Pomodoro), 2) Daily 10-minute morning walks, and 3) Limiting caffeine after 2pm. What works for you?', CAST(N'2026-05-16T17:43:06.060' AS DateTime), 1, 0, 0, NULL)
INSERT [dbo].[ForumPosts] ([PostID], [UserID], [Title], [Content], [DatePosted], [IsActive], [ViewCount], [IsResolved], [EditedAt]) VALUES (3, 4, N'Has anyone tried the 4-7-8 breathing technique?', N'I just learned about the 4-7-8 breathing technique from the Stress Management course and I''m amazed at how quickly it works! Within a couple of minutes I feel calmer. I''ve started using it before presentations and it''s really helped with my nerves. Has anyone else tried this? What''s your experience?', CAST(N'2026-05-16T17:43:06.060' AS DateTime), 1, 0, 0, NULL)
INSERT [dbo].[ForumPosts] ([PostID], [UserID], [Title], [Content], [DatePosted], [IsActive], [ViewCount], [IsResolved], [EditedAt]) VALUES (4, 9, N'HELLO', N'HELLO', CAST(N'2026-05-17T17:22:44.037' AS DateTime), 1, 0, 0, NULL)
INSERT [dbo].[ForumPosts] ([PostID], [UserID], [Title], [Content], [DatePosted], [IsActive], [ViewCount], [IsResolved], [EditedAt]) VALUES (5, 10, N'hi', N'hi', CAST(N'2026-05-22T18:07:15.313' AS DateTime), 1, 0, 0, NULL)
INSERT [dbo].[ForumPosts] ([PostID], [UserID], [Title], [Content], [DatePosted], [IsActive], [ViewCount], [IsResolved], [EditedAt]) VALUES (12, 1, N'Positive', N'This website helps me alot..', CAST(N'2026-05-24T02:09:32.773' AS DateTime), 1, 0, 0, NULL)
SET IDENTITY_INSERT [dbo].[ForumPosts] OFF
GO
SET IDENTITY_INSERT [dbo].[QuestionOptions] ON 

INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (1, 1, N'A', N'A persistent feeling of worry about future events')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (2, 1, N'B', N'A temporary emotion only experienced by anxious people')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (3, 1, N'C', N'A sign of weakness')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (4, 1, N'D', N'Something that never goes away')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (5, 2, N'A', N'Holding your breath')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (6, 2, N'B', N'Box breathing (4-4-4-4)')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (7, 2, N'C', N'Breathing quickly')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (8, 2, N'D', N'None of the above')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (9, 3, N'A', N'2%')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (10, 3, N'B', N'5%')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (11, 3, N'C', N'19%')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (12, 3, N'D', N'50%')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (13, 4, N'A', N'Paying attention to the present moment without judgment')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (14, 4, N'B', N'Thinking about the future')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (15, 4, N'C', N'Worrying about the past')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (16, 4, N'D', N'Ignoring your surroundings')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (17, 5, N'A', N'30 minutes')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (18, 5, N'B', N'5-10 minutes')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (19, 5, N'C', N'2 hours')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (20, 5, N'D', N'Meditation time does not matter')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (21, 6, N'A', N'Only sight')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (22, 6, N'B', N'All five senses')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (23, 6, N'C', N'Only touch')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (24, 6, N'D', N'Only hearing')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (25, 7, N'A', N'Our perception of events')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (26, 7, N'B', N'The events themselves only')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (27, 7, N'C', N'Other people')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (28, 7, N'D', N'Work only')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (29, 8, N'A', N'Exercise and deep breathing')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (30, 8, N'B', N'Avoiding the problem')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (31, 8, N'C', N'Drinking alcohol')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (32, 8, N'D', N'Overworking')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (33, 9, N'A', N'Serotonin')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (34, 9, N'B', N'Cortisol')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (35, 9, N'C', N'Dopamine')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (36, 9, N'D', N'Adrenaline only')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (37, 10, N'A', N'4-5 hours')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (38, 10, N'B', N'7-9 hours')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (39, 10, N'C', N'10-12 hours')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (40, 10, N'D', N'Sleep duration does not matter')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (41, 11, N'A', N'Blue light from screens')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (42, 11, N'B', N'Caffeine')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (43, 11, N'C', N'Heavy meals')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (44, 11, N'D', N'All of the above')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (45, 12, N'A', N'75 degrees F (24 degrees C)')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (46, 12, N'B', N'65-68 degrees F (18-20 degrees C)')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (47, 12, N'C', N'80 degrees F (27 degrees C)')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (48, 12, N'D', N'Any temperature is fine')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (49, 13, N'A', N'Never feeling sad')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (50, 13, N'B', N'The ability to bounce back from adversity')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (51, 13, N'C', N'Ignoring problems')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (52, 13, N'D', N'Being emotionless')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (53, 14, N'A', N'Social support')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (54, 14, N'B', N'Self-care')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (55, 14, N'C', N'Positive thinking')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (56, 14, N'D', N'All of the above')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (57, 15, N'A', N'Journaling')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (58, 15, N'B', N'Talking to friends')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (59, 15, N'C', N'Exercise')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (60, 15, N'D', N'All of the above')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (61, 16, N'A', N'A phobia of specific objects or situations')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (62, 16, N'B', N'Anxiety that occurs only in social settings')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (63, 16, N'C', N'Persistent, excessive worry about many different areas of life')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (64, 16, N'D', N'A short-term stress response to immediate danger')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (65, 17, N'A', N'Rapid heartbeat')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (66, 17, N'B', N'Racing or intrusive thoughts')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (67, 17, N'C', N'Sweating')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (68, 17, N'D', N'Muscle tension')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (69, 18, N'A', N'Cognitive Behavioral Therapy')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (70, 18, N'B', N'Cognitive Brain Training')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (71, 18, N'C', N'Clinical Behavioral Technique')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (72, 18, N'D', N'Comprehensive Breathing Therapy')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (73, 19, N'A', N'Dopamine')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (74, 19, N'B', N'Serotonin')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (75, 19, N'C', N'Norepinephrine')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (76, 19, N'D', N'GABA')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (77, 20, N'A', N'Hippocampus')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (78, 20, N'B', N'Amygdala')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (79, 20, N'C', N'Prefrontal cortex')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (80, 20, N'D', N'Cerebellum')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (81, 21, N'A', N'Negative evaluation or judgment by others')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (82, 21, N'B', N'Open spaces')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (83, 21, N'C', N'Physical illness')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (84, 21, N'D', N'Contamination')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (85, 22, N'A', N'A mild feeling of worry lasting several days')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (86, 22, N'B', N'Persistent low mood and loss of interest')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (87, 22, N'C', N'A sudden surge of intense fear with physical symptoms peaking within minutes')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (88, 22, N'D', N'A phobic response triggered by a specific object')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (89, 23, N'A', N'Fear is internal; anxiety is external')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (90, 23, N'B', N'Fear responds to present danger; anxiety is directed toward future threats')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (91, 23, N'C', N'Fear is healthy; anxiety is always unhealthy')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (92, 23, N'D', N'There is no meaningful difference')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (93, 24, N'A', N'Cognitive Behavioral Therapy (CBT)')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (94, 24, N'B', N'Hypnotherapy')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (95, 24, N'C', N'Psychoanalysis')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (96, 24, N'D', N'Art therapy')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (97, 25, N'A', N'Avoiding feared situations permanently')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (98, 25, N'B', N'Taking medication before facing fears')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (99, 25, N'C', N'Replacing anxious thoughts with positive affirmations')
GO
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (100, 25, N'D', N'Gradually confronting feared situations until anxiety reduces')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (101, 26, N'A', N'Eliminating all negative thoughts')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (102, 26, N'B', N'Increasing the speed of the stress response')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (103, 26, N'C', N'Increasing present-moment awareness and reducing rumination')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (104, 26, N'D', N'Suppressing emotional responses')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (105, 27, N'A', N'Sleeping more than 10 hours per night')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (106, 27, N'B', N'Regular aerobic exercise')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (107, 27, N'C', N'Drinking herbal tea')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (108, 27, N'D', N'Avoiding all social situations')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (109, 28, N'A', N'Focused attention meditation')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (110, 28, N'B', N'Open monitoring meditation')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (111, 28, N'C', N'Loving-kindness meditation')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (112, 28, N'D', N'Body scan meditation')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (113, 29, N'A', N'Mindful Breathing and Stress Relief')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (114, 29, N'B', N'Mind-Body Stress Recovery')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (115, 29, N'C', N'Mindfulness-Based Stress Reduction')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (116, 29, N'D', N'Meditative Brain Self-Regulation')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (117, 30, N'A', N'Amygdala')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (118, 30, N'B', N'Prefrontal cortex')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (119, 30, N'C', N'Brain stem')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (120, 30, N'D', N'Cerebellum')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (121, 31, N'A', N'Scanning your environment for sources of danger')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (122, 31, N'B', N'Rapid movement through yoga poses')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (123, 31, N'C', N'Counting breaths from 1 to 10 repeatedly')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (124, 31, N'D', N'Systematically moving attention through different parts of the body')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (125, 32, N'A', N'Compassion and goodwill toward self and others')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (126, 32, N'B', N'Deep physical relaxation')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (127, 32, N'C', N'Focused concentration on a mantra')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (128, 32, N'D', N'Awareness of bodily sensations')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (129, 33, N'A', N'It enlarges the amygdala, improving threat detection')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (130, 33, N'B', N'It has no effect on amygdala activity')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (131, 33, N'C', N'It reduces amygdala reactivity, lowering stress responses')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (132, 33, N'D', N'It transfers amygdala function to the hippocampus')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (133, 34, N'A', N'Requires eyes to remain open at all times')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (134, 34, N'B', N'Involves observing all arising thoughts and sensations without attachment')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (135, 34, N'C', N'Uses a specific mantra or sound')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (136, 34, N'D', N'Is only practiced while walking')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (137, 35, N'A', N'The neural pathway responsible for voluntary movement')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (138, 35, N'B', N'A network activated only during sleep')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (139, 35, N'C', N'The brain system responsible for processing sensory input')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (140, 35, N'D', N'A brain network active during mind-wandering and self-referential thought')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (141, 36, N'A', N'Depression only')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (142, 36, N'B', N'Anxiety only')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (143, 36, N'C', N'Chronic pain only')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (144, 36, N'D', N'Depression, anxiety, and chronic pain')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (145, 37, N'A', N'Approaching each experience with openness, as if encountering it for the first time')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (146, 37, N'B', N'Only practicing meditation if you are a beginner')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (147, 37, N'C', N'Thinking like a child')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (148, 37, N'D', N'Starting each session with no technique')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (149, 38, N'A', N'It increases carbon dioxide levels dangerously')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (150, 38, N'B', N'It activates the parasympathetic nervous system, countering fight-or-flight')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (151, 38, N'C', N'It reduces oxygen to the brain')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (152, 38, N'D', N'It stops all anxious thoughts immediately')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (153, 39, N'A', N'4 weeks')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (154, 39, N'B', N'6 weeks')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (155, 39, N'C', N'8 weeks')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (156, 39, N'D', N'12 weeks')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (157, 40, N'A', N'A severe form of chronic stress')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (158, 40, N'B', N'Positive, motivating stress that enhances performance')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (159, 40, N'C', N'Stress caused by external events only')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (160, 40, N'D', N'The absence of any stress')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (161, 41, N'A', N'Fight-or-flight system')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (162, 41, N'B', N'Central processing system')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (163, 41, N'C', N'Rest-and-digest system')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (164, 41, N'D', N'Arousal system')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (165, 42, N'A', N'The body mobilises its resources for the first time')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (166, 42, N'B', N'The body successfully adapts and functions normally')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (167, 42, N'C', N'Stress hormones reach their peak levels')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (168, 42, N'D', N'The body''s resources are depleted and vulnerability to illness increases')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (169, 43, N'A', N'The immune system')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (170, 43, N'B', N'The digestive system')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (171, 43, N'C', N'The skeletal system')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (172, 43, N'D', N'The endocrine system')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (173, 44, N'A', N'10 minutes')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (174, 44, N'B', N'20 minutes')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (175, 44, N'C', N'25 minutes')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (176, 44, N'D', N'50 minutes')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (177, 45, N'A', N'A sudden burst of energy after rest')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (178, 45, N'B', N'A physiological state of deep rest opposite to the fight-or-flight response')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (179, 45, N'C', N'Falling asleep under stress')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (180, 45, N'D', N'A mental state of ignoring stressors')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (181, 46, N'A', N'Removes the source of stress')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (182, 46, N'B', N'Provides emotional comfort')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (183, 46, N'C', N'Offers practical help and information')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (184, 46, N'D', N'Provides emotional, informational, and practical help')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (185, 47, N'A', N'Externalising thoughts, gaining perspective, and processing emotions')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (186, 47, N'B', N'Keeping secrets away from others')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (187, 47, N'C', N'Reinforcing negative thought patterns')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (188, 47, N'D', N'Replacing physical exercise')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (189, 48, N'A', N'Rapid shallow chest breathing')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (190, 48, N'B', N'Slow, deep diaphragmatic breathing with a longer exhale than inhale')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (191, 48, N'C', N'Holding the breath for 30 seconds')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (192, 48, N'D', N'Breathing through the mouth only')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (193, 49, N'A', N'Denying that a stressor exists')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (194, 49, N'B', N'Avoiding thinking about the stressor')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (195, 49, N'C', N'Changing how you interpret or assign meaning to a stressful situation')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (196, 49, N'D', N'Expressing anger toward the stressor')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (197, 50, N'A', N'20-30%')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (198, 50, N'B', N'40-50%')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (199, 50, N'C', N'55-65%')
GO
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (200, 50, N'D', N'75-90%')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (201, 51, N'A', N'Systematically tensing and releasing muscle groups to reduce physical tension')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (202, 51, N'B', N'Stretching muscles as far as possible and holding')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (203, 51, N'C', N'Massaging each muscle group for 5 minutes')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (204, 51, N'D', N'Applying heat packs to tense muscles')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (205, 52, N'A', N'Physical repair of muscles and tissues')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (206, 52, N'B', N'Releasing growth hormone')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (207, 52, N'C', N'Memory consolidation and emotional processing')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (208, 52, N'D', N'Detoxifying the liver')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (209, 53, N'A', N'The total number of hours slept')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (210, 53, N'B', N'The time it takes to fall asleep after lights out')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (211, 53, N'C', N'The number of times you wake during the night')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (212, 53, N'D', N'The duration of REM sleep')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (213, 54, N'A', N'Melatonin')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (214, 54, N'B', N'Cortisol')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (215, 54, N'C', N'Insulin')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (216, 54, N'D', N'Adrenaline')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (217, 55, N'A', N'1 night per week')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (218, 55, N'B', N'2 nights per week')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (219, 55, N'C', N'2-3 nights per week with mild daytime impact')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (220, 55, N'D', N'3 or more nights per week for at least 3 months')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (221, 56, N'A', N'Excessive daytime sleepiness without nighttime disturbances')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (222, 56, N'B', N'Repeated pauses in breathing during sleep, often with snoring')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (223, 56, N'C', N'Difficulty falling asleep due to racing thoughts')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (224, 56, N'D', N'Walking or talking during sleep')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (225, 57, N'A', N'1 hour before bed')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (226, 57, N'B', N'2-3 hours before bed')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (227, 57, N'C', N'6 hours before bed')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (228, 57, N'D', N'Caffeine has no effect on sleep')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (229, 58, N'A', N'24 hours')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (230, 58, N'B', N'12 hours')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (231, 58, N'C', N'48 hours')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (232, 58, N'D', N'It varies widely between individuals')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (233, 59, N'A', N'Stage 1 (N1) - light sleep')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (234, 59, N'B', N'Stage 2 (N2) - sleep spindles')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (235, 59, N'C', N'REM sleep')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (236, 59, N'D', N'Stage 3 (N3) - slow-wave or deep sleep')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (237, 60, N'A', N'Causing eye strain that makes falling asleep painful')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (238, 60, N'B', N'Suppressing melatonin production, signalling the brain it is still daytime')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (239, 60, N'C', N'Increasing body temperature')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (240, 60, N'D', N'Stimulating the digestive system')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (241, 61, N'A', N'Prescribing sleep medication')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (242, 61, N'B', N'Eliminating all daytime activities')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (243, 61, N'C', N'Changing thoughts, beliefs, and behaviours that interfere with quality sleep')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (244, 61, N'D', N'Increasing time spent in bed to force more sleep')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (245, 62, N'A', N'10-20 minutes (power nap)')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (246, 62, N'B', N'45-60 minutes')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (247, 62, N'C', N'90-120 minutes')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (248, 62, N'D', N'Duration does not matter as long as you feel rested')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (249, 63, N'A', N'It allows you to maximise total time in bed')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (250, 63, N'B', N'It ensures you always feel rested immediately upon waking')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (251, 63, N'C', N'It reduces the need for melatonin')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (252, 63, N'D', N'It anchors the circadian rhythm, making it easier to fall and stay asleep')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (253, 64, N'A', N'Abraham Maslow')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (254, 64, N'B', N'Martin Seligman')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (255, 64, N'C', N'Viktor Frankl')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (256, 64, N'D', N'Carl Rogers')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (257, 65, N'A', N'The inevitable psychological damage caused by trauma')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (258, 65, N'B', N'A return to baseline functioning after a traumatic event')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (259, 65, N'C', N'Positive psychological change and personal development following adversity')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (260, 65, N'D', N'A therapeutic technique for treating PTSD')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (261, 66, N'A', N'Managing the intensity, duration, and expression of emotions adaptively')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (262, 66, N'B', N'Suppressing all negative emotions')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (263, 66, N'C', N'Only experiencing positive emotions')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (264, 66, N'D', N'Avoiding situations that trigger emotions')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (265, 67, N'A', N'Requires you to feel better than others')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (266, 67, N'B', N'Depends on achieving goals')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (267, 67, N'C', N'Is only relevant during moments of success')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (268, 67, N'D', N'Does not depend on performance, comparison, or outcome')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (269, 68, N'A', N'High income')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (270, 68, N'B', N'Strong social support and meaningful work')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (271, 68, N'C', N'Working fewer than 30 hours per week')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (272, 68, N'D', N'Having a high IQ')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (273, 69, N'A', N'The time frame in which trauma therapy is most effective')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (274, 69, N'B', N'A person''s ability to tolerate physical pain')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (275, 69, N'C', N'The optimal zone of arousal in which a person can function and process experience')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (276, 69, N'D', N'The maximum duration of a therapy session')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (277, 70, N'A', N'The brain can reorganise, form new connections, and adapt following adversity')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (278, 70, N'B', N'The brain shrinks in size when stressed, improving efficiency')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (279, 70, N'C', N'Neuroplasticity only occurs in children')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (280, 70, N'D', N'New neurons can be created through willpower alone')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (281, 71, N'A', N'Eliminating negative experiences from memory')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (282, 71, N'B', N'Increasing financial security')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (283, 71, N'C', N'Replacing the need for social support')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (284, 71, N'D', N'Shifting attention toward positive aspects of life and broadening perspective')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (285, 72, N'A', N'Anxiety Control Therapy')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (286, 72, N'B', N'Acceptance and Commitment Therapy')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (287, 72, N'C', N'Adaptive Coping Technique')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (288, 72, N'D', N'Arousal Control Training')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (289, 73, N'A', N'Changing your core values based on circumstances')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (290, 73, N'B', N'Avoiding difficult thoughts and emotions')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (291, 73, N'C', N'Adapting behaviour in alignment with values despite difficult thoughts or feelings')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (292, 73, N'D', N'Achieving complete emotional stability at all times')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (293, 74, N'A', N'Reinterpreting the meaning of a situation to change its emotional impact')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (294, 74, N'B', N'Suppressing the expression of an emotion while still feeling it')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (295, 74, N'C', N'Removing yourself physically from a stressful situation')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (296, 74, N'D', N'Seeking distraction through entertainment')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (297, 75, N'A', N'Are less important than managing negative emotions')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (298, 75, N'B', N'Only affect mood, not behaviour or cognition')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (299, 75, N'C', N'Indicate a lack of awareness of real problems')
GO
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (300, 75, N'D', N'Broaden thinking and awareness, helping build lasting personal resources over time')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (301, 76, N'A', N'Relying on healthcare professionals for all health decisions')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (302, 76, N'B', N'Avoiding illness through isolation')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (303, 76, N'C', N'The ability of individuals to promote health and cope with illness with or without professional support')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (304, 76, N'D', N'Taking vitamins and supplements daily')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (305, 77, N'A', N'Physical')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (306, 77, N'B', N'Emotional')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (307, 77, N'C', N'Spiritual')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (308, 77, N'D', N'Financial investment')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (309, 78, N'A', N'Increased productivity')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (310, 78, N'B', N'Burnout, compassion fatigue, and impaired emotional regulation')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (311, 78, N'C', N'Better focus and efficiency')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (312, 78, N'D', N'Stronger immune function')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (313, 79, N'A', N'You must take care of yourself before you can effectively care for others')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (314, 79, N'B', N'Deep breathing is the most important self-care practice')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (315, 79, N'C', N'Self-care should only be practised in emergencies')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (316, 79, N'D', N'Physical health always comes before emotional health')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (317, 80, N'A', N'Happy, Active, Lively, Tired')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (318, 80, N'B', N'Healthy, Alert, Logical, Thankful')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (319, 80, N'C', N'Hungry, Angry, Lonely, Tired')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (320, 80, N'D', N'Hopeful, Anxious, Lost, Troubled')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (321, 81, N'A', N'Never saying yes to any request')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (322, 81, N'B', N'Clearly communicating your limits to protect your wellbeing and relationships')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (323, 81, N'C', N'Avoiding all social contact')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (324, 81, N'D', N'Doing whatever others ask to avoid conflict')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (325, 82, N'A', N'The stomach produces serotonin independently of the brain')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (326, 82, N'B', N'Eating habits have no proven effect on mood')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (327, 82, N'C', N'The gut only affects digestion, not mental health')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (328, 82, N'D', N'What you eat directly affects neurotransmitter production and emotional wellbeing')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (329, 83, N'A', N'Reducing constant stimulation that activates the stress response and prevents mental recovery')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (330, 83, N'B', N'Eliminating the need for social interaction')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (331, 83, N'C', N'Improving physical fitness')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (332, 83, N'D', N'Increasing work productivity')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (333, 84, N'A', N'Regular sleep')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (334, 84, N'B', N'Balanced nutrition')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (335, 84, N'C', N'Consistent physical activity')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (336, 84, N'D', N'All of the above')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (337, 85, N'A', N'Suppressing difficult feelings to stay positive')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (338, 85, N'B', N'Recognising, accepting, and healthily expressing your emotions')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (339, 85, N'C', N'Avoiding all situations that cause negative emotions')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (340, 85, N'D', N'Seeking validation from others for all decisions')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (341, 86, N'A', N'Working as many hours as possible to succeed')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (342, 86, N'B', N'Keeping work and personal life completely separate at all times')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (343, 86, N'C', N'Maintaining a sustainable work-life balance and finding meaning in your work')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (344, 86, N'D', N'Avoiding promotion to reduce responsibility')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (345, 87, N'A', N'It increases appetite and caloric intake')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (346, 87, N'B', N'It reduces the need for social interaction')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (347, 87, N'C', N'It guarantees success in academic and professional life')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (348, 87, N'D', N'It restores the brain, regulates mood, and supports immune function')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (349, 88, N'A', N'Self-compassion reduces self-criticism and supports the motivation to practise self-care')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (350, 88, N'B', N'Self-compassion is self-indulgent and reduces motivation')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (351, 88, N'C', N'Self-care only involves physical activities')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (352, 88, N'D', N'Self-compassion requires comparing yourself favourably to others')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (353, 89, N'A', N'Spending all your free time with others')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (354, 89, N'B', N'Nurturing meaningful relationships and setting limits on draining interactions')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (355, 89, N'C', N'Avoiding conflict at all costs')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (356, 89, N'D', N'Only socialising with people who agree with you')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (357, 90, N'A', N'Taking a two-week holiday every month')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (358, 90, N'B', N'Quitting your job to reduce stress')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (359, 90, N'C', N'A 5-minute breathing exercise, gratitude journaling, or a short outdoor walk')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (360, 90, N'D', N'Sleeping 12 hours per day')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (361, 91, N'A', N'Sigmund Freud')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (362, 91, N'B', N'Aaron T. Beck')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (363, 91, N'C', N'Carl Rogers')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (364, 91, N'D', N'B. F. Skinner')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (365, 92, N'A', N'Events directly cause emotions')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (366, 92, N'B', N'Emotions cannot be controlled')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (367, 92, N'C', N'The meaning we assign to events shapes our emotional response')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (368, 92, N'D', N'Genetic predisposition determines mood')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (369, 93, N'A', N'I am going to fail this exam')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (370, 93, N'B', N'A general theory of mind')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (371, 93, N'C', N'An exposure hierarchy')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (372, 93, N'D', N'A genetic marker')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (373, 94, N'A', N'Ignoring the negative')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (374, 94, N'B', N'Predicting the worst possible outcome and treating it as inevitable')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (375, 94, N'C', N'Seeing only the bright side')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (376, 94, N'D', N'Avoiding all risk')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (377, 95, N'A', N'Personalisation')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (378, 95, N'B', N'Should statements')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (379, 95, N'C', N'Labelling')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (380, 95, N'D', N'Mind-reading')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (381, 96, N'A', N'To track sleep patterns')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (382, 96, N'B', N'To slow a thought down, examine its evidence, and generate a balanced alternative')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (383, 96, N'C', N'To replace all negative thoughts with positive ones')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (384, 96, N'D', N'To list daily achievements')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (385, 97, N'A', N'Generalised anxiety disorder')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (386, 97, N'B', N'Specific phobia')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (387, 97, N'C', N'Depression')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (388, 97, N'D', N'OCD')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (389, 98, N'A', N'A list of feared situations from least to most anxiety-provoking, approached gradually')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (390, 98, N'B', N'A daily mood diary')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (391, 98, N'C', N'A medication dosing schedule')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (392, 98, N'D', N'A relaxation script')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (393, 99, N'A', N'One-way, top-down')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (394, 99, N'B', N'One-way, bottom-up')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (395, 99, N'C', N'Independent of each other')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (396, 99, N'D', N'Bidirectional and mutually reinforcing')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (397, 100, N'A', N'You are wrong to think that')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (398, 100, N'B', N'What evidence supports that thought, and what evidence might point another way?')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (399, 100, N'C', N'Just stop thinking about it')
GO
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (400, 100, N'D', N'You should not feel that way')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (401, 101, N'A', N'Therapist and client work together as scientists testing thoughts against evidence')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (402, 101, N'B', N'The therapist dictates the treatment plan')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (403, 101, N'C', N'The client works alone between sessions')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (404, 101, N'D', N'Treatment is decided by majority vote in group therapy')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (405, 102, N'A', N'The therapist''s age')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (406, 102, N'B', N'The number of sessions per week')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (407, 102, N'C', N'Consistent between-session practice (homework)')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (408, 102, N'D', N'The client''s IQ')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (409, 103, N'A', N'Past, present, and future events')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (410, 103, N'B', N'Self, world, and future')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (411, 103, N'C', N'Parents, partner, and peers')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (412, 103, N'D', N'Work, money, and health')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (413, 104, N'A', N'1 to 2')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (414, 104, N'B', N'3 to 5')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (415, 104, N'C', N'12 to 20')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (416, 104, N'D', N'100 or more')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (417, 105, N'A', N'To eliminate all negative thoughts permanently')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (418, 105, N'B', N'To convince yourself that everything is fine')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (419, 105, N'C', N'To avoid all distressing situations')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (420, 105, N'D', N'To replace distorted thoughts with more balanced, evidence-based alternatives')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (421, 106, N'A', N'Bessel van der Kolk')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (422, 106, N'B', N'Aaron Beck')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (423, 106, N'C', N'Carl Rogers')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (424, 106, N'D', N'Sigmund Freud')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (425, 107, N'A', N'Cerebellum')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (426, 107, N'B', N'Hippocampus')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (427, 107, N'C', N'Pineal gland')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (428, 107, N'D', N'Visual cortex')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (429, 108, N'A', N'Hippocampus')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (430, 108, N'B', N'Prefrontal cortex')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (431, 108, N'C', N'Amygdala')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (432, 108, N'D', N'Basal ganglia')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (433, 109, N'A', N'Daniel Siegel')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (434, 109, N'B', N'Stephen Porges')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (435, 109, N'C', N'Peter Levine')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (436, 109, N'D', N'Pat Ogden')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (437, 110, N'A', N'Ventral vagal')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (438, 110, N'B', N'Sympathetic')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (439, 110, N'C', N'Dorsal vagal')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (440, 110, N'D', N'Parasympathetic ventral')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (441, 111, N'A', N'Tedeschi and Calhoun')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (442, 111, N'B', N'Beck and Ellis')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (443, 111, N'C', N'Linehan and Hayes')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (444, 111, N'D', N'Seligman and Csikszentmihalyi')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (445, 112, N'A', N'Personal strength')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (446, 112, N'B', N'Appreciation of life')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (447, 112, N'C', N'New possibilities')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (448, 112, N'D', N'Financial success')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (449, 113, N'A', N'Within days of the event')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (450, 113, N'B', N'Only after professional therapy')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (451, 113, N'C', N'Six to twenty-four months after the event, with deliberate processing')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (452, 113, N'D', N'Only in people who never experienced distress')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (453, 114, N'A', N'Medication for PTSD')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (454, 114, N'B', N'Expressive writing about trauma')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (455, 114, N'C', N'Eye-movement protocols')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (456, 114, N'D', N'Group hypnosis')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (457, 115, N'A', N'Insight alone is usually not enough')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (458, 115, N'B', N'Safety must be established before deep processing')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (459, 115, N'C', N'Pacing matters profoundly')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (460, 115, N'D', N'Pushing harder produces faster recovery')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (461, 116, N'A', N'Ventral vagal')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (462, 116, N'B', N'Sympathetic')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (463, 116, N'C', N'Dorsal vagal')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (464, 116, N'D', N'Parasympathetic dominance')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (465, 117, N'A', N'The zone of arousal in which a person can think and feel without becoming overwhelmed')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (466, 117, N'B', N'The time available before a trauma occurs')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (467, 117, N'C', N'A measure of pain tolerance')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (468, 117, N'D', N'The amount of light tolerated after a head injury')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (469, 118, N'A', N'Cognitive analytic therapy')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (470, 118, N'B', N'Pure psychoanalysis')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (471, 118, N'C', N'Somatic Experiencing')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (472, 118, N'D', N'Behavioural activation')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (473, 119, N'A', N'Never coexist')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (474, 119, N'B', N'Only occur in sequence — distress first, then growth')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (475, 119, N'C', N'Coexist; survivors can carry grief and renewed meaning simultaneously')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (476, 119, N'D', N'Only appear after the symptoms are eliminated')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (477, 120, N'A', N'It eliminates traumatic memories')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (478, 120, N'B', N'It anchors the nervous system in the present, expanding the window of tolerance')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (479, 120, N'C', N'It is a form of medication')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (480, 120, N'D', N'It guarantees full recovery')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (481, 121, N'A', N'Aaron Beck')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (482, 121, N'B', N'Carl Jung')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (483, 121, N'C', N'Marsha Linehan')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (484, 121, N'D', N'Steven Hayes')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (485, 122, N'A', N'The zone of arousal in which a person can think and feel clearly')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (486, 122, N'B', N'Time spent meditating per day')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (487, 122, N'C', N'How much pain a person can bear')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (488, 122, N'D', N'The lifetime risk of mental illness')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (489, 123, N'A', N'Racing heart')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (490, 123, N'B', N'Numbness and dissociation')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (491, 123, N'C', N'Hypervigilance')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (492, 123, N'D', N'Aggressive urges')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (493, 124, N'A', N'Free association')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (494, 124, N'B', N'Dream interpretation')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (495, 124, N'C', N'Hypnosis')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (496, 124, N'D', N'Distress tolerance')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (497, 125, N'A', N'Temperature, Intense exercise, Paced breathing, Paired muscle relaxation')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (498, 125, N'B', N'Therapy, Insight, Patience, Practice')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (499, 125, N'C', N'Touch, Image, Posture, Process')
GO
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (500, 125, N'D', N'Talk, Identify, Plan, Proceed')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (501, 126, N'A', N'Past and future')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (502, 126, N'B', N'Self and other')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (503, 126, N'C', N'Emotion mind and reason mind')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (504, 126, N'D', N'Conscious and unconscious')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (505, 127, N'A', N'GIVE')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (506, 127, N'B', N'DEAR MAN')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (507, 127, N'C', N'PLEASE')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (508, 127, N'D', N'STOP')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (509, 128, N'A', N'The emotion fits the facts and acting on it would help')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (510, 128, N'B', N'You are in crisis')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (511, 128, N'C', N'The emotion does not fit the facts or acting on it would not help')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (512, 128, N'D', N'You are physically ill')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (513, 129, N'A', N'Approving of what happened')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (514, 129, N'B', N'Pretending the situation is fine')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (515, 129, N'C', N'Trying harder to change reality')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (516, 129, N'D', N'Acknowledging reality as it is without endorsing it')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (517, 130, N'A', N'Social communication')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (518, 130, N'B', N'Biological vulnerabilities that affect emotion (sleep, food, exercise, illness, substances)')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (519, 130, N'C', N'Trauma processing')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (520, 130, N'D', N'Crisis management')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (521, 131, N'A', N'Biology alone')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (522, 131, N'B', N'A combination of biological vulnerability and an invalidating environment')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (523, 131, N'C', N'Lack of intelligence')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (524, 131, N'D', N'Bad luck')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (525, 132, N'A', N'Two sessions')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (526, 132, N'B', N'Three months')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (527, 132, N'C', N'Twelve months')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (528, 132, N'D', N'Ten years')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (529, 133, N'A', N'Acceptance and change')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (530, 133, N'B', N'Right and wrong')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (531, 133, N'C', N'Past and present')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (532, 133, N'D', N'Mind and body')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (533, 134, N'A', N'Prevent panic attacks permanently')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (534, 134, N'B', N'Pause before acting on a destructive impulse')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (535, 134, N'C', N'End a conversation politely')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (536, 134, N'D', N'Stop unwanted thoughts immediately')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (537, 135, N'A', N'It eliminates difficult emotions')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (538, 135, N'B', N'It replaces medication')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (539, 135, N'C', N'It is the easiest module')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (540, 135, N'D', N'It widens the gap between feeling and reaction, making other skills usable')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (601, 1, N'A', N'A persistent feeling of worry about future events')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (602, 1, N'B', N'A temporary emotion only experienced by anxious people')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (603, 1, N'C', N'A sign of weakness')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (604, 1, N'D', N'Something that never goes away')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (605, 2, N'A', N'Holding your breath')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (606, 2, N'B', N'Box breathing (4-4-4-4)')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (607, 2, N'C', N'Breathing quickly')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (608, 2, N'D', N'None of the above')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (609, 3, N'A', N'2%')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (610, 3, N'B', N'5%')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (611, 3, N'C', N'19%')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (612, 3, N'D', N'50%')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (613, 4, N'A', N'Paying attention to the present moment without judgment')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (614, 4, N'B', N'Thinking about the future')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (615, 4, N'C', N'Worrying about the past')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (616, 4, N'D', N'Ignoring your surroundings')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (617, 5, N'A', N'30 minutes')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (618, 5, N'B', N'5-10 minutes')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (619, 5, N'C', N'2 hours')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (620, 5, N'D', N'Meditation time does not matter')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (621, 6, N'A', N'Only sight')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (622, 6, N'B', N'All five senses')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (623, 6, N'C', N'Only touch')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (624, 6, N'D', N'Only hearing')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (625, 7, N'A', N'Our perception of events')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (626, 7, N'B', N'The events themselves only')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (627, 7, N'C', N'Other people')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (628, 7, N'D', N'Work only')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (629, 8, N'A', N'Exercise and deep breathing')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (630, 8, N'B', N'Avoiding the problem')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (631, 8, N'C', N'Drinking alcohol')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (632, 8, N'D', N'Overworking')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (633, 9, N'A', N'Serotonin')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (634, 9, N'B', N'Cortisol')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (635, 9, N'C', N'Dopamine')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (636, 9, N'D', N'Adrenaline only')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (637, 10, N'A', N'4-5 hours')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (638, 10, N'B', N'7-9 hours')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (639, 10, N'C', N'10-12 hours')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (640, 10, N'D', N'Sleep duration does not matter')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (641, 11, N'A', N'Blue light from screens')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (642, 11, N'B', N'Caffeine')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (643, 11, N'C', N'Heavy meals')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (644, 11, N'D', N'All of the above')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (645, 12, N'A', N'75 degrees F (24 degrees C)')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (646, 12, N'B', N'65-68 degrees F (18-20 degrees C)')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (647, 12, N'C', N'80 degrees F (27 degrees C)')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (648, 12, N'D', N'Any temperature is fine')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (649, 13, N'A', N'Never feeling sad')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (650, 13, N'B', N'The ability to bounce back from adversity')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (651, 13, N'C', N'Ignoring problems')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (652, 13, N'D', N'Being emotionless')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (653, 14, N'A', N'Social support')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (654, 14, N'B', N'Self-care')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (655, 14, N'C', N'Positive thinking')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (656, 14, N'D', N'All of the above')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (657, 15, N'A', N'Journaling')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (658, 15, N'B', N'Talking to friends')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (659, 15, N'C', N'Exercise')
GO
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (660, 15, N'D', N'All of the above')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (661, 1, N'A', N'A persistent feeling of worry about future events')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (662, 1, N'B', N'A temporary emotion only experienced by anxious people')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (663, 1, N'C', N'A sign of weakness')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (664, 1, N'D', N'Something that never goes away')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (665, 2, N'A', N'Holding your breath')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (666, 2, N'B', N'Box breathing (4-4-4-4)')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (667, 2, N'C', N'Breathing quickly')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (668, 2, N'D', N'None of the above')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (669, 3, N'A', N'2%')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (670, 3, N'B', N'5%')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (671, 3, N'C', N'19%')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (672, 3, N'D', N'50%')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (673, 4, N'A', N'Paying attention to the present moment without judgment')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (674, 4, N'B', N'Thinking about the future')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (675, 4, N'C', N'Worrying about the past')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (676, 4, N'D', N'Ignoring your surroundings')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (677, 5, N'A', N'30 minutes')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (678, 5, N'B', N'5-10 minutes')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (679, 5, N'C', N'2 hours')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (680, 5, N'D', N'Meditation time does not matter')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (681, 6, N'A', N'Only sight')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (682, 6, N'B', N'All five senses')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (683, 6, N'C', N'Only touch')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (684, 6, N'D', N'Only hearing')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (685, 7, N'A', N'Our perception of events')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (686, 7, N'B', N'The events themselves only')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (687, 7, N'C', N'Other people')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (688, 7, N'D', N'Work only')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (689, 8, N'A', N'Exercise and deep breathing')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (690, 8, N'B', N'Avoiding the problem')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (691, 8, N'C', N'Drinking alcohol')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (692, 8, N'D', N'Overworking')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (693, 9, N'A', N'Serotonin')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (694, 9, N'B', N'Cortisol')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (695, 9, N'C', N'Dopamine')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (696, 9, N'D', N'Adrenaline only')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (697, 10, N'A', N'4-5 hours')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (698, 10, N'B', N'7-9 hours')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (699, 10, N'C', N'10-12 hours')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (700, 10, N'D', N'Sleep duration does not matter')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (701, 11, N'A', N'Blue light from screens')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (702, 11, N'B', N'Caffeine')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (703, 11, N'C', N'Heavy meals')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (704, 11, N'D', N'All of the above')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (705, 12, N'A', N'75 degrees F (24 degrees C)')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (706, 12, N'B', N'65-68 degrees F (18-20 degrees C)')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (707, 12, N'C', N'80 degrees F (27 degrees C)')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (708, 12, N'D', N'Any temperature is fine')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (709, 13, N'A', N'Never feeling sad')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (710, 13, N'B', N'The ability to bounce back from adversity')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (711, 13, N'C', N'Ignoring problems')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (712, 13, N'D', N'Being emotionless')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (713, 14, N'A', N'Social support')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (714, 14, N'B', N'Self-care')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (715, 14, N'C', N'Positive thinking')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (716, 14, N'D', N'All of the above')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (717, 15, N'A', N'Journaling')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (718, 15, N'B', N'Talking to friends')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (719, 15, N'C', N'Exercise')
INSERT [dbo].[QuestionOptions] ([OptionID], [QuestionID], [OptionLabel], [OptionText]) VALUES (720, 15, N'D', N'All of the above')
SET IDENTITY_INSERT [dbo].[QuestionOptions] OFF
GO
SET IDENTITY_INSERT [dbo].[Questions] ON 

INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (1, 1, N'What is anxiety?', N'multiple_choice', N'A', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (2, 1, N'Which breathing technique helps reduce anxiety?', N'multiple_choice', N'B', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (3, 1, N'Anxiety disorder affects what percentage of adults?', N'multiple_choice', N'C', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (4, 2, N'What is mindfulness?', N'multiple_choice', N'A', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (5, 2, N'How long should beginners meditate daily?', N'multiple_choice', N'B', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (6, 2, N'Which sense is commonly used in grounding technique 5-4-3-2-1?', N'multiple_choice', N'B', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (7, 3, N'What is the main cause of stress?', N'multiple_choice', N'A', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (8, 3, N'Which of these is a healthy stress management technique?', N'multiple_choice', N'A', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (9, 3, N'What is the stress hormone called?', N'multiple_choice', N'B', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (10, 4, N'How many hours of sleep does an adult need?', N'multiple_choice', N'B', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (11, 4, N'What should you avoid before bed?', N'multiple_choice', N'D', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (12, 4, N'What is the best room temperature for sleep?', N'multiple_choice', N'B', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (13, 5, N'What is emotional resilience?', N'multiple_choice', N'B', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (14, 5, N'Which factor builds emotional resilience?', N'multiple_choice', N'D', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (15, 5, N'What is a healthy coping mechanism?', N'multiple_choice', N'D', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (16, 1, N'What is Generalized Anxiety Disorder (GAD)?', N'multiple_choice', N'C', 4)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (17, 1, N'Which of the following is a cognitive symptom of anxiety?', N'multiple_choice', N'B', 5)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (18, 1, N'CBT stands for?', N'multiple_choice', N'A', 6)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (19, 1, N'Which neurotransmitter, when low, is most associated with anxiety?', N'multiple_choice', N'D', 7)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (20, 1, N'The fight-or-flight response is triggered by which brain structure?', N'multiple_choice', N'B', 8)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (21, 1, N'Social anxiety disorder primarily involves fear of?', N'multiple_choice', N'A', 9)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (22, 1, N'What best describes a panic attack?', N'multiple_choice', N'C', 10)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (23, 1, N'What is the key difference between fear and anxiety?', N'multiple_choice', N'B', 11)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (24, 1, N'Which therapy has the strongest evidence base for treating anxiety disorders?', N'multiple_choice', N'A', 12)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (25, 1, N'Exposure therapy for anxiety works by?', N'multiple_choice', N'D', 13)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (26, 1, N'Mindfulness helps reduce anxiety primarily by?', N'multiple_choice', N'C', 14)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (27, 1, N'Which lifestyle factor most significantly reduces anxiety symptoms over time?', N'multiple_choice', N'B', 15)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (28, 2, N'What type of meditation focuses sustained attention on a single object such as the breath?', N'multiple_choice', N'A', 4)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (29, 2, N'MBSR stands for?', N'multiple_choice', N'C', 5)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (30, 2, N'Research shows that regular meditation practice increases grey matter density in which brain region?', N'multiple_choice', N'B', 6)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (31, 2, N'Body scan meditation involves?', N'multiple_choice', N'D', 7)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (32, 2, N'Loving-kindness (Metta) meditation is primarily designed to cultivate?', N'multiple_choice', N'A', 8)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (33, 2, N'How does regular mindfulness practice affect the amygdala?', N'multiple_choice', N'C', 9)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (34, 2, N'Open monitoring meditation differs from focused attention meditation in that it?', N'multiple_choice', N'B', 10)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (35, 2, N'What is the default mode network (DMN)?', N'multiple_choice', N'D', 11)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (36, 2, N'Research shows mindfulness-based interventions reduce symptoms of?', N'multiple_choice', N'D', 12)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (37, 2, N'What does "beginner''s mind" mean in mindfulness practice?', N'multiple_choice', N'A', 13)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (38, 2, N'Slow, mindful breathing reduces anxiety because?', N'multiple_choice', N'B', 14)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (39, 2, N'A standard MBSR program is how many weeks long?', N'multiple_choice', N'C', 15)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (40, 3, N'What is eustress?', N'multiple_choice', N'B', 4)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (41, 3, N'The parasympathetic nervous system is also called?', N'multiple_choice', N'C', 5)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (42, 3, N'In Selye''s General Adaptation Syndrome, what happens during the Exhaustion stage?', N'multiple_choice', N'D', 6)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (43, 3, N'Chronic stress most directly suppresses which body system?', N'multiple_choice', N'A', 7)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (44, 3, N'The Pomodoro Technique is a time management method that uses work intervals of?', N'multiple_choice', N'C', 8)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (45, 3, N'The relaxation response, described by Dr. Herbert Benson, is best defined as?', N'multiple_choice', N'B', 9)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (46, 3, N'Social support reduces stress because it?', N'multiple_choice', N'D', 10)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (47, 3, N'Expressive journaling reduces stress primarily by?', N'multiple_choice', N'A', 11)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (48, 3, N'Which breathing pattern most effectively activates the relaxation response?', N'multiple_choice', N'B', 12)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (49, 3, N'Cognitive reframing helps manage stress by?', N'multiple_choice', N'C', 13)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (50, 3, N'What percentage of doctor visits are estimated to be related to stress?', N'multiple_choice', N'D', 14)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (51, 3, N'Progressive Muscle Relaxation (PMR) works by?', N'multiple_choice', N'A', 15)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (52, 4, N'REM sleep is primarily important for?', N'multiple_choice', N'C', 4)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (53, 4, N'What is sleep latency?', N'multiple_choice', N'B', 5)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (54, 4, N'Which hormone primarily regulates the sleep-wake cycle?', N'multiple_choice', N'A', 6)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (55, 4, N'Insomnia is clinically defined as difficulty sleeping at least how many nights per week?', N'multiple_choice', N'D', 7)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (56, 4, N'Sleep apnea is characterised by?', N'multiple_choice', N'B', 8)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (57, 4, N'To avoid disrupting sleep, you should stop consuming caffeine at least how long before bedtime?', N'multiple_choice', N'C', 9)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (58, 4, N'The human circadian rhythm operates on approximately what cycle?', N'multiple_choice', N'A', 10)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (59, 4, N'Which sleep stage is the deepest and most physically restorative?', N'multiple_choice', N'D', 11)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (60, 4, N'Blue light from screens disrupts sleep primarily by?', N'multiple_choice', N'B', 12)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (61, 4, N'Cognitive Behavioral Therapy for Insomnia (CBT-I) primarily works by?', N'multiple_choice', N'C', 13)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (62, 4, N'What is the recommended duration for a beneficial daytime nap?', N'multiple_choice', N'A', 14)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (63, 4, N'Why is maintaining a consistent wake time important for sleep quality?', N'multiple_choice', N'D', 15)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (64, 5, N'The PERMA model of wellbeing was developed by?', N'multiple_choice', N'B', 4)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (65, 5, N'Post-traumatic growth (PTG) refers to?', N'multiple_choice', N'C', 5)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (66, 5, N'Emotional regulation refers to?', N'multiple_choice', N'A', 6)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (67, 5, N'Self-compassion differs from self-esteem in that self-compassion?', N'multiple_choice', N'D', 7)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (68, 5, N'Which factor is most consistently protective against occupational burnout?', N'multiple_choice', N'B', 8)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (69, 5, N'The "window of tolerance" in trauma therapy refers to?', N'multiple_choice', N'C', 9)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (70, 5, N'Neuroplasticity supports resilience because?', N'multiple_choice', N'A', 10)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (71, 5, N'Regular gratitude practice builds resilience primarily by?', N'multiple_choice', N'D', 11)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (72, 5, N'ACT stands for?', N'multiple_choice', N'B', 12)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (73, 5, N'Psychological flexibility, a core concept in ACT, involves?', N'multiple_choice', N'C', 13)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (74, 5, N'Cognitive reappraisal as a coping strategy involves?', N'multiple_choice', N'A', 14)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (75, 5, N'Barbara Fredrickson''s broaden-and-build theory states that positive emotions?', N'multiple_choice', N'D', 15)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (76, 6, N'What does the WHO definition of self-care emphasise?', N'multiple_choice', N'C', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (77, 6, N'The six domains of self-care do NOT include which of the following?', N'multiple_choice', N'D', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (78, 6, N'Chronic self-neglect most commonly leads to?', N'multiple_choice', N'B', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (79, 6, N'The oxygen mask principle in self-care means?', N'multiple_choice', N'A', 4)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (80, 6, N'The HALT technique asks you to check if you are?', N'multiple_choice', N'C', 5)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (81, 6, N'Which of the following best describes a healthy boundary?', N'multiple_choice', N'B', 6)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (82, 6, N'How does the gut-brain connection relate to self-care?', N'multiple_choice', N'D', 7)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (83, 6, N'A digital detox supports self-care primarily by?', N'multiple_choice', N'A', 8)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (84, 6, N'Physical self-care includes which of the following?', N'multiple_choice', N'D', 9)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (85, 6, N'Emotional self-care involves?', N'multiple_choice', N'B', 10)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (86, 6, N'Professional self-care is best described as?', N'multiple_choice', N'C', 11)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (87, 6, N'Adequate, consistent sleep is important for self-care because?', N'multiple_choice', N'D', 12)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (88, 6, N'Self-compassion and self-care are related in that?', N'multiple_choice', N'A', 13)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (89, 6, N'Social self-care involves?', N'multiple_choice', N'B', 14)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (90, 6, N'Which of the following is an effective micro self-care practice?', N'multiple_choice', N'C', 15)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (91, 7, N'Who is widely credited with founding Cognitive Behavioural Therapy in the 1960s?', N'multichoice', N'B', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (92, 7, N'What is the central premise of the cognitive model?', N'multichoice', N'C', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (93, 7, N'Which of the following is an automatic thought?', N'multichoice', N'A', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (94, 7, N'What is catastrophising?', N'multichoice', N'B', 4)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (95, 7, N'Which cognitive distortion involves assuming what others are thinking without checking?', N'multichoice', N'D', 5)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (96, 7, N'What is the purpose of a thought record?', N'multichoice', N'B', 6)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (97, 7, N'Behavioural activation is most commonly used for which condition?', N'multichoice', N'C', 7)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (98, 7, N'What is an exposure hierarchy?', N'multichoice', N'A', 8)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (99, 7, N'In CBT, the relationship between thoughts, emotions, and behaviour is best described as:', N'multichoice', N'D', 9)
GO
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (100, 7, N'Which is an example of a Socratic question?', N'multichoice', N'B', 10)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (101, 7, N'What is meant by collaborative empiricism in CBT?', N'multichoice', N'A', 11)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (102, 7, N'Which factor is most strongly associated with successful CBT outcomes?', N'multichoice', N'C', 12)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (103, 7, N'Beck''s cognitive triad of depression involves negative views of:', N'multichoice', N'B', 13)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (104, 7, N'Roughly how many sessions is a standard CBT protocol for a single anxiety disorder?', N'multichoice', N'C', 14)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (105, 7, N'What is the goal of cognitive restructuring?', N'multichoice', N'D', 15)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (106, 8, N'Whose work popularised the phrase ''the body keeps the score''?', N'multichoice', N'A', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (107, 8, N'Which brain region is impaired by extreme stress, leading to fragmented traumatic memories?', N'multichoice', N'B', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (108, 8, N'Which brain region encodes trauma in raw sensory fragments?', N'multichoice', N'C', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (109, 8, N'Polyvagal Theory was developed by:', N'multichoice', N'B', 4)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (110, 8, N'Which nervous system state involves shutdown, collapse, and dissociation?', N'multichoice', N'C', 5)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (111, 8, N'Post-Traumatic Growth (PTG) was formally introduced in 1996 by:', N'multichoice', N'A', 6)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (112, 8, N'Which of the following is NOT one of Tedeschi & Calhoun''s five PTG domains?', N'multichoice', N'D', 7)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (113, 8, N'Post-traumatic growth most reliably emerges:', N'multichoice', N'C', 8)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (114, 8, N'James Pennebaker is best known for research on:', N'multichoice', N'B', 9)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (115, 8, N'Which is FALSE about trauma recovery?', N'multichoice', N'D', 10)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (116, 8, N'Hypervigilance, panic, and rage are signs of which autonomic state?', N'multichoice', N'B', 11)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (117, 8, N'The ''window of tolerance'' refers to:', N'multichoice', N'A', 12)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (118, 8, N'Which of the following is a body-based trauma treatment?', N'multichoice', N'C', 13)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (119, 8, N'Post-traumatic growth and ongoing distress can:', N'multichoice', N'C', 14)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (120, 8, N'Why is grounding important in trauma recovery?', N'multichoice', N'B', 15)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (121, 9, N'Who developed Dialectical Behaviour Therapy?', N'multichoice', N'C', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (122, 9, N'What does the ''window of tolerance'' refer to?', N'multichoice', N'A', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (123, 9, N'Hypoarousal includes which of the following?', N'multichoice', N'B', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (124, 9, N'Which is one of the four DBT modules?', N'multichoice', N'D', 4)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (125, 9, N'What does TIPP stand for?', N'multichoice', N'A', 5)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (126, 9, N'Wise Mind is the integration of:', N'multichoice', N'C', 6)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (127, 9, N'Which acronym is used in DBT for assertive communication?', N'multichoice', N'B', 7)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (128, 9, N'Opposite Action is most useful when:', N'multichoice', N'C', 8)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (129, 9, N'Radical acceptance means:', N'multichoice', N'D', 9)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (130, 9, N'What does the PLEASE skill address?', N'multichoice', N'B', 10)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (131, 9, N'According to Linehan''s biosocial theory, emotion dysregulation results from:', N'multichoice', N'B', 11)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (132, 9, N'Standard comprehensive DBT lasts approximately:', N'multichoice', N'C', 12)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (133, 9, N'The ''dialectic'' at the heart of DBT is:', N'multichoice', N'A', 13)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (134, 9, N'STOP is used to:', N'multichoice', N'B', 14)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (135, 9, N'Why is mindfulness considered the foundation of DBT?', N'multichoice', N'D', 15)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (151, 1, N'What is anxiety?', N'multichoice', N'A', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (152, 1, N'Which breathing technique helps reduce anxiety?', N'multichoice', N'B', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (153, 1, N'Anxiety disorder affects what percentage of adults?', N'multichoice', N'C', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (154, 2, N'What is mindfulness?', N'multichoice', N'A', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (155, 2, N'How long should beginners meditate daily?', N'multichoice', N'B', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (156, 2, N'Which sense is commonly used in grounding technique 5-4-3-2-1?', N'multichoice', N'B', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (157, 3, N'What is the main cause of stress?', N'multichoice', N'A', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (158, 3, N'Which of these is a healthy stress management technique?', N'multichoice', N'A', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (159, 3, N'What is the stress hormone called?', N'multichoice', N'B', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (160, 4, N'How many hours of sleep does an adult need?', N'multichoice', N'B', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (161, 4, N'What should you avoid before bed?', N'multichoice', N'D', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (162, 4, N'What is the best room temperature for sleep?', N'multichoice', N'B', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (163, 5, N'What is emotional resilience?', N'multichoice', N'B', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (164, 5, N'Which factor builds emotional resilience?', N'multichoice', N'D', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (165, 5, N'What is a healthy coping mechanism?', N'multichoice', N'D', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (166, 1, N'What is anxiety?', N'multichoice', N'A', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (167, 1, N'Which breathing technique helps reduce anxiety?', N'multichoice', N'B', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (168, 1, N'Anxiety disorder affects what percentage of adults?', N'multichoice', N'C', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (169, 2, N'What is mindfulness?', N'multichoice', N'A', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (170, 2, N'How long should beginners meditate daily?', N'multichoice', N'B', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (171, 2, N'Which sense is commonly used in grounding technique 5-4-3-2-1?', N'multichoice', N'B', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (172, 3, N'What is the main cause of stress?', N'multichoice', N'A', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (173, 3, N'Which of these is a healthy stress management technique?', N'multichoice', N'A', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (174, 3, N'What is the stress hormone called?', N'multichoice', N'B', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (175, 4, N'How many hours of sleep does an adult need?', N'multichoice', N'B', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (176, 4, N'What should you avoid before bed?', N'multichoice', N'D', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (177, 4, N'What is the best room temperature for sleep?', N'multichoice', N'B', 3)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (178, 5, N'What is emotional resilience?', N'multichoice', N'B', 1)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (179, 5, N'Which factor builds emotional resilience?', N'multichoice', N'D', 2)
INSERT [dbo].[Questions] ([QuestionID], [QuizID], [QuestionText], [QuestionType], [CorrectAnswer], [OrderNum]) VALUES (180, 5, N'What is a healthy coping mechanism?', N'multichoice', N'D', 3)
SET IDENTITY_INSERT [dbo].[Questions] OFF
GO
SET IDENTITY_INSERT [dbo].[QuizResults] ON 

INSERT [dbo].[QuizResults] ([ResultID], [UserID], [QuizID], [Score], [TotalQuestions], [Percentage], [Feedback], [DateTaken]) VALUES (0, 2, 1, 3, 3, CAST(100.00 AS Decimal(5, 2)), N'Excellent work! You passed with 100%. Keep up your mental wellness journey!', CAST(N'2026-05-16T18:36:01.950' AS DateTime))
INSERT [dbo].[QuizResults] ([ResultID], [UserID], [QuizID], [Score], [TotalQuestions], [Percentage], [Feedback], [DateTaken]) VALUES (1, 2, 3, 3, 3, CAST(100.00 AS Decimal(5, 2)), N'Excellent work! You passed with 100%. Keep up your mental wellness journey!', CAST(N'2026-05-16T18:39:34.317' AS DateTime))
INSERT [dbo].[QuizResults] ([ResultID], [UserID], [QuizID], [Score], [TotalQuestions], [Percentage], [Feedback], [DateTaken]) VALUES (2, 9, 2, 2, 3, CAST(66.70 AS Decimal(5, 2)), N'Good effort! You scored 66.7%. Review the course materials and try again.', CAST(N'2026-05-17T15:55:47.740' AS DateTime))
INSERT [dbo].[QuizResults] ([ResultID], [UserID], [QuizID], [Score], [TotalQuestions], [Percentage], [Feedback], [DateTaken]) VALUES (3, 9, 1, 4, 15, CAST(26.70 AS Decimal(5, 2)), N'You scored 26.7%. Don''t be discouraged - revisit the course content and try again.', CAST(N'2026-05-17T17:32:47.117' AS DateTime))
INSERT [dbo].[QuizResults] ([ResultID], [UserID], [QuizID], [Score], [TotalQuestions], [Percentage], [Feedback], [DateTaken]) VALUES (4, 10, 6, 6, 15, CAST(40.00 AS Decimal(5, 2)), N'You scored 40.0%. Don''t be discouraged - revisit the course content and try again.', CAST(N'2026-05-18T17:25:16.990' AS DateTime))
SET IDENTITY_INSERT [dbo].[QuizResults] OFF
GO
SET IDENTITY_INSERT [dbo].[Quizzes] ON 

INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (1, 3, N'Understanding Anxiety', N'Test your knowledge about anxiety, its causes, and management techniques.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (2, 2, N'Mindfulness & Meditation', N'Test your understanding of mindfulness principles and meditation practices.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (3, 1, N'Stress Management', N'Assess your knowledge of stress causes, effects, and healthy coping strategies.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (4, 4, N'Sleep Hygiene', N'Test your knowledge about healthy sleep habits and rest optimization.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (5, 5, N'Emotional Resilience', N'Assess your understanding of emotional resilience and coping mechanisms.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (6, 7, N'Self-Care Essentials', N'Test your knowledge of self-care science, strategies, and daily practices for mental and emotional wellbeing.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (7, 8, N'CBT Techniques Essentials', N'Test your understanding of the cognitive model, key techniques, and the evidence base behind CBT.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (8, 9, N'Trauma and Growth Essentials', N'Test your understanding of how trauma is encoded in the nervous system and how post-traumatic growth becomes possible.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (9, 10, N'DBT Skills Essentials', N'Test your understanding of emotion regulation, the four DBT modules, and the dialectical stance at the heart of the approach.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (11, 3, N'Understanding Anxiety', N'Test your knowledge about anxiety, its causes, and management techniques.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (12, 2, N'Mindfulness & Meditation', N'Test your understanding of mindfulness principles and meditation practices.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (13, 1, N'Stress Management', N'Assess your knowledge of stress causes, effects, and healthy coping strategies.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (14, 4, N'Sleep Hygiene', N'Test your knowledge about healthy sleep habits and rest optimization.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (15, 5, N'Emotional Resilience', N'Assess your understanding of emotional resilience and coping mechanisms.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (16, 3, N'Understanding Anxiety', N'Test your knowledge about anxiety, its causes, and management techniques.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (17, 2, N'Mindfulness & Meditation', N'Test your understanding of mindfulness principles and meditation practices.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (18, 1, N'Stress Management', N'Assess your knowledge of stress causes, effects, and healthy coping strategies.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (19, 4, N'Sleep Hygiene', N'Test your knowledge about healthy sleep habits and rest optimization.', 70)
INSERT [dbo].[Quizzes] ([QuizID], [CourseID], [Title], [Description], [PassingScore]) VALUES (20, 5, N'Emotional Resilience', N'Assess your understanding of emotional resilience and coping mechanisms.', 70)
SET IDENTITY_INSERT [dbo].[Quizzes] OFF
GO
SET IDENTITY_INSERT [dbo].[Resources] ON 

INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (1, 1, N'What is Stress? The Science Behind It', N'article', N'Stress is the body’s adaptive response to any demand or perceived challenge. The classic acute stress reaction — known as the “fight-or-flight” response — was first described by physiologist Walter Cannon in 1915. When the brain detects a threat (real or anticipated), the amygdala signals the hypothalamus, which in turn activates two parallel pathways: the sympathetic-adrenal-medullary axis releases adrenaline within seconds, while the slower hypothalamic-pituitary-adrenal (HPA) axis releases cortisol over minutes to hours.

Physiologically, this cascade widens pupils, accelerates heart rate, raises blood glucose, and shunts blood from digestion toward skeletal muscles. These changes evolved to help our ancestors escape predators in short bursts; they are remarkably effective for brief emergencies but become harmful when sustained over weeks or months.

Researchers distinguish between two qualitative types. Eustress is short-lived, motivating activation — the kind of arousal that sharpens focus before a presentation or fuels training for a marathon. Distress is the prolonged, overwhelming state where demand exceeds perceived coping resources. The same biological machinery powers both; what changes is duration, controllability, and meaning. Hans Selye, who coined the term “stress” in its modern sense, called this the General Adaptation Syndrome and identified its three phases: alarm, resistance, and exhaustion.

Chronic distress reshapes the brain and body. Prolonged cortisol exposure shrinks the hippocampus (impairing memory and learning), enlarges the amygdala (heightening threat sensitivity), and weakens the prefrontal cortex (eroding executive control). Outside the brain, long-term stress raises blood pressure, suppresses immune function, accelerates cellular ageing through telomere shortening, and contributes to cardiovascular disease, type 2 diabetes, and major depressive disorder. The American Psychological Association’s annual “Stress in America” survey consistently finds students and young adults reporting the highest stress burdens of any age group.

The good news is that stress is highly modifiable. Decades of research from labs led by Bruce McEwen, Kelly McGonigal, and others show that perception, control, and recovery matter as much as the stressor itself. Three findings recur across the literature: regular relaxation practices (breathwork, progressive muscle relaxation, meditation) measurably lower baseline cortisol; reframing stress as a resource rather than a threat improves cardiovascular response under pressure; and strong social ties buffer against nearly every adverse stress outcome. Identifying personal triggers — academic pressure, financial uncertainty, relationship strain, sleep loss — is the first practical step, followed by deliberate recovery routines that allow the nervous system to return to baseline between demands.', NULL, 1)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (2, 1, N'5 Immediate Stress Relief Techniques', N'article', N'1. Deep Breathing (4-7-8 Technique): Inhale for 4 counts, hold for 7, exhale for 8. This activates the parasympathetic nervous system and calms your body within minutes.

2. Progressive Muscle Relaxation: Tense each muscle group for 5 seconds, then release. Start from your toes and work upward. This reduces physical tension associated with stress.

3. The 5-4-3-2-1 Grounding Technique: Name 5 things you can see, 4 you can touch, 3 you can hear, 2 you can smell, 1 you can taste. This anchors you to the present moment.

4. Cold Water Splash: Splash cold water on your face. This activates the dive reflex and can reduce heart rate rapidly.

5. Brief Physical Activity: Even a 10-minute walk releases endorphins that combat stress hormones.', NULL, 2)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (3, 1, N'How to Make Stress Your Friend - Kelly McGonigal (TED)', N'video', NULL, N'https://www.youtube.com/embed/RcGyVTAoXEU', 3)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (4, 1, N'Daily Stress Journal Template', N'download', N'Download this daily stress journal template to track your stress triggers, responses, and coping strategies. Regular journaling helps identify patterns and monitor your progress.', N'/Content/Downloads/stress-journal-template.html', 4)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (5, 2, N'Introduction to Mindfulness', N'article', N'Mindfulness is the practice of intentionally directing your attention to the present moment with openness and without judgment. Rooted in Buddhist traditions but thoroughly validated by modern neuroscience, mindfulness has been shown to reduce anxiety, depression, and stress while improving focus, emotional regulation, and overall wellbeing.

Core mindfulness principles:
- Present-moment awareness: focusing on what''s happening now, not past regrets or future worries
- Non-judgment: observing thoughts and feelings without labelling them as good or bad
- Acceptance: allowing experiences to be as they are without fighting them
- Beginner''s mind: approaching each moment with curiosity and openness

Research from Harvard, Oxford, and other leading institutions confirms that regular mindfulness practice (as little as 10 minutes per day) can physically change brain structure, increasing grey matter in areas associated with learning, memory, and emotional regulation.', NULL, 1)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (6, 2, N'All It Takes Is 10 Mindful Minutes - Andy Puddicombe (TED)', N'video', NULL, N'https://www.youtube.com/embed/qzR62JJCMBQ', 2)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (7, 2, N'Mindfulness for Students - Guide', N'article', N'As a student, your mind is constantly pulled in multiple directions: lectures, assignments, social pressures, and future concerns. Mindfulness gives you the ability to choose where to direct your attention.

Simple mindfulness practices for students:
1. Mindful morning routine (5 minutes): Before checking your phone, take 5 deep breaths and set a positive intention for the day.
2. Mindful eating: During at least one meal, put away devices and eat slowly, noticing flavours, textures, and sensations.
3. Study mindfulness: Before studying, take 3 deep breaths. Notice when your mind wanders and gently redirect attention to the material.
4. Mindful walking: During breaks between classes, walk slowly and notice the sensation of each step.
5. Evening reflection (3 minutes): Before sleep, reflect on 3 things you''re grateful for from the day.', NULL, 3)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (8, 3, N'What is Anxiety? Types and Symptoms', N'article', N'Anxiety is a natural response to perceived threat or uncertainty. It becomes a disorder when persistent, excessive, and interfering with daily life. Main anxiety disorders include: Generalised Anxiety Disorder (GAD) — persistent worry about many topics; Panic Disorder — recurrent unexpected panic attacks with physical symptoms; Social Anxiety Disorder — intense fear of social situations; and Specific Phobias — irrational fear of a specific object or situation. Common physical signs: racing heart, sweating, trembling, dry mouth, nausea. Cognitive signs: catastrophic thinking, overestimating danger, difficulty concentrating.', NULL, 1)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (9, 3, N'Cognitive-Behavioural Techniques for Anxiety', N'article', N'Cognitive-Behavioural Therapy (CBT) is the gold-standard treatment for anxiety. Key CBT techniques: (1) Thought Records — write the situation, automatic thought, evidence for/against, and a balanced alternative thought; (2) Behavioural Experiments — test anxious predictions against reality through gradual exposure; (3) Exposure Hierarchy — list feared situations from least to most anxiety-provoking, then face them gradually; (4) Cognitive Restructuring — challenge catastrophising, mind-reading, and overestimating probability; (5) Relaxation — diaphragmatic breathing, progressive muscle relaxation, and mindfulness reduce the physical component of anxiety.', NULL, 2)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (10, 3, N'How to Cope with Anxiety - Olivia Remes (TEDx)', N'video', NULL, N'https://www.youtube.com/embed/ZidGozDhOjg', 3)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (11, 4, N'The Science of Sleep and Mental Health', N'article', N'Sleep is one of the most active processes your brain undergoes each night. The brain consolidates memories, clears metabolic waste products, and regulates emotional responses during sleep. Sleep cycles (~90 minutes each) alternate between NREM Stage 1-2 (light sleep), NREM Stage 3 (deep slow-wave sleep — tissue repair, immune strengthening), and REM sleep (vivid dreaming, emotional memory processing). Sleep deprivation increases amygdala reactivity by up to 60%, making you emotionally reactive. Chronic poor sleep is one of the strongest predictors of depression and anxiety. Adults need 7-9 hours per night.', NULL, 1)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (12, 4, N'Building a Sleep-Friendly Environment and Routine', N'article', N'Sleep hygiene covers habits and environmental conditions that promote high-quality sleep. Environment: keep your bedroom at 16-20 degrees C (60-68 F) — core body temperature must drop to initiate sleep; use blackout curtains since even small amounts of light suppress melatonin; use your bed only for sleep to strengthen the mental association. Behavioural strategies: wake at the same time every day (including weekends) to anchor your circadian rhythm; follow a 30-60 minute wind-down routine with dim lights and no screens; avoid caffeine after 2pm (half-life is 5-6 hours); avoid alcohol before bed as it fragments sleep and suppresses REM; exercise regularly but avoid vigorous workouts within 2 hours of bedtime.', NULL, 2)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (13, 4, N'Sleep Is Your Superpower - Matthew Walker (TED)', N'video', NULL, N'https://www.youtube.com/embed/5MuIMqhT8DM', 3)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (14, 4, N'Sleep Quality Tracker Template', N'download', N'Download this sleep quality tracker to monitor your sleep schedule, bedtime habits, and energy levels. Tracking for two weeks helps identify patterns that improve or disrupt your sleep.', N'/Content/Downloads/sleep-quality-tracker.html', 4)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (15, 5, N'What is Emotional Resilience?', N'article', N'Emotional resilience is the ability to adapt positively in the face of adversity, trauma, or significant stress. Resilient people do not avoid difficult emotions — they process them effectively and grow from experience. Key dimensions: emotional regulation (manage emotions without being overwhelmed); cognitive flexibility (reframe situations and find alternative interpretations); social connectedness (strong relationships are the most powerful predictor of resilience); self-efficacy (belief in your ability to cope, built through experience); and purpose and meaning (a sense of why buffers against stress). Martin Seligman''s PERMA model identifies five pillars of wellbeing: Positive Emotion, Engagement, Relationships, Meaning, and Accomplishment.', NULL, 1)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (16, 5, N'Building Your Resilience Toolkit', N'article', N'Resilience is a set of learnable skills. Evidence-based strategies: (1) Growth mindset — view challenges as learning opportunities; replace "I cannot do this" with "I cannot do this yet"; (2) Gratitude practice — write 3 specific things you appreciate daily, shown to increase wellbeing within 2-4 weeks; (3) Build your support network — identify 3-5 people you can call when struggling; (4) Emotional vocabulary — label emotions precisely rather than just "bad" (e.g. "disappointed", "overwhelmed", "embarrassed"); (5) Accept what you cannot control — distinguish between what is and is not within your control; (6) Physical self-care — sleep, exercise, and nutrition are foundational to resilience; (7) Post-traumatic growth journaling — write about what happened, how you felt, what you learned, and how it has shaped you.', NULL, 2)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (17, 5, N'The Three Secrets of Resilient People - Lucy Hone (TEDx)', N'video', NULL, N'https://www.youtube.com/embed/NWH8N-BvhAw', 3)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (18, 5, N'Resilience Self-Assessment Worksheet', N'download', N'Download this resilience self-assessment to identify your current strengths, areas for growth, and create a personalised resilience-building action plan.', N'/Content/Downloads/resilience-self-assessment.html', 4)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (19, 7, N'What is Self-Care? The Science Behind It', N'article', N'Self-care is the deliberate practice of activities that maintain and improve physical, mental, and emotional health. It is not selfish — it is essential. Research shows that consistent self-care reduces burnout, lowers cortisol, and improves immune function.

The World Health Organization defines self-care as the ability of individuals to promote health, prevent disease, and cope with illness with or without the support of a healthcare provider. Self-care falls into six key domains: physical (sleep, nutrition, exercise), emotional (recognising and expressing feelings), social (healthy relationships), mental (stimulation, creativity), spiritual (meaning and purpose), and professional (work-life balance).

One foundational concept is the oxygen mask principle — you must care for yourself before you can effectively help others. Chronic self-neglect leads to compassion fatigue, burnout, and reduced ability to regulate emotions. Even small daily acts of self-care accumulate into meaningful wellbeing over time.', NULL, 1)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (20, 7, N'Practical Self-Care Strategies for Every Day', N'article', N'Effective self-care does not require vast amounts of time. Research-backed strategies include:

1. Boundary Setting: Learning to say no is a skill. Healthy boundaries protect your energy and reduce resentment. Practice by identifying your limits and communicating them clearly.

2. The HALT Technique: When overwhelmed, check if you are Hungry, Angry, Lonely, or Tired. Addressing these basic needs first often resolves emotional distress.

3. The 5-Minute Reset: Set a timer for 5 minutes and do one of the following — stretch, breathe deeply, write three things you are grateful for, or step outside.

4. Digital Detox: Schedule 30-60 minutes daily away from screens, especially before bed. Constant connectivity activates the stress response and prevents recovery.

5. Nourishment: Eating regular, balanced meals stabilises blood sugar and mood. The gut-brain connection means what you eat directly affects how you feel.

6. Joyful Movement: Any physical activity you enjoy counts as self-care. Aim for at least 20-30 minutes most days.', NULL, 2)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (21, 7, N'Self Care: What It Really Is - Susannah Winters (TEDx)', N'video', NULL, N'https://www.youtube.com/embed/dBn0ETS6XDk', 3)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (22, 7, N'My Self-Care Plan Worksheet', N'download', N'Download this personalised self-care planning worksheet to identify your needs across all life domains and build a sustainable daily routine.', N'/Content/Downloads/self-care-plan.html', 4)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (23, 2, N'Mindfulness Practice Log', N'download', N'A weekly worksheet to track your mindfulness practice, notice common distractions, and reflect on what kept your attention steady. Completing it for two to four weeks helps build a sustainable rhythm.', N'/Content/Downloads/mindfulness-practice-log.html', 4)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (24, 3, N'Anxiety Coping Plan', N'download', N'A structured plan to identify triggers, challenge anxious thoughts, build a personal exposure ladder, and choose grounding techniques that work for you.', N'/Content/Downloads/anxiety-coping-plan.html', 4)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (25, 8, N'The Cognitive Model: Why Thoughts Drive Feelings', N'article', N'Cognitive Behavioural Therapy (CBT) rests on a single, deceptively simple premise: it is not events themselves that determine how we feel, but the meaning we assign to them. Two students can receive the same critical feedback on an essay and walk out of the tutor’s office in very different emotional states. The first interprets the feedback as evidence that they are a fraud who will never succeed; the second interprets it as a useful map for the next draft. Same event, two cognitions, two emotional worlds.

This insight, formalised by Aaron T. Beck in the 1960s after his clinical observations of depressed patients, became the cognitive model. Beck noticed that his patients reported a constant stream of negative thoughts about themselves, the world, and the future — what he later called the cognitive triad. Crucially, these thoughts were not consciously chosen; they appeared automatically, felt entirely true, and shaped mood, behaviour, and physical state. Change the thought, Beck reasoned, and the downstream emotion and behaviour would shift with it. Six decades of randomised trials have largely confirmed this hypothesis: CBT is now the most evidence-supported psychological treatment for depression, generalised anxiety, panic disorder, OCD, PTSD, and many other conditions.

The model has three interacting layers. At the surface sit automatic thoughts — fleeting, situation-specific cognitions like “I’m going to fail this presentation” or “She didn’t reply because she hates me.” Beneath them sit intermediate beliefs (rules and assumptions such as “If I don’t do everything perfectly, I’m worthless”). At the deepest level lie core beliefs — global, absolute statements about the self (“I am unlovable”), others (“People will always let me down”), or the world (“It is not safe to trust”). Core beliefs are typically formed in childhood and reactivated by stressful events. CBT works at all three levels but begins with automatic thoughts, because they are the most accessible.

Three findings from outcome research consistently shape effective practice: (1) Specificity beats abstraction — “my partner sighed when I mentioned dinner” is a workable thought; “he doesn’t care” is not; (2) The therapeutic relationship matters as much as the technique — patients improve when they feel understood, even before formal restructuring begins; (3) Between-session practice predicts outcome more strongly than session frequency — CBT is a skill built through repetition, not insight alone. This is why thought records, behavioural experiments, and homework are central to every protocol.', N'', 1)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (26, 8, N'Mastering Core CBT Techniques in Practice', N'article', N'Once the cognitive model becomes a working framework, the next step is fluency in the core techniques. CBT is best thought of as a toolkit; the skill is choosing the right tool for the job and using it well. The following techniques are the most evidence-supported and the most teachable to clients.

(1) The Thought Record — write the situation, the emotion (rated 0 to 100), the automatic thought, evidence for the thought, evidence against it, and a more balanced alternative. The act of slowing the thought down in writing is itself therapeutic; it transforms an automatic process into a deliberate one. Daily practice for two to three weeks reliably produces a measurable shift in mood; (2) Behavioural Experiments — design a small real-world test of an anxious prediction. If the prediction is “if I ask a question in tutorial, everyone will think I’m stupid,” the experiment is to ask one question and observe what actually happens. Reality almost always disconfirms the catastrophic prediction; (3) Exposure Hierarchies — list feared situations from least to most distressing and approach them gradually, staying long enough at each step for anxiety to subside on its own. The mechanism is habituation: the threat response cannot sustain itself indefinitely without reinforcement; (4) Behavioural Activation — for depression, schedule small, valued activities in advance rather than waiting for motivation. Action precedes motivation in low mood, not the other way around; (5) Socratic Questioning — instead of telling clients their thought is irrational, ask: “What is the evidence? Is there another way to look at this? What would you say to a friend in your position?” The shift in perspective comes from the client, which is what makes it stick; (6) Cognitive Restructuring of Core Beliefs — once automatic thoughts loosen, identify the underlying rules and core beliefs and treat them as hypotheses to be tested rather than facts to be lived by.

Two practical principles tie these tools together. The first is collaborative empiricism: therapist and client are both scientists, gathering data on the client’s mind. The second is between-session practice: the work of therapy happens in the hours between sessions, not the hour of the session. Mark Williams calls this “laying down a new neural path” — every repetition strengthens the alternative response and weakens the automatic one.

A common question is how long CBT takes. For a single anxiety disorder treated without complications, twelve to twenty sessions is typical. For more complex presentations — trauma, comorbid personality difficulties, longstanding depression — protocols extend to thirty sessions or more, often integrating schema-focused or compassion-focused adaptations. What does not change across formats is the underlying logic: identify the thought, hold it up to the light, test it against reality, and choose your response.', N'', 2)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (27, 8, N'The Power of Believing You Can Improve - Carol Dweck (TED)', N'video', N'Carol Dweck''s foundational research on growth mindset — the cognitive belief that abilities can develop through effort — closely mirrors how CBT teaches us to challenge fixed, distorted thinking.', N'https://www.youtube.com/embed/_X0mgOOSpLU', 3)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (28, 8, N'CBT Thought Record Workbook', N'download', N'A complete thought-record template with cognitive-distortion checklist, evidence columns, and a re-rating section. Use one entry per emotional episode for two to three weeks.', N'/Content/Downloads/cbt-thought-record.html', 4)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (29, 9, N'Understanding Trauma and the Nervous System', N'article', N'Trauma is not simply a memory of a terrible event; it is a lasting change in how the nervous system perceives and responds to the world. Bessel van der Kolk, in his decades of clinical research, summarised this in a single sentence: the body keeps the score. Long after the original event has ended, the body continues to mobilise as if the threat were still present — heart rate elevated, muscles braced, attention narrowed, sleep disrupted.

The mechanism lies in the way memory is encoded under extreme stress. Under ordinary conditions, an experience is processed by the hippocampus into a coherent autobiographical memory: a story with a beginning, middle, and end, indexed in time. Under the flood of stress hormones released during life-threatening events, hippocampal processing is impaired, while the amygdala — the brain’s alarm system — encodes the experience in fragments of raw sensation: a smell, a sound, a body position. These fragments are not stored as a story but as live wires. Later, when something in the present environment resembles one of those fragments, the alarm fires again. The person re-experiences the original arousal even though, on the surface, they may know perfectly well that they are safe.

Stephen Porges’s Polyvagal Theory offers a complementary lens. The autonomic nervous system has three main states: the ventral vagal state (social engagement, calm, connection), the sympathetic state (fight-or-flight mobilisation), and the dorsal vagal state (shutdown, collapse, dissociation). A healthy nervous system moves fluidly between these states. After trauma, the system tends to lock in sympathetic or dorsal patterns. Hypervigilance, panic, and rage are sympathetic; numbness, fatigue, and dissociation are dorsal. Recognising one’s own state without judgement is the first step of recovery.

Three implications follow from this neuroscience: (1) Trauma recovery cannot be achieved by insight alone — the work must reach the body and the nervous system, not just the conscious mind; (2) Establishing physical and relational safety is not a precondition for therapy but the first phase of therapy; (3) Pacing matters profoundly — pushing too hard, too fast, retraumatises rather than heals. Modern trauma-informed approaches (EMDR, Sensorimotor Psychotherapy, Somatic Experiencing, IFS, trauma-focused CBT) all share this respect for the body’s timing and the nervous system’s capacity.', N'', 1)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (30, 9, N'Post-Traumatic Growth: From Survival to Meaning', N'article', N'For many decades, the dominant clinical story about trauma was deficit-based: trauma damages the person, and treatment aims to repair what was broken. In 1996, psychologists Richard Tedeschi and Lawrence Calhoun introduced a parallel story: post-traumatic growth (PTG). They studied survivors of bereavement, cancer, war, and accident and found that a substantial proportion reported positive psychological changes that they explicitly attributed to their struggle with the trauma — not despite it.

PTG is not the absence of suffering; it coexists with it. A survivor can carry grief and find renewed purpose in the same week. Tedeschi and Calhoun identified five domains in which growth most commonly appears: (1) Personal strength — “I am more resilient than I imagined”; (2) Relating to others — deeper, more honest relationships and increased compassion; (3) New possibilities — career, vocation, or identity shifts that would not have occurred otherwise; (4) Appreciation of life — sharper attention to small, everyday goods; (5) Spiritual or existential change — a re-examination of what one’s life is for. These are not romantic platitudes; they are repeatedly observed in standardised assessments such as the Post-Traumatic Growth Inventory.

The mechanism of growth, as far as research can establish, is deliberate cognitive engagement with the event over time. Survivors who explore the trauma rather than suppress it — typically through writing, conversation, or therapy — gradually reconstruct their assumptive world (their basic beliefs about themselves, others, and life). The old assumptive world has been shattered; a new, more nuanced one is built in its place. James Pennebaker’s landmark expressive-writing studies demonstrated that even brief, structured writing about a trauma produces measurable improvements in health and wellbeing months later.

Clinicians who work in this space emphasise three principles. First, growth is not a goal to be pursued for its own sake — pressure to “grow” can become another burden. It is better described as a possibility to be made room for. Second, growth and pain are not opposites; the deepest growth often emerges from the willingness to feel the pain fully rather than escape it. Third, growth requires time. Tedeschi and Calhoun observe that PTG typically becomes visible six to twenty-four months after the event, not in the immediate aftermath. The early phase is for stabilisation and safety; meaning-making comes later, when the nervous system has the bandwidth for it. Recovery, in this view, is neither linear nor optional. It is the slow, often quiet work of building a life that holds both what was lost and what is now possible.', N'', 2)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (31, 9, N'How Childhood Trauma Affects Health Across a Lifetime - Nadine Burke Harris (TED)', N'video', N'Dr Nadine Burke Harris''s landmark TED talk on Adverse Childhood Experiences (ACEs) and how trauma reshapes the developing brain, immune system, and long-term health.', N'https://www.youtube.com/embed/95ovIJ3dsNk', 3)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (32, 9, N'Trauma Recovery Reflection Guide', N'download', N'A trauma-informed reflection worksheet covering window of tolerance, safety anchors, grounding techniques, self-compassion, and meaning-making.', N'/Content/Downloads/trauma-recovery-reflection.html', 4)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (33, 10, N'The Window of Tolerance and Why Emotions Dysregulate', N'article', N'Dan Siegel’s phrase “window of tolerance” has become standard shorthand in trauma and emotion-regulation work, but its mechanism is worth understanding precisely. The window describes the zone of autonomic arousal within which a person can think, feel, and act with reasonable clarity. Inside the window, the prefrontal cortex stays online; reasoning, perspective-taking, and impulse control are accessible. Outside the window, in either direction, the prefrontal cortex effectively goes offline and lower-brain systems take over.

There are two ways to exit the window. Hyperarousal is the upward exit: heart racing, breath shallow, attention narrowed, urges to fight or flee, racing or intrusive thoughts. Hypoarousal is the downward exit: numbness, fatigue, foggy thinking, urges to disappear or shut down, dissociation. Both states evolved as protective responses to overwhelming threat, and both are profoundly unpleasant when triggered by ordinary modern stressors. Chronic emotion dysregulation is, in essence, a window that has become too narrow — small everyday events push the person out of the window with little warning.

Marsha Linehan, who developed DBT in the late 1980s after research with chronically suicidal patients, framed emotion dysregulation as the joint product of biological vulnerability (innate emotional sensitivity, intensity, and slow return to baseline) and an invalidating environment (relationships in which intense emotional experiences are dismissed, punished, or oversimplified). Over time, the person never learns the skills of regulating intense emotion, because the environment that should have taught them either could not or would not. DBT is, in this sense, an explicit attempt to provide what was missing: skills, structure, and a deeply validating relationship.

Three practical implications follow: (1) Regulation skills must be learned in a regulated state, not in crisis — you cannot teach calm to someone already on fire; (2) The skills must be specific and rehearsed, because in moments of overwhelm, only well-rehearsed behaviour is accessible; (3) Validation comes before change. Linehan’s key dialectical move is to hold two truths at once: “You are doing the best you can” AND “You can do better, learn new skills, and build a life worth living.” Both are true; one without the other fails.', N'', 1)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (34, 10, N'The Four DBT Modules: A Practical Toolkit', N'article', N'DBT organises its skills into four modules, each addressing a distinct demand of the emotion-regulation challenge. They are designed to be learned in sequence but used flexibly — a single difficult moment may call on skills from two or three modules at once.

(1) Mindfulness — the foundation. The “what” skills (observe, describe, participate) and “how” skills (non-judgementally, one-mindfully, effectively) teach the person to notice an emotion as it arises rather than be carried by it. The aim is not to eliminate emotion but to widen the gap between feeling and reaction. Wise Mind, the integration of emotion mind and reason mind, is the goal state; (2) Distress Tolerance — for moments when distress is already at a level where regulation is not yet possible. The signature skill is TIPP (Temperature change, Intense exercise, Paced breathing, Paired muscle relaxation), which rapidly downshifts physiological arousal. STOP (Stop, Take a step back, Observe, Proceed mindfully) helps prevent impulsive action. Radical acceptance is the long arc: accepting reality as it is, not because it is desirable, but because fighting it is more painful than acknowledging it; (3) Emotion Regulation — for shifting the emotion itself over time. Check the Facts asks whether the emotion fits the actual situation; Opposite Action asks the person to act opposite to the urge of an unjustified emotion (approach what fear avoids, engage in what shame hides); PLEASE (treat Physical illness, balance Eating, avoid mood-altering substances, balance Sleep, get Exercise) addresses the biological substrate that makes regulation possible; (4) Interpersonal Effectiveness — for staying regulated in relationship. DEAR MAN (Describe, Express, Assert, Reinforce, stay Mindful, Appear confident, Negotiate) is the script for asking for what you need; GIVE keeps the relationship intact; FAST preserves self-respect.

What unifies the modules is the dialectical stance: holding apparent opposites simultaneously without collapsing one into the other. Acceptance AND change. Self-compassion AND accountability. Validation AND skill-building. Linehan describes this not as a tactic but as a worldview: reality is composed of opposing forces in motion, and synthesis — not victory of one side over the other — is the work.

The evidence base is substantial. Standard DBT, delivered over twelve months in a comprehensive programme (individual therapy, skills group, phone coaching, therapist consultation), shows large effect sizes for borderline personality disorder, suicidal behaviour, substance use disorders, eating disorders, and severe emotion dysregulation. Skills-only adaptations (without individual therapy) show meaningful benefit for sub-threshold emotion difficulties in the general population, including students and young adults navigating high-pressure transitions. The crucial finding across trials is that DBT skills, repeatedly practised, produce measurable change in functional outcomes — not just symptom scores.', N'', 2)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (35, 10, N'The Power of Vulnerability - Brené Brown (TEDx)', N'video', N'Brené Brown''s foundational TEDx talk on vulnerability and shame — themes that sit at the heart of emotional regulation, distress tolerance, and the dialectic between acceptance and change in DBT.', N'https://www.youtube.com/embed/iCvmsMzlF7o', 3)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (36, 10, N'DBT Skills Practice Worksheet', N'download', N'A structured worksheet for logging one emotional episode, choosing a skill from the right DBT module, and reflecting on how it worked.', N'/Content/Downloads/dbt-skills-practice.html', 4)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (41, 1, N'What is Stress? The Science Behind It', N'article', N'Stress is the body''s response to any demand or challenge. When you encounter a stressor â€” whether physical, emotional, or psychological â€” your body activates the "fight-or-flight" response. Cortisol and adrenaline are released, increasing heart rate, blood pressure, and alerting your senses.

While acute stress can be beneficial (helping you meet deadlines or avoid danger), chronic stress damages physical and mental health. Signs of chronic stress include: persistent headaches, fatigue, irritability, difficulty concentrating, and disrupted sleep.

Understanding your stress triggers is the first step toward effective management. Common triggers for students include: academic pressure, financial concerns, relationship issues, and uncertainty about the future.

The good news: stress is manageable. With the right tools and consistent practice, you can build resilience and reduce the impact of stress on your wellbeing.', NULL, 1)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (42, 1, N'5 Immediate Stress Relief Techniques', N'article', N'1. Deep Breathing (4-7-8 Technique): Inhale for 4 counts, hold for 7, exhale for 8. This activates the parasympathetic nervous system and calms your body within minutes.

2. Progressive Muscle Relaxation: Tense each muscle group for 5 seconds, then release. Start from your toes and work upward. This reduces physical tension associated with stress.

3. The 5-4-3-2-1 Grounding Technique: Name 5 things you can see, 4 you can touch, 3 you can hear, 2 you can smell, 1 you can taste. This anchors you to the present moment.

4. Cold Water Splash: Splash cold water on your face. This activates the dive reflex and can reduce heart rate rapidly.

5. Brief Physical Activity: Even a 10-minute walk releases endorphins that combat stress hormones.', NULL, 2)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (43, 1, N'Stress Management - Guided Exercise Video', N'video', NULL, N'https://www.youtube.com/embed/z6X5oEIg6Ak', 3)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (44, 1, N'Daily Stress Journal Template', N'download', N'Download this daily stress journal template to track your stress triggers, responses, and coping strategies. Regular journaling helps identify patterns and monitor your progress.', NULL, 4)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (45, 2, N'Introduction to Mindfulness', N'article', N'Mindfulness is the practice of intentionally directing your attention to the present moment with openness and without judgment. Rooted in Buddhist traditions but thoroughly validated by modern neuroscience, mindfulness has been shown to reduce anxiety, depression, and stress while improving focus, emotional regulation, and overall wellbeing.

Core mindfulness principles:
- Present-moment awareness: focusing on what''s happening now, not past regrets or future worries
- Non-judgment: observing thoughts and feelings without labelling them as good or bad
- Acceptance: allowing experiences to be as they are without fighting them
- Beginner''s mind: approaching each moment with curiosity and openness

Research from Harvard, Oxford, and other leading institutions confirms that regular mindfulness practice (as little as 10 minutes per day) can physically change brain structure, increasing grey matter in areas associated with learning, memory, and emotional regulation.', NULL, 1)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (46, 2, N'10-Minute Body Scan Meditation', N'video', NULL, N'https://www.youtube.com/embed/dB_LkXuDEDw', 2)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (47, 2, N'Mindfulness for Students - Guide', N'article', N'As a student, your mind is constantly pulled in multiple directions: lectures, assignments, social pressures, and future concerns. Mindfulness gives you the ability to choose where to direct your attention.

Simple mindfulness practices for students:
1. Mindful morning routine (5 minutes): Before checking your phone, take 5 deep breaths and set a positive intention for the day.
2. Mindful eating: During at least one meal, put away devices and eat slowly, noticing flavours, textures, and sensations.
3. Study mindfulness: Before studying, take 3 deep breaths. Notice when your mind wanders and gently redirect attention to the material.
4. Mindful walking: During breaks between classes, walk slowly and notice the sensation of each step.
5. Evening reflection (3 minutes): Before sleep, reflect on 3 things you''re grateful for from the day.', NULL, 3)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (48, 1, N'What is Stress? The Science Behind It', N'article', N'Stress is the body''s response to any demand or challenge. When you encounter a stressor â€” whether physical, emotional, or psychological â€” your body activates the "fight-or-flight" response. Cortisol and adrenaline are released, increasing heart rate, blood pressure, and alerting your senses.

While acute stress can be beneficial (helping you meet deadlines or avoid danger), chronic stress damages physical and mental health. Signs of chronic stress include: persistent headaches, fatigue, irritability, difficulty concentrating, and disrupted sleep.

Understanding your stress triggers is the first step toward effective management. Common triggers for students include: academic pressure, financial concerns, relationship issues, and uncertainty about the future.

The good news: stress is manageable. With the right tools and consistent practice, you can build resilience and reduce the impact of stress on your wellbeing.', NULL, 1)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (49, 1, N'5 Immediate Stress Relief Techniques', N'article', N'1. Deep Breathing (4-7-8 Technique): Inhale for 4 counts, hold for 7, exhale for 8. This activates the parasympathetic nervous system and calms your body within minutes.

2. Progressive Muscle Relaxation: Tense each muscle group for 5 seconds, then release. Start from your toes and work upward. This reduces physical tension associated with stress.

3. The 5-4-3-2-1 Grounding Technique: Name 5 things you can see, 4 you can touch, 3 you can hear, 2 you can smell, 1 you can taste. This anchors you to the present moment.

4. Cold Water Splash: Splash cold water on your face. This activates the dive reflex and can reduce heart rate rapidly.

5. Brief Physical Activity: Even a 10-minute walk releases endorphins that combat stress hormones.', NULL, 2)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (50, 1, N'Stress Management - Guided Exercise Video', N'video', NULL, N'https://www.youtube.com/embed/z6X5oEIg6Ak', 3)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (51, 1, N'Daily Stress Journal Template', N'download', N'Download this daily stress journal template to track your stress triggers, responses, and coping strategies. Regular journaling helps identify patterns and monitor your progress.', NULL, 4)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (52, 2, N'Introduction to Mindfulness', N'article', N'Mindfulness is the practice of intentionally directing your attention to the present moment with openness and without judgment. Rooted in Buddhist traditions but thoroughly validated by modern neuroscience, mindfulness has been shown to reduce anxiety, depression, and stress while improving focus, emotional regulation, and overall wellbeing.

Core mindfulness principles:
- Present-moment awareness: focusing on what''s happening now, not past regrets or future worries
- Non-judgment: observing thoughts and feelings without labelling them as good or bad
- Acceptance: allowing experiences to be as they are without fighting them
- Beginner''s mind: approaching each moment with curiosity and openness

Research from Harvard, Oxford, and other leading institutions confirms that regular mindfulness practice (as little as 10 minutes per day) can physically change brain structure, increasing grey matter in areas associated with learning, memory, and emotional regulation.', NULL, 1)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (53, 2, N'10-Minute Body Scan Meditation', N'video', NULL, N'https://www.youtube.com/embed/dB_LkXuDEDw', 2)
INSERT [dbo].[Resources] ([ResourceID], [CourseID], [Title], [ResourceType], [Content], [URL], [OrderNum]) VALUES (54, 2, N'Mindfulness for Students - Guide', N'article', N'As a student, your mind is constantly pulled in multiple directions: lectures, assignments, social pressures, and future concerns. Mindfulness gives you the ability to choose where to direct your attention.

Simple mindfulness practices for students:
1. Mindful morning routine (5 minutes): Before checking your phone, take 5 deep breaths and set a positive intention for the day.
2. Mindful eating: During at least one meal, put away devices and eat slowly, noticing flavours, textures, and sensations.
3. Study mindfulness: Before studying, take 3 deep breaths. Notice when your mind wanders and gently redirect attention to the material.
4. Mindful walking: During breaks between classes, walk slowly and notice the sensation of each step.
5. Evening reflection (3 minutes): Before sleep, reflect on 3 things you''re grateful for from the day.', NULL, 3)
SET IDENTITY_INSERT [dbo].[Resources] OFF
GO
SET IDENTITY_INSERT [dbo].[SuccessStories] ON 

INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (1, 1, NULL, N'Aisha M.', N'Stress-Free Exam Season', N'I learned that stress is not the enemy, my reaction to it is. The 4-7-8 breathing technique became my go-to before every exam.', N'Reduced pre-exam anxiety by roughly 60%. My grades improved because I could think clearly instead of panicking.', 1, CAST(N'2026-05-17T15:48:25.840' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (2, 1, NULL, N'James T.', N'Work-Life Balance Restored', N'The time management module showed me how I was creating my own stress with unrealistic task lists. I now use the Eisenhower Matrix daily.', N'I finish work on time 4 days a week now. My evenings are genuinely relaxing again.', 1, CAST(N'2026-05-17T15:48:25.840' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (3, 1, NULL, N'Priya K.', N'Mastered Progressive Relaxation', N'Progressive muscle relaxation felt strange at first but after a week I could release tension in minutes. It changed how I end every day.', N'I fall asleep within 20 minutes now instead of lying awake worrying for an hour.', 1, CAST(N'2026-05-17T15:48:25.840' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (4, 1, NULL, N'Daniel R.', N'Cortisol Under Control', N'Understanding the science of cortisol and how chronic stress physically damages the body was a wake-up call. I take recovery seriously now.', N'My resting heart rate dropped 8 bpm over 6 weeks. My doctor noticed the improvement at my check-up.', 1, CAST(N'2026-05-17T15:48:25.840' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (5, 1, NULL, N'Siti N.', N'Daily Calm Achieved', N'The 5-4-3-2-1 grounding technique sounds simple but it genuinely works. I use it whenever I feel overwhelmed in class or at home.', N'I have not had a full panic episode in two months. I feel in control of my mind for the first time in years.', 1, CAST(N'2026-05-17T15:48:25.840' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (6, 2, NULL, N'Lena W.', N'10-Min Daily Habit Built', N'I always thought meditation needed an hour and a quiet mountain. 10 focused minutes is transformative when done consistently.', N'After 30 days of consistent practice my focus during lectures improved dramatically. I retain information so much better.', 1, CAST(N'2026-05-17T15:48:25.850' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (7, 2, NULL, N'Omar H.', N'Non-Judgement Unlocked', N'The concept of observing thoughts without labelling them as good or bad removed enormous pressure from my inner monologue.', N'I stopped catastrophising about small mistakes. My self-compassion increased and so did my productivity.', 1, CAST(N'2026-05-17T15:48:25.850' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (8, 2, NULL, N'Chloe B.', N'Mindful Eating Transformed', N'I was a speed-eater who barely tasted food. The mindful eating practice made me slow down and actually enjoy meals.', N'I eat less, enjoy food more, and no longer have afternoon energy crashes from rushing lunch.', 1, CAST(N'2026-05-17T15:48:25.850' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (9, 2, NULL, N'Raj P.', N'40% Less Phone Screen Time', N'Present-moment awareness made me realise how unconsciously I reached for my phone. I set intentional phone-free windows each day.', N'Screen time down from 6 hours to 3.5 hours daily. That time now goes to reading and actual rest.', 1, CAST(N'2026-05-17T15:48:25.850' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (10, 3, NULL, N'Emma L.', N'CBT Changed Everything', N'Cognitive restructuring showed me that my anxious thoughts were predictions, not facts. Learning to challenge them was genuinely life-changing.', N'I gave a 10-minute presentation in front of 40 people last month. Six months ago that would have been impossible.', 1, CAST(N'2026-05-17T15:48:25.860' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (11, 3, NULL, N'Haris A.', N'Social Anxiety Reduced 70%', N'The exposure hierarchy exercise was uncomfortable but it worked. Starting with low-risk social interactions and gradually building up confidence.', N'I now initiate conversations and join group discussions in tutorials. My classmates would not recognise who I was before.', 1, CAST(N'2026-05-17T15:48:25.860' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (12, 3, NULL, N'Sofia G.', N'Panic Attacks Under Control', N'Understanding that panic attacks cannot physically harm me removed a huge layer of fear. The breathing techniques interrupt the cycle early.', N'From 3-4 panic attacks a week to one minor episode in the past month. I finally feel safe in my own body.', 1, CAST(N'2026-05-17T15:48:25.860' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (13, 3, NULL, N'Ethan J.', N'Thought Record Master', N'Keeping a thought record diary for two weeks showed me I was catastrophising every assignment. The evidence never supported my worst fears.', N'Assignment anxiety dropped significantly. I submit work without the hours of paralysing what-ifs that used to precede every submission.', 1, CAST(N'2026-05-17T15:48:25.860' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (14, 4, NULL, N'Mei L.', N'From 5hrs to 8hrs Sleep', N'I had no idea light and temperature affected sleep so much. Blackout curtains and dropping room temperature added 90 minutes of sleep.', N'I wake up alert, skip the 3pm energy crash, and my mood has completely stabilised.', 1, CAST(N'2026-05-17T15:48:25.867' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (15, 4, NULL, N'Tom K.', N'No More Scrolling in Bed', N'The bed association principle was simple but powerful. I stopped using my phone in bed entirely and my brain now links bed with sleep only.', N'Fall-asleep time went from 45 minutes to under 15 minutes. I have not taken a sleeping tablet in 3 months.', 1, CAST(N'2026-05-17T15:48:25.867' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (16, 4, NULL, N'Nadia S.', N'Consistent Wake Time Wins', N'The hardest change was waking at the same time on weekends. After two weeks my circadian rhythm adjusted and I naturally felt tired at 10pm.', N'I have not used an alarm to drag myself out of bed in 6 weeks. My body wakes up on its own, rested and ready.', 1, CAST(N'2026-05-17T15:48:25.867' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (17, 4, NULL, N'Ben C.', N'Caffeine Audit Changed Sleep', N'I discovered I was drinking coffee at 4pm well within the 5-6 hour half-life window. Cutting off at noon made an immediate difference.', N'Deep sleep on my fitness tracker increased about 25% within the first week of the caffeine cut-off change.', 1, CAST(N'2026-05-17T15:48:25.867' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (18, 5, NULL, N'Fatimah R.', N'Bounced Back from Failure', N'After failing two subjects I thought my academic life was over. The growth mindset module reframed failure as data, not identity.', N'I retook both subjects and passed. More importantly I no longer fear failure. I treat it as a signal to adjust my strategy.', 1, CAST(N'2026-05-17T15:48:25.877' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (19, 5, NULL, N'Lucas M.', N'Gratitude Rewired My Brain', N'I was deeply sceptical about gratitude journaling. Writing three specific things daily felt forced for a week, then something shifted.', N'After 21 days I naturally noticed positives throughout the day. My baseline mood lifted measurably. My friends noticed before I did.', 1, CAST(N'2026-05-17T15:48:25.877' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (20, 5, NULL, N'Amara D.', N'Built My Support Network', N'The course made me realise I was trying to be resilient alone, which is exhausting. I identified five people I could be vulnerable with.', N'Having a support network means struggles feel temporary rather than permanent. I reach out now instead of isolating.', 1, CAST(N'2026-05-17T15:48:25.877' AS DateTime))
INSERT [dbo].[SuccessStories] ([StoryID], [CourseID], [UserID], [DisplayName], [Achievement], [WhatLearned], [Result], [IsApproved], [DatePosted]) VALUES (21, 5, NULL, N'Kevin O.', N'Post-Traumatic Growth', N'The journaling framework for processing difficult experiences helped me make sense of a really hard year. Writing it down externalised the pain.', N'I can talk about what happened without distress now. The experience became part of my story rather than a wound I carried.', 1, CAST(N'2026-05-17T15:48:25.877' AS DateTime))
SET IDENTITY_INSERT [dbo].[SuccessStories] OFF
GO
SET IDENTITY_INSERT [dbo].[UserProgress] ON 

INSERT [dbo].[UserProgress] ([ProgressID], [UserID], [EventType], [ReferenceID], [ProgressPct], [ScoreValue], [MinutesSpent], [RecordedAt], [CourseID], [QuizID], [ActionType], [Score], [DateCreated], [IsCompleted]) VALUES (3, 2, N'enroll', 7, 0, NULL, 5, CAST(N'2026-05-17T20:05:10.073' AS DateTime), NULL, NULL, NULL, NULL, CAST(N'2026-05-17T20:05:10.073' AS DateTime), 0)
INSERT [dbo].[UserProgress] ([ProgressID], [UserID], [EventType], [ReferenceID], [ProgressPct], [ScoreValue], [MinutesSpent], [RecordedAt], [CourseID], [QuizID], [ActionType], [Score], [DateCreated], [IsCompleted]) VALUES (4, 2, N'resource_view', 7, 50, NULL, 15, CAST(N'2026-05-17T20:05:10.087' AS DateTime), NULL, NULL, NULL, NULL, CAST(N'2026-05-17T20:05:10.087' AS DateTime), 0)
INSERT [dbo].[UserProgress] ([ProgressID], [UserID], [EventType], [ReferenceID], [ProgressPct], [ScoreValue], [MinutesSpent], [RecordedAt], [CourseID], [QuizID], [ActionType], [Score], [DateCreated], [IsCompleted]) VALUES (5, 10, N'quiz_fail', 6, 40, CAST(40.00 AS Decimal(5, 2)), 10, CAST(N'2026-05-18T17:25:17.000' AS DateTime), NULL, NULL, NULL, NULL, CAST(N'2026-05-18T17:25:17.000' AS DateTime), 0)
INSERT [dbo].[UserProgress] ([ProgressID], [UserID], [EventType], [ReferenceID], [ProgressPct], [ScoreValue], [MinutesSpent], [RecordedAt], [CourseID], [QuizID], [ActionType], [Score], [DateCreated], [IsCompleted]) VALUES (6, 10, N'enroll', 7, 0, NULL, 5, CAST(N'2026-05-18T17:28:01.707' AS DateTime), NULL, NULL, NULL, NULL, CAST(N'2026-05-18T17:28:01.707' AS DateTime), 0)
INSERT [dbo].[UserProgress] ([ProgressID], [UserID], [EventType], [ReferenceID], [ProgressPct], [ScoreValue], [MinutesSpent], [RecordedAt], [CourseID], [QuizID], [ActionType], [Score], [DateCreated], [IsCompleted]) VALUES (7, 10, N'resource_view', 7, 50, NULL, 15, CAST(N'2026-05-18T17:28:01.720' AS DateTime), NULL, NULL, NULL, NULL, CAST(N'2026-05-18T17:28:01.720' AS DateTime), 0)
INSERT [dbo].[UserProgress] ([ProgressID], [UserID], [EventType], [ReferenceID], [ProgressPct], [ScoreValue], [MinutesSpent], [RecordedAt], [CourseID], [QuizID], [ActionType], [Score], [DateCreated], [IsCompleted]) VALUES (8, 2, N'resource_view', 2, 50, NULL, 15, CAST(N'2026-05-18T21:31:36.413' AS DateTime), NULL, NULL, NULL, NULL, CAST(N'2026-05-18T21:31:36.413' AS DateTime), 0)
INSERT [dbo].[UserProgress] ([ProgressID], [UserID], [EventType], [ReferenceID], [ProgressPct], [ScoreValue], [MinutesSpent], [RecordedAt], [CourseID], [QuizID], [ActionType], [Score], [DateCreated], [IsCompleted]) VALUES (1008, 10, N'enroll', 11, 0, NULL, 5, CAST(N'2026-05-23T18:43:48.877' AS DateTime), NULL, NULL, NULL, NULL, CAST(N'2026-05-23T18:43:48.877' AS DateTime), 0)
INSERT [dbo].[UserProgress] ([ProgressID], [UserID], [EventType], [ReferenceID], [ProgressPct], [ScoreValue], [MinutesSpent], [RecordedAt], [CourseID], [QuizID], [ActionType], [Score], [DateCreated], [IsCompleted]) VALUES (1009, 10, N'resource_view', 11, 50, NULL, 15, CAST(N'2026-05-23T18:43:48.890' AS DateTime), NULL, NULL, NULL, NULL, CAST(N'2026-05-23T18:43:48.890' AS DateTime), 0)
INSERT [dbo].[UserProgress] ([ProgressID], [UserID], [EventType], [ReferenceID], [ProgressPct], [ScoreValue], [MinutesSpent], [RecordedAt], [CourseID], [QuizID], [ActionType], [Score], [DateCreated], [IsCompleted]) VALUES (1010, 10, N'quiz_pass', 10, 100, CAST(100.00 AS Decimal(5, 2)), 10, CAST(N'2026-05-23T18:46:03.690' AS DateTime), NULL, NULL, NULL, NULL, CAST(N'2026-05-23T18:46:03.690' AS DateTime), 0)
INSERT [dbo].[UserProgress] ([ProgressID], [UserID], [EventType], [ReferenceID], [ProgressPct], [ScoreValue], [MinutesSpent], [RecordedAt], [CourseID], [QuizID], [ActionType], [Score], [DateCreated], [IsCompleted]) VALUES (1011, 10, N'enroll', 17, 0, NULL, 5, CAST(N'2026-05-23T23:11:02.550' AS DateTime), NULL, NULL, NULL, NULL, CAST(N'2026-05-23T23:11:02.550' AS DateTime), 0)
INSERT [dbo].[UserProgress] ([ProgressID], [UserID], [EventType], [ReferenceID], [ProgressPct], [ScoreValue], [MinutesSpent], [RecordedAt], [CourseID], [QuizID], [ActionType], [Score], [DateCreated], [IsCompleted]) VALUES (1012, 10, N'enroll', 15, 0, NULL, 5, CAST(N'2026-05-23T23:11:38.813' AS DateTime), NULL, NULL, NULL, NULL, CAST(N'2026-05-23T23:11:38.813' AS DateTime), 0)
INSERT [dbo].[UserProgress] ([ProgressID], [UserID], [EventType], [ReferenceID], [ProgressPct], [ScoreValue], [MinutesSpent], [RecordedAt], [CourseID], [QuizID], [ActionType], [Score], [DateCreated], [IsCompleted]) VALUES (1013, 10, N'enroll', 10, 0, NULL, 5, CAST(N'2026-05-23T23:37:34.170' AS DateTime), NULL, NULL, NULL, NULL, CAST(N'2026-05-23T23:37:34.170' AS DateTime), 0)
INSERT [dbo].[UserProgress] ([ProgressID], [UserID], [EventType], [ReferenceID], [ProgressPct], [ScoreValue], [MinutesSpent], [RecordedAt], [CourseID], [QuizID], [ActionType], [Score], [DateCreated], [IsCompleted]) VALUES (1014, 10, N'resource_view', 10, 50, NULL, 15, CAST(N'2026-05-23T23:37:34.180' AS DateTime), NULL, NULL, NULL, NULL, CAST(N'2026-05-23T23:37:34.180' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[UserProgress] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [FullName], [Username], [Email], [PasswordHash], [Role], [ProfilePicture], [Bio], [DateRegistered], [IsActive]) VALUES (1, N'System Administrator', N'admin', N'admin@mindspace.com', N'e86f78a8a3caf0b60d8e74e5942aa6d86dc150cd3c03338aef25b7d2d7e3acc7', N'admin', NULL, NULL, CAST(N'2026-05-16T17:43:06.050' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [FullName], [Username], [Email], [PasswordHash], [Role], [ProfilePicture], [Bio], [DateRegistered], [IsActive]) VALUES (2, N'Alex Johnson', N'alexj', N'alex@student.apu.edu.my', N'89dfd05f08d48ad49d49a5f87fbd56f9a6f81d7347b661abf6a2208637b5ae05', N'learner', NULL, N'', CAST(N'2026-05-16T17:43:06.053' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [FullName], [Username], [Email], [PasswordHash], [Role], [ProfilePicture], [Bio], [DateRegistered], [IsActive]) VALUES (3, N'Sarah Chen', N'sarahc', N'sarah@student.apu.edu.my', N'8776f108e247ab1e2b323042c049c266407c81fbad41bde1e8dfc1bb66fd267e', N'learner', NULL, NULL, CAST(N'2026-05-16T17:43:06.053' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [FullName], [Username], [Email], [PasswordHash], [Role], [ProfilePicture], [Bio], [DateRegistered], [IsActive]) VALUES (4, N'Mohammed Ali', N'mohammedali', N'mohammed@student.apu.edu.my', N'8776f108e247ab1e2b323042c049c266407c81fbad41bde1e8dfc1bb66fd267e', N'learner', NULL, NULL, CAST(N'2026-05-16T17:43:06.053' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [FullName], [Username], [Email], [PasswordHash], [Role], [ProfilePicture], [Bio], [DateRegistered], [IsActive]) VALUES (8, N'rabiah', N'Rabiah', N'rabiahawais470@gmail.com', N'e1ca54938164121f61b6561f5898f3236fa238864eab035afb8bd81a6476f575', N'learner', NULL, NULL, CAST(N'2026-05-17T15:12:36.493' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [FullName], [Username], [Email], [PasswordHash], [Role], [ProfilePicture], [Bio], [DateRegistered], [IsActive]) VALUES (9, N'ali', N'Ruby', N'rabiahawais1@gmail.com', N'e1ca54938164121f61b6561f5898f3236fa238864eab035afb8bd81a6476f575', N'learner', NULL, NULL, CAST(N'2026-05-17T15:14:12.380' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [FullName], [Username], [Email], [PasswordHash], [Role], [ProfilePicture], [Bio], [DateRegistered], [IsActive]) VALUES (10, N'Rubyy', N'rubyy', N'ruby@gmail.com', N'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f', N'learner', NULL, N'girl', CAST(N'2026-05-18T10:43:46.293' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [UQ_Bookmark_User_Course]    Script Date: 25/5/2026 8:50:55 PM ******/
ALTER TABLE [dbo].[Bookmarks] ADD  CONSTRAINT [UQ_Bookmark_User_Course] UNIQUE NONCLUSTERED 
(
	[UserID] ASC,
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Enrollme__7B1A1BB5B5F29717]    Script Date: 25/5/2026 8:50:55 PM ******/
ALTER TABLE [dbo].[Enrollments] ADD UNIQUE NONCLUSTERED 
(
	[UserID] ASC,
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserProgress_User]    Script Date: 25/5/2026 8:50:55 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserProgress_User] ON [dbo].[UserProgress]
(
	[UserID] ASC,
	[RecordedAt] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E40A03BE99]    Script Date: 25/5/2026 8:50:55 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D10534BE3083F3]    Script Date: 25/5/2026 8:50:55 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bookmarks]  WITH CHECK ADD  CONSTRAINT [FK_Bookmarks_Courses] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Courses] ([CourseID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Bookmarks] CHECK CONSTRAINT [FK_Bookmarks_Courses]
GO
ALTER TABLE [dbo].[Bookmarks]  WITH CHECK ADD  CONSTRAINT [FK_Bookmarks_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Bookmarks] CHECK CONSTRAINT [FK_Bookmarks_Users]
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Courses] ([CourseID])
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[ForumComments]  WITH CHECK ADD FOREIGN KEY([PostID])
REFERENCES [dbo].[ForumPosts] ([PostID])
GO
ALTER TABLE [dbo].[ForumComments]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[ForumPosts]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[QuestionOptions]  WITH CHECK ADD FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Questions] ([QuestionID])
GO
ALTER TABLE [dbo].[Questions]  WITH CHECK ADD FOREIGN KEY([QuizID])
REFERENCES [dbo].[Quizzes] ([QuizID])
GO
ALTER TABLE [dbo].[QuizResults]  WITH CHECK ADD FOREIGN KEY([QuizID])
REFERENCES [dbo].[Quizzes] ([QuizID])
GO
ALTER TABLE [dbo].[QuizResults]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Quizzes]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Courses] ([CourseID])
GO
ALTER TABLE [dbo].[Resources]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Courses] ([CourseID])
GO
ALTER TABLE [dbo].[SuccessStories]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Courses] ([CourseID])
GO
ALTER TABLE [dbo].[SuccessStories]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[UserProgress]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Courses] ([CourseID])
GO
ALTER TABLE [dbo].[UserProgress]  WITH CHECK ADD FOREIGN KEY([QuizID])
REFERENCES [dbo].[Quizzes] ([QuizID])
GO
ALTER TABLE [dbo].[UserProgress]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
USE [master]
GO
ALTER DATABASE [MindSpaceDB] SET  READ_WRITE 
GO


