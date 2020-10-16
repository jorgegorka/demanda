import { navigateTo } from "svelte-router-spa";
import { client as graphqlClient } from "../config/apollo";

import { UserSession } from "../session";
import { createSession, newSession } from "../queries/session";
import { Request } from "../queries/request";
import { SessionToken } from "../session/token";

function Session() {
  function add(loginInfo) {
    Request.mutation(
      graphqlClient,
      "login",
      {
        mutation: newSession,
        variables: { loginInfo },
      },
      { success: "Welcome back!" }
    ).then(function (loginData) {
      SessionToken.create(loginData.token);
      UserSession.get();
      const userInfo = SessionToken.extractPayload();
      if (userInfo.role === "admin") {
        navigateTo("/admin");
      } else {
        navigateTo("/user");
      }
    });
  }

  function create(signupInfo) {
    return Request.mutation(
      graphqlClient,
      "signup",
      {
        mutation: createSession,
        variables: { signupInfo },
      },
      { success: "Your account was created successfully. Welcome to Demanda." }
    );
  }

  return Object.freeze({
    add,
    create,
  });
}

export { Session };
