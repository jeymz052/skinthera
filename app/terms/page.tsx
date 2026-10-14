import type { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Terms & Conditions | Skinthera",
  description: "Terms and Conditions for Skinthera Medical Aesthetic in Tacurong City.",
};

const sections = [
  ["1. Acceptance of Terms", "By accessing and using Skinthera's services, booking platform, and patient portal, you agree to these Terms and Conditions."],
  ["2. Services", "Skinthera offers aesthetic and wellness services performed or supervised by licensed medical professionals."],
  ["3. Medical Disclaimer", "Results vary between individuals. A consultation is required before treatment, and Skinthera may decline a medically inappropriate service."],
  ["4. Booking & Appointments", "Bookings are confirmed upon receipt of any required deposit or confirmation. Skinthera may reschedule or cancel appointments with reasonable notice."],
  ["5. Payment Terms", "Payment is due at the time of service unless another arrangement has been made. Prices are in Philippine Peso and may change without prior notice."],
  ["6. Privacy & Confidentiality", "Patient information, medical records, and treatment history are confidential and handled under applicable Philippine data privacy laws."],
  ["7. Patient Responsibilities", "Patients must provide accurate medical information and follow the pre- and post-treatment instructions given by the Skinthera team."],
  ["8. Intellectual Property", "Website content, images, text, logos, and design belong to Skinthera and are protected by applicable copyright law."],
  ["9. Limitation of Liability", "Skinthera is not liable for indirect, incidental, or consequential damages. Liability is limited to the value of the treatment rendered."],
  ["10. Amendments", "Skinthera may update these Terms and Conditions. Continued use of our services constitutes acceptance of updated terms."],
  ["11. Governing Law", "These terms are governed by Philippine law. Disputes shall be resolved through the appropriate legal channels in Tacurong City, Sultan Kudarat."],
];

export default function TermsPage() {
  return <div className="policy-root"><div className="policy-container">
    {/* eslint-disable-next-line @next/next/no-img-element */}
    <img src="/images/skintheralogo-removebg-preview.png" alt="Skinthera Medical Aesthetic" className="policy-logo" />
    <h1 className="policy-title">Terms &amp; Conditions</h1><p className="policy-updated">Last updated: September 2026</p>
    <div className="policy-body">{sections.map(([title, body]) => <section className="policy-section" key={title}><h2>{title}</h2><p>{body}</p></section>)}
      <section className="policy-section"><h2>12. Contact</h2><p>For questions, contact Skinthera:</p><ul><li>Call or text: <strong>0969 487 2272</strong></li><li>Facebook: <strong>Skinthera Medical Aesthetic</strong></li><li>Jameela Building, Brgy. EJC, Tacurong City, Philippines 9800</li></ul></section>
    </div>
    <div className="policy-footer"><Link href="/auth" className="policy-back-btn">Back to Sign In</Link><Link href="/" className="policy-home-btn">Home</Link></div>
  </div></div>;
}
