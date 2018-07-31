---
title: Class 6 Prep
currentMenu: course-outline
---

Before coming to Class 5, please complete the following tasks:


### JS History and jQuery

Javascript's original purpose was as a way to decorate pages by sprinkling extra functionality onto a page. For example: you might want to animate a button spin when you hover over it, or rotate between several photos of a project when they are clicked. Early on, only some browsers supported javascript, so it was only used for non-essential functionality.

As web developers attempted to make fancier pages, and users began to expect more out of websites, javascript became more popular. But there were inconsistencies between different browsers. For example, some browsers allowed you to access characters in a string with `'apple'[0]`, but IE did not. There's a [great answer on Stack Overflow][quirks-mode] that gives more examples of differences.

Luckily, a glorious champion appeared: jQuery! jQuery is still today the most popular javascript library, used on something like 50% of all websites<sup>[citation needed]</sup>. During the days when javascript was inconsistent between different browsers, it papered over these differences. Old versions of Internet Explorer didn't support setting `.innerHTML` for some elements. But with jQuery, you could call `$('.content').html(replacementValue)` instead of writing that terrible `setHtml` function described in the [stack overflow answer above][quirks-mode].

In addition to providing compatibility between different browsers, jQuery was just easier to use. The functions were shorter (`$('#num-rows')` instead of `document.getElementById('num-rows')`), and it had [helper functions for common uses](http://youmightnotneedjquery.com/#json).

On the bad side of things, jQuery (and regular javascript too) promoted an undisciplined approach to laying out code, keeping with its origins as a way to "sprinkle on" unimportant functionality. As web sites transistioned to web _apps_, code bases began to break down under their own weight. It was too easy to write `$('img').click(function() { $('.modal').show(); })` and too hard to figure out why the logo now showed the login modal. (Or something like that. Examples are hard to think of. At some point in your career, you'll inherit a codebase written in this era and you'll start to understand why we've moved on 😉).

jQuery is still relevant because so many websites use it. You'll come across it on your career But most _new_ sites are written with a different style of library, such as React, Angular2+, or Vue. The main difference between these libraries and their predecessors is that instead of writing DOM manipulation code (like `var newMovie = document.createElement('li'); newMovie.innerText = 'Snowpiercer'; document.querySelector('#movies-list').appendChild(newMovie')`), we write a code for how we'd like the DOM to look _once_, and the library takes care of making it so.

React was the first library to popularize this approach. I find Vue to be easier to use, though, so that's what we'll be learning in this class.

Done | Task | Resource Type | Link | Time Estimate | Instructions
-----|------|---------------|------|---------------|-------------
<input type="checkbox" v-model="checks.p6b" /> | Code along | Video Course | [Intro to Vue.js][intro-vuejs] | 2 hours | Follow along with the course.


[css-selectors]: https://www.codecademy.com/en/courses/web-beginner-en-WF0CF/resume?curriculum_id=50579fb998b470000202dc8b
[intro-vuejs]: https://www.vuemastery.com/courses/intro-to-vue-js/vue-instance
[quirks-mode]: https://stackoverflow.com/a/2599388/1586229