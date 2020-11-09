import { SessionToken } from "./token";
import { currentUser } from "../stores/current_user";
import { User } from "../models/user";

function userSession() {
  function get() {
    const userInfo = SessionToken.extractPayload();
    if (userInfo.user_id) {
      currentUser.set({
        userId: userInfo.user_id,
        accountId: userInfo.account_id,
        role: userInfo.role,
        name: userInfo.name,
      });
      User()
        .findOne(userInfo.user_id)
        .subscribe(function (result) {
          result.then(function (response) {
            const user = response.data.users[0];
            currentUser.set({
              userId: userInfo.user_id,
              accountId: userInfo.account_id,
              role: userInfo.role,
              name: user.name,
              phone: user.phone,
              email: user.email,
            });
          });
        });

      return true;
    } else {
      currentUser.set({ userId: "0" });

      return false;
    }
  }

  function remove() {
    currentUser.set({ userId: "-" });
    SessionToken.remove();
  }

  return Object.freeze({
    get,
    remove,
  });
}

const UserSession = userSession();

export { UserSession };
