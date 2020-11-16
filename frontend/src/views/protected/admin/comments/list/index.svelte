<script>
  import Loading from "../../../../components/loading.svelte";
  import CommentResults from "./results.svelte";
  import { Comment } from "../../../../../lib/models/comment";

  const listParams = {};

  const commentsList = Comment().find(listParams);

  function approveComment(event) {
    Comment()
      .approve(event.detail)
      .then(function (result) {
        if (result.errors.length === 0) {
          commentsList.refetch();
        }
      });
  }

  function deleteComment(event) {
    Comment()
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
  <CommentResults
    comments={result.data.comments}
    on:deleteComment={deleteComment}
    on:approveComment={approveComment} />
{:catch error}
  Error:
  {error}
{/await}
