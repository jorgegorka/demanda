<script>
  import AttachmentItem from "./item.svelte";

  export let attachments = [];
</script>

<table class="bg-white w-full rounded">
  <thead class="">
    <tr class="text-gray-700 bg-gray-100">
      <th class="p-4 text-left">Media</th>
      <th class=" text-left">Language</th>
      <th class=" text-left">URL</th>
      <th class=" text-left">Order</th>
      <th class="p-4 text-right">Options</th>
    </tr>
  </thead>
  <tbody>
    {#each attachments as attachment (attachment.id)}
      <AttachmentItem {attachment} />
    {/each}
  </tbody>
</table>
