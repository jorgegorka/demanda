function sessionToken() {
  function create(token) {
    localStorage.setItem("demanda-eshop", token);
  }

  function extractPayload() {
    const token = find();
    let payload = "";
    if (token) {
      payload = parseJwt(token);
    }

    return payload;
  }

  function find() {
    return localStorage.getItem("demanda-eshop");
  }

  function parseJwt(token) {
    if (!token || token === "invalid") {
      return false;
    }
    const base64Url = token.split(".")[1];
    const base64 = base64Url.replace(/-/g, "+").replace(/_/g, "/");
    const jsonPayload = decodeURIComponent(
      atob(base64)
        .split("")
        .map(function (c) {
          return "%" + ("00" + c.charCodeAt(0).toString(16)).slice(-2);
        })
        .join("")
    );

    return JSON.parse(jsonPayload);
  }

  function remove() {
    localStorage.removeItem("demanda-eshop");
  }

  return Object.freeze({
    create,
    extractPayload,
    find,
    remove,
  });
}

const SessionToken = sessionToken();

export { SessionToken };
