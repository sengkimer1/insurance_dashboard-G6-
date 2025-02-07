import prisma from "@/lib/prisma";

export async function getCompany(): Promise<string> {
  const data = await prisma.$queryRaw<
    { approved_quotation_company: string }[]
  >`
 
	SELECT
COUNT(company_id) AS approved_quotation_company
FROM quotation q
WHERE q.quotation_status = 'Approved';

  `;
  if (data.length > 0) return data[0].approved_quotation_company;
  else return "0";
}