import prisma from "@/lib/prisma";

export async function getMixPremium(): Promise<string> {
  const data = await prisma.$queryRaw<
    { max_premium: string }[]
  >`
  SELECT
    MAX(proposed_premium) AS max_premium
    FROM quotation q
    WHERE q.quotation_status = 'Pending';
  `;
  if (data.length > 0) return data[0].max_premium;
  else return "0";
}