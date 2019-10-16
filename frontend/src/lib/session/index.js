import { SessionToken } from "./token";
import { currentUser } from "../stores/current_user";

function userSession() {
  function get() {
    const userInfo = SessionToken.extractPayload();
    if (userInfo.user_id && userInfo.role && userInfo.account_id) {
      currentUser.set({
        userId: userInfo.user_id,
        role: userInfo.role,
        accountId: userInfo.account_id
      });
      return true;
    } else {
      currentUser.set({ userId: "0" });
      return false;
    }
  }

  function remove() {
    SessionToken.remove();
    currentUser.set({});
  }

  return Object.freeze({
    get,
    remove
  });
}

const UserSession = userSession();

export { UserSession };
