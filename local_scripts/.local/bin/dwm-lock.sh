#!/bin/sh

xautolock -time 15 -locker slock \
    -notify 30 -notifier "notify-send 'Locking Screen' 'Screen will lock in 30 seconds'" -u critical \
    -killtime 10 \
    -killer "loginctl suspend"

