if [ -z "$HOME" ]
then
  echo HOME not in environment, guessing...
  export HOME=$(awk -F: -v v="$USER" '{if ($1==v) print $6}' /etc/passwd)
fi

export JENKINS_WORKSPACE=$WORKSPACE

if [ ! -z "$CWORKSPACE" ]
then
	export WORKSPACE=$CWORKSPACE
fi

cd $WORKSPACE
mkdir -p ../android
cd ../android
export WORKSPACE=$PWD
	
if [ ! -d cm_jenkins ]
then
  git clone git://github.com/rodero95/cm_jenkins.git
fi

cd cm_jenkins
## Get rid of possible local changes
git reset --hard
git pull -s resolve

exec ./build.sh
