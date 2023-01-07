#!/bin/sh
CONF=/etc/config/qpkg.conf
QPKG_NAME="Tailscale"
QPKG_ROOT=`/sbin/getcfg ${QPKG_NAME} Install_Path -f ${CONF}`
export QNAP_QPKG=${QPKG_NAME}
export QPKG_ROOT
export QPKG_NAME
export PIDF=/var/run/tailscaled.pid
set -e

case "$1" in
  start)
    ENABLED=$(/sbin/getcfg ${QPKG_NAME} Enable -u -d FALSE -f ${CONF})
    if [ "${ENABLED}" != "TRUE" ]; then
        echo "${QPKG_NAME} is disabled."
        exit 1
    fi

    if [ -e ${PIDF} ]; then
        PID=$(cat ${PIDF})
        if [ -d /proc/${PID}/ ]; then
          echo "${QPKG_NAME} is already running."
          exit 0
        fi
    fi
    /bin/ln -sf ${QPKG_ROOT}/tailscaled /usr/bin/tailscaled
    /bin/ln -sf ${QPKG_ROOT}/tailscale /usr/bin/tailscale
    tailscaled --port 41641 --statedir=${QPKG_ROOT}/state 2> /dev/null &
    echo $! > ${PIDF}
    sleep 10
    tailscale up 2>&1 > /dev/null | tee ${QPKG_ROOT}/tailscale.txt &
    ;;

  stop)
    tailscale down
    if [ -e ${PIDF} ]; then
      PID=$(cat ${PIDF})
      kill -9 ${PID} || true
      rm -f ${PIDF}
    fi
    rm -rf /usr/bin/tailscaled
    rm -rf /usr/bin/tailscale
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
