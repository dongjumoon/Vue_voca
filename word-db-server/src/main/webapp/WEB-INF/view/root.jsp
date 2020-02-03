<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>
<title>Insert title here</title>
</head>
<body>
<div id="app">
	<router-view></router-view>
</div>
<script>
	let root = {
			template: '<div> <h1 class="title">Vue 로 만든 영단어장</h1> <div class="main-img-box"> <div> <img src="../images/main.jpg" alt="Vue 영단어 로고"> </div> </div> <nav class="main-nav"> <ul> <li><router-link to="/quiz">퀴즈 풀기</router-link></li> <li><router-link to="/addWord">단어 입력하기</router-link></li> <li><router-link to="/wordList">단어 목록 보기</router-link></li> </ul> </nav> </div>'
	}
	let router = new VueRouter({
		mode: 'history',
		routes:[
			{
				path: '/word-db-server/root',
				component: root
			},
			{
				path: '/quiz',
				component: {template:'<p>하이</p>'}
			},
			{
				path: '/addWord',
				component: {}
			},
			{
				path: '/wordList',
				component: {}
			}
		]
	})
	let vue = new Vue({
		router
	}).$mount('#app');
</script>
</body>
</html>