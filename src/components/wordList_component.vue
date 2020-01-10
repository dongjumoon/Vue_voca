<template>
    <div>
        <header class="header">
            <h1 class="page-title">{{ pageTitle }}</h1>
            <a href="/"
               title="메인화면으로 이동"
               class="go-back-btn">
                <span>Back</span>
            </a>
        </header>
        <div class="word-list-box">
            <div class="toggle-btn-area">
                <button class="viewer-toggle">Page / scroll</button>
            </div>
            <section>
                <ul class="word-list">
                    <li v-for="(word, index) in words" v-bind:key="word">{{ (index + 1) + '.' }} {{ word }}</li>
                </ul>
                <nav>

                </nav>
            </section>
        </div>
    </div>
</template>

<script>
    export default {
        data: function() {
            return {
                pageTitle: '단어 목록보기',
                words: ['red', 'blue', 'component', 'function', 'method']
            }
        }
    }
</script>

<style scoped>

</style>