<template>
    <div id="app">
        <h1>Vue 로 만든 영단어장</h1>
        <div class="center-img-box">
            <div>
                <img src="./images/main.jpg" alt="Vue 영단어 로고">
            </div>
        </div>
        <ul>
            <li><router-link to="/quiz">퀴즈 풀기</router-link></li>
            <li><router-link to="/addWord">단어 입력하기</router-link></li>
            <li><router-link to="/wordList">단어 목록 보기</router-link></li>
        </ul>
    </div>
</template>

<script>
export default {
    name: 'app'
}
</script>

<style>
    * {
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        list-style: none;
        margin: 0;
        padding: 0;
        text-decoration: none;
    }
    a {
        color: black;
    }

    /*  */
    h1 {
        text-align: center;
        line-height: 200px;
        font-weight: normal;
    }
    li {
        width: 50%;
        min-width: 250px;
        max-width: 800px;
        text-align: center;
        border: 1px solid #eee;
        margin: 0 auto 10px;
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        border-radius: 5px;
    }
    li > a {
        display: block;
        padding: 10px;
    }
    .center-img-box {
        width: 40%;
        min-width: 250px;
        margin: 0 auto 110px;
    }
    .center-img-box > div {
        width: 100%;
        padding-bottom: 70%;
        position: relative;
    }
    .center-img-box > div > img {
        position: absolute;
        width: 100%;
        height: 100%;
    }
</style>
