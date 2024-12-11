import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_university_communication/modules/auth/admin/page/admin_page.dart';
import 'package:new_university_communication/routes/routes.dart';

class AdminModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(Routes.template.init, child: (context) => AdminPage());
  }
}
