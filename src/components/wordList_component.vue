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
                    <li v-for="(value, key) in words" v-bind:key="key">{{ key }}</li>
                </ul>
                <nav>
                    <paginate v-if="viewerMode"
                            :page-count="Number(maxPage)"
                            :click-handler="getWords"
                            :prev-text="'Prev'"
                            :next-text="'Next'"
                            :container-class="'pagination'">
                        <span slot="prevContent">Changed previous button</span>
                        <span slot="nextContent">Changed next button</span>
                        <span slot="breakViewContent">
                            <svg width="16" height="4" viewBox="0 0 16 4">
                              <circle fill="#999999" cx="2" cy="2" r="2" />
                              <circle fill="#999999" cx="8" cy="2" r="2" />
                              <circle fill="#999999" cx="14" cy="2" r="2" />
                            </svg>
                        </span>
                    </paginate>
                </nav>
                <button v-on:click="serverTest">서버확인버튼</button>
            </section>
        </div>
    </div>
</template>

<script>
    import axios from 'axios'
    export default {
        data: function() {
            return {
                pageTitle: '단어 목록보기',
                viewerMode: true,
            }
        },
        props: ['words', 'maxPage'],
        created: function() {
            this.$emit('paging', 1);
        },
        methods: {
            getWords: function(pageNum) {
                this.$emit('paging', pageNum);
            },
            serverTest: function() {
                axios.get('http://localhost:8088/word-db-server/insert?word=server17&description=testserver17')
                    .then(()=>{console.log('성공')})
                    .catch(()=>{console.log('실패')});
            }
        }
    }
</script>

<style scoped>

</style>