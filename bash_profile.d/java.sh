# Java Settings

# try to set JAVA_HOME to something sensible
if [ -z "$JAVA_HOME" ]; then
    if [ -e /etc/alternatives/java ]; then
        # Ubuntu
        java=`readlink /etc/alternatives/java`
        export JAVA_HOME=${java%%/bin/java}
    elif [ -e /etc/alternatives/java_sdk ]; then
        # RHEL/CentOS
        export JAVA_HOME=`readlink /etc/alternatives/java_sdk`
    elif [ -x  /usr/libexec/java_home ]; then
        # MacOS X
        export JAVA_HOME=$(/usr/libexec/java_home)
    fi
fi

if [ -d /opt/local/share/java/gradle ]; then
    export GRADLE_HOME=/opt/local/share/java/gradle
fi

# Maven
export MAVEN_OPTS="-Xmx1024M -Xss128M -XX:MetaspaceSize=512M -XX:MaxMetaspaceSize=1024M"
