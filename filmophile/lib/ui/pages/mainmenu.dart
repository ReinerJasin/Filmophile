part of 'pages.dart';

class MainMenu extends StatefulWidget {
  static const String routeName = "/mainmenu";
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;
  List<int> menu = [0, 1, 2, 3];

  static List<Widget> _widgetOptions = <Widget>[
    //nanti diganti
    Home(),
    AddData(),
    ListData(),
    MyAccount(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomSheet: Container(
        height: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [for (var i in menu) selectedMenu(i, _selectedIndex)],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Chart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 0,
        backgroundColor: Color(0xff164E74),
        // Design buat selected index
        selectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        // Design buat unselected index
        unselectedItemColor: Colors.white,
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget selectedMenu(int i, int _selectedIndex) {
    // for(var i = 0; i < menu.length; i++){
    if (i == _selectedIndex) {
      return Container(
        height: 8,
        width: MediaQuery.of(context).size.width / menu.length,
        color: filmophileOrange,
        child: Text(""),
      );
    } else {
      return Container(
        height: 8,
        width: MediaQuery.of(context).size.width / menu.length,
        color: filmophileBlue,
        child: Text(""),
      );
    }
    // }
  }
}
