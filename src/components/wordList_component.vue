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
                    <li v-for="(value, index) in words" v-bind:key="value.word">{{ value.word }}</li>
                </ul>
                <nav>
                    <paginate v-if="isPaginationMode"
                            :page-count="maxPage"
                            :click-handler="getPage"
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
            </section>
        </div>
    </div>
</template>

<script>
    export default {
        data: function() {
            return {
                pageTitle: '단어 목록보기',
                words: [],
                onePageViewCount: 5,
                isPaginationMode: true,
                maxPage: 1,
            }
        },
        created: function() {
            this.getPage(1);

            let thisComp = this;
            axios.get('/maxPage', {
                    params: {
                        onePageViewCount: this.onePageViewCount
                    }
                })
                .then((res)=>{
                    thisComp.maxPage = res.data;
                })
                .catch(()=>{
                    alert('단어장(서버)을 불러오는데 실패하였습니다.');
                })
        },
        methods: {
            getPage: function(pageNum) {
                let thisComp = this;
                axios.get('/getPage', {
                        params: {
                            pageNum: pageNum,
                            onePageViewCount: this.onePageViewCount
                        }
                    })
                    .then((res)=>{
                        thisComp.words = res.data;
                    })
                    .catch(()=>{
                        alert('단어장(서버)을 불러오는데 실패하였습니다.');
                    })
            }
        }
    }
</script>

<style scoped>

</style>