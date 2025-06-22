# 04 - Labels in a workspace

Labels are used in Bazel to identify a target and though you may haven't noticed it, you have been using them all along! In the previous exercises you had to add sources to rules or even wire up dependencies by their name. Those were all labels. Having said so, that was possibly the best case scenario, labels of targets in the same package are just the target name. So you basically have 3 cases:
- a file name for sources or generated outputs within the root directory of a package (remember: a package is any directory with a `BUILD.bazel` file)
- the path of a source file or generated output nested inside directories that are part of the package, but not packages themselves (basically, any directory within a package without its own `BUILD.bazel`)
- the name of a rule target. In this case we usually prefix the target with ':'. This is just a convention that helps users recognize whether a target is a rule or a file at a first glance, but both forms are valid

But what if you need to reference a target that is in a different package? Well, for that we'll need to extend labels a bit and incorporate the package. The package name can be thought of as the path from the root of the project to the package itself. The root of a workspace is identified with '//' so every target within a workspace will start with a double slash. The separator in a package is *always* '//' regardless of the operating system you're running Bazel on.

Let's look at a few examples then. Say you have the following structure:

```
my_project
\_BUILD.bazel
    src
    \_BUILD.bazel
    app.js
    \_testdata
        \_fakedata.json
    \_utils
        \_BUILD.bazel
            util.js
\_data
    \_data.json    
```

Then the source files will have the following labels:
- app.js -> `//src:app.js`
- util.js -> `//src/utils:util.js`
- data.json -> `//:data/data.json` (data is not a package because there isn't a `BUILD.bazel`)
- fakedata.json -> `//src:testdata/fakedata.json` (this shows how packages differ from directory trees. Unlike utils this isn't a separate package)

There is a lot more to learn about labels, but it requires understanding how Bazel handles other repositories than the current one. If you're curious and would like to skip ahead, you can read [Bazel's documentation about labels](https://bazel.build/concepts/labels). 

# Deps attribute

When a rule needs to depend on other rules, the convention is to do so via an attribute called `deps`, which is an array of labels. Again, like with `srcs` and `data` this is just a convention, but there is no particular meaning to any of these attributes as far as Bazel is concerned. 

# Using labels in commands

Labels are not only useful within builds but can also be used in conjunction with multiple bazel commands. For example, every time you've been running `bazel test //exercises:<lesson_name>_test` the last part was the label of the test associated with each lesson. This same approach can be used with `build`, `run` and as part of more complex commands like query. The target in `test` and `build` isn't actually just a target, but rather a list of target patterns, which allows you to match multiple targets the same way that globs match files. If you're curious about target patterns you can read the [following docs](https://bazel.build/run/build#specifying-build-targets).