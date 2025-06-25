# Extending Bazel - starlark and legacy macros

We've seen how to create a basic build, with libraries, binaries and tests. We've seen how to create multiple packages and make targets in one package refer to targets in a different package via labels.

That's great, but sometimes you really need more than the rules Bazel gives you out of the box. This will be a running topic throughout this course. For now, we'll look into the symplest way of doing that by looking at `legacy macros`. Yeah, the term legacy sounds very scary and normally you wouldn't expect to learn something legacy in a course. However, this is such a simple, useful and widespread mechanism that it has a lot of value for begineers and is likely not going away from real codebases anytime soon. If you want to know why this approach is considered legacy, you should read [this document](https://bazel.build/extending/legacy-macros#no-legacy-macros). In the meantime though, let's focus on why you should learn them!

## Starlak and declarative BUILD files

Up until now, we've looked at BUILD files without truly understanding the language behind. The exercises were simple enough to allow that, but as we extend the build system we need to dig deeper and understand what's going on. Bazel is configured via a language called [starlark](https://github.com/bazelbuild/starlark/tree/master). It's heavily inspired by python and in most cases almost identical, however it has some minor differences. First of all it removes all kinds of unbounded loops and recursion to ensure that build scripts can terminate.

Imports in starlark are replaced by the load function. The first parameter of this function is a path and the rest of the arguments are the symbols to import. If the symbols are prefixed by `name=` then they will instead be assigned to that name. That's how we will be able import functionalities from shared rules.

One crucial feature of how Bazel uses starlark is that in `BUILD.bazel` and `MODULE.bazel` you really don't get access to the whole language, but only a declarative subset of it. The goal of this approach was to keep build scripts readable and move reusable components to separate files, usually with the extension `.bzl` (not `.bazel`!). So you can call a function, assign values to a variable and do list/dict comprehensions, but you can't have loops, conditionals or declare functions.

## Legacy macros

So, finally, how can you write a macro and why would you do it in the first place? Well, the why could be to group a set of rules together and simplify how users can use them. Think about a macro called `cc_binary_and_test` that takes all the C++ sources, splits them between test and non-test based on the filenames and instantiate both rules. Sometimes macros are used to setup complex defaults for rules that require some amount of logic that cannot normally be expressed with how rules are declared. And finally they can be a very effective tool to quickly create/prototype simple rules. Just don't rely too much on them as they can pollute your build over time and later on we will see why.

Now that we know the why we can look at the how. And that's surprisingly simple as legacy macros are just functions. Let's look at an example:

```py
# macro.bzl

def my_macro(name, srcs, test_srcs):
    my_binary(name=name, srcs=srcs)
    my_test(name=name + "_test", srcs=test_srcs)
```

and 

```py
# BUILD.bazel

load("macro.bzl", "my_macro")

my_macro(
    name = "my_project",
    srcs = glob(["*.my"], excludes=["*_test.my"]),
    test_srcs = glob(["*_test.my"]),
)

# which generates the following:
#     my_binary(
#         name="my_project", 
#         srcs=glob(["*.my"], excludes=["*_test.my"]),
#     )
#     my_test(
#         name="my_project_test", 
#         srcs=glob(["*_test.my"]),
#     )
```