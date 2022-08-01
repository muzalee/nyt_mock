import 'package:flutter_test/flutter_test.dart';
import 'package:nyt_mock/ui/search_provider.dart';

void main() {
  late SearchProvider sut;

  setUp(() {
    sut = SearchProvider();
  });

  test(
    "validate empty value", () async {
      sut.validate('');
      expect(sut.error, true);
    },
  );

  test(
    "validate not empty value", () async {
      sut.validate('value');
      expect(sut.error, false);
    },
  );
}