import { useState, type ReactNode } from "react";
import { Drawer, DrawerContent, DrawerDescription, DrawerHeader, DrawerTitle } from "@/components/ui/drawer";

type Root = {
  phrase: string;
  original: string;
  transliteration: string;
  pronunciation: string;
  language: string;
  gloss: string;
  notes: string[];
  references: string;
};

// Lexical notes only — standard Hebrew lexicon facts, no added doctrine.
const ROOTS: Root[] = [
  {
    phrase: "comparable to him",
    original: "כְּנֶגְדּוֹ",
    transliteration: "kenegdô",
    pronunciation: "keh-neg-DOH",
    language: "Hebrew",
    gloss: "corresponding to him · opposite him · as his counterpart",
    notes: [
      "Built from ke (“like, as”) and neged (“in front of, opposite”).",
      "The phrase appears only here in Genesis 2:18 and again in Genesis 2:20.",
      "It describes one who stands face to face — matching, not identical.",
    ],
    references: "Genesis 2:18, 2:20",
  },
  {
    phrase: "helper",
    original: "עֵזֶר",
    transliteration: "ʿēzer",
    pronunciation: "AY-zer",
    language: "Hebrew",
    gloss: "help · helper · one who brings aid",
    notes: [
      "Used about twenty-one times in the Hebrew Old Testament.",
      "Most of those uses describe God Himself as the help of His people.",
      "The word carries no sense of lesser worth or inferior rank.",
    ],
    references: "Exodus 18:4 · Deuteronomy 33:29 · Psalm 33:20 · Psalm 121:1–2",
  },
];

export function SacredRootsText({ text }: { text: string }) {
  const [open, setOpen] = useState<Root | null>(null);
  const parts: ReactNode[] = [];
  let rest = text;
  let key = 0;
  while (rest.length) {
    let best: { i: number; root: Root } | null = null;
    for (const root of ROOTS) {
      const i = rest.indexOf(root.phrase);
      if (i >= 0 && (!best || i < best.i)) best = { i, root };
    }
    if (!best) {
      parts.push(rest);
      break;
    }
    parts.push(rest.slice(0, best.i));
    const root = best.root;
    parts.push(
      <button
        key={key++}
        type="button"
        onClick={() => {
          navigator.vibrate?.(10);
          setOpen(root);
        }}
        className="cursor-pointer underline decoration-[color:var(--foil)] decoration-dotted decoration-2 underline-offset-4 transition-colors hover:text-primary"
        aria-label={`Study the ${root.language} word behind “${root.phrase}”`}
      >
        {root.phrase}
      </button>,
    );
    rest = rest.slice(best.i + root.phrase.length);
  }

  return (
    <>
      {parts}
      <Drawer open={!!open} onOpenChange={(v) => !v && setOpen(null)}>
        <DrawerContent className="glass mx-auto max-w-lg">
          {open && (
            <div className="px-6 pb-10 pt-2">
              <DrawerHeader className="px-0 text-center">
                <p className="eyebrow">Sacred Roots · {open.language}</p>
                <p lang="he" dir="rtl" className="foil-text mt-4 font-display text-6xl leading-none">
                  {open.original}
                </p>
                <DrawerTitle className="mt-4 font-display text-3xl font-normal italic">{open.transliteration}</DrawerTitle>
                <DrawerDescription className="text-xs uppercase tracking-[0.16em]">Say it: {open.pronunciation}</DrawerDescription>
              </DrawerHeader>
              <span className="mx-auto my-5 block h-px w-12 bg-primary/40" />
              <p className="text-center text-sm text-muted-foreground">Translated “{open.phrase}”</p>
              <p className="mt-2 text-center font-display text-xl">{open.gloss}</p>
              <ul className="mt-6 space-y-3 text-[0.95rem] leading-7">
                {open.notes.map((n) => (
                  <li key={n} className="border-l border-primary/30 pl-4">{n}</li>
                ))}
              </ul>
              <p className="mt-6 text-xs uppercase tracking-[0.14em] text-muted-foreground">See also · {open.references}</p>
              <p className="mt-4 text-xs text-muted-foreground">Word notes from standard Hebrew lexicons. Read them alongside the Scripture, not in place of it.</p>
            </div>
          )}
        </DrawerContent>
      </Drawer>
    </>
  );
}
