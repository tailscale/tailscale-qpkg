#!/bin/sh
CONF=/etc/config/qpkg.conf
QPKG_NAME="Tailscale"
QPKG_ROOT=`/sbin/getcfg $QPKG_NAME Install_Path -f ${CONF}`
export QNAP_QPKG=$QPKG_NAME
set -e

case "$1" in
  start)
    ENABLED=$(/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f $CONF)
    if [ "$ENABLED" != "TRUE" ]; then
        echo "$QPKG_NAME is disabled."
        exit 1
    fi
    if [ -e $QPKG_ROOT/var/run/tailscale/tailscale.pid ]; then
        echo "$QPKG_NAME is already running."
        exit 0
    fi
    $QPKG_ROOT/tailscaled --port 41641 --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock 2> /var/log/tailscaled.log &
    echo $! > $QPKG_ROOT/var/run/tailscale/tailscale.pid
    ;;

  stop)
    if [ -e $QPKG_ROOT/var/run/tailscale/tailscale.pid ]; then
      ID=$(cat $QPKG_ROOT/var/run/tailscale/tailscale.pid)
      kill -9 $ID || true
      rm -f $QPKG_ROOT/var/run/tailscale/tailscale.pid
    fi
    ;;

  restart)
    $0 stop
    $0 start
    ;;
  remove)
    ;;

  *)
    echo "Usage: $0 {start|stop|restart|remove}"
    exit 1
esac

exit 0
