#Install apptainer
source globals.sh

APPTAINER_VER=$1

if [ $OS=="ubuntu" ]; then 
        if ( ! dpkg -l curl >& /dev/null); then 
        apt-get update 
        apt-get install -y curl
        fi

        if ( ! dpkg -l gdebi-core >& /dev/null); then 
        apt-get update 
        apt-get install -y gdebi
        fi

        for name in apptainer apptainer-suid
        do
        curl -L -O https://github.com/apptainer/apptainer/releases/download/v${APPTAINER_VER}/${name}_${APPTAINER_VER}_amd64.deb && \
                gdebi -n ${name}_${APPTAINER_VER}_amd64.deb && \
                rm -f ${name}_${APPTAINER_VER}_amd64.deb*
        done
else
        if ( ! rpm -qi epel-release >& /dev/null ); then
                yum -y install epel-release
                crb-enable
        fi
        yum install -y epel-release
        for name in apptainer apptainer-suid
        do
                yum install -y https://github.com/apptainer/apptainer/releases/download/v${APPTAINER_VER}/${name}-${APPTAINER_VER}-1.x86_64.rpm 
        done
fi