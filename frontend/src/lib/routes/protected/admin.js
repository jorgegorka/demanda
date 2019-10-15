import DashboardIndex from "../../../views/protected/admin/dashboard/index.svelte";
import AdminLayout from "../../../views/protected/admin/layout/index.svelte";
import ListCategories from "../../../views/protected/admin/categories/list/index.svelte";

const adminRoutes = [
  {
    name: "/admin",
    layout: AdminLayout,
    nestedRoutes: [
      { name: "index", component: DashboardIndex },
      { name: "categories", component: ListCategories }
    ]
  }
];

export { adminRoutes };
