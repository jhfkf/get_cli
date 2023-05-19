import 'package:recase/recase.dart';

import '../../common/utils/pubspec/pubspec_utils.dart';
import '../interface/sample_interface.dart';

/// [Sample] file from Module_Binding file creation.
class StateSample extends Sample {
  final String _fileName;
  final String _controllerDir;
  final String _stateName;
  final bool _isServer;

  StateSample(String path, this._fileName, this._stateName,
      this._controllerDir, this._isServer,
      {bool overwrite = false})
      : super(path, overwrite: overwrite);

  String get _import => "";

  @override
  String get content => '''
  
class $_stateName {
  $_stateName() {
    ///Initialize variables
  }
}
''';
}
