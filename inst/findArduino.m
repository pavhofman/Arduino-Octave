% finding arduino with proper Firmata firmware. Returns empty array if nothing found
% portPrefix limits the search (e.g. 'ttyACM' searches only CDC ports - Arduino Leonardo)
function ard = findArduino(portPrefix = '')
  ard = [];
  % all serial ports in system
  ports = seriallist();
  % filtering ports starting with portPrefix
  if ~isempty(portPrefix)
    ports = ports(strncmp(portPrefix, ports, length(portPrefix)));
  endif
  
  for idx = 1:length(ports)
    port = ports{idx};
    % trying to create arduino
    try
      ard = arduino(strcat('/dev/', port));
      % found, returning
      return;
    catch
    end_try_catch
  endfor
  error("No arduino found");
endfunction
