Pod::Spec.new do |s|
  s.name                = 'capturesdk_flutter'
  s.version             = '2.1.8'
  s.summary             = 'Flutter CaptureSDK for Socket Mobile Inc.'
  s.description         = 'The official Flutter CaptureSDK by Socket Mobile. It supports all current Socket Mobile’s barcode and NFC Reader scanning solutions.'
  s.homepage            = 'https://docs.socketmobile.dev/captureflutter/en/latest'
  s.license             = { :type => 'MIT', :file => 'LICENSE' }
  s.author              = { 'Socket Mobile' => 'sdksupport@socketmobile.com' }
  s.source              = { :path => '.' }
  s.source_files        = 'capturesdk_flutter/Sources/capturesdk_flutter/**/*.{h,m}'
  s.public_header_files = 'capturesdk_flutter/Sources/capturesdk_flutter/include/**/*.h'
  s.platforms           = { :ios => "15.0" }
  s.dependency 'Flutter'
  s.dependency 'CaptureSDK', '>2.1.22'
  s.static_framework    = true
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
