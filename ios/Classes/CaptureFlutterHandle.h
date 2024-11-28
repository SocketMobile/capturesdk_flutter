//
//  CaptureFlutterHandle.h
//  Pods
//
//  Created by Eric Glaenzer on 12/13/21.
//

#ifndef CaptureFlutterHandle_h
#define CaptureFlutterHandle_h


@interface CaptureFlutterHandle : NSObject

-(NSNumber *)addNewObject:(NSObject *)obj;
-(NSObject *)getObjectFromHandle:(NSNumber *)handle;
-(void)removeHandle:(NSNumber *)handle;
-(NSNumber *)findHandleFromObject:(id)object;
-(NSInteger)getCount;
-(NSNumber *)getFirstHandle;
-(NSEnumerator *)getEnumator;

@end

#endif /* CaptureFlutterHandle_h */
