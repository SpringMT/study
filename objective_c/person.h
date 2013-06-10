#import <Foundation/Foundation.h>

@interface Person : NSObject

@property NSString *firstname;
@property NSString *lastname;

+ (Person *)hogename:(NSString *)n;
- (NSString *)get_hogename;

@end


