using Toybox.Lang as Lang;
using Toybox.System as Sys;

//! Logging utility
module Log {

    //! Returns true if debug is enabled
    function isDebugEnabled() {
        return DEBUG;
    }

    //! Writes a debug message on system console
    function debug(text) {
        if (DEBUG) {
            var clock = Sys.getClockTime();
            var msg = Lang.format("$1$:$2$:$3$ - [DEBUG] - $4$", [
                clock.hour.format("%.2d"),
                clock.min.format("%.2d"),
                clock.sec.format("%.2d"),
                text
            ]);
            Sys.println(msg);
        }
    }


    hidden const DEBUG = false;
}
