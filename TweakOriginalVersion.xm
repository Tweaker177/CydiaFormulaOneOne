#include <substrate.h>
#include <stdlib.h>
#import <UIKit/UIKit.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.i0stweak3r.cydiaformulaoneone~prefs.plist"
 
inline bool GetPrefBool(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}
/**
@interface CydiaObject : NSObject
- (NSString *)firmware
@end 
**/
@interface pkgSourceList: NSMutableArray
@end

@interface Database: NSObject
-(bool) popErrorWithTitle:(id)arg1 forReadList:(pkgSourceList*)arg2;
-(bool) popErrorWithTitle:(id)arg1;
@end




%hook UIActivityIndicatorView
-(id)_defaultColorForStyle:(long long)arg1 {
if(GetPrefBool(@"key3")) {
int r = arc4random_uniform(255);
int g = arc4random_uniform(255);
int b = arc4random_uniform(255);
UIColor *random=  [UIColor colorWithRed:(r/255.0) 
green:(g/255.0) blue:(b/255.0) alpha: 1 ];
return random;
%orig;
}
return %orig;
}
%end


%hook CyteObject
-(NSString *)firmware {

NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];
 
    NSString *text = [prefs objectForKey:@"text"];
  
    BOOL enabled = [[prefs valueForKey:@"enabled"] boolValue];

if([text isEqualToString:@""] || text == nil || !enabled) 
{
return %orig;
  }
    
    else if (enabled) {
        return text;
    }
else { return %orig; }
}
%end



%hook CydiaObject
-(NSString *)firmware {

NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];
 
    NSString *text = [prefs objectForKey:@"text"];
  
    BOOL enabled = [[prefs valueForKey:@"enabled"] boolValue];

if([text isEqualToString:@""] || text == nil || !enabled) 
{
return %orig;
  }
    
    else if (enabled) {
        return text;
    }
else { return %orig; }
}
%end

%hook Database
-(bool) popErrorWithTitle:(id)arg1 {
if(GetPrefBool(@"key1")) {
return FALSE;
}
return %orig;
}

-(bool) popErrorWithTitle:(id)arg1 forReadList:(id)arg2 {
if(GetPrefBool(@"key1")) {
arg1 = nil;
return %orig;
}
return %orig;
}
%end






