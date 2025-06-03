import { NextResponse, NextRequest } from "next/server";
import { prisma } from "@/lib/prisma";

interface PostRequest {
  page?: number;
  ITEMS_PER_PAGE?: number;
}

export async function POST(request: NextRequest) {
  try {
    const body: PostRequest = await request.json();
    const page = Math.max(1, body.page || 1);
    const ITEMS_PER_PAGE = body.ITEMS_PER_PAGE || 10;

    const [applications, totalCount, servers_all] = await Promise.all([
      prisma.application.findMany({
        skip: (page - 1) * ITEMS_PER_PAGE,
        take: ITEMS_PER_PAGE,
        orderBy: { name: "asc" },
        select: {
          id: true,
          name: true,
          description: true,
          icon: true,
          publicURL: true,
          localURL: true,
          serverId: true,
          online: true,
          uptimecheckUrl: true,
          min_downtime_seconds: true, // NEW
        },
      }),
      prisma.application.count(),
      prisma.server.findMany()
    ]);

    const serverIds = applications
    .map((app: { serverId: number | null }) => app.serverId)
    .filter((id:any): id is number => id !== null);

    const servers = await prisma.server.findMany({
      where: { id: { in: serverIds } }
    });

    const applicationsWithServers = applications.map((app: any) => ({
        ...app,
        minDowntimeSeconds: app.min_downtime_seconds, // NEW
        server: servers.find((s: any) => s.id === app.serverId)?.name || "No server"
      }));

    const maxPage = Math.ceil(totalCount / ITEMS_PER_PAGE);

    return NextResponse.json({
      applications: applicationsWithServers,
      servers: servers_all,
      maxPage,
      totalItems: totalCount
    });
  } catch (error: unknown) {
    const message = error instanceof Error ? error.message : "Unknown error";
    return NextResponse.json({ error: message }, { status: 500 });
  }
}