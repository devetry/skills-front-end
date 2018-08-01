---
title: Class 7 Prep
currentMenu: course-outline
---

We are now transitioning to a point in the class where we will be making a bunch of HTTP requests to external servers, and processing the data we receive back. This, of course, is what a browser does every time you visit a webpage. But it turns out there are other ways, besides "visiting a page", of making HTTP requests. On the front-end, one very common technique for making requests is using a technique called AJAX, which you will learn about in the Udacity course below.

Before coming to Class 6, please complete the following tasks:


### cURL

cURL is a command-line tool that lets you simply make HTTP requests and see the response. This is a helpful tool for debugging, and for playing around the APIs of third-party sources that make their data available (like in the Udacity course below).

Done | Task | Resource Type | Link | Time Estimate | Instructions
-----|------|---------------|------|---------------|--------------
<input type="checkbox" v-model="checks.p7a" /> | Follow-Along | Article | [cURL Tutorial][curl-tutorial] | 30 minutes | As you read this article, make sure to open up a Terminal window follow along with the examples.


### JSON

When sending and receiving data, there are a variety of different standards for the exact syntax of how to structure the data as text. These days, the most common standard is JSON.

Done | Task | Resource Type | Link | Time Estimate | Instructions
-----|------|---------------|------|---------------|--------------
<input type="checkbox" v-model="checks.p7b" /> | Read | Article | [What is JSON: the 3 minute JSON Tutorial][3-minute-json] | 3 minutes! | This (very old) article gives a quick intro to JSON.
<input type="checkbox" v-model="checks.p7c" /> | Read  | Stack Overflow Post | [What is JSON and Why Should I Use it?][what-is-json] | a few more minutes | Quickly read this SO post on JSON.

### AJAX

In Javascript, you can make a request to a server, wait for the response to come back, and then do something with the response, without the user ever having to leave or refresh the page. This technique is called AJAX. This is how Gmail, for example, makes your newly received email appear instantly in your inbox, even without you refreshing the page.

Done | Task | Resource Type | Link | Time Estimate | Instructions
-----|------|---------------|------|---------------|--------------
<input type="checkbox" v-model="checks.p7d" /> | Do   | Article | [CSS Tricks: Using Fetch][css-tricks-using-fetch] | 20 minutes | This article explains how to use the built-in `fetch` function to bring data from other sources into your page. Feel free to stop once you get to the "Handling other response types" portion.
<input type="checkbox" v-model="checks.p7e" /> | Do   | Documentation | [MDN: Using Fetch][mdn-using-fetch] | 20 minutes | Documentation for how to use `fetch`, with many examples.



[curl-tutorial]: http://www.yilmazhuseyin.com/blog/dev/curl-tutorial-examples-usage/
[3-minute-json]: http://www.secretgeek.net/json_3mins
[what-is-json]: http://stackoverflow.com/questions/383692/what-is-json-and-why-would-i-use-it
[css-tricks-using-fetch]: https://css-tricks.com/using-fetch/#article-header-id-6
[mdn-using-fetch]: https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch