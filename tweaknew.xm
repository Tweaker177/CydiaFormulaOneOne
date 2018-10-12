#include <substrate.h>
#include <stdlib.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.i0stweak3r.cydiaformulaoneone~prefs.plist"
 
static NSString *loadingTitle;
static int separatorPrefs=1;
static bool kEnabled = YES;
static int statusBarColor = 1;
/**
static bool chevronPrefs = YES;
didn't get this to work tried to remove chevrons
but had wrong method...i forget lol
**/
static bool wantsTheme = YES;

static bool wantsHighlights = YES;

static int tabBarColor = 1;
static int navBarColor=1;
static int tableBarColor=1;
static int indexColorSlot = 1;
static int indexBGColorSlot = 1;
static int tabBarTextColor = 1;
static int tabBarIconColor = 1;
static int unselectedHighlight = 1;
static int selectedHighlight = 1;

inline bool GetPrefBool(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}

@interface pkgSourceList: NSMutableArray
@end

@interface Database: NSObject
-(bool) popErrorWithTitle:(id)arg1 forReadList:(pkgSourceList*)arg2;
-(bool) popErrorWithTitle:(id)arg1;
@end



%hook _UIBarBackground
-(void) configureBackgroundColor:(id)backgroundColor barStyle:(NSInteger)bStyle translucent:(bool)arg3 {
if(wantsTheme) {
int i=2;
bStyle= (NSInteger) i;

return %orig(backgroundColor, bStyle, arg3);
}
return %orig;
}
%end


%hook UITableView
//color of the bars for giant separators in tables

-(id)_backgroundColor {
if (wantsTheme) {
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];

tableBarColor= [[prefs objectForKey:@"tableBarColor"] intValue];


UIColor *actualColor;

switch (tableBarColor) 
{
case 0: actualColor= [UIColor blueColor];
break;
case 1: actualColor= [UIColor magentaColor];
break;
case 2: actualColor= [UIColor greenColor];
break;
default: actualColor= [UIColor yellowColor];
break;
}
return actualColor;
}
return %orig;
}

-(void)_setHeaderAndFooterViewsFloat:(BOOL)arg1 {
if (wantsTheme) {
arg1= TRUE;
 return %orig;
}
return %orig;
}

%end

// Index Bar color on right side

%hook UITableViewIndex
-(void) setIndexColor:(id)indexCol {
if (wantsTheme) {
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];

indexColorSlot= [[prefs objectForKey:@"indexColorSlot"] intValue];

UIColor *actualColor;


switch (indexColorSlot) 
{
case 0: actualColor= [UIColor blueColor];
break;
case 1: actualColor= [UIColor yellowColor];
break;
case 2: actualColor= [UIColor orangeColor];
break;
default: actualColor= [UIColor blackColor];
break;
}
indexCol= actualColor;
return %orig(indexCol);
}
return %orig;
}

//Sidebar BG color

-(void) setIndexBackgroundColor:(id)indexBGColor {
if (wantsTheme) {
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];

indexBGColorSlot= [[prefs objectForKey:@"indexBGColorSlot"] intValue];

UIColor *actualColor;


switch (indexBGColorSlot) 
{
case 0: actualColor= [UIColor blueColor];
break;
case 1: actualColor= [UIColor redColor];
break;
case 2: actualColor= [UIColor orangeColor];
break;
default: actualColor= [UIColor blackColor];
break;
}
indexBGColor = actualColor;
return %orig(indexBGColor);
}
return %orig;
}
%end



%hook UITabBar

-(bool)_disableBlurTinting {
if (wantsTheme) {
return FALSE;
}
return %orig;
}

-(bool)isTranslucent {
if (wantsTheme) {
return FALSE;
}
return %orig;
}
%end

%hook UINavigationBar
-(double) _titleOpacity {
if (wantsTheme) {
return 1.000;
}
return %orig;
}

-(id) _titleTextColor {
if(wantsTheme) {
UIColor *txtColor = [UIColor colorWithRed:(107/255) green:(147/255) blue:(236/255) alpha:1];
return txtColor;
}
return %orig;
}

-(bool) _disableBlurTinting {
if(wantsTheme) {
return FALSE;
}
return %orig;
}

-(void)setTranslucent:(bool)arg1 {
if(wantsTheme) {
arg1= FALSE;
return %orig(arg1);
}
return %orig;
}

-(void)_setHidesShadow:(bool)arg1 {
if(wantsTheme) {
arg1= FALSE;
return %orig(arg1);
}
return %orig;
}

-(double) _backgroundOpacity {
if(wantsTheme) {
return 0.2f;
}
return %orig;
}
/** 
forget what this was but took out b4 release

-(id) buttonItemTextColor {
if(wantsTheme) {
return 
[UIColor colorWithRed:(215/255) green:(46/255) blue:(62/255) alpha:1];
}
return %orig;
}
**/

-(id) _effectiveBarTintColor {
if(wantsTheme) {
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];

navBarColor= [[prefs objectForKey:@"navBarColor"] intValue];


UIColor *actualColor;

switch (navBarColor) 
{
case 0: actualColor= [UIColor blueColor];
break;
case 1: actualColor= [UIColor redColor];
break;
case 2: actualColor= [UIColor orangeColor];

break;
default: actualColor= [UIColor blackColor];
break;
}
return actualColor;

}
return %orig;
}
/**
Was not needed 

-(id)_statusBarTintColor {
if(wantsTheme) {

int tintColor=1;
UIColor *actualColor;

int r = arc4random_uniform(255);
int g = arc4random_uniform(255);
int b = arc4random_uniform(255);

switch (tintColor) 
{
case 0: actualColor= [UIColor colorWithRed:(0) green:(211/255) blue:(19/255) alpha:1];
break;
case 1: actualColor= [UIColor blueColor];
break;
case 2: actualColor= [UIColor brownColor];

break;
default: actualColor= [UIColor blackColor];
break;
}
return actualColor;

}
return %orig;
}
**/

-(void)_setAlwaysUseDefaultMetrics:(bool)arg1 {
if (wantsTheme) {
arg1= FALSE;
return %orig(arg1);
}
return %orig;
}
%end

%hook _UINavigationBarVisualProviderModernIOS
-(bool) wantsExtendedContentView {
if (wantsTheme) {
return TRUE;
}
return %orig;
}

-(bool)allowLargeTitleView {
if (wantsTheme) {
return TRUE;
}
return %orig;
}
%end

%hook UITableViewCellSelectedBackground
-(void) setNoneStyleBackgroundColor:(id)backgroundColor {
if(wantsTheme) {

backgroundColor= [UIColor clearColor];
return %orig;
}
return %orig;
}

%end

%hook UITableViewCellSelectedBackground
-(void) setSelectionTintColor:(id)tintColor {
if((wantsTheme)&&(wantsHighlights)) {
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];


selectedHighlight=  [[prefs objectForKey:@"selectedHighlight"] intValue];

UIColor *actualColor;

switch (selectedHighlight) 
{
case 0: actualColor= [UIColor redColor];
break;
case 1: actualColor= [UIColor greenColor];
break;
case 2: actualColor= [UIColor orangeColor];
break;
default: actualColor= [UIColor blackColor];
break;
}
tintColor= actualColor;
return %orig(tintColor);
}
return %orig;
}

%end

%hook UITableViewCellUnhighlightedState
-(void) setBackgroundColor:(id)arg1 {
if((wantsTheme)&&(wantsHighlights)) {
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];


unselectedHighlight=  [[prefs objectForKey:@"unselectedHighlight"] intValue];

UIColor *actualColor;

switch (unselectedHighlight) 
{
case 0: actualColor= [UIColor cyanColor];
break;
case 1: actualColor= [UIColor yellowColor];
break;
case 2: actualColor= [UIColor orangeColor];
break;
default: actualColor= [UIColor blackColor];
break;
}
arg1= actualColor;
return %orig(arg1);
}
return %orig;
}

-(void)setOpaque:(bool)arg1 {
if(wantsTheme) {
arg1= TRUE;
return %orig(arg1);
}
return %orig;
}
%end
/** Another unused method
%hook UITabBarItem

-(void) setBadgeColor:(id)bgColor {
**/

%hook UITabBarButton
-(id)_contentTintColorForState:(unsigned long long)arg1 {
if(wantsTheme) {
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];


tabBarIconColor=  [[prefs objectForKey:@"tabBarIconColor"] intValue];

UIColor *actualColor;

switch (tabBarIconColor) 
{
case 0: actualColor= [UIColor cyanColor];
break;
case 1: actualColor= [UIColor greenColor];
break;
case 2: actualColor= [UIColor blueColor];
break;
default: actualColor= [UIColor blackColor];
break;
}
return actualColor;
%orig;
}
return %orig;
}



-(id)_defaultUnselectedLabelTintColor {
if(wantsTheme) {
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];


tabBarTextColor=  [[prefs objectForKey:@"tabBarTextColor"] intValue];

UIColor *actualColor;

switch (tabBarTextColor) 
{
case 0: actualColor= [UIColor yellowColor];
break;
case 1: actualColor= [UIColor cyanColor];
break;
case 2: actualColor= [UIColor blueColor];
break;
default: actualColor= [UIColor blackColor];
break;
}
return actualColor;
}
return %orig;
}

%end

%hook UINavigationBar
-(void) _setDisableBlurTinting:(bool)arg1 {

if(wantsTheme) {
arg1=FALSE;
return %orig(arg1);
}
return %orig;
}

-(NSInteger)_barStyle {
if (wantsTheme) {
int i=2;
return (NSInteger) i;
}
return %orig;
}

-(long long) _statusBarStyle {
if (wantsTheme) {
return 2;
}
return %orig;
}

%end

%hook UITabBar
//Bottom Tab Bar Color
-(id)barTintColor {
if(wantsTheme) {
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];


tabBarColor=  [[prefs objectForKey:@"tabBarColor"] intValue];

UIColor *actualColor;

switch (tabBarColor) 
{
case 0: actualColor= [UIColor orangeColor];
break;
case 1: actualColor= [UIColor blueColor];
break;
case 2: actualColor= [UIColor redColor];
break;
default: actualColor= [UIColor blackColor];
break;
}
return actualColor;

}
return %orig;
}

-(void) setTranslucent:(bool)arg1 {
if(wantsTheme) {
arg1= FALSE;
return %orig(arg1);
}
return %orig;
}

-(void)_setLabelTextColor:(id)arg1 selectedTextColor:(id)arg2 {
if(wantsTheme) {
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];


tabBarTextColor=  [[prefs objectForKey:@"tabBarTextColor"] intValue];

UIColor *actualColor;

switch (tabBarTextColor) 
{
case 0: actualColor= [UIColor yellowColor];
break;
case 1: actualColor= [UIColor cyanColor];
break;
case 2: actualColor= [UIColor blueColor];
break;
default: actualColor= [UIColor blackColor];
break;
}
arg1= actualColor;

return %orig(arg1,arg2);
}
return %orig;
}
/**
-(bool) _blurEnabled {
if(wantsTheme) {
return TRUE;
}
return %orig;
}
**/
-(void) _setBlurEnabled:(bool)arg1 {

if(wantsTheme) {
arg1=TRUE;
return %orig(arg1);
}
return %orig;
}

-(void) setTintColor:(id)arg1 {
if(wantsTheme) {
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];


tabBarTextColor=  [[prefs objectForKey:@"tabBarTextColor"] intValue];

UIColor *actualColor;

switch (tabBarTextColor) 
{
case 0: actualColor= [UIColor yellowColor];
break;
case 1: actualColor= [UIColor cyanColor];
break;
case 2: actualColor= [UIColor blueColor];
break;
default: actualColor= [UIColor blackColor];
break;
}
arg1= actualColor;

return %orig(arg1);
}
return %orig;
}

-(bool) _blurEnabled {
if(wantsTheme) {
return TRUE;
}
return %orig;
}

-(void) _setDisableBlurTinting:(bool)arg1 {

if(wantsTheme) {
arg1=FALSE;
return %orig(arg1);
}
return %orig;
}
/*** another unused method lol
+(id)_unselectedTabTintColorForView:(id)arg1

**/
%end

//Status bar color in app

%hook UIStatusBarForegroundStyleAttributes
-(id)tintColor {
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];


statusBarColor=  [[prefs objectForKey:@"statusBarColor"] intValue];

UIColor *actualColor;

if(wantsTheme) {
switch (statusBarColor) 
{
case 0: actualColor= [UIColor greenColor];
break;
case 1: actualColor= [UIColor yellowColor];
break;
case 2: actualColor= [UIColor cyanColor];
break;
default: actualColor= [UIColor blackColor];
break;
}
return actualColor;

}
return %orig;
}

%end


%hook UITableView
-(void)setSeparatorStyle:(long long)separatorStyle {

NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];


separatorPrefs= [[prefs objectForKey:@"separatorPrefs"] intValue];

separatorStyle = separatorPrefs;
return %orig(separatorStyle);
} 

%end


/** Originally had this in beta but it made chevrons cut off so removed 

%hook UITableViewCellLayoutManager
-(bool)shouldApplyAccessibilityLargeTextLayoutForCell:(id)cell {
if (separatorPrefs==2) {

return TRUE;
return %orig;
}
return %orig;
}

%end
**/

%hook CyteTableViewCell
-(bool)highlighted {
if((wantsTheme)&&(wantsHighlights)) {
return TRUE; 
}
return %orig;
}
%end

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

%hook UIProgressHUD
-(void)setText:(NSString *)arg1 {
if(kEnabled) {
int randomPicker = arc4random_uniform(116);
switch (randomPicker) {
case 0: arg1=@"This internet sux!";  
break;
case 1: arg1=@"ETA son? 🙋🏻‍♂️"; 
break;
case 2: arg1=@"Don't eat yellow snow!"; break;
case 3: arg1=@"You just lost ur JB! 🙀\n\n jk"; 
break;
case 4: arg1= @"💤💤💤💤💤💤"; 
break;
case 5: arg1= @"Remove all porn to continue";
break;
case 6: arg1=@"Have u supported a dev lately? 💸";
break;
case 7: arg1=@"Can't stop here, this is bat country!";
break;
case 8: arg1=@"Dont 📲 and 🚗 ";
break;
case 9: arg1=@"Patience is a virtue. 😇";
break;
case 10: arg1=@"Username checks out.";
break;
case 11: arg1=@"!remindme 12 hours";
break;
case 12: arg1=@"IFTTT 🙈";
break;
case 13: arg1=@"Apple's thesaurus isn't just awful- it's awful!";
break;
case 14: arg1=@"Velcro is such a rip-off!";
break;
case 15: arg1=@"Don't pee in a dream- it's a trap!";
break;
case 16: arg1=@"My wife and I laugh about how competitive we are. I laugh more tho.";
break;
case 17: arg1=@"You know how to disable autocorrect on my wife?";
break;
case 18: arg1=@"Don't try to tell a hair-raising story to a bald guy.";
break;
case 19: arg1=@"Talk is cheap? Call my lawyer.";
break;
case 20: arg1=@"You keepin it 💯?";
break;
case 21: arg1=@"I bet hell is full of deleted selfies.";
break;
case 22: arg1=@"Is this seriously still loading?!";
break;
case 23: arg1=@"O divine art of subtlety and secrecy! -Sun Zhu";
break;
case 24: arg1=@"Numerical weakness comes from having to prepare against possible attacks-Sun Zhu";
break;
case 25: arg1=@"Ever since the first computers, there have always been ghosts in the machine.";
break;
case 26: arg1=@"These free radicals engender questions of free will, creativity, and even the nature of what we might call the soul.";
break;
case 27: arg1=@"case 27: segmentationFault 🙈 Need break";
break;
case 28: arg1=@"Um, new color please. 💁🏼‍♂️";
break;
case 29: arg1=@"There are not more than five musical notes, yet the combinations of these five give rise to more melodies than can ever be heard.";
break;
case 30: arg1=@"Damn I think I just fell asleep and lost time again. 💤🤗💤";
break;
case 31: arg1=@"There are not more than five musical notes, yet the combinations of these five give rise to more melodies than can ever be heard.   🎧 🎹 🎧";
break;
case 32: arg1=@"There are not more than five primary colors (blue, yellow, red, white, and black), yet in combination they produce more hues than can ever been seen.";
break;
case 33: arg1=@"Still keepin it 💯?";
break;
case 34: arg1=@"case 34 colon arg1 does not equal funnyString. probablyShould_break";
break;
case 35: arg1=@"There are not more than five cardinal tastes (sour, acrid, salt, sweet, bitter), yet combinations of them yield more flavors than can ever be tasted.";
break;
case 36: arg1=@"Hologram of Dr. Lanning: That, Detective, is the right question.⁉️";
break;
case 37: arg1=@"Theres nothing in here. [Points to his chest] Its just lights and clockwork.";
break;
case 38: arg1=@"Let me ask you something. Does believing you are the last sane man on the planet make you crazy? Cause if it does-maybe I am.";
break;
case 39: arg1=@"You were right, Doc. I am the dumbest dumb person on the face of the Earth";
break;
case 40: arg1=@"Seriously? Not again!";
break;
case 41: arg1=@"Thx for the bug 🐜 report G. Funny I hate bugs-but sure love squishing them.";
break;
case 42: arg1=@"Can programmed code ever actually be truly random? 🤔";
break;
case 43: arg1=@"Debo escribir más cosas en otras lenguas. Lo siento para los que no entiendan inglés.";
break;
case 44: arg1=@"It may seem innocent, but beware of the black dot! DO. NOT. TAP. If you see it- find who sent it and beat em up instead.";
break;
case 45: arg1=@"I do not mind lying, but inaccuracies I can not stand.";
break;
case 46: arg1=@"Society my dear is like salt water- easy to swim in but hard to swallow.";
break;
case 47: arg1=@"Knowledge rests not upon truth alone-but upon error also.";
break;
case 48: arg1=@"From error to error one discovers the entire truth.";
break;
case 49: arg1=@"If you want to get across an idea wrap it up in a person.";
break;
case 50: arg1=@"You can tell a lot about a fellows character by his manner of eating.";
break;
case 51: arg1=@"Forgiveness is the key to happiness.";
break;
case 52: arg1=@"Nature is a mutable dictionary which is always and never the same.";
break;
case 53: arg1=@"Everything comes to he or she who hustles while they wait. So run along now if ur seeing this you should probably be hustling. Or at least flossin.";
break;
case 54: arg1=@"Insert annoying ad here so developer gets some kind of revenue stream for all the free work.";
break;
case 55: arg1=@"While it is nice to shine- Sometimes its better to fly below the radar and between the shadows.";
break;
case 56: arg1=@"Smartness runs in my family..I was so smart my teacher was in my class for 5 years.";
break;
case 57: arg1=@"Wen ETA kinds are just misunderstood- they never experienced dial-up modems. They never even had to dial a phone. 📞";
break;
case 58: arg1=@"After traveling through Europe and Australia I realized how great we have it in the USA- you cant give a dancer less then a $5 tip without throwing coins at her almost anywhere else.";
break;
case 59: arg1=@"The way to fight a woman is with your hat. Grab it and run!";
break;
case 60: arg1= @"The mass of men lead quiet lives of desperation-\n\nHenry David Thoreau in 1854";
break;
case 61: arg1= @"It is the job of the thinking people not to be on the side of the executioners.";
break;
case 62: arg1= @"When I wanted a new game as a kid I was given 500 page books written in basic. By the time I finished typing them into the commodore they were no longer popular. Thx dad!";
break;
case 63: arg1= @"Better to get up late and be wide awake then to get up early and be asleep all day.";
break;
case 64: arg1= @"If you go to a country where everyone winks- wink back! 😉 (Thai Proverb)";
break;
case 65: arg1= @"Dont panic, but unless you have tape over the camera hole on ur device someone is probably watching you right now. Well maybe not- damn ur ugly!";
break;
case 66: arg1= @"Fool me one time shame on you. Fool me two times- yeah Im still gonna blame you so dont be a jerk.";
break;
case 67: arg1= @"All I really want is a Spice Girl.  I really need a Spice Girl.";
break;
case 68: arg1= @"Will you be my Trap Queen❓🙋🏻‍♂️";
break;
case 69: arg1= @"Would you like me to locate the nearest trap house ❓";
break;
case 70: arg1= @"You really are addicted! Put it down. You have been sentenced to a 12 hour screen ban. On ALL devices- dont even think about grabbing that other one- I WILL know.";
break;
case 71: arg1= @"You're playing a very dangerous game, Betty Cooper";
break;
case 72: arg1=@"If what happened to Mitch has taught us anything, it's that no one is safe.";
break;
case 73: arg1=@"Lay low- Serpents got your back.";
break;
case 74: arg1=@"Now I am become death, the destroyer of worlds- \nRobert Oppenheimer \n The Manhatten Project.";
break;
case 75: arg1=@"It was a perfect storm. ⛈";
break; 
case 76: arg1=@"Of all the girls in Riverdale High. 🙇🏼";
break;
case 77: arg1=@"Alright Bulldogs- let's go have some fun!";
break;
case 78: arg1=@"Magicians are nothing without their assistants. \n 🎩🐰";
break;
case 79: arg1=@"The whole point of getting things done is knowing what to leave undone.\n-Lady Reading";
break;
case 80: arg1=@"You do ill if you praise, but worse if you censure, what you do not understand. \n-Leonardo da Vinci";
break;
case 81: arg1=@"Don't judge each day by the harvest you reap but by the seeds you plant.\n\n-Robert Louis Stephenson";
break;
case 82: arg1=@"I sure hope you changed your mobile and root passwords from \"alpine\" to something a little harder to hack.";
break;
case 83: arg1=@"Dipomacy is to do and say the nastiest thing in the nicest way.";
break;
case 84: arg1=@"To avoid criticism, do nothing, say nothing and be nothing.";
break;
case 85: arg1=@"I have not failed. I've just found 10,000 ways that don't work.\n\n-Thomas Edison";
break;
case 86: arg1=@"The discovery of America was the occasion of the greatest outburst of cruelty and reckless greed known in history.";
break;
case 87: arg1=@"In college they don't tell you the greater part of the law is learning to tolerate fools.";
break;
case 88: arg1=@"Hearing voices no one else can hear isn't a good sign, even in the wizarding world.\n\n-J.K. Rowling";
break;
case 89: arg1=@"One must not think that feeling is everything. Art is nothing without form.\n\n-Gustave Flaubert";
break;
case 90: arg1=@"The school of hard knocks is an accelerated curriculum. \n-Menander";
break;
case 91: arg1=@"Piracy is bad. Mmmmkay?!";
break;
case 92: arg1=@"Any fool can tell the truth- it takes talent to lie well.\n\n-Robert Ludlum";
break;
case 93: arg1=@"So this is how liberty dies. With thunderous applause.\n\n-George Lucas";
break;
case 94: arg1=@"I have a new philosophy. I'm only going to dread one day at a time.";
break;
case 95: arg1=@"Tragedy is when I cut my finger. Comedy is when you walk into an open sewer and die.\n\n-Mel Brooks";
break;
case 96: arg1=@"Of all the Gin joints in all the world. \n🍸🍸";
break;
case 97: arg1=@"By golly I think he's done it!";
break;
case 98: arg1=@"I got 99 problems but my 💃🏿 ain't one. \nI got 99 problems...";
break;
case 99: arg1=@"Ahh, you could be happy.\nYou made me...";
break;
case 100: arg1=@"So baby, oh, baby, how long you going to keep me waiting. Are you gonna have to be waiting on me?";
break;
case 101: arg1=@"Much time has passed between us do you still think of me at all?\nmy world of broken promises now you won't catch me when I fall";
break;
case 102: arg1=@"Who do you love? Tell me tell me. Who do you ❤️?";
break;
case 103: arg1=@"Eyes open I see you 👀 \nI'm watchin you yeah.\nMore people wanna be you\ndon't trust no one.";
break;
case 104: arg1=@"Politicians and the lies. Tell me what's the point in picking sides?";
break;
case 105: arg1=@"I still see your shadows in my room. Can't take back the love that I gave you.";
break;
case 106: arg1=@"It's to the point where I love and I hate you. And I cannot change you so I must replace you.";
break;
case 107: arg1=@"Do not take life too seriously. You will never get out alive.";
break;
case 108: arg1=@"Watch the breakdown.";
break;
case 109: arg1=@"I tell you in this world being a little crazy helps to keep you sane.";
break;
case 110: arg1=@"Get busy living or get busy dying.\n\n-Stephen King";
break;
case 111: arg1=@"Choose life. Choose a job. Choose a career. Choose a family. Choose DIY and wondering who you are on a Sunday morning. Choose sitting on that couch watching mind-numbing spirit-crushing game shows...Choose your future. Choose life.";
break;
case 112: arg1=@"Shouldn't you be paying attention to something more important right now?";
break;
case 113: arg1=@"It's official the end has come- Drake is more popular then the Beatles in their prime. 🔚🙈";
break;
case 114: arg1=@"Not sure why we just code and code till our heads explode, for something ppl want for free. Kind of mind boggling, lol.";
break;
case 115: arg1=@"Mátame ya no puedo soportar más. 🙈";
break;
default: arg1= @"Still Loading";
break;
}
loadingTitle= arg1;
return %orig(arg1);
}
return %orig;
}
%end

static void loadPrefs()
{
        NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];
    if(prefs)
    {
        kEnabled = ([prefs objectForKey:@"Enabled4"] ? [[prefs objectForKey:@"Enabled4"] boolValue] : NO);

wantsHighlights = ([prefs objectForKey:@"wantsHighlights"] ? [[prefs objectForKey:@"wantsHighlights"] boolValue] : NO);
 
indexBGColorSlot = ([prefs objectForKey:@"indexBGColorSlot"] ? [[prefs objectForKey:@"indexBGColorSlot"] intValue] : indexBGColorSlot);

indexColorSlot = ([prefs objectForKey:@"indexColorSlot"] ? [[prefs objectForKey:@"indexColorSlot"] intValue] : indexColorSlot);
 
 separatorPrefs = ([prefs objectForKey:@"separatorPrefs"] ? [[prefs objectForKey:@"separatorPrefs"] intValue] : separatorPrefs);

statusBarColor= ([prefs objectForKey:@"statusBarColor"] ? [[prefs objectForKey:@"statusBarColor"] intValue] : statusBarColor);

tableBarColor= ([prefs objectForKey:@"tableBarColor"] ? [[prefs objectForKey:@"tableBarColor"] intValue] : tableBarColor);

tabBarTextColor= ([prefs objectForKey:@"tabBarTextColor"] ? [[prefs objectForKey:@"tabBarTextColor"] intValue] : tabBarTextColor);

tabBarIconColor= ([prefs objectForKey:@"tabBarIconColor"] ? [[prefs objectForKey:@"tabBarIconColor"] intValue] : tabBarIconColor);

tabBarColor= ([prefs objectForKey:@"tabBarColor"] ? [[prefs objectForKey:@"tabBarColor"] intValue] : tabBarColor);

unselectedHighlight= ([prefs objectForKey:@"unselectedHighlight"] ? [[prefs objectForKey:@"unselectedHighlight"] intValue] : unselectedHighlight);

selectedHighlight= ([prefs objectForKey:@"selectedHighlight"] ? [[prefs objectForKey:@"selectedHighlight"] intValue] : selectedHighlight);


wantsTheme = ([prefs objectForKey:@"wantsTheme"] ? [[prefs objectForKey:@"wantsTheme"] boolValue] : NO);

    }
    [prefs release];
}

static void settingschanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    loadPrefs();
}


%ctor
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, settingschanged, CFSTR("com.i0stweak3r.cydiaformulaoneone~prefs/saved"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}








