---
target: //exercises:02_basic_cc_test_test
---
# 02 - Basic test using cc_test

Based on what you learned in the previous exercise, try creating a test using [cc_test](https://bazel.build/reference/be/c-cpp#cc_test). This time `BUILD.bazel` will be completely empty, good luck!

## How do tests work in Bazel

Bazel has an interesting approach to testing. Tests are in fact executables like the ones you create with *_binary rules, but are invoked by bazel when you run `bazel test :some_target`. Bazel determins the test's success based on its exit code. Furthermore, test rules provide deeper integrations with testing frameworks/libraries for each specific language that allow more advanced usage patterns and avoid each user from having to rewrite the whole test infrastructure. Writing test rules can be a really difficult task and there are a plethora of interesting options and optimizations Bazel experts make use of to make the experience as fast and easy as possible. We will cover that later as it's quite an advanced topic. For now, you can read about [some tips & tricks to make testing with Bazel easier](https://blog.engflow.com/2023/09/18/bazel-testing-tips/)!