import '../index.dart';

class TeacherItem extends StatefulWidget {
  TeacherItem(this.teacher) : super(key: ValueKey(teacher.id));
  final Teacher teacher;
  @override
  _TeacherItemState createState() => _TeacherItemState();
}

class _TeacherItemState extends State<TeacherItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
              child: Row(
                children: [
                  Column(children: [
                    CircleAvatar(radius: 100.ssp, backgroundImage: NetworkImage(widget.teacher.avatar),),
                    Text(widget.teacher.name),
                    Text(widget.teacher.SN),
                  ],),
                  Spacer(),
                  Container(padding:EdgeInsets.only(left: 20.ssp, top: 40.ssp,right: 0.ssp, bottom: 0.ssp),width:400.ssp,child: Column(children: [
                    Row(children: [Text(widget.teacher.collage),Spacer(),Expanded(child: Text(widget.teacher.age.toString()+"岁"))],),
                    Row(children: [Text(widget.teacher.skilled.map((e) => e["name"]).join(","))],),
                    Row(children: widget.teacher.certificates.map<Widget>((e) => subjectTag(e["name"])).toList()),
                    Row(children: [Expanded(child: Text(widget.teacher.description)),],),
                    Row(children: [Text(widget.teacher.price.toString()+"元/小时")],),
                    Align(alignment: Alignment.topRight,child: OutlinedButton(child: Text("预约试听"), onPressed: () {},),),
                  ],),),
                ],
              ),
            )
        ),
      ],
    );
  }

  Widget subjectTag(String context){
    return Container(
      margin: EdgeInsets.all(10.ssp),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
      ),
      child: Text(
        context,
        style: TextStyle(color: Colors.red,fontSize: 22.ssp),
      ),
    );
  }
}