//
//  AppDataManager.h
//  Miaoyou
//
//  Created by Kiet Thai Thuan on 7/12/16.
//  Copyright (c) 2016 PROSOFT SG. All rights reserved.
//

#import "DataManagerBase.h"

@interface AppDataManager : DataManagerBase

@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;

+ (AppDataManager *) getInstance;

- (BOOL)getBoolValue:(NSString*)key defaultValue:(BOOL)defaultValue;
- (void)setBoolValue:(NSString*)key value:(BOOL)value;

- (NSInteger)getIntegerValue:(NSString*)key defaultValue:(NSInteger)defaultValue;
- (void)setIntegerValue:(NSString*)key value:(NSInteger)value;

- (NSString*)getStringValue:(NSString*)key defaultValue:(NSString*)defaultValue;
- (void)setStringValue:(NSString*)key value:(NSString*)value;

- (void)removeBoolValue:(NSString*)key;
- (void)removeIntegerValue:(NSString*)key;
- (void)removeStringValue:(NSString*)key;

- (void)saveAccountInfo:(UserInfo*)userInfo;
- (NSString*)getUserNickName;
- (NSString*)getUserTrueName;
- (NSString*)getUserState;
- (NSString*)getAvatar;
- (NSString*)getAvatarBackground;

- (NSString*)getMobileInfo;
- (NSString*)getPassword;
- (void)clearAccountInfo;
- (NSString*)getAccountId;
- (BOOL)isFirstLogin;
- (void)setIsFirstLogin;

- (void)setSettingMsgNotification:(BOOL)value;//SHARED_KEY_SETTING_NOTIFICATION
- (BOOL)getSettingMsgNotification;
- (void)setSettingMsgSound:(BOOL)value;//SHARED_KEY_SETTING_SOUND
- (BOOL)getSettingMsgSound;
- (void)setSettingMsgVibrate:(BOOL)value;//SHARED_KEY_SETTING_VIBRATE
- (BOOL)getSettingMsgVibrate;
- (void)setSettingMsgSpeaker:(BOOL)value;//SHARED_KEY_SETTING_SPEAKER
- (BOOL)getSettingMsgSpeaker;
- (void)setSettingAllowChatroomOwnerLeave:(BOOL)value;//SHARED_KEY_SETTING_CHATROOM_OWNER_LEAVE
- (BOOL)getSettingAllowChatroomOwnerLeave;
- (void)setDeleteMessagesAsExitGroup:(BOOL)value;//SHARED_KEY_SETTING_DELETE_MESSAGES_WHEN_EXIT_GROUP
- (BOOL)isDeleteMessagesAsExitGroup;
- (void)setAutoAcceptGroupInvitation:(BOOL)value;//SHARED_KEY_SETTING_AUTO_ACCEPT_GROUP_INVITATION
- (BOOL)isAutoAcceptGroupInvitation;
- (void)setAdaptiveVideoEncode:(BOOL)value;//SHARED_KEY_SETTING_ADAPTIVE_VIDEO_ENCODE
- (BOOL)isAdaptiveVideoEncode;
- (void)setGroupsSynced:(BOOL)value;//SHARED_KEY_SETTING_GROUPS_SYNCED
- (BOOL)isGroupsSynced;
- (void)setContactSynced:(BOOL)value;//SHARED_KEY_SETTING_CONTACT_SYNCED
- (BOOL)isContactSynced;
- (void)setBlacklistSynced:(BOOL)value;//SHARED_KEY_SETTING_BALCKLIST_SYNCED
- (BOOL)isBacklistSynced;
- (void)setCurrentUserNick:(NSString*)nick;//SHARED_KEY_CURRENTUSER_NICK
- (NSString*)getCurrentUserNick;
- (void)setCurrentUserAvatar:(NSString*)avatar;//SHARED_KEY_CURRENTUSER_AVATAR
- (NSString*)getCurrentUserAvatar;
- (void)setCurrentUserName:(NSString*)username;//SHARED_KEY_CURRENTUSER_USERNAME
- (NSString*)getCurrentUsername;
- (void)removeCurrentUserInfo;



@end
