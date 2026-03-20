#import "CaptureFlutterPlugin.h"
#import "IosTransport.h"
#import "CaptureFlutterHandle.h"
#import "TransportConnector.h"


#pragma mark - SocketCamPlatformView

@interface SocketCamPlatformView : NSObject <FlutterPlatformView>
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, weak) TransportConnector *transport;
@end

@implementation SocketCamPlatformView

- (instancetype)initWithFrame:(CGRect)frame transport:(TransportConnector *)transport {
    self = [super init];
    if (self) {
        _transport = transport;
        _containerView = [[UIView alloc] initWithFrame:frame];
        _containerView.backgroundColor = [UIColor blackColor];
        [self embedSocketCamView];
    }
    return self;
}

- (void)embedSocketCamView {
    UIViewController *socketCamVC = _transport.socketCamViewController;
    if (socketCamVC != nil) {
        socketCamVC.view.frame = _containerView.bounds;
        socketCamVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_containerView addSubview:socketCamVC.view];
    }
}

- (UIView *)view {
    return _containerView;
}

@end


#pragma mark - SocketCamViewFactory

@interface SocketCamViewFactory : NSObject <FlutterPlatformViewFactory>
@property (nonatomic, weak) TransportConnector *transport;
- (instancetype)initWithTransport:(TransportConnector *)transport;
@end

@implementation SocketCamViewFactory

- (instancetype)initWithTransport:(TransportConnector *)transport {
    self = [super init];
    if (self) {
        _transport = transport;
    }
    return self;
}

- (NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                    viewIdentifier:(int64_t)viewId
                                         arguments:(id _Nullable)args {
    return [[SocketCamPlatformView alloc] initWithFrame:frame transport:_transport];
}

- (NSObject<FlutterMessageCodec> *)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

@end


#pragma mark - CaptureFlutterPlugin

@implementation CaptureFlutterPlugin

+(void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {

    // iOS Transport for sending message to Capture with Pigeon
    TransportConnector *transport = [TransportConnector new];
    IosTransportSetup([registrar messenger], transport);

    // Event Channel for Capture Event notifications
    FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:@"captureevent"
                                                                  binaryMessenger:[registrar messenger]];
    [eventChannel setStreamHandler:transport];

    // PlatformView factory for SocketCamView widget
    [registrar registerViewFactory:[[SocketCamViewFactory alloc] initWithTransport:transport]
                            withId:@"com.socketmobile.capturesdk/socket_cam_view"];

    // MethodChannel for SocketCam native presentation
    FlutterMethodChannel *methodChannel =
        [FlutterMethodChannel methodChannelWithName:@"com.socketmobile.capturesdk/socket_cam"
                                    binaryMessenger:[registrar messenger]];
    CaptureFlutterPlugin *instance = [[CaptureFlutterPlugin alloc] initWithTransport:transport];
    [registrar addMethodCallDelegate:instance channel:methodChannel];
}

- (instancetype)initWithTransport:(TransportConnector *)transport {
    self = [super init];
    if (self) {
        _transport = transport;
    }
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([@"presentSocketCamFullScreen" isEqualToString:call.method]) {
        [self presentSocketCamFullScreenWithResult:result];
    } else if ([@"dismissSocketCam" isEqualToString:call.method]) {
        [self dismissSocketCamWithResult:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)presentSocketCamFullScreenWithResult:(FlutterResult)result {
    UIViewController *socketCamVC = _transport.socketCamViewController;
    if (socketCamVC == nil) {
        result([FlutterError errorWithCode:@"NO_VIEW_CONTROLLER"
                                   message:@"SocketCam view controller is not available. Did you call setTrigger first?"
                                   details:nil]);
        return;
    }
    UIViewController *presenter = [TransportConnector getPresentedViewController];
    if (presenter == nil) {
        result([FlutterError errorWithCode:@"NO_PRESENTER"
                                   message:@"Could not find a presenting view controller."
                                   details:nil]);
        return;
    }
    socketCamVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [presenter presentViewController:socketCamVC animated:YES completion:^{
        result(nil);
    }];
}

- (void)dismissSocketCamWithResult:(FlutterResult)result {
    UIViewController *presenter = [TransportConnector getPresentedViewController];
    if (presenter != nil &&
        ([presenter isKindOfClass:NSClassFromString(@"CaptureSDK.SocketCamViewController")] ||
         [presenter isKindOfClass:NSClassFromString(@"CaptureSDK.SocketCamSwiftDecoderViewController")])) {
        [presenter dismissViewControllerAnimated:YES completion:^{
            result(nil);
        }];
    } else {
        result(nil);
    }
}

@end
