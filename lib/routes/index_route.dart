import '../index.dart';

class IndexContainer extends StatefulWidget {
  @override
  createState() => new IndexContainerState();
}

class IndexContainerState extends State<IndexContainer> {
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页",),
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "课程表",),
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "公开课",),
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "日常",),
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "我的",),
  ];
  final pages = [Home(), ClassSchedule(), PublicClass(), PublicNavigator(), ProfileRoute()];
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text("小禾在线家教",style: TextStyle(fontSize: 51.ssp),),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: bottomNavItems,
          unselectedLabelStyle: TextStyle(fontSize: 36.ssp),
          selectedLabelStyle: TextStyle(fontSize: 36.ssp),
          selectedItemColor: Colors.orange[500],
          currentIndex: _selectedIndex,
          iconSize: 62.ssp,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            _onItemTapped(index);
          },
        ),
        body: pages[_selectedIndex]
    );
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
}