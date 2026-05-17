-- =============================================
-- MindSpace Mental Health Learning Portal
-- Database: MindSpaceDB
-- Group G29 | APU CT050-3-2-WAPP
-- =============================================

CREATE DATABASE MindSpaceDB;
GO

USE MindSpaceDB;
GO

-- =============================================
-- TABLE: Users
-- =============================================
CREATE TABLE Users (
    UserID      INT IDENTITY(1,1) PRIMARY KEY,
    FullName    NVARCHAR(100) NOT NULL,
    Username    NVARCHAR(50)  NOT NULL UNIQUE,
    Email       NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role        NVARCHAR(20)  NOT NULL DEFAULT 'learner',  -- 'learner', 'admin'
    ProfilePicture NVARCHAR(255) NULL,
    Bio         NVARCHAR(MAX) NULL,
    DateRegistered DATETIME DEFAULT GETDATE(),
    IsActive    BIT DEFAULT 1
);

-- =============================================
-- TABLE: Courses
-- =============================================
CREATE TABLE Courses (
    CourseID        INT IDENTITY(1,1) PRIMARY KEY,
    Title           NVARCHAR(200) NOT NULL,
    Description     NVARCHAR(MAX),
    Category        NVARCHAR(100),  -- 'Stress Management','Mindfulness','Anxiety','Sleep Hygiene','Resilience'
    ThumbnailURL    NVARCHAR(255),
    DifficultyLevel NVARCHAR(50),   -- 'Beginner','Intermediate','Advanced'
    Duration        NVARCHAR(50),   -- e.g. '4 weeks'
    IsActive        BIT DEFAULT 1,
    CreatedBy       INT NULL FOREIGN KEY REFERENCES Users(UserID),
    DateCreated     DATETIME DEFAULT GETDATE()
);

-- =============================================
-- TABLE: Enrollments
-- =============================================
CREATE TABLE Enrollments (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    UserID       INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
    CourseID     INT NOT NULL FOREIGN KEY REFERENCES Courses(CourseID),
    EnrollDate   DATETIME DEFAULT GETDATE(),
    Progress     INT DEFAULT 0,       -- 0–100 percent
    IsCompleted  BIT DEFAULT 0,
    UNIQUE (UserID, CourseID)
);

-- =============================================
-- TABLE: Resources
-- =============================================
CREATE TABLE Resources (
    ResourceID   INT IDENTITY(1,1) PRIMARY KEY,
    CourseID     INT NOT NULL FOREIGN KEY REFERENCES Courses(CourseID),
    Title        NVARCHAR(200) NOT NULL,
    ResourceType NVARCHAR(50),   -- 'article','video','download'
    Content      NVARCHAR(MAX),
    URL          NVARCHAR(500),
    OrderNum     INT DEFAULT 0
);

-- =============================================
-- TABLE: Quizzes
-- =============================================
CREATE TABLE Quizzes (
    QuizID       INT IDENTITY(1,1) PRIMARY KEY,
    CourseID     INT NOT NULL FOREIGN KEY REFERENCES Courses(CourseID),
    Title        NVARCHAR(200) NOT NULL,
    Description  NVARCHAR(MAX),
    PassingScore INT DEFAULT 60
);

-- =============================================
-- TABLE: Questions
-- =============================================
CREATE TABLE Questions (
    QuestionID   INT IDENTITY(1,1) PRIMARY KEY,
    QuizID       INT NOT NULL FOREIGN KEY REFERENCES Quizzes(QuizID),
    QuestionText NVARCHAR(MAX) NOT NULL,
    QuestionType NVARCHAR(20) DEFAULT 'multiple',  -- 'multiple','truefalse'
    CorrectAnswer NVARCHAR(255) NOT NULL,
    OrderNum     INT DEFAULT 0
);

-- =============================================
-- TABLE: QuestionOptions
-- =============================================
CREATE TABLE QuestionOptions (
    OptionID    INT IDENTITY(1,1) PRIMARY KEY,
    QuestionID  INT NOT NULL FOREIGN KEY REFERENCES Questions(QuestionID),
    OptionLabel CHAR(1) NOT NULL,  -- A, B, C, D
    OptionText  NVARCHAR(500) NOT NULL
);

-- =============================================
-- TABLE: QuizResults
-- =============================================
CREATE TABLE QuizResults (
    ResultID       INT IDENTITY(1,1) PRIMARY KEY,
    UserID         INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
    QuizID         INT NOT NULL FOREIGN KEY REFERENCES Quizzes(QuizID),
    Score          INT NOT NULL,
    TotalQuestions INT NOT NULL,
    Percentage     DECIMAL(5,2),
    Feedback       NVARCHAR(MAX),
    DateTaken      DATETIME DEFAULT GETDATE()
);

-- =============================================
-- TABLE: SuccessStories
-- =============================================
CREATE TABLE SuccessStories (
    StoryID       INT IDENTITY(1,1) PRIMARY KEY,
    CourseID      INT NOT NULL FOREIGN KEY REFERENCES Courses(CourseID),
    UserID        INT NULL FOREIGN KEY REFERENCES Users(UserID),
    DisplayName   NVARCHAR(100)  NOT NULL,
    Achievement   NVARCHAR(200)  NOT NULL,
    WhatLearned   NVARCHAR(MAX)  NOT NULL,
    Result        NVARCHAR(MAX)  NOT NULL,
    IsApproved    BIT NOT NULL DEFAULT 1,
    DatePosted    DATETIME NOT NULL DEFAULT GETDATE()
);

-- =============================================
-- TABLE: ForumPosts
-- =============================================
CREATE TABLE ForumPosts (
    PostID      INT IDENTITY(1,1) PRIMARY KEY,
    UserID      INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
    Title       NVARCHAR(200) NOT NULL,
    Content     NVARCHAR(MAX) NOT NULL,
    DatePosted  DATETIME DEFAULT GETDATE(),
    IsActive    BIT DEFAULT 1,
    ViewCount   INT DEFAULT 0,
    IsResolved  BIT DEFAULT 0,
    EditedAt    DATETIME NULL
);

-- =============================================
-- TABLE: UserProgress  (activity / progress events log)
-- =============================================
CREATE TABLE UserProgress (
    ProgressID   INT IDENTITY(1,1) PRIMARY KEY,
    UserID       INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
    CourseID     INT NULL FOREIGN KEY REFERENCES Courses(CourseID),
    QuizID       INT NULL FOREIGN KEY REFERENCES Quizzes(QuizID),
    ActionType   NVARCHAR(50)   NULL,       -- 'enroll','quiz_pass','quiz_fail','forum_post','resource_view','course_complete'
    Score        DECIMAL(5,2)   NULL,       -- quiz percentage score (0–100)
    DateCreated  DATETIME NOT NULL DEFAULT GETDATE(),
    IsCompleted  BIT NOT NULL DEFAULT 0,    -- 1 when event represents a completion milestone
    -- Legacy / extended columns kept for backward compatibility
    EventType    NVARCHAR(50)   NOT NULL DEFAULT '',
    ReferenceID  INT            NULL,       -- CourseID or QuizID depending on EventType
    ProgressPct  INT            NULL,       -- course completion % at time of event
    ScoreValue   DECIMAL(5,2)   NULL,       -- alias of Score, kept for existing queries
    MinutesSpent INT NOT NULL DEFAULT 0,    -- estimated minutes for this activity
    RecordedAt   DATETIME NOT NULL DEFAULT GETDATE()
);
CREATE INDEX IX_UserProgress_User ON UserProgress (UserID, RecordedAt DESC);

-- =============================================
-- TABLE: ForumComments
-- =============================================
CREATE TABLE ForumComments (
    CommentID  INT IDENTITY(1,1) PRIMARY KEY,
    PostID     INT NOT NULL FOREIGN KEY REFERENCES ForumPosts(PostID),
    UserID     INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
    Content    NVARCHAR(MAX) NOT NULL,
    DatePosted DATETIME DEFAULT GETDATE(),
    IsActive   BIT DEFAULT 1,
    EditedAt   DATETIME NULL
);
GO

-- =============================================
-- SAMPLE DATA
-- =============================================

-- Admin user (password = "Admin@123" — SHA256 hash pre-computed)
-- After running this script, register via the app with email admin@mindspace.com
-- then run: UPDATE Users SET Role='admin' WHERE Email='admin@mindspace.com';
-- OR use the hash below (SHA256 of "Admin@123"):
INSERT INTO Users (FullName, Username, Email, PasswordHash, Role)
VALUES (
    'System Administrator',
    'admin',
    'admin@mindspace.com',
    'e86f78a8a3caf0b60d8e74e5942aa6d86dc150cd3c03338aef25b7d2d7e3acc7',
    'admin'
);

-- Sample learner accounts (password = "Test@123")
INSERT INTO Users (FullName, Username, Email, PasswordHash, Role)
VALUES
('Alex Johnson', 'alexj', 'alex@student.apu.edu.my',
 '8776f108e247ab1e2b323042c049c266407c81fbad41bde1e8dfc1bb66fd267e', 'learner'),
('Sarah Chen', 'sarahc', 'sarah@student.apu.edu.my',
 '8776f108e247ab1e2b323042c049c266407c81fbad41bde1e8dfc1bb66fd267e', 'learner'),
('Mohammed Ali', 'mohammedali', 'mohammed@student.apu.edu.my',
 '8776f108e247ab1e2b323042c049c266407c81fbad41bde1e8dfc1bb66fd267e', 'learner');

-- Learner password hash above is SHA256("Test@123").
-- To set a known admin password, register via the app then UPDATE Role.

-- Sample Courses
INSERT INTO Courses (Title, Description, Category, DifficultyLevel, Duration, CreatedBy)
VALUES
(
    'Stress Management Fundamentals',
    'Learn evidence-based techniques to identify, manage, and reduce stress in your daily life. This course covers the science of stress, practical coping strategies, time management, and relaxation techniques.',
    'Stress Management', 'Beginner', '4 weeks', 1
),
(
    'Mindfulness & Meditation',
    'Explore the practice of mindfulness and meditation to cultivate present-moment awareness, reduce anxiety, and improve focus. Includes guided exercises and daily practice routines.',
    'Mindfulness', 'Beginner', '6 weeks', 1
),
(
    'Understanding Anxiety',
    'A comprehensive guide to understanding anxiety disorders, their causes, symptoms, and effective management strategies. Learn cognitive-behavioural techniques to challenge anxious thoughts.',
    'Anxiety', 'Intermediate', '5 weeks', 1
),
(
    'Sleep Hygiene & Restoration',
    'Discover the critical role of sleep in mental health and learn practical strategies to improve sleep quality, establish healthy routines, and overcome common sleep challenges.',
    'Sleep Hygiene', 'Beginner', '3 weeks', 1
),
(
    'Building Emotional Resilience',
    'Develop the skills to bounce back from adversity, manage difficult emotions, and thrive under pressure. This course teaches resilience frameworks used by mental health professionals.',
    'Resilience', 'Intermediate', '8 weeks', 1
);

-- Sample Resources for Course 1 (Stress Management)
INSERT INTO Resources (CourseID, Title, ResourceType, Content, URL, OrderNum)
VALUES
(1, 'What is Stress? The Science Behind It', 'article',
 'Stress is the body''s response to any demand or challenge. When you encounter a stressor — whether physical, emotional, or psychological — your body activates the "fight-or-flight" response. Cortisol and adrenaline are released, increasing heart rate, blood pressure, and alerting your senses.

While acute stress can be beneficial (helping you meet deadlines or avoid danger), chronic stress damages physical and mental health. Signs of chronic stress include: persistent headaches, fatigue, irritability, difficulty concentrating, and disrupted sleep.

Understanding your stress triggers is the first step toward effective management. Common triggers for students include: academic pressure, financial concerns, relationship issues, and uncertainty about the future.

The good news: stress is manageable. With the right tools and consistent practice, you can build resilience and reduce the impact of stress on your wellbeing.',
 NULL, 1),
(1, '5 Immediate Stress Relief Techniques', 'article',
 '1. Deep Breathing (4-7-8 Technique): Inhale for 4 counts, hold for 7, exhale for 8. This activates the parasympathetic nervous system and calms your body within minutes.

2. Progressive Muscle Relaxation: Tense each muscle group for 5 seconds, then release. Start from your toes and work upward. This reduces physical tension associated with stress.

3. The 5-4-3-2-1 Grounding Technique: Name 5 things you can see, 4 you can touch, 3 you can hear, 2 you can smell, 1 you can taste. This anchors you to the present moment.

4. Cold Water Splash: Splash cold water on your face. This activates the dive reflex and can reduce heart rate rapidly.

5. Brief Physical Activity: Even a 10-minute walk releases endorphins that combat stress hormones.',
 NULL, 2),
(1, 'How to Make Stress Your Friend - Kelly McGonigal (TED)', 'video',
 NULL, 'https://www.youtube.com/embed/RcGyVTAoXEU', 3),
(1, 'Daily Stress Journal Template', 'download',
 'Download this daily stress journal template to track your stress triggers, responses, and coping strategies. Regular journaling helps identify patterns and monitor your progress.',
 '/Content/Downloads/stress-journal-template.html', 4);

-- Sample Resources for Course 2 (Mindfulness)
INSERT INTO Resources (CourseID, Title, ResourceType, Content, URL, OrderNum)
VALUES
(2, 'Introduction to Mindfulness', 'article',
 'Mindfulness is the practice of intentionally directing your attention to the present moment with openness and without judgment. Rooted in Buddhist traditions but thoroughly validated by modern neuroscience, mindfulness has been shown to reduce anxiety, depression, and stress while improving focus, emotional regulation, and overall wellbeing.

Core mindfulness principles:
- Present-moment awareness: focusing on what''s happening now, not past regrets or future worries
- Non-judgment: observing thoughts and feelings without labelling them as good or bad
- Acceptance: allowing experiences to be as they are without fighting them
- Beginner''s mind: approaching each moment with curiosity and openness

Research from Harvard, Oxford, and other leading institutions confirms that regular mindfulness practice (as little as 10 minutes per day) can physically change brain structure, increasing grey matter in areas associated with learning, memory, and emotional regulation.',
 NULL, 1),
(2, 'All It Takes Is 10 Mindful Minutes - Andy Puddicombe (TED)', 'video',
 NULL, 'https://www.youtube.com/embed/qzR62JJCMBQ', 2),
(2, 'Mindfulness for Students - Guide', 'article',
 'As a student, your mind is constantly pulled in multiple directions: lectures, assignments, social pressures, and future concerns. Mindfulness gives you the ability to choose where to direct your attention.

Simple mindfulness practices for students:
1. Mindful morning routine (5 minutes): Before checking your phone, take 5 deep breaths and set a positive intention for the day.
2. Mindful eating: During at least one meal, put away devices and eat slowly, noticing flavours, textures, and sensations.
3. Study mindfulness: Before studying, take 3 deep breaths. Notice when your mind wanders and gently redirect attention to the material.
4. Mindful walking: During breaks between classes, walk slowly and notice the sensation of each step.
5. Evening reflection (3 minutes): Before sleep, reflect on 3 things you''re grateful for from the day.',
 NULL, 3);

-- =============================================
-- QUIZ 1: Understanding Anxiety (CourseID=3)
-- =============================================
INSERT INTO Quizzes (CourseID, Title, Description, PassingScore)
VALUES (3, 'Understanding Anxiety', 'Test your knowledge about anxiety, its causes, and management techniques.', 70);

INSERT INTO Questions (QuizID, QuestionText, QuestionType, CorrectAnswer, OrderNum) VALUES
(1, 'What is anxiety?', 'multichoice', 'A', 1),
(1, 'Which breathing technique helps reduce anxiety?', 'multichoice', 'B', 2),
(1, 'Anxiety disorder affects what percentage of adults?', 'multichoice', 'C', 3);

INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText) VALUES
(1, 'A', 'A persistent feeling of worry about future events'),
(1, 'B', 'A temporary emotion only experienced by anxious people'),
(1, 'C', 'A sign of weakness'),
(1, 'D', 'Something that never goes away'),
(2, 'A', 'Holding your breath'),
(2, 'B', 'Box breathing (4-4-4-4)'),
(2, 'C', 'Breathing quickly'),
(2, 'D', 'None of the above'),
(3, 'A', '2%'),
(3, 'B', '5%'),
(3, 'C', '19%'),
(3, 'D', '50%');

-- =============================================
-- QUIZ 2: Mindfulness & Meditation (CourseID=2)
-- =============================================
INSERT INTO Quizzes (CourseID, Title, Description, PassingScore)
VALUES (2, 'Mindfulness & Meditation', 'Test your understanding of mindfulness principles and meditation practices.', 70);

INSERT INTO Questions (QuizID, QuestionText, QuestionType, CorrectAnswer, OrderNum) VALUES
(2, 'What is mindfulness?', 'multichoice', 'A', 1),
(2, 'How long should beginners meditate daily?', 'multichoice', 'B', 2),
(2, 'Which sense is commonly used in grounding technique 5-4-3-2-1?', 'multichoice', 'B', 3);

INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText) VALUES
(4, 'A', 'Paying attention to the present moment without judgment'),
(4, 'B', 'Thinking about the future'),
(4, 'C', 'Worrying about the past'),
(4, 'D', 'Ignoring your surroundings'),
(5, 'A', '30 minutes'),
(5, 'B', '5-10 minutes'),
(5, 'C', '2 hours'),
(5, 'D', 'Meditation time does not matter'),
(6, 'A', 'Only sight'),
(6, 'B', 'All five senses'),
(6, 'C', 'Only touch'),
(6, 'D', 'Only hearing');

-- =============================================
-- QUIZ 3: Stress Management (CourseID=1)
-- =============================================
INSERT INTO Quizzes (CourseID, Title, Description, PassingScore)
VALUES (1, 'Stress Management', 'Assess your knowledge of stress causes, effects, and healthy coping strategies.', 70);

INSERT INTO Questions (QuizID, QuestionText, QuestionType, CorrectAnswer, OrderNum) VALUES
(3, 'What is the main cause of stress?', 'multichoice', 'A', 1),
(3, 'Which of these is a healthy stress management technique?', 'multichoice', 'A', 2),
(3, 'What is the stress hormone called?', 'multichoice', 'B', 3);

INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText) VALUES
(7, 'A', 'Our perception of events'),
(7, 'B', 'The events themselves only'),
(7, 'C', 'Other people'),
(7, 'D', 'Work only'),
(8, 'A', 'Exercise and deep breathing'),
(8, 'B', 'Avoiding the problem'),
(8, 'C', 'Drinking alcohol'),
(8, 'D', 'Overworking'),
(9, 'A', 'Serotonin'),
(9, 'B', 'Cortisol'),
(9, 'C', 'Dopamine'),
(9, 'D', 'Adrenaline only');

-- =============================================
-- QUIZ 4: Sleep Hygiene (CourseID=4)
-- =============================================
INSERT INTO Quizzes (CourseID, Title, Description, PassingScore)
VALUES (4, 'Sleep Hygiene', 'Test your knowledge about healthy sleep habits and rest optimization.', 70);

INSERT INTO Questions (QuizID, QuestionText, QuestionType, CorrectAnswer, OrderNum) VALUES
(4, 'How many hours of sleep does an adult need?', 'multichoice', 'B', 1),
(4, 'What should you avoid before bed?', 'multichoice', 'D', 2),
(4, 'What is the best room temperature for sleep?', 'multichoice', 'B', 3);

INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText) VALUES
(10, 'A', '4-5 hours'),
(10, 'B', '7-9 hours'),
(10, 'C', '10-12 hours'),
(10, 'D', 'Sleep duration does not matter'),
(11, 'A', 'Blue light from screens'),
(11, 'B', 'Caffeine'),
(11, 'C', 'Heavy meals'),
(11, 'D', 'All of the above'),
(12, 'A', '75 degrees F (24 degrees C)'),
(12, 'B', '65-68 degrees F (18-20 degrees C)'),
(12, 'C', '80 degrees F (27 degrees C)'),
(12, 'D', 'Any temperature is fine');

-- =============================================
-- QUIZ 5: Emotional Resilience (CourseID=5)
-- =============================================
INSERT INTO Quizzes (CourseID, Title, Description, PassingScore)
VALUES (5, 'Emotional Resilience', 'Assess your understanding of emotional resilience and coping mechanisms.', 70);

INSERT INTO Questions (QuizID, QuestionText, QuestionType, CorrectAnswer, OrderNum) VALUES
(5, 'What is emotional resilience?', 'multichoice', 'B', 1),
(5, 'Which factor builds emotional resilience?', 'multichoice', 'D', 2),
(5, 'What is a healthy coping mechanism?', 'multichoice', 'D', 3);

INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText) VALUES
(13, 'A', 'Never feeling sad'),
(13, 'B', 'The ability to bounce back from adversity'),
(13, 'C', 'Ignoring problems'),
(13, 'D', 'Being emotionless'),
(14, 'A', 'Social support'),
(14, 'B', 'Self-care'),
(14, 'C', 'Positive thinking'),
(14, 'D', 'All of the above'),
(15, 'A', 'Journaling'),
(15, 'B', 'Talking to friends'),
(15, 'C', 'Exercise'),
(15, 'D', 'All of the above');

-- Extended quiz questions: 12 more per quiz (60 total new questions)
-- Run only if questions 16+ do not yet exist
IF NOT EXISTS (SELECT 1 FROM Questions WHERE OrderNum=4)
BEGIN

-- QUIZ 1: Understanding Anxiety (QuizID=1, OrderNum 4-15)
DECLARE @q INT;

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (1,'What is Generalized Anxiety Disorder (GAD)?','multiple_choice','C',4);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','A phobia of specific objects or situations'),
(@q,'B','Anxiety that occurs only in social settings'),
(@q,'C','Persistent, excessive worry about many different areas of life'),
(@q,'D','A short-term stress response to immediate danger');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (1,'Which of the following is a cognitive symptom of anxiety?','multiple_choice','B',5);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Rapid heartbeat'),
(@q,'B','Racing or intrusive thoughts'),
(@q,'C','Sweating'),
(@q,'D','Muscle tension');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (1,'CBT stands for?','multiple_choice','A',6);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Cognitive Behavioral Therapy'),
(@q,'B','Cognitive Brain Training'),
(@q,'C','Clinical Behavioral Technique'),
(@q,'D','Comprehensive Breathing Therapy');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (1,'Which neurotransmitter, when low, is most associated with anxiety?','multiple_choice','D',7);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Dopamine'),
(@q,'B','Serotonin'),
(@q,'C','Norepinephrine'),
(@q,'D','GABA');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (1,'The fight-or-flight response is triggered by which brain structure?','multiple_choice','B',8);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Hippocampus'),
(@q,'B','Amygdala'),
(@q,'C','Prefrontal cortex'),
(@q,'D','Cerebellum');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (1,'Social anxiety disorder primarily involves fear of?','multiple_choice','A',9);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Negative evaluation or judgment by others'),
(@q,'B','Open spaces'),
(@q,'C','Physical illness'),
(@q,'D','Contamination');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (1,'What best describes a panic attack?','multiple_choice','C',10);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','A mild feeling of worry lasting several days'),
(@q,'B','Persistent low mood and loss of interest'),
(@q,'C','A sudden surge of intense fear with physical symptoms peaking within minutes'),
(@q,'D','A phobic response triggered by a specific object');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (1,'What is the key difference between fear and anxiety?','multiple_choice','B',11);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Fear is internal; anxiety is external'),
(@q,'B','Fear responds to present danger; anxiety is directed toward future threats'),
(@q,'C','Fear is healthy; anxiety is always unhealthy'),
(@q,'D','There is no meaningful difference');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (1,'Which therapy has the strongest evidence base for treating anxiety disorders?','multiple_choice','A',12);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Cognitive Behavioral Therapy (CBT)'),
(@q,'B','Hypnotherapy'),
(@q,'C','Psychoanalysis'),
(@q,'D','Art therapy');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (1,'Exposure therapy for anxiety works by?','multiple_choice','D',13);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Avoiding feared situations permanently'),
(@q,'B','Taking medication before facing fears'),
(@q,'C','Replacing anxious thoughts with positive affirmations'),
(@q,'D','Gradually confronting feared situations until anxiety reduces');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (1,'Mindfulness helps reduce anxiety primarily by?','multiple_choice','C',14);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Eliminating all negative thoughts'),
(@q,'B','Increasing the speed of the stress response'),
(@q,'C','Increasing present-moment awareness and reducing rumination'),
(@q,'D','Suppressing emotional responses');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (1,'Which lifestyle factor most significantly reduces anxiety symptoms over time?','multiple_choice','B',15);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Sleeping more than 10 hours per night'),
(@q,'B','Regular aerobic exercise'),
(@q,'C','Drinking herbal tea'),
(@q,'D','Avoiding all social situations');

-- QUIZ 2: Mindfulness & Meditation (QuizID=2, OrderNum 4-15)

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (2,'What type of meditation focuses sustained attention on a single object such as the breath?','multiple_choice','A',4);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Focused attention meditation'),
(@q,'B','Open monitoring meditation'),
(@q,'C','Loving-kindness meditation'),
(@q,'D','Body scan meditation');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (2,'MBSR stands for?','multiple_choice','C',5);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Mindful Breathing and Stress Relief'),
(@q,'B','Mind-Body Stress Recovery'),
(@q,'C','Mindfulness-Based Stress Reduction'),
(@q,'D','Meditative Brain Self-Regulation');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (2,'Research shows that regular meditation increases grey matter density in which brain region?','multiple_choice','B',6);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Amygdala'),
(@q,'B','Prefrontal cortex'),
(@q,'C','Brain stem'),
(@q,'D','Cerebellum');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (2,'Body scan meditation involves?','multiple_choice','D',7);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Scanning your environment for sources of danger'),
(@q,'B','Rapid movement through yoga poses'),
(@q,'C','Counting breaths from 1 to 10 repeatedly'),
(@q,'D','Systematically moving attention through different parts of the body');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (2,'Loving-kindness (Metta) meditation is primarily designed to cultivate?','multiple_choice','A',8);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Compassion and goodwill toward self and others'),
(@q,'B','Deep physical relaxation'),
(@q,'C','Focused concentration on a mantra'),
(@q,'D','Awareness of bodily sensations');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (2,'How does regular mindfulness practice affect the amygdala?','multiple_choice','C',9);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','It enlarges the amygdala, improving threat detection'),
(@q,'B','It has no effect on amygdala activity'),
(@q,'C','It reduces amygdala reactivity, lowering stress responses'),
(@q,'D','It transfers amygdala function to the hippocampus');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (2,'Open monitoring meditation differs from focused attention meditation in that it?','multiple_choice','B',10);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Requires eyes to remain open at all times'),
(@q,'B','Involves observing all arising thoughts and sensations without attachment'),
(@q,'C','Uses a specific mantra or sound'),
(@q,'D','Is only practised while walking');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (2,'What is the default mode network (DMN)?','multiple_choice','D',11);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','The neural pathway responsible for voluntary movement'),
(@q,'B','A network activated only during sleep'),
(@q,'C','The brain system responsible for processing sensory input'),
(@q,'D','A brain network active during mind-wandering and self-referential thought');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (2,'Research shows mindfulness-based interventions reduce symptoms of?','multiple_choice','D',12);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Depression only'),
(@q,'B','Anxiety only'),
(@q,'C','Chronic pain only'),
(@q,'D','Depression, anxiety, and chronic pain');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (2,'What does "beginner''s mind" mean in mindfulness practice?','multiple_choice','A',13);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Approaching each experience with openness, as if encountering it for the first time'),
(@q,'B','Only practising meditation if you are a beginner'),
(@q,'C','Thinking like a child'),
(@q,'D','Starting each session with no technique');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (2,'Slow, mindful breathing reduces anxiety because?','multiple_choice','B',14);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','It increases carbon dioxide levels dangerously'),
(@q,'B','It activates the parasympathetic nervous system, countering fight-or-flight'),
(@q,'C','It reduces oxygen to the brain'),
(@q,'D','It stops all anxious thoughts immediately');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (2,'A standard MBSR program is how many weeks long?','multiple_choice','C',15);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','4 weeks'),
(@q,'B','6 weeks'),
(@q,'C','8 weeks'),
(@q,'D','12 weeks');

-- QUIZ 3: Stress Management (QuizID=3, OrderNum 4-15)

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (3,'What is eustress?','multiple_choice','B',4);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','A severe form of chronic stress'),
(@q,'B','Positive, motivating stress that enhances performance'),
(@q,'C','Stress caused by external events only'),
(@q,'D','The absence of any stress');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (3,'The parasympathetic nervous system is also called?','multiple_choice','C',5);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Fight-or-flight system'),
(@q,'B','Central processing system'),
(@q,'C','Rest-and-digest system'),
(@q,'D','Arousal system');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (3,'In Selye''s General Adaptation Syndrome, what happens during the Exhaustion stage?','multiple_choice','D',6);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','The body mobilises its resources for the first time'),
(@q,'B','The body successfully adapts and functions normally'),
(@q,'C','Stress hormones reach their peak levels'),
(@q,'D','The body''s resources are depleted and vulnerability to illness increases');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (3,'Chronic stress most directly suppresses which body system?','multiple_choice','A',7);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','The immune system'),
(@q,'B','The digestive system'),
(@q,'C','The skeletal system'),
(@q,'D','The endocrine system');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (3,'The Pomodoro Technique uses focused work intervals of?','multiple_choice','C',8);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','10 minutes'),
(@q,'B','20 minutes'),
(@q,'C','25 minutes'),
(@q,'D','50 minutes');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (3,'The relaxation response described by Dr. Herbert Benson is best defined as?','multiple_choice','B',9);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','A sudden burst of energy after rest'),
(@q,'B','A physiological state of deep rest opposite to the fight-or-flight response'),
(@q,'C','Falling asleep under stress'),
(@q,'D','A mental state of ignoring stressors');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (3,'Social support reduces stress because it?','multiple_choice','D',10);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Removes the source of stress'),
(@q,'B','Provides emotional comfort'),
(@q,'C','Offers practical help and information'),
(@q,'D','Provides emotional, informational, and practical help');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (3,'Expressive journaling reduces stress primarily by?','multiple_choice','A',11);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Externalising thoughts, gaining perspective, and processing emotions'),
(@q,'B','Keeping secrets away from others'),
(@q,'C','Reinforcing negative thought patterns'),
(@q,'D','Replacing physical exercise');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (3,'Which breathing pattern most effectively activates the relaxation response?','multiple_choice','B',12);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Rapid shallow chest breathing'),
(@q,'B','Slow, deep diaphragmatic breathing with a longer exhale than inhale'),
(@q,'C','Holding the breath for 30 seconds'),
(@q,'D','Breathing through the mouth only');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (3,'Cognitive reframing helps manage stress by?','multiple_choice','C',13);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Denying that a stressor exists'),
(@q,'B','Avoiding thinking about the stressor'),
(@q,'C','Changing how you interpret or assign meaning to a stressful situation'),
(@q,'D','Expressing anger toward the stressor');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (3,'What percentage of doctor visits are estimated to be stress-related?','multiple_choice','D',14);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','20-30%'),
(@q,'B','40-50%'),
(@q,'C','55-65%'),
(@q,'D','75-90%');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (3,'Progressive Muscle Relaxation (PMR) works by?','multiple_choice','A',15);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Systematically tensing and releasing muscle groups to reduce physical tension'),
(@q,'B','Stretching muscles as far as possible and holding'),
(@q,'C','Massaging each muscle group for 5 minutes'),
(@q,'D','Applying heat packs to tense muscles');

-- QUIZ 4: Sleep Hygiene (QuizID=4, OrderNum 4-15)

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (4,'REM sleep is primarily important for?','multiple_choice','C',4);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Physical repair of muscles and tissues'),
(@q,'B','Releasing growth hormone'),
(@q,'C','Memory consolidation and emotional processing'),
(@q,'D','Detoxifying the liver');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (4,'What is sleep latency?','multiple_choice','B',5);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','The total number of hours slept'),
(@q,'B','The time it takes to fall asleep after lights out'),
(@q,'C','The number of times you wake during the night'),
(@q,'D','The duration of REM sleep');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (4,'Which hormone primarily regulates the sleep-wake cycle?','multiple_choice','A',6);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Melatonin'),
(@q,'B','Cortisol'),
(@q,'C','Insulin'),
(@q,'D','Adrenaline');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (4,'Insomnia is clinically defined as difficulty sleeping at least how many nights per week?','multiple_choice','D',7);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','1 night per week'),
(@q,'B','2 nights per week'),
(@q,'C','2-3 nights per week with mild daytime impact'),
(@q,'D','3 or more nights per week for at least 3 months');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (4,'Sleep apnea is characterised by?','multiple_choice','B',8);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Excessive daytime sleepiness without nighttime disturbances'),
(@q,'B','Repeated pauses in breathing during sleep, often with snoring'),
(@q,'C','Difficulty falling asleep due to racing thoughts'),
(@q,'D','Walking or talking during sleep');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (4,'To avoid disrupting sleep, caffeine should be avoided at least how long before bedtime?','multiple_choice','C',9);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','1 hour before bed'),
(@q,'B','2-3 hours before bed'),
(@q,'C','6 hours before bed'),
(@q,'D','Caffeine has no effect on sleep');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (4,'The human circadian rhythm operates on approximately what cycle?','multiple_choice','A',10);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','24 hours'),
(@q,'B','12 hours'),
(@q,'C','48 hours'),
(@q,'D','It varies widely between individuals');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (4,'Which sleep stage is the deepest and most physically restorative?','multiple_choice','D',11);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Stage 1 (N1) - light sleep'),
(@q,'B','Stage 2 (N2) - sleep spindles'),
(@q,'C','REM sleep'),
(@q,'D','Stage 3 (N3) - slow-wave or deep sleep');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (4,'Blue light from screens disrupts sleep primarily by?','multiple_choice','B',12);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Causing eye strain that makes falling asleep painful'),
(@q,'B','Suppressing melatonin production, signalling the brain it is still daytime'),
(@q,'C','Increasing body temperature'),
(@q,'D','Stimulating the digestive system');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (4,'Cognitive Behavioral Therapy for Insomnia (CBT-I) primarily works by?','multiple_choice','C',13);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Prescribing sleep medication'),
(@q,'B','Eliminating all daytime activities'),
(@q,'C','Changing thoughts, beliefs, and behaviours that interfere with quality sleep'),
(@q,'D','Increasing time spent in bed to force more sleep');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (4,'What is the recommended duration for a beneficial daytime nap?','multiple_choice','A',14);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','10-20 minutes (power nap)'),
(@q,'B','45-60 minutes'),
(@q,'C','90-120 minutes'),
(@q,'D','Duration does not matter as long as you feel rested');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (4,'Why is maintaining a consistent wake time important for sleep quality?','multiple_choice','D',15);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','It allows you to maximise total time in bed'),
(@q,'B','It ensures you always feel rested immediately upon waking'),
(@q,'C','It reduces the need for melatonin'),
(@q,'D','It anchors the circadian rhythm, making it easier to fall and stay asleep');

-- QUIZ 5: Emotional Resilience (QuizID=5, OrderNum 4-15)

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (5,'The PERMA model of wellbeing was developed by?','multiple_choice','B',4);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Abraham Maslow'),
(@q,'B','Martin Seligman'),
(@q,'C','Viktor Frankl'),
(@q,'D','Carl Rogers');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (5,'Post-traumatic growth (PTG) refers to?','multiple_choice','C',5);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','The inevitable psychological damage caused by trauma'),
(@q,'B','A return to baseline functioning after a traumatic event'),
(@q,'C','Positive psychological change and personal development following adversity'),
(@q,'D','A therapeutic technique for treating PTSD');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (5,'Emotional regulation refers to?','multiple_choice','A',6);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Managing the intensity, duration, and expression of emotions adaptively'),
(@q,'B','Suppressing all negative emotions'),
(@q,'C','Only experiencing positive emotions'),
(@q,'D','Avoiding situations that trigger emotions');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (5,'Self-compassion differs from self-esteem in that self-compassion?','multiple_choice','D',7);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Requires you to feel better than others'),
(@q,'B','Depends on achieving goals'),
(@q,'C','Is only relevant during moments of success'),
(@q,'D','Does not depend on performance, comparison, or outcome');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (5,'Which factor is most consistently protective against occupational burnout?','multiple_choice','B',8);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','High income'),
(@q,'B','Strong social support and meaningful work'),
(@q,'C','Working fewer than 30 hours per week'),
(@q,'D','Having a high IQ');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (5,'The window of tolerance in trauma therapy refers to?','multiple_choice','C',9);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','The time frame in which trauma therapy is most effective'),
(@q,'B','A person''s ability to tolerate physical pain'),
(@q,'C','The optimal zone of arousal in which a person can function and process experience'),
(@q,'D','The maximum duration of a therapy session');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (5,'Neuroplasticity supports resilience because?','multiple_choice','A',10);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','The brain can reorganise, form new connections, and adapt following adversity'),
(@q,'B','The brain shrinks in size when stressed, improving efficiency'),
(@q,'C','Neuroplasticity only occurs in children'),
(@q,'D','New neurons can be created through willpower alone');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (5,'Regular gratitude practice builds resilience primarily by?','multiple_choice','D',11);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Eliminating negative experiences from memory'),
(@q,'B','Increasing financial security'),
(@q,'C','Replacing the need for social support'),
(@q,'D','Shifting attention toward positive aspects of life and broadening perspective');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (5,'ACT stands for?','multiple_choice','B',12);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Anxiety Control Therapy'),
(@q,'B','Acceptance and Commitment Therapy'),
(@q,'C','Adaptive Coping Technique'),
(@q,'D','Arousal Control Training');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (5,'Psychological flexibility, a core ACT concept, involves?','multiple_choice','C',13);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Changing your core values based on circumstances'),
(@q,'B','Avoiding difficult thoughts and emotions'),
(@q,'C','Adapting behaviour in alignment with values despite difficult thoughts or feelings'),
(@q,'D','Achieving complete emotional stability at all times');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (5,'Cognitive reappraisal as a coping strategy involves?','multiple_choice','A',14);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Reinterpreting the meaning of a situation to change its emotional impact'),
(@q,'B','Suppressing the expression of an emotion while still feeling it'),
(@q,'C','Removing yourself physically from a stressful situation'),
(@q,'D','Seeking distraction through entertainment');

INSERT INTO Questions (QuizID,QuestionText,QuestionType,CorrectAnswer,OrderNum)
VALUES (5,'Barbara Fredrickson''s broaden-and-build theory states that positive emotions?','multiple_choice','D',15);
SET @q=SCOPE_IDENTITY();
INSERT INTO QuestionOptions(QuestionID,OptionLabel,OptionText) VALUES
(@q,'A','Are less important than managing negative emotions'),
(@q,'B','Only affect mood, not behaviour or cognition'),
(@q,'C','Indicate a lack of awareness of real problems'),
(@q,'D','Broaden thinking and awareness, helping build lasting personal resources over time');

END -- IF NOT EXISTS

-- Sample Enrollments (learner 2 enrolled in courses 1 & 2)
INSERT INTO Enrollments (UserID, CourseID, Progress, IsCompleted)
VALUES
(2, 1, 75, 0),
(2, 2, 40, 0),
(3, 1, 100, 1),
(3, 3, 30, 0),
(4, 2, 60, 0);

-- Sample Forum Posts
INSERT INTO ForumPosts (UserID, Title, Content)
VALUES
(2, 'What mindfulness technique works best for you?',
 'Hi everyone! I''ve been struggling with exam stress lately and started practising mindfulness. I''ve tried the body scan meditation and find it helpful before bed. What techniques have worked best for you? Any tips for beginners?'),
(3, 'Managing anxiety during exam season - share your tips!',
 'As final exams approach, I know many of us are feeling the pressure. I wanted to create a space for us to share what''s been helping us cope. For me, it''s been: 1) Breaking study sessions into 25-minute blocks (Pomodoro), 2) Daily 10-minute morning walks, and 3) Limiting caffeine after 2pm. What works for you?'),
(4, 'Has anyone tried the 4-7-8 breathing technique?',
 'I just learned about the 4-7-8 breathing technique from the Stress Management course and I''m amazed at how quickly it works! Within a couple of minutes I feel calmer. I''ve started using it before presentations and it''s really helped with my nerves. Has anyone else tried this? What''s your experience?');

-- Sample Comments
INSERT INTO ForumComments (PostID, UserID, Content)
VALUES
(1, 3, 'I find the 5-minute morning meditation works great! Just sitting quietly and focusing on breathing before starting the day sets a positive tone. Also, the mindful eating practice from the course helped me be more present during meals.'),
(1, 4, 'Box breathing is my go-to! 4 counts in, 4 hold, 4 out, 4 hold. I use it during stressful moments throughout the day. Apps like Calm or Headspace also have great guided sessions if you prefer audio guidance.'),
(2, 2, 'The Pomodoro technique is a game changer! I also started keeping a worry journal - writing down anxious thoughts before studying helps clear my mind. And please remember to eat well and sleep enough - they make a huge difference!'),
(3, 2, 'Yes! I tried it last night when I couldn''t sleep. It took about 3-4 cycles but I definitely felt more relaxed. I think the key is the extended exhale which activates the parasympathetic nervous system. Really effective!');

-- Additional Forum Seed Data (more discussions and replies)
INSERT INTO ForumPosts (UserID, Title, Content, ViewCount)
VALUES
(2, 'Struggling with sleep anxiety - any advice?',
 'I''ve been experiencing a lot of anxiety specifically around bedtime. My mind races as soon as I lie down and I can''t switch off. I''ve tried the sleep hygiene tips from the course but still struggling. Has anyone else experienced this? What actually helped you?',
 15),
(3, 'Gratitude journaling - does it really work?',
 'I started a gratitude journal after completing the Emotional Resilience module and honestly wasn''t expecting much. But after two weeks, I''ve noticed I''m genuinely looking for positive things throughout the day. Has anyone else tried this? How long did it take before you noticed a difference?',
 22),
(4, 'Best apps for meditation beginners?',
 'Just started the Mindfulness course and looking for a good meditation app to supplement my learning. I''ve heard about Calm, Headspace, and Insight Timer but not sure where to start. Any recommendations from people who''ve tried these?',
 31);

INSERT INTO ForumComments (PostID, UserID, Content)
VALUES
(4, 2, 'I struggled with sleep anxiety for months! What really helped me was the 4-7-8 breathing technique - do it 4 times right before bed. Also, avoid checking your phone for 30 minutes before sleep. It took about 2 weeks to notice a real difference but it works!'),
(4, 3, 'Progressive muscle relaxation changed everything for me. Start from your toes and work upwards. Also try writing down everything on your mind before bed - getting thoughts out of your head and onto paper really helps.'),
(5, 4, 'Yes! Gratitude journaling absolutely works but you need to be specific. Instead of "I''m grateful for my family", write "I''m grateful that my friend texted to check on me today". Specificity makes the difference. I noticed a shift after about 10 days.'),
(5, 2, 'I found it helpful to do 3 things: 1 thing that went well, 1 person I appreciate, 1 thing I''m looking forward to. Keep it simple and consistent. Morning works better for me than evening.'),
(6, 3, 'Insight Timer is brilliant for beginners because it''s completely free with tons of guided meditations. Start with the 5-minute ones and work up gradually. Headspace has a good structured beginner course if you prefer guided programs.'),
(6, 2, 'I started with Calm''s Daily Calm (10 minutes) and it was perfect for building the habit. After a month I moved to longer sessions. The key is consistency - same time every day, even if it''s only 5 minutes.');

GO

-- =============================================
-- SAMPLE SUCCESS STORIES (3–5 per course)
-- =============================================
INSERT INTO SuccessStories (CourseID, UserID, DisplayName, Achievement, WhatLearned, Result) VALUES
-- Course 1: Stress Management
(1, NULL, 'Aisha M.', 'Stress-Free Exam Season',
 'I learned that stress is not the enemy — my reaction to it is. The 4-7-8 breathing technique became my go-to before every exam.',
 'Reduced pre-exam anxiety by roughly 60%. My grades actually improved because I could think clearly instead of panicking.'),
(1, NULL, 'James T.', 'Work-Life Balance Restored',
 'The time management module showed me how I was creating my own stress with unrealistic task lists. I now use the Eisenhower Matrix daily.',
 'I finish work on time 4 days a week now. My evenings are genuinely relaxing again.'),
(1, NULL, 'Priya K.', 'Mastered Progressive Relaxation',
 'Progressive muscle relaxation felt strange at first but after a week I could release tension in minutes. It changed how I end every day.',
 'I fall asleep within 20 minutes now instead of lying awake worrying for an hour. Huge difference.'),
(1, NULL, 'Daniel R.', 'Cortisol Under Control',
 'Understanding the science of cortisol and how chronic stress physically damages the body was a wake-up call. I take recovery seriously now.',
 'My resting heart rate dropped 8 bpm over 6 weeks. My doctor noticed the improvement at my check-up.'),
(1, NULL, 'Siti N.', 'Daily Calm Achieved',
 'The 5-4-3-2-1 grounding technique sounds simple but it genuinely works. I use it whenever I feel overwhelmed in class or at home.',
 'I have not had a full panic episode in two months. I feel in control of my mind for the first time in years.'),

-- Course 2: Mindfulness
(2, NULL, 'Lena W.', '10-Min Daily Habit Built',
 'I always thought meditation needed an hour and a quiet mountain. Andy Puddicombe proved me wrong — 10 focused minutes is transformative.',
 'After 30 days of consistent practice my focus during lectures improved dramatically. I retain information so much better.'),
(2, NULL, 'Omar H.', 'Non-Judgement Unlocked',
 'The concept of observing thoughts without labelling them as good or bad removed enormous pressure from my inner monologue.',
 'I stopped catastrophising about small mistakes. My self-compassion increased and so did my productivity.'),
(2, NULL, 'Chloe B.', 'Mindful Eating Transformed',
 'I was a speed-eater who barely tasted food. The mindful eating practice made me slow down and actually enjoy meals.',
 'I eat less, enjoy food more, and no longer have afternoon energy crashes from rushing lunch.'),
(2, NULL, 'Raj P.', '40% Less Phone Screen Time',
 'The present-moment awareness module made me realise how unconsciously I reached for my phone. I set intentional phone-free windows.',
 'Screen time down from 6 hours to 3.5 hours daily. That reclaimed time goes to reading and actual rest.'),

-- Course 3: Anxiety
(3, NULL, 'Emma L.', 'CBT Changed Everything',
 'Cognitive restructuring showed me that my anxious thoughts were predictions, not facts. Learning to challenge them was genuinely life-changing.',
 'I gave a 10-minute presentation in front of 40 people last month. Six months ago that would have been impossible.'),
(3, NULL, 'Haris A.', 'Social Anxiety Reduced 70%',
 'The exposure hierarchy exercise was uncomfortable but it worked. Starting with low-risk social interactions and gradually building up confidence.',
 'I now initiate conversations and join group discussions in tutorials. My classmates would not recognise the anxious person I was.'),
(3, NULL, 'Sofia G.', 'Panic Attacks Under Control',
 'Understanding that panic attacks cannot physically harm me removed a huge layer of fear. The breathing techniques interrupt the cycle early.',
 'From 3-4 panic attacks a week to one minor episode in the past month. I finally feel safe in my own body.'),
(3, NULL, 'Ethan J.', 'Thought Record Master',
 'Keeping a thought record diary for two weeks showed me I was catastrophising every assignment. The evidence never supported my worst fears.',
 'Assignment anxiety dropped significantly. I submit work without the hours of paralysing what-ifs that used to precede every submission.'),

-- Course 4: Sleep Hygiene
(4, NULL, 'Mei L.', 'From 5hrs to 8hrs Sleep',
 'I had no idea light and temperature affected sleep so much. Blackout curtains and dropping the room temperature added 90 minutes of sleep.',
 'I wake up alert, skip the 3pm energy crash, and my mood has completely stabilised. Sleep really is a superpower.'),
(4, NULL, 'Tom K.', 'No More Scrolling in Bed',
 'The bed association principle was simple but powerful — I stopped using my phone in bed entirely. My brain now links bed with sleep.',
 'Fall-asleep time went from 45+ minutes to under 15 minutes. I have not taken a sleeping tablet in 3 months.'),
(4, NULL, 'Nadia S.', 'Consistent Wake Time Wins',
 'The hardest change was waking at the same time on weekends. After two weeks my circadian rhythm adjusted and I naturally felt tired at 10pm.',
 'I have not used an alarm to drag myself out of bed in 6 weeks. My body wakes up on its own, rested and ready.'),
(4, NULL, 'Ben C.', 'Caffeine Audit Changed Sleep',
 'I discovered I was drinking coffee at 4pm — well within the 5-6 hour half-life window. Cutting off at noon made an immediate difference.',
 'Deep sleep percentage on my fitness tracker increased by about 25% within the first week of the caffeine cut-off change.'),

-- Course 5: Resilience
(5, NULL, 'Fatimah R.', 'Bounced Back from Failure',
 'After failing two subjects I thought my academic life was over. The growth mindset module reframed failure as data, not identity.',
 'I retook both subjects and passed. More importantly, I no longer fear failure — I treat it as a signal to adjust my strategy.'),
(5, NULL, 'Lucas M.', 'Gratitude Rewired My Brain',
 'I was deeply sceptical about gratitude journaling. Writing three specific things daily felt forced for a week, then something genuinely shifted.',
 'After 21 days I naturally noticed positives throughout the day. My baseline mood lifted measurably. My friends noticed before I did.'),
(5, NULL, 'Amara D.', 'Built My Support Network',
 'The course made me realise I was trying to be resilient alone, which is exhausting. I identified five people I could be vulnerable with.',
 'Having a support network means struggles feel temporary rather than permanent. I reach out now instead of isolating, and it works.'),
(5, NULL, 'Kevin O.', 'Post-Traumatic Growth',
 'The journaling framework for processing difficult experiences helped me make sense of a really hard year. Writing it down externalised the pain.',
 'I can talk about what happened without distress now. The experience became part of my story rather than a wound I carried.');

-- =============================================
-- MIGRATION: Add EditedAt to ForumComments
-- (run if upgrading an existing database)
-- =============================================
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('ForumComments') AND name = 'EditedAt'
)
    ALTER TABLE ForumComments ADD EditedAt DATETIME NULL;
GO

-- =============================================
-- MIGRATION: Add SuccessStories table
-- =============================================
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'SuccessStories')
BEGIN
    CREATE TABLE SuccessStories (
        StoryID       INT IDENTITY(1,1) PRIMARY KEY,
        CourseID      INT NOT NULL FOREIGN KEY REFERENCES Courses(CourseID),
        UserID        INT NULL FOREIGN KEY REFERENCES Users(UserID),
        DisplayName   NVARCHAR(100)  NOT NULL,
        Achievement   NVARCHAR(200)  NOT NULL,
        WhatLearned   NVARCHAR(MAX)  NOT NULL,
        Result        NVARCHAR(MAX)  NOT NULL,
        IsApproved    BIT NOT NULL DEFAULT 1,
        DatePosted    DATETIME NOT NULL DEFAULT GETDATE()
    );
    PRINT 'SuccessStories table created.';
END
ELSE
    PRINT 'SuccessStories table already exists - skipped.';
GO

-- =============================================
-- MIGRATION: Add UserProgress table
-- (run on existing databases to add progress tracking)
-- =============================================
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'UserProgress')
BEGIN
    CREATE TABLE UserProgress (
        ProgressID   INT IDENTITY(1,1) PRIMARY KEY,
        UserID       INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
        CourseID     INT NULL FOREIGN KEY REFERENCES Courses(CourseID),
        QuizID       INT NULL FOREIGN KEY REFERENCES Quizzes(QuizID),
        ActionType   NVARCHAR(50)   NULL,
        Score        DECIMAL(5,2)   NULL,
        DateCreated  DATETIME NOT NULL DEFAULT GETDATE(),
        IsCompleted  BIT NOT NULL DEFAULT 0,
        EventType    NVARCHAR(50)   NOT NULL DEFAULT '',
        ReferenceID  INT            NULL,
        ProgressPct  INT            NULL,
        ScoreValue   DECIMAL(5,2)   NULL,
        MinutesSpent INT NOT NULL DEFAULT 0,
        RecordedAt   DATETIME NOT NULL DEFAULT GETDATE()
    );
    CREATE INDEX IX_UserProgress_User ON UserProgress (UserID, RecordedAt DESC);
    PRINT 'UserProgress table created.';
END
ELSE
    PRINT 'UserProgress table already exists - skipped.';
GO

-- =============================================
-- MIGRATION: Seed resources for Courses 3, 4, 5
-- (safe to re-run — skips if rows already exist)
-- =============================================
IF NOT EXISTS (SELECT 1 FROM Resources WHERE CourseID = 3)
BEGIN
    INSERT INTO Resources (CourseID, Title, ResourceType, Content, URL, OrderNum) VALUES
    (3, 'What is Anxiety? Types and Symptoms', 'article',
     'Anxiety is a natural response to perceived threat or uncertainty. It becomes a disorder when it is persistent, excessive, and interferes with daily functioning. The main anxiety disorders include:

Generalised Anxiety Disorder (GAD): persistent worry about a variety of topics, events, or activities. People with GAD find it hard to control their worry and often feel on edge.

Panic Disorder: recurrent unexpected panic attacks — sudden surges of intense fear accompanied by physical symptoms such as pounding heart, shortness of breath, dizziness, and chest tightness.

Social Anxiety Disorder: intense fear of social or performance situations where scrutiny by others is possible. The person fears humiliation or embarrassment.

Specific Phobias: intense, irrational fear of a specific object or situation (e.g., heights, spiders, flying).

Recognising your anxiety type is the first step. Common physical signs include: racing heart, sweating, trembling, dry mouth, nausea, and shortness of breath. Cognitive signs include: catastrophic thinking, overestimating danger, and difficulty concentrating.',
     NULL, 1),
    (3, 'Cognitive-Behavioural Techniques for Anxiety', 'article',
     'Cognitive-Behavioural Therapy (CBT) is the gold-standard psychological treatment for anxiety. Its core principle: our thoughts influence our feelings and behaviours. By changing unhelpful thought patterns, we can reduce anxiety.

Key CBT techniques for anxiety:

1. Thought Records: When you notice anxiety, write down the situation, your automatic thought, the evidence for and against that thought, and a balanced alternative thought. This slows down catastrophic thinking.

2. Behavioural Experiments: Test your anxious predictions against reality. If you fear that speaking in class will lead to everyone laughing, test this belief by gradually participating and noting what actually happens.

3. Exposure Hierarchy: Create a list of feared situations from least to most anxiety-provoking. Start with the easiest and gradually work up. Repeated exposure reduces anxiety over time.

4. Cognitive Restructuring: Challenge unhelpful thinking patterns such as: catastrophising ("This will be a disaster"), mind-reading ("Everyone thinks I''m stupid"), and overestimating probability ("Something bad will definitely happen").

5. Relaxation Techniques: Diaphragmatic breathing, progressive muscle relaxation, and mindfulness-based strategies reduce the physical component of anxiety.',
     NULL, 2),
    (3, 'How to Cope with Anxiety - Olivia Remes (TEDx)', 'video',
     NULL, 'https://www.youtube.com/embed/ZidGozDhOjg', 3);
END

IF NOT EXISTS (SELECT 1 FROM Resources WHERE CourseID = 4)
BEGIN
    INSERT INTO Resources (CourseID, Title, ResourceType, Content, URL, OrderNum) VALUES
    (4, 'The Science of Sleep and Mental Health', 'article',
     'Sleep is not passive — it is one of the most active and essential processes your brain and body undergo. During sleep, the brain consolidates memories, clears metabolic waste products (including proteins linked to Alzheimer''s), and regulates emotional responses.

The sleep architecture consists of cycles (~90 minutes each) alternating between:
- NREM Stage 1 & 2 (Light sleep): transition to sleep, body temperature drops, heart rate slows
- NREM Stage 3 (Deep/Slow-wave sleep): tissue repair, immune strengthening, memory consolidation
- REM sleep: vivid dreaming, emotional memory processing, creativity

Why sleep matters for mental health:
- Sleep deprivation increases amygdala reactivity by up to 60%, making you more emotionally reactive
- Chronic poor sleep is one of the strongest predictors of depression and anxiety
- A single night of 6 hours or less impairs attention, working memory, and decision-making comparably to 24 hours of no sleep

The recommended amount for adults (18–64) is 7–9 hours per night. Most people underestimate their own sleep deficit.',
     NULL, 1),
    (4, 'Building a Sleep-Friendly Environment and Routine', 'article',
     'Sleep hygiene refers to the habits and environmental conditions that promote consistent, high-quality sleep. Research-backed strategies:

Environment optimisation:
- Temperature: Keep your bedroom between 16–20°C (60–68°F). Your core body temperature must drop to initiate sleep.
- Darkness: Use blackout curtains or a sleep mask. Even small amounts of light suppress melatonin.
- Sound: Use white noise, earplugs, or silence. Your brain continues processing sound during sleep.
- Bed association: Use your bed only for sleep and intimacy. This strengthens the mental association between bed and sleep.

Behavioural strategies:
- Consistent schedule: Wake at the same time every day (including weekends). This anchors your circadian rhythm.
- Wind-down routine: 30–60 minutes before bed, dim lights, avoid screens, and do calming activities (reading, gentle stretching, warm bath).
- Caffeine cut-off: Caffeine has a half-life of 5–6 hours. A 3pm coffee still leaves half its dose in your system at 9pm.
- Alcohol: While alcohol may help you fall asleep, it fragments sleep in the second half of the night and suppresses REM sleep.
- Exercise: Regular exercise improves sleep quality significantly, but avoid vigorous exercise within 2 hours of bedtime.',
     NULL, 2),
    (4, 'Sleep Is Your Superpower - Matthew Walker (TED)', 'video',
     NULL, 'https://www.youtube.com/embed/5MuIMqhT8DM', 3),
    (4, 'Sleep Quality Tracker Template', 'download',
     'Download this sleep quality tracker to monitor your sleep schedule, bedtime habits, and energy levels. Tracking for two weeks helps identify patterns that improve or disrupt your sleep.',
     '/Content/Downloads/sleep-quality-tracker.html', 4);
END

IF NOT EXISTS (SELECT 1 FROM Resources WHERE CourseID = 5)
BEGIN
    INSERT INTO Resources (CourseID, Title, ResourceType, Content, URL, OrderNum) VALUES
    (5, 'What is Emotional Resilience?', 'article',
     'Emotional resilience is the ability to adapt positively in the face of adversity, trauma, threats, or significant sources of stress. Resilient people do not avoid or suppress difficult emotions — instead, they process them effectively and use the experience to grow.

Key dimensions of resilience:
- Emotional regulation: the ability to manage and modulate emotional responses. This does not mean suppressing emotions but experiencing them without being overwhelmed.
- Cognitive flexibility: the ability to reframe situations and find alternative interpretations. Resilient people can step back from a setback and find lessons or opportunities.
- Social connectedness: strong, supportive relationships are consistently the most powerful predictor of resilience. People rarely bounce back from adversity in isolation.
- Self-efficacy: belief in your own ability to cope. This builds through experience — small successes accumulate into a strong internal narrative.
- Purpose and meaning: a sense of why you are doing what you are doing buffers against stress and gives direction during difficulty.

Research by psychologist Martin Seligman (PERMA model) identifies five pillars of wellbeing that build resilience: Positive Emotion, Engagement, Relationships, Meaning, and Accomplishment.',
     NULL, 1),
    (5, 'Building Your Resilience Toolkit', 'article',
     'Resilience is not a fixed trait — it is a set of skills that can be learned and strengthened over time. Here are evidence-based strategies used by mental health professionals:

1. Develop a growth mindset (Carol Dweck): View challenges as opportunities for learning rather than threats to your competence. Replace "I can''t do this" with "I can''t do this yet."

2. Practice gratitude: Daily gratitude practice (writing 3 specific things you appreciate) has been shown to increase wellbeing and reduce symptoms of depression within 2–4 weeks.

3. Build your support network: Identify 3–5 people you can call when struggling. Vulnerability and connection are core to resilience — asking for help is a strength.

4. Develop emotional vocabulary: The more precisely you can label an emotion (not just "bad" but "disappointed", "overwhelmed", "embarrassed"), the more effectively you can process it.

5. Accept what you cannot control: The Stoic practice of distinguishing between what is within your control and what is not reduces anxiety and increases a sense of agency.

6. Regular physical self-care: Sleep, exercise, and nutrition are foundational. Resilience under stress is impossible on chronic sleep deprivation or poor nutrition.

7. Post-traumatic growth journaling: After difficult experiences, write about: what happened, how you felt, what you learned, and how it has shaped you. This promotes integration and meaning-making.',
     NULL, 2),
    (5, 'The Three Secrets of Resilient People - Lucy Hone (TEDx)', 'video',
     NULL, 'https://www.youtube.com/embed/NWH8N-BvhAw', 3),
    (5, 'Resilience Self-Assessment Worksheet', 'download',
     'Download this resilience self-assessment to identify your current strengths, areas for growth, and create a personalised resilience-building action plan.',
     '/Content/Downloads/resilience-self-assessment.html', 4);
END

PRINT 'MindSpaceDB created successfully!';
PRINT '';
PRINT 'IMPORTANT: To set up the admin account:';
PRINT '1. Register via the app with email: admin@mindspace.com and any password';
PRINT '2. Run: UPDATE Users SET Role=''admin'' WHERE Email=''admin@mindspace.com'';';
PRINT '   OR the pre-inserted admin account uses password "123" (update it immediately)';
