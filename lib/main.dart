import 'index.dart';

void main() {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((e) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      // designSize: Size(1170, 2532),
      allowFontScaling: true,
      child: MaterialApp(
          initialRoute:"/",  //名为"/"的路由作为应用的home(首页)
          theme: new ThemeData(primaryColor: Colors.white),
          //注册路由表
          routes:{
            "/":(context) => IndexContainer(), //注册首页路由
            "home":(context) => Home(), //注册首页路由
            "class_schedule":(context) => ClassSchedule(),
            "public_class":(context) => PublicClass(),
            "navigator":(context) => PublicNavigator(),
            "profile":(context) => ProfileRoute(),
            "teachers":(context) => Teachers(),
          }
      ),
    );
  }
}