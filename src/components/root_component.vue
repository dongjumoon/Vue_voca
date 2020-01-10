<template>
    <div>
        <h1 class="title">Vue 로 만든 영단어장</h1>
        <div class="main-img-box">
            <div>
                <img src="../images/main.jpg" alt="Vue 영단어 로고">
            </div>
        </div>
        <nav class="main-nav">
            <ul>
                <li><router-link to="/quiz">퀴즈 풀기</router-link></li>
                <li><router-link to="/addWord">단어 입력하기</router-link></li>
                <li><router-link to="/wordList">단어 목록 보기</router-link></li>
            </ul>
        </nav>
    </div>
</template>

<script>
    export default {
    }
</script>

<style scoped>
</style>