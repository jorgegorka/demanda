import { adminRoutes } from "./protected/admin";
// import { clientRoutes } from "./protected/client";
const clientRoutes = [];

const protectedRoutes = [...adminRoutes, ...clientRoutes];

export { protectedRoutes };
