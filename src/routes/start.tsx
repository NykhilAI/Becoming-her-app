import { createFileRoute, Link } from "@tanstack/react-router";
import { useState } from "react";
import { ArrowLeft, ArrowRight } from "lucide-react";
import { BotanicalMark } from "@/components/botanical-mark";
import { Brand } from "@/components/brand";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Bookplate } from "@/components/bookplate";

export const Route = createFileRoute("/start")({
  head: () => ({ meta: [
    { title: "Begin Your Journey — Becoming Her" },
    { name: "description", content: "Begin your private Becoming Her biblical journal journey." },
    { property: "og:title", content: "Begin Your Journey — Becoming Her" },
    { property: "og:description", content: "Begin your private Becoming Her biblical journal journey." },
    { property: "og:type", content: "website" },
    { name: "twitter:card", content: "summary_large_image" },
  ]}),
  component: StartPage,
});

function StartPage() {
  const [step, setStep] = useState(0);
  const [details, setDetails] = useState({ name: "", email: "", prayer: "" });
  const [sealed, setSealed] = useState(false);
  const next = () => setStep((value) => Math.min(2, value + 1));
  return (
    <main className="paper-texture relative flex min-h-screen items-center justify-center overflow-hidden px-5 py-10">
      <BotanicalMark className="pointer-events-none absolute -bottom-28 -right-32 w-96 opacity-30" />
      <div className="relative z-10 w-full max-w-md">
        <div className="mb-8 flex items-center justify-between"><Button variant="ghost" size="icon" onClick={() => step ? setStep(step - 1) : history.back()} aria-label="Go back"><ArrowLeft /></Button><span className="eyebrow">{step + 1} / 3</span></div>
        {step === 0 && <section className="text-center"><Brand /><h1 className="mt-12 font-display text-5xl">Your story begins with God.</h1><p className="mt-6 leading-7 text-muted-foreground">This journal is an invitation to begin where Scripture begins: with God.</p><Button onClick={next} className="mt-10 w-full" size="lg" variant="journal">Begin your journey <ArrowRight /></Button></section>}
        {step === 1 && <section><p className="eyebrow">Before you begin</p><h1 className="mt-4 font-display text-4xl">Use this journal slowly.</h1><p className="mt-6 leading-8 text-muted-foreground">Some pages will comfort you; others will confront you. That is not a flaw in the process. Christian formation often feels like both healing and pruning.</p><p className="mt-5 leading-8 text-muted-foreground">You do not need to be dating to use this journal. In fact, some of its most important work may happen before anyone has your attention.</p><Button onClick={next} className="mt-10 w-full" size="lg" variant="journal">Continue <ArrowRight /></Button></section>}
        {step === 2 && <section><p className="eyebrow">This journal belongs to</p><h1 className="mt-4 font-display text-4xl">Make this journey yours.</h1><div className="mt-8"><Bookplate name={details.name} sealed={sealed} onSeal={() => setSealed(true)} /></div><p className="mt-4 text-center text-sm text-muted-foreground">{sealed ? "Sealed. This journey is yours." : "Write your name, then tap the seal to dedicate this journal."}</p><div className="mt-8 space-y-5"><label className="block text-sm font-medium">Name<Input className="mt-2 h-12 bg-card" value={details.name} onChange={(e) => { setSealed(false); setDetails({ ...details, name: e.target.value }); }} maxLength={100} /></label><label className="block text-sm font-medium">Email<Input className="mt-2 h-12 bg-card" type="email" value={details.email} onChange={(e) => setDetails({ ...details, email: e.target.value })} maxLength={255} /></label><label className="block text-sm font-medium">A prayer I am bringing into this journal <span className="text-muted-foreground">(optional)</span><Textarea className="mt-2 min-h-32 bg-card" value={details.prayer} onChange={(e) => setDetails({ ...details, prayer: e.target.value })} maxLength={2000} /></label></div><Button asChild className="mt-8 w-full" size="lg" variant="journal"><Link to="/auth" search={{ mode: "signup", name: details.name, email: details.email, prayer: details.prayer }}>Create your account <ArrowRight /></Link></Button><Button asChild className="mt-3 w-full" size="lg" variant="quiet"><Link to="/auth" search={{ mode: "login", name: "", email: details.email, prayer: "" }}>Log in</Link></Button></section>}
      </div>
    </main>
  );
}