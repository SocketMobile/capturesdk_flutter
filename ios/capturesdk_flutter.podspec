#
# Run `pod lib lint capturesdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'capturesdk_flutter'
  s.version          = '1.3.0'
  s.summary          = 'Flutter CaptureSDK for Socket Mobile Inc.'
  s.description      = 'The official Flutter CaptureSDK by Socket Mobile. It supports all current Socket Mobile’s barcode and NFC Reader scanning solutions.'
                       
  s.homepage         = 'https://docs.socketmobile.com/captureflutter/en/latest'
  s.license           = {
    :type => 'MIT',
    :file => 'LICENSE'
    }
  s.author           = { 'Socket Mobile' => 'sdksupport@socketmobile.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platforms    = { :ios => "12.0" }
  s.dependency 'CaptureSDK', '~>1.8.34'
  s.static_framework = true
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end