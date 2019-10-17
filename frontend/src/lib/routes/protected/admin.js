import DashboardIndex from "../../../views/protected/admin/dashboard/index.svelte";
import AdminLayout from "../../../views/protected/admin/layout/index.svelte";
import CategoriesIndex from "../../../views/protected/admin/categories/index.svelte";
import CategoriesShow from "../../../views/protected/admin/categories/show/index.svelte";
import CategoriesNew from "../../../views/protected/admin/categories/new/index.svelte";

const adminRoutes = [
  {
    name: "/admin",
    layout: AdminLayout,
    nestedRoutes: [
      { name: "index", component: DashboardIndex },
      {
        name: "categories",
        nestedRoutes: [
          { name: "index", component: CategoriesIndex },
          { name: "new/:parentId", component: CategoriesNew },
          { name: "show/:id", component: CategoriesShow }
        ]
      }
    ]
  }
];

export { adminRoutes };
