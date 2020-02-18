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
  ard.disable(stepperID);
endfunction


% stepper 0 init
ard.initStepperType4(stepperID, 4, 5, 6, 7);

ard.setSpeed(stepperID, 350);

% 0 accel = acceleration off
ard.setAccel(stepperID, 100);

moveWait(ard, stepperID, 500);
moveWait(ard, stepperID, -500);
