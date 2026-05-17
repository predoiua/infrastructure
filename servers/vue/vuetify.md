

~~~
npm uninstall vue-cli -g
npm install -g @vue/cli

vue --version   # in 2020 must be > 3

#vue ui
#vue create fe2
npm install -g @vue/cli-init

~~~

fe2
~~~
vue init webpack fe2  # old form
~~~



vue add vuetify-preset-rally
https://vuetifyjs.com/en/customization/presets/


fe2
~~~
#https://www.youtube.com/watch?v=FbEW3xAmhKs&list=PL4cUxeGkcC9g0MQZfHwKcuB0Yswgb3gA5&index=2
vue create fe3   # custom, select what you want to include
cd fe3
npm run serve
vue add vuetify  # will modify existing Vue files
#https://vuetifyjs.com/en/customization/presets/
vue add vuetify-preset-rally
~~~

# To know

all must be inside v-app
v-app -> v-main -> router-view        ( v-content was replaced with v-main )
dark is a prop

## Font

class="diplay-1" # very large to display-1
class="subheading"
class="caption"

## Spacing - padding and margin

Margin is an element’s personal space — how much distance the element wants to keep with other elements around it.
Padding is how much an element is away from itself — how much distance an element wants to keep with the elements inside it.

class="mx-4 pa-2"




