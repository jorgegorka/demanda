<script>
  export let content = {};
</script>

<section class="mt-12 p-4 flex flex-col md:flex-row items-center text-gray-900">
  <div class="px-4 md:px-8 w-full md:w-2/3">
    <h2 class="text-2xl text-gray-800 xl:text-4xl font-display font-semibold">
      {content.title}
    </h2>
    <p class="mt-2 text-lg text-gray-600 xl:text-2xl">{content.description}</p>
  </div>
  <div class="mt-4 ml-4 w-full md:w-1/3">
    <img class="rounded border" src={content.imageSrc} alt={content.imageAlt} />
  </div>
</section>
