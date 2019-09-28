
# SPA with Vue

## Env setup, build

## Single File Components

Post.vue
<template>
    <div>
        <div class="card-content">
        </div>
        <footer></footer>
    </div>
</template>
<script>
    export default {
        props: ['post']
    }
</script>

Usage 
<template>
    <div v-for="(post, title) in posts">
        <app-post :post="post"></app-post>
    <div>
</template>
<script>
    import Post from './Post.vue'
    export default {
        components {
            'app-post': Post
        },
        data() {
            return {
                posts: []
            }
        }
    }
</script>


## Routing

<template>
    <div>
        <router-link to="/category/front-end" exact>FE</router-link>
        <router-link :to="{ name: 'category', params: {id :mobile}}">Mobile</router-link>
    </div>
</template>

router.js

const router = new VueRouter({
    mode: 'history',
    scrollBehavior: (to, from, savePosition => ({ y: 0 })),
    routes: [
        { path: '/login', component: Login},
        { path: '/category/:id', name: 'category', component: Category },
        { path: '/', redirect: /category/front-end' },
        { path: '*', component: NotFound }
    ]
})

## API Communication

app.service.js

import axios from 'axios'

axios.defaults.baseURL = 'http://localhost'
axios.interceptors.request.use(function (config) {
    config.headers.Authorization = 'Authorization': `Bearer ${token}`
    return config
})
const appService = {
    getPosts (categoryId) {
        return new Promise((resolve) => {
            axios.get('xx',{
                headers: { 'Authorization': `Bearer ${token}`}
            })
            .then(response => {
                resolve(response.data)
            })
        })
        
    }
}

export default appService

Category.vue
<script>
methods: {
    loadPosts () {
        appService.getPosts(categoryId).then(data => {
            this.posts = data
        })
    }
}
</script>

## State management

- vuex
- module

