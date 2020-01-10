/**
 * Created by mdj on 2020-01-09.
 */
import Vue from 'vue'
import VueRouter from 'vue-router'
import root_comp from '../components/root_component.vue'
import quiz_comp from '../components/quiz_component.vue'
import addWord_comp from '../components/addWord_component.vue'
import wordList_comp from '../components/wordList_component.vue'

Vue.use(VueRouter)

export const router = new VueRouter({
    mode: 'history',
    routes: [
        {
            path: '/',
            component: root_comp,
        },
        {
            path: '/quiz',
            component: quiz_comp
        },
        {
            path: '/addWord',
            component: addWord_comp
        },
        {
            path: '/wordList',
            component: wordList_comp
        }
    ]
})