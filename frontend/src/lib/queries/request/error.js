import { navigateTo } from "svelte-router-spa";

import { notificationMessage } from "../../stores/notification_message";
import { UserSession } from "../../session";

function requestError() {
  function process(error) {
    if (error.message.includes("Invalid user")) {
      logout();
    } else {
      notify(error.message);
    }
  }

  function notify(message) {
    notificationMessage.add({
      message,
      type: "danger-msg"
    });
  }

  function logout() {
    UserSession.remove();
    notify("Invalid credentials. Please log in again.");
    navigateTo("login");
  }

  return Object.freeze({
    process
  });
}

const RequestError = requestError();

export { RequestError };
