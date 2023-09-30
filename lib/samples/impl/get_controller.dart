import 'package:recase/recase.dart';

import '../interface/sample_interface.dart';

/// [Sample] file from Module_Controller file creation.
class ControllerSample extends Sample {
  final String _fileName;
  final bool _isServer;
  int pageType = 0;
  ControllerSample(String path, this._fileName, this._isServer,
      {bool overwrite = false, this.pageType = 0})
      : super(path, overwrite: overwrite);

  @override
  String get content {
    if (_isServer) {
      return serverController;
    }
    if (pageType == 1) {
      return flutterListController;
    }
    return flutterController;
  }

  String get serverController => '''import 'package:get_server/get_server.dart';

class ${_fileName.pascalCase}Controller extends GetxController {
  //TODO: Implement ${_fileName.pascalCase}Controller

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
''';
  String get flutterController => '''import 'package:get/get.dart';

import 'state.dart';

class ${_fileName.pascalCase}Logic extends GetxController {
  //TODO: Implement ${_fileName.pascalCase}Logic
  
  // @override
  final ${_fileName.pascalCase}State state = ${_fileName.pascalCase}State();

  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onReady() {
    super.onReady();
  }
  @override
  void onClose() {
    super.onClose();
  }
}
''';
  String get flutterListController => '''import 'package:get/get.dart';

import '../../api/api.dart';
import '../../../app/utils/extensions/index.dart';
import '../../utils/widget/widget_smart_refresher.dart';
import '../../../generated/assets.dart';

import 'state.dart';

class ${_fileName.pascalCase}Logic extends GetxController with StateMixin {
  //TODO: Implement ${_fileName.pascalCase}Logic
  
  @override
  final ${_fileName.pascalCase}State state = ${_fileName.pascalCase}State();

  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onReady() {
    super.onReady();
    change(null, status: RxStatus.loading());
    onLoadingEvent();
  }
  
  // 刷新事件
  Future<void> onRefreshEvent() async {
    state.${_fileName.camelCase}List.clear();
    onLoadingEvent();
  }
  
  // 加载事件
  Future<void> onLoadingEvent() async {
    await loadData();
  }
  
    // 请求列表
  Future loadData() async {
    var pageNum = calculationRequestPage(
      dataLen: state.${_fileName.camelCase}List.length,
      limitLen: state.limit,
    );
    DataResult result = await UtilsApi.baseNormalRequest(
      url: Api.url,
      requestType: AppRequestType.get,
      params: {
        "pageNum": pageNum,
        "pageSize": state.limit,
      },
    );
    if (!result.result) {
      change(null, status: RxStatus.error());
      return;
    }
    // 将从服务器获取的数据转换为模型
    if (result.data != null) {
      PageEntity pageEntity = PageEntity.fromJson(result.data);
      List<${_fileName.pascalCase}Entity> newRequestData =
      List.from(pageEntity.list!.toList())
          .map((e) => ${_fileName.pascalCase}Entity.fromJson(e))
          .toList();
      if (newRequestData.length < state.limit) {
        // 已经加载至尾页-设置不可上拉
        state.controller.loadNoData();
      } else {
        state.controller.loadComplete();
      }
      // 添加进本地列表
      state.${_fileName.camelCase}List.addAll(newRequestData);
      if (newRequestData.isNotEmpty) {
        change(null, status: RxStatus.success());
        update();
      } else {
        change(null, status: RxStatus.empty());
      }
    }
  }
  
  itemTap(index, info) {

  }
  
  @override
  void onClose() {
    super.onClose();
  }
}
''';
}
