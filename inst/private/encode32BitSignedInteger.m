% https://github.com/firmata/firmata.js/blob/488964da379b137da5ab3e7887161cbf31c60793/packages/firmata-io/lib/firmata.js#L2562
function encoded = encode32BitSignedInteger(data)
  negative = data < 0;

  data = abs(data);

  encoded = [...
    bitand(data, 0x7F),...
    bitand(bitshift(data, -7), 0x7F),...
    bitand(bitshift(data, -14), 0x7F),...
    bitand(bitshift(data, -21), 0x7F),...
    bitand(bitshift(data, -28), 0x07),...
  ];

  if (negative)
    encoded(end) = bitor(encoded(end), 0x08);
  endif
endfunction

%!test
%! in = 1511154012;
%! assert(decode32BitSignedInteger(encode32BitSignedInteger(in)), in);

%!test
%! in = -1511154012;
%! assert(decode32BitSignedInteger(encode32BitSignedInteger(in)), in);