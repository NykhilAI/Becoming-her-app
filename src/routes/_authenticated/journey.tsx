import { createFileRoute, Link } from "@tanstack/react-router";
import { useQuery } from "@tanstack/react-query";
import { ArrowRight, CircleCheck, LockKeyhole, Feather } from "lucide-react";
import { supabase } from "@/integrations/supabase/client";
import { AppShell } from "@/components/app-shell";
import { parts } from "@/lib/journey";

const ROMAN = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII"];

function bounds(range: string): [number, number] {
  const m = range.match(/(\d+)\D+(\d+)/);
  return m ? [Number(m[1]), Number(m[2])] : [0, 0];
}

export const Route = createFileRoute("/_authenticated/journey")({
  head: () => ({
    meta: [
      { title: "Your Journey — Becoming Her" },
      { name: "description", content: "Browse the Becoming Her parts and chapters." },
      { property: "og:title", content: "Your Journey — Becoming Her" },
      { property: "og:description", content: "Browse the Becoming Her parts and chapters." },
      { property: "og:type", content: "website" },
      { name: "twitter:card", content: "summary" },
      { name: "robots", content: "noindex,nofollow" },
    ],
  }),
  component: Journey,
});

function Journey() {
  const { user } = Route.useRouteContext();
  const { data: completed = [] } = useQuery({
    queryKey: ["completed-chapters", user.id],
    queryFn: async () => {
      const { data } = await supabase
        .from("chapter_progress")
        .select("is_completed,chapters(chapter_number)")
        .eq("user_id", user.id)
        .eq("is_completed", true);
      return (data ?? []).map((r) => r.chapters?.chapter_number).filter((v): v is number => typeof v === "number");
    },
  });
  const { data: chapters = [] } = useQuery({
    queryKey: ["published-chapters"],
    queryFn: async () => {
      const { data } = await supabase.from("chapters").select("chapter_number,title").order("chapter_number");
      return data ?? [];
    },
  });

  const done = new Set(completed);
  const isOpen = (n: number) => n === 1 || done.has(n - 1);

  return (
    <AppShell>
      <p className="eyebrow">Your journey</p>
      <h1 className="mt-3 font-display text-[clamp(2.5rem,12vw,3.5rem)] leading-[1.02]">Parts &amp; Chapters</h1>
      <p className="mt-5 max-w-xl leading-7 text-muted-foreground">
        Move slowly. Each chapter opens once you complete the one before it — read, pray, and write through each one first.
      </p>
      <div className="mt-12 space-y-10">
        {parts.map((part) => {
          const [start, end] = bounds(part.range);
          const list = chapters.filter((c) => c.chapter_number >= start && c.chapter_number <= end);
          const partOpen = isOpen(start);
          return (
            <section key={part.number} className="border-t border-border pt-5">
              <div className="grid grid-cols-[minmax(0,1fr)_auto] items-start gap-4">
                <div className="min-w-0">
                  <p className="eyebrow">Part {ROMAN[part.number - 1]}</p>
                  <h2 className="mt-2 font-display text-3xl leading-tight">{part.title}</h2>
                </div>
                <span className="shrink-0 pt-1 text-sm text-muted-foreground">{part.range}</span>
              </div>
              <div className="mt-5 space-y-3">
                {list.map((c) =>
                  isOpen(c.chapter_number) ? (
                    <Link
                      key={c.chapter_number}
                      to="/chapter/$chapterNumber"
                      params={{ chapterNumber: String(c.chapter_number) }}
                      className="grid min-h-16 grid-cols-[minmax(0,1fr)_auto] items-center gap-4 border border-border bg-card px-5 py-5"
                    >
                      <div className="min-w-0">
                        <p className="text-xs uppercase tracking-[0.16em] text-primary">Chapter {c.chapter_number}</p>
                        <p className="mt-2 font-display text-xl leading-snug">{c.title}</p>
                        {done.has(c.chapter_number) && <p className="mt-2 text-xs uppercase tracking-[0.14em] text-muted-foreground">Complete</p>}
                      </div>
                      {done.has(c.chapter_number) ? <CircleCheck className="size-5 shrink-0 text-primary" /> : <ArrowRight className="size-5 shrink-0 text-primary" />}
                    </Link>
                  ) : (
                    <div key={c.chapter_number} className="grid grid-cols-[minmax(0,1fr)_auto] items-center gap-4 border border-border px-5 py-5 opacity-70">
                      <div className="min-w-0">
                        <p className="text-xs uppercase tracking-[0.16em] text-muted-foreground">Chapter {c.chapter_number}</p>
                        <p className="mt-2 font-display text-xl leading-snug">{c.title}</p>
                        <p className="mt-2 text-xs text-muted-foreground">Opens after you complete Chapter {c.chapter_number - 1}</p>
                      </div>
                      <LockKeyhole className="size-4 shrink-0 text-muted-foreground" />
                    </div>
                  ),
                )}
                {list.length < end - start + 1 && (
                  <div className="flex items-center gap-2 py-2 text-sm text-muted-foreground">
                    {partOpen ? <Feather className="size-4" /> : <LockKeyhole className="size-4" />}
                    {partOpen ? "More chapters are being prepared" : `Opens after you complete Chapter ${start - 1}`}
                  </div>
                )}
              </div>
            </section>
          );
        })}
      </div>
    </AppShell>
  );
}
