import { useEffect, useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { CalendarPlus } from "lucide-react";
import { supabase } from "@/integrations/supabase/client";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Switch } from "@/components/ui/switch";

const DAYS = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
const ICS_DAYS = ["SU", "MO", "TU", "WE", "TH", "FR", "SA"];

export function ReminderSettings({ userId }: { userId: string }) {
  const { data } = useQuery({
    queryKey: ["reminders", userId],
    queryFn: async () => (await supabase.from("reminder_preferences").select("*").eq("user_id", userId).maybeSingle()).data,
  });
  const [days, setDays] = useState<number[]>([1, 3, 5]);
  const [time, setTime] = useState("07:00");
  const [email, setEmail] = useState(false);
  const [status, setStatus] = useState("");

  useEffect(() => {
    if (data) { setDays(data.days); setTime(data.reminder_time.slice(0, 5)); setEmail(data.email_enabled); }
  }, [data]);

  const toggle = (d: number) => setDays((c) => (c.includes(d) ? c.filter((x) => x !== d) : [...c, d].sort()));

  async function save() {
    if (!days.length) return setStatus("Choose at least one day.");
    const { error } = await supabase.from("reminder_preferences").upsert({
      user_id: userId, days, reminder_time: time, email_enabled: email,
      timezone: Intl.DateTimeFormat().resolvedOptions().timeZone,
    });
    setStatus(error ? "Could not save. Please try again." : "Reminder saved");
  }

  function addToCalendar() {
    if (!days.length) return setStatus("Choose at least one day.");
    const [h, m] = time.split(":");
    const now = new Date();
    const start = `${now.getFullYear()}${String(now.getMonth() + 1).padStart(2, "0")}${String(now.getDate()).padStart(2, "0")}T${h}${m}00`;
    const url = `${window.location.origin}/dashboard`;
    const ics = [
      "BEGIN:VCALENDAR", "VERSION:2.0", "PRODID:-//Becoming Her//Journal//EN", "BEGIN:VEVENT",
      `UID:becoming-her-${userId}@journal`, `DTSTAMP:${now.toISOString().replace(/[-:]/g, "").split(".")[0]}Z`,
      `DTSTART:${start}`, "DURATION:PT20M",
      `RRULE:FREQ=WEEKLY;BYDAY=${days.map((d) => ICS_DAYS[d]).join(",")}`,
      "SUMMARY:Quiet time with your journal", `DESCRIPTION:Return when you are ready. ${url}`, `URL:${url}`,
      "BEGIN:VALARM", "TRIGGER:PT0M", "ACTION:DISPLAY", "DESCRIPTION:Quiet time with your journal", "END:VALARM",
      "END:VEVENT", "END:VCALENDAR",
    ].join("\r\n");
    const a = document.createElement("a");
    a.href = URL.createObjectURL(new Blob([ics], { type: "text/calendar" }));
    a.download = "becoming-her-reminder.ics";
    a.click();
    URL.revokeObjectURL(a.href);
  }

  return (
    <section className="mt-14 border-t border-border pt-10">
      <p className="eyebrow">Gentle reminders</p>
      <h2 className="mt-3 font-display text-3xl">A quiet invitation to return</h2>
      <p className="mt-3 text-sm leading-6 text-muted-foreground">Optional. Reminders never mention what you have written.</p>
      <div className="mt-6 grid grid-cols-7 gap-1.5" role="group" aria-label="Reminder days">
        {DAYS.map((d, i) => (
          <button key={d} type="button" onClick={() => toggle(i)} aria-pressed={days.includes(i)}
            className={`min-h-11 rounded-sm border text-xs ${days.includes(i) ? "border-primary bg-primary text-primary-foreground" : "border-border bg-card text-muted-foreground"}`}>{d}</button>
        ))}
      </div>
      <label className="mt-5 block text-sm">Time<Input type="time" className="mt-2 h-12 bg-card" value={time} onChange={(e) => setTime(e.target.value)} /></label>
      <label className="mt-5 flex items-center justify-between gap-4 border-y border-border py-4 text-sm">
        <span>Email me a reminder<span className="mt-1 block text-xs text-muted-foreground">Emails begin once sending is switched on.</span></span>
        <Switch checked={email} onCheckedChange={setEmail} />
      </label>
      <div className="mt-6 grid gap-3 sm:grid-cols-2">
        <Button type="button" size="lg" variant="journal" onClick={save}>Save reminder</Button>
        <Button type="button" size="lg" variant="outline" onClick={addToCalendar}><CalendarPlus /> Add to my calendar</Button>
      </div>
      {status && <p className="mt-3 text-center text-sm text-primary" role="status">{status}</p>}
    </section>
  );
}
