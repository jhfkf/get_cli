import '../interface/sample_interface.dart';

/// [Sample] file from [app_routes] file creation.
class RouteSample extends Sample {
  RouteSample({String path = 'lib/app/routes/routes_names.dart'}) : super(path);
  @override
  String get content => '''part of 'routes_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes{
  Routes._();

}

abstract class _Paths {
  
  _Paths._();

}

''';
}
