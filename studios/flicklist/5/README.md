---
title: "FlickList 5"
currentMenu: studios
---

In today's (final!) studio, you will add some finishing touches to the project. The changes are mostly cosmetic, but they will require you to refactor a significant chunk of your html and javascript code.

## Demo

Here is a demo of what you are trying to accomplish: [FlickList 5 Demo](http://htmlpreview.github.io/?https://github.com/LaunchCodeEducation/flicklist/blob/636afdd8442225455cef24ea4a8560705a17313c/index.html) (note: I noticed some weird behavior with this demo on Safari, so be sure to open it up in Chrome). Play around with the demo for a minute and get familiar with its features. Also, keep the demo open in a separate window, so you can refer to it while working on the assignment.

Note the following additions since last time:

* The proverbial furniture has been rearranged. The two sections (watchlist and browse) are no longer arranged in side-by-side columns; instead the browse section has moved back to its former home, below the watchlist section.
* The browse section is way different. Rather than displaying all the movies at once inside a list, now only one movie is shown at a time. The user can cycle through movies using a fancy UI "carousel", which displays the movie posters along with buttons for sliding back and forth between movies. Each time the carousel slides, the movie title and description update to reflect the newly active movie whose poster has slid into view.
* The browse section layout uses the Bootstrap grid system, in fact a *nested* grid: At the macro level, the section is split into two columns, and then the column on the left is subdivided into two smaller columns:
	* (A) a column on the left for the movie info and carousel, which is further subdivided into:
		* (A-1) a column on the left for the movie title and overview.
		* (A-2) a column on the right for the carousel and the "Add to Watchlist" button.
	*  (B) a column on the right for the search form.

## Starter Code

Same procedure as usual. Checkout the `studio5` branch:

```nohighlight
$ git checkout studio5
Branch studio5 set up to track remote branch studio5 from upstream.
Switched to a new branch 'studio5'
```

## A Brief Tour

Here's what has changed since last time:

### index.html

The two-column layout has already been removed for you. Notice how the two sections are no longer inside a "row" div, and no longer have class names like "col-md-7", and the "main-content" div no longer has a class of "fluid-container".

There is some additional code in the script at the bottom of the page. More on that later.

### flicklist.js

Nothing new here.

### styles.css

A couple minor changes, not worth talking about.

## Assignment

For this studio, there are some tasks that do not explicitly have TODO comments in the source code (it would be too messy / ambiguous as to where to place the comment). So follow the steps as outlined here:

### 0. API key

You know what to do.

### 1. Rearrange to use Grid

For starters, let's just try to implement this new grid layout in the browse section. In `index.html`, build out the following structure:

```nohighglight
+-----------------------------------------------------------------------------------------------------+
|                                           Browse Section                                            |
| +-----------------------------------------------------------+ +-----------------------------------+ |
| |         Container A (67% width)                           | |          Container B (33%)        | |
| | +------------------------------+ +----------------------+ | |      (header and search form)     | |
| | |     Conainer A-1 (58%)       | | Container A-2 (42%)  | | |                                   | |
| | |                              | |                      | | |                                   | |
| | +------------------------------+ +----------------------+ | |                                   | |
| +-----------------------------------------------------------+ +-----------------------------------+ |
+-----------------------------------------------------------------------------------------------------+
```

This will involve adding some things, moving some things, and deleting some things.

Eventually the poster image carousel will live in Container A-2, and over in Container A-1 we will display the title and overview of the the currently visible movie poster. But for now, just ignore that, and implement this scaffolding.

A few things to point out:

* Note that your search form ("Search by Topic") and header ("Browse Movies") should be placed inside Container B.
* Give Container A-1 an attribute of `id="browse-info"`
* Place A-1 and A-2 inside a Bootstrap [well](http://getbootstrap.com/components/#wells) by wrapping the entire row that holds A-1 and A-2 inside a wrapper div with `class="well"`
* Don't be afraid of breaking what you currently have.
* Google "Bootstrap Grid" if you need a refresher.
* Feel free to "cheat" by opening the Studio Demo in your browser and inspecting its HTML with the dev tools.

### 2. Add Some Dummy Data

Next, let's hard-code some fake content into your HTML page. Later you will delete this and use Vue to render the real content dynamically, but this intermediate step should help clarify how to do that.

In `index.html`, add the following content:

* Inside Container A-1, place an `<h4>` element with the text "Twilight", followed by an `<hr/>`, followed by a fake overview paragraph about Twilight. Make sure your overview paragraph is an accurate description of the plot of the movie... just kidding.
* Inside Container A-2, add a placeholder `<img>` (with an "src" equal to "https://pbs.twimg.com/profile_images/378800000576832113/3e69602eab961fd19b89cc65ea9bd2e8.jpeg"), followed by a button that says "Add to Watchlist" and has an attribute of `id="add-to-watchlist"`.

### 3. Create the Carousel

Now for the fun part: inside Container A-2, create a Bootstrap Carousel. How does one do that? It's essentially just like the other Bootstrap components we've already seen, but more complex, and composed of multiple elements rather than just one. You simply create some elements and wire them up with them the right class and id names and other attributes, and Bootstrap will style everything properly.

Some of the docs will refer to bootstrap making the carousel move automatically. That's what the `data-ride="carousel"` or `$('.carousel').carousel()` bits are doing. We won't be using those pieces. Those both require using Bootstrap's javascript library, and jQuery, which don't play nicely with Vue and the way the rest of the site works.

So we'll use Bootstrap's styling for the carousel, but we'll make it move ourselves instead of using their javascript.

Now it's time to create the carousel. Check out [this Codepen example](https://codepen.io/bgschiller/pen/eLmyWm) (which I made, and which mirrors exactly what you want to do (make sure you expand the "html" window on Codepen so you don't go insane trying to read from a tiny box)), and also [this W3 Schools example](http://www.w3schools.com/bootstrap/bootstrap_carousel.asp) (which has some extra stuff we don't care about, but provides explanations of the various parts, which you should read).

To build your carousel:

1. Find the urls of three or so movie posters. Store them in the `data` portion of your Vue in a new model property. Something like
```
  watchlistItems: [],
  browseItems: [],
  imgs: [
        "https://....jpg",
        "https://....jpg",
        "http://....jpg",
  ],
```
2. In the same section, make another value called `activeIx`, and set it to be 0 initially.
3. Add the `nextImg` and `prevImg` methods. Feel free to copy them from the codepen example.
4. Now that we have the data, we can write the template portion. There's some funky syntax involved in setting the class portion:
```
<li
    v-for="(imgSrc, ix) in imgs"
    :class="{
        'carousel-item': true,
        active: ix == activeIx,
    }"
>
```
The v-for isn't too different from what we've seen. It does include the `ix`, which will be `0, 1, 2, ...`&mdash;the position of each image in the list.

That class syntax looks funny though. Vue allows you to pass a whole object to set a class, which is convenient in cases like this. When an object is given, Vue interprets the keys to be the class names to apply. It will apply them _only if_ the value is `true`. So in the case above, `carousel-item` will be applied to every `<li>`, and `active` will be applied only when `ix == activeIx`.

Finally, add this rule to your `styles.css` file:

```css
#browse-carousel {
	max-width: 300px;
	margin: auto;
}
```

which will ensure that the carousel does not get annoyingly large, and is centered horizontally in its container.

Give your carousel a try, make sure it works.

### 4. Refactor the template

#### 4a. Use the actual movie posters

Now let's fill the carousel with the actual movie poster images. Instead of iterating over our stub `imgs` list, we'll use `browseItems`.

#### 4b. Make a new computed property: activeMovie

We have the `activeIx`, but it would be more convenient to have the _whole_ movie available to use (especially for the next step).

This is exactly what computed properties were designed for! Let's make a new computed property called `activeMovie`. It should have the value of `this.browseItems[this.activeIx]`.

#### 4c. Title and Overview

Next, replace the hard-coded "Twilight" content with the actual title and overview for the currently active movie. Now that you have your computed property, you should be able to access that info using, eg, `activeMovie.overview`

Once you've got this working, your page should update its content whenever the carousel slides!

#### 4d. Revive the "Add to Watchlist" Button

Previously we created a new button for each browse item, but now we just have one permanent button which you have already added to the HTML page. But that button doesn't work and is ugly. Bring it back to life!

Remember, it should call the `addToWatchlist` function. This time, we know it will always pass along `activeMovie`, instead of a different movie for each button.

It should also be disabled if the movie has already been added to the watchlist. I can think of a couple ways to do this. One of them is more similar to our code from last time (something like `watchlistItems.includes(movie)`), and the other one pushes that code into a computed property.

### 5. CSS

The last step is to add some CSS and make everything look tidy. No guidance on this one! You got this. Just compare your version to the demo and rig up some CSS rules to make it work.

One hint, regarding your carousel: remember that a `<ul>`, by default, has some padding on the left side.

## Commit and Push on Git

When you have finished (or class ends), commit your changes on Git and push them up to your remote repo on Github.

If you run the `git status` command, you should see that you now have *unstaged* changes:

```nohighlight
$ git status
On branch studio5
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   css/styes.css
        modified:   index.html
        modified:   js/flicklist.js

no changes added to commit (use "git add" and/or "git commit -a")
```

We can stage these changes with the `add` command:

```nohighlight
$ git add --all
```

The `--all` adds all of the unstaged files, so you don't have to type them one by one.

If you check your status again now, you should see:

```nohighlight
$ git status
On branch studio5
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)
        modified:   css/styes.css
        modified:   index.html
        modified:   js/flicklist.js
```

All the files are now staged for committing. Go ahead and make a commit, using the -m flag to remind your future self (and others looking at your code) what changes you made during this commit:

```nohighlight
$ git commit -m "finish FlickList 5 studio"
[studio2 46db232] finish FlickList 5 studio
 2 files changed, 2 insertions(+), 2 deletions(-)
```

The convention is to write your commit messages using the present tense rather than past tense (e.g. "finish" rather than "finished").

If you check your status one more time, you should see this:

```nohighlight
$ git status
On branch studio5
nothing to commit, working directory clean
```

Finally, *push* your changes to your remote repo:

```nohighlight
$ git push origin studio5
Counting objects: 62, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (20/20), done.
Writing objects: 100% (22/22), 2.36 KiB | 0 bytes/s, done.
Total 22 (delta 6), reused 0 (delta 0)
To https://github.com/jharvard/flicklist.git
 * [new branch]      studio5 -> studio5
```

If you go back and revisit github.com/jharvard/flicklist, you should now see your new branch up there! Specificially, near the top-left of the screen, you should see a dropdown menu that says "Branch: master". Click that dropdown and you should see an option for "studio2". Click on that branch, and you should now see the code you just worked on.

## Bonus: Publish your Work using Github Pages!

Lastly, let's put your work on display so you can show it off! Github has a feature called Github Pages, which makes it really easy to host your front-end projects on the real, live internet. You simply need to give your repository a branch with with the special name `gh-pages`. When Github sees a branch with this name, it will host the branch's content online for free.

Let's do that now. First, create the new branch locally:

```nohighlight
$ git checkout -b gh-pages
Switched to a new branch 'gh-pages'
```
The `-b` flag creates a *new* local branch from your current one (whereas previously you have only been checking out preexisting branches that we provided).

Now we want to push this branch up to your remote repository. There is one slight complication, which is that when you forked our LaunchCodeEducation/flicklist repo back in Studio 0, your fork also received all of our branches, including our own gh-pages branch. So your remote in fact already has a (out of date) gh-pages branch. So first, delete that one:

```nohighlight
$ git push --delete origin gh-pages
To https://github.com/jharvard/flicklist.git
 - [deleted]         gh-pages
```

and now you can then push this local one:

```nohighlight
$ git push origin gh-pages
Counting objects: 5, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 686 bytes | 0 bytes/s, done.
Total 5 (delta 1), reused 0 (delta 0)
To https://github.com/jharvard/flicklist.git
 * [new branch]      gh-pages -> gh-pages
```

Now you (or anyone) can view your project! Just visit this url `http://bobthebuilder.github.io/flicklist` (where `bobthebuilder` is your username).
