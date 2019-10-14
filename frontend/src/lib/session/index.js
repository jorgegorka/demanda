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

  return Object.freeze({
    get
  });
}

const UserSession = userSession();

export { UserSession };
