<template>
    <div id="app">
        <router-link class="link" to="/main">Main voca</router-link>
        <router-link class="link" to="/login">Login voca</router-link>
        <router-view></router-view>
    </div>
</template>

<script>
export default {
    name: 'app'
}
</script>

<style>
.link {
    display: block;
    border: 1px solid black;
    padding: 5px;
}
</style>
