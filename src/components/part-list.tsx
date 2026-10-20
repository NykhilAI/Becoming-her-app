import { Link } from "@tanstack/react-router";
import { ArrowRight, LockKeyhole } from "lucide-react";
import { parts } from "@/lib/journey";

export function PartList({ interactive = false }: { interactive?: boolean }) {
  return (
    <div className="divide-y divide-border border-y border-border">
      {parts.map((part) => {
        const content = (
          <div className="grid grid-cols-[minmax(0,1fr)_auto] items-center gap-4 py-5">
            <div className="min-w-0"><p className="eyebrow">Part {roman(part.number)}</p><h3 className="mt-1 font-display text-2xl leading-tight">{part.title}</h3><p className="mt-1 text-sm text-muted-foreground">{part.range}</p></div>
            {interactive && (part.number === 1 ? <ArrowRight className="size-5 shrink-0 text-primary" /> : <LockKeyhole className="size-4 shrink-0 text-muted-foreground" />)}
          </div>
        );
        return interactive && part.number === 1 ? <Link key={part.number} to="/journey" className="block">{content}</Link> : <div key={part.number}>{content}</div>;
      })}
    </div>
  );
}

function roman(value: number) {
  return ["I", "II", "III", "IV", "V", "VI", "VII", "VIII"][value - 1];
}