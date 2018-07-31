---
title: "Mario 5"
currentMenu: studios
---

Today you won't be adding any new features to the project. Instead you will refactor the existing codebase to use Vue.js instead of "vanilla" Javascript for manipulating the DOM.

## Obtaining the Starter Code

1. Navigate into your `mario-js` directory.

2. Make sure you do not have any uncommitted changes:

    ```nohighlight
    $ git status
    On branch mario4
    Your branch is ahead of 'origin/mario4' by 1 commit.
      (use "git push" to publish your local commits)
    nothing to commit, working directory clean
    ```
    It should say "working directory clean".

    If you *do* have uncommitted changes, then `add` and `commit` them now.

3. Switch to the `mario5` branch:

    ```nohighlight
    $ git checkout mario5
    Switched to branch 'mario5'
    Your branch is up-to-date with 'origin/mario5'.
    ```

4. Pull down the latest changes.

    ```nohighlight
    $ git pull
    Already up-to-date.
    ```

    Sometimes, the staff might make last-minute changes to the starter-code. Running `git pull` here ensures that you will have the **very latest** version of the `mario3` branch.

    Usually you will just see:

    ```nohighlight
    Already up-to-date.
    ```

    But in the event that we **did** make some changes after your initial `git clone` on the first day of class, running `git pull` now pulls down those changes, and you will see a different message outlining the changes.


## Take a Look

#### Preview

If you open up the page in a browser, you will see that it looks the same as last time, but it doesn't function anymore. You can type in the textbox, but nothing happens when you submit the form. That's because we have started the refactoring process, and left some gaps for you to fill in.

#### Code Changes

Let's look over the code. Notice the following changes:

- At the bottom of `mario.html`, we have an additional `<script>` tag right before the one that loads `mario.js`. This script imports the Vue.js library so that we can use Vue's methods in our own code.

- We have refactored the code to (partially) use Vue syntax:

	- `pyramidRows`, instead of directly modifying the DOM, now returns a list of strings: one for each row.

	- We ripped most of the page out of html, and made it a view template

    - The "Draw a pyramid" button uses Vue's `@click="clearAndRedraw"` instead of `addEventListener`.

	- Vue will give the height input a class if `this.error` is set (that's what the `:class="error ? 'invalid-field': null"` bit is doing).


## Your Task

Heads up: there's a _lot_ of new things in today's class. If you get stuck, see if you can write down a reason that you're stuck as a google search term. Some examples:

- vue js display value
- vue js input value
- vue js computed property
- vue js for loop

You might also try looking through the [documentation for Vue.js][vue-js-docs], which is quite complete.

Now go ahead and complete the following tasks:

1. Fill out the `checkForErrors` function. It should return an error message if the given `heightStr` value is the empty string, not a number, less than 1, or more than 100. If there are no errors, return `null`.

2. Since the error message from `checkForErrors` is being set in `clearAndRedraw` as `this.error`, it's available in our template. Use the double curly braces (`{{ }}`) to show the error message. Hint: you won't need to refer to `this`, the template assumes that's where your data is stored.

3. Currently the pyramids always have a height of 5, no matter what the user types. Let's fix that. Inside the template, add a `v-model` directive so that the input is kept in sync with `heightStr`.

4. Computed properties are functions on your view's data that are kept up-to-date. They're called whenever the data changes, but otherwise cached. Create a new computed property called `error` that it returns the result of `checkForErrors(this.heightStr)`. Also, delete the `error` entry in `data:` and the update in `clearAndRedraw`.

5. Fill out the other computed property, `rows`. It should return the result of calling `pyramidRows` on `this.height`. Use your new computed property towards the bottom of `clearAndRedraw`.

6. Now we get to the good stuff! We're going to get to remove that ugly direct DOM manipulation code (almost all of `clearAndRedraw`). Instead, we'll use a nice declarative template. Inside the `#pyramid` div in the template, add the following:

```html
<p v-for="row in rows" v-html="row" />
```

This says "make a `<p>` for each entry in rows. Each p's `.innerHTML` should be set to the value of `row`.

7. Delete all the DOM manipulation code from `clearAndRedraw`. It should just look like this:

```js
// Stop the form from causing a page refresh.
evt.preventDefault();

if (this.error) {
    // Stop drawing, we've got errors.
    return;
}

this.height = parseInt(this.heightStr);
```

## Committing Your Changes

1. Add your new changes:

    ```nohighlight
    $ git add mario.js
    ```

2. Then commit, along with a descriptive message.

    ```nohighlight
    $ git commit -m "refactor to use Vue.js"
    ```

[vue-js-docs]: https://vuejs.org/v2/guide/