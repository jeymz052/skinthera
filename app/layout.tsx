import type { Metadata, Viewport } from "next";
import "./globals.css";

export const metadata: Metadata = {
  metadataBase: new URL(process.env.APP_URL || "http://localhost:3000"),
  icons: {
    icon: [{ url: "/images/skintherafavicon.png", type: "image/png" }],
    apple: [{ url: "/images/skintherafavicon.png", type: "image/png" }],
  },
  openGraph: {
    type: "website",
    siteName: "Skinthera Medical Aesthetic",
    title: "Skinthera Medical Aesthetic",
    description: "Aesthetic and regenerative medicine in Tacurong City.",
    url: "/",
    images: [{ url: "/images/skintherahero3.png", alt: "Skinthera Medical Aesthetic" }],
  },
  twitter: {
    card: "summary_large_image",
    title: "Skinthera Medical Aesthetic",
    description: "Aesthetic and regenerative medicine in Tacurong City.",
    images: ["/images/skintherahero3.png"],
  },
  title: "Skinthera | Aesthetic & Regenerative Medicine — Tacurong City",
  description: "Personalized aesthetic, regenerative, skin, laser, and weight-management care in Tacurong City. Book a consultation with Skinthera.",
};

export const viewport: Viewport = { width: "device-width", initialScale: 1, viewportFit: "cover" };

export default function RootLayout({ children }: LayoutProps<"/">) {
  return <html lang="en"><head><link rel="preconnect" href="https://fonts.googleapis.com"/><link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="anonymous"/><link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossOrigin="anonymous" referrerPolicy="no-referrer"/></head><body suppressHydrationWarning>{children}</body></html>;
}
