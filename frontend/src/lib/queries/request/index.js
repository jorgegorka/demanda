import { mutate } from "svelte-apollo";

import { notificationMessage } from "../../stores/notification_message";
import { RequestError } from "./error";

function request() {
  async function mutation(graphqlClient, name, params, messages) {
    try {
      const response = await mutate(graphqlClient, params);
      const data = response.data[name];
      notify(data, messages);
      return data;
    } catch (error) {
      RequestError.process(error);
    }
  }

  function notify(data, messages) {
    if (data.errors.length > 0) {
      notificationMessage.add({
        message: messages.error ? messages.error : data.errors[0],
        type: "danger-msg",
      });
    } else {
      notificationMessage.add({
        message: messages.success,
        type: "success-msg",
      });
    }
  }

  return Object.freeze({
    mutation,
  });
}

const Request = request();

export { Request };
