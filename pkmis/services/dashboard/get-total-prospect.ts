import prisma from "@/lib/prisma";

export async function getTotalProspect(): Promise<string> {
  const data = await prisma.$queryRaw<
    { total_prospect: string }[]
  >`
   SELECT 
     COUNT(e.id) - COUNT(ic.id) AS total_prospect
     FROM employee e
    LEFT JOIN insured_coverage ic ON e.id = ic.employee_id
  `;
  if (data.length > 0) return data[0].total_prospect;
  else return "0";
}

export async function getTotalCompany(): Promise<string> {
    const data = await prisma.$queryRaw<
      { count: string }[]
    >`SELECT count(id) from quotation 
    where quotation_status = 'Pending'
    `;
    if (data.length > 0) return data[0].count;
    else return "0";
  }

