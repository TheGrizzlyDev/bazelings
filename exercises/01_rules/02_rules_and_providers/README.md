---
target: //exercises:02_rules_and_providers_test
---
# 02 - Rules and providers

Rules are Bazel's main extension mechanism and they allow you to support custom functionality. Rules are declared in a similar way to the symbolic macros we've just looked at, except you invoke the `rule` function instead of `macro`. Similarly to macros, rules have a set of attributes, which are declared in the same fashion (minus the inheritance mechanism).

## Providers

The first thing rules can do is to provide a mechanism to carry metadata across your build graph. Providers are named and optionally-typed structs that rules can return. In fact, every rules can returns as many providers as it wants. Providers can be expected by attributes that accept labels, so that you can tell Bazel that a given attributes only accept labels that provide a specific type of metadata. 

Let's say that you're writing a ruleset for MagicLang. MagicLang looks a lot like python, but it allows you to "sling" spells whenever an incantation is uttered. As such, the rules may need to forward a `SpellsProvider` from `magic_lang_library` that can be used by other `magic_lang_{library, binary, test}` rules so that they too can sling the spells. Said provider may contain a dictionary with the incantations as keys and their effect and mana cost as values. The sky is the limit! This very flexibly and extensible mechanism is at the root of creating and integrating rules. Say that now you want to integrate 2 languages with each other, you can rely on the providers of one as a dependency on the other. This is how various rulesets can provide supply-chain metadata across various rulesets, by using the providers declared in [bazel-contrib/supply-chain](https://github.com/bazel-contrib/supply-chain/tree/main/metadata/providers).

