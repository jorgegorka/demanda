<script>
  import Loading from "../../../../components/loading.svelte";
  import CommentResults from "./results.svelte";
  import { CommentModel } from "../../../../../lib/models/comment";

  const listParams = {};

  const commentsList = CommentModel().find(listParams);

  function deleteComment(event) {
    CommentModel()
      .remove(event.detail)
      .then(function (result) {
        if (result.errors.length === 0) {
          commentsList.refetch();
        }
      });
  }
</script>

{#await $commentsList}
  <Loading />
{:then result}
  <CommentResults comments={result.data.comments} on:deleteComment={deleteComment} />
{:catch error}
  Error: {error}
{/await}
