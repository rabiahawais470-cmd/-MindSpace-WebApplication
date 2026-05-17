USE MindSpaceDB;
GO

IF NOT EXISTS (SELECT 1 FROM Resources WHERE CourseID = 3)
BEGIN
    INSERT INTO Resources (CourseID, Title, ResourceType, Content, URL, OrderNum) VALUES
    (3, 'What is Anxiety? Types and Symptoms', 'article',
     'Anxiety is a natural response to perceived threat or uncertainty. It becomes a disorder when persistent, excessive, and interfering with daily life. Main anxiety disorders include: Generalised Anxiety Disorder (GAD) -- persistent worry about many topics; Panic Disorder -- recurrent unexpected panic attacks with physical symptoms; Social Anxiety Disorder -- intense fear of social situations; and Specific Phobias -- irrational fear of a specific object or situation. Common physical signs: racing heart, sweating, trembling, dry mouth, nausea. Cognitive signs: catastrophic thinking, overestimating danger, difficulty concentrating.',
     NULL, 1),
    (3, 'Cognitive-Behavioural Techniques for Anxiety', 'article',
     'Cognitive-Behavioural Therapy (CBT) is the gold-standard treatment for anxiety. Key CBT techniques: (1) Thought Records -- write the situation, automatic thought, evidence for/against, and a balanced alternative thought; (2) Behavioural Experiments -- test anxious predictions against reality through gradual exposure; (3) Exposure Hierarchy -- list feared situations from least to most anxiety-provoking, then face them gradually; (4) Cognitive Restructuring -- challenge catastrophising, mind-reading, and overestimating probability; (5) Relaxation -- diaphragmatic breathing, progressive muscle relaxation, and mindfulness reduce the physical component of anxiety.',
     NULL, 2),
    (3, 'How to Cope with Anxiety - Olivia Remes (TEDx)', 'video',
     NULL, 'https://www.youtube.com/embed/ZidGozDhOjg', 3)
    PRINT 'Resources seeded for Course 3 (Anxiety).';
END
ELSE
    PRINT 'Course 3 resources already exist -- skipped.';
GO

IF NOT EXISTS (SELECT 1 FROM Resources WHERE CourseID = 4)
BEGIN
    INSERT INTO Resources (CourseID, Title, ResourceType, Content, URL, OrderNum) VALUES
    (4, 'The Science of Sleep and Mental Health', 'article',
     'Sleep is one of the most active processes your brain undergoes each night. The brain consolidates memories, clears metabolic waste products, and regulates emotional responses during sleep. Sleep cycles (~90 minutes each) alternate between NREM Stage 1-2 (light sleep), NREM Stage 3 (deep slow-wave sleep -- tissue repair, immune strengthening), and REM sleep (vivid dreaming, emotional memory processing). Sleep deprivation increases amygdala reactivity by up to 60%, making you emotionally reactive. Chronic poor sleep is one of the strongest predictors of depression and anxiety. Adults need 7-9 hours per night.',
     NULL, 1),
    (4, 'Building a Sleep-Friendly Environment and Routine', 'article',
     'Sleep hygiene covers habits and environmental conditions that promote high-quality sleep. Environment: keep your bedroom at 16-20 degrees C (60-68 F) -- core body temperature must drop to initiate sleep; use blackout curtains since even small amounts of light suppress melatonin; use your bed only for sleep to strengthen the mental association. Behavioural strategies: wake at the same time every day (including weekends) to anchor your circadian rhythm; follow a 30-60 minute wind-down routine with dim lights and no screens; avoid caffeine after 2pm (half-life is 5-6 hours); avoid alcohol before bed as it fragments sleep and suppresses REM; exercise regularly but avoid vigorous workouts within 2 hours of bedtime.',
     NULL, 2),
    (4, 'Sleep Is Your Superpower - Matthew Walker (TED)', 'video',
     NULL, 'https://www.youtube.com/embed/5MuIMqhT8DM', 3),
    (4, 'Sleep Quality Tracker Template', 'download',
     'Download this sleep quality tracker to monitor your sleep schedule, bedtime habits, and energy levels. Tracking for two weeks helps identify patterns that improve or disrupt your sleep.',
     NULL, 4)
    PRINT 'Resources seeded for Course 4 (Sleep Hygiene).';
END
ELSE
    PRINT 'Course 4 resources already exist -- skipped.';
GO

IF NOT EXISTS (SELECT 1 FROM Resources WHERE CourseID = 5)
BEGIN
    INSERT INTO Resources (CourseID, Title, ResourceType, Content, URL, OrderNum) VALUES
    (5, 'What is Emotional Resilience?', 'article',
     'Emotional resilience is the ability to adapt positively in the face of adversity, trauma, or significant stress. Resilient people do not avoid difficult emotions -- they process them effectively and grow from experience. Key dimensions: emotional regulation (manage emotions without being overwhelmed); cognitive flexibility (reframe situations and find alternative interpretations); social connectedness (strong relationships are the most powerful predictor of resilience); self-efficacy (belief in your ability to cope, built through experience); and purpose and meaning (a sense of why buffers against stress). Martin Seligman''s PERMA model identifies five pillars of wellbeing: Positive Emotion, Engagement, Relationships, Meaning, and Accomplishment.',
     NULL, 1),
    (5, 'Building Your Resilience Toolkit', 'article',
     'Resilience is a set of learnable skills. Evidence-based strategies: (1) Growth mindset -- view challenges as learning opportunities; replace "I cannot do this" with "I cannot do this yet"; (2) Gratitude practice -- write 3 specific things you appreciate daily, shown to increase wellbeing within 2-4 weeks; (3) Build your support network -- identify 3-5 people you can call when struggling; (4) Emotional vocabulary -- label emotions precisely rather than just "bad" (e.g. "disappointed", "overwhelmed", "embarrassed"); (5) Accept what you cannot control -- distinguish between what is and is not within your control; (6) Physical self-care -- sleep, exercise, and nutrition are foundational to resilience; (7) Post-traumatic growth journaling -- write about what happened, how you felt, what you learned, and how it has shaped you.',
     NULL, 2),
    (5, 'The Three Secrets of Resilient People - Lucy Hone (TEDx)', 'video',
     NULL, 'https://www.youtube.com/embed/NWH8N-BvhAw', 3),
    (5, 'Resilience Self-Assessment Worksheet', 'download',
     'Download this resilience self-assessment to identify your current strengths, areas for growth, and create a personalised resilience-building action plan.',
     NULL, 4)
    PRINT 'Resources seeded for Course 5 (Resilience).';
END
ELSE
    PRINT 'Course 5 resources already exist -- skipped.';
GO

-- Verify
SELECT CourseID, COUNT(*) AS ResourceCount FROM Resources GROUP BY CourseID ORDER BY CourseID;
GO
