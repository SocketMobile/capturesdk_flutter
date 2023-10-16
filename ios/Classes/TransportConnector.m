// The Transport Connector wires the protocol defined by pigeon in IosTransport.h
// to CaptureSDK.

// It also handles the events coming from CaptureSDK by converting them in JSON
// format so that the Dart side can create a Dart object corresponding to the event
// The only type checking in this case is assumed by checking the event type member
// which indicates the type of the data of the event received.

// The Type checking is less important for the events coming from the CaptureSDK
// since they are expected to be generated correctly by the Capture SDK.

#import "IosTransport.h"
#import <CaptureSDK/CaptureSDK.h>
#import "CaptureFlutterHandle.h"
#import "TransportConnector.h"

@implementation TransportConnector{
    BOOL connectionRestarted;
}

- (void)openClientAppInfo:(nullable IosAppInfo *)appInfo completion:(void(^)(IosTransportHandle *_Nullable, FlutterError *_Nullable))completion{
    SKTAppInfo* sktAppInfo = [SKTAppInfo new];
    sktAppInfo.DeveloperID = appInfo.developerId;
    sktAppInfo.AppID = appInfo.appId;
    sktAppInfo.AppKey = appInfo.appKey;
    SKTCapture* capture = nil;
    NSNumber* captureHandle;
    if(self->_handles == nil){
        self->connectionRestarted = FALSE;
        self->_handles = [CaptureFlutterHandle new];
        capture = [[SKTCapture alloc] initWithDelegate: self];
        captureHandle = [self->_handles addNewObject:capture];
    }
    else{
        if(connectionRestarted == FALSE){
            [NSOperationQueue.mainQueue addOperationWithBlock:^{
                NSNumber* firstHandle = [self->_handles getFirstHandle];
                SKTCapture* capture = [self->_handles getObjectFromHandle:firstHandle];
                [self closeDevicesButThisHandle: firstHandle withCompletion:^{
                    [capture closeWithCompletionHandler:^(SKTResult result) {
                        self->connectionRestarted = TRUE;
                        [self openClientAppInfo:appInfo
                                     completion:^(IosTransportHandle * _Nullable tspHandle, FlutterError * _Nullable flutterError) {
                            self->connectionRestarted = FALSE;
                            completion(tspHandle, flutterError);
                        }];
                    }];
                }];
            }];
            return;
        }
    }
    if(capture == nil){
        captureHandle = [self->_handles getFirstHandle];
        capture = [self->_handles getObjectFromHandle:captureHandle];
    }
    [capture openWithAppInfo:sktAppInfo completionHandler:^(SKTResult result){
        IosTransportHandle* handle = nil;
        FlutterError* res = nil;
        if(result < SKTCaptureE_NOERROR){
            [self->_handles removeObjectFromHandle:captureHandle];
            handle = nil;
            res = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld", (long)result] message:@"Unable to open Capture" details:nil];
        }
        else{
            handle = [IosTransportHandle new];
            handle.value = captureHandle;
        }
        completion(handle, res);
    }];
}

- (void)openDeviceHandle:(nullable IosTransportHandle *)handle guid:(nullable NSString *)guid completion:(void(^)(IosTransportHandle *_Nullable, FlutterError *_Nullable))completion{
    if(_handles != nil){
        @try{
            SKTCapture* mainCapture = (SKTCapture*)[_handles getObjectFromHandle:[handle value]];
            [mainCapture openDeviceWithGuid:guid completionHandler:^(SKTResult result, SKTCapture * _Nullable deviceCapture) {
                NSNumber* captureHandle = [self->_handles addNewObject:deviceCapture];
                FlutterError* error = nil;
                IosTransportHandle* handle = [IosTransportHandle new];
                handle.value = captureHandle;
                completion(handle, error);
            }];
        }
        @catch(NSException* e){
            NSLog(@"Exception in TransportConnector: %@", e);
            FlutterError* err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)SKTCaptureE_INVALIDHANDLE] message:@"The handle is invalid" details:nil];
            completion(nil, err);
        }
    }
    else {
        FlutterError* err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)SKTCaptureE_NOTINITIALIZED] message:@"Capture is not initialized, did you open Capture first?" details:nil];
        completion(nil, err);
    }
}

- (void)closeHandle:(nullable IosTransportHandle *)handle completion:(void(^)(IosTransportResult *_Nullable, FlutterError *_Nullable))completion{
    if(_handles != nil){
        SKTCapture* capture = (SKTCapture*)[_handles removeObjectFromHandle:[handle value]];
        [capture closeWithCompletionHandler:^(SKTResult result) {
            if(result>= SKTCaptureE_NOERROR){
                IosTransportResult* res = [IosTransportResult new];
                res.value = [NSNumber numberWithLong: result];
                completion(res, nil);
            }
            else {
                FlutterError* err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)result] message:@"Unable to close with the provided handle" details:nil];
                completion(nil, err);
            }
        }];
    }
}

- (void)getPropertyHandle:(nullable IosTransportHandle *)handle property:(nullable Property *)property completion:(void(^)(Property *_Nullable, FlutterError *_Nullable))completion{
    if(_handles != nil){
        @try{
            SKTCapture* capture = (SKTCapture*)[_handles getObjectFromHandle:[handle value]];
            SKTCaptureProperty* captureProperty = [TransportConnector convertToCaptureProperty: property];
            [capture getProperty:captureProperty completionHandler:^(SKTResult result, SKTCaptureProperty * _Nullable complete) {
                Property* responseProperty = nil;
                FlutterError* flutterError = nil;
                if(result >= SKTCaptureE_NOERROR){
                    responseProperty = [TransportConnector convertToDartProperty: complete];
                }
                else{
                    flutterError = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)result] message:[NSString stringWithFormat:@"Unable to get the property %ld",(long)captureProperty.ID] details:nil];
                }
                completion(responseProperty, flutterError);
            }];
        }
        @catch(NSException* e){
            NSLog(@"Exception in TransportConnector: %@", e);
            FlutterError* err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)SKTCaptureE_INVALIDHANDLE] message:@"The handle is invalid" details:nil];
            completion(nil, err);
        }
    }
    else {
        FlutterError* err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)SKTCaptureE_NOTINITIALIZED] message:@"Capture is not initialized, did you open Capture first?" details:nil];
        completion(nil, err);
    }
}

- (void)setPropertyHandle:(nullable IosTransportHandle *) handle property:(nullable Property *)property completion:(void(^)(Property *_Nullable, FlutterError *_Nullable))completion{
    if(_handles != nil){
        @try{
            SKTCapture* capture = (SKTCapture*)[_handles getObjectFromHandle:[handle value]];
            SKTCaptureProperty* captureProperty = [TransportConnector convertToCaptureProperty: property];
            [capture setProperty:captureProperty completionHandler:^(SKTResult result, SKTCaptureProperty * _Nullable complete) {
                Property* responseProperty = nil;
                FlutterError* flutterError = nil;
                if(result >= SKTCaptureE_NOERROR){
                    responseProperty = [TransportConnector convertToDartProperty: complete];
                }
                else{
                    flutterError = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)result] message:[NSString stringWithFormat:@"Unable to get the property %ld",(long)captureProperty.ID] details:nil];
                }
                completion(responseProperty, flutterError);
            }];
        }
        @catch(NSException* e){
            NSLog(@"Exception in TransportConnector: %@", e);
            FlutterError* err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)SKTCaptureE_INVALIDHANDLE] message:@"The handle is invalid" details:nil];
            completion(nil, err);
        }
    }
    else {
        FlutterError* err = [FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",(long)SKTCaptureE_NOTINITIALIZED] message:@"Capture is not initialized, did you open Capture first?" details:nil];
        completion(nil, err);
    }
}

-(void)closeDevicesButThisHandle:(NSNumber*) handle
                  withCompletion:(void(^)(void))completion{
    NSEnumerator* enumeration = [self->_handles getEnumator];

    NSString* handleKey = [CaptureFlutterHandle getKeyHandle:handle];
    [self closeNextDeviceFromEnumerator:enumeration
                          notThisHandle:handleKey
                         withCompletion:completion];
}

-(void)closeNextDeviceFromEnumerator:(NSEnumerator*)enumeration
                       notThisHandle:(NSString*)handle
                      withCompletion:(void(^)(void))completion{
    NSString* key = [enumeration nextObject];
    if(key != nil){
        if([key containsString:handle] == FALSE){
            SKTCapture* device = (SKTCapture*)[self->_handles removeObjectFromHandleString:key];
            [device closeWithCompletionHandler:^(SKTResult result) {
                [self closeNextDeviceFromEnumerator:enumeration
                                      notThisHandle:handle
                                     withCompletion:completion];
            }];
        }
        else{
            [self closeNextDeviceFromEnumerator:enumeration
                                  notThisHandle:handle
                                 withCompletion:completion];
        }
    }
    else {
        completion();
    }
}

+ (SKTCaptureProperty*) convertToCaptureProperty:(Property*) property {
    SKTCaptureProperty* captureProperty = [SKTCaptureProperty new];
    captureProperty.ID = property.propertyId.intValue;
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
            captureProperty.ArrayValue = [NSKeyedArchiver archivedDataWithRootObject:property.arrayValue];
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
            captureProperty.Object = [TransportConnector  InjectRootUiViewIfOverlayProperty:property.propertyId fromContext: property.objectValue];
            break;
        case SKTCapturePropertyTypeLastType:
            break;
    }
    return captureProperty;
}

+ (Property*) convertToDartProperty:(SKTCaptureProperty* _Nullable) property{
    Property* dartProperty = [Property new];
    dartProperty.propertyId = [[NSNumber alloc]initWithInt: (int)property.ID];
    dartProperty.type = [[NSNumber alloc]initWithInt:(int)property.Type];
    switch(property.Type){
        case SKTCapturePropertyTypeNone:
            break;
        case SKTCapturePropertyTypeNotApplicable:
            break;
        case SKTCapturePropertyTypeByte:
            dartProperty.byteValue = [[NSNumber alloc]initWithInt:(UInt8)property.ByteValue];
            break;
        case SKTCapturePropertyTypeUlong:
            dartProperty.longValue = [[NSNumber alloc]initWithLong:property.ULongValue];
            break;
        case SKTCapturePropertyTypeArray:
            dartProperty.arrayValue = [NSKeyedUnarchiver unarchiveObjectWithData:property.ArrayValue];
            break;
        case SKTCapturePropertyTypeString:
            dartProperty.stringValue = property.StringValue;
            break;
        case SKTCapturePropertyTypeVersion:
            dartProperty.versionValue = [Version new];
            dartProperty.versionValue.major = [[NSNumber alloc]initWithLong: property.Version.Major];
            dartProperty.versionValue.middle = [[NSNumber alloc]initWithLong: property.Version.Middle];
            dartProperty.versionValue.minor = [[NSNumber alloc]initWithLong: property.Version.Minor];
            dartProperty.versionValue.build = [[NSNumber alloc]initWithLong: property.Version.Build];
            dartProperty.versionValue.year = [[NSNumber alloc]initWithLong: property.Version.Year];
            dartProperty.versionValue.month = [[NSNumber alloc]initWithLong: property.Version.Month];
            dartProperty.versionValue.day = [[NSNumber alloc]initWithLong: property.Version.Day];
            dartProperty.versionValue.hour = [[NSNumber alloc]initWithLong: property.Version.Hour];
            dartProperty.versionValue.minute = [[NSNumber alloc]initWithLong: property.Version.Minute];
            break;
        case SKTCapturePropertyTypeDataSource:
            dartProperty.dataSourceValue = [DataSource new];
            dartProperty.dataSourceValue.id = [[NSNumber alloc]initWithInt: (int)property.DataSource.ID];
            dartProperty.dataSourceValue.status = [[NSNumber alloc]initWithInt: (int)property.DataSource.Status];
            dartProperty.dataSourceValue.flags = [[NSNumber alloc]initWithInt: (int)property.DataSource.Flags];
            dartProperty.dataSourceValue.name = property.DataSource.Name;
            break;
        case SKTCapturePropertyTypeEnum:
            break;
        case SKTCapturePropertyTypeObject:
            dartProperty.objectValue = property.Object;
            break;
        case SKTCapturePropertyTypeLastType:
            break;
    }
    return dartProperty;
}

// Replace YourViewController with the name of your main view controller class
+ (UIViewController *)getPresentedViewController {
    UIViewController *topViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topViewController.presentedViewController) {
        topViewController = topViewController.presentedViewController;
    }
    return topViewController;
}

+(NSDictionary*)InjectRootUiViewIfOverlayProperty:(NSNumber*)propertyId fromContext: (NSDictionary*)socketCamContext {
    if (propertyId.intValue == SKTCapturePropertyIDOverlayViewDevice) {
           UIViewController *mainUiViewController = [TransportConnector getPresentedViewController];
           NSMutableDictionary *socketCamContextModif = [NSMutableDictionary dictionaryWithDictionary:socketCamContext];
           [socketCamContextModif setObject:mainUiViewController forKey:SKTCaptureSocketCamContext];

           return socketCamContextModif;
       }

       return nil;

}

- (void)didReceiveEvent:(SKTCaptureEvent * _Nonnull)event forCapture:(SKTCapture * _Nonnull)capture withResult:(SKTResult)result {
    if(_flutterEvent != nil){
      NSNumber* handle = [_handles findHandleFromObject:capture];
      NSString* json = [self createJsonFromHandle:handle withResult:result forEvent:event];
      (_flutterEvent)(json);
    }
}

- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    FlutterError* error = nil;
    _flutterEvent = nil;
    return error;
}

- (FlutterError * _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(nonnull FlutterEventSink)events {
    FlutterError* error = nil;
    
    _flutterEvent = events;
    
    return error;
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
-(NSString*)createJsonFromHandle:(NSNumber*)handle withResult:(SKTResult)result forEvent:(SKTCaptureEvent*) event {
    NSMutableString* json = [NSMutableString stringWithFormat:@"{\"handle\": %d, \"result\": %ld, \"event\":{ \"id\": %ld, \"type\": %ld",handle.intValue, (long)result,(long)event.ID, (long)event.Data.Type];
    switch(event.Data.Type){
            
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
            [json appendString:@", \"value\": {"];
            [json appendFormat:@"\"data\": %@,", [TransportConnector ConvertToStringFromData:event.Data.DecodedData.DecodedData]];
            [json appendFormat:@"\"id\": %ld,", (long)event.Data.DecodedData.DataSourceID];
            [json appendFormat:@"\"name\": \"%@\"}}}", event.Data.DecodedData.DataSourceName];
            break;
        case SKTCaptureEventDataTypeDeviceInfo:
            [json appendString:@", \"value\": {"];
            [json appendFormat:@"\"type\": %ld, ",event.Data.DeviceInfo.DeviceType];
            [json appendFormat:@"\"guid\": \"%@\", ",event.Data.DeviceInfo.Guid];
            [json appendFormat:@"\"name\": \"%@\"",event.Data.DeviceInfo.Name];
            if(event.Data.DeviceInfo.Handle > 0){
                [json appendFormat:@", \"handle\": %ld}}}",(long)event.Data.DeviceInfo.Handle];
            }
            else {
                [json appendString:@"}}}"];
            }
            break;
        case SKTCaptureEventDataTypeLastID:
            [json appendString:@"}}"];
            break;
    }
    return json;
}

+(NSString*) ConvertToStringFromData:(NSData*)data {
    NSMutableString* stringData = [NSMutableString stringWithString:@"["];
    const char* bytes = data.bytes;
    for(int i = 0; i < data.length; i++){
        if(i == 0){
            [stringData appendFormat:@"%d", bytes[i]];
        }
        else {
            [stringData appendFormat:@",%d", bytes[i]];
        }
    }
    [stringData appendString:@"]"];
    return stringData;
}

@end

