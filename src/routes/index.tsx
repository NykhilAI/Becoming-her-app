import { createFileRoute, Link } from "@tanstack/react-router";
import { ArrowRight } from "lucide-react";
import { BotanicalMark } from "@/components/botanical-mark";
import { Brand } from "@/components/brand";
import { PartList } from "@/components/part-list";
import { Button } from "@/components/ui/button";
import { ReadingControls } from "@/components/reading-controls";
import { fourQuestions } from "@/lib/journey";
import { Book3D } from "@/components/book-3d";
import coverAsset from "@/assets/becoming-her-cover.png.asset.json";

// No head() here: the home route inherits title/description/og/twitter from
// __root.tsx, and ships no og:image so serve-time hosting can inject the
// project's social preview (explicit og:image or latest screenshot).
export const Route = createFileRoute("/")({
  head: () => ({ meta: [
    { title: "Becoming Her — A Biblical Journal" },
    { name: "description", content: "A private journey of biblical reflection, formation, discernment, prayer, and preparation." },
    { property: "og:title", content: "Becoming Her — A Biblical Journal" },
    { property: "og:description", content: "A private journey of biblical reflection, formation, discernment, prayer, and preparation." },
    { property: "og:type", content: "website" },
    { name: "twitter:card", content: "summary_large_image" },
  ]}),
  component: Index,
});

// IMPORTANT: Replace this placeholder. See ./README.md for routing conventions.
function Index() {
  return (
    <div className="paper-texture overflow-hidden bg-background">
      <header className="mx-auto flex max-w-6xl items-center justify-between px-5 py-5"><Brand compact /><Link to="/auth" className="text-sm text-primary underline underline-offset-4">Log in</Link></header>
      <main>
        <section className="relative mx-auto grid min-h-[calc(100svh-74px)] max-w-6xl items-center gap-10 px-5 pb-16 pt-8 md:grid-cols-[minmax(0,1fr)_minmax(280px,0.65fr)] md:py-20">
          <div className="relative z-10 max-w-2xl">
            <p className="eyebrow">A private digital journey</p>
            <h1 className="mt-5 font-display text-6xl leading-[0.86] sm:text-7xl md:text-8xl">Becoming <em className="text-primary">Her</em></h1>
            <div data-draw className="my-7 h-px w-16 bg-primary" />
            <p className="max-w-md font-display text-2xl leading-snug">A Biblical Journal for the Woman Preparing for Marriage</p>
            <p className="mt-6 max-w-lg leading-7 text-muted-foreground">A journey of biblical reflection, formation, discernment, prayer and preparation—beginning where Scripture begins: with God.</p>
            <div className="mt-9 flex max-w-sm flex-col gap-3"><Button asChild size="lg" variant="journal"><Link to="/start">Begin your journey <ArrowRight /></Link></Button><Button asChild size="lg" variant="quiet"><Link to="/auth">Already have an account? Log in</Link></Button></div>
          </div>
          <Book3D src={coverAsset.url} alt="Becoming Her: A Biblical Journal for the Woman Preparing for Marriage cover" />
          <BotanicalMark className="pointer-events-none absolute -bottom-16 -right-28 w-[390px] opacity-20 sm:right-0 md:w-[520px]" />
        </section>
        <section className="border-y border-border bg-card py-20 sm:py-24">
          <div className="mx-auto max-w-3xl px-5">
            <div className="relative flex flex-col items-center gap-4 sm:flex-row sm:justify-center">
              <p className="eyebrow text-center">A letter to her</p>
              <ReadingControls className="sm:absolute sm:right-0" />
            </div>
            <figure data-reveal className="relative mt-6 border-y border-primary/40 px-1 py-10 sm:px-8">
              <div className="pointer-events-none absolute inset-x-0 top-[3px] h-px bg-primary/20" data-draw />
              <div className="pointer-events-none absolute inset-x-0 bottom-[3px] h-px bg-primary/20" data-draw />
              <blockquote className="reading-quiet text-foreground sm:text-[calc(1.6rem*var(--reading-scale,1))]">
                “I have seen firsthand the unseen cost of walking into marriage without Christ at the center—the quiet erosion of faith, the generational loss, and the silent grief of a divided home. This journal was born from a protective pastoral heart: to help you pause, pray, and seek God’s wisdom before you ever make a covenant that shapes your entire life.”
              </blockquote>
              <figcaption className="mt-8 flex items-center gap-4">
                <span data-draw className="h-px w-10 bg-primary" />
                <span className="text-sm text-muted-foreground">Nikhil Jaykar · <em className="font-display text-base">Becoming Her</em> · Grace Led Me</span>
              </figcaption>
            </figure>
          </div>
        </section>
        <section className="py-20"><div className="mx-auto max-w-5xl px-5"><p data-reveal className="eyebrow text-center">The questions beneath the journey</p><div className="mt-10 grid gap-px bg-border sm:grid-cols-2">{fourQuestions.map((question, index) => <div key={question} data-reveal className="bg-card p-7"><span className="font-display text-3xl text-primary">0{index + 1}</span><p className="mt-4 font-display text-2xl">{question}</p></div>)}</div></div></section>
        <section className="mx-auto max-w-3xl px-5 py-20"><p className="eyebrow">Your journey</p><h2 data-reveal className="mt-3 font-display text-4xl">Eight movements of faithful preparation</h2><div className="mt-10"><PartList /></div></section>
      </main>
      <footer className="border-t border-border px-5 py-10 text-center"><Brand /><p className="mt-4 text-sm text-muted-foreground">By Nikhil Jaykar · Grace Led Me</p></footer>
    </div>
  );
}
