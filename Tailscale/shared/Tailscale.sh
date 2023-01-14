#!/bin/sh
CONF=/etc/config/qpkg.conf
QPKG_NAME="Tailscale"
QPKG_ROOT=`/sbin/getcfg ${QPKG_NAME} Install_Path -f ${CONF}`
export QNAP_QPKG=${QPKG_NAME}
export PIDF=/var/run/tailscaled.pid
set -e

case "$1" in
  start)
    ENABLED=$(/sbin/getcfg ${QPKG_NAME} Enable -u -d FALSE -f ${CONF})
    if [ "${ENABLED}" != "TRUE" ]; then
        echo "${QPKG_NAME} is disabled."
        exit 1
    fi
    mkdir -p -m 0755 /tmp/tailscale
    if [ -e ${PIDF} ]; then
        PID=$(cat ${PIDF})
        if [ -d /proc/${PID}/ ]; then
          echo "${QPKG_NAME} is already running."
          exit 0
        fi
    fi
    tailscaled --port 41641 --statedir=${QPKG_ROOT}/state 2> /dev/null &
    echo $! > ${PIDF}
    ;;

  stop)
    if [ -e ${PIDF} ]; then
      PID=$(cat ${PIDF})
      kill -9 ${PID} || true
      rm -f ${PIDF}
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
