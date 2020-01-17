<template>
    <div id="app">
        <router-view v-on:isSuccess="isSuccess"></router-view>
    </div>
</template>

<script>
export default {
    methods: {
        isSuccess: function(enumMap) {
            let key = Object.keys(enumMap);
            alert(enumMap[key]);
            return key[0] === 'SUCCESS' ? true : false;
        },
    }
}
</script>

<style>
    @import './css/main.css';
</style>
