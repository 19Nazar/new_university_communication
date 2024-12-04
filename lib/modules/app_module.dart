import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_university_communication/modules/home/home_module.dart';
import 'package:new_university_communication/routes/routes.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module(Routes.home.getModule(), module: HomeModule());
  }
}
