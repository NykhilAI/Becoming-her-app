CREATE TABLE public.reminder_preferences (
  user_id uuid PRIMARY KEY,
  email_enabled boolean NOT NULL DEFAULT false,
  days smallint[] NOT NULL DEFAULT '{1,3,5}',
  reminder_time time NOT NULL DEFAULT '07:00',
  timezone text NOT NULL DEFAULT 'UTC',
  last_sent_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.reminder_preferences TO authenticated;
GRANT ALL ON public.reminder_preferences TO service_role;
ALTER TABLE public.reminder_preferences ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Own reminders select" ON public.reminder_preferences FOR SELECT TO authenticated USING (auth.uid() = user_id);
CREATE POLICY "Own reminders insert" ON public.reminder_preferences FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Own reminders update" ON public.reminder_preferences FOR UPDATE TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Own reminders delete" ON public.reminder_preferences FOR DELETE TO authenticated USING (auth.uid() = user_id);
CREATE TRIGGER reminder_preferences_set_updated_at BEFORE UPDATE ON public.reminder_preferences FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();