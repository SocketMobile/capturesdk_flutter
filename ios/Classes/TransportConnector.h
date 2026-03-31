#import <Flutter/Flutter.h>
#import <CaptureSDK/CaptureSDK.h>

@interface TransportConnector: NSObject<IosTransport, SKTCaptureDelegate, FlutterStreamHandler> {

    CaptureFlutterHandle *_handles;
    FlutterEventSink _flutterEvent;
    SKTCapture *_rootCapture;
    NSNumber *_rootCaptureHandle;
    NSMutableSet *_closingHandles;

}

@property (nonatomic, strong, nullable) UIViewController *socketCamViewController;

+(UIViewController * _Nullable)getPresentedViewController;

@end
