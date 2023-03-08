import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import 'logic.dart';

class WatertankPage extends StatelessWidget {
  final logic = Get.put(WatertankLogic());
  final state = Get.find<WatertankLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WatertankLogic>(initState: (_) {
      logic.waterValue = logic.progressValue * 100;
    }, builder: (logic) {
      return Scaffold(
          bottomNavigationBar: _buildBottomNavigation(),
          body: _buildBody(context));
    });
  }

  Widget _buildBody(context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.4,
        child: LiquidCircularProgressIndicator(
          value: logic.progressValue, // Defaults to 0.5.
          valueColor: AlwaysStoppedAnimation(
              Colors.lightBlue), // Defaults to the current Theme's accentColor.
          backgroundColor:
              Colors.white, // Defaults to the current Theme's backgroundColor.
          borderColor: Colors.blue,
          borderWidth: 5.0,
          direction: Axis
              .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
          center: Text(''),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              logic.progressValue = 0.0;
              logic.waterValue = 0.0;
              logic.update();
            },
            child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.white,
                )),
          ),
          InkWell(
            onTap: () {
              if (logic.waterValue >= 100.0) {
                print(logic.waterValue);
              } else {
                logic.progressValue = logic.progressValue + 0.10;
                logic.waterValue = logic.progressValue * 100;
                logic.update();
              }
            },
            child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: logic.waterValue < 100.0 ? Colors.green : Colors.grey,
                ),
                padding: EdgeInsets.all(20),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                )),
          ),
          InkWell(
            onTap: () {
              if (logic.waterValue <= 0.0) {
                print(logic.waterValue);
              } else {
                logic.progressValue = logic.progressValue - 0.10;
                logic.waterValue = logic.progressValue * 100;
                print(logic.progressValue);
                logic.update();
              }
            },
            child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: logic.waterValue <= 0.0 ? Colors.grey : Colors.blue,
                ),
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }
}
