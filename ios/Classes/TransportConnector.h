#import <Flutter/Flutter.h>
#import <CaptureSDK/CaptureSDK.h>

@interface TransportConnector: NSObject<IosTransport, SKTCaptureDelegate, FlutterStreamHandler> {
    
    CaptureFlutterHandle *_handles;
    FlutterEventSink _flutterEvent;
    SKTCapture *_rootCapture;
    NSNumber *_rootCaptureHandle;

}

@end
