import '../index.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false; //密码是否显示明文
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = false;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = Global.profile.lastLogin;
    if (_unameController.text != null) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: new AppBar(

      ),
      body:
        Container(
          margin: EdgeInsets.only(top: 200.ssp),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text("小禾在线家教"),
                  TextFormField(
                      autofocus: _nameAutoFocus,
                      controller: _unameController,
                      decoration: InputDecoration(
                        labelText: gm.userName,
                        hintText: gm.userNameOrEmail,
                        prefixIcon: Icon(Icons.person),
                      ),
                      // 校验用户名（不能为空）
                      validator: (v) {
                        return v.trim().isNotEmpty ? null : gm.userNameRequired;
                      }),
                  TextFormField(
                    controller: _pwdController,
                    decoration: InputDecoration(
                        labelText: gm.password,
                        hintText: gm.password,
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                              pwdShow ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              pwdShow = !pwdShow;
                            });
                          },
                        )),
                    obscureText: !pwdShow,
                    //校验密码（不能为空）
                    validator: (v) {
                      return v.trim().isNotEmpty ? null : gm.passwordRequired;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.expand(height: 55.0),
                      child: RaisedButton(
                        color: Colors.deepOrange,
                        onPressed: _onLogin,
                        textColor: Colors.white,
                        child: Text(gm.login),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }

  void _onLogin() async {
    // // 提交前，先验证各个表单字段是否合法
    // if ((_formKey.currentState as FormState).validate()) {
    //   showLoading(context);
    //   User user;
    //   try {
    //     user = await Git(context).login(_unameController.text, _pwdController.text);
    //     // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
    //     Provider.of<UserModel>(context, listen: false).user = user;
    //   } catch (e) {
    //     //登录失败则提示
    //     if (e.response?.statusCode == 401) {
    //       showToast(GmLocalizations.of(context).userNameOrPasswordWrong);
    //     } else {
    //       showToast(e.toString());
    //     }
    //   } finally {
    //     // 隐藏loading框
    //     Navigator.of(context).pop();
    //   }
    //   if (user != null) {
    //     // 返回
    //     Navigator.of(context).pop();
    //   }
    // }
  }
}