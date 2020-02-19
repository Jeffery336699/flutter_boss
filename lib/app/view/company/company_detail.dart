import 'package:flutter/material.dart';
import 'package:flutter_app/app/component/indicator_viewpager.dart';
import 'package:flutter_app/app/model/company.dart';
import 'package:flutter_app/app/view/company/company_hot_job.dart';
import 'package:flutter_app/app/view/company/company_inc.dart';
import 'package:flutter_app/app/view/company/company_info.dart';

enum AppBarBehavior { normal, pinned, floating, snapping }

const double _kAppBarHeight = 206.0;

class CompanyDetail extends StatefulWidget {

  final Company _company;

  CompanyDetail(this._company);

  @override
  CompanyDetailState createState() => new CompanyDetailState();
}

class CompanyDetailState extends State<CompanyDetail>
    with TickerProviderStateMixin {

  List<Tab> _tabs;
  List<Widget> _imagePages;
  TabController _controller;
  List<String> _urls = [
    'https://img.bosszhipin.com/beijin/mcs/chatphoto/20170725/861159df793857d6cb984b52db4d4c9c.jpg',
    'https://img2.bosszhipin.com/mcs/chatphoto/20151215/a79ac724c2da2a66575dab35384d2d75532b24d64bc38c29402b4a6629fcefd6_s.jpg',
    'https://img.bosszhipin.com/beijin/mcs/chatphoto/20180207/c15c2fc01c7407b98faf4002e682676b.jpg'
  ];
  Widget _companyTabContent;
  VoidCallback onChanged;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    if (!_urls.isEmpty) {
      _imagePages = <Widget>[];
      _urls.forEach((String url) {
        _imagePages.add(
            new Container(
                color: Colors.black.withAlpha(900),
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: new Image.network(
                    url,
                    fit: BoxFit.cover,
                    height: _kAppBarHeight,
                  ),
                ))
        );
      });
    }
    _tabs = [
      new Tab(text: '公司概况'),
      new Tab(text: '热招职位'),
    ];
    _companyTabContent = new CompanyInc(widget._company.inc);
    _controller = new TabController(length: _tabs.length, vsync: this);
    onChanged = () {
      setState(() {
        if (_currentIndex == 0) {
          _companyTabContent = new CompanyInc(widget._company.inc);
        } else {
          _companyTabContent = new CompanyHotJob();
        }
        _currentIndex = this._controller.index;
      });
    };
    ///监听TabBar的切换,实时改变下面的内容
    _controller.addListener(onChanged);
  }

  @override
  void dispose() {
    ///control移除监听器,避免内存泄漏等不必要的资源浪费
    _controller.removeListener(onChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: new Color.fromARGB(255, 242, 242, 245),
        body: new Stack(
          children: <Widget>[
            new SingleChildScrollView(
                child: new Column(
                  children: <Widget>[
                    new SizedBox.fromSize(
                      ///固定高度值,宽度延伸屏幕宽
                      size: const Size.fromHeight(_kAppBarHeight),
                      child: new IndicatorViewPager(_imagePages),
                    ),

                    new Container(
                      color: Colors.white,
                      child: new Column(
                        children: <Widget>[
                          new CompanyInfo(widget._company),
                          new Divider(),
                          new TabBar(
                            indicatorWeight: 3.0,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelStyle: new TextStyle(fontSize: 16.0),
                            labelColor: Colors.black,
                            controller: _controller,
                            tabs: _tabs,
                            indicatorColor: Theme
                                .of(context)
                                .primaryColor,
                          ),
                        ],
                      ),
                    ),
                    _companyTabContent
                  ],
                )
            ),

            new Positioned(
              ///在原来padding的基础上,top向下(正方向)偏移10,左边向右(正方向)偏移-10 等价于 左边向左偏移10
              top: 10.0,
              left: -10.0,
              child: new Container(
                  padding: const EdgeInsets.all(15.0),
                  child: new BackButton(color: Colors.white)
              ),
            ),
          ],
        )
    );
  }
}