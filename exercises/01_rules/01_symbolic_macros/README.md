---
target: //exercises:01_symbolic_macros_test
---
# 01 - Symbolic macros

Symbolic macros are the newer approach to macros in Bazel. I won't be going into why you should be using symbolic macros here, but you can read the [upstream documentation about it](https://bazel.build/extending/legacy-macros#no-legacy-macros). Symbolic macros are very similar to legacy macros as in they are very simple starlark functions used to instantiate groups of 1 or more targets in a more convenient way. They aren't a way to build complex logic though, in which case you're better off using rules, which we'll explain soon after.

The main difference is that you can't use the function itself, but rather you need to use the result returned from invoking the `macro` function. This is a rather common pattern within bazel and it's used with rules, aspects, repository rules and module extensions as well. In fact, there are some similarties between all of these types of functionalities.

## The anatomy of a symbolic macro

```py
def _symbolic_macro_impl(name, visibility, some_attribute, **kwargs):
    # ... instantiate 1+ targets
    pass

symbolic_macro = macro(
    doc = "Docstring describing the macro",
    implementation = _symbolic_macro_impl,
    attrs = {
        "some_attribute": attr.string(),
    },
)
```

This very simple macro already shows a few things:
- Each and every symbolic macro has a `name` and `visibility` attribute. Unlike in legacy macros, both attributes are mandatory
- The macro attribute `attrs` is used to define the additional attributes of a macro and their type
- The macro attribute `doc` is used to document what a macro does
- The macro attribute `implementation` refers to the underlying macro function that implements the macro's logic
- Implementations are usually called something like `_macro_name_impl`. The underscore at the beginning implies that the function is private in this module and `_impl` that it's the underlying implementation of a `macro` or a `rule` or any similar object. This isn't a rule enforced by Bazel, but rather a naming convention.

## Attributes

Attributes in a macro and in similar abstractions like rules are key-value pairs that can be used when invoking said object in a build. They are defined using the `attr` module, which allows to create various types like `string`, `label`, lists and many others. When declaring attributes one can define default values, docs, whether labels pointed at by the attributes can be files, executables, and much more! Make sure to read the [upstream documentation](https://bazel.build/rules/lib/toplevel/attr)!

Labels are one of the most interesting attributes, as they look like string, but they go through additional validation and have unique semantics which we've already explained. Labels can be instantiated by invoking the `Label` function passing a label string, but when an attribute is declared as a label type, then Bazel will do that conversion automatically, which saves a few keystrokes!

One rather unique feature about symbolic macros is that you can inherit another symbol's attribute list by passing it to the `inherit_attrs` when instantiating `macro`. If you want to get rid of one or more inherited attributes you only need to set said attributes' keys in `attrs` and set their respective values to `null`.