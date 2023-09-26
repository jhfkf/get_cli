import 'package:recase/recase.dart';

import '../../common/utils/pubspec/pubspec_utils.dart';
import '../interface/sample_interface.dart';

/// [Sample] file from Module_View file creation.
class GetViewSample extends Sample {
  final String _controllerDir;
  final String _viewName;
  final String _controller;
  final bool _isServer;
  int pageType = 0;

  GetViewSample(String path, this._viewName, this._controller,
      this._controllerDir, this._isServer,
      {bool overwrite = false, this.pageType = 0})
      : super(path, overwrite: overwrite);

  String get import => _controllerDir.isNotEmpty
      ? '''import 'package:${PubspecUtils.projectName}/$_controllerDir';'''
      : '';

  String get _controllerName =>
      _controller.isNotEmpty ? 'GetView<$_controller>' : 'GetView';

  // class $_viewName extends $_controllerName {

  String get _flutterView => '''import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

$import

class $_viewName extends StatelessWidget {
  $_viewName({Key? key}) : super(key: key);
 
  final logic = Get.find<$_controller>();
  final state = Get.find<$_controller>().state;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$_viewName'),
        centerTitle: true,
      ),
      body:const Center(
        child: Text(
          '$_viewName is working', 
          style: TextStyle(fontSize:20),
        ),
      ),
    );
  }
}
  ''';

  String get _flutterListView => '''import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

import '../../data/theme/app_styles.dart';
import '../../utils/widget/utils_public_widget.dart';
import '../../utils/widget/widget_smart_refresher.dart';

$import

class $_viewName extends StatelessWidget {
  $_viewName({Key? key}) : super(key: key);
 
  final logic = Get.find<$_controller>();
  final state = Get.find<$_controller>().state;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$_viewName'),
        centerTitle: true,
      ),
      backgroundColor: Styles.pageLightGrayBgColor,
      body: Column(
        children: [
          Expanded(
              child: logic.obx((status) {
                return WidgetSmartRefresher(
                  controller: state.controller,
                  enablePullUp: false,
                  enablePullDown: true,
                  onRefresh: () => logic.onRefreshEvent(),
                  child: ListView.builder(
                    itemCount: state.${_viewName.replaceAll("Page", "").camelCase}List.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildListItemWidget(
                          index, state.${_viewName.replaceAll("Page", "").camelCase}List[index]);
                    },
                  ),
                );
              },
                  onEmpty: PublicWidget.buildEmptyWidget(
                      msg: "暂无数据",
                      isRefresh: true,
                      callback: logic.onRefreshEvent),
                  onError: (info) => PublicWidget.buildErrorWidget(
                      isRefresh: true, callback: logic.onRefreshEvent),
                  onLoading: PublicWidget.buildStaticLoadingWidget(
                      isRefresh: true, callback: logic.onRefreshEvent)))
        ],
      ),
    );
  }
  
  Widget _buildListItemWidget(int index, ${_viewName.replaceAll("Page", "").pascalCase}Entity info) {
    return GestureDetector(
      onTap: () => logic.itemTap(index, info),
      child: Container(
      margin: const EdgeInsets.all(12).copyWith(bottom: 0),
      padding: const EdgeInsets.all(12),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          ),
      child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(info.name.noNullStr),
                Text(info.createTime.safeSubTo(10)),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(info.name.noNullStr),
                const WidgetNormalImage(
                  url: Assets.tabPrescriptionNormal,
                  width: 64,
                  height: 64,
                ),
                Text(info.createTime.safeSubTo(10)),
              ],
            )
          ],
        ),
    ),
    );
  }
}
  ''';

  String get _serverView =>
      '''import 'package:get_server/get_server.dart'; $import

class $_viewName extends $_controllerName {
  @override
  Widget build(BuildContext context) {
    return const Text('GetX to Server is working!');
  }
}
  ''';

  @override
  String get content {
    if (_isServer) {
      return _serverView;
    }
    if (pageType == 1) {
      return _flutterListView;
    }
    return _flutterView;
  }
}
