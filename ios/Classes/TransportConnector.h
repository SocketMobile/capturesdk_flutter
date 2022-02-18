#import <Flutter/Flutter.h>

#import "SKTCapture.h"

@interface TransportConnector: NSObject<IosTransport, SKTCaptureDelegate, FlutterStreamHandler> {
    CaptureFlutterHandle* _handles;
    FlutterEventSink _flutterEvent;
}
// - (void)openClientAppInfo:(nullable IosAppInfo *)appInfo completion:(void(^)(IosTransportHandle *_Nullable, FlutterError *_Nullable))completion;
// - (void)openDeviceHandle:(nullable IosTransportHandle *)handle guid:(nullable NSString *)guid completion:(void(^)(IosTransportHandle *_Nullable, FlutterError *_Nullable))completion;
// - (void)closeHandle:(nullable IosTransportHandle *)handle completion:(void(^)(IosTransportResult *_Nullable, FlutterError *_Nullable))completion;
// - (void)getPropertyHandle:(nullable IosTransportHandle *)handle property:(nullable Property *)property completion:(void(^)(Property *_Nullable, FlutterError *_Nullable))completion;
// - (void)setPropertyHandle:(nullable IosTransportHandle *)handle property:(nullable Property *)property completion:(void(^)(Property *_Nullable, FlutterError *_Nullable))completion;
@end
