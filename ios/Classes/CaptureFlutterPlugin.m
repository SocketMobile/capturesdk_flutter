#import "CaptureFlutterPlugin.h"
#import "IosTransport.h"
#import "CaptureFlutterHandle.h"
#import "TransportConnector.h"

@implementation CaptureFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {

  // iOS Transport for sending message to Capture with Pigeon
  TransportConnector* transport = [TransportConnector new];
  IosTransportSetup([registrar messenger], transport);

  // Event Channel for Capture Event notifications
  FlutterEventChannel* eventChannel = [FlutterEventChannel 
                                    eventChannelWithName:@"captureevent" 
                                        binaryMessenger:[registrar messenger]];
  [eventChannel setStreamHandler:transport];
}


@end