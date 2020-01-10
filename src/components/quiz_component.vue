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
        <section>
            <div>
                <p class="question">
                    {{ question }}
                    <span class="question-num">{{ questionNum }}</span>
                </p>
            </div>
            <div>
                <input v-model="answer" class="answer" type="text" placeholder="정답 입력">
                <button class="submit-btn" v-on:click="resultView">제출하기</button>
            </div>
        </section>
        <!-- 모달팝업 추가(오답,정답알림) -->
    </div>
</template>

<script>
    export default {
        data: function() {
            return {
                pageTitle: '퀴즈 풀기',
                answer: '',
                question: '설명설명'
            }
        },
        computed: {
            'questionNum' : function() {
               return '1/10';
            }
        },
        methods: {
            resultView: function() {
            }
        }
    }
</script>

<style scoped>

</style>