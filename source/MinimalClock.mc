import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class MinimalClock {

    public var Color as Number = Graphics.COLOR_LT_GRAY;

    private var _lw = 0;
    
    private var _w = 0;
    private var _h = 0;
    private var _c as Point = new Point(0,0);

    private var _p1 = new Point(0,0);
    private var _p2 = new Point(0,0);
    private var _p3 = new Point(0,0);


    function draw(dc as Dc) as Void {
        if (_w == 0 || _h == 0) {
            _w = dc.getWidth();
            _h = dc.getHeight();
            _c = new Point(_w / 2, _h / 2);

            _lw = _w * 3 / 200;

            _p1 = new Point(_c.X, _lw);
            _p2 = new Point(_c.X, _lw * 3);
            _p3 = new Point(_c.X, _lw * 5);
        }

        var time = System.getClockTime();

        var p1 = _p1.Rotate(_c, (time.hour * 360 / 12) + (time.min * 30 / 60));
        var p2 = _p2.Rotate(_c, time.min * 360 / 60);
        var p3 = _p3.Rotate(_c, time.min * 360 / 60);

        dc.setColor(Color, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(_lw);
        dc.drawPoint(p1.X, p1.Y);
        dc.drawLine(p2.X, p2.Y, p3.X, p3.Y);
    }
}