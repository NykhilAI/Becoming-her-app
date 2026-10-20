-- Becoming Her — Chapters 3–54 import
-- Generated from the authoritative Becoming_Her_Final_QA_fonts_embedded.pdf
-- 52 chapters | 362 content blocks | 204 reflection questions
-- Safe to re-run: replaces only chapters 3–54 for the identified Becoming Her journey.

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
WHERE journey_id = (SELECT journey_id FROM _becoming_her_import_context) AND chapter_number BETWEEN 3 AND 10;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 3, 'You Are Not Waiting for Your Life to Begin', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=1;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', '1 CORINTHIANS 7:32-35; PHILIPPIANS 4:11-13 — WEBU', 'He who is unmarried is concerned for the things of the Lord, how he may please the Lord... The unmarried woman 
cares about the things of the Lord, that she may be holy both in body and in spirit... Not that I speak because of lack, 
for I have learned in whatever state I am, to be content in it... I can do all things through Christ who strengthens me.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'Paul''s discussion of singleness in 1 Corinthians 7 is not a dismissal of marriage. It is a serious theological 
claim that unmarried believers can live with focused devotion to the Lord. Philippians 4 speaks of learned 
contentment in changing circumstances, not the denial of desire.
Contentment in Scripture is not pretending every unmet longing is small. It is learning to live faithfully 
with Christ as sufficient while real desires remain present.', 2),
  ('biblical_story', 'BIBLICAL STORY', 'Paul writes as an unmarried apostle whose life is not on pause. His singleness is not wasted space before a 
better season. It becomes part of his devotion, labor, suffering, prayer, teaching, and care for the churches.', 3),
  ('teaching', 'TEACHING', 'One of the quiet lies many single women absorb is that life is preparation now and fullness later. Later 
when he comes. Later when the ring is on your finger. Later when your home looks like the life you 
imagined. Later when people stop asking questions.
But Scripture will not let you call today an empty hallway. If you are in Christ, today is a place of 
obedience. Today is a place of worship. Today is a place where the Spirit forms patience, courage, skill, 
generosity, holiness, friendship, service, and wisdom.
This does not mean your longing is fake. It means your longing is not allowed to cancel your calling. A 
woman can desire marriage deeply and still live fully before God now. She can grieve delay without 
surrendering to bitterness. She can prepare for marriage without treating singleness as a waiting room.
Contentment is learned. Paul says he learned it. That means contentment is not always instant, effortless, 
or sentimental. Sometimes contentment is the daily act of telling the truth: I would welcome marriage, but 
I am not abandoned without it. I desire companionship, but Christ has not withheld Himself from me.', 4),
  ('application', 'APPLICATION', 'Name one area of life you have postponed because you were waiting for marriage. Then choose a faithful 
step you can take now.
Ask God to make this season fruitful, not merely endurable.', 5),
  ('prayer', 'PRAYER — MAKE THIS SEASON FAITHFUL', 'Lord Jesus, forgive me for the ways I have treated this season as if it were less holy than the one I hope will come. I 
do not want to waste my present by constantly bargaining for a different future.
Teach me contentment that is honest, not numb. Teach me joy that can coexist with longing. Teach me obedience 
that does not wait for ideal circumstances before saying yes to You.
Show me what faithfulness looks like right now: in my work, my church, my friendships, my body, my finances, my 
habits, my prayer life, and my hidden thoughts. Make this season fruitful in ways I may only understand later. 
Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'My life in Christ is not on pause.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=3;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What have I postponed because I assumed marriage must come first?', 1),
  ('What would faithfulness look like if marriage took longer than I expected?', 2),
  ('Where is God inviting me to live fully with Him now?', 3)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=3;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 4, 'Loved Before You Are Chosen', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=1;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'EPHESIANS 1:3-7; PSALM 139:13-14 — WEBU', 'He chose us in him before the foundation of the world... having predestined us for adoption as children through Jesus 
Christ to himself... In him we have our redemption through his blood, the forgiveness of our trespasses... For you 
formed my inmost being. You knit me together in my mother’s womb. I will give thanks to you, for I am fearfully 
and wonderfully made.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'Ephesians 1 opens with praise for God''s saving work in Christ. The language of choosing, adoption, 
redemption, forgiveness, grace, and inheritance concerns God''s people in Christ. Psalm 139 is a prayer 
attributed to David that confesses God''s intimate knowledge, presence, and creative care.
These passages should not be reduced to self-esteem slogans. They are deeper than that: they locate the 
believer''s life inside God''s knowing, redeeming, adopting grace.', 2),
  ('teaching', 'TEACHING', 'The question “Will someone choose me?” can become painfully loud. It may grow louder after rejection, 
after another wedding invitation, after a relationship ends, after a birthday, after family comments, or after 
scrolling through lives that seem to be moving faster than yours.
Ephesians answers a deeper question first: Who has already called me His? In Christ, the believer is not 
auditioning for belovedness. She is not waiting for a man to confirm that she is worth pursuing. She is 
adopted, redeemed, forgiven, graced, and brought near.
This does not make romantic rejection painless. But it changes what rejection can say. Rejection may say, 
“This person did not choose me.” It may not say, “I am unwanted by God.” It may say, “This relationship 
ended.” It may not say, “My life is unloved.”
Psalm 139 adds another layer: God knows you completely. He knows the story behind your reactions, the 
wounds beneath your fears, the body you criticize, the memories you carry, and the dreams you barely say 
aloud. His knowledge is not cold surveillance. In the psalm, it becomes the ground of worship and 
surrender.', 3),
  ('application', 'APPLICATION', 'When the ache of being unchosen rises, answer it with truth before you answer it with distraction.
Write a clear distinction: what a person''s rejection can mean, and what it cannot mean about your identity 
in Christ.', 4),
  ('prayer', 'PRAYER — ANCHOR MY WORTH IN CHRIST', 'Father, I confess that I sometimes want human attention to do work only Your love can do. I want to feel chosen, 
pursued, delighted in, and secure. These desires are tender, and I bring them to You.

Anchor my worth in Christ. Let Your adoption speak louder than rejection. Let Your redemption speak louder than 
shame. Let Your knowledge of me speak louder than my fear of being misunderstood.
When I am tempted to measure my value by relationship status, appearance, attention, or comparison, call me back 
to the truth. I am not waiting to become loved. In Christ, I am already held by grace. Amen.', 5),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I am loved in Christ before I am chosen by anyone else.', 6)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=4;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('Where have I allowed being chosen by a man to feel like proof of my worth?', 1),
  ('What does Ephesians 1 say God has done for His people in Christ?', 2),
  ('What lie about rejection do I need to renounce?', 3)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=4;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 5, 'The Woman God Is Forming', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=1;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'GALATIANS 5:22-25 — WEBU', 'But the fruit of the Spirit is love, joy, peace, patience, kindness, goodness, faith, gentleness, and self-control. Against 
such things there is no law. Those who belong to Christ have crucified the flesh with its passions and lusts. If we live 
by the Spirit, let’s also walk by the Spirit.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'Galatians 5 contrasts life directed by the flesh with life led by the Spirit. The fruit of the Spirit is not 
presented as a dating checklist or personality aesthetic. It is the visible ethical fruit of belonging to Christ 
and walking by the Spirit.
The list begins in a letter concerned with the gospel of grace. Christian character is not self-salvation. It is 
Spirit-formed life flowing from union with Christ.', 2),
  ('teaching', 'TEACHING', 'Before asking God for a man of character, ask Him to form character in you. This is not because you must 
become flawless before you can marry. It is because marriage does not remove the need for sanctification; 
it reveals it.
The fruit of the Spirit is deeply relational. Love affects how you treat people. Joy affects what controls your 
mood. Peace affects conflict. Patience affects waiting. Kindness affects speech. Goodness affects decisions. 
Faithfulness affects trust. Gentleness affects power. Self-control affects desire.
A woman preparing for marriage should pay attention to these fruits because marriage will not create 
them automatically. A wedding can change your name, household, schedule, and responsibilities. It cannot 
replace the work of the Holy Spirit.
This chapter is not an invitation to self-condemnation. It is an invitation to honest cooperation with grace. 
You may discover impatience, envy, manipulation, fear, anger, or lack of self-control. Do not hide it behind 
the dream of a future marriage. Bring it into the light now.', 3),
  ('application', 'APPLICATION', 'Choose one fruit of the Spirit that is currently weak in your relationships. Ask what situations expose that 
weakness.
Do not only ask, “Would I recognize a godly man?” Ask, “Would a godly man recognize Spirit-formed 
maturity growing in me?”', 4),
  ('prayer', 'PRAYER — FORM IN ME WHAT I AM PRAYING TO FIND', 'Holy Spirit, form in me what I cannot manufacture by effort alone. Grow love where I am selfish, joy where I am 
ruled by circumstances, peace where I am anxious, and patience where I am restless.
Make me kind in my words, good in my choices, faithful in my commitments, gentle in conflict, and self-controlled 
in desire. Expose the patterns I excuse. Heal the wounds that make obedience feel threatening.

Prepare me for marriage by making me more like Christ, not by making me obsessed with perfection. Let the fruit of 
Your presence be visible in my hidden life, my friendships, my family, my church, and one day, if You will, my 
marriage. Amen.', 5),
  ('truth_to_carry', 'TRUTH TO CARRY', 'God is not only preparing a future for me; He is forming Christlike fruit in me.', 6)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=5;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('Which fruit of the Spirit do I most need God to cultivate in me right now?', 1),
  ('How do I respond when I am disappointed, corrected, delayed, or told no?', 2),
  ('What pattern should I stop excusing as “just my personality”?', 3)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=5;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 6, 'Beauty That Does Not Fade', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=1;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', '1 PETER 3:3-4 — WEBU', 'Let your beauty come not from the outward adorning of braiding your hair, and of wearing gold ornaments or of 
putting on fine clothing, but from the hidden person of the heart, in the incorruptible adornment of a gentle and 
quiet spirit, which is very precious in God’s sight.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'First Peter addresses Christians living under social pressure and calls them to honorable conduct. In 1 Peter 
3, Peter speaks to wives, including those married to husbands who do not obey the Word. His instruction 
about adornment contrasts outward display with inward character that God values.
This passage should not be used to forbid all beauty, clothing, jewelry, or care for appearance. The contrast 
is about the source of a woman''s adornment and worth. In the ancient world, elaborate hair, gold, and fine 
clothing could communicate status and honor. Peter redirects honor toward hidden, incorruptible character 
before God.', 2),
  ('biblical_story', 'BIBLICAL STORY', 'Sarah is mentioned in the following verses as an example of a woman who hoped in God. The point is not 
that every woman must imitate every cultural detail of Sarah''s marriage. The text points to hope in God 
expressed through a life ordered by reverence, courage, and honorable conduct.', 3),
  ('teaching', 'TEACHING', 'Beauty is not the enemy. Vanity is. Care is not the enemy. Worship is. The problem is not that a woman 
wants to look lovely; the problem is when visible beauty becomes the place she searches for worth, power, 
security, or control.
Peter''s words are not an insult to the feminine desire for beauty. They are a rescue from beauty that cannot 
hold. Hair changes. Skin changes. Trends change. Attention changes. The body itself is a gift, but it was 
never designed to be the foundation of identity.
The “hidden person of the heart” is not hidden from God. It may be hidden from people who only know 
how to measure what is visible, but it is precious in His sight. That phrase matters. God sees value where 
the world often sees nothing marketable.
A gentle and quiet spirit is not weakness, silence, lack of opinion, or fear. In Scripture''s moral vocabulary, 
gentleness is strength submitted to God. Quietness is not the absence of personality; it is a heart not 
governed by panic, vanity, or the need to control every outcome.', 4),
  ('application', 'APPLICATION', 'Examine where appearance has become a source of fear. What do you believe would happen if you were 
less admired, less noticed, or less physically ideal?

Practice beauty as stewardship, not slavery. Receive your body as created by God, care for it with gratitude, 
and refuse to let appearance become your master.', 5),
  ('prayer', 'PRAYER — MAKE ME BEAUTIFUL BEFORE YOU', 'Father, You know how easily I can measure myself by what is visible. You know the comparisons I make, the flaws I 
notice, the attention I enjoy, and the fear I feel when I think I am not enough.
Teach me to receive beauty without worshiping it. Help me care for my body with gratitude instead of criticism, 
modesty instead of fear, and freedom instead of vanity.
Form in me the beauty that does not fade: a heart at rest in You, speech shaped by wisdom, strength governed by 
gentleness, courage free from panic, and a spirit that is precious in Your sight. Make my hidden life beautiful before 
You. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'The beauty God calls precious is not fragile, fading, or dependent on applause.

PART II
Becoming Her
Before asking God for the right man, let Him form the right heart.
Move through this section slowly. Scripture gives the foundation; reflection gives you a place to answer it 
honestly. The teaching here is pastoral application and original synthesis, not a replacement for the biblical 
text.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=6;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('Where do I feel pressure to prove my worth through appearance?', 1),
  ('What would it mean to practice beauty as stewardship rather than slavery?', 2),
  ('How can God cultivate gentleness and holy steadiness in me?', 3)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=6;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 7, 'Wisdom Is More Valuable Than Charm', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=2;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'PROVERBS 31:25-26 — WEBU', 'She opens her mouth with wisdom. Loving kindness is on her tongue.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Proverbs 31:25-26. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Reread Proverbs 31 as a portrait of faithful wisdom rather than a perfection checklist.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of wisdom, strength, work, generosity, and fear of the LORD. It does not 
promise an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when a 
woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - wisdom, strength, work, generosity, and fear of the 
LORD - matters because a covenant relationship will magnify whatever patterns are already being 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how wisdom, strength, work, generosity, and 
fear of the LORD appears in your speech, schedule, friendships, family relationships, and decision-making. 
Write down evidence rather than impressions. Then ask a trusted, mature Christian whether your 
interpretation is fair.

Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of wisdom, strength, work, generosity, and fear of the LORD into my real life. Show me where 
I am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about wisdom, strength, work, generosity, and fear of the 
LORD, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=7;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What kind of wisdom do I need in ordinary decisions?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=7;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 8, 'Can You Receive Correction?', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=2;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'PROVERBS 12:1 — WEBU', 'Whoever loves correction loves knowledge, but he who hates reproof is stupid.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Proverbs 12:1. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Correction is not the same as control; wise correction can help expose blind spots while abusive criticism 
must not be sanctified.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of teachability, humility, listening, and growth. It does not promise an easy 
life or a guaranteed relationship outcome. It shows what faithfulness looks like when a woman brings 
ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - teachability, humility, listening, and growth - matters 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how teachability, humility, listening, and 
growth appears in your speech, schedule, friendships, family relationships, and decision-making. Write 
down evidence rather than impressions. Then ask a trusted, mature Christian whether your interpretation 
is fair.

Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of teachability, humility, listening, and growth into my real life. Show me where I am sincere, 
where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about teachability, humility, listening, and growth, while 
trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=8;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('How do I respond when someone trustworthy tells me a hard truth?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=8;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 9, 'Can You Say ‘I Was Wrong’?', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=2;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'PROVERBS 28:13 — WEBU', 'He who conceals his sins doesn’t prosper, but whoever confesses and renounces them finds mercy.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Proverbs 28:13. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Biblical repentance is more than regret or image repair; it brings sin into the light and turns toward 
obedience.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of confession, mercy, repentance, and changed direction. It does not promise 
an easy life or a guaranteed relationship outcome. It shows what faithfulness looks like when a woman 
brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - confession, mercy, repentance, and changed direction 
- matters because a covenant relationship will magnify whatever patterns are already being practiced in 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how confession, mercy, repentance, and 
changed direction appears in your speech, schedule, friendships, family relationships, and decision-making. 

Write down evidence rather than impressions. Then ask a trusted, mature Christian whether your 
interpretation is fair.
Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of confession, mercy, repentance, and changed direction into my real life. Show me where I 
am sincere, where I am afraid, and where I have been using spiritual language to avoid obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about confession, mercy, repentance, and changed 
direction, while trusting Christ with the outcome.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=9;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What would honest repentance look like in one relationship?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=9;

INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
SELECT ctx.journey_id, jp.id, 10, 'What Are You Carrying Into Marriage?', true
FROM _becoming_her_import_context ctx
JOIN public.journey_parts jp ON jp.journey_id=ctx.journey_id AND jp.part_number=2;

INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
SELECT c.id, v.block_type, v.heading, v.body, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('scripture', 'PSALM 139:23-24 — WEBU', 'Search me, God, and know my heart. Try me, and know my thoughts. See if there is any wicked way in me, and lead 
me in the everlasting way.', 1),
  ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', 'This lesson is grounded in Psalm 139:23-24. The immediate passage and its larger biblical setting matter: 
Scripture speaks within real narratives, letters, poems, wisdom sayings, and prophetic arguments. We 
should receive the text on its own terms before applying it to romantic decisions.
Self-examination is an invitation to God''s searching presence, not a demand to diagnose yourself perfectly.', 2),
  ('biblical_story', 'BIBLICAL STORY OR IMAGE', 'The passage gives us a picture of wounds, expectations, fears, family patterns, habits, and unresolved 
bitterness. It does not promise an easy life or a guaranteed relationship outcome. It shows what 
faithfulness looks like when a woman brings ordinary choices, desires, and relationships under God''s truth.', 3),
  ('teaching', 'TEACHING', 'A Christian woman preparing for marriage is not preparing for a performance. She is learning to live 
before God with honesty. The theme of this chapter - wounds, expectations, fears, family patterns, habits, 
and unresolved bitterness - matters because a covenant relationship will magnify whatever patterns are 
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
  ('application', 'APPLICATION', 'Practice this lesson in one concrete place this week. Notice how wounds, expectations, fears, family 
patterns, habits, and unresolved bitterness appears in your speech, schedule, friendships, family 
relationships, and decision-making. Write down evidence rather than impressions. Then ask a trusted, 
mature Christian whether your interpretation is fair.

Do not use this chapter to diagnose someone else from a distance. Use it to slow down, ask better 
questions, observe patterns, and obey what Scripture actually says. Wisdom is usually quieter than 
urgency.', 5),
  ('prayer', 'PRAYER — MAKE ME WISE AND WHOLE', 'Father, bring the truth of wounds, expectations, fears, family patterns, habits, and unresolved bitterness into my real 
life. Show me where I am sincere, where I am afraid, and where I have been using spiritual language to avoid 
obedience.
Give me courage to receive correction, patience to observe patterns, and humility to seek counsel. Protect me from 
fantasy that ignores facts and from fear that refuses every good gift.
Form in me the character of Jesus: truthful, holy, gentle, courageous, and willing to love without controlling the 
outcome. If marriage is part of my calling, let me enter it with wisdom. Whatever my future holds, keep me close to 
Christ. Amen.', 6),
  ('truth_to_carry', 'TRUTH TO CARRY', 'I will let Scripture and observable fruit shape my wisdom about wounds, expectations, fears, family patterns, habits, 
and unresolved bitterness, while trusting Christ with the outcome.

PART III
What Should You Look For?
Character before chemistry.
Move through this section slowly. Scripture gives the foundation; reflection gives you a place to answer it 
honestly. The teaching here is pastoral application and original synthesis, not a replacement for the biblical 
text.', 7)
) AS v(block_type, heading, body, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=10;

INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT c.id, v.prompt, v.position
FROM public.chapters c
CROSS JOIN LATERAL (VALUES
  ('What am I carrying that needs healing, counsel, confession, or boundaries?', 1),
  ('LOOK INWARD: What is God asking me to examine in myself?', 2),
  ('LOOK OUTWARD: What should I learn to recognize in another person?', 3),
  ('What would obedience look like in the next seven days?', 4)
) AS v(prompt, position)
WHERE c.journey_id=(SELECT journey_id FROM _becoming_her_import_context) AND c.chapter_number=10;

COMMIT;
