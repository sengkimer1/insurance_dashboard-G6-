import prisma from "@/lib/prisma";

export async function getTotalQuotation(): Promise<string> {
  const data = await prisma.$queryRaw<
    { count: string }[]
  >`
  select count(id) from quotation`;
  if (data.length > 0) return data[0].count;
  else return "0";
}
// SELECT
// COUNT(*) AS total_quotation,
// AVG(proposed_premium) AS average_premium
// FROM quotation;