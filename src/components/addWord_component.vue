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
                <div class="box-answer-add">
                    <input v-model="answer" class="answer answer-add" type="text" placeholder="정답 입력">
                    <button v-on:click="isHaveWord">중복검사</button>
                </div>
                <div>
                    <textarea v-model="question" class="question question-input" v-on:keypress="lengthTest"></textarea>
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
                if (this.answer.length > 0) {
                    axios.get('/insert', {
                        params: {
                            word: this.answer,
                            description: this.question
                        }
                    })
                        .then((res) => {
                            let isSuccess = this.$emit('isSuccess', res.data);
                            if (isSuccess) {
                                this.clearInputBoxes();
                            }
                        })
                        .catch(() => {
                            alert('단어 저장 실패');
                        })
                } else {
                    alert('단어를 입력해주세요');
                }
            },
            clearInputBoxes: function() {
                this.answer = '';
                this.question = '';
            },
            lengthTest: function(event) {
                if (this.question.length > 300) {
                    alert('설명은 300자를 초과할 수 없습니다.');
                    event.preventDefault();
                }
            },
            isHaveWord: function() {
                if (this.answer.length > 0) {
                    axios.get('/isHaveWord?word=' + this.answer)
                        .then((res)=>{
                            if (res.data) {
                                alert('이미 등록된 단어입니다.')
                            } else {
                                alert('등록 가능한 단어입니다.')
                            }
                        })
                        .catch(()=>{
                            alert('서버 접근에 실패하였습니다.');
                        })
                } else {
                    alert('단어를 입력해주세요');
                }
            }
        }
    }
</script>

<style scoped>

</style>