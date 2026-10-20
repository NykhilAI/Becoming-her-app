import botanical from "@/assets/botanical.png";

export function BotanicalMark({ className = "" }: { className?: string }) {
  return <img src={botanical} alt="" aria-hidden="true" width={1024} height={1408} className={className} />;
}