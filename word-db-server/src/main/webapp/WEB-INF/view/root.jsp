<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
${contextPath = pageContext.request.contextPath; ''}
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>
<link href="${contextPath}/css/main.css" rel="stylesheet" type="text/css">
<link href="${contextPath}/css/modal.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>
<div id="app">
	<router-view v-on:is-success="isSuccess"></router-view>
</div>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script>
axios.defaults.baseURL = '${contextPath}';
Vue.component('paginate', VuejsPaginate);

	let modal = {
			template: 
			"  <transition name='modal'>"
			+"	<div class='modal-mask'>"
			+"	  <div class='modal-wrapper'>"
			+"		<div class='modal-container'>"

			+"		  <div class='modal-header'>"
			+"			<slot name='header'>"
			+"				default header"
			+"			</slot>"
			+"		  </div>"

			+"		  <div class='modal-body'>"
			+"			<slot name='body'>"
			+"				default body"
			+"			</slot>"
			+"		  </div>"

			+"		  <div class='modal-footer'>"
			+"			<slot name='footer'>"
			+"				default footer"
			+"			</slot>"
			+"		  </div>"
			+"		</div>"
			+"	  </div>"
			+"	</div>"
			+"  </transition>",
			
	}

	let root = {

			template:
			 "<div> "
			+	"<h1 class='title'>Vue 로 만든 영단어장</h1> "
			+	"<div class='main-img-box'> "
			+		"<div> "
			+			"<img src='${contextPath}/images/main.jpg' alt='Vue 영단어 로고'>" 
			+		"</div> "
			+	"</div> "
			+	"<nav class='main-nav'> "
			+		"<ul> "
			+			"<li><router-link to='quiz'>퀴즈 풀기</router-link></li> "
			+			"<li><router-link to='addWord'>단어 입력하기</router-link></li> "
			+			"<li><router-link to='wordList'>단어 목록 보기</router-link></li> "
			+		"</ul> "
			+	"</nav> "
			+"</div>"

	}
	
	let quiz = {
			template: 
			 "	<div>"
			+"		<header class='header'>"
			+"			<h1 class='page-title'>{{ pageTitle }}</h1>"
			+"			<a href='${contextPath}/root'"
			+"			   title='메인화면으로 이동'"
			+"			   class='go-back-btn'>"
			+"				<span>Back</span>"
			+"			</a>"
			+"		</header>"
			+"		<section>"
			+"			<div>"
			+"				<p class='question'>"
			+"					{{ question }}"
			+"					<span class='question-num'>{{ questionNum }}</span>"
			+"				</p>"
			+"			</div>"
			+"			<div>"
			+"				<input v-model='answer'"
			+"					   v-focus"
			+"					   v-on:keydown.enter.stop='showResultModal'"
			+"					   class='answer'"
			+"					   type='text'"
			+"					   placeholder='정답 입력' ref='answer'>"
			+"				<button class='submit-btn' v-on:click='showResultModal'>제출하기</button>"
			+"			</div>"
			+"		</section>"

			+"		<modal v-if='showModal'>"
			+"			<h3 slot='header'>{{ resultTitle }}</h3>"
			+"			<div slot='body'>"
			+"				<div v-html='resultMsg'></div>"
			+"			</div>"
			+"			<div slot='footer' v-bind:class='twoModalBtn ? \"two-btn-box\" : \"one-btn-box\"'>"
			+"				<div v-if='twoModalBtn' v-on:click='$router.go(0)'>다시 도전</div>"
			+"				<div v-if='twoModalBtn' v-on:click='$router.push(\"${contextPath}\")'>홈으로</div>"

			+"				<button v-else v-on:click='closeModal' v-focus>확인</button>"
			+"			</div>"
			+"		</modal>"
			+"	</div>",
			
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
				modal : modal,
			}
			
	}
	
	let addWord = {
			template: 
			 "	<div>"
			+"		<div>"
			+"			<header class='header'>"
			+"				<h1 class='page-title'>{{ pageTitle }}</h1>"
			+"				<a href='${contextPath}/root'"
			+"				   title='메인화면으로 이동'"
			+"				   class='go-back-btn'>"
			+"					<span>Back</span>"
			+"				</a>"
			+"			</header>"
			+"			<section>"
			+"				<div class='box-answer-add'>"
			+"					<input v-model='answer' v-focus class='answer answer-add' type='text' placeholder='정답 입력'>"
			+"					<button v-on:click='isHaveWord'>중복검사</button>"
			+"				</div>"
			+"				<div>"
			+"					<textarea v-model='question' class='question question-input' v-on:keypress='lengthTest'></textarea>"
			+"				</div>"
			+"				<div>"
			+"					<button class='submit-btn' v-on:click='addWord'>입력하기</button>"
			+"				</div>"
			+"			</section>"
			+"		</div>"
			+"	</div>",
			
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
								let isSuccess = this.$emit('is-success', res.data);
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
			},
			directives: {
				focus: {
					inserted: function(el) {
						el.focus();
					}
				}
			}

	}
	
	let wordList = {
			template: 
				"<div>"
				+"	<header class='header'>"
				+"		<h1 class='page-title'>{{ pageTitle }}</h1>"
				+"		<a href='${contextPath}/root'"
				+"		   title='메인화면으로 이동'"
				+"		   class='go-back-btn'>"
				+"			<span>Back</span>"
				+"		</a>"
				+"	</header>"
				+"	<div class='word-list-box'>"
				+"		<div class='toggle-btn-area'>"
				+"			<button class='viewer-toggle' v-on:click='changeViewMode'>{{ viewMode }}</button>"
				+"		</div>"
				+"		<!-- 페이지네이션 -->"
				+"		<section>"
				+"			<ul class='word-list'>"
				+"				<li v-for='(value, index) in words' v-bind:key='index'>"
				+"					<span v-on:click='showWord(value, index)'>{{ value.word }}</span>"
				+"				</li>"
				+"			</ul>"
				+"			<nav>"
				+"				<paginate v-if='isPaginationMode'"
				+"						:page-count='maxPage'"
				+"						:click-handler='getPage'"
				+"						:prev-text=\"'Prev'\""
				+"						:next-text=\"'Next'\""
				+"						:container-class=\"'pagination'\">"
				+"					<span slot='prevContent'>Changed previous button</span>"
				+"					<span slot='nextContent'>Changed next button</span>"
				+"					<span slot='breakViewContent'>"
				+"						<svg width='16' height='4' viewBox='0 0 16 4'>"
				+"						  <circle fill='#999999' cx='2' cy='2' r='2' />"
				+"						  <circle fill='#999999' cx='8' cy='2' r='2' />"
				+"						  <circle fill='#999999' cx='14' cy='2' r='2' />"
				+"						</svg>"
				+"					</span>"
				+"				</paginate>"
				+"			</nav>"
				+"		</section>"
				+"	</div>"

				+"	<modal v-if='showModal'>"
				+"		<h3 slot='header'>{{ viewWord }}</h3>"
				+"		<div slot='body'>"
				+"			<div v-if='!isEditMode'>"
				+"				{{ viewDescription }}"
				+"			</div>"
				+"			<div v-else>"
				+"				<textarea class='edit-textarea' v-focus v-model='editDescription'></textarea>"
				+"			</div>"
				+"		</div>"
				+"		<div slot='footer' class='two-btn-box'>"
				+"			<div v-if='!isEditMode' v-on:click='editModeOn'>수정</div>"
				+"			<div v-else             v-on:click='submit'           >저장</div>"

				+"			<div v-if='!isEditMode' v-on:click='showModal = false'>닫기</div>"
				+"			<div v-else             v-on:click='isEditMode = false'>취소</div>"
				+"		</div>"
				+"	</modal>"
				+"</div>",
				
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
							let isSuccess = this.$emit('is-success', res.data);
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
				modal: modal
			},
			directives: {
				focus: {
					inserted: function(el) {
						el.focus();
					}
				}
			}
				
			
	}

	let router = new VueRouter({
		mode: 'history',
		routes:[
			{
				path: '${contextPath}/root',
				component: root
			},
			{
				path: '${contextPath}/quiz',
				component: quiz
			},
			{
				path: '${contextPath}/addWord',
				component: addWord
			},
			{
				path: '${contextPath}/wordList',
				component: wordList
			}
		]
	})
	
	let vue = new Vue({
		el: '#app',
		router,
		methods: {

			isSuccess: function(enumMap) {
				let key = Object.keys(enumMap);
				alert(enumMap[key]);
				return key[0] === 'SUCCESS' ? true : false;
			}

		}
	});
</script>
</body>
</html>