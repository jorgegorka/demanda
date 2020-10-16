import ClientLayout from "../../../views/protected/client/layout/index.svelte";
import DashboardIndex from "../../../views/protected/client/dashboard/index.svelte";

const clientRoutes = [
  {
    name: "/user",
    layout: ClientLayout,
    nestedRoutes: [
      { name: "index", redirectTo: "user/dashboard" },
      {
        name: "dashboard",
        component: DashboardIndex,
      },
    ],
  },
];

export { clientRoutes };
