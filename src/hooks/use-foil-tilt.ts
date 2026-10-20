import { useEffect, useRef } from "react";

/** Writes --tilt-x / --tilt-y (-1..1) on the element from device tilt, or pointer position as fallback. */
export function useFoilTilt<T extends HTMLElement>() {
  const ref = useRef<T>(null);
  useEffect(() => {
    const el = ref.current;
    if (!el) return;
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return;
    // Smoothly glide current values toward targets every frame.
    let tx = 0, ty = 0, cx = 0, cy = 0, frame = 0;
    const clamp = (v: number) => Math.max(-1, Math.min(1, v));
    const loop = () => {
      cx += (tx - cx) * 0.12;
      cy += (ty - cy) * 0.12;
      el.style.setProperty("--tilt-x", cx.toFixed(3));
      el.style.setProperty("--tilt-y", cy.toFixed(3));
      frame = requestAnimationFrame(loop);
    };
    frame = requestAnimationFrame(loop);
    const onOrient = (e: DeviceOrientationEvent) => {
      if (e.gamma == null && e.beta == null) return;
      tx = clamp((e.gamma ?? 0) / 30);
      ty = clamp(((e.beta ?? 45) - 45) / 30);
    };
    // Cursor tilt only for real mice, so touches never freeze the book.
    const onMove = (e: PointerEvent) => {
      if (e.pointerType !== "mouse") return;
      tx = clamp((e.clientX / window.innerWidth) * 2 - 1);
      ty = clamp((e.clientY / window.innerHeight) * 2 - 1);
    };
    let listening = false;
    const listen = () => {
      if (listening) return;
      listening = true;
      window.addEventListener("deviceorientation", onOrient);
    };
    const D = (globalThis as unknown as { DeviceOrientationEvent?: { requestPermission?: () => Promise<string> } }).DeviceOrientationEvent;
    const needsPermission = typeof D?.requestPermission === "function";
    const onFirstTouch = async () => {
      if (await requestTiltPermission()) {
        window.removeEventListener("deviceorientation", onOrient);
        listening = false;
        listen();
      }
    };
    if (!needsPermission) listen();
    else {
      // Already granted earlier this session? Listening works right away.
      listen();
      window.addEventListener("touchend", onFirstTouch, { once: true });
      window.addEventListener("click", onFirstTouch, { once: true });
    }
    window.addEventListener("pointermove", onMove);
    return () => {
      cancelAnimationFrame(frame);
      window.removeEventListener("deviceorientation", onOrient);
      window.removeEventListener("pointermove", onMove);
      window.removeEventListener("touchend", onFirstTouch);
      window.removeEventListener("click", onFirstTouch);
    };
  }, []);
  return ref;
}

/** iOS requires a user gesture to grant motion access. */
export async function requestTiltPermission(): Promise<boolean> {
  const D = (globalThis as unknown as { DeviceOrientationEvent?: { requestPermission?: () => Promise<string> } }).DeviceOrientationEvent;
  if (!D?.requestPermission) return true;
  try { return (await D.requestPermission()) === "granted"; } catch { return false; }
}
