//
//  AppDataManager.m
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 7/12/16.
//  Copyright (c) 2016 PROSOFT SG. All rights reserved.
//

#import "AppDataManager.h"

@implementation AppDataManager {
    NSUserDefaults *prefs;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        prefs = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

+ (AppDataManager *) getInstance {
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

- (BOOL)getBoolValue:(NSString*)key defaultValue:(BOOL)defaultValue {
    if ([prefs objectForKey:key]) {
        return [[prefs objectForKey:key] boolValue];
    }
    return defaultValue;
}

- (void)setBoolValue:(NSString*)key value:(BOOL)value {
    [prefs setValue:[NSNumber numberWithBool:value] forKey:key];
    [prefs synchronize];
}

- (NSInteger)getIntegerValue:(NSString*)key defaultValue:(NSInteger)defaultValue {
    if ([prefs objectForKey:key]) {
        return [[prefs objectForKey:key] integerValue];
    }
    return defaultValue;
}
- (void)setIntegerValue:(NSString*)key value:(NSInteger)value {
    [prefs setValue:[NSNumber numberWithInteger:value] forKey:key];
    [prefs synchronize];
}


- (NSString*)getStringValue:(NSString*)key defaultValue:(NSString*)defaultValue {
    if ([prefs objectForKey:key]) {
        return [prefs objectForKey:key];
    }
    return defaultValue;
}

- (void)setStringValue:(NSString*)key value:(NSString*)value {
    [prefs setValue:value forKey:key];
    [prefs synchronize];
}

- (void)removeBoolValue:(NSString*)key {
    [prefs removeObjectForKey:key];
    [prefs synchronize];
}

- (void)removeIntegerValue:(NSString*)key {
    [prefs removeObjectForKey:key];
    [prefs synchronize];
}

- (void)removeStringValue:(NSString*)key {
    [prefs removeObjectForKey:key];
    [prefs synchronize];
}

////////////////////////////////////////////////////////////////////

#define PREFS_NAME      @"miaoyou"

#define USER_ID         @"userID"
#define USER_NICK_NAME  @"user_nick_name"
#define USER_TRUE_NAME  @"user_true_name"
#define USER_STATE      @"user_state"
#define ACCOUNT_KEY     @"account"
#define PWD_KEY         @"password"
#define AVATAR          @"user_avatar_url"
#define AVATAR_BACKGROUND @"user_avatar_background_url"
#define IS_FIRST        @"is_first"

////////////////////////////////////////////////////////////////////

#define PREFERENCE_NAME @"saveInfo"


#define SHARED_KEY_SETTING_NOTIFICATION @"shared_key_setting_notification"
#define SHARED_KEY_SETTING_SOUND @"shared_key_setting_sound"
#define SHARED_KEY_SETTING_VIBRATE @"shared_key_setting_vibrate"
#define SHARED_KEY_SETTING_SPEAKER @"shared_key_setting_speaker"

#define SHARED_KEY_SETTING_CHATROOM_OWNER_LEAVE @"shared_key_setting_chatroom_owner_leave"
#define SHARED_KEY_SETTING_DELETE_MESSAGES_WHEN_EXIT_GROUP @"shared_key_setting_delete_messages_when_exit_group"
#define SHARED_KEY_SETTING_AUTO_ACCEPT_GROUP_INVITATION @"shared_key_setting_auto_accept_group_invitation"
#define SHARED_KEY_SETTING_ADAPTIVE_VIDEO_ENCODE @"shared_key_setting_adaptive_video_encode"

#define SHARED_KEY_SETTING_GROUPS_SYNCED @"SHARED_KEY_SETTING_GROUPS_SYNCED"
#define SHARED_KEY_SETTING_CONTACT_SYNCED @"SHARED_KEY_SETTING_CONTACT_SYNCED"
#define SHARED_KEY_SETTING_BALCKLIST_SYNCED @"SHARED_KEY_SETTING_BALCKLIST_SYNCED"

#define SHARED_KEY_CURRENTUSER_USERNAME @"SHARED_KEY_CURRENTUSER_USERNAME"
#define SHARED_KEY_CURRENTUSER_NICK @"SHARED_KEY_CURRENTUSER_NICK"
#define SHARED_KEY_CURRENTUSER_AVATAR @"SHARED_KEY_CURRENTUSER_AVATAR"



////////////////////////////////////////////////////////////////////

- (void)saveAccountInfo:(UserInfo *)userInfo {
    [self setStringValue:USER_ID value:userInfo.id];
//    [self setStringValue:USER_NICK_NAME value:userInfo.NickName];
    [self setStringValue:USER_TRUE_NAME value:userInfo.names];
    [self setStringValue:USER_STATE value:userInfo.State];
    [self setStringValue:ACCOUNT_KEY value:userInfo.mobile];
    if (![Utils isEmpty:userInfo.PassWord]) {
        [self setStringValue:PWD_KEY value:userInfo.PassWord];
    }
    [self setStringValue:AVATAR value:userInfo.headimgurl];
//    [self setStringValue:AVATAR_BACKGROUND value:userInfo.Pictures];
    [self setBoolValue:IS_FIRST value:false];
    [self setCurrentUserAvatar:userInfo.headimgurl];
    [self setCurrentUserName:userInfo.mobile];
    [self setCurrentUserNick:userInfo.names];
}

- (NSString*)getUserNickName {
    return [self getStringValue:USER_NICK_NAME defaultValue:@""];
}

- (NSString*)getUserTrueName {
    return [self getStringValue:USER_TRUE_NAME defaultValue:@""];
}
- (NSString*)getUserState {
    return [self getStringValue:USER_STATE defaultValue:@""];
}
- (NSString*)getAvatar {
    return [self getStringValue:AVATAR defaultValue:@""];
}
- (NSString*)getAvatarBackground {
    return [self getStringValue:AVATAR_BACKGROUND defaultValue:@""];
}

- (NSString*)getMobileInfo {
    return [self getStringValue:ACCOUNT_KEY defaultValue:@""];
}

- (NSString*)getPassword {
    return [self getStringValue:PWD_KEY defaultValue:@""];
}

- (void)clearAccountInfo {
    [self removeStringValue:PWD_KEY];
    [self setBoolValue:IS_FIRST value:true];
}

- (NSString*)getAccountId {
    return [self getStringValue:USER_ID defaultValue:@""];
}

- (BOOL)isFirstLogin {
    return [self getBoolValue:IS_FIRST defaultValue:true];
}
- (void)setIsFirstLogin {
    [self setBoolValue:IS_FIRST value:true];
}

////////////////////////////////////////////////////////////////////

- (void)setSettingMsgNotification:(BOOL)value {
    [self setBoolValue:SHARED_KEY_SETTING_NOTIFICATION value:value];
}//SHARED_KEY_SETTING_NOTIFICATION
- (BOOL)getSettingMsgNotification {
    return [self getBoolValue:SHARED_KEY_SETTING_NOTIFICATION defaultValue:true];
}
- (void)setSettingMsgSound:(BOOL)value {
    [self setBoolValue:SHARED_KEY_SETTING_SOUND value:value];
}//SHARED_KEY_SETTING_SOUND
- (BOOL)getSettingMsgSound {
    return [self getBoolValue:SHARED_KEY_SETTING_SOUND defaultValue:true];
}
- (void)setSettingMsgVibrate:(BOOL)value {
    [self setBoolValue:SHARED_KEY_SETTING_VIBRATE value:value];
}//SHARED_KEY_SETTING_VIBRATE
- (BOOL)getSettingMsgVibrate {
    return [self getBoolValue:SHARED_KEY_SETTING_VIBRATE defaultValue:true];
}
- (void)setSettingMsgSpeaker:(BOOL)value {
    [self setBoolValue:SHARED_KEY_SETTING_SPEAKER value:value];
}//SHARED_KEY_SETTING_SPEAKER
- (BOOL)getSettingMsgSpeaker {
    return [self getBoolValue:SHARED_KEY_SETTING_SPEAKER defaultValue:true];
}
- (void)setSettingAllowChatroomOwnerLeave:(BOOL)value {
    [self setBoolValue:SHARED_KEY_SETTING_CHATROOM_OWNER_LEAVE value:value];
}//SHARED_KEY_SETTING_CHATROOM_OWNER_LEAVE
- (BOOL)getSettingAllowChatroomOwnerLeave {
    return [self getBoolValue:SHARED_KEY_SETTING_CHATROOM_OWNER_LEAVE defaultValue:true];
}
- (void)setDeleteMessagesAsExitGroup:(BOOL)value {
    [self setBoolValue:SHARED_KEY_SETTING_DELETE_MESSAGES_WHEN_EXIT_GROUP value:value];
}//SHARED_KEY_SETTING_DELETE_MESSAGES_WHEN_EXIT_GROUP
- (BOOL)isDeleteMessagesAsExitGroup {
    return [self getBoolValue:SHARED_KEY_SETTING_DELETE_MESSAGES_WHEN_EXIT_GROUP defaultValue:true];
}
- (void)setAutoAcceptGroupInvitation:(BOOL)value {
    [self setBoolValue:SHARED_KEY_SETTING_AUTO_ACCEPT_GROUP_INVITATION value:value];
}//SHARED_KEY_SETTING_AUTO_ACCEPT_GROUP_INVITATION
- (BOOL)isAutoAcceptGroupInvitation {
    return [self getBoolValue:SHARED_KEY_SETTING_AUTO_ACCEPT_GROUP_INVITATION defaultValue:true];
}
- (void)setAdaptiveVideoEncode:(BOOL)value {
    [self setBoolValue:SHARED_KEY_SETTING_ADAPTIVE_VIDEO_ENCODE value:value];
}//SHARED_KEY_SETTING_ADAPTIVE_VIDEO_ENCODE
- (BOOL)isAdaptiveVideoEncode {
    return [self getBoolValue:SHARED_KEY_SETTING_ADAPTIVE_VIDEO_ENCODE defaultValue:false];
}
- (void)setGroupsSynced:(BOOL)value {
    [self setBoolValue:SHARED_KEY_SETTING_GROUPS_SYNCED value:value];
}//SHARED_KEY_SETTING_GROUPS_SYNCED
- (BOOL)isGroupsSynced {
    return [self getBoolValue:SHARED_KEY_SETTING_GROUPS_SYNCED defaultValue:false];
}
- (void)setContactSynced:(BOOL)value {
    [self setBoolValue:SHARED_KEY_SETTING_CONTACT_SYNCED value:value];
}//SHARED_KEY_SETTING_CONTACT_SYNCED
- (BOOL)isContactSynced {
    return [self getBoolValue:SHARED_KEY_SETTING_CONTACT_SYNCED defaultValue:false];
}
- (void)setBlacklistSynced:(BOOL)value {
    [self setBoolValue:SHARED_KEY_SETTING_BALCKLIST_SYNCED value:value];
}//SHARED_KEY_SETTING_BALCKLIST_SYNCED
- (BOOL)isBacklistSynced {
    return [self getBoolValue:SHARED_KEY_SETTING_BALCKLIST_SYNCED defaultValue:false];
}
- (void)setCurrentUserNick:(NSString*)nick {
    [self setStringValue:SHARED_KEY_CURRENTUSER_NICK value:nick];
}//SHARED_KEY_CURRENTUSER_NICK
- (NSString*)getCurrentUserNick {
    return [self getStringValue:SHARED_KEY_CURRENTUSER_NICK defaultValue:nil];
}
- (void)setCurrentUserAvatar:(NSString*)avatar {
    [self setStringValue:SHARED_KEY_CURRENTUSER_AVATAR value:avatar];
}//SHARED_KEY_CURRENTUSER_AVATAR
- (NSString*)getCurrentUserAvatar {
    return [self getStringValue:SHARED_KEY_CURRENTUSER_AVATAR defaultValue:nil];
}
- (void)setCurrentUserName:(NSString*)username {
    [self setStringValue:SHARED_KEY_CURRENTUSER_USERNAME value:username];
}//SHARED_KEY_CURRENTUSER_USERNAME
- (NSString*)getCurrentUsername {
    return [self getStringValue:SHARED_KEY_CURRENTUSER_USERNAME defaultValue:nil];
}
- (void)removeCurrentUserInfo {
    [self removeStringValue:SHARED_KEY_CURRENTUSER_NICK];
    [self removeStringValue:SHARED_KEY_CURRENTUSER_AVATAR];
}

@end
