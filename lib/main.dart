import 'package:flutter/material.dart';
import 'package:flutter_app/app/component/icon_tab.dart';
import 'package:flutter_app/app/view/company/company_view.dart';
import 'package:flutter_app/app/view/jobs_view_new.dart';
import 'package:flutter_app/app/view/message_view.dart';
import 'package:flutter_app/app/view/mine_view.dart';

const double _kTabTextSize = 11.0;

class BossApp extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<BossApp> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  TabController _controller;
  VoidCallback onChanged;

  @override
  void initState() {
    super.initState();
    _controller =
        new TabController(initialIndex: _currentIndex, length: 4, vsync: this);
    onChanged = () {
      setState(() {
        _currentIndex = this._controller.index;
      });
    };

    _controller.addListener(onChanged);
  }

  @override
  void dispose() {
    ///移除监听,防止内存泄漏
    _controller.removeListener(onChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new TabBarView(
        children: <Widget>[
          new JobsTabNew(),
          new CompanyTab(),
          new MessageTab(),
          new MineTab()
        ],
        controller: _controller,
      ),
      bottomNavigationBar: new Material(
        color: Colors.white,
        child: new TabBar(
          controller: _controller,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: new TextStyle(fontSize: _kTabTextSize),
          tabs: <IconTab>[
            new IconTab(
              icon: _currentIndex == 0
                  ? "assets/images/ic_main_tab_company_pre.png"
                  : "assets/images/ic_main_tab_company_nor.png",
              text: "职位",
            ),
            new IconTab(
              icon: _currentIndex == 1
                  ? "assets/images/ic_main_tab_contacts_pre.png"
                  : "assets/images/ic_main_tab_contacts_nor.png",
              text: "公司",
            ),
            new IconTab(
              icon: _currentIndex == 2
                  ? "assets/images/ic_main_tab_find_pre.png"
                  : "assets/images/ic_main_tab_find_nor.png",
              text: "消息",
            ),
            new IconTab(
              icon: _currentIndex == 3
                  ? "assets/images/ic_main_tab_my_pre.png"
                  : "assets/images/ic_main_tab_my_nor.png",
              text: "我的",
            ),
          ],
        ),
      ),
    );
  }
}

void main() {

  runApp(new MaterialApp(
    ///这个标题其实是后台应用顶部显示的标题,之前一直没搞懂是啥
      title: "Boss直聘",
      theme: new ThemeData(
        primaryIconTheme: const IconThemeData(color: Colors.white),
        brightness: Brightness.light,
        primaryColor: new Color.fromARGB(255, 0, 215, 198),
        accentColor: Colors.cyan[300],
      ),
      home: new BossApp(),
      debugShowCheckedModeBanner: false,
//      home: new TestDemo()
  ));
}

class TestDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("测试")),body: Container(
      color: Colors.pink,
      child: Row(
        children: <Widget>[Text("张三")],
        mainAxisSize: MainAxisSize.max,
      ),
    ),);
  }
}
