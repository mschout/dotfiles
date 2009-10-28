if [ -d /opt/local/sbin ]
then
    PATH=/opt/local/sbin:$PATH
fi

if [ -d /opt/local/bin ]
then
    PATH=/opt/local/bin:$PATH
fi

export PATH
