import { useFoilTilt, requestTiltPermission } from "@/hooks/use-foil-tilt";

type Props = { name: string; date?: Date; sealed: boolean; onSeal?: () => void; season?: string | null };

export function Bookplate({ name, date = new Date(), sealed, onSeal, season }: Props) {
  const ref = useFoilTilt<HTMLDivElement>();
  const dateText = date.toLocaleDateString(undefined, { day: "numeric", month: "long", year: "numeric" });
  async function seal() {
    await requestTiltPermission();
    if ("vibrate" in navigator) navigator.vibrate?.([12, 40, 24]);
    onSeal?.();
  }
  return (
    <div ref={ref} className="relative mx-auto w-full max-w-sm rounded-sm bg-card p-2 shadow-[0_20px_50px_-25px_color-mix(in_oklch,var(--foreground)_40%,transparent)]">
      <div className="border border-[color:var(--foil)] p-1">
        <div className="border border-[color:color-mix(in_oklch,var(--foil)_50%,transparent)] px-6 pb-8 pt-9 text-center">
          <p className="foil-text text-[0.65rem] font-semibold uppercase tracking-[0.3em]">Ex Libris</p>
          <p className="mt-4 font-display text-lg italic text-muted-foreground">This journal belongs to</p>
          <div className="mt-5 min-h-[3.5rem] border-b border-border pb-2">
            <p key={sealed ? "s" : name} className={`font-display text-4xl leading-tight break-words ${sealed ? "foil-text ink-in" : "text-foreground"}`}>{name.trim() || "\u00a0"}</p>
          </div>
          {season && <p className="mt-3 text-sm text-muted-foreground">{season}</p>}
          <p className="mt-4 text-[0.7rem] uppercase tracking-[0.22em] text-muted-foreground">Begun {dateText}</p>
          <div className="mt-7 flex justify-center">
            {sealed ? (
              <div className="seal-press wax-seal flex h-20 w-20 items-center justify-center rounded-full" aria-label="Sealed with Grace Led Me">
                <div className="wax-inner flex h-[4.1rem] w-[4.1rem] flex-col items-center justify-center rounded-full border border-[color:color-mix(in_oklch,white_45%,transparent)]">
                  <span className="font-display text-2xl leading-none text-[color:var(--foil-light)] [text-shadow:0_-1px_0_color-mix(in_oklch,black_35%,transparent),0_1px_0_color-mix(in_oklch,white_40%,transparent)]">BH</span>
                  <span className="mt-1 text-[0.4rem] uppercase tracking-[0.12em] text-[color:var(--foil-light)]">Grace Led Me</span>
                </div>
              </div>
            ) : onSeal ? (
              <button type="button" onClick={seal} disabled={!name.trim()} className="flex h-20 w-20 items-center justify-center rounded-full border border-dashed border-[color:var(--foil)] text-[0.6rem] uppercase tracking-[0.18em] text-muted-foreground transition-transform duration-150 active:scale-90 disabled:opacity-40">
                Tap to<br />seal
              </button>
            ) : null}
          </div>
          <p className="mt-6 font-display text-sm italic text-muted-foreground">Becoming Her · Grace Led Me</p>
        </div>
      </div>
    </div>
  );
}
