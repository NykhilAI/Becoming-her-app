-- Becoming Her — Chapters 3–54 import
-- Generated from the authoritative Becoming_Her_Final_QA_fonts_embedded.pdf
-- 52 chapters | 362 content blocks | 204 reflection questions
-- Safe to re-run: replaces only chapters 27–34 for the identified Becoming Her journey.

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
WHERE journey_id = (SELECT journey_id FROM _becoming_her_import_context) AND chapter_number BETWEEN 27 AND 34;INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 27, 'Leah and Rachel', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=5;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'GENESIS 29:31 — WEBU', 'The LORD saw that Leah was hated, and he opened her womb, but Rachel was barren.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Genesis 29:31. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Genesis 29-30 records a painful household shaped by favoritism and competition; Scripture describes the 
harm without presenting it as an ideal.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of comparison, rejection, rivalry, longing, and God''s attention to the 
overlooked. It does not promise an easy life or a guaranteed relationship outcome. It shows what 
faithfulness looks like when a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - comparison, rejection, rivalry, longing, and God''s 
attention to the overlooked - matters because a covenant relationship will magnify whatever patterns are 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how comparison, rejection, rivalry, longing, and 
God''s attention to the overlooked appears in your speech, schedule, friendships, family relationships, and 

decision-making. Write down evidence rather than impressions. Then ask a trusted, mature Christian 
whether your interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of comparison, rejection, rivalry, longing, and God''s attention to the overlooked into my real 
life. Show me where I am sincere, where I am afraid, and where I have been using spiritual language to avoid 
obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about comparison, rejection, rivalry, longing, and God''s 
attention to the overlooked, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=27;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('Where am I asking another person''s love to settle my worth?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=27;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 28, 'Ruth', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=5;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'RUTH 2:12 — WEBU', 'May the LORD repay your work, and may your reward be full from the LORD, the God of Israel, under whose wings 
you have come to take refuge.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Ruth 2:12. The immediate passage and its larger biblical setting matter: Scripture 
speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We should receive 
the text on its own terms before applying it to romantic decisions.
Ruth is a story of a Moabite widow finding refuge among God''s people; the narrative emphasizes faithful 
action and providence, not romantic entitlement.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of loyalty, refuge, work, kindness, providence, and redemption. It does not 
promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when a 
woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - loyalty, refuge, work, kindness, providence, and 
redemption - matters because a covenant relationship will magnify whatever patterns are already being 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how loyalty, refuge, work, kindness, 
providence, and redemption appears in your speech, schedule, friendships, family relationships, and 

decision-making. Write down evidence rather than impressions. Then ask a trusted, mature Christian 
whether your interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of loyalty, refuge, work, kindness, providence, and redemption into my real life. Show me 
where I am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about loyalty, refuge, work, kindness, providence, and 
redemption, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=28;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What does faithful obedience look like before I know the outcome?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=28;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 29, 'Abigail', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=5;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', '1 SAMUEL 25:32-33 — WEBU', 'Blessed is the LORD, the God of Israel, who sent you this day to meet me; and blessed is your wisdom...', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in 1 Samuel 25:32-33. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Abigail acts wisely in a dangerous household and David receives correction; the story does not command 
women to remain in unsafe situations.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of wisdom, courage, peacemaking, danger, and the moral limits of 
romanticizing a foolish man. It does not promise an easy life or a guaranteed relationship outcome. It 
shows what faithfulness looks like when a woman brings ordinary choices, desires, and relationships under 
God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - wisdom, courage, peacemaking, danger, and the 
moral limits of romanticizing a foolish man - matters because a covenant relationship will magnify 
whatever patterns are already being practiced in secret.
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how wisdom, courage, peacemaking, danger, 
and the moral limits of romanticizing a foolish man appears in your speech, schedule, friendships, family 

relationships, and decision-making. Write down evidence rather than impressions. Then ask a trusted, 
mature Christian whether your interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of wisdom, courage, peacemaking, danger, and the moral limits of romanticizing a foolish 
man into my real life. Show me where I am sincere, where I am afraid, and where I have been using spiritual 
language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about wisdom, courage, peacemaking, danger, and the 
moral limits of romanticizing a foolish man, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=29;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('Where do I need wise counsel and a truthful assessment of risk?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=29;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 30, 'Esther', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=5;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'ESTHER 4:14 — WEBU', 'Who knows whether you have come to the kingdom for such a time as this?', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Esther 4:14. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Esther is a court narrative about the preservation of the Jewish people; her marriage is not the story''s 
central moral.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of courage, responsibility, hidden providence, and costly obedience. It does 
not promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when 
a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - courage, responsibility, hidden providence, and costly 
obedience - matters because a covenant relationship will magnify whatever patterns are already being 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how courage, responsibility, hidden providence, 
and costly obedience appears in your speech, schedule, friendships, family relationships, and decision-

making. Write down evidence rather than impressions. Then ask a trusted, mature Christian whether your 
interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of courage, responsibility, hidden providence, and costly obedience into my real life. Show me 
where I am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about courage, responsibility, hidden providence, and 
costly obedience, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=30;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What responsibility might God be placing before me today?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=30;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 31, 'The Woman at the Well', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=5;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'JOHN 4:14 — WEBU', 'Whoever drinks of the water that I will give him will never thirst; but the water that I will give him will become in 
him a well of water springing up to eternal life.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in John 4:14. The immediate passage and its larger biblical setting matter: Scripture 
speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We should receive 
the text on its own terms before applying it to romantic decisions.
John 4 presents Jesus crossing ethnic, social, and gender boundaries to reveal truth and offer living water; 
the woman''s worth is not reduced to her relationship history.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of shame, truth, worship, witness, and Christ''s direct care for a woman with 
a complicated history. It does not promise an easy life or a guaranteed relationship outcome. It shows what 
faithfulness looks like when a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - shame, truth, worship, witness, and Christ''s direct 
care for a woman with a complicated history - matters because a covenant relationship will magnify 
whatever patterns are already being practiced in secret.
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how shame, truth, worship, witness, and 
Christ''s direct care for a woman with a complicated history appears in your speech, schedule, friendships, 

family relationships, and decision-making. Write down evidence rather than impressions. Then ask a 
trusted, mature Christian whether your interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of shame, truth, worship, witness, and Christ''s direct care for a woman with a complicated 
history into my real life. Show me where I am sincere, where I am afraid, and where I have been using spiritual 
language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about shame, truth, worship, witness, and Christ''s direct 
care for a woman with a complicated history, while trusting Christ with the outcome.

PART VI
Pray, Wait & Discern
Prayer is not a way to control the outcome.
Move through this section slowly. Scripture gives the foundation; reflection gives you a place to answer it 
honestly. The teaching here is pastoral application and original synthesis, not a replacement for the biblical 
text.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=31;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What part of my story needs to be brought honestly to Jesus?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=31;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 32, 'Pray for Your Future Husband', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=6;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'MATTHEW 6:10 — WEBU', 'Let your Kingdom come. Let your will be done on earth as it is in heaven.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Matthew 6:10. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Jesus teaches prayer around God''s name, kingdom, will, provision, forgiveness, and deliverance; Christian 
prayer is not a technique for controlling another person.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of prayer, surrender, character, and God''s kingdom rather than romantic 
fantasy. It does not promise an easy life or a guaranteed relationship outcome. It shows what faithfulness 
looks like when a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - prayer, surrender, character, and God''s kingdom 
rather than romantic fantasy - matters because a covenant relationship will magnify whatever patterns are 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how prayer, surrender, character, and God''s 
kingdom rather than romantic fantasy appears in your speech, schedule, friendships, family relationships, 

and decision-making. Write down evidence rather than impressions. Then ask a trusted, mature Christian 
whether your interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of prayer, surrender, character, and God''s kingdom rather than romantic fantasy into my real 
life. Show me where I am sincere, where I am afraid, and where I have been using spiritual language to avoid 
obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about prayer, surrender, character, and God''s kingdom 
rather than romantic fantasy, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=32;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What qualities can I pray for without turning prayer into fantasy?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=32;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 33, 'Pray for Yourself', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=6;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'PSALM 51:10 — WEBU', 'Create in me a clean heart, God. Renew a right spirit within me.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Psalm 51:10. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Psalm 51 is David''s penitential prayer after sin; its request is for cleansing and restored fellowship, not 
cosmetic improvement.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of inner renewal, confession, integrity, and dependence on grace. It does not 
promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when a 
woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - inner renewal, confession, integrity, and dependence 
on grace - matters because a covenant relationship will magnify whatever patterns are already being 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how inner renewal, confession, integrity, and 
dependence on grace appears in your speech, schedule, friendships, family relationships, and decision-

making. Write down evidence rather than impressions. Then ask a trusted, mature Christian whether your 
interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of inner renewal, confession, integrity, and dependence on grace into my real life. Show me 
where I am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about inner renewal, confession, integrity, and dependence 
on grace, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=33;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What transformation do I need more than a change in circumstances?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=33;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 34, 'Pray for Wisdom', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=6;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'JAMES 1:5 — WEBU', 'But if any of you lacks wisdom, let him ask of God, who gives to all liberally and without reproach; and it will be 
given to him.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in James 1:5. The immediate passage and its larger biblical setting matter: Scripture 
speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We should receive 
the text on its own terms before applying it to romantic decisions.
James places the promise of wisdom in a letter about trials, perseverance, and obedience; wisdom is not 
merely information but faithful response.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of asking, humility, trials, wisdom, and faithful action. It does not promise 
an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when a woman 
brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - asking, humility, trials, wisdom, and faithful action - 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how asking, humility, trials, wisdom, and 
faithful action appears in your speech, schedule, friendships, family relationships, and decision-making. 

Write down evidence rather than impressions. Then ask a trusted, mature Christian whether your 
interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of asking, humility, trials, wisdom, and faithful action into my real life. Show me where I am 
sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about asking, humility, trials, wisdom, and faithful action, 
while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=34;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('Where do I need wisdom rather than a sign?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=34;

COMMIT;
