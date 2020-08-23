import PublicIndex from "../../views/public/home/index.svelte";
import PublicLayout from "../../views/public/layout/index.svelte";
import UserActionsLayout from "../../views/public/layout/user_actions.svelte";
import Login from "../../views/public/login/index.svelte";
import Signup from "../../views/public/signup/index.svelte";
import NotFound from "../../views/public/not_found/index.svelte";

const publicRoutes = [
  {
    name: "/",
    component: PublicIndex,
    layout: PublicLayout,
  },
  { name: "login", component: Login, layout: UserActionsLayout },
  { name: "signup", component: Signup, layout: UserActionsLayout },
  { name: "404", component: NotFound },
];

export { publicRoutes };
