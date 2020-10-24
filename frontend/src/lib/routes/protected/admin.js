import DashboardIndex from "../../../views/protected/admin/dashboard/index.svelte";
import AdminLayout from "../../../views/protected/admin/layout/index.svelte";
import CategoriesIndex from "../../../views/protected/admin/categories/index.svelte";
import CategoriesNew from "../../../views/protected/admin/categories/new/index.svelte";
import CategoriesShow from "../../../views/protected/admin/categories/show/index.svelte";
import CategoriesEdit from "../../../views/protected/admin/categories/edit/index.svelte";
import LanguagesIndex from "../../../views/protected/admin/languages/index.svelte";
import LanguagesNew from "../../../views/protected/admin/languages/new/index.svelte";
import LanguagesShow from "../../../views/protected/admin/languages/show/index.svelte";
import LanguagesEdit from "../../../views/protected/admin/languages/edit/index.svelte";
import TaxesIndex from "../../../views/protected/admin/taxes/index.svelte";
import TaxesNew from "../../../views/protected/admin/taxes/new/index.svelte";
import TaxesShow from "../../../views/protected/admin/taxes/show/index.svelte";
import TaxesEdit from "../../../views/protected/admin/taxes/edit/index.svelte";
import DiscountsIndex from "../../../views/protected/admin/discounts/index.svelte";
import DiscountsNew from "../../../views/protected/admin/discounts/new/index.svelte";
import DiscountsShow from "../../../views/protected/admin/discounts/show/index.svelte";
import DiscountsEdit from "../../../views/protected/admin/discounts/edit/index.svelte";
import ProductsIndex from "../../../views/protected/admin/products/index.svelte";
import ProductsNew from "../../../views/protected/admin/products/new/index.svelte";
import ProductsShow from "../../../views/protected/admin/products/show/index.svelte";
import ProductsEdit from "../../../views/protected/admin/products/edit/index.svelte";
import TranslationsNew from "../../../views/protected/admin/translations/new/index.svelte";
import TranslationsEdit from "../../../views/protected/admin/discounts/edit/index.svelte";
import MediaNew from "../../../views/protected/admin/media/new/index.svelte";
import CommentsIndex from "../../../views/protected/admin/comments/index.svelte";

const adminRoutes = [
  {
    name: "/admin",
    layout: AdminLayout,
    nestedRoutes: [
      { name: "index", redirectTo: "admin/dashboard" },
      {
        name: "dashboard",
        component: DashboardIndex,
      },
      {
        name: "categories",
        nestedRoutes: [
          { name: "index", component: CategoriesIndex },
          { name: "new/:parentId", component: CategoriesNew },
          { name: "show/:id", component: CategoriesShow },
          { name: "edit/:id", component: CategoriesEdit },
        ],
      },
      {
        name: "languages",
        nestedRoutes: [
          { name: "index", component: LanguagesIndex },
          { name: "new/:parentId", component: LanguagesNew },
          { name: "show/:id", component: LanguagesShow },
          { name: "edit/:id", component: LanguagesEdit },
        ],
      },
      {
        name: "taxes",
        nestedRoutes: [
          { name: "index", component: TaxesIndex },
          { name: "new", component: TaxesNew },
          { name: "show/:id", component: TaxesShow },
          { name: "edit/:id", component: TaxesEdit },
        ],
      },
      {
        name: "discounts",
        nestedRoutes: [
          { name: "index", component: DiscountsIndex },
          { name: "new", component: DiscountsNew },
          { name: "show/:id", component: DiscountsShow },
          { name: "edit/:id", component: DiscountsEdit },
        ],
      },
      {
        name: "products",
        nestedRoutes: [
          { name: "index", component: ProductsIndex },
          { name: "new", component: ProductsNew },
          { name: "show/:id", component: ProductsShow },
          { name: "edit/:id", component: ProductsEdit },
        ],
      },
      {
        name: "comments",
        nestedRoutes: [{ name: "index", component: CommentsIndex }],
      },
      {
        name: "translations",
        nestedRoutes: [
          { name: "new/:parentId", component: TranslationsNew },
          { name: "edit/:id", component: TranslationsEdit },
        ],
      },
      {
        name: "media",
        nestedRoutes: [{ name: "new/:parentId", component: MediaNew }],
      },
    ],
  },
];

export { adminRoutes };
