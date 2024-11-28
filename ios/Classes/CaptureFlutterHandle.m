//
//  CaptureFlutterHandle.m
//  captureflutter
//
//  Created by Eric Glaenzer on 12/13/21.
//

#import <Foundation/Foundation.h>
#import "CaptureFlutterHandle.h"


@implementation CaptureFlutterHandle {
    
    NSMutableDictionary *_handles;
    int _counter;
    NSNumber *_firstHandle; // root CaptureSDK object
    
}

-(NSNumber *)addNewObject:(NSObject *)obj {
    NSDate *date = [NSDate date];
    
    int cal = (int)[date timeIntervalSince1970];
    if (_handles == nil) {
        _handles = [NSMutableDictionary new];
        _counter = 0;
    }
    cal *= 1000;
    _counter += 1;
    cal += _counter;
    NSNumber *handle = [NSNumber numberWithInt:cal];
    [_handles setValue:obj forKey:handle.stringValue];
    if (_counter == 1) {
        _firstHandle = handle;
        NSLog(@"----> Root Capture opened: %@", handle);
    } else {
        NSLog(@"----> Device opened: %@", handle);
    }

    return handle;
}

-(NSObject *)getObjectFromHandle:(NSNumber *)handle {
    BOOL isValid = [self isValidHandle:handle];
    if (isValid) {
        return [_handles valueForKey:handle.stringValue];
    }

    return nil;
}

-(void)removeHandle:(NSNumber *)handle {
    if ([_handles.allKeys containsObject:handle.stringValue]) {
        [_handles removeObjectForKey:handle.stringValue];
    }
}

-(BOOL)isValidHandle:(NSNumber *)handle {
    return [_handles valueForKey:handle.stringValue] != nil;
}

-(NSNumber *)findHandleFromObject:(id)object {
    __block NSNumber *found;
    if (_handles != nil) {
        [_handles enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            *stop = NO;
            if (obj == object) {
                *stop = YES;
                found = key;
            }
        }];

        return found;
    } else {
        return nil;
    }
}

-(NSInteger)getCount {
    return [_handles count];
}

-(NSNumber *)getFirstHandle {
    return _firstHandle;
}

-(NSEnumerator *)getEnumator {
    return [_handles keyEnumerator];
}

@end
