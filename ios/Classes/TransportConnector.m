// The Transport Connector wires the protocol defined by pigeon in IosTransport.h
// to CaptureSDK.

// It also handles the events coming from CaptureSDK by converting them in JSON
// format so that the Dart side can create a Dart object corresponding to the event
// The only type checking in this case is assumed by checking the event type member
// which indicates the type of the data of the event received.

// The Type checking is less important for the events coming from the CaptureSDK
// since they are expected to be generated correctly by the CaptureSDK.

#import "IosTransport.h"
#import <CaptureSDK/CaptureSDK.h>
#import "CaptureFlutterHandle.h"
#import "TransportConnector.h"

@implementation TransportConnector{
    BOOL connectionRestarted;
}

-(void)openClientAppInfo:(IosAppInfo *)appInfo completion:(void(^)(IosTransportHandle *, FlutterError *))completion {
    SKTAppInfo *sktAppInfo = [SKTAppInfo new];
    sktAppInfo.DeveloperID = appInfo.developerId;
    sktAppInfo.AppID = appInfo.appId;
    sktAppInfo.AppKey = appInfo.appKey;
    if (self->_handles == nil) {
        connectionRestarted = NO;
        self->_handles = [CaptureFlutterHandle new];
        self->_rootCapture = [[SKTCapture alloc] initWithDelegate:self];
        self->_rootCaptureHandle = [self->_handles addNewObject:self->_rootCapture];
    } else {
        if(!connectionRestarted) { // This handles the Flutter Hot Restart
            [NSOperationQueue.mainQueue addOperationWithBlock:^{
                [self closeDevicesButThisHandle:self->_rootCaptureHandle withCompletion:^{
                    // Once the devices are all closed, proceed to close the Root Capture object.
                    // This may take until 8 seconds to make sure that all devices are closed and all operations have been completed
                    [self->_rootCapture closeWithCompletionHandler:^(SKTResult result) {
                        self->_rootCapture = nil;
                        self->_rootCaptureHandle = nil;
                        if (SKTSUCCESS(result)) {
                            NSLog(@"CaptureSDK has been closed successfully after the hot reload");
                            self->connectionRestarted = YES;
                            [self openClientAppInfo:appInfo
                                         completion:^(IosTransportHandle *tspHandle, FlutterError *flutterError) {
                                self->connectionRestarted = NO;
                                NSLog(@"CaptureSDK has been restarted successfully after the hot reload");
                                completion(tspHandle, flutterError);
                            }];
                        } else {
                            FlutterError *error = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld", (long)result]
                                                                      message:@"CaptureSDK - Error when closing"
                                                                      details:nil];
                            completion(nil, error);
                        }
                    }];
                }];
            }];

            return;
        }
    }
    if (self->_rootCapture == nil) {
        self->_rootCaptureHandle = [self->_handles getFirstHandle];
        self->_rootCapture = (SKTCapture *)[self->_handles getObjectFromHandle:self->_rootCaptureHandle];
    }
    [self->_rootCapture openWithAppInfo:sktAppInfo completionHandler:^(SKTResult result) {
        IosTransportHandle* handle = nil;
        FlutterError* res = nil;
        if (result < SKTCaptureE_NOERROR) {
            [self->_handles removeHandle:self->_rootCaptureHandle];
            handle = nil;
            res = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld", (long)result]
                                      message:@"Unable to open CaptureSDK"
                                      details:nil];
        }
        else{
            handle = [IosTransportHandle new];
            handle.value = self->_rootCaptureHandle;
        }
        completion(handle, res);
    }];
}

-(void)openDeviceHandle:(IosTransportHandle *)handle guid:(NSString *)guid completion:(void(^)(IosTransportHandle *, FlutterError *))completion {
    if (self->_handles != nil) {
        @try {
            if (self->_rootCapture != nil) {
                [self->_rootCapture openDeviceWithGuid:guid completionHandler:^(SKTResult result, SKTCapture *deviceCapture) {
                    if (result >= SKTCaptureE_NOERROR) {
                        NSNumber *deviceHandle = [self->_handles addNewObject:deviceCapture];
                        IosTransportHandle *handle = [IosTransportHandle new];
                        handle.value = deviceHandle;
                        completion(handle, nil);
                    } else {
                        FlutterError *err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)result]
                                                                message:[NSString stringWithFormat:@"Unable to open with the provided guid: %@", guid]
                                                                details:nil];
                        completion(nil, err);
                    }
                }];
            } else {
                FlutterError *err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)SKTCaptureE_INVALIDHANDLE]
                                                        message:@"Unable to oepn with the provided handle"
                                                        details:nil];
                completion(nil, err);
            }
        } @catch(NSException *e) {
            NSLog(@"Exception in TransportConnector: %@", e);
            FlutterError *err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)SKTCaptureE_INVALIDHANDLE]
                                                    message:@"The handle is invalid"
                                                    details:nil];
            completion(nil, err);
        }
    } else {
        FlutterError *err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)SKTCaptureE_NOTINITIALIZED]
                                                message:@"CaptureSDK is not initialized, did you open CaptureSDK first?"
                                                details:nil];
        completion(nil, err);
    }
}

-(void)closeHandle:(IosTransportHandle *)handle completion:(void(^)(IosTransportResult *, FlutterError *))completion {
    if (self->_handles != nil) {
        SKTCapture *capture = (SKTCapture *)[self->_handles getObjectFromHandle:handle.value];
        if (capture != nil) {
            [capture closeWithCompletionHandler:^(SKTResult result) {
                [self->_handles removeHandle:handle.value];
                if (result >= SKTCaptureE_NOERROR) {
                    IosTransportResult *res = [IosTransportResult new];
                    res.value = [NSNumber numberWithLong:result];
                    completion(res, nil);
                } else {
                    FlutterError *err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)result]
                                                            message:@"Unable to close with the provided handle"
                                                            details:nil];
                    completion(nil, err);
                }
            }];
        } else {
            FlutterError *err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)SKTCaptureE_INVALIDHANDLE]
                                                    message:@"Unable to close with the provided handle because it is invalid"
                                                    details:nil];
            completion(nil, err);
        }
    }
}

-(void)getPropertyHandle:(IosTransportHandle *)handle property:(Property *)property completion:(void(^)(Property *, FlutterError *))completion {
    if (self->_handles != nil) {
        @try {
            SKTCapture *capture = (SKTCapture *)[self->_handles getObjectFromHandle:handle.value];
            if (capture != nil) {
                SKTCaptureProperty *captureProperty = [TransportConnector convertToCaptureProperty:property];
                [capture getProperty:captureProperty completionHandler:^(SKTResult result, SKTCaptureProperty *complete) {
                    Property *responseProperty = nil;
                    FlutterError *flutterError = nil;
                    if (result >= SKTCaptureE_NOERROR) {
                        responseProperty = [TransportConnector convertToDartProperty:complete];
                    } else {
                        flutterError = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)result]
                                                           message:[NSString stringWithFormat:@"Unable to get the property %ld",(long)captureProperty.ID]
                                                           details:nil];
                    }
                    completion(responseProperty, flutterError);
                }];
            } else {
                FlutterError *err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)SKTCaptureE_INVALIDHANDLE]
                                                        message:@"Unable to get the provided handle because it is invalid"
                                                        details:nil];
                completion(nil, err);
            }
        } @catch(NSException *e) {
            NSLog(@"Exception in TransportConnector: %@", e);
            FlutterError *err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)SKTCaptureE_INVALIDHANDLE]
                                                    message:@"The handle is invalid"
                                                    details:nil];
            completion(nil, err);
        }
    } else {
        FlutterError *err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)SKTCaptureE_NOTINITIALIZED]
                                                message:@"CaptureSDK is not initialized, did you open CaptureSDK first?"
                                                details:nil];
        completion(nil, err);
    }
}

-(void)setPropertyHandle:(IosTransportHandle *) handle property:(Property *)property completion:(void(^)(Property *, FlutterError *))completion {
    if (self->_handles != nil) {
        @try {
            SKTCapture *capture = (SKTCapture *)[self->_handles getObjectFromHandle:handle.value];
            if (capture != nil) {
                SKTCaptureProperty *captureProperty = [TransportConnector convertToCaptureProperty:property];
                [capture setProperty:captureProperty completionHandler:^(SKTResult result, SKTCaptureProperty *complete) {
                    Property *responseProperty = nil;
                    FlutterError *flutterError = nil;
                    if (result >= SKTCaptureE_NOERROR) {
                        responseProperty = [TransportConnector convertToDartProperty: complete];
                    } else {
                        flutterError = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)result]
                                                           message:[NSString stringWithFormat:@"Unable to get the property %ld",(long)captureProperty.ID]
                                                           details:nil];
                    }
                    completion(responseProperty, flutterError);
                }];
            } else {
                FlutterError *err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)SKTCaptureE_INVALIDHANDLE]
                                                        message:@"Unable to get the provided handle because it is invalid"
                                                        details:nil];
                completion(nil, err);
            }
        } @catch(NSException *e) {
            NSLog(@"Exception in TransportConnector: %@", e);
            FlutterError *err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)SKTCaptureE_INVALIDHANDLE]
                                                    message:@"The handle is invalid"
                                                    details:nil];
            completion(nil, err);
        }
    } else {
        FlutterError *err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)SKTCaptureE_NOTINITIALIZED]
                                                message:@"CaptureSDK is not initialized, did you open CaptureSDK first?"
                                                details:nil];
        completion(nil, err);
    }
}

-(void)closeDevicesButThisHandle:(NSNumber *)handle withCompletion:(void(^)(void))completion {
    NSEnumerator *enumeration = [self->_handles getEnumator];
    [self closeNextDeviceFromEnumerator:enumeration notThisHandle:handle.stringValue withCompletion:completion];
}

-(void)closeNextDeviceFromEnumerator:(NSEnumerator *)enumeration notThisHandle:(NSString *)handle withCompletion:(void(^)(void))completion {
    NSString *key = [enumeration nextObject];
    if (key != nil) {
        if ([key isEqualToString:handle]) {
            [self closeNextDeviceFromEnumerator:enumeration notThisHandle:handle withCompletion:completion];
        } else {
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            f.numberStyle = NSNumberFormatterDecimalStyle;
            NSNumber *keyNumber = [f numberFromString:key];
            SKTCapture *device = (SKTCapture *)[self->_handles getObjectFromHandle:keyNumber];
            if (device != nil) {
                [device closeWithCompletionHandler:^(SKTResult result) {
                    [self->_handles removeHandle:keyNumber];
                    [self closeNextDeviceFromEnumerator:enumeration notThisHandle:handle withCompletion:completion];
                }];
            } else {
                [self closeNextDeviceFromEnumerator:enumeration notThisHandle:handle withCompletion:completion];
            }
        }
    } else {
        completion();
    }
}

+(SKTCaptureProperty *)convertToCaptureProperty:(Property *)property {
    SKTCaptureProperty *captureProperty = [SKTCaptureProperty new];
    captureProperty.ID = property.id.intValue;
    captureProperty.Type = property.type.intValue;
    switch(captureProperty.Type) {
        case SKTCapturePropertyTypeNone:
            break;
        case SKTCapturePropertyTypeNotApplicable:
            break;
        case SKTCapturePropertyTypeByte:
            captureProperty.ByteValue = (UInt8)[property.byteValue intValue];
            break;
        case SKTCapturePropertyTypeUlong:
            captureProperty.ULongValue = [property.longValue longValue];
            break;
        case SKTCapturePropertyTypeArray:
        {
            FlutterStandardTypedData *uintInt8List = (FlutterStandardTypedData *)property.arrayValue;
            captureProperty.ArrayValue = uintInt8List.data;
        }
            break;
        case SKTCapturePropertyTypeString:
            captureProperty.StringValue = property.stringValue;
            break;
        case SKTCapturePropertyTypeVersion:
            captureProperty.Version = [SKTCaptureVersion new];
            captureProperty.Version.Major = [property.versionValue.major intValue];
            captureProperty.Version.Middle = [property.versionValue.middle intValue];
            captureProperty.Version.Minor = [property.versionValue.minor intValue];
            captureProperty.Version.Build = [property.versionValue.build intValue];
            captureProperty.Version.Year = [property.versionValue.year intValue];
            captureProperty.Version.Month = [property.versionValue.month intValue];
            captureProperty.Version.Day = [property.versionValue.day intValue];
            captureProperty.Version.Hour = [property.versionValue.hour intValue];
            captureProperty.Version.Minute = [property.versionValue.minute intValue];
            break;
        case SKTCapturePropertyTypeDataSource:
            captureProperty.DataSource = [SKTCaptureDataSource new];
            captureProperty.DataSource.ID = [property.dataSourceValue.id intValue];
            captureProperty.DataSource.Status = [property.dataSourceValue.status intValue];
            captureProperty.DataSource.Name = property.dataSourceValue.name;
            captureProperty.DataSource.Flags = [property.dataSourceValue.flags intValue];
            break;
        case SKTCapturePropertyTypeEnum:
            break;
        case SKTCapturePropertyTypeObject:
            break;
        case SKTCapturePropertyTypeLastType:
            break;
    }

    return captureProperty;
}

+(Property *)convertToDartProperty:(SKTCaptureProperty *)property {
    Property *dartProperty = [Property new];
    dartProperty.id = [[NSNumber alloc] initWithInt:(int)property.ID];
    dartProperty.type = [[NSNumber alloc] initWithInt:(int)property.Type];
    switch(property.Type) {
        case SKTCapturePropertyTypeNone:
            break;
        case SKTCapturePropertyTypeNotApplicable:
            break;
        case SKTCapturePropertyTypeByte:
            dartProperty.byteValue = [[NSNumber alloc] initWithInt:(UInt8)property.ByteValue];
            break;
        case SKTCapturePropertyTypeUlong:
            dartProperty.longValue = [[NSNumber alloc] initWithLong:property.ULongValue];
            break;
        case SKTCapturePropertyTypeArray:
            dartProperty.arrayValue = (FlutterStandardTypedData *)property.ArrayValue;
            break;
        case SKTCapturePropertyTypeString:
            dartProperty.stringValue = property.StringValue;
            break;
        case SKTCapturePropertyTypeVersion:
            dartProperty.versionValue = [Version new];
            dartProperty.versionValue.major = [[NSNumber alloc] initWithLong:property.Version.Major];
            dartProperty.versionValue.middle = [[NSNumber alloc] initWithLong:property.Version.Middle];
            dartProperty.versionValue.minor = [[NSNumber alloc] initWithLong:property.Version.Minor];
            dartProperty.versionValue.build = [[NSNumber alloc] initWithLong:property.Version.Build];
            dartProperty.versionValue.year = [[NSNumber alloc] initWithLong:property.Version.Year];
            dartProperty.versionValue.month = [[NSNumber alloc] initWithLong:property.Version.Month];
            dartProperty.versionValue.day = [[NSNumber alloc] initWithLong:property.Version.Day];
            dartProperty.versionValue.hour = [[NSNumber alloc] initWithLong:property.Version.Hour];
            dartProperty.versionValue.minute = [[NSNumber alloc] initWithLong:property.Version.Minute];
            break;
        case SKTCapturePropertyTypeDataSource:
            dartProperty.dataSourceValue = [DataSource new];
            dartProperty.dataSourceValue.id = [[NSNumber alloc] initWithInt:(int)property.DataSource.ID];
            dartProperty.dataSourceValue.status = [[NSNumber alloc] initWithInt:(int)property.DataSource.Status];
            dartProperty.dataSourceValue.flags = [[NSNumber alloc] initWithInt:(int)property.DataSource.Flags];
            dartProperty.dataSourceValue.name = property.DataSource.Name;
            break;
        case SKTCapturePropertyTypeEnum:
            break;
        case SKTCapturePropertyTypeObject:
        {
            if (property.ID == SKTCapturePropertyIDTriggerDevice) {
                if ([property.Object isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *socketCamDictionary = (NSDictionary *)property.Object;
                    NSString *objectType = [socketCamDictionary objectForKey:@"SKTObjectType"];
                    if ([objectType isEqualToString:@"SKTSocketCamViewControllerType"]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if ([[socketCamDictionary objectForKey:@"SKTSocketCamViewController"] isKindOfClass:[UIViewController class]]) {
                                UIViewController* socketCamViewController = (UIViewController *)[socketCamDictionary objectForKey:@"SKTSocketCamViewController"];
                                if (socketCamViewController != nil) {
                                    UIViewController *mainUiViewController = [TransportConnector getPresentedViewController];
                                    socketCamViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
                                    [mainUiViewController presentViewController:socketCamViewController animated:YES completion:nil];
                                }
                            }
                        });
                    }
                }
            } else {
                dartProperty.objectValue = property.Object;
            }
        }
            break;
        case SKTCapturePropertyTypeLastType:
            break;
    }

    return dartProperty;
}

// Replace YourViewController with the name of your main view controller class
+(UIViewController *)getPresentedViewController {
    UIViewController *topViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topViewController.presentedViewController) {
        topViewController = topViewController.presentedViewController;
    }
    return topViewController;
}

-(void)didReceiveEvent:(SKTCaptureEvent *)event forCapture:(SKTCapture *)capture withResult:(SKTResult)result {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self->_flutterEvent != nil) {
            NSNumber *handle = [self->_handles findHandleFromObject:capture];
            NSString *json = [self createJsonFromHandle:handle withResult:result forEvent:event];
            (self->_flutterEvent)(json);
        }
    });
}

-(FlutterError *)onCancelWithArguments:(id)arguments {
    _flutterEvent = nil;

    return nil;
}

-(FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events {
    _flutterEvent = events;
    
    return nil;
}

/*
 * json string that will regroup all the information for
 * a capture event
 *
 * {
 *    "handle": -213123,
 *    "result": 0,
 *    "event": {
 *       "id": -213213,
 *       "type": 5,
 *       "value": {
 *          "data": [32,213,222,45,56,54,54,54],
 *          "dataSource": {}
 *        }
 *     }
 * }
 */
-(NSString *)createJsonFromHandle:(NSNumber *)handle withResult:(SKTResult)result forEvent:(SKTCaptureEvent *)event {
    NSMutableString *json = [NSMutableString stringWithFormat:@"{\"handle\": %d, \"result\": %ld, \"event\":{ \"id\": %ld, \"type\": %ld", handle.intValue, (long)result, (long)event.ID, (long)event.Data.Type];
    switch(event.Data.Type) {
        case SKTCaptureEventDataTypeNone:
            [json appendString:@"}}"];
            break;
        case SKTCaptureEventDataTypeByte:
            [json appendFormat:@", \"value\": %d }}", event.Data.ByteValue];
            break;
        case SKTCaptureEventDataTypeUlong:
            [json appendFormat:@", \"value\": %lu }}", event.Data.ULongValue];
            break;
        case SKTCaptureEventDataTypeArray:
            [json appendFormat:@", \"value\": %@ }}", [TransportConnector ConvertToStringFromData:event.Data.ArrayValue]];
            break;
        case SKTCaptureEventDataTypeString:
            [json appendFormat:@", \"value\": \"%@\" }}", event.Data.StringValue];
            break;
        case SKTCaptureEventDataTypeDecodedData:
        {
            [json appendString:@", \"value\": {"];
            [json appendFormat:@"\"data\": %@,", [TransportConnector ConvertToStringFromData:event.Data.DecodedData.DecodedData]];
            [json appendFormat:@" \"id\": %ld,", (long)event.Data.DecodedData.DataSourceID];

            if (event.Data.DecodedData.TagIdData.length > 0) {
              [json appendFormat:@" \"tagId\": \"%@\",", [TransportConnector stringFromTagIdData:event.Data.DecodedData.TagIdData]];
            }

            [json appendFormat:@" \"name\": \"%@\"}}}", event.Data.DecodedData.DataSourceName];

            dispatch_async(dispatch_get_main_queue(), ^{
                UIViewController *mainUiViewController = [TransportConnector getPresentedViewController];
                if ([mainUiViewController isKindOfClass:NSClassFromString(@"CaptureSDK.SocketCamViewController")] || [mainUiViewController isKindOfClass:NSClassFromString(@"CaptureSDK.SocketCamSwiftDecoderViewController")]) {
                    [mainUiViewController dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }
            });
        }
            break;
        case SKTCaptureEventDataTypeDeviceInfo:
            [json appendString:@", \"value\": {"];
            [json appendFormat:@"\"type\": %ld, ",event.Data.DeviceInfo.DeviceType];
            [json appendFormat:@"\"guid\": \"%@\", ",event.Data.DeviceInfo.Guid];
            [json appendFormat:@"\"name\": \"%@\"",event.Data.DeviceInfo.Name];
            if (event.Data.DeviceInfo.Handle > 0) {
                [json appendFormat:@", \"handle\": %ld}}}",(long)event.Data.DeviceInfo.Handle];
            } else {
                [json appendString:@"}}}"];
            }
            break;
        case SKTCaptureEventDataTypeLastID:
            [json appendString:@"}}"];
            break;
    }

    return json;
}

+(NSString *)ConvertToStringFromData:(NSData *)data {
    NSMutableString *stringData = [NSMutableString stringWithString:@"["];
    const char* bytes = data.bytes;
    for (int i = 0; i < data.length; i++) {
        if (i == 0) {
            [stringData appendFormat:@"%d", bytes[i]];
        } else {
            [stringData appendFormat:@",%d", bytes[i]];
        }
    }
    [stringData appendString:@"]"];

    return stringData;
}


+ (NSString *)stringFromTagIdData:(NSData *)tagIdData {
    const unsigned char *bytes = (const unsigned char *)tagIdData.bytes;
    NSMutableString *hexString = [NSMutableString stringWithCapacity:tagIdData.length * 2];
    for (NSUInteger i = 0; i < tagIdData.length; i++) {
        [hexString appendFormat:@"%02X", bytes[i]];
    }

    return hexString;
}

@end

