#! /bin/bash
##Launches an instance of the Designer Launcher
# Get the location of the script.
REALDIR=$(cd "$( dirname "${BASH_SOURCE[0]}")" && pwd)

# Logging if error
LAUNCHER_LOGFILE="${REALDIR}/../designerlauncher.log"
LOG_MSG="ERROR [LauncherApplication           ] [$(date +"%Y/%m/%d %T")]:"

if [ "$(getconf LONG_BIT)" != "64" ]; then
	"${REALDIR}/../runtime/bin/./java" --version
	if [ $? -ne 0 ]; then
		echo "${LOG_MSG} 64-bit OS not detected. This launcher must run on a 64-bit OS." | tee -a "${LAUNCHER_LOGFILE}"
	fi
fi

#update the .desktop icon
sed -i 's,Icon=launcher.png,'"Icon=${REALDIR}\/launcher.png"',' "${REALDIR}/../designerlauncher.desktop"

"${REALDIR}/../runtime/bin/./java" -jar "${REALDIR}/launcher-designer-linux.jar" $@ >/dev/null 2>&1 &
