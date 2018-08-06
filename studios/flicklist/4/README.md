---
title: "FlickList 4"
currentMenu: studios
---

Today we will make only a few changes, but they are tricky changes.

## Demo

Here is a demo of what you are trying to accomplish: [FlickList 4 Demo](http://htmlpreview.github.io/?https://github.com/LaunchCodeEducation/flicklist/blob/aa417bf89d29552d0e825605e99dd5dc1fb8e077/index.html). Play around with the demo for a minute and get familiar with its features. Also, keep the demo open in a separate window, so you can refer to it while working on the assignment.

Looks the same as last time! But if you have a sharp eye, you might have noticed one difference: the text of the search button has changed from "Search by Title" to "Search by Topic". And indeed, the underlying functionality has changed as well. Say, for example, you wanted to browse for some vampire movies. In the [prevous version](http://htmlpreview.github.io/?https://github.com/LaunchCodeEducation/flicklist/blob/b19ea10df9355f8079047e8b1f48e0a8e31a2ba9/index.html), you could try searching for "vampire", but you would only get results that literally had the word "vampire" in the title. That means no Twilight!! The new version will return any movies that prominently feature vampires, regardless of whether the word appears in the title or not.

## The API

So what are we doing differently under the hood to allow this new Search functionality? We are interacting with TheMovieDB's API a little differently than before.

### Read the Docs

Let's dive into this by interacting more deeply with the API documentation.

Up till now, we have been sending a request to their [/search/movie](https://developers.themoviedb.org/3/search/search-movies) endpoint, which you can see from the documentation (click that link above), is described as allowing you to "Search for movies by title."

Great, so is there a different search endpoint that allows you to, say, "search for movies by topic"?

Not exactly. But the <a href="https://developers.themoviedb.org/3/discover">/discover/movie</a> endpoint does have an "optional parameter" that seems promising. Take a minute now, and browse quickly through that long list of optional parameters and see if you can spot it.

Did you find it?

The `with_keywords` parameter is described as such:

> "Only include movies with the specified keywords. Expected value is an integer (the id of a keyword). Multiple values can be specified. Comma separated indicates an 'AND' query, while a pipe (|) separated value indicates an 'OR'."

This cryptic explanation is telling us that with the "Discover" endpoint, we can attach a parameter to our request specifying a "keyword" (or a list of multiple keywords). The results we receive back will be filtered so that we only get movies that are tagged with the specified keyword(s).

Perfect! But unfortunately, the way we go about doing this is not so simple as merely adding a key/value pair like so:

```nohighlight
with_keywords: "vampire"
```

Rather than the keyword itself, the "expected value is an integer (the id of a keyword)". So if we want to search for "vampire", we actually need to pass in an **id number** like, say 954782, which is the official magic id number for the keyword "vampire".

How the heck do we find that id number? There's a different endpoint set up specifically for this purpose: the <a href="https://developers.themoviedb.org/3/search/search-keywords">/search/keyword</a> endpoint allows you to "search for keywords by name".

Let's try one of these keyword searches. Notice that in the right-hand sidebar on the docs page, is an interactive console via which you can make calls to the API. If you click the green "Call Resource" button, it will make the call. Try it now.

You should receive a response like this:

```nohighlight
{
  "status_code": 7,
  "status_message": "Invalid API key: You must be granted a valid key."
}
```
Just like in our code, the call won't be successful unless we provide our API key as a parameter. In fact, you can see from the docs that this endpoint has two required parameters:
* `api_key`
* `query`

Go ahead and add those two parameters by clicking, above the green button, the text that says "Add a new header". Paste in your api key as the value for the `api_key` key, and the word "vampire" as the value for the `query` key. Then try clicking again. You should hopefully now see a response containing some "keyword" objects, where each object has a "name" and "id". The id looks like the magic number we need!

Now we can go back and try the Discover endpoint again, using keyword ids.

Try hitting up /discover/movie, including with the following extra parameters:

```nohighlight
api_key: 123456789 (insert your api key here)
with_keywords 192305|210090|210092|210093
```

Those numbers above are a handful of ids associated with "vampire". The pipe character "|" in between them specifes that we are treating this as an "Or" scenario: we want results that have at least one of the associated ids-- in other words, we don't require that a movie has all of the keywords.

With this request, you should get back some movie objects with vampire-related movies!

So the overall proccess was:
1. Get the keyword IDs for the search term
2. Include those keywords in a request to Discover

## Obtaining the Starter Code

Same procedure as usual. Just checkout the `studio4` branch:

```nohighlight
$ git checkout -b studio4 upstream/studio4
Branch studio4 set up to track remote branch studio4 from upstream.
Switched to a new branch 'studio4'
```

## A Brief Tour

There are only a few minor changes since last time, in just the `flicklist.js` file.

First, notice that the `searchMovies` function has a bunch of TODOs, and its `success` callback no longer has any code (aside from a `console.log` statement).

## Assignment

Work your way through the TODOs in the source code. The tasks are numbered. You should work on them in the order prescribed, as follows:

### 0. API key

As usual, add your api key to the object near the top of `flicklist.js`.

### 1. Add A second argument to the `discoverMovies` function.

In the `discoverMovies` function, we now want to specify keywords in our request. Before we can do that, we need to accept an argument so that the caller of the function can decide what those keywords are. Add an argument called `keywords` in the function declaration.

### 2. Include Keywords in Discover Request

Now that the `discoverMovies` function knows what keywords to use, the next task is to use them. When you make the AJAX request to the API, include these keywords. The `data` object is where you can specify additional things about the request.

When you think you're done, verify that this is working by doing a little test:

Open up the developer tools and navigate to the Console tab. Notice that you can click on the console and start typing. The console, in addition to displaying your `console.log` statements, also allows you to test code snippets and see the results.
Type the following line:

```js
flicklistView.discoverMovies("3133|185633|3630|7010");
```

and press enter. If all goes well, you should see your browse list reload with some Vampire flicks!

### 3. Change Url of Search Request

Now that `discoverMovies` is working, let's fix `searchMovies`. This function's job is going to change now. Rather than grab a bunch of movies directly from the API, our search function will simply request those keyword IDs from the API. Once the keyword IDs come back, we will invoke `discoverMovies` and pass the keywords along as an argument.

The first step is to change the url so that we are talking to a different endpoint. Instead of the `/movie` service, we want the one that handles requests for keywords.

Verify that your code is working correctly by entering a search term and submitting the form, and then opening up the console. The `success` callback contains this line:

```js
console.log(response);
```

so the response should show up in the console once you submit the form.

Poke around inside the object and you should see `.results` property like usual, but unlike previous responses, this array of results should not contain objects representing movies. Istead it should contain objects representing "keywords".

### 4. Handle Search Response by Invoking Discover

Now that your search function is receiving keywords, the next step is to do something with those keywords. Basically, you want to collect those keywords into a string, and then pass that string over to `discoverMovies` and let it work its magic, taking advantage of the work you've already done over there.

### 4a. Get an Array of IDs

So we have an array of keywords inside that that `response` object, but notice that each keyword object contains two properties: a `.id`, representing the id number, and a `.name`, representing the actual search term. In this case we don't care about the name, we just want the pure ids. This is the prefect chance to use the array [map](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map) function, which lets you create a new array from an old one by "mapping" each of its elements to something else. Use the `map` function to convert `response.results` into an array of ids, and store the result in a variable called `keywordIDs`.

#### 4b. Convert the Array to a String

So now we have an array of ids. But ultimately what we want is a *string* containing those ids. Specifically, the API specifies that we need a string in which the id numbers are interleaved with either commas or pipe `"|"` characters, e.g. `"3133,185633,3630,7010"` or `"3133|185633|3630|7010"`.

There is a quick, fancy way of producing this string: a magic array method called `join`, which does exactly what we want: creates a string with each element of the array, separated by commas or some other string. Check out the [documentation for the join function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join).

Use the join function to create a variable called `keywordsString` whose value is the string we are trying to produce.

#### 4c. Use an "Or" String Instead of an "And" String

Rather than a comma-separated string, we want to insert a pipe character in between the ids. the secret to accomplishing this is that although the `join` function uses a comma character as the default content to intersperse between the elements, `join` also accepts an optional argument, where you can specify some other custom string.

Go ahead and change your call to `join` to take advantage of this.

#### 4d. Invoke Discover

Finally, invoke the `discoverMovies` function! Pass along the string holding the keywords, which you constructed above.

Confirm that everything is working by opening your page in the browser and searching for some topics! You should see relevant movies (regardless of title) appear in the browse list.

### 5. Change Button Text

This last step is very easy. Our search button needs an update! Change the text from "Search by Title" to "Search by Topic"

## Commit and Push on Git

When you are finished (or the work period has ended), commit your changes on Git and push them up to your remote repo.

If you run the `git status` command, you should see that you now have *unstaged* changes:

```nohighlight
$ git status
On branch studio4
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

The `--all` adds all of the unstaged files, so you don't have to type them one by one.

If you check your status again now, you should see:

```nohighlight
$ git status
On branch studio4
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)
        modified:   index.html
        modified:   js/flicklist.js
```

All the files are now staged for committing. Go ahead and make a commit, using the -m flag to remind your future self (and others looking at your code) what changes you made during this commit:

```nohighlight
$ git commit -m "finish FlickList 4 studio"
[studio2 46db232] finish FlickList 4 studio
 2 files changed, 2 insertions(+), 2 deletions(-)
```

The convention is to write your commit messages using the present tense rather than past tense (e.g. "finish" rather than "finished").

If you check your status one more time, you should see this:

```nohighlight
$ git status
On branch studio4
nothing to commit, working directory clean
```

Finally, *push* your changes to your remote repo:

```nohighlight
$ git push origin studio4
Counting objects: 62, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (20/20), done.
Writing objects: 100% (22/22), 2.36 KiB | 0 bytes/s, done.
Total 22 (delta 6), reused 0 (delta 0)
To https://github.com/jharvard/flicklist.git
 * [new branch]      studio4 -> studio4
```

If you go back and revisit github.com/jharvard/flicklist, you should now see your new branch up there! Specificially, near the top-left of the screen, you should see a dropdown menu that says "Branch: master". Click that dropdown and you should see an option for "studio4". Click on that branch, and you should now see the code you just worked on.
