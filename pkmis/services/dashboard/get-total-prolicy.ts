import prisma from "@/lib/prisma";

export async function getTotalPolicy(): Promise<string> {
  const data = await prisma.$queryRaw<
    { count: string }[]
  >`select count(id) from insurance_policy`;
  if (data.length > 0) return data[0].count;
  else return "0";
}

export async function getTotalPremium(): Promise<string> {
    const data = await prisma.$queryRaw<{ sum_premium_policy: string | null }[]>`
    select sum(premium_amount) as sum_premium_policy
    from insurance_policy_premium;  
  `;

  if (data.length > 0) {
    return data[0].sum_premium_policy ? data[0].sum_premium_policy : "0";
  } else {
    return "0";
  }
}