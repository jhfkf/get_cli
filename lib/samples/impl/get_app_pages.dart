import '../../common/utils/pubspec/pubspec_utils.dart';
import '../interface/sample_interface.dart';

/// [Sample] file from [app_pages] file creation.
class AppPagesSample extends Sample {
  String initial;
  AppPagesSample(
      {String path = 'lib/app/routes/routes_pages.dart', this.initial = 'HOME'})
      : super(path);
  final import = PubspecUtils.getPackageImport;
  String get _initialRoute =>
      initial.isNotEmpty ? '\nstatic const INITIAL = Routes.$initial;' : '';

  @override
  String get content => '''$import
part 'routes_names.dart';

class AppPages {
   AppPages._();
  $_initialRoute

  static final routes = [
  ];
}
''';
}
