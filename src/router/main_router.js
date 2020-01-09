/**
 * Created by mdj on 2020-01-09.
 */
import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

export const router = new VueRouter({
    routes: [
        {
            path: '/quiz',
            component: {
                template: '<div>quiz</div>'
            }
        },
        {
            path: '/addWord',
            component: {
                template: '<div>addWord</div>'
            }
        },
        {
            path: '/wordList',
            component: {
                template: '<div>wordList</div>'
            }
        }
    ]
})