import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_university_communication/modules/auth/auth_teacher/page/auth_teacher_page.dart';
import 'package:new_university_communication/routes/routes.dart';

class AuthTeacherModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(Routes.template.init, child: (context) => AuthTeacherPage());
  }
}
