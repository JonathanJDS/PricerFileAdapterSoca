yajsw-stable-11.06

    Bug: Jna tmp folder
    Bug: yajsw prints wrong version
    Bug: netty: do not use sun.misc.Unsafe, this may crash the JVM (we do not need high performance)
    Bug: windows >= vista and java >= 7:  check that java.net.preferIPv4Stack=true is set and set it in the windows batch file and service command line
    Bug: possible loop in JVMController.processStarted()
    Change: minor changes in WrappedJavaProcess.getDOption(), WrappedJavaProcess.reconnect()
    New: new property: wrapper.restart.reload_cache
    New: script:  vfsCommandCondition.gv