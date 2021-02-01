<script>
  export let item = {};
</script>

<li class="flex justify-between">
  <p>{item.product.name}</p>
  <p>{item.quantity}</p>
  <p>{item.price}</p>
  <p>{item.totalGross}</p>
  <p>{item.totalDiscount}</p>
  <p>{item.totalNet}</p>
  <p>{item.totalTax}</p>
  <p>{item.Total}</p>
</li>
