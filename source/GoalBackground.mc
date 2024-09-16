import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class GoalBackground {

    // Data related
    public var Goal as Number = 0;
    public var Value as Number = 0;
    public var Color as Number = Graphics.COLOR_DK_GRAY;


    // View related
    private var _lines = 16;
    private var _angle = 0;
    private var _w = 0;
    private var _h = 0;
    private var _c as Point = new Point(0,0);
    private var _max = 0;
    private var _min = 0;
    private var _step = 0;

    function initialize(angle as Number) {
        _angle = angle;
    }

    function draw(dc as Dc) as Void {
        if (_w == 0 || _h == 0) {
            _w = dc.getWidth();
            _h = dc.getHeight();
            _c = new Point(_w / 2, _h / 2);

            _max = (Math.sqrt(2) * _lines.toFloat()).toNumber();
            _min = _lines - _max;
            _step = _h / _lines;
        }

        if (Goal == 0) {
            return;
        }

        dc.setColor(Color, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(_h / (_lines * 8));


        for (var i = _min; i < _max; i++) {
            if (i > Value * _lines / Goal && i <= _lines) {
                continue;
            }
            var p1 = new Point(_min * _step, i * _step);
            var p2 = new Point(_max * _step, i * _step);
            
            p1 = p1.Rotate(_c, _angle);
            p2 = p2.Rotate(_c, _angle);

            dc.drawLine(p1.X, p1.Y, p2.X, p2.Y);
        }
    }

}
