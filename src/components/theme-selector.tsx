import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { THEMES, applyTheme, isTheme, storedTheme, type ThemeId } from "@/lib/theme";

export function ThemeSelector({ userId }: { userId: string }) {
  const [theme, setTheme] = useState<ThemeId>("alabaster");
  const [status, setStatus] = useState("");

  useEffect(() => {
    setTheme(storedTheme());
    supabase.from("profiles").select("theme").eq("id", userId).maybeSingle().then(({ data }) => {
      if (data && isTheme(data.theme)) { setTheme(data.theme); applyTheme(data.theme); }
    });
  }, [userId]);

  async function choose(id: ThemeId) {
    setTheme(id);
    applyTheme(id);
    const { error } = await supabase.from("profiles").update({ theme: id }).eq("id", userId);
    setStatus(error ? "Could not save. Please try again." : "Saved to your account");
  }

  return (
    <section className="mt-14 border-t border-border pt-10">
      <p className="eyebrow">Appearance</p>
      <h2 className="mt-3 font-display text-3xl">Colors of your journal</h2>
      <p className="mt-3 text-sm leading-6 text-muted-foreground">Each preview shows how a chapter and a reflection will look.</p>
      <div className="mt-6 grid gap-4 sm:grid-cols-2" role="radiogroup" aria-label="Journal colors">
        {THEMES.map((t) => (
          <button key={t.id} type="button" role="radio" aria-checked={theme === t.id} onClick={() => choose(t.id)}
            className={`flex flex-col border p-2 text-left text-sm ${theme === t.id ? "border-primary ring-1 ring-primary" : "border-border"}`}>
            <span data-theme={t.id} aria-hidden="true" className="block border border-border bg-background p-4 text-foreground">
              <span className="eyebrow block">Part I · Chapter 1</span>
              <span className="mt-2 block font-display text-xl leading-tight">Before There Was “Him,” There Was God</span>
              <span className="mt-3 block border-y border-border bg-card px-3 py-2 font-display text-sm italic">Genesis 2:18</span>
              <span className="mt-3 block text-xs text-muted-foreground">Journal & Reflection</span>
              <span className="mt-1 block h-10 border border-input bg-card" />
              <span className="mt-3 inline-block bg-primary px-3 py-1.5 text-xs text-primary-foreground">Save entry</span>
            </span>
            <span className={`mt-2 px-1 ${theme === t.id ? "text-foreground" : "text-muted-foreground"}`}>{t.label}{theme === t.id ? " · Selected" : ""}</span>
          </button>
        ))}
      </div>
      {status && <p className="mt-3 text-center text-sm text-primary" role="status">{status}</p>}
    </section>
  );
}
