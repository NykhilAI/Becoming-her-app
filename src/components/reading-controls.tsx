import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";

const SIZES = [
  { label: "Smaller", value: 0.9 },
  { label: "Standard", value: 1 },
  { label: "Larger", value: 1.12 },
  { label: "Largest", value: 1.25 },
];
const SPACINGS = [
  { label: "Snug", value: 0.9 },
  { label: "Standard", value: 1 },
  { label: "Airy", value: 1.15 },
];
const KEY = "bh-reading-prefs";

function apply(scale: number, leading: number) {
  const root = document.documentElement;
  root.style.setProperty("--reading-scale", String(scale));
  root.style.setProperty("--reading-leading", String(leading));
}

export function ReadingControls({ className = "", compact = false }: { className?: string; compact?: boolean }) {
  const [scale, setScale] = useState(1);
  const [leading, setLeading] = useState(1);

  const [userId, setUserId] = useState<string | null>(null);
  const [touched, setTouched] = useState(false);

  useEffect(() => {
    try {
      const saved = JSON.parse(localStorage.getItem(KEY) ?? "{}");
      if (typeof saved.scale === "number") setScale(saved.scale);
      if (typeof saved.leading === "number") setLeading(saved.leading);
    } catch { /* ignore */ }
    let cancelled = false;
    supabase.auth.getSession().then(async ({ data }) => {
      const id = data.session?.user.id;
      if (!id || cancelled) return;
      setUserId(id);
      const { data: row } = await supabase.from("profiles").select("reading_scale, reading_leading").eq("id", id).maybeSingle();
      if (row && !cancelled) { setScale(row.reading_scale); setLeading(row.reading_leading); }
    });
    return () => { cancelled = true; };
  }, []);

  useEffect(() => {
    apply(scale, leading);
    try { localStorage.setItem(KEY, JSON.stringify({ scale, leading })); } catch { /* ignore */ }
    if (!touched || !userId) return;
    const t = window.setTimeout(() => {
      void supabase.from("profiles").update({ reading_scale: scale, reading_leading: leading }).eq("id", userId);
    }, 400);
    return () => window.clearTimeout(t);
  }, [scale, leading, touched, userId]);

  const option = (active: boolean) =>
    `min-h-11 flex-1 border px-2 text-xs transition-colors ${active ? "border-primary bg-primary/10 text-foreground" : "border-border text-muted-foreground"}`;

  return (
    <Popover>
      <PopoverTrigger
        aria-label="Reading comfort: text size and line spacing"
        className={`glass inline-flex shrink-0 items-center gap-2 rounded-full border border-primary/30 font-display text-foreground transition-all hover:border-primary/60 hover:text-primary active:scale-95 ${compact ? "min-h-8 px-3" : "min-h-10 px-4"} ${className}`}
      >
        <span aria-hidden className="leading-none"><span className="text-xs">A</span><span className="text-base">a</span></span>
        <span className={`font-sans text-[11px] uppercase tracking-[0.12em] ${compact ? "sr-only" : ""}`}>Text size</span>
      </PopoverTrigger>
      <PopoverContent align="end" className="w-72 rounded-2xl border-border bg-background p-5">
        <p className="mb-4 text-xs text-muted-foreground">Make reading comfortable. Your choice is saved for every chapter.</p>
        <p className="eyebrow">Text size</p>
        <div className="mt-3 flex gap-1">
          {SIZES.map((s) => (
            <button key={s.label} type="button" aria-pressed={scale === s.value} onClick={() => { setTouched(true); setScale(s.value); }} className={option(scale === s.value)}>
              <span style={{ fontSize: `${0.8 * s.value}rem` }} className="font-display">Aa</span>
            </button>
          ))}
        </div>
        <p className="eyebrow mt-5">Line spacing</p>
        <div className="mt-3 flex gap-1">
          {SPACINGS.map((s) => (
            <button key={s.label} type="button" aria-pressed={leading === s.value} onClick={() => { setTouched(true); setLeading(s.value); }} className={option(leading === s.value)}>
              {s.label}
            </button>
          ))}
        </div>
      </PopoverContent>
    </Popover>
  );
}
