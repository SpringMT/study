#import "Person.h"

@implementation Person
+ (Person *)hogename:(NSString *)n
{
  Person *p = [[Person alloc] init];
  p.firstname = n;
  return p;
}

- (NSString *)get_hogename
{
  return _firstname;
}
@end

