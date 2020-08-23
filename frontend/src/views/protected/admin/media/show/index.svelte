<script>
  export let attachment;
  export let width = 600;

  function isImage() {
    console.log(attachment);
    return attachment.contentType.startsWith("image");
  }
</script>

{#if isImage()}
  <img src={attachment.url} alt={attachment.title} {width} />
{:else}
  <a href={attachment.url} title={attachment.title}>{attachment.title}</a>
{/if}
