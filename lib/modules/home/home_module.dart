import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_university_communication/modules/home/page/home_page.dart';
import 'package:new_university_communication/routes/routes.dart';

class HomeModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(Routes.home.page, child: (context) => HomePage());
  }
}
