
# Install and start Jekyll

~~~
apt instll jekyll
jekyll serve
~~~

## Add content

- create folder "tutorial"

- add index.md
---
layout: doc
title: Documentation
permalink: /documents/
menu: main
---

- edit _includes/header.html
{% if my_page.title %} => {% if my_page.menu == 'main' %}


- create doc layout