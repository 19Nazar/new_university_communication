import 'dart:js' as js;
import 'dart:async';

import 'package:new_university_communication/service/js_engines/js_vm.dart';

JsVMService getJsVM() => WebJsVMService();

class WebJsVMService implements JsVMService {
  WebJsVMService() {}

  @override
  Future<dynamic> callJS(String function) async {
    final res = js.context.callMethod('eval', [function]);
    print(res);
    return res;
  }

  @override
  Future callJSAsync(String function) async {
    var completer = Completer<dynamic>();

    var jsPromise = js.context.callMethod('eval', [function]);

    jsPromise.callMethod('then', [
      (result) {
        completer.complete(result);
      }
    ]);

    jsPromise.callMethod('catch', [
      (error) {
        completer.completeError(error.toString());
      }
    ]);

    return completer.future;
  }
}
