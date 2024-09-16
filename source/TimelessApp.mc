import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class TimelessApp extends Application.AppBase {

    private var view = new TimelessView();

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ view ];
    }

    function onSettingsChanged() as Void {
        view.readSettings();
        WatchUi.requestUpdate();
    }

}

function getApp() as TimelessApp {
    return Application.getApp() as TimelessApp;
}