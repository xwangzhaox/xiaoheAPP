import '../index.dart';
import '../states/profile_change_notifier.dart';

class ProfileRoute extends StatefulWidget {
  @override
  createState() => new ProfileRouteState();
}

class ProfileRouteState extends State<ProfileRoute> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _profileHeader(),
        Expanded(child: _profileListTile())
      ],
    );
  }

  Widget _profileHeader(){
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel value, Widget child) {
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 80.ssp, bottom: 40.ssp),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  // 如果已登录，则显示用户头像；若未登录，则显示默认头像
                  child: value.isLogin
                        ? gmAvatar(value.user.avatar_url, width: 160.ssp)
                        : Image.asset('images/default-avatar.png', width: 160.ssp, fit: BoxFit.cover,)
                ),
                Container(
                  padding: EdgeInsets.only(left: 60.ssp),
                  child: Text(
                    value.isLogin ? value.user.login : GmLocalizations.of(context).login,
                    style: TextStyle(fontWeight: FontWeight.bold,),
                  )
                )
              ],
            ),
          ),
          onTap: () {
            if (!value.isLogin) Navigator.of(context).pushNamed("login");
          },
        );
      },
    );
  }

  Widget _profileListTile(){
    return Consumer<UserModel>(
        builder: (BuildContext context, UserModel userModel, Widget child) {
          var gm = GmLocalizations.of(context);
          return Container(
            color: Theme.of(context).primaryColor,
            child: ListView(
              children: <Widget>[
                Divider(height: 2.0,color:Colors.grey),
                ListTile(
                  leading: FlutterLogo(),
                  title: Text("意见反馈"),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(height: 2.0,color:Colors.grey),
                ListTile(
                  leading: FlutterLogo(),
                  title: Text("关于小禾"),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(height: 2.0,color:Colors.grey),
              ]
            ),
          );
        }
    );
  }
}