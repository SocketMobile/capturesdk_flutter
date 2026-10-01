#import <Flutter/Flutter.h>

@class TransportConnector;

@interface CaptureFlutterPlugin : NSObject<FlutterPlugin>
@property (nonatomic, weak) TransportConnector *transport;
- (instancetype)initWithTransport:(TransportConnector *)transport;
@end
