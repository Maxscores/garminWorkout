using Toybox.Application as App;

//! Preferences utility.
module Prefs {

    enum {
        SEVEN = 0,
        CARDIO = 1,
        STRENGTH = 2
    }

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

    //! Store exercise duration
    function setExerciseDuration(duration) {
        App.getApp().setProperty(EXERCISE_DURATION, duration);
        if (Log.isDebugEnabled()) {
            Log.debug("Prefs: exercise duration set to " + duration);
        }
    }

    //! Get exercise duration
    function getExerciseDuration() {
        var duration = getNumber(EXERCISE_DURATION, 30, 10, 999);
        if (Log.isDebugEnabled()) {
            Log.debug("Prefs: exercise duration value is " + duration);
        }
        return duration;
    }

    //! Store rest duration
    function setRestDuration(duration) {
        App.getApp().setProperty(REST_DURATION, duration);
        if (Log.isDebugEnabled()) {
            Log.debug("Prefs: rest duration set to " + duration);
        }
    }

    //! Get rest duration
    function getRestDuration() {
        var duration = getNumber(REST_DURATION, 10, 5, 999);
        if (Log.isDebugEnabled()) {
            Log.debug("Prefs: rest duration value is " + duration);
        }
        return duration;
    }

    //! Store exercise count
    function setExerciseCount(count) {
        App.getApp().setProperty(EXERCISE_COUNT, count);
        if (Log.isDebugEnabled()) {
            Log.debug("Prefs: exercise count set to " + count);
        }
    }

    //! Get exercise count
    function getExerciseCount() {
        var count = getNumber(EXERCISE_COUNT, 13, 1, 999);
        if (Log.isDebugEnabled()) {
            Log.debug("Prefs: exercise count value is " + count);
        }
        return count;
    }

    //! Return true if vibrations are allowed
    function isAllowVibration() {
        var value = getBoolean(ALLOW_VIBRATION, true);
        if (Log.isDebugEnabled()) {
            Log.debug("Prefs: allow vibration value is " + value);
        }
        return value;
    }

    //! Return the number value for a preference, or the given default value if pref
    //! does not exist, is invalid, is less than the min or is greater than the max.
    //! @param name the name of the preference
    //! @param def the default value if preference value cannot be found
    //! @param min the minimum authorized value for the preference
    //! @param max the maximum authorized value for the preference
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

    //! Return the boolean value for the preference
    //! @param name the name of the preference
    //! @param def the default value if preference value cannot be found
    hidden function getBoolean(name, def) {
        var app = App.getApp();
        var pref = def;

        if (app != null) {
            pref = app.getProperty(name);

            if (pref != null) {
                if (pref instanceof Toybox.Lang.Boolean) {
                    return pref;
                }

                if (pref == 1) {
                    return true;
                }
            }
        }

        // Default
        return pref;
    }

    // Settings name, see resources/settings.xml
    hidden const ACTIVITY_TYPE = "activityType";
    hidden const EXERCISE_DURATION = "exerTime";
    hidden const REST_DURATION = "restTime";
    hidden const EXERCISE_COUNT = "exerCount";
    hidden const ALLOW_VIBRATION = "allowVibration";
}
