import { ValidationModel } from "./validation";
import { Attachments } from "../database/attachments";

function AttachmentModel(attachment = {}) {
  const constraints = {
    title: {
      presence: true,
      type: "string",
      length: {
        minimum: 1,
        message: "Please enter a title.",
      },
    },
    languageId: {
      presence: false,
      type: "string",
    },
    parentType: {
      presence: true,
      type: "string",
    },
    parentId: {
      presence: true,
      type: "string",
    },
  };

  const validation = ValidationModel(attachment, constraints);
  const fields = validation.fields();

  function add() {
    const bodyParams = new FormData();
    bodyParams.append("title", fields.title.value);
    bodyParams.append("language_id", fields.languageId.value);
    bodyParams.append("parent_id", fields.parentId.value);
    bodyParams.append("parent_type", fields.parentType.value);
    bodyParams.append("files", fields.files[0]);

    return Attachments.add(bodyParams);
  }

  function remove(attachmentId) {
    return Attachments.remove(attachmentId);
  }

  function valid() {
    return validation.valid(fields);
  }

  function validValues() {
    return validation.validValues(fields);
  }

  return Object.freeze({
    add,
    fields,
    remove,
    valid,
    validValues,
  });
}

export { AttachmentModel };
