import { adminRoutes } from "./protected/admin";
import { clientRoutes } from "./protected/client";

const protectedRoutes = [...adminRoutes, ...clientRoutes];

export { protectedRoutes };
