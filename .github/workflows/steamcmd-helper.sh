#!/bin/bash
#set -euo pipefail
IFS=$'\n\t'
#set +u

# steamdir=${STEAM_HOME:-$HOME/Steam}
steamdir=~/steamcmd
# this is relative to the action
contentroot=$(pwd)/$rootPath

manifest_path=$(pwd)/manifest.vdf

echo ""
echo "#################################"
echo "#    Generating Item Manifest   #"
echo "#################################"
echo ""

cat << EOF > "manifest.vdf"
"workshopitem"
{
    "appid" "$appId"
    "publishedfileid" "$itemId"
    "contentfolder" "$contentroot"
    "changenote" "$changeNote"
}
EOF

cat manifest.vdf
echo ""

# if [ ! -n "$configVdf" ]; then
#   echo ""
#   echo "#################################"
#   echo "#     Using SteamGuard TOTP     #"
#   echo "#################################"
#   echo ""

#   ~/steamcmd/steamcmd.sh +set_steam_guard_code "$steam_totp" +login "$steam_username" "$steam_password" +quit;

#   ret=$?
#   if [ $ret -eq 0 ]; then
#       echo ""
#       echo "#################################"
#       echo "#        Successful login       #"
#       echo "#################################"
#       echo ""
#   else
#         echo ""
#         echo "#################################"
#         echo "#        FAILED login #"
#         echo "#################################"
#         echo ""
#         echo "Exit code: $ret"

#         exit $ret
#   fi
# else
#   if [ ! -n "$configVdf" ]; then
#     echo "Config VDF input is missing or incomplete! Cannot proceed."
#     exit 1
#   fi

  steam_totp="INVALID"

  echo ""
  echo "#################################"
  echo "#    Copying SteamGuard Files   #"
  echo "#################################"
  echo ""

  echo "Steam is installed in: $steamdir"

  mkdir -p "$steamdir/config"

  echo "Copying $steamdir/config/config.vdf..."
  echo "$configVdf" | base64 -d > "$steamdir/config/config.vdf"
  chmod 777 "$steamdir/config/config.vdf"

  echo "Finished Copying SteamGuard Files!"
  echo ""

  # echo ""
  # echo "#################################"
  # echo "#        Test login   #"
  # echo "#################################"
  # echo ""

  # ~/steamcmd/steamcmd.sh +login "$steam_username" +quit;

  # ret=$?
  # if [ $ret -eq 0 ]; then
  #     echo ""
  #     echo "#################################"
  #     echo "#        Successful login       #"
  #     echo "#################################"
  #     echo ""
  # else
  #       echo ""
  #       echo "#################################"
  #       echo "#        FAILED login #"
  #       echo "#################################"
  #       echo ""
  #       echo "Exit code: $ret"

  #       exit $ret
  # fi
# fi

echo ""
echo "#################################"
echo "#        Uploading item         #"
echo "#################################"
echo ""

~/steamcmd/steamcmd.sh +login "$steam_username" +workshop_build_item "$manifest_path" +quit || (
    echo ""
    echo "#################################"
    echo "#   Errors  #"
    echo "#################################"
    echo ""
    echo "Listing current folder and root path"
    echo ""
    ls -alh
    echo ""
    ls -alh "$rootPath" || true
    echo ""
    echo "Listing logs folder:"
    echo ""
    ls -Ralph "$steamdir/logs/"

    for f in "$steamdir"/logs/*; do
      if [ -e "$f" ]; then
        echo "######## $f"
        cat "$f"
        echo
      fi
    done

    echo ""
    echo "Displaying error log"
    echo ""
    cat "$steamdir/logs/stderr.txt"
    echo ""
    echo "Displaying bootstrapper log"
    echo ""
    cat "$steamdir/logs/bootstrap_log.txt"

    exit 1
  )

echo "manifest=${manifest_path}" >> $GITHUB_OUTPUT"
