---
target: //exercises:03_sharing_code_with_libraries_test
---
# Sharing code with libraries

Sometimes, we don't want to rewrite code over and over again and we try to reuse the same building blocks in multiple places. When this happens you can resort to libraries, which in Bazel are usually rules called *_library. In this scenario you want to create a library shared by both test and binary. Be careful, in the C++ rules there might be a separate attribute for header sources, so read the [docs](https://bazel.build/reference/be/c-cpp#cc_library) carefully!

It's important to point out that library here does not refer to a shared library or a static library, but rather a set of intermediate artifacts that Bazel produces that allow reusing code, builds and metadata across other rules. The outputs of library rules may still be traditional library files, but what's important is that they aren't meant to be distributable artifacts per se. Instead if what you want is a library file you should use [cc_shared_library](https://bazel.build/reference/be/c-cpp#cc_shared_library) and [cc_static_library](https://bazel.build/reference/be/c-cpp#cc_static_library) respectively. This will be more clear later when we explain how to build custom rules!