import prisma from "@/lib/prisma";

export async function getAccepted(): Promise<string> {
  const data = await prisma.$queryRaw<
    { approved_quotation_company: string }[]
  >`
 
	SELECT
COUNT(quotation_status) AS approved_quotation_company
FROM quotation q
WHERE q.quotation_status = 'Accepted';
  `;
  if (data.length > 0) return data[0].approved_quotation_company;
  else return "0";
}