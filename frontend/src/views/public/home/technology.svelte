<script>
  import SectionRight from "../../components/page_sections/section_image_right.svelte";
  import SectionLeft from "../../components/page_sections/section_image_left.svelte";

  const section1 = {
    title: "All you need to create a modern online shop",
    description:
      "With Demanda you can create secure, scalable, robust and modern online shops. Thanks to its GraphQL API is very configurable. Demanda's been created using reliable and modern technologies.",
    imageSrc: "/images/create-modern-online-shops.jpg",
    imageAlt: "create secure, scalable, robust and modern online shops"
  };
  const section2 = {
    title: "For developers and designers",
    description:
      "Whether you are a developer or a designer, with Demanda you can create and customise an e-commerce site very quickly. Use only what you need. Backend and frontend are completely separated.",
    imageSrc: "/images/designers-developers.jpg",
    imageAlt: "for developers and designers"
  };
  const section3 = {
    title: "Bring your own frontend",
    description:
      "If you are using any modern website creator like Gatsby JS, Sapper, Nuxt or Gridsome just to name a few, you will find in Demanda the perfect tool to add e-commerce functionality to your site.",
    imageSrc: "/images/help-available.jpg",
    imageAlt: "Conctact me for commercial support"
  };
</script>

<div class="p-12 bg-gray-100 text-center text-gray-800">
  <SectionRight content={section1} />
  <SectionLeft content={section2} />
  <SectionRight content={section3} />
</div>
