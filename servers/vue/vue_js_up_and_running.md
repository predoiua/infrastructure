# Vue js Up and Running


## 1. Vue.js: The Basics

### Webpack

~~~
npm install --global vue-cli
vue init webpack
~~~

<div id="app">
    <p v-if="path === '/'">You are on the home page</p>
    <p v-else>You're on {{ path }}</p>
</div>
<script>
    new Vue({
    el: '#app',
    data: {
        path: location.pathname
    }
});
</script>

### looping

<div id="app">
    <ul>
        <li v-for="dog in dogs">{{ dog }}</li>
    </ul>
</div>
<script>
    new Vue({
    el: '#app',
    data: {
        dogs: ['Rex', 'Rover', 'Henrietta', 'Alan']
    }
});
</script>

### Binding Arguments

<div id="app">
    <button v-bind:type="buttonType">Test button</button>
</div>
<script>
new Vue({
    el: '#app',
    data: {
        buttonType: 'submit'
    }
});
</script>

### reactivity and hooks

<div id="app">
<p>{{ seconds }} seconds have elapsed since you opened the page.</p>
</div>
<script>
new Vue({
    el: '#app',
    data: {
        seconds: 0
    },
    created() {
        setInterval(() => {
            this.seconds++;
        }, 1000);
    }
});
</script>

### Reactivity caveats

#### new property
const vm = new Vue({
data: {
    formData: {
        username: 'someuser'
    }
}
});

will  not work:
vm.formData.name = 'Some User';
use:
Vue.set(vm.formData, 'name', 'Some User');

#### array

const vm = new Vue({
data: {
    dogs: ['Rex', 'Rover', 'Henrietta', 'Alan']
}
});
will not work:
vm.dogs[2] = 'Bob'
use:
vm.dogs.splice(2, 1, 'Bob);
or:
Vue.set(vm.dogs, 2, 'Bob');

### Two-Way Data Binding

<div id="app">
    <input type="text" v-model="inputText">
    <p>inputText: {{ inputText }}</p>
</div>


## 2 Components in Vue.js

## Pass params to component
<div id="app">
    <color-preview color="red"></color-preview>
    <color-preview color="blue"></color-preview>
</div>
<script>
Vue.component('color-preview', {
    template: '<div class="color-preview" :style="style"></div>',
    props: ['color'],
    computed: {
        style() {
        return { backgroundColor: this.color };
        }
    }
});
new Vue({
    el: '#app'
});
</script>