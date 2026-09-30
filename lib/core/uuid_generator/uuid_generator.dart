import 'package:uuid/uuid.dart';

abstract interface class const UuidGenerator() {
  String v4();
}

final class const UuidGeneratorImpl(final Uuid _uuid) implements UuidGenerator{
  
  @override
  String v4() => _uuid.v4();
}