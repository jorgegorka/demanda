import { ValidationModel } from "./validation";
import { Comments } from "../database/comments";

function Comment(comment = {}) {
  const constraints = {};

  const validation = ValidationModel(comment, constraints);
  const fields = validation.fields();

  function approve(commentId) {
    const commentInfo = {
      id: commentId,
      approved: true,
    };
    return Comments.edit(commentInfo);
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
    approve,
    fields,
    find,
    findOne,
    remove,
    valid,
    validValues,
  });
}

export { Comment };
