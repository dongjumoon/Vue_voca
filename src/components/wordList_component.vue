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
            </section>
        </div>
    </div>
</template>

<script>
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
            }
        }
    }
</script>

<style scoped>

</style>