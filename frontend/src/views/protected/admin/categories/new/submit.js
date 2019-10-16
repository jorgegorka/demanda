import { mutate } from "svelte-apollo";

import { notificationMessage } from "../../../../../lib/stores/notification_message";
import { addCategory } from "../../../../../lib/queries/categories";

async function submitForm(graphqlClient, formFields) {
  const categoryInfo = {
    name: formFields.name.value,
    parentId: formFields.parentId.value
  };
  const response = await mutate(graphqlClient, {
    mutation: addCategory,
    variables: { categoryInfo }
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
  }
}

export { submitForm };
