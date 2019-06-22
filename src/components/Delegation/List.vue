<template>
  <div class="pt-5 col-md">
    <h3>Delegees</h3>
    <ul class="pt-2">
      <li>
          Heisenberg <button @click="revoke('0x111')" type="button" class="btn btn-link">Revoke</button>

      </li>
    </ul>
  </div>
</template>
<script>

export default {
  name: 'Main',
  methods: {
    revoke(pubKey) {
      console.log("revoking "+pubKey)
    }
  }
}

</script>
