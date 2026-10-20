-- Becoming Her — Chapters 3–54 import
-- Generated from the authoritative Becoming_Her_Final_QA_fonts_embedded.pdf
-- 52 chapters | 362 content blocks | 204 reflection questions
-- Safe to re-run: replaces only chapters 43–50 for the identified Becoming Her journey.

BEGIN;

CREATE TEMP TABLE _becoming_her_import_context (journey_id uuid) ON COMMIT DROP;

INSERT INTO _becoming_her_import_context (journey_id)
SELECT id FROM public.journeys
WHERE slug IN ('becoming-her','becoming-her-journey') OR lower(title) IN ('becoming her','becoming her journey');

DO $$
DECLARE v_count integer;
BEGIN
  SELECT count(*) INTO v_count FROM _becoming_her_import_context;
  IF v_count <> 1 THEN RAISE EXCEPTION 'Expected exactly one Becoming Her journey, found %', v_count; END IF;
END $$;

DELETE FROM public.chapters
WHERE journey_id = (SELECT journey_id FROM _becoming_her_import_context) AND chapter_number BETWEEN 43 AND 50;INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 43, 'Family and Boundaries', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=7;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'GENESIS 2:24 — WEBU', 'Therefore a man will leave his father and his mother, and will join with his wife, and they will be one flesh.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Genesis 2:24. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Genesis 2 describes a new one-flesh household; leaving does not mean contempt for parents, and honoring 
does not mean surrendering marital boundaries.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of new household, honor, loyalty, boundaries, and family systems. It does 
not promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when 
a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - new household, honor, loyalty, boundaries, and 
family systems - matters because a covenant relationship will magnify whatever patterns are already being 
practiced in secret.
This does not mean you must become flawless before you are loved or before you marry. The gospel is not 
a reward system for polished people. It is grace that brings sin into the light, gives courage to repent, and 
forms a new way of living. Maturity is not the absence of weakness; it is increasing truthfulness, 
responsibility, teachability, and dependence on Christ.
Popular Christian relationship advice often turns a biblical idea into a formula: find the right sign, identify 
the right person, and secure the right outcome. Scripture is more durable than a formula. It teaches 
wisdom, patience, holiness, courage, counsel, and love. Those virtues help you discern reality whether 
marriage comes soon, later, differently than expected, or not at all.
So ask two questions. First, what is God asking me to examine in myself? Second, what should I learn to 
recognize in another person? Looking inward is not self-absorption; it is repentance and formation. 
Looking outward is not suspicion; it is responsible love. Both require the humility to let truth interrupt 
fantasy.', 4),
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how new household, honor, loyalty, boundaries, 
and family systems appears in your speech, schedule, friendships, family relationships, and decision-

making. Write down evidence rather than impressions. Then ask a trusted, mature Christian whether your 
interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of new household, honor, loyalty, boundaries, and family systems into my real life. Show me 
where I am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about new household, honor, loyalty, boundaries, and 
family systems, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=43;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('How will we honor family without letting family govern the marriage?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=43;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 44, 'Conflict', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=7;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'EPHESIANS 4:26-27 — WEBU', 'Be angry, and don’t sin. Don’t let the sun go down on your wrath, neither give place to the devil.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Ephesians 4:26-27. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Ephesians 4 addresses anger within a broader call to put away falsehood and live as a new humanity; the 
verse is not a simplistic bedtime deadline.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of anger, repair, truth-telling, time, and reconciliation. It does not promise an 
easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when a woman brings 
ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - anger, repair, truth-telling, time, and reconciliation - 
matters because a covenant relationship will magnify whatever patterns are already being practiced in 
secret.
This does not mean you must become flawless before you are loved or before you marry. The gospel is not 
a reward system for polished people. It is grace that brings sin into the light, gives courage to repent, and 
forms a new way of living. Maturity is not the absence of weakness; it is increasing truthfulness, 
responsibility, teachability, and dependence on Christ.
Popular Christian relationship advice often turns a biblical idea into a formula: find the right sign, identify 
the right person, and secure the right outcome. Scripture is more durable than a formula. It teaches 
wisdom, patience, holiness, courage, counsel, and love. Those virtues help you discern reality whether 
marriage comes soon, later, differently than expected, or not at all.
So ask two questions. First, what is God asking me to examine in myself? Second, what should I learn to 
recognize in another person? Looking inward is not self-absorption; it is repentance and formation. 
Looking outward is not suspicion; it is responsible love. Both require the humility to let truth interrupt 
fantasy.', 4),
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how anger, repair, truth-telling, time, and 
reconciliation appears in your speech, schedule, friendships, family relationships, and decision-making. 

Write down evidence rather than impressions. Then ask a trusted, mature Christian whether your 
interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of anger, repair, truth-telling, time, and reconciliation into my real life. Show me where I am 
sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about anger, repair, truth-telling, time, and reconciliation, 
while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=44;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What helps conflict move toward truth and repair?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=44;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 45, 'Sex and Purity', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=7;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', '1 CORINTHIANS 6:19-20 — WEBU', 'Your body is a temple of the Holy Spirit... You are not your own, for you were bought with a price. Therefore glorify 
God in your body.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in 1 Corinthians 6:19-20. The immediate passage and its larger biblical setting 
matter: Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. 
We should receive the text on its own terms before applying it to romantic decisions.
Paul''s teaching is about belonging to Christ and fleeing sexual immorality; purity is not a woman''s burden 
alone and does not mean shame about the body.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of embodiment, holiness, consent, honor, temptation, and grace. It does not 
promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when a 
woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - embodiment, holiness, consent, honor, temptation, 
and grace - matters because a covenant relationship will magnify whatever patterns are already being 
practiced in secret.
This does not mean you must become flawless before you are loved or before you marry. The gospel is not 
a reward system for polished people. It is grace that brings sin into the light, gives courage to repent, and 
forms a new way of living. Maturity is not the absence of weakness; it is increasing truthfulness, 
responsibility, teachability, and dependence on Christ.
Popular Christian relationship advice often turns a biblical idea into a formula: find the right sign, identify 
the right person, and secure the right outcome. Scripture is more durable than a formula. It teaches 
wisdom, patience, holiness, courage, counsel, and love. Those virtues help you discern reality whether 
marriage comes soon, later, differently than expected, or not at all.
So ask two questions. First, what is God asking me to examine in myself? Second, what should I learn to 
recognize in another person? Looking inward is not self-absorption; it is repentance and formation. 
Looking outward is not suspicion; it is responsible love. Both require the humility to let truth interrupt 
fantasy.', 4),
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how embodiment, holiness, consent, honor, 
temptation, and grace appears in your speech, schedule, friendships, family relationships, and decision-

making. Write down evidence rather than impressions. Then ask a trusted, mature Christian whether your 
interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of embodiment, holiness, consent, honor, temptation, and grace into my real life. Show me 
where I am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about embodiment, holiness, consent, honor, temptation, 
and grace, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=45;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What boundaries honor both holiness and the dignity of the other person?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=45;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 46, 'Calling and Career', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=7;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'COLOSSIANS 3:23 — WEBU', 'Whatever you do, work heartily, as for the Lord, and not for men.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Colossians 3:23. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Colossians 3 places ordinary work under the lordship of Christ; marriage decisions require honest 
conversation rather than one universal career formula.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of work, vocation, gifts, family decisions, and mutual sacrifice. It does not 
promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when a 
woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - work, vocation, gifts, family decisions, and mutual 
sacrifice - matters because a covenant relationship will magnify whatever patterns are already being 
practiced in secret.
This does not mean you must become flawless before you are loved or before you marry. The gospel is not 
a reward system for polished people. It is grace that brings sin into the light, gives courage to repent, and 
forms a new way of living. Maturity is not the absence of weakness; it is increasing truthfulness, 
responsibility, teachability, and dependence on Christ.
Popular Christian relationship advice often turns a biblical idea into a formula: find the right sign, identify 
the right person, and secure the right outcome. Scripture is more durable than a formula. It teaches 
wisdom, patience, holiness, courage, counsel, and love. Those virtues help you discern reality whether 
marriage comes soon, later, differently than expected, or not at all.
So ask two questions. First, what is God asking me to examine in myself? Second, what should I learn to 
recognize in another person? Looking inward is not self-absorption; it is repentance and formation. 
Looking outward is not suspicion; it is responsible love. Both require the humility to let truth interrupt 
fantasy.', 4),
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how work, vocation, gifts, family decisions, and 
mutual sacrifice appears in your speech, schedule, friendships, family relationships, and decision-making. 

Write down evidence rather than impressions. Then ask a trusted, mature Christian whether your 
interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of work, vocation, gifts, family decisions, and mutual sacrifice into my real life. Show me 
where I am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about work, vocation, gifts, family decisions, and mutual 
sacrifice, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=46;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What work and calling has God placed before me now?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=46;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 47, 'Church and Community', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=7;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'HEBREWS 10:24-25 — WEBU', 'Let’s consider how to provoke one another to love and good works, not forsaking our own assembling together...', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Hebrews 10:24-25. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Hebrews urges believers toward gathered encouragement and perseverance; isolated romance is a poor 
substitute for the body of Christ.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of community, accountability, worship, and shared life. It does not promise 
an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when a woman 
brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - community, accountability, worship, and shared life - 
matters because a covenant relationship will magnify whatever patterns are already being practiced in 
secret.
This does not mean you must become flawless before you are loved or before you marry. The gospel is not 
a reward system for polished people. It is grace that brings sin into the light, gives courage to repent, and 
forms a new way of living. Maturity is not the absence of weakness; it is increasing truthfulness, 
responsibility, teachability, and dependence on Christ.
Popular Christian relationship advice often turns a biblical idea into a formula: find the right sign, identify 
the right person, and secure the right outcome. Scripture is more durable than a formula. It teaches 
wisdom, patience, holiness, courage, counsel, and love. Those virtues help you discern reality whether 
marriage comes soon, later, differently than expected, or not at all.
So ask two questions. First, what is God asking me to examine in myself? Second, what should I learn to 
recognize in another person? Looking inward is not self-absorption; it is repentance and formation. 
Looking outward is not suspicion; it is responsible love. Both require the humility to let truth interrupt 
fantasy.', 4),
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how community, accountability, worship, and 
shared life appears in your speech, schedule, friendships, family relationships, and decision-making. Write 

down evidence rather than impressions. Then ask a trusted, mature Christian whether your interpretation 
is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of community, accountability, worship, and shared life into my real life. Show me where I am 
sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about community, accountability, worship, and shared life, 
while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=47;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('Who knows me well enough to speak truth into my relationship?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=47;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 48, 'The Questions You Are Afraid to Ask', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=7;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'PROVERBS 18:13 — WEBU', 'He who answers before he hears, that is folly and shame to him.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Proverbs 18:13. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Proverbs praises careful listening; courageous questions are a form of love because they refuse to build a 
future on assumptions.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of curiosity, courage, listening, history, health, and truthful conversation. It 
does not promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like 
when a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - curiosity, courage, listening, history, health, and 
truthful conversation - matters because a covenant relationship will magnify whatever patterns are already 
being practiced in secret.
This does not mean you must become flawless before you are loved or before you marry. The gospel is not 
a reward system for polished people. It is grace that brings sin into the light, gives courage to repent, and 
forms a new way of living. Maturity is not the absence of weakness; it is increasing truthfulness, 
responsibility, teachability, and dependence on Christ.
Popular Christian relationship advice often turns a biblical idea into a formula: find the right sign, identify 
the right person, and secure the right outcome. Scripture is more durable than a formula. It teaches 
wisdom, patience, holiness, courage, counsel, and love. Those virtues help you discern reality whether 
marriage comes soon, later, differently than expected, or not at all.
So ask two questions. First, what is God asking me to examine in myself? Second, what should I learn to 
recognize in another person? Looking inward is not self-absorption; it is repentance and formation. 
Looking outward is not suspicion; it is responsible love. Both require the humility to let truth interrupt 
fantasy.', 4),
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how curiosity, courage, listening, history, 
health, and truthful conversation appears in your speech, schedule, friendships, family relationships, and 

decision-making. Write down evidence rather than impressions. Then ask a trusted, mature Christian 
whether your interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of curiosity, courage, listening, history, health, and truthful conversation into my real life. 
Show me where I am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about curiosity, courage, listening, history, health, and 
truthful conversation, while trusting Christ with the outcome.

PART VIII
Before You Say Yes
A wedding lasts a day. A covenant changes a life.
Move through this section slowly. Scripture gives the foundation; reflection gives you a place to answer it 
honestly. The teaching here is pastoral application and original synthesis, not a replacement for the biblical 
text.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=48;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What question am I afraid to ask because I fear the answer?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=48;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 49, 'Have I Seen His Character Under Pressure?', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=8;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'PROVERBS 24:10 — WEBU', 'If you falter in the day of trouble, your strength is small.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Proverbs 24:10. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Proverbs speaks in wisdom observations, not a laboratory test; pressure can reveal patterns, but one 
moment should be interpreted with context and honesty.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of pressure, stress, disappointment, responsibility, and resilience. It does not 
promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when a 
woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - pressure, stress, disappointment, responsibility, and 
resilience - matters because a covenant relationship will magnify whatever patterns are already being 
practiced in secret.
This does not mean you must become flawless before you are loved or before you marry. The gospel is not 
a reward system for polished people. It is grace that brings sin into the light, gives courage to repent, and 
forms a new way of living. Maturity is not the absence of weakness; it is increasing truthfulness, 
responsibility, teachability, and dependence on Christ.
Popular Christian relationship advice often turns a biblical idea into a formula: find the right sign, identify 
the right person, and secure the right outcome. Scripture is more durable than a formula. It teaches 
wisdom, patience, holiness, courage, counsel, and love. Those virtues help you discern reality whether 
marriage comes soon, later, differently than expected, or not at all.
So ask two questions. First, what is God asking me to examine in myself? Second, what should I learn to 
recognize in another person? Looking inward is not self-absorption; it is repentance and formation. 
Looking outward is not suspicion; it is responsible love. Both require the humility to let truth interrupt 
fantasy.', 4),
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how pressure, stress, disappointment, 
responsibility, and resilience appears in your speech, schedule, friendships, family relationships, and 

decision-making. Write down evidence rather than impressions. Then ask a trusted, mature Christian 
whether your interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of pressure, stress, disappointment, responsibility, and resilience into my real life. Show me 
where I am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about pressure, stress, disappointment, responsibility, and 
resilience, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=49;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What have I learned from how we handle difficulty?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=49;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 50, 'Have I Seen Him Fail?', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=8;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'PROVERBS 28:13 — WEBU', 'Whoever confesses and renounces them finds mercy.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Proverbs 28:13. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
The biblical question is not whether a person has never failed, but whether sin is hidden or confessed and 
renounced.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of failure, confession, repair, accountability, and changed behavior. It does 
not promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when 
a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - failure, confession, repair, accountability, and 
changed behavior - matters because a covenant relationship will magnify whatever patterns are already 
being practiced in secret.
This does not mean you must become flawless before you are loved or before you marry. The gospel is not 
a reward system for polished people. It is grace that brings sin into the light, gives courage to repent, and 
forms a new way of living. Maturity is not the absence of weakness; it is increasing truthfulness, 
responsibility, teachability, and dependence on Christ.
Popular Christian relationship advice often turns a biblical idea into a formula: find the right sign, identify 
the right person, and secure the right outcome. Scripture is more durable than a formula. It teaches 
wisdom, patience, holiness, courage, counsel, and love. Those virtues help you discern reality whether 
marriage comes soon, later, differently than expected, or not at all.
So ask two questions. First, what is God asking me to examine in myself? Second, what should I learn to 
recognize in another person? Looking inward is not self-absorption; it is repentance and formation. 
Looking outward is not suspicion; it is responsible love. Both require the humility to let truth interrupt 
fantasy.', 4),
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how failure, confession, repair, accountability, 
and changed behavior appears in your speech, schedule, friendships, family relationships, and decision-

making. Write down evidence rather than impressions. Then ask a trusted, mature Christian whether your 
interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of failure, confession, repair, accountability, and changed behavior into my real life. Show me 
where I am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about failure, confession, repair, accountability, and 
changed behavior, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=50;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('Have I seen repentance with changed patterns?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=50;

COMMIT;
