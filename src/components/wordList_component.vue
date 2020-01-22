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
                <button class="viewer-toggle" v-on:click="changeViewMode">{{ viewMode }}</button>
            </div>
            <!-- 페이지네이션 -->
            <section v-show="isPaginationMode">
                <ul class="word-list">
                    <li v-for="(value, index) in words" v-bind:key="index">
                        <span v-on:click="showWord(value, index)">{{ value.word }}</span>
                    </li>
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
            <!-- 무한스크롤 -->
            <section v-show="!isPaginationMode"
                     class="infinite-scroll-box"
                     ref="infiniteScrollBox"
                     v-infinite-scroll="loadMore"
                     infinite-scroll-disabled="busy"
                     infinite-scroll-distance="10"
                     infinite-scroll-immediate-check="true">
                    <ul class="word-list">
                        <li v-for="(value, index) in words" v-bind:key="index">
                            <span v-on:click="showWord(value, index)">{{ value.word }}</span>
                        </li>
                    </ul>
            </section>
        </div>

        <modal v-if="showModal">
            <h3 slot="header">{{ viewWord }}</h3>
            <div slot="body">
                <div v-if="!isEditMode">
                    {{ viewDescription }}
                </div>
                <div v-else>
                    <textarea class="edit-textarea" v-focus v-model="editDescription"></textarea>
                </div>
            </div>
            <div slot="footer" class="two-btn-box">
                <div v-if="!isEditMode" v-on:click="editModeOn">수정</div>
                <div v-else             v-on:click="submit"           >저장</div>

                <div v-if="!isEditMode" v-on:click="showModal = false">닫기</div>
                <div v-else             v-on:click="isEditMode = false">취소</div>
            </div>
        </modal>
    </div>
</template>

<script>
    import Modal from './common/Modal.vue'
    export default {
        data: function() {
            return {
                pageTitle: '단어 목록보기',
                words: [],
                onePageViewCount: 5,
                isPaginationMode: true,
                maxPage: 1,
                showModal: false,
                viewWord: '',
                viewDescription: '',
                viewIndex: -1,
                isEditMode: false,
                editDescription: '',
                busy: false,
                loadingPageNum: 1,
                loadingTimeOutKey: -1,
            }
        },
        computed: {
            viewMode: function() {
                return this.isPaginationMode ? 'PageMode' : 'ScrollMode';
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
            },
            loadMore: function() {
                this.busy = true;
                this.loadingTimeOutKey = setTimeout(() => {
                    if (this.maxPage > this.loadingPageNum) {
                        this.addWords();
                        this.busy = false;
                    } else {
                        alert('단어를 모두 불러왔습니다.')
                    }
                }, 1000);
            },
            addWords: function() {
                if (!this.isPaginationMode) {
                    let thisComp = this;
                    axios.get('/getPage', {
                            params: {
                                pageNum: ++this.loadingPageNum,
                                onePageViewCount: this.onePageViewCount
                            }
                        })
                        .then((res)=>{
                            thisComp.words = thisComp.words.concat(res.data);
                        })
                        .catch(()=>{
                            alert('단어장(서버)을 불러오는데 실패하였습니다.');
                        })
                }
            },
            showWord: function(word, index) {
                this.viewWord = word.word;
                this.viewDescription = word.description;
                this.viewIndex = index;
                this.showModal = true;
            },
            submit: function() {
                let thisComp = this;
                axios.get('/update', {
                        params: {
                            word: this.viewWord,
                            description: this.editDescription,
                        }
                    })
                    .then((res)=>{
                        let isSuccess = this.$emit('isSuccess', res.data);
                        if (isSuccess) {
                            thisComp.isEditMode = false;
                            thisComp.words.splice(thisComp.viewIndex, 1, {
                                word: thisComp.viewWord,
                                description: thisComp.editDescription,
                            })
                            thisComp.viewDescription = thisComp.editDescription;
                        }
                    })
                    .catch(()=>{
                        alert('서버 오류: 단어 수정 실패');
                    })
            },
            editModeOn: function() {
                this.editDescription = this.viewDescription;
                this.isEditMode = true;
            },
            changeViewMode: function() {
                this.isPaginationMode = !this.isPaginationMode;
                clearTimeout(this.loadingTimeOutKey);
                this.getPage(1);
                this.loadingPageNum = 1;
                this.$refs.infiniteScrollBox.scrollTop = 0;
                this.busy = false;
            }
        },
        components: {
            modal: Modal
        },
        directives: {
            focus: {
                inserted: function(el) {
                    el.focus();
                }
            }
        }
    }
</script>

<style scoped>

</style>