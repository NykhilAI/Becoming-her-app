import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import {
  Outlet,
  Link,
  createRootRouteWithContext,
  useRouter,
  HeadContent,
  Scripts,
} from "@tanstack/react-router";
import { useEffect, type ReactNode } from "react";

import appCss from "../styles.css?url";
import { reportLovableError } from "../lib/lovable-error-reporting";
import { applyTheme, isTheme, storedTheme } from "../lib/theme";
import { supabase } from "../integrations/supabase/client";
import { useScrollReveal } from "../hooks/use-scroll-reveal";

function NotFoundComponent() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-background px-4">
      <div className="max-w-md text-center">
        <h1 className="text-7xl font-bold text-foreground">404</h1>
        <h2 className="mt-4 text-xl font-semibold text-foreground">Page not found</h2>
        <p className="mt-2 text-sm text-muted-foreground">
          The page you're looking for doesn't exist or has been moved.
        </p>
        <div className="mt-6">
          <Link
            to="/"
            className="inline-flex items-center justify-center rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground transition-colors hover:bg-primary/90"
          >
            Go home
          </Link>
        </div>
      </div>
    </div>
  );
}

function ErrorComponent({ error, reset }: import("@tanstack/react-router").ErrorComponentProps) {
  console.error(error);
  const router = useRouter();
  useEffect(() => {
    reportLovableError(error, { boundary: "tanstack_root_error_component" });
  }, [error]);

  return (
    <div className="flex min-h-screen items-center justify-center bg-background px-4">
      <div className="max-w-md text-center">
        <h1 className="text-xl font-semibold tracking-tight text-foreground">
          This page didn't load
        </h1>
        <p className="mt-2 text-sm text-muted-foreground">
          Something went wrong on our end. You can try refreshing or head back home.
        </p>
        <div className="mt-6 flex flex-wrap justify-center gap-2">
          <button
            onClick={() => {
              router.invalidate();
              reset();
            }}
            className="inline-flex items-center justify-center rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground transition-colors hover:bg-primary/90"
          >
            Try again
          </button>
          <a
            href="/"
            className="inline-flex items-center justify-center rounded-md border border-input bg-background px-4 py-2 text-sm font-medium text-foreground transition-colors hover:bg-accent"
          >
            Go home
          </a>
        </div>
      </div>
    </div>
  );
}

export const Route = createRootRouteWithContext<{ queryClient: QueryClient }>()({
  head: () => ({
    meta: [
      { charSet: "utf-8" },
      { name: "viewport", content: "width=device-width, initial-scale=1" },
      { title: "Becoming Her — Biblical Journal" },
      { name: "description", content: "A private biblical journey for the woman preparing for marriage." },
      { name: "author", content: "Nikhil Jaykar" },
      { property: "og:title", content: "Becoming Her — Biblical Journal" },
      { property: "og:description", content: "A private biblical journey for the woman preparing for marriage." },
      { property: "og:type", content: "website" },
      { name: "twitter:card", content: "summary_large_image" },
      { name: "twitter:site", content: "@Lovable" },
    ],
    links: [
      {
        rel: "stylesheet",
        href: appCss,
      },
      { rel: "preconnect", href: "https://fonts.googleapis.com" },
      { rel: "preconnect", href: "https://fonts.gstatic.com", crossOrigin: "anonymous" },
      { rel: "stylesheet", href: "https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,500;0,600;1,500&family=Source+Sans+3:wght@400;500;600&display=swap" },
      { rel: "icon", href: "/favicon.ico", type: "image/x-icon" },
    ],
  }),
  shellComponent: RootShell,
  component: RootComponent,
  notFoundComponent: NotFoundComponent,
  errorComponent: ErrorComponent,
});

function RootShell({ children }: { children: ReactNode }) {
  return (
    <html lang="en">
      <head>
        <HeadContent />
      </head>
      <body>
        {children}
        <Scripts />
      </body>
    </html>
  );
}

function RootComponent() {
  useScrollReveal();
  const { queryClient } = Route.useRouteContext();

  useEffect(() => {
    // After an update, an already-open tab may request code files that no longer exist.
    // Reload once to pick up the new version instead of showing a blank screen.
    const isStaleChunk = (msg: string) => /Importing a module script failed|Failed to fetch dynamically imported module|error loading dynamically imported module/i.test(msg);
    const recover = () => {
      try {
        if (sessionStorage.getItem("bh-chunk-reload")) return;
        sessionStorage.setItem("bh-chunk-reload", "1");
      } catch { /* ignore */ }
      window.location.reload();
    };
    const onPreload = (e: Event) => { e.preventDefault(); recover(); };
    const onRejection = (e: PromiseRejectionEvent) => { if (isStaleChunk(String(e.reason?.message ?? e.reason))) recover(); };
    const onError = (e: ErrorEvent) => { if (isStaleChunk(e.message ?? "")) recover(); };
    window.addEventListener("vite:preloadError", onPreload);
    window.addEventListener("unhandledrejection", onRejection);
    window.addEventListener("error", onError);
    const clear = window.setTimeout(() => { try { sessionStorage.removeItem("bh-chunk-reload"); } catch { /* ignore */ } }, 10000);
    applyTheme(storedTheme());
    const applyReading = (scale: number, leading: number) => {
      document.documentElement.style.setProperty("--reading-scale", String(scale));
      document.documentElement.style.setProperty("--reading-leading", String(leading));
      try { localStorage.setItem("bh-reading-prefs", JSON.stringify({ scale, leading })); } catch { /* ignore */ }
    };
    try {
      const saved = JSON.parse(localStorage.getItem("bh-reading-prefs") ?? "{}");
      if (typeof saved.scale === "number" && typeof saved.leading === "number") applyReading(saved.scale, saved.leading);
    } catch { /* ignore */ }
    const sync = async () => {
      const { data } = await supabase.auth.getSession();
      const id = data.session?.user.id;
      if (!id) return;
      const { data: row } = await supabase.from("profiles").select("theme, reading_scale, reading_leading").eq("id", id).maybeSingle();
      if (row && isTheme(row.theme)) applyTheme(row.theme);
      if (row) applyReading(row.reading_scale, row.reading_leading);
    };
    void sync();
    const { data: sub } = supabase.auth.onAuthStateChange((event) => {
      if (event === "SIGNED_IN") void sync();
    });
    return () => {
      sub.subscription.unsubscribe();
      window.clearTimeout(clear);
      window.removeEventListener("vite:preloadError", onPreload);
      window.removeEventListener("unhandledrejection", onRejection);
      window.removeEventListener("error", onError);
    };
  }, []);

  return (
    <QueryClientProvider client={queryClient}>
      {/* Required: nested routes render here. Removing <Outlet /> breaks all child routes. */}
      <Outlet />
    </QueryClientProvider>
  );
}
