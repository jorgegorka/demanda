<script>
  export let product = {};
</script>

<div class="p-4 flex justify-between bg-white">
  <p>Category: {product.category.name}</p>
  <p>Price: {product.price}</p>
  <p>Stock qty: {product.stock}</p>
</div>
