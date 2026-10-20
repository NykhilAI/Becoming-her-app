import { Link } from "@tanstack/react-router";

export function Brand({ compact = false }: { compact?: boolean }) {
  return (
    <Link to="/" className="inline-flex flex-col text-center text-foreground">
      <span className={compact ? "font-display text-2xl" : "font-display text-4xl"}>Becoming <em className="text-primary">Her</em></span>
      {!compact && <span className="mt-1 text-[10px] uppercase tracking-[0.24em] text-muted-foreground">Grace Led Me</span>}
    </Link>
  );
}