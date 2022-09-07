//
//  CaptureFlutterHandle.h
//  Pods
//
//  Created by Eric Glaenzer on 12/13/21.
//

#ifndef CaptureFlutterHandle_h
#define CaptureFlutterHandle_h

@interface CaptureFlutterHandle : NSObject
+(NSString*)getKeyHandle:(NSNumber*)handle;
-(NSNumber*)addNewObject:(NSObject*)obj;
-(id)getObjectFromHandleString:(NSString*)handle;
-(id)getObjectFromHandle:(NSNumber*)handle;
-(id)removeObjectFromHandleString:(NSString*) handle;
-(id)removeObjectFromHandle:(NSNumber*) handle;
-(BOOL)isValidHandle:(NSNumber*)handle;
-(NSNumber*)findHandleFromObject:(id)object;
-(NSInteger)getCount;
-(NSNumber*)getFirstHandle;
-(NSEnumerator*) getEnumator;
@end
#endif /* CaptureFlutterHandle_h */
