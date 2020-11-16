<script>
  import { createEventDispatcher } from "svelte";
  import { formatDate } from "../../../../../lib/utils/dates";

  import ApproveComment from "./approve.svelte";

  export let comment = {};

  const dispatch = createEventDispatcher();
</script>

<li
  class="block border-b border-gray-200 hover:bg-gray-50 focus:outline-none focus:bg-gray-50 transition duration-150 ease-in-out">
  <div class="px-4 py-4 sm:px-6">
    <div class="flex items-center justify-between">
      <p class="text-sm leading-5 font-medium text-indigo-600 truncate">
        {comment.forName}
        -
        {comment.forType}
      </p>
      <p class="ml-2 flex-shrink-0 flex justify-between items-center">
        <ApproveComment {comment} on:approveComment />
        <!-- <a class="ml-2" href={`/admin/comments/reply/${comment.id}`}>
          <svg
            viewBox="0 0 20 20"
            fill="currentColor"
            class="pencil w-6 h-6 text-blue-500">
            <path
              d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3
                14.172V17h2.828l8.38-8.379-2.83-2.828z" />
          </svg>
        </a> -->
        <a
          href="#!"
          class="ml-2"
          on:click={() => dispatch('removeComment', comment.id)}>
          <svg
            viewBox="0 0 20 20"
            fill="currentColor"
            class="trash w-6 h-6 text-red-500">
            <path
              fill-rule="evenodd"
              d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0
                100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1
                1 0 00-1-1z"
              clip-rule="evenodd" />
          </svg>
        </a>
      </p>
    </div>
    <div class="mt-2 sm:flex sm:justify-between">
      <div class="sm:flex">
        <p class="mr-6 flex items-center text-sm leading-5 text-gray-500">
          {formatDate(comment.createdAt, 'dd-MM-yyyy HH:mm')}
          -
          {comment.user.name}
          -
          {comment.user.email}
        </p>
      </div>
    </div>
    <p>{comment.description}</p>
  </div>
</li>
