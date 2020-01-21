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
                <input v-model="answer"
                       v-focus
                       v-on:keydown.enter.stop="showResultModal"
                       class="answer"
                       type="text"
                       placeholder="정답 입력" ref="answer">
                <button class="submit-btn" v-on:click="showResultModal">제출하기</button>
            </div>
        </section>

        <modal v-if="showModal">
            <h3 slot="header">{{ resultTitle }}</h3>
            <div slot="body">
                <div v-html="resultMsg"></div>
            </div>
            <div slot="footer" v-bind:class="twoModalBtn ? 'two-btn-box' : 'one-btn-box'">
                <div v-if="twoModalBtn" v-on:click="$router.go(0)">다시 도전</div>
                <div v-if="twoModalBtn" v-on:click="$router.push('/')">홈으로</div>

                <button v-else v-on:click="closeModal" v-focus>확인</button>
            </div>
        </modal>
    </div>
</template>

<script>
    import Modal from './common/Modal.vue'
    export default {
        data: function() {
            return {
                pageTitle: '퀴즈 풀기',
                totalQuizNumber: 10,
                quizList: [],
                nowIndex: 0,
                answer: '',
                rightPoint: 0,
                score: 0,
                resultTitle: '',
                resultMsg: '',
                showModal: false,
                question: '',
                twoModalBtn: false,
            }
        },
        computed: {
            questionNum : function() {
               return (this.nowIndex + 1) + '/' + this.quizList.length;
            }
        },
        watch: {
            nowIndex: function() {
                this.question = this.quizList[this.nowIndex].description;
            }
        },
        methods: {
            showResultModal: function(event) {
                event.preventDefault();
                if (this.answer.length === 0) {
                    this.resultMsg = '정답을 입력해주세요.';
                } else {
                    if (this.answer === this.quizList[this.nowIndex].word) {
                       this.resultMsg = '정답입니다';
                       this.score++;
                    } else {
                        this.resultMsg = '틀렸습니다';
                    }
                    if (this.nowIndex + 1 >= this.quizList.length) {
                        // 퀴즈 결과 표시
                        if (this.score === this.quizList.length) {
                            this.resultTitle = '만점! 축하합니다';
                        } else if (this.score >= this.quizList.length * 0.7) {
                            this.resultTitle = '좋은 결과입니다.';
                        } else {
                            this.resultTitle = '아쉬운 결과입니다';
                        }
                        this.resultMsg = '맞은갯수 : ' + this.score + '<br>틀린갯수 : ' + (this.quizList.length - this.score);
                        this.twoModalBtn = true;
                    } else {
                        this.nowIndex++;
                    }
                }
                this.showModal = true;
            },
            closeModal: function() {
                this.showModal = false;
                this.answer = '';
                this.$refs.answer.focus();
            },
            restart: function() {

            },
            goMain: function() {

            }
        },
        created: function() {
            let thisComp = this;
            axios.get('/quizList?totalQuizNumber=' + this.totalQuizNumber)
                 .then((res)=>{
                        thisComp.quizList = res.data;
                        thisComp.question = thisComp.quizList[0].description;
                    })
                 .catch(()=>{alert('오류')})
        },
        directives: {
            focus: {
                inserted: function(el) {
                    el.focus();
                }
            }
        },
        components: {
            modal : Modal,
        }
    }
</script>

<style scoped>

</style>