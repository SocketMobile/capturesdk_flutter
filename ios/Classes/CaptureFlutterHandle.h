//
//  CaptureFlutterHandle.h
//  Pods
//
//  Created by Eric Glaenzer on 12/13/21.
//

#ifndef CaptureFlutterHandle_h
#define CaptureFlutterHandle_h

@interface CaptureFlutterHandle : NSObject
-(NSNumber*)addNewObject:(NSObject*)obj;
-(id)getObjectFromHandle:(NSNumber*)handle;
-(id)removeObjectFromHandle:(NSNumber*) handle;
-(BOOL)isValidHandle:(NSNumber*)handle;
-(NSNumber*)findHandleFromObject:(id)object;
@end
#endif /* CaptureFlutterHandle_h */
