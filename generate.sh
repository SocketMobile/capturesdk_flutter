flutter pub run pigeon \
  --input pigeons/pigeon_ios_transport.dart \
  --dart_out lib/classes/pigeon_ios_transport.dart \
  --objc_header_out ios/Runner/pigeon.h \
  --objc_source_out ios/Runner/pigeon.m \
  --java_out ./android/app/src/main/java/io/flutter/PigeonIosTransport.java \
  --java_package "io.flutter.plugins"