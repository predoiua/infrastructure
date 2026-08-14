
~~~bash
yes | head -10 | awk '{ print NR, NR % 2 == 0 ? "even": "odd"}' | fzf
~~~