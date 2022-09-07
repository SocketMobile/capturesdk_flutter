//
//  CaptureFlutterHandle.m
//  captureflutter
//
//  Created by Eric Glaenzer on 12/13/21.
//

#import <Foundation/Foundation.h>
#import "CaptureFlutterHandle.h"

@implementation CaptureFlutterHandle {
    NSDictionary* _handles;
    int _counter;
    NSNumber* _firstHandle; // root Capture
}

-(void)checkInitialized {
    if(_handles == nil){
        NSException *e = [NSException
      exceptionWithName:@"InvalidHandleException"
                  reason:@"There no handles"
                userInfo:nil];
        @throw e;
    }
}

-(void)checkHandle:(NSNumber*) handle {
    [self checkInitialized];
    if([self isValidHandle:handle] == NO){
        NSException *e = [NSException
      exceptionWithName:@"InvalidHandleException"
                  reason:@"No such handle valid"
                userInfo:nil];
        @throw e;
    }
}

+(NSString*)getKeyHandle:(NSNumber*)handle {
    return [NSString stringWithFormat:@"%d", [handle intValue]];
}

-(NSNumber*)addNewObject:(NSObject*)obj{
    NSDate* date = [NSDate date];
    
    int cal = (int)[date timeIntervalSince1970];
    if(_handles == nil){
        _handles = [NSMutableDictionary new];
        _counter = 0;
    }
    cal *= 1000;
    _counter += 1;
    cal += _counter;
    NSNumber* handle = [NSNumber numberWithInt:cal];
    [_handles setValue:obj forKey:[CaptureFlutterHandle getKeyHandle:handle]];
    if (_counter == 1){
        _firstHandle = handle;
    }
    return handle;
}

-(id)getObjectFromHandleString:(NSString*)handle{
    return [_handles valueForKey:handle];
}

-(id)getObjectFromHandle:(NSNumber*)handle{
    [self checkHandle:handle];
    return [self getObjectFromHandleString:[CaptureFlutterHandle getKeyHandle:handle]];
}

-(id)removeObjectFromHandleString:(NSString*) handle{
    NSObject* obj = [self getObjectFromHandleString:handle];
    NSMutableDictionary* dic = (NSMutableDictionary*)_handles;
    [dic removeObjectForKey:handle];
    return obj;
}

-(id)removeObjectFromHandle:(NSNumber*) handle{
    NSObject* obj = [self removeObjectFromHandleString:[CaptureFlutterHandle getKeyHandle:handle]];
    return obj;
}

-(BOOL)isValidHandle:(NSNumber*)handle{
    if(_handles == nil){
        return NO;
    }
    if([_handles valueForKey:[CaptureFlutterHandle getKeyHandle:handle]] == nil){
        return NO;
    }
    return YES;
}

-(NSNumber*)findHandleFromObject:(id)object{
    __block NSNumber* found;
    [self checkInitialized];
    [_handles enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        *stop = NO;
        if(obj == object){
            *stop = YES;
            found = key;
        }
    }];
    return found;
}

-(NSInteger)getCount {
    return [_handles count];
}

-(NSNumber*)getFirstHandle {
    return _firstHandle;
}

-(NSEnumerator*) getEnumator {
    return [_handles keyEnumerator];
}

@end
