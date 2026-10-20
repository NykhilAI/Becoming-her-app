import { createServerFn } from "@tanstack/react-start";
import { z } from "zod";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { generateFollowUps } from "./follow-up.server";

export const getFollowUpQuestions = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data) => z.object({ chapterId: z.string().uuid(), reflection: z.string().trim().min(10).max(20000) }).parse(data))
  .handler(async ({ data, context }) => {
    const { data: chapter, error } = await context.supabase
      .from("chapters")
      .select("title,content_blocks(heading,body,position)")
      .eq("id", data.chapterId)
      .single();
    if (error || !chapter) return { ok: false as const, message: "This chapter could not be found." };
    const blocks = [...chapter.content_blocks].sort((a, b) => a.position - b.position);
    const text = `${chapter.title}\n\n${blocks.map((b) => `${b.heading ?? ""}\n${b.body}`).join("\n\n")}`;
    return generateFollowUps(text, data.reflection);
  });
