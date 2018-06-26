#import "NSArray+Log.h"

@implementation NSArray (Log)

- (NSString *)description {
    
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [strM appendFormat:@"\t%@,\n", obj];
    
    }];
    
    [strM appendString:@")"];
    
    return strM;
}

@end

