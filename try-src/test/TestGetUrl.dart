    import '../../../../../../../D:/Program/dart/dart-sdk/lib/io/io.dart';
    import '../../../../../../../D:/Program/dart/dart-sdk/lib/async/async.dart';
    import '../../../../../../../D:/Program/dart/dart-sdk/lib/convert/convert.dart';

    void main() {
      HttpClient hc = new HttpClient();
      hc.getUrl(Uri.parse("http://127.0.0.1:8091/pools"))
      .then((req) => req.close())
      .then((resp) => resp.first)
      .then((bytes) => print("${UTF8.decode(bytes)}"));
    }