import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_university_communication/modules/auth/auth_student/auth_student_module.dart';
import 'package:new_university_communication/modules/auth/auth_teacher/auth_teacher_module.dart';
import 'package:new_university_communication/modules/home/page/home_page.dart';
import 'package:new_university_communication/routes/routes.dart';

class HomeModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(Routes.home.page, child: (context) => HomePage());
    r.module(Routes.template.auth_teacher_module, module: AuthTeacherModule());
    r.module(Routes.template.auth_student_module, module: AuthStudentModule());
  }
}
