@interface SBNotificationCenterHeaderView : NSObject {
    id _xAction;
}
@end

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

%ctor {
    @autoreleasepool {
        if ([[NSProcessInfo processInfo] respondsToSelector:@selector(isOperatingSystemAtLeastVersion:)]) {
            if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){8,0,0}] &&
                ![[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){9,0,0}]) {
                %init(iOS8);
            }
        }
    }
}