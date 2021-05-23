import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/widget/base_stateless_widget.dart';

class ClipImageWidget extends BaseStatelessWidget {

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text("BoxDecoration 圆角"),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                image: DecorationImage(
                  image: AssetImage(icon_love),
                  fit: BoxFit.cover,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text("ShapeDecoration 圆角"),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: ShapeDecoration(
              color: Colors.red,
              image: DecorationImage(
                  image: AssetImage(icon_love), fit: BoxFit.cover),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text("ClipRRect 圆角"),
          ),
          Container(
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: buildImageIcon(),
            ),
          ),
        ],
      ),
    );
  }

  Image buildImageIcon() => Image.asset(
        icon_love,
        fit: BoxFit.cover,
        width: 100,
        height: 100,
      );
}

const icon_love = "static/icon_love.png";
