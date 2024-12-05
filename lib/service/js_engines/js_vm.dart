abstract class JsVMService {
  Future<dynamic> callJS(String function);

  Future<dynamic> callJSAsync(String function);
}
