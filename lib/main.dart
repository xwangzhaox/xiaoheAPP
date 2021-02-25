import 'index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((e) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
        builder: (BuildContext context, themeModel, localeModel, Widget child) {
          return ScreenUtilInit(
            designSize: Size(750, 1334),
            // designSize: Size(1170, 2532),
            allowFontScaling: true,
            child: MaterialApp(
                initialRoute:"/",  //名为"/"的路由作为应用的home(首页)
                theme: new ThemeData(primaryColor: Colors.white),
                onGenerateTitle: (context) {
                  return GmLocalizations.of(context).title;
                },
                locale: localeModel.getLocale(),
                //我们只支持美国英语和中文简体
                supportedLocales: [
                  const Locale('en', 'US'), // 美国英语
                  const Locale('zh', 'CN'), // 中文简体
                  //其它Locales
                ],
                localizationsDelegates: [
                  // 本地化的代理类
                  // AppLocalizationsDelegate(),
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GmLocalizationsDelegate()
                ],
                localeResolutionCallback:
                    (Locale _locale, Iterable<Locale> supportedLocales) {
                  if (localeModel.getLocale() != null) {
                    //如果已经选定语言，则不跟随系统
                    return localeModel.getLocale();
                  } else {
                    //跟随系统
                    Locale locale;
                    if (supportedLocales.contains(_locale)) {
                      locale = _locale;
                    } else {
                      //如果系统语言不是中文简体或美国英语，则默认使用美国英语
                      locale = Locale('en', 'US');
                    }
                    return locale;
                  }
                },
                //注册路由表
                routes:{
                  "/":(context) => IndexContainer(), //注册首页路由
                  "home":(context) => Home(), //注册首页路由
                  "class_schedule":(context) => ClassSchedule(),
                  "public_class":(context) => PublicClass(),
                  "navigator":(context) => PublicNavigator(),
                  "profile":(context) => ProfileRoute(),
                  "login":(context) => LoginRoute(),
                  "teachers":(context) => Teachers(),
                }
            ),
          );
        },
      ),
    );
  }
}