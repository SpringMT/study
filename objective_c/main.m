#import <Foundation/Foundation.h>
#import "Person.h"

int main (int argc, const char * argv[])
{
  @autoreleasepool {
    Person * p = [Person hogename:@"aaaaa"];
    NSString *foo = [p get_hogename];
    NSLog(@"name = %@", foo);
  }
  return 0;
}


