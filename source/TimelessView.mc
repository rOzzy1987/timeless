import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class TimelessView extends WatchUi.WatchFace {

    private var _fntL;
    private var _fntM;
    private var _fntS;

    // private var _flh;
    private var _fmh;
    private var _fsh;

    private var _calBg = new GoalBackground(21);
    private var _stpBg = new GoalBackground(-21);
    private var _clk = new MinimalClock();

    private var _calColor = Graphics.COLOR_WHITE;
    private var _stpColor = Graphics.COLOR_WHITE;
    private var _productColor = Graphics.COLOR_LT_GRAY;
    private var _productName = "";

    private var _c = new Point(0,0);
    private var _w = 0;
    private var _h = 0;


    function initialize() {
        WatchFace.initialize();
        _stpBg.Color = Graphics.COLOR_DK_GRAY;
        _calBg.Color = Graphics.COLOR_DK_GRAY;
        _clk.Color = Graphics.COLOR_RED;
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
		_fntL = WatchUi.loadResource(Rez.Fonts.ZenL);
		_fntM = WatchUi.loadResource(Rez.Fonts.SarM);
		_fntS = WatchUi.loadResource(Rez.Fonts.SarS);
    }

    function readSettings() as Void {
        _productName = Application.Properties.getValue("ProductName").toString().toUpper();
        _calBg.Goal = Application.Properties.getValue("CaloriesGoal").toNumber();
        
        _stpBg.Color = Application.Properties.getValue("StepGoalBgColor").toNumber();
        _calBg.Color = Application.Properties.getValue("CaloriesGoalBgColor").toNumber();
        _clk.Color = Application.Properties.getValue("ClockColor").toNumber();
        _calColor = Application.Properties.getValue("CaloriesColor").toNumber();
        _stpColor = Application.Properties.getValue("StepsColor").toNumber();
        _productColor = Application.Properties.getValue("ProductNameColor").toNumber();

        if (_productName.equals("")){
            _productName = WatchUi.loadResource(Rez.Strings.ProductName).toUpper();
        }
    }

    function onUpdate(dc as Dc) as Void {
        if (_w == 0 || _h == 0) {
            _w = dc.getWidth();
            _h = dc.getHeight();
            _c = new Point(_w / 2, _h / 2);

            // _flh = dc.getFontHeight(_fntL);
            _fmh = dc.getFontHeight(_fntM);
            _fsh = dc.getFontHeight(_fntS);
            readSettings();
        }

        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_BLACK);
        dc.clear();

        var info = ActivityMonitor.getInfo();
        _stpBg.Goal = info.stepGoal;
        _stpBg.Value = info.steps;
        _calBg.Value = info.calories;

        _calBg.draw(dc);
        _stpBg.draw(dc);

        dc.setColor(_stpColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(_c.X, _c.Y - _fmh * 6 / 7, _fntM, info.steps.format("%05d"), Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor(_calColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(_c.X, _c.Y, _fntL, info.calories.format("%04d"), Graphics.TEXT_JUSTIFY_CENTER);

        dc.setColor(_productColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(_c.X, _c.Y, _fntS, _productName , Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(_c.X, _h - _fsh * 3 / 2, _fntS, "TIMELESS", Graphics.TEXT_JUSTIFY_CENTER);

        _clk.draw(dc);
    }
}
