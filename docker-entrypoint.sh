#!/bin/bash
PFLOTRAN_UID=$(stat -c '%u' ./)
getent passwd $PFLOTRAN_UID
if [ $? -ne 0 ] 
then
  useradd pflotran_$PFLOTRAN_UID -u $PFLOTRAN_UID
fi
PFLOTRAN_CMD=pflotran


if [ ! -z "$NUM_PROCESSES" ] 
then 
  PFLOTRAN_CMD="mpirun -np $NUM_PROCESSES pflotran"
fi
echo "$PFLOTRAN_CMD"
sleep 10

sudo -u \#$PFLOTRAN_UID $PFLOTRAN_CMD $@
