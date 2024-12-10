class Routes {
  static final _Home home = _Home();
  static final _Template template = _Template();
}

class _Home extends RouteClass {
  String module = '/';
  String page = "/home";
  // String addModel = '/addModel';
}

abstract class RouteClass {
  String module = '/';

  String getRoute(String moduleRoute) => module + moduleRoute;

  String getModule() => '$module/';
}

class _Template extends RouteClass {
  String init = '/';

  String auth_teacher_module = "/auth-teacher-module";
  String auth_student_module = "/auth-student-module";

  String notificationHandler = "/notification-handler";
}
