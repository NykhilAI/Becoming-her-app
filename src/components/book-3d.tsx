import { useEffect, useRef } from "react";
import { useFoilTilt } from "@/hooks/use-foil-tilt";

/** A cover image presented as a physical hardcover that tilts gently with the phone or cursor. */
export function Book3D({ src, alt }: { src: string; alt: string }) {
  const ref = useFoilTilt<HTMLDivElement>();
  const wrap = useRef<HTMLDivElement>(null);
  useEffect(() => {
    const el = wrap.current;
    if (!el || window.matchMedia("(prefers-reduced-motion: reduce)").matches) return;
    let raf = 0;
    const update = () => {
      raf = 0;
      const p = Math.min(1, Math.max(0, window.scrollY / (window.innerHeight * 0.9)));
      el.style.setProperty("--book-scroll-scale", String(1 - p * 0.06));
      el.style.setProperty("--book-scroll-y", `${p * 18}px`);
      el.style.setProperty("--book-shadow-op", String(1 - p * 0.55));
    };
    const onScroll = () => { if (!raf) raf = requestAnimationFrame(update); };
    update();
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => { window.removeEventListener("scroll", onScroll); if (raf) cancelAnimationFrame(raf); };
  }, []);
  return (
    <div ref={wrap} className="book-scroll mx-auto w-full max-w-sm">
    <div ref={ref} className="book-stage relative mx-auto w-full max-w-sm">
      <div className="book-shadow" aria-hidden />
      <div className="book-3d">
        <div className="book-pages" aria-hidden />
        <div className="book-cover">
          <img src={src} alt={alt} className="block w-full" fetchPriority="high" />
          <div className="book-spine" aria-hidden />
          <div className="book-sheen" aria-hidden />
        </div>
      </div>
    </div>
    </div>
  );
}
