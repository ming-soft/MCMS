#!/bin/sh
PIDS=$(ps -ef | awk '/ms-mcms\.jar/ && !/awk/ {print $2}')

if [ -z "$PIDS" ]; then
    echo "ms-mcms.jar is not running."
    exit 0
fi

echo "Stopping ms-mcms.jar (PID: $PIDS)..."
kill $PIDS

i=0
while [ "$i" -lt 10 ]; do
    REMAINING=$(ps -ef | awk '/ms-mcms\.jar/ && !/awk/ {print $2}')
    if [ -z "$REMAINING" ]; then
        echo "ms-mcms.jar stopped."
        exit 0
    fi
    sleep 1
    i=$((i + 1))
done

echo "Graceful shutdown timed out, force killing (PID: $REMAINING)..."
kill -9 $REMAINING
