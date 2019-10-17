import { Request } from "../../../../../lib/queries/request";
import { addCategory } from "../../../../../lib/queries/categories";

function submitForm(graphqlClient, formFields) {
  const categoryInfo = {
    name: formFields.name.value,
    parentId: formFields.parentId.value
  };
  Request.mutation(
    graphqlClient,
    "createCategory",
    {
      mutation: addCategory,
      variables: { categoryInfo }
    },
    { success: "Category created successfully" }
  );
}

export { submitForm };
