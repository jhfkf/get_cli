import 'package:recase/recase.dart';

import '../../common/utils/pubspec/pubspec_utils.dart';
import '../interface/sample_interface.dart';

/// [Sample] file from Module_Binding file creation.
class StateSample extends Sample {
  final String _fileName;
  final String _controllerDir;
  final String _stateName;
  final bool _isServer;
  int pageType = 0;

  StateSample(String path, this._fileName, this._stateName,
      this._controllerDir, this._isServer,
      {bool overwrite = false, this.pageType = 0})
      : super(path, overwrite: overwrite);

  String get _import => "";

//   @override
//   String get content => '''
//
// class $_stateName {
//   $_stateName() {
//     ///Initialize variables
//   }
// }
// ''';

  @override
  String get content {
    if (pageType == 1) {
      return '''
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class $_stateName {

  RefreshController controller = RefreshController();
  
  int limit = 10;
  
  var ${_stateName.substring(0, _stateName.length - 5).camelCase}List = [];

  $_stateName() {
    ///Initialize variables
  }
}
''';
    }
    return '''
class $_stateName {
  $_stateName() {
    ///Initialize variables
  }
}
''';
  }
}
