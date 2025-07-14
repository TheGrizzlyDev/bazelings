---
target: //exercises:05_grouping_and_matching_files_test
---
# Grouping and matching files

In the previous examples we've had to manually include lots and lots of files individually every time. This doesn't need to be the case though as bazel offers a useful `glob` function. The first parameter of the function is a list of globbing patterns to match against. You can also exclude specific files or directories, which can be useful in many cases like when excluding test cases from other sources. For more informations you can read [the docs](https://bazel.build/reference/be/functions#glob).

Sometimes though you may want to create a group of file that can be used and reused, both within and outside the package they're part of. When that happens you can use [filegroup](https://bazel.build/reference/be/general#filegroup), a very handy rule that allows grouping a bunch of files under a single target. This rule is actually more powerful than what it looks like and later on, when we explore providers and we'll write our own rules, you will learn what else you can do with it.