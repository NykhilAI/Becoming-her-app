import { Link, useNavigate } from "@tanstack/react-router";
import { BookOpenText, CircleUserRound, Feather, House, LogOut } from "lucide-react";
import { useQueryClient } from "@tanstack/react-query";
import { supabase } from "@/integrations/supabase/client";
import { Brand } from "@/components/brand";
import { Button } from "@/components/ui/button";

const nav = [
  { to: "/dashboard", label: "Home", icon: House },
  { to: "/journey", label: "Journey", icon: BookOpenText },
  { to: "/journal", label: "Journal", icon: Feather },
  { to: "/profile", label: "Profile", icon: CircleUserRound },
] as const;

export function AppShell({ children }: { children: React.ReactNode }) {
  const navigate = useNavigate();
  const queryClient = useQueryClient();

  async function signOut() {
    await queryClient.cancelQueries();
    queryClient.clear();
    await supabase.auth.signOut();
    navigate({ to: "/auth", replace: true });
  }

  return (
    <div className="min-h-screen bg-background pb-24 md:pb-10">
      <header className="glass sticky top-0 z-30 !border-x-0 !border-t-0 !shadow-none">
        <div className="mx-auto grid max-w-5xl grid-cols-[minmax(0,1fr)_auto] items-center px-5 py-4">
          <Brand compact />
          <Button variant="ghost" size="icon" onClick={signOut} aria-label="Sign out" title="Sign out"><LogOut /></Button>
        </div>
      </header>
      <main className="mx-auto w-full max-w-5xl px-5 py-8 md:py-12">{children}</main>
      <nav className="glass fixed inset-x-4 bottom-[max(0.75rem,env(safe-area-inset-bottom))] z-30 mx-auto max-w-md rounded-full md:static md:mt-8 md:max-w-xl">
        <div className="grid grid-cols-4">
          {nav.map(({ to, label, icon: Icon }) => (
            <Link key={to} to={to} className="m-1 flex min-h-14 flex-col items-center justify-center gap-0.5 rounded-full text-[11px] text-muted-foreground transition-all active:scale-95" activeProps={{ className: "bg-primary/10 text-primary" }}>
              <Icon className="size-5" strokeWidth={1.5} /><span>{label}</span>
            </Link>
          ))}
        </div>
      </nav>
    </div>
  );
}