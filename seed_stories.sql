USE MindSpaceDB;
GO

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
    PRINT 'SuccessStories table already exists.';
GO

IF NOT EXISTS (SELECT 1 FROM SuccessStories WHERE CourseID = 1)
BEGIN
    INSERT INTO SuccessStories (CourseID, UserID, DisplayName, Achievement, WhatLearned, Result) VALUES
    (1, NULL, 'Aisha M.', 'Stress-Free Exam Season',
     'I learned that stress is not the enemy, my reaction to it is. The 4-7-8 breathing technique became my go-to before every exam.',
     'Reduced pre-exam anxiety by roughly 60%. My grades improved because I could think clearly instead of panicking.'),
    (1, NULL, 'James T.', 'Work-Life Balance Restored',
     'The time management module showed me how I was creating my own stress with unrealistic task lists. I now use the Eisenhower Matrix daily.',
     'I finish work on time 4 days a week now. My evenings are genuinely relaxing again.'),
    (1, NULL, 'Priya K.', 'Mastered Progressive Relaxation',
     'Progressive muscle relaxation felt strange at first but after a week I could release tension in minutes. It changed how I end every day.',
     'I fall asleep within 20 minutes now instead of lying awake worrying for an hour.'),
    (1, NULL, 'Daniel R.', 'Cortisol Under Control',
     'Understanding the science of cortisol and how chronic stress physically damages the body was a wake-up call. I take recovery seriously now.',
     'My resting heart rate dropped 8 bpm over 6 weeks. My doctor noticed the improvement at my check-up.'),
    (1, NULL, 'Siti N.', 'Daily Calm Achieved',
     'The 5-4-3-2-1 grounding technique sounds simple but it genuinely works. I use it whenever I feel overwhelmed in class or at home.',
     'I have not had a full panic episode in two months. I feel in control of my mind for the first time in years.');
    PRINT 'Course 1 stories seeded.';
END
GO

IF NOT EXISTS (SELECT 1 FROM SuccessStories WHERE CourseID = 2)
BEGIN
    INSERT INTO SuccessStories (CourseID, UserID, DisplayName, Achievement, WhatLearned, Result) VALUES
    (2, NULL, 'Lena W.', '10-Min Daily Habit Built',
     'I always thought meditation needed an hour and a quiet mountain. 10 focused minutes is transformative when done consistently.',
     'After 30 days of consistent practice my focus during lectures improved dramatically. I retain information so much better.'),
    (2, NULL, 'Omar H.', 'Non-Judgement Unlocked',
     'The concept of observing thoughts without labelling them as good or bad removed enormous pressure from my inner monologue.',
     'I stopped catastrophising about small mistakes. My self-compassion increased and so did my productivity.'),
    (2, NULL, 'Chloe B.', 'Mindful Eating Transformed',
     'I was a speed-eater who barely tasted food. The mindful eating practice made me slow down and actually enjoy meals.',
     'I eat less, enjoy food more, and no longer have afternoon energy crashes from rushing lunch.'),
    (2, NULL, 'Raj P.', '40% Less Phone Screen Time',
     'Present-moment awareness made me realise how unconsciously I reached for my phone. I set intentional phone-free windows each day.',
     'Screen time down from 6 hours to 3.5 hours daily. That time now goes to reading and actual rest.');
    PRINT 'Course 2 stories seeded.';
END
GO

IF NOT EXISTS (SELECT 1 FROM SuccessStories WHERE CourseID = 3)
BEGIN
    INSERT INTO SuccessStories (CourseID, UserID, DisplayName, Achievement, WhatLearned, Result) VALUES
    (3, NULL, 'Emma L.', 'CBT Changed Everything',
     'Cognitive restructuring showed me that my anxious thoughts were predictions, not facts. Learning to challenge them was genuinely life-changing.',
     'I gave a 10-minute presentation in front of 40 people last month. Six months ago that would have been impossible.'),
    (3, NULL, 'Haris A.', 'Social Anxiety Reduced 70%',
     'The exposure hierarchy exercise was uncomfortable but it worked. Starting with low-risk social interactions and gradually building up confidence.',
     'I now initiate conversations and join group discussions in tutorials. My classmates would not recognise who I was before.'),
    (3, NULL, 'Sofia G.', 'Panic Attacks Under Control',
     'Understanding that panic attacks cannot physically harm me removed a huge layer of fear. The breathing techniques interrupt the cycle early.',
     'From 3-4 panic attacks a week to one minor episode in the past month. I finally feel safe in my own body.'),
    (3, NULL, 'Ethan J.', 'Thought Record Master',
     'Keeping a thought record diary for two weeks showed me I was catastrophising every assignment. The evidence never supported my worst fears.',
     'Assignment anxiety dropped significantly. I submit work without the hours of paralysing what-ifs that used to precede every submission.');
    PRINT 'Course 3 stories seeded.';
END
GO

IF NOT EXISTS (SELECT 1 FROM SuccessStories WHERE CourseID = 4)
BEGIN
    INSERT INTO SuccessStories (CourseID, UserID, DisplayName, Achievement, WhatLearned, Result) VALUES
    (4, NULL, 'Mei L.', 'From 5hrs to 8hrs Sleep',
     'I had no idea light and temperature affected sleep so much. Blackout curtains and dropping room temperature added 90 minutes of sleep.',
     'I wake up alert, skip the 3pm energy crash, and my mood has completely stabilised.'),
    (4, NULL, 'Tom K.', 'No More Scrolling in Bed',
     'The bed association principle was simple but powerful. I stopped using my phone in bed entirely and my brain now links bed with sleep only.',
     'Fall-asleep time went from 45 minutes to under 15 minutes. I have not taken a sleeping tablet in 3 months.'),
    (4, NULL, 'Nadia S.', 'Consistent Wake Time Wins',
     'The hardest change was waking at the same time on weekends. After two weeks my circadian rhythm adjusted and I naturally felt tired at 10pm.',
     'I have not used an alarm to drag myself out of bed in 6 weeks. My body wakes up on its own, rested and ready.'),
    (4, NULL, 'Ben C.', 'Caffeine Audit Changed Sleep',
     'I discovered I was drinking coffee at 4pm well within the 5-6 hour half-life window. Cutting off at noon made an immediate difference.',
     'Deep sleep on my fitness tracker increased about 25% within the first week of the caffeine cut-off change.');
    PRINT 'Course 4 stories seeded.';
END
GO

IF NOT EXISTS (SELECT 1 FROM SuccessStories WHERE CourseID = 5)
BEGIN
    INSERT INTO SuccessStories (CourseID, UserID, DisplayName, Achievement, WhatLearned, Result) VALUES
    (5, NULL, 'Fatimah R.', 'Bounced Back from Failure',
     'After failing two subjects I thought my academic life was over. The growth mindset module reframed failure as data, not identity.',
     'I retook both subjects and passed. More importantly I no longer fear failure. I treat it as a signal to adjust my strategy.'),
    (5, NULL, 'Lucas M.', 'Gratitude Rewired My Brain',
     'I was deeply sceptical about gratitude journaling. Writing three specific things daily felt forced for a week, then something shifted.',
     'After 21 days I naturally noticed positives throughout the day. My baseline mood lifted measurably. My friends noticed before I did.'),
    (5, NULL, 'Amara D.', 'Built My Support Network',
     'The course made me realise I was trying to be resilient alone, which is exhausting. I identified five people I could be vulnerable with.',
     'Having a support network means struggles feel temporary rather than permanent. I reach out now instead of isolating.'),
    (5, NULL, 'Kevin O.', 'Post-Traumatic Growth',
     'The journaling framework for processing difficult experiences helped me make sense of a really hard year. Writing it down externalised the pain.',
     'I can talk about what happened without distress now. The experience became part of my story rather than a wound I carried.');
    PRINT 'Course 5 stories seeded.';
END
GO

SELECT CourseID, COUNT(*) AS StoryCount FROM SuccessStories GROUP BY CourseID ORDER BY CourseID;
GO
