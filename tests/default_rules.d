module tests.default_rules;

import reggae;
import unit_threaded;

void testNoDefaultRule() {
    "doStuff foo=bar".getDefaultRule.shouldThrow!Exception;
    "_foo foo=bar".getDefaultRule.shouldThrow!Exception;
}

void testGetDefaultRule() {
    "_dcompile foo=bar".getDefaultRule.shouldEqual("_dcompile");
    "_ccompile foo=bar".getDefaultRule.shouldEqual("_ccompile");
    "_cppcompile foo=bar".getDefaultRule.shouldEqual("_cppcompile");
    "_dlink foo=bar".getDefaultRule.shouldEqual("_dlink");
}

void testGetDefaultRuleParams() {
    immutable command = "_dcompile foo=bar includes=boo,looloo,bearhugs";
    command.getDefaultRuleParams("foo").shouldEqual(["bar"]);
    command.getDefaultRuleParams("includes").shouldEqual(["boo", "looloo", "bearhugs"]);
    command.getDefaultRuleParams("nonexistent").shouldThrow!Exception;

    "_madeup includes=boo,bar".getDefaultRuleParams("includes").shouldThrow!Exception;
}
