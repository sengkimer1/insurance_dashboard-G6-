import prisma from "@/lib/prisma";

export async function getTotalHFPartner(): Promise<string> {
  const data = await prisma.$queryRaw<
    { total_hf_partners: string }[]
  >`
    SELECT 
      COUNT(*) - COUNT(CASE WHEN is_partner_hf = FALSE THEN 1 END) AS total_hf_partners
    FROM health_facility;
  `;

  return data.length > 0 ? data[0].total_hf_partners : "0";
}

export async function getTotalNonPartner(): Promise<string> {
  const data = await prisma.$queryRaw<
    { total_non_partners: string }[]
  >`
    SELECT 
      COUNT(*) - COUNT(CASE WHEN is_partner_hf = TRUE THEN 1 END) AS total_non_partners
    FROM health_facility;
  `;

  return data.length > 0 ? data[0].total_non_partners : "0";
}
