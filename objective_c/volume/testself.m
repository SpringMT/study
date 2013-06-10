#import <Foundation/NSObject.h>
#import <stdio.h>

@interface A : NSObject
- (void)method1;
- (void)method2;
@end

@implementation A
- (void)method1 { printf("method1 of class A\n"); }
- (void)method2 { printf("method2 of class A\n"); }
@end

@interface B : A
- (void)method2;
@end

@implementation B
- (void)method2 {
  printf("method2 of class B\n");
  printf("self ---> ");
  [self method1];
  printf("super ---> ");
  [super method2];
}
@end

@interface C : B
- (void)method1;
@end

@implementation C
- (void)method1 { printf("method1 of class C \n"); }
@end

int main(void) {
  id b = [[B alloc] init];
  id c = [[C alloc] init];
  printf("instance of B \n");
  [b method1];
  [b method2];
  printf("instance of C \n");
  [c method1];
  [c method2];
  return 0;
}

