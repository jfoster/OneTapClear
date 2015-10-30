#pragma mark Interfaces

@interface SBNotificationCenterHeaderView : NSObject {
	id _xAction; // iOS 8
}
@property (retain) id clearButtonVisibleAction; // iOS 9
@end

#pragma mark iOS9

%group iOS9

%hook SBNotificationCenterHeaderView

-(void)setClearButtonFinalAction:(id)arg1 {
	%orig(arg1);
	self.clearButtonVisibleAction = arg1;
}

%end

%hook SBNotificationsClearButton

-(void)setState:(long long)arg1 animated:(BOOL)arg2 {
	%orig(0, NO);
}

%end

%end // iOS9

#pragma mark iOS8

%group iOS8

%hook SBNotificationCenterHeaderView

-(void)setTarget:(id)arg1 forClearButtonAction:(id)arg2 {
	%orig(arg1, arg2);
	MSHookIvar<id>(self,"_xAction") = [arg2 retain];
}

%end

%hook SBNotificationsClearButton

-(void)setState:(long long)arg1 animated:(BOOL)arg2 {
	%orig(0, NO);
}

%end

%end // iOS 8

#pragma mark Constructor

#define IS_OS_GREATER_THAN_OR_EQUAL_TO(a,b,c) [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){a, b, c}]

%ctor {
	@autoreleasepool {
		if ([[NSProcessInfo processInfo] respondsToSelector:@selector(isOperatingSystemAtLeastVersion:)]) {
			if (IS_OS_GREATER_THAN_OR_EQUAL_TO(9,0,0)) {
				NSLog(@"[OneTapClear] running iOS9");
				%init(iOS9);
			} else if (IS_OS_GREATER_THAN_OR_EQUAL_TO(8,0,0)) {
				NSLog(@"[OneTapClear] running iOS8");
				%init(iOS8);
			}
		} else {
			NSLog(@"[OneTapClear] iOS version is not supported.");
		}
	}
}