% https://github.com/firmata/firmata.js/blob/488964da379b137da5ab3e7887161cbf31c60793/packages/firmata-io/lib/firmata.js#L2598
function encoded = encodeCustomFloat(input)
  persistent MAX_SIGNIFICAND = 2^23;

  if (input < 0)
    sign = 1;
  else
    sign = 0;
  endif
  
  if input ~= 0 
    input = abs(input);

    base10 = floor(log10(input));
    % Shift decimal to start of significand
    exponent = 0 + base10;
    
    input /= 10^base10;

    % Shift decimal to the right as far as we can
    while (floor(input) ~= input && input < MAX_SIGNIFICAND)
      exponent -= 1;
      input *= 10;
    endwhile

    % Reduce precision if necessary
    while (input > MAX_SIGNIFICAND)
      exponent += 1;
      input /= 10;
    endwhile

    input = fix(input);
    exponent += 11;
  else
    exponent = 0;
  endif
  

  encoded = [...
    bitand(input, 0x7F),...
    bitand(bitshift(input, -7), 0x7F),...
    bitand(bitshift(input, -14), 0x7F),...
    bitand(bitshift(input, -21), 0x03) + bitshift(bitand(exponent, 0x0F), 2) + bitshift(bitand(sign, 0x01), 6)...
  ];

endfunction


%!test
%! in = 1/60/60;
%! expected = [0x31, 0x45, 0x29, 0x05];
%! assert(encodeCustomFloat(in), expected);

%!test
%! in = 100;
%! expected = [0x01, 0x00, 0x00, 0x34];
%! assert(encodeCustomFloat(in), expected);
