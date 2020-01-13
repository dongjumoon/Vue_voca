<template>
    <div id="app">
        <router-view v-bind:words="viewerWords" v-bind:maxPage="maxPage" v-on:paging="getPageWords"></router-view>
    </div>
</template>

<script>
export default {
    data() {
        return {
            words: {
                word01: '설명01',
                word02: '설명02',
                word03: '설명03',
                word04: '설명04',
                word05: '설명05',
                word06: '설명06',
                word07: '설명07',
                word08: '설명08',
                word09: '설명09',
                word10: '설명10',
                word11: '설명11',
                word12: '설명12',
                word13: '설명13',
                word14: '설명14',
                word15: '설명15',
                word16: '설명16',
                word17: '설명17',
                word18: '설명18',
                word19: '설명19',
                word20: '설명20',
                word21: '설명21',
            },
            onePageViewCount: 5,
            viewerWords: {},
            maxPage: 1,
        }
    },
    methods: {
        getPageWords: function(page) {
            var keys = Object.keys(this.words);
            this.maxPage = keys.length / this.onePageViewCount;
            if (keys.length % this.onePageViewCount !== 0) {
                this.maxPage = Math.ceil(this.maxPage);
            }
            var startWordIndex = (page - 1) * this.onePageViewCount;
            var viewerKeys = keys.slice(startWordIndex, startWordIndex + this.onePageViewCount);
            var words = {};
            for (var key in viewerKeys) {
                    var wordName = (startWordIndex + 1 + Number(key)) + '. ' + viewerKeys[key];
                    words[wordName] = this.words[key];
            }
            this.viewerWords = words;
        },
    }
}
</script>

<style>
    @import './css/main.css';
</style>
