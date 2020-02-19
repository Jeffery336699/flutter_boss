import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double _kTextAndIconTabHeight = 53.0;   // 导航高度
const double _kMarginBottom = 3.0;            // 图标与文字的间隔

class IconTab extends StatelessWidget {

  const IconTab({
    Key key,
    this.text,
    this.icon,
  }): assert(text != null || icon != null),
        super(key: key);

  final String text;
  final String icon;

  Widget _buildLabelText() {
    ///设置文本背景色
    Paint paintRed = Paint();
    paintRed.color = Colors.red;
    return new Text(text, softWrap: false, overflow: TextOverflow.fade,/*style: TextStyle(background: paintRed)*/);
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    double height = _kTextAndIconTabHeight;
    Widget label = new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            ///测试代码
//            color: text=="职位"?Colors.orange:Colors.blue,
            child: new Image(
              image: new AssetImage(this.icon),
              height: 30.0,
              width: 30.0,
            ),
            margin: const EdgeInsets.only(bottom: _kMarginBottom),
          ),
          _buildLabelText()
        ]
    );

    return new SizedBox(
      height: height,
      ///有起到底部下划线跟上面一样宽度的奇效,widthFactor=1表示与子child一样宽度
      child: new Center(
        child: label,
        widthFactor: 1.0,
      ),
    );
  }
}