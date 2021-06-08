import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/widget/base_stateless_widget.dart';
import 'package:hy_flutter_simple/widget/drop/drop_select_demo_data.dart';
import 'package:hy_flutter_simple/widget/drop/drop_select_list_menu.dart';
import 'package:hy_flutter_simple/widget/drop/drop_select_menu_title_widget.dart';
import 'package:hy_flutter_simple/widget/drop/drop_select_object.dart';

import 'drop_select_grid_menu.dart';
import 'drop_select_menu.dart';
import 'drop_select_widget.dart';

class DropSelectPageWidget extends BaseStatelessWidget {
  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      child: DropSelectMenuContainerWidget(
        child: Column(
          children: [
            renderHeader(),
            Expanded(
                child: Stack(
              children: [
                ListView.builder(
                  itemBuilder: (c, index) {
                    return ListTile(
                      leading: Text('Text $index'),
                    );
                  },
                  itemCount: 40,
                  itemExtent: 45,
                ),
                renderMenuList(context)
              ],
            ))
          ],
        ),
      ),
    );
  }

  DropSelectMenu renderMenuList(BuildContext context) {
    return DropSelectMenu(
      maxHeight: MediaQuery.of(context).size.height,
      menus: [
        dropSelectGridMenuBuilder(context),
        dropSelectListMenuBuilder2(context),
        dropSelectListMenuBuilder(context),
      ],
    );
  }

  DropSelectMenuBuilder dropSelectListMenuBuilder(
      BuildContext context) {
    print(
        '计算高= ${DropSelectListMenu.kDropSelectListHeight * selectNormal.length}');
    print('screen= ${MediaQuery.of(context).size.height}');
    return DropSelectMenuBuilder(
        builder: (context) {
          return DropSelectListMenu(
              itemBuilder: (context, data) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            data.title.toString(),style: createSelectTextStyle(data, context),),
                        Icon(
                          data.selected ? Icons.check_circle : null,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                );
              },
              singleSelected: true,
              items: selectNormal);
        },
        height: DropSelectListMenu.kDropSelectListHeight * selectNormal.length);
  }

  TextStyle createSelectTextStyle(DropSelectObject data, BuildContext context) {
    return TextStyle(color:
                      data.selected?Colors.blue:Theme.of(context).unselectedWidgetColor
                      );
  }

  DropSelectMenuBuilder dropSelectListMenuBuilder2(BuildContext context) {
    return DropSelectMenuBuilder(
        builder: (context) {
          return DropSelectListMenu(
              itemBuilder: (context, data) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data.title.toString(),style: createSelectTextStyle(data, context),),
                        Icon(
                          data.selected ? Icons.check_circle : null,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                );
              },
              singleSelected: false,
              items: selectNormal);
        },
        height: MediaQuery.of(context).size.height);
  }

  DropSelectMenuBuilder dropSelectGridMenuBuilder(BuildContext context) {
    return DropSelectMenuBuilder(
        height: MediaQuery.of(context).size.height,
        builder: (c) {
          return DropSelectGridMenu(
            itemBuilder: (BuildContext context, DropSelectObject data) {
              return Container(
                  decoration: BoxDecoration(border: Border.all(color: data.selected?Colors.blue:Theme.of(context).unselectedWidgetColor)),
                  child: Center(child: Text(data.title.toString(),style: createSelectTextStyle(data, context),)));
            },
            items: selectChildGrid,
          );
        });
  }

  DropSelectMenuTitleWidget renderHeader() {
    return DropSelectMenuTitleWidget(
        showTitle: (_, index) {
          switch (index) {
            case 0:
              return 'title1';
            case 1:
              return 'title2';
            case 2:
              return 'title3';
          }
          return 'title';
        },
        titles: [selectExpand[0], selectChildGrid[0], selectNormal[0]]);
  }
}
