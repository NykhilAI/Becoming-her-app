import { useState } from "react";
import { useServerFn } from "@tanstack/react-start";
import { LoaderCircle, Sparkles } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { getFollowUpQuestions } from "@/lib/follow-up.functions";

export function GuidedQuestions({ chapterId }: { chapterId: string }) {
  const ask = useServerFn(getFollowUpQuestions);
  const [text, setText] = useState("");
  const [busy, setBusy] = useState(false);
  const [questions, setQuestions] = useState<string[]>([]);
  const [message, setMessage] = useState("");

  async function submit() {
    setBusy(true);
    setMessage("");
    try {
      const res = await ask({ data: { chapterId, reflection: text } });
      if (res.ok) setQuestions(res.questions);
      else setMessage(res.message);
    } catch {
      setMessage("Something went wrong while preparing questions. Please try again.");
    } finally {
      setBusy(false);
    }
  }

  return (
    <section className="mt-16 border-t border-border pt-10">
      <p className="eyebrow">Go a little deeper</p>
      <h2 className="mt-3 font-display text-3xl leading-tight">Questions for your heart</h2>
      <p className="mt-4 text-sm leading-6 text-muted-foreground">
        Share a few honest lines from this chapter, and receive gentle follow-up questions drawn only from what you have just read. What you share here is used to prepare the questions and is not saved.
      </p>
      <Textarea
        value={text}
        onChange={(e) => setText(e.target.value)}
        maxLength={20000}
        placeholder="What stirred in you as you read?"
        className="mt-6 min-h-36 resize-y bg-card p-5 font-display text-lg leading-8 shadow-none"
      />
      <Button className="mt-4 w-full" variant="outline" size="lg" disabled={busy || text.trim().length < 10} onClick={submit}>
        {busy ? <LoaderCircle className="animate-spin" /> : <Sparkles />}
        {busy ? "Preparing questions…" : "Receive follow-up questions"}
      </Button>
      {message && <p className="mt-4 text-sm text-muted-foreground" role="status">{message}</p>}
      {questions.length > 0 && (
        <ol className="mt-8 space-y-5 border-y border-border bg-card px-5 py-7 sm:px-8">
          {questions.map((q, i) => (
            <li key={i} className="reading-quiet">
              <span className="mr-2 text-xs uppercase tracking-[0.16em] text-primary">{i + 1}.</span>
              {q}
            </li>
          ))}
          <li className="pt-2 text-xs text-muted-foreground">AI-prepared prompts. Weigh them against Scripture and your own prayer.</li>
        </ol>
      )}
    </section>
  );
}
