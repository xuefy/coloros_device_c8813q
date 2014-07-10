.class Landroid/media/AudioService$SettingsObserver;
.super Landroid/database/ContentObserver;
.source "AudioService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/media/AudioService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "SettingsObserver"
.end annotation


# instance fields
.field final synthetic this$0:Landroid/media/AudioService;


# direct methods
.method constructor <init>(Landroid/media/AudioService;)V
    .locals 3
    .parameter

    .prologue
    const/4 v2, 0x0

    .line 3592
    iput-object p1, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    .line 3593
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    invoke-direct {p0, v0}, Landroid/database/ContentObserver;-><init>(Landroid/os/Handler;)V

    .line 3594
    #getter for: Landroid/media/AudioService;->mContentResolver:Landroid/content/ContentResolver;
    invoke-static {p1}, Landroid/media/AudioService;->access$3800(Landroid/media/AudioService;)Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "mode_ringer_streams_affected"

    invoke-static {v1}, Landroid/provider/Settings$System;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1, v2, p0}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 3596
    #getter for: Landroid/media/AudioService;->mContentResolver:Landroid/content/ContentResolver;
    invoke-static {p1}, Landroid/media/AudioService;->access$3800(Landroid/media/AudioService;)Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "dock_audio_media_enabled"

    invoke-static {v1}, Landroid/provider/Settings$Global;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1, v2, p0}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 3598
    #getter for: Landroid/media/AudioService;->mContentResolver:Landroid/content/ContentResolver;
    invoke-static {p1}, Landroid/media/AudioService;->access$3800(Landroid/media/AudioService;)Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "volume_link_notification"

    invoke-static {v1}, Landroid/provider/Settings$System;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1, v2, p0}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 3600
    #getter for: Landroid/media/AudioService;->mContentResolver:Landroid/content/ContentResolver;
    invoke-static {p1}, Landroid/media/AudioService;->access$3800(Landroid/media/AudioService;)Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "safe_headset_volume"

    invoke-static {v1}, Landroid/provider/Settings$System;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1, v2, p0}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 3602
    #getter for: Landroid/media/AudioService;->mContentResolver:Landroid/content/ContentResolver;
    invoke-static {p1}, Landroid/media/AudioService;->access$3800(Landroid/media/AudioService;)Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "volume_keys_control_ring_stream"

    invoke-static {v1}, Landroid/provider/Settings$System;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1, v2, p0}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 3604
    return-void
.end method


# virtual methods
.method public onChange(ZLandroid/net/Uri;)V
    .locals 9
    .parameter "selfChange"
    .parameter "uri"

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 3608
    invoke-super {p0, p1, p2}, Landroid/database/ContentObserver;->onChange(ZLandroid/net/Uri;)V

    .line 3613
    iget-object v3, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    #getter for: Landroid/media/AudioService;->mSettingsLock:Ljava/lang/Object;
    invoke-static {v3}, Landroid/media/AudioService;->access$6200(Landroid/media/AudioService;)Ljava/lang/Object;

    move-result-object v3

    monitor-enter v3

    .line 3614
    :try_start_0
    const-string v4, "mode_ringer_streams_affected"

    invoke-static {v4}, Landroid/provider/Settings$System;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v4

    invoke-virtual {p2, v4}, Landroid/net/Uri;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 3615
    iget-object v1, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    #getter for: Landroid/media/AudioService;->mContentResolver:Landroid/content/ContentResolver;
    invoke-static {v1}, Landroid/media/AudioService;->access$3800(Landroid/media/AudioService;)Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "mode_ringer_streams_affected"

    const/16 v4, 0xa6

    const/4 v5, -0x2

    invoke-static {v1, v2, v4, v5}, Landroid/provider/Settings$System;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v0

    .line 3620
    .local v0, ringerModeAffectedStreams:I
    iget-object v1, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    #getter for: Landroid/media/AudioService;->mVoiceCapable:Z
    invoke-static {v1}, Landroid/media/AudioService;->access$3900(Landroid/media/AudioService;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 3621
    and-int/lit8 v0, v0, -0x9

    .line 3625
    :goto_0
    iget-object v1, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    #getter for: Landroid/media/AudioService;->mCameraSoundForced:Ljava/lang/Boolean;
    invoke-static {v1}, Landroid/media/AudioService;->access$3600(Landroid/media/AudioService;)Ljava/lang/Boolean;

    move-result-object v2

    monitor-enter v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3626
    :try_start_1
    iget-object v1, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    #getter for: Landroid/media/AudioService;->mCameraSoundForced:Ljava/lang/Boolean;
    invoke-static {v1}, Landroid/media/AudioService;->access$3600(Landroid/media/AudioService;)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 3627
    and-int/lit16 v0, v0, -0x81

    .line 3631
    :goto_1
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3632
    :try_start_2
    iget-object v1, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    #getter for: Landroid/media/AudioService;->mRingerModeAffectedStreams:I
    invoke-static {v1}, Landroid/media/AudioService;->access$7600(Landroid/media/AudioService;)I

    move-result v1

    if-eq v0, v1, :cond_0

    .line 3637
    iget-object v1, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    #setter for: Landroid/media/AudioService;->mRingerModeAffectedStreams:I
    invoke-static {v1, v0}, Landroid/media/AudioService;->access$7602(Landroid/media/AudioService;I)I

    .line 3638
    iget-object v1, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    iget-object v2, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    invoke-virtual {v2}, Landroid/media/AudioService;->getRingerMode()I

    move-result v2

    const/4 v4, 0x0

    #calls: Landroid/media/AudioService;->setRingerModeInt(IZ)V
    invoke-static {v1, v2, v4}, Landroid/media/AudioService;->access$5600(Landroid/media/AudioService;IZ)V

    .line 3659
    .end local v0           #ringerModeAffectedStreams:I
    :cond_0
    :goto_2
    monitor-exit v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3660
    return-void

    .line 3623
    .restart local v0       #ringerModeAffectedStreams:I
    :cond_1
    or-int/lit8 v0, v0, 0x8

    goto :goto_0

    .line 3629
    :cond_2
    or-int/lit16 v0, v0, 0x80

    goto :goto_1

    .line 3631
    :catchall_0
    move-exception v1

    :try_start_3
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw v1

    .line 3659
    .end local v0           #ringerModeAffectedStreams:I
    :catchall_1
    move-exception v1

    monitor-exit v3
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    throw v1

    .line 3641
    :cond_3
    :try_start_5
    const-string v4, "dock_audio_media_enabled"

    invoke-static {v4}, Landroid/provider/Settings$Global;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v4

    invoke-virtual {p2, v4}, Landroid/net/Uri;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 3642
    iget-object v1, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    iget-object v2, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    #getter for: Landroid/media/AudioService;->mContentResolver:Landroid/content/ContentResolver;
    invoke-static {v2}, Landroid/media/AudioService;->access$3800(Landroid/media/AudioService;)Landroid/content/ContentResolver;

    move-result-object v2

    #calls: Landroid/media/AudioService;->readDockAudioSettings(Landroid/content/ContentResolver;)V
    invoke-static {v1, v2}, Landroid/media/AudioService;->access$7700(Landroid/media/AudioService;Landroid/content/ContentResolver;)V

    goto :goto_2

    .line 3644
    :cond_4
    const-string v4, "volume_link_notification"

    invoke-static {v4}, Landroid/provider/Settings$System;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v4

    invoke-virtual {p2, v4}, Landroid/net/Uri;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_7

    .line 3645
    iget-object v4, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    iget-object v5, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    #getter for: Landroid/media/AudioService;->mContentResolver:Landroid/content/ContentResolver;
    invoke-static {v5}, Landroid/media/AudioService;->access$3800(Landroid/media/AudioService;)Landroid/content/ContentResolver;

    move-result-object v5

    const-string v6, "volume_link_notification"

    const/4 v7, 0x1

    invoke-static {v5, v6, v7}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v5

    if-ne v5, v1, :cond_5

    :goto_3
    #setter for: Landroid/media/AudioService;->mLinkNotificationWithVolume:Z
    invoke-static {v4, v1}, Landroid/media/AudioService;->access$7802(Landroid/media/AudioService;Z)Z

    .line 3647
    iget-object v1, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    #getter for: Landroid/media/AudioService;->mLinkNotificationWithVolume:Z
    invoke-static {v1}, Landroid/media/AudioService;->access$7800(Landroid/media/AudioService;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 3648
    iget-object v1, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    #getter for: Landroid/media/AudioService;->mStreamVolumeAlias:[I
    invoke-static {v1}, Landroid/media/AudioService;->access$3700(Landroid/media/AudioService;)[I

    move-result-object v1

    const/4 v2, 0x5

    const/4 v4, 0x2

    aput v4, v1, v2

    goto :goto_2

    :cond_5
    move v1, v2

    .line 3645
    goto :goto_3

    .line 3650
    :cond_6
    iget-object v1, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    #getter for: Landroid/media/AudioService;->mStreamVolumeAlias:[I
    invoke-static {v1}, Landroid/media/AudioService;->access$3700(Landroid/media/AudioService;)[I

    move-result-object v1

    const/4 v2, 0x5

    const/4 v4, 0x5

    aput v4, v1, v2

    goto :goto_2

    .line 3653
    :cond_7
    const-string v4, "safe_headset_volume"

    invoke-static {v4}, Landroid/provider/Settings$System;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v4

    invoke-virtual {p2, v4}, Landroid/net/Uri;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_8

    .line 3654
    iget-object v1, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    iget-object v2, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    iget-object v4, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    #getter for: Landroid/media/AudioService;->mContentResolver:Landroid/content/ContentResolver;
    invoke-static {v4}, Landroid/media/AudioService;->access$3800(Landroid/media/AudioService;)Landroid/content/ContentResolver;

    move-result-object v4

    #calls: Landroid/media/AudioService;->safeVolumeEnabled(Landroid/content/ContentResolver;)Z
    invoke-static {v2, v4}, Landroid/media/AudioService;->access$8000(Landroid/media/AudioService;Landroid/content/ContentResolver;)Z

    move-result v2

    #setter for: Landroid/media/AudioService;->mSafeVolumeEnabled:Z
    invoke-static {v1, v2}, Landroid/media/AudioService;->access$7902(Landroid/media/AudioService;Z)Z

    goto/16 :goto_2

    .line 3655
    :cond_8
    const-string v4, "volume_keys_control_ring_stream"

    invoke-static {v4}, Landroid/provider/Settings$System;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v4

    invoke-virtual {p2, v4}, Landroid/net/Uri;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 3656
    iget-object v4, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    iget-object v5, p0, Landroid/media/AudioService$SettingsObserver;->this$0:Landroid/media/AudioService;

    #getter for: Landroid/media/AudioService;->mContentResolver:Landroid/content/ContentResolver;
    invoke-static {v5}, Landroid/media/AudioService;->access$3800(Landroid/media/AudioService;)Landroid/content/ContentResolver;

    move-result-object v5

    const-string v6, "volume_keys_control_ring_stream"

    const/4 v7, 0x1

    const/4 v8, -0x2

    invoke-static {v5, v6, v7, v8}, Landroid/provider/Settings$System;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v5

    if-ne v5, v1, :cond_9

    :goto_4
    #setter for: Landroid/media/AudioService;->mVolumeKeysControlRingStream:Z
    invoke-static {v4, v1}, Landroid/media/AudioService;->access$8102(Landroid/media/AudioService;Z)Z
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    goto/16 :goto_2

    :cond_9
    move v1, v2

    goto :goto_4
.end method
