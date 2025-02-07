import prisma from "@/lib/prisma";

export async function getTotalAvgPremium(): Promise<string> {
    const data = await prisma.$queryRaw<
        { average_premium: string }[]
    >`
    SELECT
    AVG(proposed_premium) AS average_premium
    FROM quotation  `;
    if (data.length > 0) return data[0].average_premium;
    else return "0";
}
