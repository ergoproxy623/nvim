
(call_expression
  function: (identifier) @signal_func (#eq? @signal_func "signal")
  arguments: (arguments
    (number) @signal_value)
) @signal_definition

(call_expression
  function: (identifier) @effect_func (#eq? @effect_func "effect")
) @signal_effect
