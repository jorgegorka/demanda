<script>
  export let product = {};
</script>

<div class="p-4 flex justify-between bg-white">
  <p>
    <strong class="mr-2">Category:</strong>
    {product.category.name}
  </p>
  <p>
    <strong class="mr-2">Price:</strong>
    {product.price}
  </p>
  <p>
    <strong class="mr-2">Stock qty:</strong>
    {product.stock}
  </p>
</div>
