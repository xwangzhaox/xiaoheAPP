import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../index.dart';

Map<String, dynamic> httpHeaders = {
  'Accept': 'application/json',
  'Content-Type': 'application/json'
};

class XiaoHe {
  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  XiaoHe([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext context;
  Options _options;

  static Dio dio = new Dio(BaseOptions(
    connectTimeout: 150000,
    receiveTimeout: 150000,
    responseType: ResponseType.json,
    validateStatus: (status) {
      // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
      return true;
    },
    baseUrl: 'http://www.jieshanju.cn/wechats/v2/',
    headers: httpHeaders,
  ));

  static void init() {
    // 添加缓存插件
    dio.interceptors.add(Global.netCache);/**/
    // 设置用户token（可能为null，代表未登录）
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
  }

  // 登录接口，登录成功后返回用户信息
  Future<Profile> login(String login, String pwd) async {
    String basic = 'Basic ' + base64.encode(utf8.encode('$login:$pwd'));
    var r = await dio.get(
      "session/app_sign_in?login=$login&password=$pwd",
      options: _options.merge(headers: {
        HttpHeaders.authorizationHeader: basic
      }, extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    print(r);
    //登录成功后更新公共头（authorization），此后的所有请求都会带上用户身份信息
    dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    //清空所有缓存
    Global.netCache.cache.clear();
    //更新profile中的token信息
    Global.profile.token = basic;
    return Profile.fromJson(r.data);
  }

  //获取用户项目列表
  Future<List<Teacher>> getTeachers(
      {Map<String, dynamic> queryParameters, //query参数，用于接收分页信息
        refresh = false}) async {
    if (refresh) {
      // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
      _options.extra.addAll({"refresh": true, "list": true});
    }
    Global.netCache.cache.clear();
    var r = await dio.get(
      "notifications/teachers",
      queryParameters: queryParameters,
      options: _options,
    );
    return (r.data["teachers"] as List).map((e) => Teacher.fromJson(e)).toList();
  }
}
