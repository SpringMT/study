#import "Volume.h"

@interface MuteVolume : Volume
{
  BOOL muting;
}
- (id)initWithMin: (int)a max: (int)b step: (int)s;
- (int)value;

- (id)mute;
@end


