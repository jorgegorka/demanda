import DashboardIndex from "../../../views/protected/admin/dashboard/index.svelte";
import AdminLayout from "../../../views/protected/admin/layout/index.svelte";
import CategoriesIndex from "../../../views/protected/admin/categories/index.svelte";
import CategoriesNew from "../../../views/protected/admin/categories/new/index.svelte";
import CategoriesShow from "../../../views/protected/admin/categories/show/index.svelte";
import CategoriesEdit from "../../../views/protected/admin/categories/edit/index.svelte";
import TaxesIndex from "../../../views/protected/admin/taxes/index.svelte";
import TaxesNew from "../../../views/protected/admin/taxes/new/index.svelte";
import TaxesShow from "../../../views/protected/admin/taxes/show/index.svelte";
import TaxesEdit from "../../../views/protected/admin/taxes/edit/index.svelte";

const adminRoutes = [
  {
    name: "/admin",
    layout: AdminLayout,
    nestedRoutes: [
      { name: "index", redirectTo: "admin/dashboard" },
      { name: "dashboard", component: DashboardIndex },
      {
        name: "categories",
        nestedRoutes: [
          { name: "index", component: CategoriesIndex },
          { name: "new/:parentId", component: CategoriesNew },
          { name: "show/:id", component: CategoriesShow },
          { name: "edit/:id", component: CategoriesEdit }
        ]
      },
      {
        name: "taxes",
        nestedRoutes: [
          { name: "index", component: TaxesIndex },
          { name: "new", component: TaxesNew },
          { name: "show/:id", component: TaxesShow },
          { name: "edit/:id", component: TaxesEdit }
        ]
      }
    ]
  }
];

export { adminRoutes };
