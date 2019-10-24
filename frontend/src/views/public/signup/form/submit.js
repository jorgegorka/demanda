import { navigateTo } from "svelte-router-spa";
import { mutate } from "svelte-apollo";

import { notificationMessage } from "../../../../lib/stores/notification_message";
import { createSession } from "../../../../lib/queries/session";
import { SessionToken } from "../../../../lib/session/token";

async function submitForm(graphqlClient, formFields) {
  const signupInfo = {
    email: formFields.email.value,
    password: formFields.password.value,
    accountName: formFields.name.value
  };

  const response = await mutate(graphqlClient, {
    mutation: createSession,
    variables: { signupInfo }
  });
  const signupData = response.data.signup;
  if (signupData.errors.length > 0) {
    notificationMessage.add({
      message: signupData.errors[0],
      type: "danger-msg"
    });
  } else {
    notificationMessage.add({
      message: "Your account was created successfully",
      type: "success-msg"
    });
    SessionToken.create(signupData.token);
    navigateTo("admin");
  }
}

export { submitForm };
