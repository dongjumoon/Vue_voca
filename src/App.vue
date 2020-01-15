<template>
    <div id="app">
        <router-view v-bind:words="viewerWords" v-bind:maxPage="maxPage" v-on:paging="getPageWords"></router-view>
    </div>
</template>

<script>
export default {
    data() {
        return {
            words: [],
            onePageViewCount: 5,
            viewerWords: [],
            maxPage: 1,
        }
    },
    methods: {
        getPageWords: function(page) {
            this.maxPage = this.words.length / this.onePageViewCount;
            if (this.words.length % this.onePageViewCount !== 0) {
                this.maxPage = Math.ceil(this.maxPage);
            }

            var startWordIndex = (page - 1) * this.onePageViewCount;
            this.viewerWords = this.words.slice(startWordIndex, startWordIndex + this.onePageViewCount);
        },
    },
    created: function() {
        let mainThis = this;
        axios.get('selectAll')
             .then(function(res) {
                 mainThis.words = res.data;
             })
             .catch(()=>{
                alert('단어장(서버)을 불러오는데 실패하였습니다.')
             });
    }
}
</script>

<style>
    @import './css/main.css';
</style>
