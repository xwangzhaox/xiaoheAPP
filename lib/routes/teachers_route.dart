import '../index.dart';

class SortCondition {
  String name;
  bool isSelected;

  SortCondition({this.name, this.isSelected});
}

class Teachers extends StatefulWidget {
  @override
  _TeachersState createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  // Dorp Down menu
  List<String> _dropDownHeaderItemStrings = ['年级', '科目', '价格', '其他'];
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey _stackKey = GlobalKey();
  GZXDropdownMenuController _dropdownMenuController = GZXDropdownMenuController();
  // Subject and Price list and checked item index
  List<SortCondition> _gradeSortConditions = [];
  List<SortCondition> _subjectSortConditions = [];
  List<SortCondition> _priceSortConditions = [];
  SortCondition _selectGradeSortCondition;
  SortCondition _selectSubjectSortCondition;
  SortCondition _selectPriceSortCondition;

  // View List
  final List<String> entries = <String>['A', 'B'];
  final List<int> colorCodes = <int>[600, 500];

  // Control the Dropdown menu action refresh viewlist data
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _gradeSortConditions.add(SortCondition(name: '全部', isSelected: true));
    _gradeSortConditions.add(SortCondition(name: '小学一年级', isSelected: false));
    _gradeSortConditions.add(SortCondition(name: '小学二年级', isSelected: false));
    _gradeSortConditions.add(SortCondition(name: '小学三年级', isSelected: false));
    _selectGradeSortCondition = _gradeSortConditions[0];

    _subjectSortConditions.add(SortCondition(name: '全部', isSelected: true));
    _subjectSortConditions.add(SortCondition(name: '数学', isSelected: false));
    _subjectSortConditions.add(SortCondition(name: '物理', isSelected: false));
    _subjectSortConditions.add(SortCondition(name: '化学', isSelected: false));
    _subjectSortConditions.add(SortCondition(name: '英语', isSelected: false));
    _subjectSortConditions.add(SortCondition(name: '语文', isSelected: false));
    _selectSubjectSortCondition = _subjectSortConditions[0];

    _priceSortConditions.add(SortCondition(name: '全部', isSelected: true));
    _priceSortConditions.add(SortCondition(name: '0-200', isSelected: false));
    _priceSortConditions.add(SortCondition(name: '2000-400', isSelected: false));
    _priceSortConditions.add(SortCondition(name: '400+', isSelected: false));
    _selectPriceSortCondition = _priceSortConditions[0];
  }

  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("老师列表", style: TextStyle(fontSize: 51.ssp),),
      ),
      body:
        Stack(
          key: _stackKey,
          children: <Widget>[
            Column(children: <Widget>[
              GZXDropDownHeader(
              // 下拉的头部项，目前每一项，只能自定义显示的文字、图标、图标大小修改
                items: [
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[0],style: TextStyle(color: Colors.deepOrangeAccent), iconData: Icons.keyboard_arrow_down),
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[1],iconData: Icons.keyboard_arrow_down),
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[2],iconData: Icons.keyboard_arrow_down),
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[3],iconData: Icons.filter_frames, iconSize: 18),
                ],
                stackKey: _stackKey,  // GZXDropDownHeader对应第一父级Stack的key
                controller: _dropdownMenuController,  // controller用于控制menu的显示或隐藏
                // 当点击头部项的事件，在这里可以进行页面跳转或openEndDrawer
                onItemTap: (index) {
                  if (index == 3) {
                    _dropdownMenuController.hide();
                    _scaffoldKey.currentState.openEndDrawer();
                  }
                },
                style: TextStyle(color: Color(0xFF666666), fontSize: 14),
                // 下拉时文字样式
                dropDownStyle: TextStyle(fontSize: 14, color: Colors.deepOrangeAccent,),
              ),
              Expanded(
                child:
                  _teacherList()
                ),
              ],
            ),
                // 下拉菜单
            GZXDropDownMenu(
              // controller用于控制menu的显示或隐藏
              controller: _dropdownMenuController,
              // 下拉菜单显示或隐藏动画时长
              animationMilliseconds: 300,
              // 下拉菜单，高度自定义，你想显示什么就显示什么，完全由你决定，你只需要在选择后调用_dropdownMenuController.hide();即可
              menus: [
                GZXDropdownMenuBuilder(
                  dropDownHeight: 40.0 * _gradeSortConditions.length,
                  dropDownWidget: _buildConditionListWidget(_gradeSortConditions, (value) {
                    _selectGradeSortCondition = value;
                    _dropDownHeaderItemStrings[0] = _selectGradeSortCondition.name == '全部' ? '年级' : _selectGradeSortCondition.name;
                    _dropdownMenuController.hide();
                    setState(() {});
                  })),
                GZXDropdownMenuBuilder(
                  dropDownHeight: 40.0 * _subjectSortConditions.length,
                  dropDownWidget: _buildConditionListWidget(_subjectSortConditions, (value) {
                    _selectSubjectSortCondition = value;
                    _dropDownHeaderItemStrings[1] = _selectSubjectSortCondition.name == '全部' ? '科目' : _selectSubjectSortCondition.name;
                    _dropdownMenuController.hide();
                    setState(() {});
                  })),
                GZXDropdownMenuBuilder(
                  dropDownHeight: 40.0 * _priceSortConditions.length,
                  dropDownWidget: _buildConditionListWidget(_priceSortConditions, (value) {
                    _selectPriceSortCondition = value;
                    _dropDownHeaderItemStrings[2] = _selectPriceSortCondition.name == '全部' ? '单价' : _selectSubjectSortCondition.name;
                    _dropdownMenuController.hide();
                    setState(() {});
                  })),
              ],
            ),
          ]
        ),
    );
  }

  Widget _teacherList(){
    return InfiniteListView<Teacher>(
      refreshKey: refreshIndicatorKey,
      onRetrieveData: (int page, List<Teacher> items, bool refresh) async {
        var data = await XiaoHe(context).getTeachers(
          refresh: refresh,
          queryParameters: {
            'grade': _selectGradeSortCondition.name,
            'subject': _selectSubjectSortCondition.name,
            'price': _selectPriceSortCondition.name,
            'page': page,
            'page_size': 20,
          },
        );
        //把请求到的新数据添加到items中
        items.addAll(data);
        // 如果接口返回的数量等于'page_size'，则认为还有数据，反之则认为最后一页
        return data.length==20;
      },
      itemBuilder: (List list, int index, BuildContext ctx) {
        // 项目信息列表项
        return TeacherItem(list[index]);
      },
    );
  }

  // build Dropdown widget
  _buildConditionListWidget(items, void itemOnTap(SortCondition sortCondition)) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      // item 的个数
      separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
      // 添加分割线
      itemBuilder: (BuildContext context, int index) {
        SortCondition goodsSortCondition = items[index];
        return GestureDetector(
          onTap: () {
            for (var value in items) {
              value.isSelected = false;
            }
            goodsSortCondition.isSelected = true;

            itemOnTap(goodsSortCondition);
            refreshIndicatorKey.currentState.show();
          },
          child: Container(
//            color: Colors.blue,
            height: 40,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    goodsSortCondition.name,
                    style: TextStyle(
                      color: goodsSortCondition.isSelected ? Colors.deepOrangeAccent : Colors.black,
                    ),
                  ),
                ),
                goodsSortCondition.isSelected
                    ? Icon(
                  Icons.check,
                  color: Colors.deepOrangeAccent,
                  size: 16,
                )
                    : SizedBox(),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}