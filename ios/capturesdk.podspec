#
# Run `pod lib lint capturesdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'capturesdk'
  s.version          = '1.2.76'
  s.summary          = 'Flutter SDK for Socket Mobile Capture Library.'
  s.description      = 'This is the Flutter CaptureSDK provided by Socket Mobile Inc."'
                       
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
  s.dependency 'SKTCaptureObjC', '~>1.3'
  s.platform = :ios, '10.1'
  s.static_framework = true
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end