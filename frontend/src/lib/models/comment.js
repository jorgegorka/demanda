import { ValidationModel } from "./validation";
import { Comments } from "../database/comments";

function CommentModel(comment = {}) {
  const constraints = {};

  const validation = ValidationModel(comment, constraints);
  const fields = validation.fields();

  function edit(commentId) {
    return Comments.edit({
      ...validValues(),
      id: commentId,
    });
  }

  function find(params) {
    return Comments.find(params);
  }

  function findOne(commentId) {
    return Comments.findOne(commentId);
  }

  function remove(commentId) {
    return Comments.remove(commentId);
  }

  function valid() {
    return validation.valid(fields);
  }

  function validValues() {
    return validation.validValues(fields);
  }

  return Object.freeze({
    edit,
    fields,
    find,
    findOne,
    remove,
    valid,
    validValues,
  });
}

export { CommentModel };
