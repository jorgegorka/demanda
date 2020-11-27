import ClientLayout from "../../../views/protected/client/layout/index.svelte";
import DashboardIndex from "../../../views/protected/client/dashboard/index.svelte";
import ProfileEdit from "../../../views/protected/client/profile/edit/index.svelte";
import OrdersIndex from "../../../views/protected/client/orders/index.svelte";
import CommentsIndex from "../../../views/protected/client/comments/index.svelte";
import AddressesIndex from "../../../views/protected/client/addresses/index.svelte";
import AddressesNew from "../../../views/protected/client/addresses/new/index.svelte";
import AddressesEdit from "../../../views/protected/client/addresses/edit/index.svelte";

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
      {
        name: "orders",
        nestedRoutes: [
          { name: "index", component: OrdersIndex },
          // { name: "show/:id", component: CategoriesShow },
          // { name: "edit/:id", component: CategoriesEdit },
        ],
      },
      {
        name: "comments",
        nestedRoutes: [
          { name: "index", component: CommentsIndex },
          // { name: "show/:id", component: CategoriesShow },
          // { name: "edit/:id", component: CategoriesEdit },
        ],
      },
      {
        name: "profile",
        component: ProfileEdit,
      },
      {
        name: "addresses",
        nestedRoutes: [
          { name: "index", component: AddressesIndex },
          { name: "new", component: AddressesNew },
          { name: "edit/:id", component: AddressesEdit },
        ],
      },
    ],
  },
];

export { clientRoutes };
