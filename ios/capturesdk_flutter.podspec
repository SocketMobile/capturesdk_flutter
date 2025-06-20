Pod::Spec.new do |s|
  s.name                = 'capturesdk_flutter'
  s.version             = '1.5.60'
  s.summary             = 'Flutter CaptureSDK for Socket Mobile Inc.'
  s.description         = 'The official Flutter CaptureSDK by Socket Mobile. It supports all current Socket Mobile’s barcode and NFC Reader scanning solutions.'
  s.homepage            = 'https://docs.socketmobile.dev/captureflutter/en/latest'
  s.license             = { :type => 'MIT', :file => 'LICENSE' }
  s.author              = { 'Socket Mobile' => 'sdksupport@socketmobile.com' }
  s.source              = { :path => '.' }
  s.source_files        = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.platforms           = { :ios => "13.0" }
  s.dependency 'Flutter'
  s.dependency 'CaptureSDK', '~>1.9.139'
  s.static_framework    = true
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
