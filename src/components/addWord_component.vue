<template>
    <div>
        <div>
            <header class="header">
                <h1 class="page-title">{{ pageTitle }}</h1>
                <a href="/"
                   title="메인화면으로 이동"
                   class="go-back-btn">
                    <span>Back</span>
                </a>
            </header>
            <section>
                <input v-model="answer" class="answer answer-add" type="text" placeholder="정답 입력">
                <div>
                    <textarea v-model="question" class="question question-input"></textarea>
                </div>
                <div>
                    <button class="submit-btn" v-on:click="addWord">입력하기</button>
                </div>
            </section>
        </div>
    </div>
</template>

<script>
    export default {
        data: function() {
            return {
                pageTitle: '단어 입력하기',
                answer: '',
                question: ''
            }
        },
        methods: {
            addWord: function() {
            }
        }
    }
</script>

<style scoped>

</style>