import { SessionToken } from "../session/token";

class Attachments {
  static add(attachmentInfo) {
    if (!attachmentInfo) {
      return false;
    }
    const token = SessionToken.find();
    const setup = {
      method: "POST",
      headers: {
        authorization: token ? `Bearer ${token}` : "",
      },
      mode: "cors",
      cache: "default",
      body: attachmentInfo,
    };

    return fetch("http://localhost:3000/attachments", setup);
  }

  static remove(attachmentId) {
    if (!attachmentId) {
      return false;
    }
    const token = SessionToken.find();
    const setup = {
      method: "DELETE",
      headers: {
        authorization: token ? `Bearer ${token}` : "",
      },
      mode: "cors",
      cache: "default",
    };

    return fetch(`http://localhost:3000/attachments/${attachmentId}`, setup);
  }
}

export { Attachments };
