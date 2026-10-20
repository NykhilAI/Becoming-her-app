CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS trigger LANGUAGE plpgsql SET search_path = public AS $$
BEGIN NEW.updated_at = now(); RETURN NEW; END;
$$;

CREATE TABLE public.profiles (
  id uuid PRIMARY KEY,
  display_name text NOT NULL CHECK (char_length(display_name) BETWEEN 1 AND 100),
  season_of_life text CHECK (season_of_life IS NULL OR char_length(season_of_life) <= 200),
  personal_prayer text CHECK (personal_prayer IS NULL OR char_length(personal_prayer) <= 2000),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.profiles TO authenticated;
GRANT ALL ON public.profiles TO service_role;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Profiles are private to their owners" ON public.profiles FOR SELECT TO authenticated USING (auth.uid() = id);
CREATE POLICY "Users create their own profile" ON public.profiles FOR INSERT TO authenticated WITH CHECK (auth.uid() = id);
CREATE POLICY "Users update their own profile" ON public.profiles FOR UPDATE TO authenticated USING (auth.uid() = id) WITH CHECK (auth.uid() = id);
CREATE POLICY "Users delete their own profile" ON public.profiles FOR DELETE TO authenticated USING (auth.uid() = id);
CREATE TRIGGER profiles_set_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TABLE public.journeys (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug text NOT NULL UNIQUE CHECK (slug ~ '^[a-z0-9-]+$'),
  title text NOT NULL,
  subtitle text,
  author_name text,
  brand_name text,
  is_published boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.journeys TO anon, authenticated;
GRANT ALL ON public.journeys TO service_role;
ALTER TABLE public.journeys ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Published journeys are readable" ON public.journeys FOR SELECT TO anon, authenticated USING (is_published = true);
CREATE TRIGGER journeys_set_updated_at BEFORE UPDATE ON public.journeys FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TABLE public.journey_parts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  journey_id uuid NOT NULL REFERENCES public.journeys(id) ON DELETE CASCADE,
  part_number integer NOT NULL CHECK (part_number BETWEEN 1 AND 99),
  title text NOT NULL,
  chapter_start integer NOT NULL,
  chapter_end integer NOT NULL,
  is_published boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (journey_id, part_number)
);
GRANT SELECT ON public.journey_parts TO anon, authenticated;
GRANT ALL ON public.journey_parts TO service_role;
ALTER TABLE public.journey_parts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Published parts are readable" ON public.journey_parts FOR SELECT TO anon, authenticated USING (is_published = true AND EXISTS (SELECT 1 FROM public.journeys j WHERE j.id = journey_id AND j.is_published = true));
CREATE TRIGGER journey_parts_set_updated_at BEFORE UPDATE ON public.journey_parts FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TABLE public.chapters (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  journey_id uuid NOT NULL REFERENCES public.journeys(id) ON DELETE CASCADE,
  part_id uuid NOT NULL REFERENCES public.journey_parts(id) ON DELETE CASCADE,
  chapter_number integer NOT NULL CHECK (chapter_number > 0),
  title text NOT NULL,
  is_published boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (journey_id, chapter_number)
);
GRANT SELECT ON public.chapters TO anon, authenticated;
GRANT ALL ON public.chapters TO service_role;
ALTER TABLE public.chapters ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Published chapters are readable" ON public.chapters FOR SELECT TO anon, authenticated USING (is_published = true AND EXISTS (SELECT 1 FROM public.journeys j WHERE j.id = journey_id AND j.is_published = true));
CREATE TRIGGER chapters_set_updated_at BEFORE UPDATE ON public.chapters FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TABLE public.content_blocks (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  chapter_id uuid NOT NULL REFERENCES public.chapters(id) ON DELETE CASCADE,
  block_type text NOT NULL CHECK (block_type IN ('scripture','biblical_context','biblical_story','teaching','application','prayer','truth_to_carry')),
  heading text,
  body text NOT NULL,
  position integer NOT NULL CHECK (position >= 0),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (chapter_id, position)
);
GRANT SELECT ON public.content_blocks TO anon, authenticated;
GRANT ALL ON public.content_blocks TO service_role;
ALTER TABLE public.content_blocks ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Published chapter content is readable" ON public.content_blocks FOR SELECT TO anon, authenticated USING (EXISTS (SELECT 1 FROM public.chapters c JOIN public.journeys j ON j.id = c.journey_id WHERE c.id = chapter_id AND c.is_published = true AND j.is_published = true));
CREATE TRIGGER content_blocks_set_updated_at BEFORE UPDATE ON public.content_blocks FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TABLE public.reflection_questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  chapter_id uuid NOT NULL REFERENCES public.chapters(id) ON DELETE CASCADE,
  prompt text NOT NULL,
  position integer NOT NULL CHECK (position >= 0),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (chapter_id, position)
);
GRANT SELECT ON public.reflection_questions TO anon, authenticated;
GRANT ALL ON public.reflection_questions TO service_role;
ALTER TABLE public.reflection_questions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Published reflection questions are readable" ON public.reflection_questions FOR SELECT TO anon, authenticated USING (EXISTS (SELECT 1 FROM public.chapters c JOIN public.journeys j ON j.id = c.journey_id WHERE c.id = chapter_id AND c.is_published = true AND j.is_published = true));
CREATE TRIGGER reflection_questions_set_updated_at BEFORE UPDATE ON public.reflection_questions FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TABLE public.journal_responses (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  question_id uuid NOT NULL REFERENCES public.reflection_questions(id) ON DELETE CASCADE,
  response_text text NOT NULL DEFAULT '' CHECK (char_length(response_text) <= 20000),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (user_id, question_id)
);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.journal_responses TO authenticated;
GRANT ALL ON public.journal_responses TO service_role;
ALTER TABLE public.journal_responses ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Journal responses are private" ON public.journal_responses FOR SELECT TO authenticated USING (auth.uid() = user_id);
CREATE POLICY "Users create private responses" ON public.journal_responses FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users update private responses" ON public.journal_responses FOR UPDATE TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users delete private responses" ON public.journal_responses FOR DELETE TO authenticated USING (auth.uid() = user_id);
CREATE TRIGGER journal_responses_set_updated_at BEFORE UPDATE ON public.journal_responses FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TABLE public.chapter_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  chapter_id uuid NOT NULL REFERENCES public.chapters(id) ON DELETE CASCADE,
  is_completed boolean NOT NULL DEFAULT false,
  last_active_at timestamptz NOT NULL DEFAULT now(),
  completed_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (user_id, chapter_id)
);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.chapter_progress TO authenticated;
GRANT ALL ON public.chapter_progress TO service_role;
ALTER TABLE public.chapter_progress ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Progress is private" ON public.chapter_progress FOR SELECT TO authenticated USING (auth.uid() = user_id);
CREATE POLICY "Users create their own progress" ON public.chapter_progress FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users update their own progress" ON public.chapter_progress FOR UPDATE TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users delete their own progress" ON public.chapter_progress FOR DELETE TO authenticated USING (auth.uid() = user_id);
CREATE TRIGGER chapter_progress_set_updated_at BEFORE UPDATE ON public.chapter_progress FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TABLE public.user_entitlements (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  journey_id uuid NOT NULL REFERENCES public.journeys(id) ON DELETE CASCADE,
  entitlement_type text NOT NULL CHECK (entitlement_type IN ('free','full_access','supporter','subscription')),
  expires_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (user_id, journey_id, entitlement_type)
);
GRANT SELECT ON public.user_entitlements TO authenticated;
GRANT ALL ON public.user_entitlements TO service_role;
ALTER TABLE public.user_entitlements ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users view their own access" ON public.user_entitlements FOR SELECT TO authenticated USING (auth.uid() = user_id);
CREATE TRIGGER user_entitlements_set_updated_at BEFORE UPDATE ON public.user_entitlements FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

WITH new_journey AS (
  INSERT INTO public.journeys (slug, title, subtitle, author_name, brand_name, is_published)
  VALUES ('becoming-her', 'BECOMING HER', 'A Biblical Journal for the Woman Preparing for Marriage', 'Nikhil Jaykar', 'Grace Led Me', true)
  RETURNING id
), parts AS (
  INSERT INTO public.journey_parts (journey_id, part_number, title, chapter_start, chapter_end, is_published)
  SELECT id, n, title, first_chapter, last_chapter, true FROM new_journey CROSS JOIN (VALUES
    (1, 'Before You Look for Him', 1, 6),
    (2, 'Becoming Her', 7, 10),
    (3, 'What Should You Look For?', 11, 18),
    (4, 'When Someone Comes Along', 19, 25),
    (5, 'Biblical Women, Real Stories', 26, 31),
    (6, 'Pray, Wait & Discern', 32, 38),
    (7, 'Conversations Before Commitment', 39, 48),
    (8, 'Before You Say Yes', 49, 54)
  ) AS p(n, title, first_chapter, last_chapter)
  RETURNING id, journey_id, part_number
), chapter AS (
  INSERT INTO public.chapters (journey_id, part_id, chapter_number, title, is_published)
  SELECT journey_id, id, 1, 'Before There Was “Him,” There Was God', true FROM parts WHERE part_number = 1
  RETURNING id
), blocks AS (
  INSERT INTO public.content_blocks (chapter_id, block_type, heading, body, position)
  SELECT id, block_type, heading, body, position FROM chapter CROSS JOIN (VALUES
    ('scripture', 'GENESIS 2:18, 22–24 — WEBU', 'The LORD God said, “It is not good for the man to be alone. I will make him a helper comparable to him.” ... The LORD God made a woman from the rib which he had taken from the man, and brought her to the man. The man said, “This is now bone of my bones, and flesh of my flesh. She will be called ‘woman,’ because she was taken out of Man.” Therefore a man will leave his father and his mother, and will join with his wife, and they will be one flesh.', 1),
    ('biblical_context', 'VERIFIED BIBLICAL CONTEXT', E'Genesis 1 presents humanity as created in God''s image, male and female. Genesis 2 gives a closer view of human relationship, garden vocation, the first “not good,” and the formation of woman. The text establishes marriage as part of God''s good creation, but it does not teach that every individual woman must find one secret preassigned spouse in order to obey God.\n\nThe phrase translated “helper comparable to him” does not imply inferiority. In the Old Testament, God Himself is often called helper. In Genesis 2, the point is fit, correspondence, and partnership under God, not a hierarchy of worth.', 2),
    ('biblical_story', 'BIBLICAL STORY', E'The first woman enters the story after Adam has seen the living creatures and has found no companion corresponding to him. God forms her, brings her to the man, and the man''s poem recognizes kinship: bone of my bones, flesh of my flesh. The story moves from aloneness to covenantal union, from individual humanity to shared life.\n\nBut notice the order: God acts first. God creates, commands, forms, brings, and blesses. Marriage is not born from panic, comparison, or social pressure. It is received within God''s world and under God''s authority.', 3),
    ('teaching', 'TEACHING', E'A woman preparing for marriage must begin with God because marriage cannot bear the weight of God. A husband may one day love you faithfully, but he cannot give you ultimate identity. He may cherish you, but he cannot become your creator. He may walk beside you, but he cannot become the source of your soul.\n\nMany women do not consciously say, “Marriage is my god.” But the heart may still act as if a relationship can save it. It may treat singleness as exile, attention as resurrection, and engagement as vindication. This is why the first lesson does not begin with choosing a man. It begins with worship.\n\nGenesis gives us permission to say marriage is good. It also gives us no permission to say marriage is ultimate. The garden was full of goodness before the wedding language appeared. God was already present. Work had already been given. The human creature was already alive by the breath of God.\n\nSo the desire for marriage does not need to be despised. It needs to be purified. You can desire companionship without making companionship your Christ. You can pray for a husband without making marriage the condition of your joy. You can prepare for covenant without forgetting that you already belong to God.', 4),
    ('application', 'APPLICATION', E'Ask where marriage has become too important in your imagination. Not important in a healthy way, but ultimate in a way that creates fear, envy, impatience, or compromise.\n\nPractice saying this honestly: marriage is good, but God is better. That sentence is not a punishment. It is protection.', 5),
    ('prayer', 'PRAYER — PUT FIRST THINGS FIRST', E'Lord God, You created marriage, so I do not need to be embarrassed by my desire for it. But You alone are Lord, so I do not want that desire to rule me. Put first things first in my heart.\n\nForgive me for the times I have imagined that my life will only become meaningful when a man chooses me. Forgive me for letting comparison write stories about my worth. Forgive me for treating delay as rejection when You may be using it as formation.\n\nTeach me to honor marriage without worshiping it. Teach me to prepare without striving. Teach me to desire without demanding. If I marry one day, let that marriage be received as a gift under Your lordship, not as an idol I have chased. Amen.', 6),
    ('truth_to_carry', 'TRUTH TO CARRY', 'My story does not begin with a future husband. My story begins with God.', 7)
  ) AS b(block_type, heading, body, position)
  RETURNING chapter_id
)
INSERT INTO public.reflection_questions (chapter_id, prompt, position)
SELECT id, prompt, position FROM chapter CROSS JOIN (VALUES
  ('Where have I allowed marriage to become too important?', 1),
  ('What would change if I believed my story begins with God, not with being chosen by a man?', 2),
  ('What desire do I need to bring honestly before the Lord?', 3)
) AS q(prompt, position);