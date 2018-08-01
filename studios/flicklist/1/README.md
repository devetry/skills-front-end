---
title: "FlickList 1"
currentMenu: studios
---

In [the previous Studio](../0), you forked the project repository and added your API key to the source code.

Today, you will start adding some real functionality to the code base. By the end of this studio, users will see a browseable list of movies on the screen. Each movie will have an "Add to Watchlist" button, which, when clicked, will cause that movie to show up on another area of the screen where the user's Watchlist is displayed.

## Demo

Here is what you are trying to accomplish: [FlickList 1 Demo](http://htmlpreview.github.io/?https://github.com/LaunchCodeEducation/flicklist/blob/ba335b0509258c7e4dc51779f9baa536f914c07b/index.html). Take a minute to play around with the demo so you understand what your goal is.

## Obtaining the Starter Code

Navigate into the `flicklist` folder:

```nohighlight
$ cd ~/your/path/to/flicklist
```

Your git status should be clean of any unstaged changes:

```nohighlight
$ git status
On branch studio0
nothing to commit, working directory clean
```

(We are assuming you will still be on the `studio0` branch from last time. But if you're on a different branch, that's fine, as long as you see "nothing to commit, working directory clean". If you do have unstaged or uncommitted changes, commit them now. If you need guidance, see [here](../0#commit-and-push-on-git).)

and then checkout the `studio1` branch:

```nohighlight
$ git checkout studio1
Branch studio1 set up to track remote branch studio1 from origin.
Switched to a new branch 'studio1'
```


## A Brief Tour

Welcome to the studio1 branch!

Your folder structure should look the same as last time:

```nohighlight
$ tree
.
├── index.html
└── js
    └── flicklist.js

1 directory, 2 files
```

But the contents of those files is a little different. Let's take a look. Open up `index.html` and `flicklist.js` in your text editor.

### index.html

The body of the document now has three main parts:
* a `<header>` to display the project title and tagline
* a `<section>` to display the movies that are on the user's watchlist
* several TODO comments, corresponding to the steps in your task

The `<header>` and `<section>` tags might look unfamiliar to you. They are relatively new additions to the HTML language. Similar to the `<div>`, these tags serve as a container for other tags, so you can group your document into chunks. The difference is that a `<div>` does not indicate *what kind of content* it contains, whereas these new tags do: the `<header>` indicates that it is meant to serve as a title or heading above some other content; the `<section>` indicates a discrete section of your document. Using these tags instead of `<div>`s makes it more immediately obvious how your document is structured and what kind of role each of the various chunks is playing. As much as possible, it is generally best practice to make your HTML "semantically meaningful" like this. You will learn a bit more about "Semantic HTML" in later Prep Work.

You might also notice that although the top of this file is almost the same as last time, there is one small change-- we have added this line:

```html
<meta charset="utf-8"/>
```

What this does is explicitly defines that our document should use the Unicode character encoding. If curious, you can read more about character encoding [here](http://www.w3.org/International/questions/qa-what-is-encoding). Generally try to remember to add this line in your HTML, or you might get some strange results when your page attempts to display obscure characters. But for now, don't waste a ton of brainpower worrying about this topic.

### flicklist.js

Let's now talk about `flicklist.js`.

The beginning of the file still contains that `api` object, one of whose properties, `token`, currently has a value of `"TODO"`, which you should once again replace with your personal api key.

There is another object nearby, inside the `data`. This is where we will store all the data we need to keep track of. You can see that this object has two properties:
* `watchlistItems`, an array (initially empty) that represents all the movies on the user's watchlist
* `browseItems`, an array (also initally empty) that holds all the movies we want to make available to the user for browsing.

Moving down the page, the `discoverMovies` function is very similar to the function called `testTheAPI` from last time: it makes an AJAX request to TheMovieDB's API, and after receiving a response, logs it to the console. But there is now a little bit more code inside that `success` function:
* First of all, there is a TODO! We want you to write a line here such that, whenever a response comes back from the API, you update the `this.browseItems` value to be equal to the list of movies in the response.

## Your Task

Work your way through the TODOs in the starter code. Each task is numbered, indicating the order in which you should work on them. The tasks are as follows:

##### 0. Add your API key to the `api` variable

Just like last time.

##### 1. Add a browsing section

In `index.html`, add another `<section>` very similar to the watchlist section above. You should also put an empty `<ul>` inside, where you will later insert those list items for the browsable movies.

##### 2. Update the model when AJAX request succeeds

Inside the `discoverMovies` function, when a successul response comes back, we are currently logging the response to the console, but we are not actually doing anything useful with the data. Your job is to update the `this.browseItems` value, setting it to be the newly received list of movies.

##### 3. Insert a list item for each movie on the browse list

Most of the rest of your TODOs are in the index.html. Even though it *seems* like we're writing html, the reality is a little more complicated. Remember, html has no way to do a for-loop. When we create our `flicklistVue` object, and set `el: '#mount-target'`, we're asking Vue to take over that portion of the page. Vue looks through the document, noticing up any `v-for`, `v-model`, `@click`, or other directives. Whenever `flicklistVue`'s data changes, Vue will update the html to "make it so". That is, Vue updates the html to ensure that it is in sync with the data.

On this TODO, we are asking you to create a list item `<li>` for each movie in the browse list, and append that list item to the `<ul>` inside the browse section on the document. The list item for now should just contain the title of the movie.

Check out [Vue.js list rendering](https://vuejs.org/v2/guide/list.html) if you're unsure how to tackle this.

Ultimately, you should be generating HTML that looks something like this:

```html
<ul>
  <li>
    <p>The Night Before Christmas</p>
  <li>
  <li>
    <p>The Morning After Christmas</p>
  </li>
  <li>
    <p>Eyes Wide Shut</p>
  </li>
  ...
</ul>
```

##### 4. Each browse list item should contain a button

Once you have list items displaying the titles of all the movies, the next step is to add a button to each item. The button should say "Add to watchlist".

This step should be pretty simple. Just throw another element inside the list item, after the movie title.

##### 5. Create a handler function for when a button is clicked

Once those buttons are showing up, your next task is to make them actually do something. We'll put the instructions for what should happen when a button is clicked into the `methods` portion of your view. The function you'll write needs to take the name of a movie as its only argument and append the name of the movie that was clicked to `this.watchlistItems`.

Because Vue is "reactive", it will notice this change to the data, and update the document to look right.

##### 6. Add click handlers to the buttons

Use `v-on:click` or `@click` (they mean the same thing, one is just shorter) to bind our handler function to each button. Be sure to pass in the name of the movie. Take a look at [Methods in Inline Handlers](https://vuejs.org/v2/guide/events.html#Methods-in-Inline-Handlers) if you get stuck.

##### 7. Insert a list item for each movie on the Watchlist

Now that your buttons are wired up and pushing new movies onto `this.watchlistItems`, the next step is to render those watchlist movies on the screen so the user can see them.

Create a similar `v-for` loop to iterate over `watchlistItems` and create `<li>` tags inside the watchlist `<section>`.

Once you've finished, you should start to see movies appearing on the watchlist whenever you click the buttons!

## Commit and Push on Git

If you run the `git status` command, you should see that you now have *unstaged* changes:

```nohighlight
$ git status
On branch studio1
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   index.html
        modified:   js/flicklist.js

no changes added to commit (use "git add" and/or "git commit -a")
```

We can stage these changes with the `add` command:

```nohighlight
$ git add --all
```

The `--all` adds all (both of) the unstaged files, so you don't have to type them one by one.

If you check your status again now, you should see:

```nohighlight
$ git status
On branch studio1
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        modified:   index.html
        modified:   js/flicklist.js
```

Both files are now staged for committing. Go ahead and make a commit, using the -m flag to remind your future self (and others looking at your code) what changes you made during this commit:

```nohighlight
$ git commit -m "finish FlickList 1 studio"
[studio1 46db232] finish FlickList 1 studio
 2 files changed, 2 insertions(+), 2 deletions(-)
```

The convention is to write your commit messages using the present tense rather than past tense (e.g. "finish" rather than "finished").

If you check your status one more time, you should see this:

```nohighlight
$ git status
On branch studio1
nothing to commit, working directory clean
```

Finally, *push* your changes to your remote repo:

```nohighlight
$ git push origin studio1
Counting objects: 62, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (20/20), done.
Writing objects: 100% (22/22), 2.36 KiB | 0 bytes/s, done.
Total 22 (delta 6), reused 0 (delta 0)
To https://github.com/jharvard/flicklist.git
 * [new branch]      studio1 -> studio1
```

If you go back and revisit github.com/jharvard/flicklist, you should now see your new branch up there! Specifically, near the top-left of the screen, you should see a dropdown menu that says "Branch: master". Click that dropdown and you should see an option for "studio1". Click on that branch, and you should now see the code you just worked on.
