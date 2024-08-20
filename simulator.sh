# This script generates a non locking copy of the save in your game folder. Useful for planning missions, or checking world progress without participating.

if [ ! -f "./local-settings.cfg" ]; then
	echo "local-settings.cfg missing! Please run barrage.sh and complete first time setup."
	exit 1
fi

source ./local-settings.cfg
cd data
source ./game-settings.cfg

git pull

# =========
# MAIN BODY
# =========

# copy save into game
BAKNUM=1
until [ ! -f "${GAMEDIR}/${SAVENAME}-Simulator-${BAKNUM}/persistent.sfs" ]; do 
    let "BAKNUM++"
done
cp -Rr "./${SAVENAME}" "${GAMEDIR}/${SAVENAME}-Simulator-${BAKNUM}"

# Undo changes we made to persistent.sfs so pull goes cleanly next time.
git reset --hard 

echo ""
echo "Simulator Save Created!"