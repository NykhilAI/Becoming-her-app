import { createOpenAI } from "@ai-sdk/openai";
import { streamText, APICallError } from "ai";

const LOVABLE_AIG_RUN_ID_HEADER = "X-Lovable-AIG-Run-ID";

function createRunIdFetch() {
  let runId: string | undefined;
  return async (input: RequestInfo | URL, init?: RequestInit) => {
    const headers = new Headers(init?.headers);
    if (runId && !headers.has(LOVABLE_AIG_RUN_ID_HEADER)) headers.set(LOVABLE_AIG_RUN_ID_HEADER, runId);
    const response = await fetch(input, { ...init, headers });
    runId ??= response.headers.get(LOVABLE_AIG_RUN_ID_HEADER)?.trim() || undefined;
    return response;
  };
}

const SYSTEM = `You are a gentle, pastoral journaling companion inside "Becoming Her", a private Christian journal for women preparing for marriage.
You will receive the chapter text and the reader's own reflection.
Write exactly 3 short follow-up journaling questions that help her go deeper, honestly and prayerfully.
Rules:
- Ground every question in the chapter text provided. Do not quote, cite or invent any Scripture, biblical facts or theology not present in the chapter.
- Never present advice as a biblical command. Do not diagnose, judge, or counsel. Ask, do not tell.
- Warm, unhurried, respectful tone. Each question under 30 words.
- If her reflection mentions self-harm or danger, make the first line a gentle encouragement to reach out to a trusted person or local help today.
Output only the questions, one per line, no numbering, no preamble.`;

export type FollowUpResult = { ok: true; questions: string[] } | { ok: false; message: string };

export async function generateFollowUps(chapterText: string, reflection: string): Promise<FollowUpResult> {
  const apiKey = process.env["LOVABLE_API_KEY"];
  if (!apiKey) return { ok: false, message: "Guided questions are not set up yet." };
  const provider = createOpenAI({
    baseURL: "https://ai.gateway.lovable.dev/v1",
    apiKey,
    headers: { "Lovable-API-Key": apiKey, "X-Lovable-AIG-SDK": "vercel-ai-sdk" },
    fetch: createRunIdFetch(),
  });
  try {
    const result = streamText({
      model: provider.responses("openai/gpt-6-astra"),
      system: SYSTEM,
      prompt: `CHAPTER TEXT:\n${chapterText}\n\nHER REFLECTION:\n${reflection}`,
      maxRetries: 0,
      providerOptions: {
        openai: {
          forceReasoning: true,
          reasoningEffort: "low",
          reasoningSummary: "auto",
          store: false,
          include: ["reasoning.encrypted_content"],
        },
      },
    });
    const text = await result.text;
    const questions = text
      .split("\n")
      .map((l) => l.replace(/^[\s\-*\d.)]+/, "").trim())
      .filter(Boolean)
      .slice(0, 4);
    if (!questions.length) return { ok: false, message: "No questions came back this time. Please try again later." };
    return { ok: true, questions };
  } catch (error) {
    const status = APICallError.isInstance(error) ? error.statusCode : undefined;
    if (status === 429) return { ok: false, message: "Many readers are asking right now. Please try again in a minute." };
    if (status === 402 || status === 403) return { ok: false, message: "Guided questions are paused for now. Please try again later." };
    console.error("follow-up generation failed", error);
    return { ok: false, message: "Something went wrong while preparing questions. Please try again." };
  }
}
