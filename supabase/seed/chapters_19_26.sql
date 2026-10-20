-- Becoming Her — Chapters 3–54 import
-- Generated from the authoritative Becoming_Her_Final_QA_fonts_embedded.pdf
-- 52 chapters | 362 content blocks | 204 reflection questions
-- Safe to re-run: replaces only chapters 19–26 for the identified Becoming Her journey.

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
WHERE journey_id = (SELECT journey_id FROM _becoming_her_import_context) AND chapter_number BETWEEN 19 AND 26;INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 19, 'Attraction Is Not Discernment', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=4;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'PROVERBS 4:23 — WEBU', 'Keep your heart with all diligence, for out of it is the wellspring of life.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Proverbs 4:23. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Attraction is real information about desire, but it is not a verdict about character, compatibility, or God''s 
will.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of desire, attention, idealization, and guarded wisdom. It does not promise 
an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when a woman 
brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - desire, attention, idealization, and guarded wisdom - 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how desire, attention, idealization, and guarded 
wisdom appears in your speech, schedule, friendships, family relationships, and decision-making. Write 

down evidence rather than impressions. Then ask a trusted, mature Christian whether your interpretation 
is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of desire, attention, idealization, and guarded wisdom into my real life. Show me where I am 
sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about desire, attention, idealization, and guarded wisdom, 
while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=19;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What am I assuming because I feel strongly?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=19;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 20, 'Potential Is Not Character', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=4;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'JUDGES 16:20 — WEBU', 'He didn’t know that the LORD had departed from him.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Judges 16:20. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Judges presents Samson''s story as a tragic pattern of calling without faithful self-control; it is not a 
romance template.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of Samson, repeated compromise, giftedness, and the danger of 
romanticizing potential. It does not promise an easy life or a guaranteed relationship outcome. It shows 
what faithfulness looks like when a woman brings ordinary choices, desires, and relationships under God''s 
truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - Samson, repeated compromise, giftedness, and the 
danger of romanticizing potential - matters because a covenant relationship will magnify whatever 
patterns are already being practiced in secret.
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how Samson, repeated compromise, giftedness, 
and the danger of romanticizing potential appears in your speech, schedule, friendships, family 

relationships, and decision-making. Write down evidence rather than impressions. Then ask a trusted, 
mature Christian whether your interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of Samson, repeated compromise, giftedness, and the danger of romanticizing potential into 
my real life. Show me where I am sincere, where I am afraid, and where I have been using spiritual language to 
avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about Samson, repeated compromise, giftedness, and the 
danger of romanticizing potential, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=20;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('Am I loving who someone might become while ignoring who they repeatedly are?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=20;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 21, 'Words versus Patterns', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=4;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'MATTHEW 12:33 — WEBU', 'Either make the tree good and its fruit good, or make the tree corrupt and its fruit corrupt; for the tree is known by 
its fruit.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Matthew 12:33. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Jesus uses the tree-and-fruit image to connect a person''s inner condition with observable outcomes.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of consistency, time, and the relationship between inner life and outward 
behavior. It does not promise an easy life or a guaranteed relationship outcome. It shows what faithfulness 
looks like when a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - consistency, time, and the relationship between inner 
life and outward behavior - matters because a covenant relationship will magnify whatever patterns are 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how consistency, time, and the relationship 
between inner life and outward behavior appears in your speech, schedule, friendships, family 
relationships, and decision-making. Write down evidence rather than impressions. Then ask a trusted, 
mature Christian whether your interpretation is fair.

Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of consistency, time, and the relationship between inner life and outward behavior into my 
real life. Show me where I am sincere, where I am afraid, and where I have been using spiritual language to avoid 
obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about consistency, time, and the relationship between 
inner life and outward behavior, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=21;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What pattern has time revealed?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=21;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 22, 'Infatuation versus Love', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=4;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', '1 CORINTHIANS 13:4-7 — WEBU', 'Love is patient and is kind. Love doesn’t envy. Love doesn’t brag, is not proud... bears all things, believes all things, 
hopes all things, and endures all things.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in 1 Corinthians 13:4-7. The immediate passage and its larger biblical setting 
matter: Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. 
We should receive the text on its own terms before applying it to romantic decisions.
First Corinthians 13 is written into a church conflict about spiritual gifts; its definition of love is costly 
practice, not wedding decoration.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of patience, humility, truth, endurance, and the difference between desire 
and love. It does not promise an easy life or a guaranteed relationship outcome. It shows what faithfulness 
looks like when a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - patience, humility, truth, endurance, and the 
difference between desire and love - matters because a covenant relationship will magnify whatever 
patterns are already being practiced in secret.
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how patience, humility, truth, endurance, and 
the difference between desire and love appears in your speech, schedule, friendships, family relationships, 

and decision-making. Write down evidence rather than impressions. Then ask a trusted, mature Christian 
whether your interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of patience, humility, truth, endurance, and the difference between desire and love into my 
real life. Show me where I am sincere, where I am afraid, and where I have been using spiritual language to avoid 
obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about patience, humility, truth, endurance, and the 
difference between desire and love, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=22;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('Which qualities of love do I practice when I receive nothing back?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=22;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 23, 'When You Start Making Excuses', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=4;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'JEREMIAH 17:9 — WEBU', 'The heart is deceitful above all things, and it is exceedingly corrupt. Who can know it?', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Jeremiah 17:9. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Jeremiah''s warning is about the unreliability of the human heart apart from God''s searching knowledge; it 
should produce humility, not paranoia.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of self-deception, rationalization, fear, and bringing desire under truth. It 
does not promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like 
when a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - self-deception, rationalization, fear, and bringing 
desire under truth - matters because a covenant relationship will magnify whatever patterns are already 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how self-deception, rationalization, fear, and 
bringing desire under truth appears in your speech, schedule, friendships, family relationships, and 

decision-making. Write down evidence rather than impressions. Then ask a trusted, mature Christian 
whether your interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of self-deception, rationalization, fear, and bringing desire under truth into my real life. Show 
me where I am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about self-deception, rationalization, fear, and bringing 
desire under truth, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=23;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What truth am I trying to make emotionally inconvenient?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=23;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 24, 'The Red Flag Pages', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=4;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'PROVERBS 22:3 — WEBU', 'A prudent man sees danger and hides himself, but the simple pass on and suffer for it.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Proverbs 22:3. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Biblical wisdom treats danger as something to recognize and avoid. Prayer does not require remaining 
available to harm.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of coercion, contempt, secrecy, volatility, isolation, addiction, and disregard 
for boundaries. It does not promise an easy life or a guaranteed relationship outcome. It shows what 
faithfulness looks like when a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - coercion, contempt, secrecy, volatility, isolation, 
addiction, and disregard for boundaries - matters because a covenant relationship will magnify whatever 
patterns are already being practiced in secret.
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how coercion, contempt, secrecy, volatility, 
isolation, addiction, and disregard for boundaries appears in your speech, schedule, friendships, family 

relationships, and decision-making. Write down evidence rather than impressions. Then ask a trusted, 
mature Christian whether your interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of coercion, contempt, secrecy, volatility, isolation, addiction, and disregard for boundaries 
into my real life. Show me where I am sincere, where I am afraid, and where I have been using spiritual language to 
avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about coercion, contempt, secrecy, volatility, isolation, 
addiction, and disregard for boundaries, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=24;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What behaviors would require slowing down, counsel, distance, or leaving?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=24;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 25, 'The Green Flag Pages', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=4;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'GALATIANS 5:22-23 — WEBU', 'The fruit of the Spirit is love, joy, peace, patience, kindness, goodness, faith, gentleness, and self-control.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Galatians 5:22-23. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Healthy character is not charm without conflict; it is Spirit-shaped fruit across ordinary and difficult 
circumstances.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of healthy patterns, humility, honesty, accountability, and durable peace. It 
does not promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like 
when a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - healthy patterns, humility, honesty, accountability, 
and durable peace - matters because a covenant relationship will magnify whatever patterns are already 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how healthy patterns, humility, honesty, 
accountability, and durable peace appears in your speech, schedule, friendships, family relationships, and 

decision-making. Write down evidence rather than impressions. Then ask a trusted, mature Christian 
whether your interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of healthy patterns, humility, honesty, accountability, and durable peace into my real life. 
Show me where I am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about healthy patterns, humility, honesty, accountability, 
and durable peace, while trusting Christ with the outcome.

PART V
Biblical Women, Real Stories
Read the women of Scripture in their actual context.
Move through this section slowly. Scripture gives the foundation; reflection gives you a place to answer it 
honestly. The teaching here is pastoral application and original synthesis, not a replacement for the biblical 
text.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=25;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What evidence of safety and maturity is present over time?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=25;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 26, 'Rebekah', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=5;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'GENESIS 24:27 — WEBU', 'As for me, the LORD has led me in the way to the house of my master’s relatives.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Genesis 24:27. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Genesis 24 narrates a family seeking a wife for Isaac; it is ancient family history, not a dating formula for 
modern readers.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of hospitality, willingness, providence, family, and a story told within God''s 
larger covenant. It does not promise an easy life or a guaranteed relationship outcome. It shows what 
faithfulness looks like when a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - hospitality, willingness, providence, family, and a 
story told within God''s larger covenant - matters because a covenant relationship will magnify whatever 
patterns are already being practiced in secret.
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how hospitality, willingness, providence, 
family, and a story told within God''s larger covenant appears in your speech, schedule, friendships, family 

relationships, and decision-making. Write down evidence rather than impressions. Then ask a trusted, 
mature Christian whether your interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of hospitality, willingness, providence, family, and a story told within God''s larger covenant 
into my real life. Show me where I am sincere, where I am afraid, and where I have been using spiritual language to 
avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about hospitality, willingness, providence, family, and a 
story told within God''s larger covenant, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=26;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('Where can willingness and wisdom coexist in my decisions?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=26;

COMMIT;
