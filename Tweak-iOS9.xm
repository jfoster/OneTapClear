@interface SBNotificationCenterHeaderView : NSObject
@property (retain) id clearButtonVisibleAction;
@end

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

%ctor {
    @autoreleasepool {
        if ([[NSProcessInfo processInfo] respondsToSelector:@selector(isOperatingSystemAtLeastVersion:)]) {
            if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){9,0,0}]) {
                %init(iOS9);
            }
        }
    }
}