% example of using arduino stepper

pkg load instrument-control;

% Leonardo (CDC - ttyACMX)
ard = findArduino('ttyACM');

stepperID = 1;

function moveWait(ard, stepperID, steps)
  % enableStepper
  ard.enableStepper(stepperID);
  pause(0.01);
  ard.relMoveTo(stepperID, steps);
  % waiting for move to finish
  while true
    [position, reportedStepperID] = ard.checkMoveComplete();
    if ~isempty(position) && reportedStepperID == stepperID
      printf("AccelStepper %d - position: %d\n", stepperID, position);
      return;
    endif
    % next try
    pause(0.1);
  endwhile

  % disable
  ard.disableStepper(stepperID);
endfunction


% stepper 0 init
ard.initStepperType4(1, 5, 2, 4, 3);
ard.setSpeed(1, 500);
% 0 accel = acceleration off
ard.setAccel(1, 0);


ard.initStepperType4(2, 19, 6, 8, 7);
ard.setSpeed(2, 500);
% 0 accel = acceleration off
ard.setAccel(2, 0);


ard.enableStepper(1);
ard.relMoveTo(1, 10000);


ard.enableStepper(2);
ard.relMoveTo(2, 10000);


ard.disableStepper(2);
ard.disableStepper(1);