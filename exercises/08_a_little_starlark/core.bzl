load("@bazel_skylib//lib:unittest.bzl", "unittest", "asserts")

def _lists_and_dictionaries_test(ctx):
    env = unittest.begin(ctx)

    names = ["Bill Board", "Bon Jon Bovi", "Shanda Lear"]
    asserts.equals(env, "Bill Board", names[2])

    ages = {"Luke": 42, "Sky": 89, "Walker": 5}
    asserts.equals(env, 89, ages["Luke"])

    prepend_title = lambda name: "Sir {}" % (name)
    names_with_titles = [
        # invoke `prepend_title` over `names`
    ]
    asserts.equals(env, "Sir Bill Board", names[0])

    drink_from_the_fountain_of_youth = lambda age: max(0, min(18, age - 30))
    ages_after_drinking_from_the_fountain_of_youth = {
        # invoke `drink_from_the_fountain_of_youth` over `ages`
    }
    asserts.equals(env, 12, ages["Luke"])
    asserts.equals(env, 18, ages["Sky"])
    asserts.equals(env, 0, ages["Walker"])

    first_two_names = names
    asserts.equals(env, [names[0], names[1]], first_two_names)

    # using a for loop add the names of all the adults (age >= 18) 
    # the list `ages`. You can use append to add to a list
    adults = []
    asserts.equals(env, ["Luke", "Sky"], adults)

    return unittest.end(ctx)

lists_and_dictionaries_test = unittest.make(_lists_and_dictionaries_test)

def _functions_and_lambdas_test(ctx):
    env = unittest.begin(ctx)

    # Starlark functions have the same syntax as in python.
    # As such you can have named functions:
    def add_two_numbers_fn():
        pass
    asserts.equals(env, 42, add_two_numbers_fn(40, 2))

    # or you can have lambda functions:
    add_two_numbers_lambda = lambda: pass
    asserts.equals(env, 42, add_two_numbers_lambda(40, 2))

    # functions support both named and positional arguments
    # and named arguments can have default values
    def say_hi(salute, who="World"):
        pass
    asserts.equals(env, "Hello, World!", say_hi("Hello"))

    # and you can capture variable arguments using: 
    # - `*args` for positional arguments
    # - `**kwargs` for named arguments
    def say_hi_with_varargs(*args, **kwargs):
        pass
    asserts.equals(env, "Hello, World!", say_hi_with_varargs("Hello", who="World"))

    return unittest.end(ctx)

functions_and_lambdas_test = unittest.make(_functions_and_lambdas_test)


frozen_dict = {"value": 0}

def append_to_frozen_default_argument(frozen_list=[]):
    frozen_list.append(0)
    return frozen_list

def _frozen_values_cannot_mutate_test(ctx):
    env = unittest.begin(ctx)

    # Starlark freezes all top-level elements so that its interpreter
    # can run said functions concurrently without having to worry about
    # any mutation to the state of the module.

    # Scoping the value inside the function makes it mutable again
    asserts.equals(env, 0, frozen_dict["value"])
    frozen_dict["value"] = frozen_dict["value"] + 1
    asserts.equals(env, 1, frozen_dict["value"])
    
    # The same principle is applied to default argument values of top-level functions
    # If `append_to_frozen_default_argument` was a nested function and not a top-level
    # module function then its default values would have not been frozen.
    # To clarify, not every value passed to the function will be frozen, just the 
    # default value of a parameter.
    asserts.equals(env, [0], append_to_frozen_default_argument())
    asserts.equals(env, [0, 0], append_to_frozen_default_argument())

    return unittest.end(ctx)

frozen_values_cannot_mutate_test = unittest.make(_frozen_values_cannot_mutate_test)

# TODO: builtins: https://github.com/bazelbuild/starlark/blob/master/spec.md#built-in-constants-and-functions

def core_test_suite():
    unittest.suite(
        "core_test_suite",
        lists_and_dictionaries_test,
        functions_and_lambdas_test,
        frozen_values_cannot_mutate_test,
    )