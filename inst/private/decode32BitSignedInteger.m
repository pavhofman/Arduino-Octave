% https://github.com/firmata/firmata.js/blob/488964da379b137da5ab3e7887161cbf31c60793/packages/firmata-io/lib/firmata.js#L2582
function result = decode32BitSignedInteger(bytes)
  bytes = int32(bytes);
  result = bitand(bytes(1), 0x7F) + ...
    bitshift(bitand(bytes(2), 0x7F), 7) + ...
    bitshift(bitand(bytes(3), 0x7F), 14) + ...
    bitshift(bitand(bytes(4), 0x7F), 21) + ...
    bitshift(bitand(bytes(5), 0x07), 28);

  if (bitshift(bytes(5), -3))
    result *= -1;
  endif

endfunction

% test in encode32BitSignedInteger