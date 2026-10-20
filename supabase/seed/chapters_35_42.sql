-- Becoming Her — Chapters 3–54 import
-- Generated from the authoritative Becoming_Her_Final_QA_fonts_embedded.pdf
-- 52 chapters | 362 content blocks | 204 reflection questions
-- Safe to re-run: replaces only chapters 35–42 for the identified Becoming Her journey.

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
WHERE journey_id = (SELECT journey_id FROM _becoming_her_import_context) AND chapter_number BETWEEN 35 AND 42;INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 35, 'Pray Before You Attach Your Heart', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=6;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'PROVERBS 4:23 — WEBU', 'Keep your heart with all diligence, for out of it is the wellspring of life.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Proverbs 4:23. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
The proverb calls for vigilant care of the inner life; applying it to dating means pacing attachment so reality 
can be seen.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of attachment, pacing, boundaries, truth, and emotional stewardship. It does 
not promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when 
a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - attachment, pacing, boundaries, truth, and emotional 
stewardship - matters because a covenant relationship will magnify whatever patterns are already being 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how attachment, pacing, boundaries, truth, and 
emotional stewardship appears in your speech, schedule, friendships, family relationships, and decision-

making. Write down evidence rather than impressions. Then ask a trusted, mature Christian whether your 
interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of attachment, pacing, boundaries, truth, and emotional stewardship into my real life. Show 
me where I am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about attachment, pacing, boundaries, truth, and 
emotional stewardship, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=35;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What practices help me stay truthful while growing affection?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=35;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 36, 'When God Says Wait', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=6;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'PSALM 27:14 — WEBU', 'Wait for the LORD. Be strong, and let your heart take courage. Yes, wait for the LORD.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Psalm 27:14. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Biblical waiting is not passive denial; it is courageous dependence while continuing to obey.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of waiting, courage, prayer, and active hope. It does not promise an easy life 
or a guaranteed relationship outcome. It shows what faithfulness looks like when a woman brings ordinary 
choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - waiting, courage, prayer, and active hope - matters 
because a covenant relationship will magnify whatever patterns are already being practiced in secret.
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how waiting, courage, prayer, and active hope 
appears in your speech, schedule, friendships, family relationships, and decision-making. Write down 
evidence rather than impressions. Then ask a trusted, mature Christian whether your interpretation is fair.

Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of waiting, courage, prayer, and active hope into my real life. Show me where I am sincere, 
where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about waiting, courage, prayer, and active hope, while 
trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=36;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('How can I practice faithful hope today?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=36;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 37, 'When God Says No', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=6;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', '2 CORINTHIANS 12:9 — WEBU', 'My grace is sufficient for you, for my power is made perfect in weakness.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in 2 Corinthians 12:9. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Paul''s thorn passage does not explain every disappointment; it records God''s sufficient grace within an 
unanswered request.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of disappointment, limits, grace, grief, and trust without simplistic 
explanations. It does not promise an easy life or a guaranteed relationship outcome. It shows what 
faithfulness looks like when a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - disappointment, limits, grace, grief, and trust without 
simplistic explanations - matters because a covenant relationship will magnify whatever patterns are 
already being practiced in secret.
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how disappointment, limits, grace, grief, and 
trust without simplistic explanations appears in your speech, schedule, friendships, family relationships, 

and decision-making. Write down evidence rather than impressions. Then ask a trusted, mature Christian 
whether your interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of disappointment, limits, grace, grief, and trust without simplistic explanations into my real 
life. Show me where I am sincere, where I am afraid, and where I have been using spiritual language to avoid 
obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about disappointment, limits, grace, grief, and trust 
without simplistic explanations, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=37;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What would grieving honestly with God look like?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=37;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 38, 'Surrender the Man, Not Just the Outcome', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=6;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'PSALM 37:5 — WEBU', 'Commit your way to the LORD. Trust also in him, and he will do this.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Psalm 37:5. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Psalm 37 calls the righteous to trust, do good, delight, commit, and wait; it is not a guarantee that God will 
give a particular person.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of surrender, control, attachment, and trust in God''s character. It does not 
promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when a 
woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - surrender, control, attachment, and trust in God''s 
character - matters because a covenant relationship will magnify whatever patterns are already being 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how surrender, control, attachment, and trust in 
God''s character appears in your speech, schedule, friendships, family relationships, and decision-making. 

Write down evidence rather than impressions. Then ask a trusted, mature Christian whether your 
interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of surrender, control, attachment, and trust in God''s character into my real life. Show me 
where I am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about surrender, control, attachment, and trust in God''s 
character, while trusting Christ with the outcome.

PART VII
Conversations Before Commitment
Questions worth asking before emotions make them harder to ask.
Move through this section slowly. Scripture gives the foundation; reflection gives you a place to answer it 
honestly. The teaching here is pastoral application and original synthesis, not a replacement for the biblical 
text.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=38;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What am I trying to control through spiritual language?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=38;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 39, 'Faith', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=7;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'AMOS 3:3 — WEBU', 'Do two walk together, unless they have agreed?', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Amos 3:3. The immediate passage and its larger biblical setting matter: Scripture 
speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We should receive 
the text on its own terms before applying it to romantic decisions.
Amos uses the question within a prophetic argument about Israel and God''s message; applying it to 
marriage requires care, but shared direction is a wise relational concern.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of shared allegiance to Christ, worship, church, and spiritual direction. It 
does not promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like 
when a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - shared allegiance to Christ, worship, church, and 
spiritual direction - matters because a covenant relationship will magnify whatever patterns are already 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how shared allegiance to Christ, worship, 
church, and spiritual direction appears in your speech, schedule, friendships, family relationships, and 

decision-making. Write down evidence rather than impressions. Then ask a trusted, mature Christian 
whether your interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of shared allegiance to Christ, worship, church, and spiritual direction into my real life. Show 
me where I am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about shared allegiance to Christ, worship, church, and 
spiritual direction, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=39;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What does shared faith look like in ordinary life?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=39;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 40, 'Marriage', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=7;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'MATTHEW 19:6 — WEBU', 'What therefore God has joined together, don’t let man tear apart.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Matthew 19:6. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Jesus answers a question about divorce by returning to creation and the seriousness of marriage; this is not 
a command to remain in danger.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of covenant, permanence, sexual union, and sober promises. It does not 
promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when a 
woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - covenant, permanence, sexual union, and sober 
promises - matters because a covenant relationship will magnify whatever patterns are already being 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how covenant, permanence, sexual union, and 
sober promises appears in your speech, schedule, friendships, family relationships, and decision-making. 

Write down evidence rather than impressions. Then ask a trusted, mature Christian whether your 
interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of covenant, permanence, sexual union, and sober promises into my real life. Show me where I 
am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about covenant, permanence, sexual union, and sober 
promises, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=40;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What do I believe marriage is for?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=40;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 41, 'Children', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=7;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'PSALM 127:3 — WEBU', 'Behold, children are a heritage of the LORD. The fruit of the womb is a reward.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Psalm 127:3. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Psalm 127 celebrates children within a song about household and city life; it does not provide a timetable 
or guarantee for every marriage.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of children, calling, family hopes, infertility, adoption, and compassion. It 
does not promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like 
when a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - children, calling, family hopes, infertility, adoption, 
and compassion - matters because a covenant relationship will magnify whatever patterns are already 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how children, calling, family hopes, infertility, 
adoption, and compassion appears in your speech, schedule, friendships, family relationships, and 

decision-making. Write down evidence rather than impressions. Then ask a trusted, mature Christian 
whether your interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of children, calling, family hopes, infertility, adoption, and compassion into my real life. 
Show me where I am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about children, calling, family hopes, infertility, adoption, 
and compassion, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=41;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What hopes and fears do I carry about children?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=41;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 42, 'Money', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=7;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'LUKE 14:28 — WEBU', 'For which of you, desiring to build a tower, doesn’t first sit down and count the cost...?', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Luke 14:28. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Jesus uses cost-counting as part of a larger teaching about the cost of discipleship; wise financial 
conversation is one practical expression of honesty.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of stewardship, debt, generosity, work, honesty, and planning. It does not 
promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when a 
woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - stewardship, debt, generosity, work, honesty, and 
planning - matters because a covenant relationship will magnify whatever patterns are already being 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how stewardship, debt, generosity, work, 
honesty, and planning appears in your speech, schedule, friendships, family relationships, and decision-

making. Write down evidence rather than impressions. Then ask a trusted, mature Christian whether your 
interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of stewardship, debt, generosity, work, honesty, and planning into my real life. Show me 
where I am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about stewardship, debt, generosity, work, honesty, and 
planning, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=42;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What money conversation am I tempted to avoid?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=42;

COMMIT;
