import 'package:new_university_communication/service/js_engines/js_vm.dart';

JsVMService getJsVM() => OtherFailEngine();

class OtherFailEngine implements JsVMService {
  @override
  Future<dynamic> callJS(String function) async {
    throw UnsupportedError("Function not support this device");
  }

  @override
  Future callJSAsync(String function) async {
    throw UnsupportedError("Function not support this device");
  }
}
