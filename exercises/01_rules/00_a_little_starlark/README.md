---
target: //exercises:00_a_little_starlark_test
---
# 00 - A little starlark

Most tutorials about Bazel focus first on the rules, helping you understand how to use Bazel in a productive way for most of its users, allowing you to use the build system without understanding much at all. That can be an effective approach. On the contrary, here we will immediately dig into Bazel's guts and get our hands dirty with custom rules. This way you can learn how to build more and more complex rules and understand the effort that goes behind existing rulesets, as well as allow you to learn how to debug someone else's rules.

In the last exercise you were quickly introduced to what starlark is, however it's important to take a moment to dig a bit deeper since you will be writing a whole lot of it!

Starlark provides a really [helpful spec](https://github.com/bazelbuild/starlark/blob/master/spec.md) explaing how the language works as well as what features are available.

## Testing in starlark

One thing that isn't covered by the spec is how code can be tested. In Bazel starlark code can be tested via [the unit testing framework in bazel-skylib](https://github.com/bazelbuild/bazel-skylib/blob/main/docs/unittest_doc.md). Bazel-skylib is one of the foundation rulesets that other rulesets build on top of. It provides all kinds of utilities that aren't part of the core Starlark and Bazel. Bazel-skylib's unit testing framework allows you to test:
- pure starlark functions via the module `unittest`
- analysis phase behaviours via `analysistest`
- loading phase behaviours via `loadingtest`

At this point, we have not introduced the analysis and loading phases, but soon they will become relevant. For now we'll only use `unittest`. Each individual test starts with a call to `unittest.begin` and ends with a call to `unittest.end` and we can use the functions in the `asserts` module to test the behaviour of the function we are testing. The test function in itself though isn't sufficient and is just the implementation of the test but not the actual declaration. For that we need to invoke `unittest.make` and assign it to a variable. This is a common pattern for declaring rules as well and normally we follow the convention of prefixing the implementation with a '_' hinting that it shouldn't be used by itself and is a hidden implementation detail. For this exercise you won't have to write any unit test yourself, but it's good to familiarize yourself with the framework since we will be using it throughout this exercise.

NOTE: In this exercise you should not need to change any assertion directly.