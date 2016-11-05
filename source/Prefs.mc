using Toybox.Application as App;

//! Preferences utility.
module Prefs {

    //! Store activity type
    function setActivityType(type) {
        App.getApp().setProperty(ACTIVITY_TYPE, type);
        if (Log.isDebugEnabled()) {
            Log.debug("Prefs: activity type set to " + type);
        }
    }

    //! Get activity type
    function getActivityType() {
        var type = getNumber(ACTIVITY_TYPE, 0, 0, 999);
        if (Log.isDebugEnabled()) {
            Log.debug("Prefs: activity type value is " + type);
        }
        return type;
    }

    //! Return the number value for a preference, or the given default value if pref
    //! does not exist, is invalid, is less than the min or is greater than the max.
    //! @param name the name of the preference
    function getNumber(name, def, min, max) {
        var app = App.getApp();
        var pref = def;

        if (app != null) {
            pref = app.getProperty(name);

            if (pref != null) {
                // GCM used to return value as string
                if (pref instanceof Toybox.Lang.String) {
                    try {
                        pref = pref.toNumber();
                    } catch(ex) {
                        pref = null;
                    }
                }
            }
        }

        // Run checks
        if (pref == null || pref < min || pref > max) {
            pref = def;
            app.setProperty(name, pref);
        }

        return pref;
    }

    hidden const ACTIVITY_TYPE = "ActivityType";
    hidden const EXERCISE_DURATION = "ExerTime";
}
