<script>
  export let attachment;
  export let name = "standard";

  function isImage() {
    return attachment.contentType.startsWith("image");
  }
</script>

{#if isImage()}
  <img src={attachment[name]} alt={attachment.title} />
{:else}
  <a href={attachment.url} title={attachment.title}>{attachment.title}</a>
{/if}
