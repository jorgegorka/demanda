import { navigateTo } from "svelte-router-spa";
import { mutate } from "svelte-apollo";

import { notificationMessage } from "../../../../lib/stores/notification_message";
import { newSession } from "../../../../lib/queries/session";
import { SessionToken } from "../../../../lib/session/token";

async function submitForm(graphqlClient, formFields) {
  const loginInfo = {
    email: formFields.email.value,
    password: formFields.password.value
  };
  const response = await mutate(graphqlClient, {
    mutation: newSession,
    variables: { loginInfo }
  });
  const loginData = response.data.login;
  if (loginData.errors.length > 0) {
    notificationMessage.add({
      message: loginData.errors[0],
      type: "danger-msg"
    });
  } else {
    notificationMessage.add({
      message: "Welcome back!",
      type: "success-msg"
    });
    SessionToken.create(loginData.token);
    navigateTo("admin");
  }
}

export { submitForm };
