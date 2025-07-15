---
target: //exercises:07_visibility_test
---
# 07 - Visibility

Bazel allows you to declare visibility for targets (target visibility) and bzl files (load visibility) in order to restrict who can access certain targets, sources and rules. Visibility is expressed as a list of labels that can be applied to:
- each package by using `package(default_visibility = ["//other_package:__pkg__"])`. If empty, the default_visibility is private
- each target via the `visibility` attribute. The default is the default_visibility of the package
- each bzl file via `visibility(["//other_package/..."])`. By default they are public
- sources can also be made visible in a package by using [exports_files](https://bazel.build/reference/be/functions#exports_files) and their visibility changed via the `visibility` attribute. By default they are public

So, what kind of constraints can we apply?
- `//visibility:public` makes the target accessible from anywhere in the build
- `//visibility:private` restrict a target to its own package
- `//foo/bar:__pkg__` makes a target accessible to the package "//foo/bar" and all its targets but not the subpackages
- `//foo/bar:__subpackages__` same as `__pkg__` but extended to all the subpackages
- `//foo/bar:pkg_group` gives access to all the targets that are part of the package_group referred to. Package group themselves are always public and lack a mechanism to change visibility

There are some nuances that we won't be mentioning to keep this content more easily digestible, so make sure to read [the upstream docs](https://bazel.build/concepts/visibility) if in doubt!