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
-- TABLE: ForumPosts
-- =============================================
CREATE TABLE ForumPosts (
    PostID      INT IDENTITY(1,1) PRIMARY KEY,
    UserID      INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
    Title       NVARCHAR(200) NOT NULL,
    Content     NVARCHAR(MAX) NOT NULL,
    DatePosted  DATETIME DEFAULT GETDATE(),
    IsActive    BIT DEFAULT 1,
    ViewCount   INT DEFAULT 0
);

-- =============================================
-- TABLE: ForumComments
-- =============================================
CREATE TABLE ForumComments (
    CommentID  INT IDENTITY(1,1) PRIMARY KEY,
    PostID     INT NOT NULL FOREIGN KEY REFERENCES ForumPosts(PostID),
    UserID     INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
    Content    NVARCHAR(MAX) NOT NULL,
    DatePosted DATETIME DEFAULT GETDATE(),
    IsActive   BIT DEFAULT 1
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
    'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',
    'admin'
);

-- Sample learner accounts (password = "Test@123")
INSERT INTO Users (FullName, Username, Email, PasswordHash, Role)
VALUES
('Alex Johnson', 'alexj', 'alex@student.apu.edu.my',
 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'learner'),
('Sarah Chen', 'sarahc', 'sarah@student.apu.edu.my',
 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'learner'),
('Mohammed Ali', 'mohammedali', 'mohammed@student.apu.edu.my',
 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'learner');

-- NOTE: Default password hash above is for "123" (SHA256).
-- When you register through the app normally, the correct hash is computed.
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
(1, 'Stress Management - Guided Exercise Video', 'video',
 NULL, 'https://www.youtube.com/embed/z6X5oEIg6Ak', 3),
(1, 'Daily Stress Journal Template', 'download',
 'Download this daily stress journal template to track your stress triggers, responses, and coping strategies. Regular journaling helps identify patterns and monitor your progress.',
 NULL, 4);

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
(2, '10-Minute Body Scan Meditation', 'video',
 NULL, 'https://www.youtube.com/embed/dB_LkXuDEDw', 2),
(2, 'Mindfulness for Students - Guide', 'article',
 'As a student, your mind is constantly pulled in multiple directions: lectures, assignments, social pressures, and future concerns. Mindfulness gives you the ability to choose where to direct your attention.

Simple mindfulness practices for students:
1. Mindful morning routine (5 minutes): Before checking your phone, take 5 deep breaths and set a positive intention for the day.
2. Mindful eating: During at least one meal, put away devices and eat slowly, noticing flavours, textures, and sensations.
3. Study mindfulness: Before studying, take 3 deep breaths. Notice when your mind wanders and gently redirect attention to the material.
4. Mindful walking: During breaks between classes, walk slowly and notice the sensation of each step.
5. Evening reflection (3 minutes): Before sleep, reflect on 3 things you''re grateful for from the day.',
 NULL, 3);

-- Sample Quiz for Course 1
INSERT INTO Quizzes (CourseID, Title, Description, PassingScore)
VALUES (1, 'Stress Management Assessment', 'Test your understanding of stress management fundamentals.', 60);

INSERT INTO Questions (QuizID, QuestionText, QuestionType, CorrectAnswer, OrderNum)
VALUES
(1, 'Which hormones are primarily released during the stress response?', 'multiple', 'A', 1),
(1, 'The 4-7-8 breathing technique involves inhaling for 4 counts, holding for 7, and exhaling for 8 counts.', 'truefalse', 'True', 2),
(1, 'Which of the following is NOT a common sign of chronic stress?', 'multiple', 'D', 3),
(1, 'What does the 5-4-3-2-1 grounding technique help with?', 'multiple', 'B', 4),
(1, 'Regular physical exercise is an effective strategy for managing stress.', 'truefalse', 'True', 5);

INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText)
VALUES
(1, 'A', 'Cortisol and Adrenaline'),
(1, 'B', 'Serotonin and Dopamine'),
(1, 'C', 'Insulin and Glucagon'),
(1, 'D', 'Melatonin and Oxytocin'),
(3, 'A', 'Persistent headaches'),
(3, 'B', 'Difficulty concentrating'),
(3, 'C', 'Fatigue and irritability'),
(3, 'D', 'Improved immune function'),
(4, 'A', 'Improving memory recall'),
(4, 'B', 'Anchoring you to the present moment'),
(4, 'C', 'Increasing energy levels'),
(4, 'D', 'Improving social skills');

-- Sample Quiz for Course 2
INSERT INTO Quizzes (CourseID, Title, Description, PassingScore)
VALUES (2, 'Mindfulness Knowledge Check', 'Evaluate your understanding of mindfulness principles and practice.', 70);

INSERT INTO Questions (QuizID, QuestionText, QuestionType, CorrectAnswer, OrderNum)
VALUES
(2, 'Mindfulness practice requires complete emptying of the mind.', 'truefalse', 'False', 1),
(2, 'Research shows that regular mindfulness practice can physically change brain structure.', 'truefalse', 'True', 2),
(2, 'Which of the following best describes mindfulness?', 'multiple', 'C', 3),
(2, 'How much daily mindfulness practice has been shown to have measurable benefits?', 'multiple', 'A', 4);

INSERT INTO QuestionOptions (QuestionID, OptionLabel, OptionText)
VALUES
(7, 'A', 'Thinking about future plans clearly'),
(7, 'B', 'Suppressing negative emotions'),
(7, 'C', 'Intentional present-moment awareness without judgment'),
(7, 'D', 'Focusing only on positive thoughts'),
(8, 'A', 'As little as 10 minutes per day'),
(8, 'B', 'At least 2 hours per day'),
(8, 'C', 'Only during meditation retreats'),
(8, 'D', 'A minimum of 1 hour per day');

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

GO

PRINT 'MindSpaceDB created successfully!';
PRINT '';
PRINT 'IMPORTANT: To set up the admin account:';
PRINT '1. Register via the app with email: admin@mindspace.com and any password';
PRINT '2. Run: UPDATE Users SET Role=''admin'' WHERE Email=''admin@mindspace.com'';';
PRINT '   OR the pre-inserted admin account uses password "123" (update it immediately)';
