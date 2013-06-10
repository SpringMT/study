/*
#import "Volume.h"
#import <stdio.h>

int main(void)
{
  id v, w;
  v = [[Volume alloc] initWithMin:0 max:10 step:2];
  w = [[Volume alloc] initWithMin:0 max:9 step:3];
  [v up];
  printf("%d %d\n", [v value], [w value]);
  [v up];
  [w up];
  printf("%d %d\n", [v value], [w value]);
  [v up];
  [w up];
  printf("%d %d\n", [v value], [w value]);
  return 0;
}
*/

#import "MuteVolume.h"
#import <stdio.h>

int main(void)
{
  id v;
  char buf[8];

  v = [[MuteVolume alloc] initWithMin:0 max:10 step:2];
  while (scanf("%s", buf) > 0 ) {
    switch (buf[0]) {
      case 'u': [v up];   break;
      case 'd': [v down]; break;
      case 'm': [v mute]; break;
      case 'q': return 0;
    }
    printf("Volume=%d\n", [v value]);
  }
  return 0;
}
