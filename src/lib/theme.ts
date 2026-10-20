export const THEMES = [
  { id: "alabaster", label: "Alabaster & Charcoal", colors: ["#FAFAFA", "#3F3F46", "#A89F91", "#18181B"] },
  { id: "linen", label: "Warm Linen & Rose", colors: ["#FAF7F2", "#9E5862", "#E4DDD3", "#2E2421"] },
  { id: "sage", label: "Botanical Sage", colors: ["#F6F8F5", "#526E58", "#DEE4DD", "#243328"] },
  { id: "cashmere", label: "Cashmere & Cognac", colors: ["#F8F5F0", "#9C6B4E", "#E6DFD5", "#2B231F"] },
] as const;

export type ThemeId = (typeof THEMES)[number]["id"];
const KEY = "bh-theme";

export function isTheme(v: unknown): v is ThemeId {
  return THEMES.some((t) => t.id === v);
}

export function applyTheme(id: ThemeId) {
  if (id === "alabaster") document.documentElement.removeAttribute("data-theme");
  else document.documentElement.setAttribute("data-theme", id);
  try { localStorage.setItem(KEY, id); } catch { /* ignore */ }
}

export function storedTheme(): ThemeId {
  try { const v = localStorage.getItem(KEY); if (isTheme(v)) return v; } catch { /* ignore */ }
  return "alabaster";
}
