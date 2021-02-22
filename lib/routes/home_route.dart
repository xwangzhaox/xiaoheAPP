import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  @override
  createState() => new HomeState();
}

class HomeState extends State<Home> {
  List<String> grads = ["小学","初一","初二","初三","高一","高二","高三"];
  String _grade = "小学";
  String _subject;
  String _price;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height:480.ssp,child:Card(
            margin: EdgeInsets.symmetric(vertical: 10.ssp,horizontal: 16.ssp),
            color: Colors.white,
            shadowColor: Colors.white,
            // 抗锯齿
            clipBehavior: Clip.antiAlias,
            elevation: 2,
            child: new Image.asset('images/banner.png', fit: BoxFit.cover,),),
          ),
          Card(
              margin: EdgeInsets.symmetric(vertical: 10.ssp,horizontal: 16.ssp),
              color: Colors.white,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.ssp)),),
              // 抗锯齿
              clipBehavior: Clip.antiAlias,
              elevation: 2,
              child: Container(
                padding: EdgeInsets.all(40.ssp),
                child: Column(
                  children: [
                    gradeSelector(),
                    gradeSelector(),
                    gradeSelector(),
                    xiaoheButton("搜索老师"),
                  ],
                ),
              )
          ),
          Card(
              margin: EdgeInsets.symmetric(vertical: 10.ssp,horizontal: 16.ssp),
              color: Colors.white,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.ssp)),),
              // 抗锯齿
              clipBehavior: Clip.antiAlias,
              elevation: 2,
              child: Container(
                padding: EdgeInsets.all(40.ssp),
                child: Column(
                  children: [
                    Row(mainAxisSize:MainAxisSize.max,children:[Text("小禾家教3步跟名师上课",textAlign: TextAlign.left,style:TextStyle(color: Color(int.parse("0xff333333")),fontSize: 48.ssp),),Spacer(),Text("详细>>",textAlign: TextAlign.right,style: TextStyle(fontSize:42.ssp,color: Colors.grey),),]),
                    Container(
                      padding: EdgeInsets.only(top: 50.ssp),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children:[
                        Column(children: [Row(children: [Image.asset('images/iconf1at2x.png',width: 112.ssp,fit: BoxFit.cover)]),Row(children: [Text("STEP1")],),Row(children: [Text("提交家教需求")],),Row(children: [Text("或自主挑选老师")],)],),
                        Column(children: [Row(children: [Image.asset('images/iconf2at2x.png',width: 112.ssp,fit: BoxFit.cover)]),Row(children: [Text("STEP2")],),Row(children: [Text("预约老师进行")],),Row(children: [Text("免费试听课程")],)],),
                        Column(children: [Row(children: [Image.asset('images/iconf3at2x.png',width: 112.ssp,fit: BoxFit.cover)]),Row(children: [Text("STEP3")],),Row(children: [Text("在线支付")],),Row(children: [Text("参加在线课程")],)],)
                      ]),
                    ),
                    Center(child:
                    xiaoheButton("立即预约"),
                    ),
                  ],
                ),
              )
          ),
          Container(
            // margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 17),
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.all(30.ssp),
              child: Column(
                children: [
                  Row(children: [Text("推荐老师",style: TextStyle(fontSize:42.ssp),textAlign: TextAlign.left),Spacer(),Text("更多老师>>",style: TextStyle(fontSize: 42.ssp),textAlign: TextAlign.right,)],),
                  teacher(),
                  Divider(height: 2.0,color:Colors.grey),
                  teacher(),
                  Divider(height: 2.0,color:Colors.grey),
                  teacher(),
                  Divider(height: 2.0,color:Colors.grey),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10.ssp,horizontal: 16.ssp),
            child: Column(children: [
              Row(children: [Text("关于小禾在线家教"),Spacer(),Text("老师登陆")],),
              SizedBox(height: 20.ssp),
              Row(children: [Text("课程如何收费"),Spacer(),Text("联系我们")],),
              SizedBox(height: 20.ssp),
              Row(children: [Text("成为老师"),Spacer(),Text("意见反馈")],),
            ],),)
        ],
      ),
    );
  }

  Widget gradeSelector(){
    return ListTile(
      leading: new Text("年级：",style: TextStyle(fontSize: 42.ssp),),
      title: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.ssp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.ssp),
          border: Border.all(
              color: Colors.grey, style: BorderStyle.solid, width: 0.80),
        ),
        child: DropdownButton(
          icon: Icon(Icons.arrow_right),
          iconSize: 40.ssp,
          underline: DropdownButtonHideUnderline(child: Container()),
          isExpanded: true,
          value: _grade,
          isDense: true,
          items: grads.map<DropdownMenuItem<String>>((String value) {return DropdownMenuItem<String>(value: value, child: Text(value),);}).toList(),
          onChanged: (newValue) {setState(() {_grade = newValue;});},
        ),),
      subtitle: new Row(
        children: [
          InkWell(child: Text("小学"),onTap: () => {setState((){_grade=grads[0];})},),
          InkWell(child: Text("初二"),onTap: () => {setState((){_grade=grads[1];})},),
          InkWell(child: Text("初三"),onTap: () => {setState((){_grade=grads[2];})},),
          InkWell(child: Text("高二"),onTap: () => {setState((){_grade=grads[3];})},),
          InkWell(child: Text("高三"),onTap: () => {setState((){_grade=grads[4];})},),
        ],
      ),
    );
  }

  Widget teacher(){
    return Row(children: [
      Column(children: [Image.asset('images/banner.png',color: Colors.grey, width:200.ssp, height:300.ssp, fit: BoxFit.cover,)],),
      Spacer(),
      Container(padding:EdgeInsets.only(left: 20.ssp, top: 40.ssp,right: 0.ssp, bottom: 0.ssp),width:400.ssp,child: Column(children: [
        Row(children: [Text("韩老师"),Expanded(child: Text("编号:T9342145"))],),
        Row(children: [Text("在校大学生"),Spacer(),Expanded(child: Text("北京大学"))],),
        Row(children: [Text("科目："),Expanded(child: Text("小学语数外、初中数学、高中数学、高中物理"))],),
        Row(children: [Text("特色："),Expanded(child: Text("擅长理科，基础功扎实，能够帮助学员领会到理科的本质")),],),
        Row(children: [Text("单价："),Expanded(child: Text("120元/小时"))],),
        Align(alignment: Alignment.topRight,child: OutlinedButton(child: Text("预约试听"), onPressed: () {},),),
      ],),),
    ],);
  }

  Widget xiaoheButton(String buttonContext){
    return Container(
        margin: EdgeInsets.fromLTRB(10.ssp, 25.ssp, 10.ssp, 0.ssp),
        width: 400.ssp,
        height: 70.ssp,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.orange, Colors.red],begin: Alignment.topCenter, end: Alignment.bottomCenter),// 渐变色
            borderRadius: BorderRadius.circular(40.ssp)
        ),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.ssp)
          ),
          color: Colors.transparent, // 设为透明色
          elevation: 0, // 正常时阴影隐藏
          // highlightElevation: 0, // 点击时阴影隐藏
          onPressed: (){
            Navigator.pushNamed(context, 'teachers');
          },
          child: Container(
            alignment: Alignment.center,
            height: 60.ssp,
            child: Text(buttonContext, style: TextStyle(color: Colors.white, fontSize: 42.ssp),),
          ),
        )
    );
  }
}