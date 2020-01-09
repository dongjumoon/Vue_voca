/**
 * Created by mdj on 2020-01-09.
 */
import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

export const router = new VueRouter({
    routes: [
        {
            path: '/main',
            component: {
                template: '<div>main</div>'
            }
        },
        {
            path: '/login',
            component: {
                template: '<div>login</div>'
            }
        }
    ]
})