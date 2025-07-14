Spell = provider(fields = {
    "name": "The name of the spell",
    "mana_cost": "The spells mana cost",
})

def _spell_impl(ctx):
    return [
        # return a Spell here
    ]

spell = rule(_spell_impl, attrs = {
    # the name attribute is implicit
    "mana_cost": attr.int(),
})

def _cast_impl(ctx):
    for dep in ctx.attr.deps:
        spell = dep[Spell]
        if spell.name == ctx.attr.spell:
            if spell.mana_cost <= ctx.attr.mana:
                print("🧙 successfully cast: " + spell.name)
                return
            else:
                fail("🧙 not enough mana ")
    fail("🧙 404 - spell not found")

cast = rule(_cast_impl, attrs = {
    "mana": attr.int(),
    "spell": attr.string(),
    "deps": attr.label_list(providers=[Spell]),
})