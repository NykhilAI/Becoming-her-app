import { createFileRoute, Link } from "@tanstack/react-router";
import { useQuery } from "@tanstack/react-query";
import { ArrowLeft, Check, CircleCheck, LoaderCircle, TriangleAlert } from "lucide-react";
import { useCallback, useEffect, useRef, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { AppShell } from "@/components/app-shell";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { ReadingControls } from "@/components/reading-controls";
import { GuidedQuestions } from "@/components/guided-questions";
import { SacredRootsText } from "@/components/sacred-roots";

const ROMAN = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII"];

export const Route = createFileRoute("/_authenticated/chapter/$chapterNumber")({
  head: () => ({
    meta: [
      { title: "Chapter 1 — Becoming Her" },
      { name: "description", content: "Before There Was ‘Him,’ There Was God." },
      { property: "og:title", content: "Chapter 1 — Becoming Her" },
      { property: "og:description", content: "Before There Was ‘Him,’ There Was God." },
      { property: "og:type", content: "article" },
      { name: "twitter:card", content: "summary" },
      { name: "robots", content: "noindex,nofollow" },
    ],
  }),
  component: Chapter,
});

function Chapter() {
  const { chapterNumber } = Route.useParams();
  const { user } = Route.useRouteContext();
  const [busy, setBusy] = useState(false);
  const { data, refetch } = useQuery({
    queryKey: ["chapter", chapterNumber, user.id],
    queryFn: async () => {
      const chapter = await supabase
        .from("chapters")
        .select("id,title,chapter_number,journey_parts(part_number,title),content_blocks(*),reflection_questions(*)")
        .eq("chapter_number", Number(chapterNumber))
        .single();
      if (chapter.error) throw chapter.error;
      if (chapter.data.chapter_number > 1) {
        const prev = await supabase
          .from("chapter_progress")
          .select("is_completed,chapters!inner(chapter_number)")
          .eq("user_id", user.id)
          .eq("is_completed", true)
          .eq("chapters.chapter_number", chapter.data.chapter_number - 1)
          .maybeSingle();
        if (!prev.data) throw new Error(`This chapter opens after you complete Chapter ${chapter.data.chapter_number - 1}.`);
      }
      const responses = await supabase.from("journal_responses").select("question_id,response_text").eq("user_id", user.id);
      const progress = await supabase.from("chapter_progress").select("is_completed").eq("user_id", user.id).eq("chapter_id", chapter.data.id).maybeSingle();
      await supabase
        .from("chapter_progress")
        .upsert({ user_id: user.id, chapter_id: chapter.data.id, last_active_at: new Date().toISOString() }, { onConflict: "user_id,chapter_id" });
      return {
        chapter: chapter.data,
        responses: Object.fromEntries((responses.data ?? []).map((response) => [response.question_id, response.response_text])),
        completed: progress.data?.is_completed ?? false,
      };
    },
  });

  if (!data) {
    return (
      <AppShell>
        <p className="py-16 text-center font-display text-xl text-muted-foreground">Opening your journal…</p>
      </AppShell>
    );
  }

  const blocks = [...data.chapter.content_blocks].sort((a, b) => a.position - b.position);
  const teaching = blocks.filter((block) => block.block_type !== "truth_to_carry");
  const truth = blocks.find((block) => block.block_type === "truth_to_carry");
  const questions = [...data.chapter.reflection_questions].sort((a, b) => a.position - b.position);
  const part = data.chapter.journey_parts;
  const partLabel = part ? `Part ${ROMAN[part.part_number - 1] ?? part.part_number} · ${part.title}` : "";

  async function toggleComplete() {
    setBusy(true);
    await supabase.from("chapter_progress").upsert(
      {
        user_id: user.id,
        chapter_id: data!.chapter.id,
        is_completed: !data!.completed,
        completed_at: !data!.completed ? new Date().toISOString() : null,
        last_active_at: new Date().toISOString(),
      },
      { onConflict: "user_id,chapter_id" },
    );
    await refetch();
    setBusy(false);
  }

  return (
    <AppShell>
      <ReadingProgress />
      <article className="mx-auto max-w-2xl">
        <div className="flex items-center justify-between">
          <Link to="/journey" className="inline-flex items-center gap-2 text-xs uppercase tracking-[0.16em] text-muted-foreground">
            <ArrowLeft className="size-3.5" /> Parts &amp; Chapters
          </Link>
          <ReadingControls />
        </div>
        <JumpMenu />
        <header className="mt-6 border-b border-border pb-10 text-center">
          {partLabel && <p className="eyebrow">{partLabel}</p>}
          <p className="mt-7 text-xs uppercase tracking-[0.18em] text-muted-foreground">Chapter {data.chapter.chapter_number}</p>
          <h1 className="mt-4 font-display text-[clamp(2.25rem,10vw,3.25rem)] leading-[1.02]">{data.chapter.title}</h1>
          <span className="mx-auto mt-8 block h-px w-16 bg-primary/50" />
        </header>

        {teaching.map((block) => (
          <ContentBlock key={block.id} type={block.block_type} heading={block.heading ?? ""} body={block.body} />
        ))}

        <section data-reveal id="journal" className="mt-16 scroll-mt-24 border-t border-primary pt-10">
          <p className="eyebrow">Journal &amp; Reflection</p>
          <h2 className="mt-3 font-display text-4xl leading-tight">Write honestly. Return gently.</h2>
          <p className="mt-4 text-sm leading-6 text-muted-foreground">Your reflections are private to your account and saved as you write.</p>
          <div className="mt-9 space-y-12">
            {questions.map((question, index) => (
              <Reflection key={question.id} index={index + 1} question={question} initial={data.responses[question.id] ?? ""} userId={user.id} />
            ))}
          </div>
          <Button className="mt-12 w-full" size="lg" disabled={busy} variant={data.completed ? "quiet" : "journal"} onClick={toggleComplete}>
            {data.completed ? (
              <>
                <CircleCheck /> Chapter complete
              </>
            ) : (
              <>
                <Check /> Mark chapter complete
              </>
            )}
          </Button>
        </section>

        <GuidedQuestions chapterId={data.chapter.id} />

        {truth && <ContentBlock type={truth.block_type} heading={truth.heading ?? ""} body={truth.body} />}
      </article>
    </AppShell>
  );
}

function ContentBlock({ type, heading, body }: { type: string; heading: string; body: string }) {
  const quiet = type === "scripture" || type === "prayer" || type === "truth_to_carry";
  const anchor = type === "scripture" ? "scripture" : type === "teaching" ? "teaching" : type === "prayer" ? "prayer" : type === "truth_to_carry" ? "truth" : undefined;
  return (
    <section data-reveal id={anchor} className={`mt-14 scroll-mt-24 ${quiet ? "border-y border-border bg-card px-5 py-9 sm:px-8" : ""}`}>
      <p className="eyebrow">{heading}</p>
      <div className={`mt-5 whitespace-pre-line ${quiet ? "reading-quiet" : "reading-copy"}`}>
        {type === "scripture" ? <SacredRootsText text={body} /> : body}
      </div>
      {type === "scripture" && <p className="mt-6 text-xs text-muted-foreground">Tap the dotted words to see the original Hebrew.</p>}
    </section>
  );
}

function Reflection({ question, initial, userId, index }: { question: { id: string; prompt: string }; initial: string; userId: string; index: number }) {
  const [value, setValue] = useState(initial);
  const [state, setState] = useState<"saved" | "saving" | "error">("saved");
  const latest = useRef(initial);
  const words = value.trim() ? value.trim().split(/\s+/).length : 0;
  const pending = useRef(false);
  const first = useRef(true);

  const flush = useCallback(async () => {
    if (!pending.current) return;
    pending.current = false;
    const { error } = await supabase
      .from("journal_responses")
      .upsert({ user_id: userId, question_id: question.id, response_text: latest.current }, { onConflict: "user_id,question_id" });
    if (error) {
      pending.current = true;
      setState("error");
    } else {
      setState("saved");
    }
  }, [question.id, userId]);

  useEffect(() => {
    latest.current = value;
    if (first.current) {
      first.current = false;
      return;
    }
    pending.current = true;
    setState("saving");
    const timer = window.setTimeout(flush, 650);
    return () => window.clearTimeout(timer);
  }, [value, flush]);

  useEffect(() => () => void flush(), [flush]);

  return (
    <div>
      <p className="text-xs uppercase tracking-[0.16em] text-primary">Question {index}</p>
      <label className="mt-3 block font-display text-2xl leading-snug" htmlFor={question.id}>
        {question.prompt}
      </label>
      <Textarea
        id={question.id}
        value={value}
        onChange={(event) => setValue(event.target.value)}
        onBlur={() => void flush()}
        placeholder="Write your reflection…"
        maxLength={20000}
        className="mt-5 min-h-52 resize-y bg-card p-5 font-display text-lg leading-8 shadow-none"
      />
      <div className="mt-3 flex items-center justify-between gap-3 text-xs text-muted-foreground">
      <span>{words} {words === 1 ? "word" : "words"}</span>
      <p className="glass flex items-center gap-1.5 rounded-full px-3 py-1" role="status" aria-live="polite">
        {state === "saving" && <LoaderCircle className="size-3 animate-spin" />}
        {state === "saved" && <Check className="size-3" />}
        {state === "error" && <TriangleAlert className="size-3 text-primary" />}
        {state === "saving" ? "Saving…" : state === "error" ? "Not saved yet — keep this page open" : "Saved privately"}
      </p>
      </div>
    </div>
  );
}

function ReadingProgress() {
  const [p, setP] = useState(0);
  useEffect(() => {
    const on = () => {
      const h = document.documentElement.scrollHeight - window.innerHeight;
      setP(h > 0 ? Math.min(1, window.scrollY / h) : 0);
    };
    on();
    window.addEventListener("scroll", on, { passive: true });
    window.addEventListener("resize", on);
    return () => { window.removeEventListener("scroll", on); window.removeEventListener("resize", on); };
  }, []);
  return (
    <div className="fixed inset-x-0 top-0 z-40 h-0.5" aria-hidden>
      <div className="h-full origin-left bg-primary/70" style={{ transform: `scaleX(${p})` }} />
    </div>
  );
}

const JUMPS = [
  ["scripture", "Scripture"],
  ["teaching", "Teaching"],
  ["prayer", "Prayer"],
  ["journal", "Journal"],
  ["truth", "Truth to Carry"],
] as const;

function JumpMenu() {
  return (
    <div className="glass sticky top-[4.75rem] z-20 mt-5 flex items-center gap-1 rounded-full p-1">
      <nav aria-label="Jump to section" className="flex min-w-0 flex-1 gap-1 overflow-x-auto [scrollbar-width:none]">
        {JUMPS.map(([id, label]) => (
          <a key={id} href={`#${id}`} className="shrink-0 rounded-full px-3 py-1.5 text-[11px] uppercase tracking-[0.12em] text-muted-foreground transition-all hover:bg-primary/10 hover:text-primary active:scale-95">
            {label}
          </a>
        ))}
      </nav>
      <ReadingControls compact />
    </div>
  );
}
