import { createFileRoute, useNavigate } from "@tanstack/react-router";
import { z } from "zod";
import { useState } from "react";
import { BookHeart, Eye, EyeOff } from "lucide-react";
import { supabase } from "@/integrations/supabase/client";
import { lovable } from "@/integrations/lovable";
import { Brand } from "@/components/brand";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

const searchSchema = z.object({ mode: z.enum(["login", "signup"]).catch("login"), name: z.string().max(100).catch(""), email: z.string().max(255).catch(""), prayer: z.string().max(2000).catch("") });
export const Route = createFileRoute("/auth")({
  validateSearch: searchSchema,
  head: () => ({ meta: [
    { title: "Private Journal Access — Becoming Her" },
    { name: "description", content: "Create an account or return to your private Becoming Her journal." },
    { property: "og:title", content: "Private Journal Access — Becoming Her" },
    { property: "og:description", content: "Create an account or return to your private Becoming Her journal." },
    { property: "og:type", content: "website" }, { name: "twitter:card", content: "summary" }, { name: "robots", content: "noindex" },
  ]}), component: AuthPage,
});

function friendly(msg: string) {
  const m = msg.toLowerCase();
  if (m.includes("invalid login")) return "We couldn't find an account with that email and password. Please check the spelling, or create an account.";
  if (m.includes("email not confirmed")) return "Please confirm your email first — check your inbox for the link we sent.";
  if (m.includes("already registered")) return "An account with this email already exists. Please log in instead.";
  return msg;
}

function GoogleMark() {
  return <svg viewBox="0 0 48 48" className="size-5" aria-hidden="true"><path fill="#FFC107" d="M43.6 20.5H42V20H24v8h11.3C33.7 32.7 29.2 36 24 36c-6.6 0-12-5.4-12-12s5.4-12 12-12c3.1 0 5.8 1.2 7.9 3.1l5.7-5.7C34 6.1 29.3 4 24 4 12.9 4 4 12.9 4 24s8.9 20 20 20 20-8.9 20-20c0-1.3-.1-2.4-.4-3.5z"/><path fill="#FF3D00" d="m6.3 14.7 6.6 4.8C14.7 15.1 19 12 24 12c3.1 0 5.8 1.2 7.9 3.1l5.7-5.7C34 6.1 29.3 4 24 4 16.3 4 9.7 8.3 6.3 14.7z"/><path fill="#4CAF50" d="M24 44c5.2 0 9.9-2 13.4-5.2l-6.2-5.2C29.2 35.1 26.7 36 24 36c-5.2 0-9.6-3.3-11.3-8l-6.5 5C9.5 39.6 16.2 44 24 44z"/><path fill="#1976D2" d="M43.6 20.5H42V20H24v8h11.3c-.8 2.2-2.2 4.2-4.1 5.6l6.2 5.2C37 39.2 44 34 44 24c0-1.3-.1-2.4-.4-3.5z"/></svg>;
}

function AuthPage() {
  const search = Route.useSearch(); const navigate = useNavigate();
  const [mode, setMode] = useState(search.mode); const [name, setName] = useState(search.name); const [email, setEmail] = useState(search.email); const [password, setPassword] = useState("");
  const [show, setShow] = useState(false);
  const [busy, setBusy] = useState(false); const [message, setMessage] = useState("");
  async function submit(e: React.FormEvent) {
    e.preventDefault(); setBusy(true); setMessage("");
    if (!z.string().email().safeParse(email.trim()).success || password.length < 8 || (mode === "signup" && !name.trim())) { setMessage(mode === "signup" ? "Please enter your name, a valid email, and a password of at least 8 characters." : "Please enter your email and password (at least 8 characters)."); setBusy(false); return; }
    if (mode === "login") {
      const { error } = await supabase.auth.signInWithPassword({ email: email.trim(), password });
      if (error) setMessage(friendly(error.message)); else { navigate({ to: "/dashboard" }); return; }
    } else {
      const { data, error } = await supabase.auth.signUp({ email: email.trim(), password, options: { emailRedirectTo: window.location.origin, data: { display_name: name.trim(), personal_prayer: search.prayer } } });
      if (error) setMessage(friendly(error.message)); else if (!data.session) { setMessage("Almost there — check your email to confirm your account, then log in here."); setMode("login"); } else { await supabase.from("profiles").upsert({ id: data.user?.id ?? "", display_name: name.trim(), personal_prayer: search.prayer || null }); navigate({ to: "/dashboard" }); return; }
    }
    setBusy(false);
  }
  async function google() { setBusy(true); setMessage(""); const result = await lovable.auth.signInWithOAuth("google", { redirect_uri: window.location.origin }); if (result.error) { setMessage("Google sign-in didn't finish. Please try again."); setBusy(false); } else if (!result.redirected) navigate({ to: "/dashboard" }); }
  async function resetPassword() { if (!z.string().email().safeParse(email.trim()).success) { setMessage("Enter your email above first, then tap “Forgot your password?” again."); return; } const { error } = await supabase.auth.resetPasswordForEmail(email.trim(), { redirectTo: `${window.location.origin}/reset-password` }); setMessage(error ? friendly(error.message) : "Check your email for a password reset link."); }
  return <main className="paper-texture flex min-h-screen items-center justify-center px-5 py-10"><section className="w-full max-w-md"><div className="text-center"><Brand /><BookHeart className="mx-auto mt-8 size-7 text-primary" strokeWidth={1.4} /></div><div className="mt-8 border-y border-border bg-card/75 px-5 py-8 sm:px-8"><p className="eyebrow">{mode === "signup" ? "Create your account" : "Welcome back"}</p><h1 className="mt-3 font-display text-4xl">{mode === "signup" ? "Begin privately." : "Return to your journey."}</h1>
    <Button type="button" onClick={google} disabled={busy} className="mt-7 w-full gap-3" size="lg" variant="quiet"><GoogleMark />Continue with Google</Button>
    <div className="my-5 flex items-center gap-3 text-xs text-muted-foreground"><span className="h-px flex-1 bg-border" />or with email<span className="h-px flex-1 bg-border" /></div>
    <form onSubmit={submit} method="post" action="#" className="space-y-4" noValidate>
      {mode === "signup" && <label htmlFor="name" className="block text-sm">Name<Input id="name" name="name" className="mt-2 h-12" value={name} onChange={(e) => setName(e.target.value)} autoComplete="name" maxLength={100} /></label>}
      <label htmlFor="email" className="block text-sm">Email<Input id="email" name="email" className="mt-2 h-12" type="email" inputMode="email" autoCapitalize="none" autoCorrect="off" spellCheck={false} value={email} onChange={(e) => setEmail(e.target.value)} autoComplete="username" maxLength={255} /></label>
      <label htmlFor="password" className="block text-sm">Password<div className="relative mt-2"><Input id="password" name="password" className="h-12 pr-12" type={show ? "text" : "password"} value={password} onChange={(e) => setPassword(e.target.value)} autoComplete={mode === "signup" ? "new-password" : "current-password"} minLength={8} maxLength={72} /><button type="button" onClick={() => setShow((s) => !s)} aria-label={show ? "Hide password" : "Show password"} aria-pressed={show} className="absolute inset-y-0 right-0 flex w-12 items-center justify-center text-muted-foreground hover:text-foreground">{show ? <EyeOff className="size-5" strokeWidth={1.5} /> : <Eye className="size-5" strokeWidth={1.5} />}</button></div></label>
      {mode === "login" && <div className="text-right"><button type="button" onClick={resetPassword} className="text-sm text-muted-foreground underline underline-offset-4">Forgot your password?</button></div>}
      {message && <p role="status" className="text-sm leading-6 text-primary">{message}</p>}
      <Button type="submit" disabled={busy} className="w-full" size="lg" variant="journal">{busy ? (mode === "signup" ? "Preparing your journal…" : "Opening your journal…") : mode === "signup" ? "Create account" : "Log in"}</Button>
    </form>
    <button type="button" onClick={() => { setMode(mode === "signup" ? "login" : "signup"); setMessage(""); }} className="mt-6 w-full text-sm text-primary underline underline-offset-4">{mode === "signup" ? "Already have an account? Log in" : "New here? Create an account"}</button></div></section></main>;
}