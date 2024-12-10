import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_university_communication/modules/auth/auth_student/page/auth_student_page.dart';
import 'package:new_university_communication/routes/routes.dart';

class AuthStudentModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(Routes.template.init, child: (context) => AuthStudentPage());
  }
}
