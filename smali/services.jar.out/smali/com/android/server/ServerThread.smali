.class Lcom/android/server/ServerThread;
.super Ljava/lang/Thread;
.source "SystemServer.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/server/ServerThread$AdbPortObserver;
    }
.end annotation


# static fields
.field private static final ENCRYPTED_STATE:Ljava/lang/String; = "1"

.field private static final ENCRYPTING_STATE:Ljava/lang/String; = "trigger_restart_min_framework"

.field public static final FAST_CHARGE_DIR:Ljava/lang/String; = "/sys/kernel/fast_charge"

.field public static final FAST_CHARGE_FILE:Ljava/lang/String; = "force_fast_charge"

.field private static final TAG:Ljava/lang/String; = "SystemServer"


# instance fields
.field mContentResolver:Landroid/content/ContentResolver;


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 85
    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 100
    return-void
.end method

.method static final startSystemUi(Landroid/content/Context;)V
    .locals 9
    .parameter "context"

    .prologue
    const/4 v2, 0x1

    const/4 v6, 0x0

    .line 1106
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v7

    const-string v8, "fcharge_enabled"

    invoke-static {v7, v8, v6}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v7

    if-ne v7, v2, :cond_0

    .line 1108
    .local v2, enabled:Z
    :goto_0
    :try_start_0
    new-instance v3, Ljava/io/File;

    const-string v7, "/sys/kernel/fast_charge"

    const-string v8, "force_fast_charge"

    invoke-direct {v3, v7, v8}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 1109
    .local v3, fastcharge:Ljava/io/File;
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v7

    if-eqz v7, :cond_2

    .line 1110
    new-instance v4, Ljava/io/FileWriter;

    invoke-direct {v4, v3}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    .line 1111
    .local v4, fwriter:Ljava/io/FileWriter;
    new-instance v0, Ljava/io/BufferedWriter;

    invoke-direct {v0, v4}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    .line 1112
    .local v0, bwriter:Ljava/io/BufferedWriter;
    if-eqz v2, :cond_1

    const-string v7, "1"

    :goto_1
    invoke-virtual {v0, v7}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 1113
    invoke-virtual {v0}, Ljava/io/BufferedWriter;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1123
    .end local v0           #bwriter:Ljava/io/BufferedWriter;
    .end local v3           #fastcharge:Ljava/io/File;
    .end local v4           #fwriter:Ljava/io/FileWriter;
    :goto_2
    new-instance v5, Landroid/content/Intent;

    invoke-direct {v5}, Landroid/content/Intent;-><init>()V

    .line 1124
    .local v5, intent:Landroid/content/Intent;
    new-instance v6, Landroid/content/ComponentName;

    const-string v7, "com.android.systemui"

    const-string v8, "com.android.systemui.SystemUIService"

    invoke-direct {v6, v7, v8}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v5, v6}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 1127
    sget-object v6, Landroid/os/UserHandle;->OWNER:Landroid/os/UserHandle;

    invoke-virtual {p0, v5, v6}, Landroid/content/Context;->startServiceAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)Landroid/content/ComponentName;

    .line 1128
    return-void

    .end local v2           #enabled:Z
    .end local v5           #intent:Landroid/content/Intent;
    :cond_0
    move v2, v6

    .line 1106
    goto :goto_0

    .line 1112
    .restart local v0       #bwriter:Ljava/io/BufferedWriter;
    .restart local v2       #enabled:Z
    .restart local v3       #fastcharge:Ljava/io/File;
    .restart local v4       #fwriter:Ljava/io/FileWriter;
    :cond_1
    :try_start_1
    const-string v7, "0"

    goto :goto_1

    .line 1115
    .end local v0           #bwriter:Ljava/io/BufferedWriter;
    .end local v4           #fwriter:Ljava/io/FileWriter;
    :cond_2
    const-string v7, "FChargeToggle"

    const-string v8, "No fast charge support"

    invoke-static {v7, v8}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    .line 1117
    .end local v3           #fastcharge:Ljava/io/File;
    :catch_0
    move-exception v1

    .line 1118
    .local v1, e:Ljava/io/IOException;
    const-string v7, "FChargeToggle"

    const-string v8, "Couldn\'t write fast_charge file"

    invoke-static {v7, v8}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1119
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v7

    const-string v8, "fcharge_enabled"

    invoke-static {v7, v8, v6}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    goto :goto_2
.end method


# virtual methods
.method reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 3
    .parameter "msg"
    .parameter "e"

    .prologue
    .line 96
    const-string v0, "SystemServer"

    const-string v1, "***********************************************"

    invoke-static {v0, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 97
    const-string v0, "SystemServer"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "BOOT FAILURE "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, p2}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 98
    return-void
.end method

.method public run()V
    .locals 152   
    .annotation build Landroid/annotation/OppoHook;
        level = .enum Landroid/annotation/OppoHook$OppoHookType;->CHANGE_CODE:Landroid/annotation/OppoHook$OppoHookType;
        note = "Jun.Zhang@Plf.Framework, to use oppo button light, three pointers move shot screen"
        property = .enum Landroid/annotation/OppoHook$OppoRomType;->ROM:Landroid/annotation/OppoHook$OppoRomType;
    .end annotation

    .prologue
    .line 115
    const/16 v7, 0xbc2

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v11

    invoke-static {v7, v11, v12}, Landroid/util/EventLog;->writeEvent(IJ)I

    .line 118
    invoke-static {}, Landroid/os/Looper;->prepareMainLooper()V

    .line 120
    const/4 v7, -0x2

    invoke-static {v7}, Landroid/os/Process;->setThreadPriority(I)V

    .line 123
    const/4 v7, 0x1

    invoke-static {v7}, Lcom/android/internal/os/BinderInternal;->disableBackgroundScheduling(Z)V

    .line 124
    const/4 v7, 0x0

    invoke-static {v7}, Landroid/os/Process;->setCanSelfBackground(Z)V

    .line 128
    const-string v7, "sys.shutdown.requested"

    const-string v9, ""

    invoke-static {v7, v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v125

    .line 130
    .local v125, shutdownAction:Ljava/lang/String;
    if-eqz v125, :cond_0

    invoke-virtual/range {v125 .. v125}, Ljava/lang/String;->length()I

    move-result v7

    if-lez v7, :cond_0

    .line 131
    const/4 v7, 0x0

    move-object/from16 v0, v125

    invoke-virtual {v0, v7}, Ljava/lang/String;->charAt(I)C

    move-result v7

    const/16 v9, 0x31

    if-ne v7, v9, :cond_10

    const/16 v117, 0x1

    .line 134
    .local v117, reboot:Z
    :goto_0
    invoke-virtual/range {v125 .. v125}, Ljava/lang/String;->length()I

    move-result v7

    const/4 v9, 0x1

    if-le v7, v9, :cond_11

    .line 135
    const/4 v7, 0x1

    invoke-virtual/range {v125 .. v125}, Ljava/lang/String;->length()I

    move-result v9

    move-object/from16 v0, v125

    invoke-virtual {v0, v7, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v116

    .line 140
    .local v116, reason:Ljava/lang/String;
    :goto_1
    move/from16 v0, v117

    move-object/from16 v1, v116

    invoke-static {v0, v1}, Lcom/android/server/power/ShutdownThread;->rebootOrShutdown(ZLjava/lang/String;)V

    .line 144
    .end local v116           #reason:Ljava/lang/String;
    .end local v117           #reboot:Z
    :cond_0
    const-string v7, "ro.factorytest"

    invoke-static {v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v89

    .line 145
    .local v89, factoryTestStr:Ljava/lang/String;
    const-string v7, ""

    move-object/from16 v0, v89

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_12

    const/16 v88, 0x0

    .line 147
    .local v88, factoryTest:I
    :goto_2
    const-string v7, "1"

    const-string v9, "ro.config.headless"

    const-string v11, "0"

    invoke-static {v9, v11}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v34

    .line 149
    .local v34, headless:Z
    const/16 v96, 0x0

    .line 150
    .local v96, installer:Lcom/android/server/pm/Installer;
    const/16 v62, 0x0

    .line 151
    .local v62, accountManager:Landroid/accounts/AccountManagerService;
    const/16 v75, 0x0

    .line 152
    .local v75, contentService:Landroid/content/ContentService;
    const/16 v98, 0x0

    .line 153
    .local v98, lights:Lcom/android/server/LightsService;
    const/16 v113, 0x0

    .line 154
    .local v113, power:Lcom/android/server/power/PowerManagerService;
    const/16 v82, 0x0

    .line 155
    .local v82, display:Lcom/android/server/display/DisplayManagerService;
    const/16 v79, 0x0

    .line 156
    .local v79, device:Lcom/android/server/DeviceHandlerService;
    const/16 v67, 0x0

    .line 157
    .local v67, battery:Lcom/android/server/BatteryService;
    const/16 v141, 0x0

    .line 158
    .local v141, vibrator:Lcom/android/server/VibratorService;
    const/16 v64, 0x0

    .line 159
    .local v64, alarm:Lcom/android/server/AlarmManagerService;
    const/16 v104, 0x0

    .line 160
    .local v104, mountService:Lcom/android/server/MountService;
    const/16 v31, 0x0

    .line 161
    .local v31, networkManagement:Lcom/android/server/NetworkManagementService;
    const/16 v30, 0x0

    .line 162
    .local v30, networkStats:Lcom/android/server/net/NetworkStatsService;
    const/16 v106, 0x0

    .line 163
    .local v106, networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    const/16 v73, 0x0

    .line 164
    .local v73, connectivity:Lcom/android/server/ConnectivityService;
    const/16 v148, 0x0

    .line 165
    .local v148, wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    const/16 v146, 0x0

    .line 166
    .local v146, wifi:Lcom/android/server/WifiService;
    const/16 v124, 0x0

    .line 167
    .local v124, serviceDiscovery:Lcom/android/server/NsdService;
    const/16 v112, 0x0

    .line 168
    .local v112, pm:Landroid/content/pm/IPackageManager;
    const/4 v5, 0x0

    .line 169
    .local v5, context:Landroid/content/Context;
    const/16 v150, 0x0

    .line 170
    .local v150, wm:Lcom/android/server/wm/WindowManagerService;
    const/16 v68, 0x0

    .line 171
    .local v68, bluetooth:Lcom/android/server/BluetoothManagerService;
    const/16 v83, 0x0

    .line 172
    .local v83, dock:Lcom/android/server/DockObserver;
    const/16 v120, 0x0

    .line 173
    .local v120, rotateSwitch:Lcom/android/server/RotationSwitchObserver;
    const/16 v139, 0x0

    .line 174
    .local v139, usb:Lcom/android/server/usb/UsbService;
    const/16 v122, 0x0

    .line 175
    .local v122, serial:Lcom/android/server/SerialService;
    const/16 v134, 0x0

    .line 176
    .local v134, twilight:Lcom/android/server/TwilightService;
    const/16 v137, 0x0

    .line 177
    .local v137, uiMode:Lcom/android/server/UiModeManagerService;
    const/16 v118, 0x0

    .line 178
    .local v118, recognition:Lcom/android/server/RecognitionManagerService;
    const/16 v130, 0x0

    .line 179
    .local v130, throttle:Lcom/android/server/ThrottleService;
    const/16 v108, 0x0

    .line 180
    .local v108, networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    const/16 v70, 0x0

    .line 181
    .local v70, commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    const/16 v95, 0x0

    .line 182
    .local v95, inputManager:Lcom/android/server/input/InputManagerService;
    const/16 v128, 0x0

    .line 189
    .local v128, telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    new-instance v136, Landroid/os/HandlerThread;

    const-string v7, "UI"

    move-object/from16 v0, v136

    invoke-direct {v0, v7}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    .line 190
    .local v136, uiHandlerThread:Landroid/os/HandlerThread;
    invoke-virtual/range {v136 .. v136}, Landroid/os/HandlerThread;->start()V

    .line 191
    new-instance v21, Landroid/os/Handler;

    invoke-virtual/range {v136 .. v136}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v7

    move-object/from16 v0, v21

    invoke-direct {v0, v7}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 192
    .local v21, uiHandler:Landroid/os/Handler;
    new-instance v7, Lcom/android/server/ServerThread$1;

    move-object/from16 v0, p0

    invoke-direct {v7, v0}, Lcom/android/server/ServerThread$1;-><init>(Lcom/android/server/ServerThread;)V

    move-object/from16 v0, v21

    invoke-virtual {v0, v7}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 209
    new-instance v151, Landroid/os/HandlerThread;

    const-string v7, "WindowManager"

    move-object/from16 v0, v151

    invoke-direct {v0, v7}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    .line 210
    .local v151, wmHandlerThread:Landroid/os/HandlerThread;
    invoke-virtual/range {v151 .. v151}, Landroid/os/HandlerThread;->start()V

    .line 211
    new-instance v22, Landroid/os/Handler;

    invoke-virtual/range {v151 .. v151}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v7

    move-object/from16 v0, v22

    invoke-direct {v0, v7}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 212
    .local v22, wmHandler:Landroid/os/Handler;
    new-instance v7, Lcom/android/server/ServerThread$2;

    move-object/from16 v0, p0

    invoke-direct {v7, v0}, Lcom/android/server/ServerThread$2;-><init>(Lcom/android/server/ServerThread;)V

    move-object/from16 v0, v22

    invoke-virtual {v0, v7}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 229
    const/16 v25, 0x0

    .line 234
    .local v25, onlyCore:Z
    :try_start_0
    const-string v7, "SystemServer"

    const-string v9, "Waiting for installd to be ready."

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 235
    new-instance v97, Lcom/android/server/pm/Installer;

    invoke-direct/range {v97 .. v97}, Lcom/android/server/pm/Installer;-><init>()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_54

    .line 236
    .end local v96           #installer:Lcom/android/server/pm/Installer;
    .local v97, installer:Lcom/android/server/pm/Installer;
    :try_start_1
    invoke-virtual/range {v97 .. v97}, Lcom/android/server/pm/Installer;->ping()Z

    .line 238
    const-string v7, "SystemServer"

    const-string v9, "Entropy Mixer"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 239
    const-string v7, "entropy"

    new-instance v9, Lcom/android/server/EntropyMixer;

    invoke-direct {v9}, Lcom/android/server/EntropyMixer;-><init>()V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 241
    const-string v7, "SystemServer"

    const-string v9, "Power Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 242
    new-instance v4, Lcom/android/server/power/PowerManagerService;

    invoke-direct {v4}, Lcom/android/server/power/PowerManagerService;-><init>()V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_55

    .line 243
    .end local v113           #power:Lcom/android/server/power/PowerManagerService;
    .local v4, power:Lcom/android/server/power/PowerManagerService;
    :try_start_2
    const-string v7, "power"

    invoke-static {v7, v4}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 245
    const-string v7, "SystemServer"

    const-string v9, "Activity Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 246
    invoke-static/range {v88 .. v88}, Lcom/android/server/am/ActivityManagerService;->main(I)Landroid/content/Context;

    move-result-object v5

    .line 248
    const-string v7, "SystemServer"

    const-string v9, "Display Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 249
    new-instance v10, Lcom/android/server/display/DisplayManagerService;

    move-object/from16 v0, v22

    move-object/from16 v1, v21

    invoke-direct {v10, v5, v0, v1}, Lcom/android/server/display/DisplayManagerService;-><init>(Landroid/content/Context;Landroid/os/Handler;Landroid/os/Handler;)V
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_56

    .line 250
    .end local v82           #display:Lcom/android/server/display/DisplayManagerService;
    .local v10, display:Lcom/android/server/display/DisplayManagerService;
    :try_start_3
    const-string v7, "display"

    const/4 v9, 0x1

    invoke-static {v7, v10, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;Z)V

    .line 252
    const-string v7, "SystemServer"

    const-string v9, "Telephony Registry"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 253
    new-instance v129, Lcom/android/server/TelephonyRegistry;

    move-object/from16 v0, v129

    invoke-direct {v0, v5}, Lcom/android/server/TelephonyRegistry;-><init>(Landroid/content/Context;)V
    :try_end_3
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_57

    .line 254
    .end local v128           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .local v129, telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :try_start_4
    const-string v7, "telephony.registry"

    move-object/from16 v0, v129

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 256
    const-string v7, "SystemServer"

    const-string v9, "Scheduling Policy"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 257
    const-string v7, "scheduling_policy"

    new-instance v9, Landroid/os/SchedulingPolicyService;

    invoke-direct {v9}, Landroid/os/SchedulingPolicyService;-><init>()V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 260
    invoke-static {v5}, Lcom/android/server/AttributeCache;->init(Landroid/content/Context;)V

    .line 262
    invoke-virtual {v10}, Lcom/android/server/display/DisplayManagerService;->waitForDefaultDisplay()Z

    move-result v7

    if-nez v7, :cond_1

    .line 263
    const-string v7, "Timeout waiting for default display to be initialized."

    new-instance v9, Ljava/lang/Throwable;

    invoke-direct {v9}, Ljava/lang/Throwable;-><init>()V

    move-object/from16 v0, p0

    invoke-virtual {v0, v7, v9}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 267
    :cond_1
    const-string v7, "SystemServer"

    const-string v9, "Package Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 269
    const-string v7, "vold.decrypt"

    invoke-static {v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v78

    .line 270
    .local v78, cryptState:Ljava/lang/String;
    const-string v7, "trigger_restart_min_framework"

    move-object/from16 v0, v78

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_13

    .line 271
    const-string v7, "SystemServer"

    const-string v9, "Detected encryption in progress - only parsing core apps"

    invoke-static {v7, v9}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 272
    const/16 v25, 0x1

    .line 278
    :cond_2
    :goto_3
    if-eqz v88, :cond_14

    const/4 v7, 0x1

    :goto_4
    move-object/from16 v0, v97

    move/from16 v1, v25

    invoke-static {v5, v0, v7, v1}, Lcom/android/server/pm/PackageManagerService;->main(Landroid/content/Context;Lcom/android/server/pm/Installer;ZZ)Landroid/content/pm/IPackageManager;
    :try_end_4
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_1

    move-result-object v112

    .line 281
    const/16 v91, 0x0

    .line 283
    .local v91, firstBoot:Z
    :try_start_5
    invoke-interface/range {v112 .. v112}, Landroid/content/pm/IPackageManager;->isFirstBoot()Z
    :try_end_5
    .catch Landroid/os/RemoteException; {:try_start_5 .. :try_end_5} :catch_3c
    .catch Ljava/lang/RuntimeException; {:try_start_5 .. :try_end_5} :catch_1

    move-result v91

    .line 287
    :goto_5
    :try_start_6
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->setSystemProcess()V

    .line 289
    const-string v7, "SystemServer"

    const-string v9, "User Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 290
    const-string v7, "user"

    invoke-static {}, Lcom/android/server/pm/UserManagerService;->getInstance()Lcom/android/server/pm/UserManagerService;

    move-result-object v9

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 294
    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v7

    move-object/from16 v0, p0

    iput-object v7, v0, Lcom/android/server/ServerThread;->mContentResolver:Landroid/content/ContentResolver;
    :try_end_6
    .catch Ljava/lang/RuntimeException; {:try_start_6 .. :try_end_6} :catch_1

    .line 298
    :try_start_7
    const-string v7, "SystemServer"

    const-string v9, "Account Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 299
    new-instance v63, Landroid/accounts/AccountManagerService;

    move-object/from16 v0, v63

    invoke-direct {v0, v5}, Landroid/accounts/AccountManagerService;-><init>(Landroid/content/Context;)V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_7 .. :try_end_7} :catch_1

    .line 300
    .end local v62           #accountManager:Landroid/accounts/AccountManagerService;
    .local v63, accountManager:Landroid/accounts/AccountManagerService;
    :try_start_8
    const-string v7, "account"

    move-object/from16 v0, v63

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_5f
    .catch Ljava/lang/RuntimeException; {:try_start_8 .. :try_end_8} :catch_58

    move-object/from16 v62, v63

    .line 305
    .end local v63           #accountManager:Landroid/accounts/AccountManagerService;
    .restart local v62       #accountManager:Landroid/accounts/AccountManagerService;
    :goto_6
    :try_start_9
    const-string v7, "SystemServer"

    const-string v9, "Content Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 306
    const/4 v7, 0x1

    move/from16 v0, v88

    if-ne v0, v7, :cond_15

    const/4 v7, 0x1

    :goto_7
    invoke-static {v5, v7}, Landroid/content/ContentService;->main(Landroid/content/Context;Z)Landroid/content/ContentService;

    move-result-object v75

    .line 309
    const-string v7, "SystemServer"

    const-string v9, "System Content Providers"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 310
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->installSystemProviders()V

    .line 313
    const-string v7, "SystemServer"

    const-string v9, "Device Handler Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 314
    new-instance v20, Lcom/android/server/DeviceHandlerService;

    move-object/from16 v0, v20

    invoke-direct {v0, v5}, Lcom/android/server/DeviceHandlerService;-><init>(Landroid/content/Context;)V
    :try_end_9
    .catch Ljava/lang/RuntimeException; {:try_start_9 .. :try_end_9} :catch_1

    .line 316
    .end local v79           #device:Lcom/android/server/DeviceHandlerService;
    .local v20, device:Lcom/android/server/DeviceHandlerService;
    :try_start_a
    const-string v7, "SystemServer"

    const-string v9, "Lights Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 317
    new-instance v6, Lcom/android/server/OppoLightsService;

    invoke-direct {v6, v5}, Lcom/android/server/OppoLightsService;-><init>(Landroid/content/Context;)V
    :try_end_a
    .catch Ljava/lang/RuntimeException; {:try_start_a .. :try_end_a} :catch_59

    .line 319
    .end local v98           #lights:Lcom/android/server/LightsService;
    .local v6, lights:Lcom/android/server/LightsService;
    :try_start_b
    const-string v7, "SystemServer"

    const-string v9, "Battery Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 320
    new-instance v8, Lcom/android/server/BatteryService;

    move-object/from16 v0, v20

    invoke-direct {v8, v5, v6, v0}, Lcom/android/server/BatteryService;-><init>(Landroid/content/Context;Lcom/android/server/LightsService;Lcom/android/internal/os/IDeviceHandler;)V
    :try_end_b
    .catch Ljava/lang/RuntimeException; {:try_start_b .. :try_end_b} :catch_5a

    .line 321
    .end local v67           #battery:Lcom/android/server/BatteryService;
    .local v8, battery:Lcom/android/server/BatteryService;
    :try_start_c
    const-string v7, "battery"

    invoke-static {v7, v8}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 323
    const-string v7, "SystemServer"

    const-string v9, "Vibrator Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 324
    new-instance v142, Lcom/android/server/OppoVibratorService;

    move-object/from16 v0, v142

    invoke-direct {v0, v5}, Lcom/android/server/OppoVibratorService;-><init>(Landroid/content/Context;)V
    :try_end_c
    .catch Ljava/lang/RuntimeException; {:try_start_c .. :try_end_c} :catch_5b

    .line 325
    .end local v141           #vibrator:Lcom/android/server/VibratorService;
    .local v142, vibrator:Lcom/android/server/VibratorService;
    :try_start_d
    const-string v7, "vibrator"

    move-object/from16 v0, v142

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 329
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v7

    invoke-static {}, Lcom/android/server/am/BatteryStatsService;->getService()Lcom/android/internal/app/IBatteryStats;

    move-result-object v9

    invoke-virtual/range {v4 .. v10}, Lcom/android/server/power/PowerManagerService;->init(Landroid/content/Context;Lcom/android/server/LightsService;Lcom/android/server/am/ActivityManagerService;Lcom/android/server/BatteryService;Lcom/android/internal/app/IBatteryStats;Lcom/android/server/display/DisplayManagerService;)V

    .line 332
    const-string v7, "SystemServer"

    const-string v9, "Alarm Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 333
    new-instance v15, Lcom/android/server/AlarmManagerService;

    invoke-direct {v15, v5}, Lcom/android/server/AlarmManagerService;-><init>(Landroid/content/Context;)V
    :try_end_d
    .catch Ljava/lang/RuntimeException; {:try_start_d .. :try_end_d} :catch_5c

    .line 334
    .end local v64           #alarm:Lcom/android/server/AlarmManagerService;
    .local v15, alarm:Lcom/android/server/AlarmManagerService;
    :try_start_e
    const-string v7, "alarm"

    invoke-static {v7, v15}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 336
    const-string v7, "SystemServer"

    const-string v9, "Init Watchdog"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 337
    invoke-static {}, Lcom/android/server/Watchdog;->getInstance()Lcom/android/server/Watchdog;

    move-result-object v11

    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v16

    move-object v12, v5

    move-object v13, v8

    move-object v14, v4

    invoke-virtual/range {v11 .. v16}, Lcom/android/server/Watchdog;->init(Landroid/content/Context;Lcom/android/server/BatteryService;Lcom/android/server/power/PowerManagerService;Lcom/android/server/AlarmManagerService;Lcom/android/server/am/ActivityManagerService;)V

    .line 340
    const-string v7, "SystemServer"

    const-string v9, "Input Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 341
    new-instance v19, Lcom/android/server/input/InputManagerService;

    move-object/from16 v0, v19

    move-object/from16 v1, v22

    invoke-direct {v0, v5, v1}, Lcom/android/server/input/InputManagerService;-><init>(Landroid/content/Context;Landroid/os/Handler;)V
    :try_end_e
    .catch Ljava/lang/RuntimeException; {:try_start_e .. :try_end_e} :catch_5d

    .line 343
    .end local v95           #inputManager:Lcom/android/server/input/InputManagerService;
    .local v19, inputManager:Lcom/android/server/input/InputManagerService;
    :try_start_f
    const-string v7, "SystemServer"

    const-string v9, "Window Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 344
    const/4 v7, 0x1

    move/from16 v0, v88

    if-eq v0, v7, :cond_16

    const/16 v23, 0x1

    :goto_8
    if-nez v91, :cond_17

    const/16 v24, 0x1

    :goto_9
    move-object/from16 v16, v5

    move-object/from16 v17, v4

    move-object/from16 v18, v10

    invoke-static/range {v16 .. v25}, Lcom/android/server/wm/WindowManagerService;->main(Landroid/content/Context;Lcom/android/server/power/PowerManagerService;Lcom/android/server/display/DisplayManagerService;Lcom/android/server/input/InputManagerService;Lcom/android/internal/os/IDeviceHandler;Landroid/os/Handler;Landroid/os/Handler;ZZZ)Lcom/android/server/wm/WindowManagerService;

    move-result-object v150

    .line 348
    const-string v7, "window"

    move-object/from16 v0, v150

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 349
    const-string v7, "input"

    move-object/from16 v0, v19

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 351
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v7

    move-object/from16 v0, v150

    invoke-virtual {v7, v0}, Lcom/android/server/am/ActivityManagerService;->setWindowManager(Lcom/android/server/wm/WindowManagerService;)V

    .line 353
    invoke-virtual/range {v150 .. v150}, Lcom/android/server/wm/WindowManagerService;->getInputMonitor()Lcom/android/server/wm/InputMonitor;

    move-result-object v7

    move-object/from16 v0, v19

    invoke-virtual {v0, v7}, Lcom/android/server/input/InputManagerService;->setWindowManagerCallbacks(Lcom/android/server/input/InputManagerService$WindowManagerCallbacks;)V

    .line 354
    invoke-virtual/range {v19 .. v19}, Lcom/android/server/input/InputManagerService;->start()V

    .line 356
    move-object/from16 v0, v150

    invoke-virtual {v10, v0}, Lcom/android/server/display/DisplayManagerService;->setWindowManager(Lcom/android/server/display/DisplayManagerService$WindowManagerFuncs;)V

    .line 357
    move-object/from16 v0, v19

    invoke-virtual {v10, v0}, Lcom/android/server/display/DisplayManagerService;->setInputManager(Lcom/android/server/display/DisplayManagerService$InputManagerFuncs;)V

    .line 362
    const-string v7, "ro.kernel.qemu"

    invoke-static {v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v9, "1"

    invoke-virtual {v7, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_18

    .line 363
    const-string v7, "SystemServer"

    const-string v9, "No Bluetooh Service (emulator)"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_f
    .catch Ljava/lang/RuntimeException; {:try_start_f .. :try_end_f} :catch_2

    :goto_a
    move-object/from16 v128, v129

    .end local v129           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v128       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v141, v142

    .end local v142           #vibrator:Lcom/android/server/VibratorService;
    .restart local v141       #vibrator:Lcom/android/server/VibratorService;
    move-object/from16 v96, v97

    .line 377
    .end local v78           #cryptState:Ljava/lang/String;
    .end local v91           #firstBoot:Z
    .end local v97           #installer:Lcom/android/server/pm/Installer;
    .restart local v96       #installer:Lcom/android/server/pm/Installer;
    :goto_b
    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    const v9, 0x1110054

    invoke-virtual {v7, v9}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v92

    .line 380
    .local v92, hasRotationLock:Z
    const/16 v80, 0x0

    .line 381
    .local v80, devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    const/16 v126, 0x0

    .line 382
    .local v126, statusBar:Lcom/android/server/StatusBarManagerService;
    const/16 v93, 0x0

    .line 383
    .local v93, imm:Lcom/android/server/InputMethodManagerService;
    const/16 v65, 0x0

    .line 384
    .local v65, appWidget:Lcom/android/server/AppWidgetService;
    const/16 v114, 0x0

    .line 385
    .local v114, profile:Lcom/android/server/ProfileManagerService;
    const/16 v110, 0x0

    .line 386
    .local v110, notification:Lcom/android/server/NotificationManagerService;
    const/16 v144, 0x0

    .line 387
    .local v144, wallpaper:Lcom/android/server/WallpaperManagerService;
    const/16 v99, 0x0

    .line 388
    .local v99, location:Lcom/android/server/LocationManagerService;
    const/16 v76, 0x0

    .line 389
    .local v76, countryDetector:Lcom/android/server/CountryDetectorService;
    const/16 v132, 0x0

    .line 390
    .local v132, tsms:Lcom/android/server/TextServicesManagerService;
    const/16 v101, 0x0

    .line 391
    .local v101, lockSettings:Lcom/android/internal/widget/LockSettingsService;
    const/16 v85, 0x0

    .line 394
    .local v85, dreamy:Lcom/android/server/dreams/DreamManagerService;
    const/4 v7, 0x1

    move/from16 v0, v88

    if-eq v0, v7, :cond_3

    .line 396
    :try_start_10
    const-string v7, "SystemServer"

    const-string v9, "Input Method Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 397
    new-instance v94, Lcom/android/server/InputMethodManagerService;

    move-object/from16 v0, v94

    move-object/from16 v1, v150

    invoke-direct {v0, v5, v1}, Lcom/android/server/InputMethodManagerService;-><init>(Landroid/content/Context;Lcom/android/server/wm/WindowManagerService;)V
    :try_end_10
    .catch Ljava/lang/Throwable; {:try_start_10 .. :try_end_10} :catch_3

    .line 398
    .end local v93           #imm:Lcom/android/server/InputMethodManagerService;
    .local v94, imm:Lcom/android/server/InputMethodManagerService;
    :try_start_11
    const-string v7, "input_method"

    move-object/from16 v0, v94

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_11
    .catch Ljava/lang/Throwable; {:try_start_11 .. :try_end_11} :catch_53

    move-object/from16 v93, v94

    .line 404
    .end local v94           #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v93       #imm:Lcom/android/server/InputMethodManagerService;
    :goto_c
    :try_start_12
    const-string v7, "SystemServer"

    const-string v9, "Accessibility Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 405
    const-string v7, "accessibility"

    new-instance v9, Lcom/android/server/accessibility/AccessibilityManagerService;

    invoke-direct {v9, v5}, Lcom/android/server/accessibility/AccessibilityManagerService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_12
    .catch Ljava/lang/Throwable; {:try_start_12 .. :try_end_12} :catch_4

    .line 413
    :cond_3
    :goto_d
    :try_start_13
    invoke-virtual/range {v150 .. v150}, Lcom/android/server/wm/WindowManagerService;->displayReady()V
    :try_end_13
    .catch Ljava/lang/Throwable; {:try_start_13 .. :try_end_13} :catch_5

    .line 419
    :goto_e
    :try_start_14
    invoke-interface/range {v112 .. v112}, Landroid/content/pm/IPackageManager;->performBootDexOpt()V
    :try_end_14
    .catch Ljava/lang/Throwable; {:try_start_14 .. :try_end_14} :catch_6

    .line 425
    :goto_f
    :try_start_15
    invoke-static {}, Landroid/app/ActivityManagerNative;->getDefault()Landroid/app/IActivityManager;

    move-result-object v7

    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v9

    const v11, 0x104046d

    invoke-virtual {v9, v11}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v9

    const/4 v11, 0x0

    invoke-interface {v7, v9, v11}, Landroid/app/IActivityManager;->showBootMessage(Ljava/lang/CharSequence;Z)V
    :try_end_15
    .catch Landroid/os/RemoteException; {:try_start_15 .. :try_end_15} :catch_52

    .line 432
    :goto_10
    const/4 v7, 0x1

    move/from16 v0, v88

    if-eq v0, v7, :cond_1b

    .line 433
    const-string v7, "0"

    const-string v9, "system_init.startmountservice"

    invoke-static {v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_4

    .line 439
    :try_start_16
    const-string v7, "SystemServer"

    const-string v9, "Mount Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 440
    new-instance v105, Lcom/android/server/MountService;

    move-object/from16 v0, v105

    invoke-direct {v0, v5}, Lcom/android/server/MountService;-><init>(Landroid/content/Context;)V
    :try_end_16
    .catch Ljava/lang/Throwable; {:try_start_16 .. :try_end_16} :catch_7

    .line 441
    .end local v104           #mountService:Lcom/android/server/MountService;
    .local v105, mountService:Lcom/android/server/MountService;
    :try_start_17
    const-string v7, "mount"

    move-object/from16 v0, v105

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_17
    .catch Ljava/lang/Throwable; {:try_start_17 .. :try_end_17} :catch_51

    move-object/from16 v104, v105

    .line 448
    .end local v105           #mountService:Lcom/android/server/MountService;
    .restart local v104       #mountService:Lcom/android/server/MountService;
    :cond_4
    :goto_11
    :try_start_18
    const-string v7, "SystemServer"

    const-string v9, "LockSettingsService"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 449
    new-instance v102, Lcom/android/internal/widget/LockSettingsService;

    move-object/from16 v0, v102

    invoke-direct {v0, v5}, Lcom/android/internal/widget/LockSettingsService;-><init>(Landroid/content/Context;)V
    :try_end_18
    .catch Ljava/lang/Throwable; {:try_start_18 .. :try_end_18} :catch_8

    .line 450
    .end local v101           #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .local v102, lockSettings:Lcom/android/internal/widget/LockSettingsService;
    :try_start_19
    const-string v7, "lock_settings"

    move-object/from16 v0, v102

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_19
    .catch Ljava/lang/Throwable; {:try_start_19 .. :try_end_19} :catch_50

    move-object/from16 v101, v102

    .line 456
    .end local v102           #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .restart local v101       #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    :goto_12
    :try_start_1a
    const-string v7, "SystemServer"

    const-string v9, "Device Policy"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 457
    new-instance v81, Lcom/android/server/DevicePolicyManagerService;

    move-object/from16 v0, v81

    invoke-direct {v0, v5}, Lcom/android/server/DevicePolicyManagerService;-><init>(Landroid/content/Context;)V
    :try_end_1a
    .catch Ljava/lang/Throwable; {:try_start_1a .. :try_end_1a} :catch_9

    .line 458
    .end local v80           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .local v81, devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    :try_start_1b
    const-string v7, "device_policy"

    move-object/from16 v0, v81

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_1b
    .catch Ljava/lang/Throwable; {:try_start_1b .. :try_end_1b} :catch_4f

    move-object/from16 v80, v81

    .line 464
    .end local v81           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v80       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    :goto_13
    :try_start_1c
    const-string v7, "SystemServer"

    const-string v9, "Status Bar"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 465
    new-instance v127, Lcom/android/server/StatusBarManagerService;

    move-object/from16 v0, v127

    move-object/from16 v1, v150

    invoke-direct {v0, v5, v1}, Lcom/android/server/StatusBarManagerService;-><init>(Landroid/content/Context;Lcom/android/server/wm/WindowManagerService;)V
    :try_end_1c
    .catch Ljava/lang/Throwable; {:try_start_1c .. :try_end_1c} :catch_a

    .line 466
    .end local v126           #statusBar:Lcom/android/server/StatusBarManagerService;
    .local v127, statusBar:Lcom/android/server/StatusBarManagerService;
    :try_start_1d
    const-string v7, "statusbar"

    move-object/from16 v0, v127

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_1d
    .catch Ljava/lang/Throwable; {:try_start_1d .. :try_end_1d} :catch_4e

    move-object/from16 v126, v127

    .line 472
    .end local v127           #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v126       #statusBar:Lcom/android/server/StatusBarManagerService;
    :goto_14
    :try_start_1e
    const-string v7, "SystemServer"

    const-string v9, "Clipboard Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 473
    const-string v7, "clipboard"

    new-instance v9, Lcom/android/server/ClipboardService;

    invoke-direct {v9, v5}, Lcom/android/server/ClipboardService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_1e
    .catch Ljava/lang/Throwable; {:try_start_1e .. :try_end_1e} :catch_b

    .line 480
    :goto_15
    :try_start_1f
    const-string v7, "SystemServer"

    const-string v9, "NetworkManagement Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 481
    invoke-static {v5}, Lcom/android/server/NetworkManagementService;->create(Landroid/content/Context;)Lcom/android/server/NetworkManagementService;

    move-result-object v31

    .line 482
    const-string v7, "network_management"

    move-object/from16 v0, v31

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_1f
    .catch Ljava/lang/Throwable; {:try_start_1f .. :try_end_1f} :catch_c

    .line 488
    :goto_16
    :try_start_20
    const-string v7, "SystemServer"

    const-string v9, "Text Service Manager Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 489
    new-instance v133, Lcom/android/server/TextServicesManagerService;

    move-object/from16 v0, v133

    invoke-direct {v0, v5}, Lcom/android/server/TextServicesManagerService;-><init>(Landroid/content/Context;)V
    :try_end_20
    .catch Ljava/lang/Throwable; {:try_start_20 .. :try_end_20} :catch_d

    .line 490
    .end local v132           #tsms:Lcom/android/server/TextServicesManagerService;
    .local v133, tsms:Lcom/android/server/TextServicesManagerService;
    :try_start_21
    const-string v7, "textservices"

    move-object/from16 v0, v133

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_21
    .catch Ljava/lang/Throwable; {:try_start_21 .. :try_end_21} :catch_4d

    move-object/from16 v132, v133

    .line 496
    .end local v133           #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v132       #tsms:Lcom/android/server/TextServicesManagerService;
    :goto_17
    :try_start_22
    const-string v7, "SystemServer"

    const-string v9, "NetworkStats Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 497
    new-instance v107, Lcom/android/server/net/NetworkStatsService;

    move-object/from16 v0, v107

    move-object/from16 v1, v31

    invoke-direct {v0, v5, v1, v15}, Lcom/android/server/net/NetworkStatsService;-><init>(Landroid/content/Context;Landroid/os/INetworkManagementService;Landroid/app/IAlarmManager;)V
    :try_end_22
    .catch Ljava/lang/Throwable; {:try_start_22 .. :try_end_22} :catch_e

    .line 498
    .end local v30           #networkStats:Lcom/android/server/net/NetworkStatsService;
    .local v107, networkStats:Lcom/android/server/net/NetworkStatsService;
    :try_start_23
    const-string v7, "netstats"

    move-object/from16 v0, v107

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_23
    .catch Ljava/lang/Throwable; {:try_start_23 .. :try_end_23} :catch_4c

    move-object/from16 v30, v107

    .line 504
    .end local v107           #networkStats:Lcom/android/server/net/NetworkStatsService;
    .restart local v30       #networkStats:Lcom/android/server/net/NetworkStatsService;
    :goto_18
    :try_start_24
    const-string v7, "SystemServer"

    const-string v9, "NetworkPolicy Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 505
    new-instance v26, Lcom/android/server/net/NetworkPolicyManagerService;

    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v28

    move-object/from16 v27, v5

    move-object/from16 v29, v4

    invoke-direct/range {v26 .. v31}, Lcom/android/server/net/NetworkPolicyManagerService;-><init>(Landroid/content/Context;Landroid/app/IActivityManager;Landroid/os/IPowerManager;Landroid/net/INetworkStatsService;Landroid/os/INetworkManagementService;)V
    :try_end_24
    .catch Ljava/lang/Throwable; {:try_start_24 .. :try_end_24} :catch_f

    .line 508
    .end local v106           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .local v26, networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    :try_start_25
    const-string v7, "netpolicy"

    move-object/from16 v0, v26

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_25
    .catch Ljava/lang/Throwable; {:try_start_25 .. :try_end_25} :catch_4b

    .line 514
    :goto_19
    :try_start_26
    const-string v7, "SystemServer"

    const-string v9, "Wi-Fi P2pService"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 515
    new-instance v149, Landroid/net/wifi/p2p/WifiP2pService;

    move-object/from16 v0, v149

    invoke-direct {v0, v5}, Landroid/net/wifi/p2p/WifiP2pService;-><init>(Landroid/content/Context;)V
    :try_end_26
    .catch Ljava/lang/Throwable; {:try_start_26 .. :try_end_26} :catch_10

    .line 516
    .end local v148           #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .local v149, wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    :try_start_27
    const-string v7, "wifip2p"

    move-object/from16 v0, v149

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_27
    .catch Ljava/lang/Throwable; {:try_start_27 .. :try_end_27} :catch_4a

    move-object/from16 v148, v149

    .line 522
    .end local v149           #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .restart local v148       #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    :goto_1a
    :try_start_28
    const-string v7, "SystemServer"

    const-string v9, "Wi-Fi Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 523
    new-instance v147, Lcom/android/server/WifiService;

    move-object/from16 v0, v147

    invoke-direct {v0, v5}, Lcom/android/server/WifiService;-><init>(Landroid/content/Context;)V
    :try_end_28
    .catch Ljava/lang/Throwable; {:try_start_28 .. :try_end_28} :catch_11

    .line 524
    .end local v146           #wifi:Lcom/android/server/WifiService;
    .local v147, wifi:Lcom/android/server/WifiService;
    :try_start_29
    const-string v7, "wifi"

    move-object/from16 v0, v147

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_29
    .catch Ljava/lang/Throwable; {:try_start_29 .. :try_end_29} :catch_49

    move-object/from16 v146, v147

    .line 530
    .end local v147           #wifi:Lcom/android/server/WifiService;
    .restart local v146       #wifi:Lcom/android/server/WifiService;
    :goto_1b
    :try_start_2a
    const-string v7, "SystemServer"

    const-string v9, "Connectivity Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 531
    new-instance v74, Lcom/android/server/ConnectivityService;

    move-object/from16 v0, v74

    move-object/from16 v1, v31

    move-object/from16 v2, v30

    move-object/from16 v3, v26

    invoke-direct {v0, v5, v1, v2, v3}, Lcom/android/server/ConnectivityService;-><init>(Landroid/content/Context;Landroid/os/INetworkManagementService;Landroid/net/INetworkStatsService;Landroid/net/INetworkPolicyManager;)V
    :try_end_2a
    .catch Ljava/lang/Throwable; {:try_start_2a .. :try_end_2a} :catch_12

    .line 533
    .end local v73           #connectivity:Lcom/android/server/ConnectivityService;
    .local v74, connectivity:Lcom/android/server/ConnectivityService;
    :try_start_2b
    const-string v7, "connectivity"

    move-object/from16 v0, v74

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 534
    move-object/from16 v0, v30

    move-object/from16 v1, v74

    invoke-virtual {v0, v1}, Lcom/android/server/net/NetworkStatsService;->bindConnectivityManager(Landroid/net/IConnectivityManager;)V

    .line 535
    move-object/from16 v0, v26

    move-object/from16 v1, v74

    invoke-virtual {v0, v1}, Lcom/android/server/net/NetworkPolicyManagerService;->bindConnectivityManager(Landroid/net/IConnectivityManager;)V

    .line 536
    invoke-virtual/range {v146 .. v146}, Lcom/android/server/WifiService;->checkAndStartWifi()V

    .line 537
    invoke-virtual/range {v148 .. v148}, Landroid/net/wifi/p2p/WifiP2pService;->connectivityServiceReady()V
    :try_end_2b
    .catch Ljava/lang/Throwable; {:try_start_2b .. :try_end_2b} :catch_48

    move-object/from16 v73, v74

    .line 543
    .end local v74           #connectivity:Lcom/android/server/ConnectivityService;
    .restart local v73       #connectivity:Lcom/android/server/ConnectivityService;
    :goto_1c
    :try_start_2c
    const-string v7, "SystemServer"

    const-string v9, "Network Service Discovery Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 544
    invoke-static {v5}, Lcom/android/server/NsdService;->create(Landroid/content/Context;)Lcom/android/server/NsdService;

    move-result-object v124

    .line 545
    const-string v7, "servicediscovery"

    move-object/from16 v0, v124

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_2c
    .catch Ljava/lang/Throwable; {:try_start_2c .. :try_end_2c} :catch_13

    .line 552
    :goto_1d
    :try_start_2d
    const-string v7, "SystemServer"

    const-string v9, "Throttle Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 553
    new-instance v131, Lcom/android/server/ThrottleService;

    move-object/from16 v0, v131

    invoke-direct {v0, v5}, Lcom/android/server/ThrottleService;-><init>(Landroid/content/Context;)V
    :try_end_2d
    .catch Ljava/lang/Throwable; {:try_start_2d .. :try_end_2d} :catch_14

    .line 554
    .end local v130           #throttle:Lcom/android/server/ThrottleService;
    .local v131, throttle:Lcom/android/server/ThrottleService;
    :try_start_2e
    const-string v7, "throttle"

    move-object/from16 v0, v131

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_2e
    .catch Ljava/lang/Throwable; {:try_start_2e .. :try_end_2e} :catch_47

    move-object/from16 v130, v131

    .line 561
    .end local v131           #throttle:Lcom/android/server/ThrottleService;
    .restart local v130       #throttle:Lcom/android/server/ThrottleService;
    :goto_1e
    :try_start_2f
    const-string v7, "SystemServer"

    const-string v9, "FM receiver Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 562
    const-string v7, "fm_receiver"

    new-instance v9, Lcom/stericsson/hardware/fm/FmReceiverService;

    invoke-direct {v9, v5}, Lcom/stericsson/hardware/fm/FmReceiverService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_2f
    .catch Ljava/lang/Throwable; {:try_start_2f .. :try_end_2f} :catch_15

    .line 569
    :goto_1f
    :try_start_30
    const-string v7, "SystemServer"

    const-string v9, "FM transmitter Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 570
    const-string v7, "fm_transmitter"

    new-instance v9, Lcom/stericsson/hardware/fm/FmTransmitterService;

    invoke-direct {v9, v5}, Lcom/stericsson/hardware/fm/FmTransmitterService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_30
    .catch Ljava/lang/Throwable; {:try_start_30 .. :try_end_30} :catch_16

    .line 576
    :goto_20
    :try_start_31
    const-string v7, "SystemServer"

    const-string v9, "UpdateLock Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 577
    const-string v7, "updatelock"

    new-instance v9, Lcom/android/server/UpdateLockService;

    invoke-direct {v9, v5}, Lcom/android/server/UpdateLockService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_31
    .catch Ljava/lang/Throwable; {:try_start_31 .. :try_end_31} :catch_17

    .line 588
    :goto_21
    if-eqz v104, :cond_5

    .line 589
    invoke-virtual/range {v104 .. v104}, Lcom/android/server/MountService;->waitForAsecScan()V

    .line 593
    :cond_5
    if-eqz v62, :cond_6

    .line 594
    :try_start_32
    invoke-virtual/range {v62 .. v62}, Landroid/accounts/AccountManagerService;->systemReady()V
    :try_end_32
    .catch Ljava/lang/Throwable; {:try_start_32 .. :try_end_32} :catch_18

    .line 600
    :cond_6
    :goto_22
    if-eqz v75, :cond_7

    .line 601
    :try_start_33
    invoke-virtual/range {v75 .. v75}, Landroid/content/ContentService;->systemReady()V
    :try_end_33
    .catch Ljava/lang/Throwable; {:try_start_33 .. :try_end_33} :catch_19

    .line 607
    :cond_7
    :goto_23
    :try_start_34
    const-string v7, "SystemServer"

    const-string v9, "Profile Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 608
    new-instance v115, Lcom/android/server/ProfileManagerService;

    move-object/from16 v0, v115

    invoke-direct {v0, v5}, Lcom/android/server/ProfileManagerService;-><init>(Landroid/content/Context;)V
    :try_end_34
    .catch Ljava/lang/Throwable; {:try_start_34 .. :try_end_34} :catch_1a

    .line 609
    .end local v114           #profile:Lcom/android/server/ProfileManagerService;
    .local v115, profile:Lcom/android/server/ProfileManagerService;
    :try_start_35
    const-string v7, "profile"

    move-object/from16 v0, v115

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_35
    .catch Ljava/lang/Throwable; {:try_start_35 .. :try_end_35} :catch_46

    move-object/from16 v114, v115

    .line 615
    .end local v115           #profile:Lcom/android/server/ProfileManagerService;
    .restart local v114       #profile:Lcom/android/server/ProfileManagerService;
    :goto_24
    :try_start_36
    const-string v7, "SystemServer"

    const-string v9, "Notification Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 616
    new-instance v111, Lcom/android/server/NotificationManagerService;

    move-object/from16 v0, v111

    move-object/from16 v1, v126

    invoke-direct {v0, v5, v1, v6}, Lcom/android/server/NotificationManagerService;-><init>(Landroid/content/Context;Lcom/android/server/StatusBarManagerService;Lcom/android/server/LightsService;)V
    :try_end_36
    .catch Ljava/lang/Throwable; {:try_start_36 .. :try_end_36} :catch_1b

    .line 617
    .end local v110           #notification:Lcom/android/server/NotificationManagerService;
    .local v111, notification:Lcom/android/server/NotificationManagerService;
    :try_start_37
    const-string v7, "notification"

    move-object/from16 v0, v111

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 618
    move-object/from16 v0, v26

    move-object/from16 v1, v111

    invoke-virtual {v0, v1}, Lcom/android/server/net/NetworkPolicyManagerService;->bindNotificationManager(Landroid/app/INotificationManager;)V
    :try_end_37
    .catch Ljava/lang/Throwable; {:try_start_37 .. :try_end_37} :catch_45

    move-object/from16 v110, v111

    .line 624
    .end local v111           #notification:Lcom/android/server/NotificationManagerService;
    .restart local v110       #notification:Lcom/android/server/NotificationManagerService;
    :goto_25
    :try_start_38
    const-string v7, "SystemServer"

    const-string v9, "Device Storage Monitor"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 625
    const-string v7, "devicestoragemonitor"

    new-instance v9, Lcom/android/server/DeviceStorageMonitorService;

    invoke-direct {v9, v5}, Lcom/android/server/DeviceStorageMonitorService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_38
    .catch Ljava/lang/Throwable; {:try_start_38 .. :try_end_38} :catch_1c

    .line 632
    :goto_26
    :try_start_39
    const-string v7, "SystemServer"

    const-string v9, "Location Manager"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 633
    new-instance v100, Lcom/android/server/LocationManagerService;

    move-object/from16 v0, v100

    invoke-direct {v0, v5}, Lcom/android/server/LocationManagerService;-><init>(Landroid/content/Context;)V
    :try_end_39
    .catch Ljava/lang/Throwable; {:try_start_39 .. :try_end_39} :catch_1d

    .line 634
    .end local v99           #location:Lcom/android/server/LocationManagerService;
    .local v100, location:Lcom/android/server/LocationManagerService;
    :try_start_3a
    const-string v7, "location"

    move-object/from16 v0, v100

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_3a
    .catch Ljava/lang/Throwable; {:try_start_3a .. :try_end_3a} :catch_44

    move-object/from16 v99, v100

    .line 640
    .end local v100           #location:Lcom/android/server/LocationManagerService;
    .restart local v99       #location:Lcom/android/server/LocationManagerService;
    :goto_27
    :try_start_3b
    const-string v7, "SystemServer"

    const-string v9, "Country Detector"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 641
    new-instance v77, Lcom/android/server/CountryDetectorService;

    move-object/from16 v0, v77

    invoke-direct {v0, v5}, Lcom/android/server/CountryDetectorService;-><init>(Landroid/content/Context;)V
    :try_end_3b
    .catch Ljava/lang/Throwable; {:try_start_3b .. :try_end_3b} :catch_1e

    .line 642
    .end local v76           #countryDetector:Lcom/android/server/CountryDetectorService;
    .local v77, countryDetector:Lcom/android/server/CountryDetectorService;
    :try_start_3c
    const-string v7, "country_detector"

    move-object/from16 v0, v77

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_3c
    .catch Ljava/lang/Throwable; {:try_start_3c .. :try_end_3c} :catch_43

    move-object/from16 v76, v77

    .line 648
    .end local v77           #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v76       #countryDetector:Lcom/android/server/CountryDetectorService;
    :goto_28
    :try_start_3d
    const-string v7, "SystemServer"

    const-string v9, "Search Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 649
    const-string v7, "search"

    new-instance v9, Landroid/server/search/SearchManagerService;

    invoke-direct {v9, v5}, Landroid/server/search/SearchManagerService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_3d
    .catch Ljava/lang/Throwable; {:try_start_3d .. :try_end_3d} :catch_1f

    .line 656
    :goto_29
    :try_start_3e
    const-string v7, "SystemServer"

    const-string v9, "DropBox Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 657
    const-string v7, "dropbox"

    new-instance v9, Lcom/android/server/DropBoxManagerService;

    new-instance v11, Ljava/io/File;

    const-string v12, "/data/system/dropbox"

    invoke-direct {v11, v12}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v9, v5, v11}, Lcom/android/server/DropBoxManagerService;-><init>(Landroid/content/Context;Ljava/io/File;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_3e
    .catch Ljava/lang/Throwable; {:try_start_3e .. :try_end_3e} :catch_20

    .line 663
    :goto_2a
    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    const v9, 0x1110031

    invoke-virtual {v7, v9}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v7

    if-eqz v7, :cond_8

    .line 666
    :try_start_3f
    const-string v7, "SystemServer"

    const-string v9, "Wallpaper Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 667
    if-nez v34, :cond_8

    .line 668
    new-instance v145, Lcom/android/server/WallpaperManagerService;

    move-object/from16 v0, v145

    invoke-direct {v0, v5}, Lcom/android/server/WallpaperManagerService;-><init>(Landroid/content/Context;)V
    :try_end_3f
    .catch Ljava/lang/Throwable; {:try_start_3f .. :try_end_3f} :catch_21

    .line 669
    .end local v144           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .local v145, wallpaper:Lcom/android/server/WallpaperManagerService;
    :try_start_40
    const-string v7, "wallpaper"

    move-object/from16 v0, v145

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_40
    .catch Ljava/lang/Throwable; {:try_start_40 .. :try_end_40} :catch_42

    move-object/from16 v144, v145

    .line 676
    .end local v145           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .restart local v144       #wallpaper:Lcom/android/server/WallpaperManagerService;
    :cond_8
    :goto_2b
    const-string v7, "0"

    const-string v9, "system_init.startaudioservice"

    invoke-static {v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_9

    .line 678
    :try_start_41
    const-string v7, "SystemServer"

    const-string v9, "Audio Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 679
    const-string v7, "audio"

    new-instance v9, Landroid/media/AudioService;

    invoke-direct {v9, v5}, Landroid/media/AudioService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_41
    .catch Ljava/lang/Throwable; {:try_start_41 .. :try_end_41} :catch_22

    .line 686
    :cond_9
    :goto_2c
    :try_start_42
    const-string v7, "SystemServer"

    const-string v9, "Dock Observer"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 688
    new-instance v84, Lcom/android/server/DockObserver;

    move-object/from16 v0, v84

    invoke-direct {v0, v5}, Lcom/android/server/DockObserver;-><init>(Landroid/content/Context;)V
    :try_end_42
    .catch Ljava/lang/Throwable; {:try_start_42 .. :try_end_42} :catch_23

    .end local v83           #dock:Lcom/android/server/DockObserver;
    .local v84, dock:Lcom/android/server/DockObserver;
    move-object/from16 v83, v84

    .line 694
    .end local v84           #dock:Lcom/android/server/DockObserver;
    .restart local v83       #dock:Lcom/android/server/DockObserver;
    :goto_2d
    if-eqz v92, :cond_a

    .line 695
    :try_start_43
    const-string v7, "SystemServer"

    const-string v9, "Rotation Switch Observer"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 697
    new-instance v121, Lcom/android/server/RotationSwitchObserver;

    move-object/from16 v0, v121

    invoke-direct {v0, v5}, Lcom/android/server/RotationSwitchObserver;-><init>(Landroid/content/Context;)V
    :try_end_43
    .catch Ljava/lang/Throwable; {:try_start_43 .. :try_end_43} :catch_24

    .end local v120           #rotateSwitch:Lcom/android/server/RotationSwitchObserver;
    .local v121, rotateSwitch:Lcom/android/server/RotationSwitchObserver;
    move-object/from16 v120, v121

    .line 704
    .end local v121           #rotateSwitch:Lcom/android/server/RotationSwitchObserver;
    .restart local v120       #rotateSwitch:Lcom/android/server/RotationSwitchObserver;
    :cond_a
    :goto_2e
    :try_start_44
    const-string v7, "SystemServer"

    const-string v9, "Wired Accessory Observer"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 706
    new-instance v7, Lcom/android/server/WiredAccessoryManager;

    move-object/from16 v0, v19

    invoke-direct {v7, v5, v0}, Lcom/android/server/WiredAccessoryManager;-><init>(Landroid/content/Context;Lcom/android/server/input/InputManagerService;)V

    move-object/from16 v0, v19

    invoke-virtual {v0, v7}, Lcom/android/server/input/InputManagerService;->setWiredAccessoryCallbacks(Lcom/android/server/input/InputManagerService$WiredAccessoryCallbacks;)V
    :try_end_44
    .catch Ljava/lang/Throwable; {:try_start_44 .. :try_end_44} :catch_25

    .line 713
    :goto_2f
    :try_start_45
    const-string v7, "SystemServer"

    const-string v9, "USB Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 715
    new-instance v140, Lcom/android/server/usb/UsbService;

    move-object/from16 v0, v140

    invoke-direct {v0, v5}, Lcom/android/server/usb/UsbService;-><init>(Landroid/content/Context;)V
    :try_end_45
    .catch Ljava/lang/Throwable; {:try_start_45 .. :try_end_45} :catch_26

    .line 716
    .end local v139           #usb:Lcom/android/server/usb/UsbService;
    .local v140, usb:Lcom/android/server/usb/UsbService;
    :try_start_46
    const-string v7, "usb"

    move-object/from16 v0, v140

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_46
    .catch Ljava/lang/Throwable; {:try_start_46 .. :try_end_46} :catch_41

    move-object/from16 v139, v140

    .line 722
    .end local v140           #usb:Lcom/android/server/usb/UsbService;
    .restart local v139       #usb:Lcom/android/server/usb/UsbService;
    :goto_30
    :try_start_47
    const-string v7, "SystemServer"

    const-string v9, "Serial Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 724
    new-instance v123, Lcom/android/server/SerialService;

    move-object/from16 v0, v123

    invoke-direct {v0, v5}, Lcom/android/server/SerialService;-><init>(Landroid/content/Context;)V
    :try_end_47
    .catch Ljava/lang/Throwable; {:try_start_47 .. :try_end_47} :catch_27

    .line 725
    .end local v122           #serial:Lcom/android/server/SerialService;
    .local v123, serial:Lcom/android/server/SerialService;
    :try_start_48
    const-string v7, "serial"

    move-object/from16 v0, v123

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_48
    .catch Ljava/lang/Throwable; {:try_start_48 .. :try_end_48} :catch_40

    move-object/from16 v122, v123

    .line 731
    .end local v123           #serial:Lcom/android/server/SerialService;
    .restart local v122       #serial:Lcom/android/server/SerialService;
    :goto_31
    :try_start_49
    const-string v7, "SystemServer"

    const-string v9, "Twilight Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 732
    new-instance v135, Lcom/android/server/TwilightService;

    move-object/from16 v0, v135

    invoke-direct {v0, v5}, Lcom/android/server/TwilightService;-><init>(Landroid/content/Context;)V
    :try_end_49
    .catch Ljava/lang/Throwable; {:try_start_49 .. :try_end_49} :catch_28

    .end local v134           #twilight:Lcom/android/server/TwilightService;
    .local v135, twilight:Lcom/android/server/TwilightService;
    move-object/from16 v134, v135

    .line 738
    .end local v135           #twilight:Lcom/android/server/TwilightService;
    .restart local v134       #twilight:Lcom/android/server/TwilightService;
    :goto_32
    :try_start_4a
    const-string v7, "SystemServer"

    const-string v9, "UI Mode Manager Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 740
    new-instance v138, Lcom/android/server/UiModeManagerService;

    move-object/from16 v0, v138

    move-object/from16 v1, v134

    invoke-direct {v0, v5, v1}, Lcom/android/server/UiModeManagerService;-><init>(Landroid/content/Context;Lcom/android/server/TwilightService;)V
    :try_end_4a
    .catch Ljava/lang/Throwable; {:try_start_4a .. :try_end_4a} :catch_29

    .end local v137           #uiMode:Lcom/android/server/UiModeManagerService;
    .local v138, uiMode:Lcom/android/server/UiModeManagerService;
    move-object/from16 v137, v138

    .line 746
    .end local v138           #uiMode:Lcom/android/server/UiModeManagerService;
    .restart local v137       #uiMode:Lcom/android/server/UiModeManagerService;
    :goto_33
    :try_start_4b
    const-string v7, "SystemServer"

    const-string v9, "Backup Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 747
    const-string v7, "backup"

    new-instance v9, Lcom/android/server/BackupManagerService;

    invoke-direct {v9, v5}, Lcom/android/server/BackupManagerService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_4b
    .catch Ljava/lang/Throwable; {:try_start_4b .. :try_end_4b} :catch_2a

    .line 754
    :goto_34
    :try_start_4c
    const-string v7, "SystemServer"

    const-string v9, "AppWidget Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 755
    new-instance v66, Lcom/android/server/AppWidgetService;

    move-object/from16 v0, v66

    invoke-direct {v0, v5}, Lcom/android/server/AppWidgetService;-><init>(Landroid/content/Context;)V
    :try_end_4c
    .catch Ljava/lang/Throwable; {:try_start_4c .. :try_end_4c} :catch_2b

    .line 756
    .end local v65           #appWidget:Lcom/android/server/AppWidgetService;
    .local v66, appWidget:Lcom/android/server/AppWidgetService;
    :try_start_4d
    const-string v7, "appwidget"

    move-object/from16 v0, v66

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_4d
    .catch Ljava/lang/Throwable; {:try_start_4d .. :try_end_4d} :catch_3f

    move-object/from16 v65, v66

    .line 762
    .end local v66           #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v65       #appWidget:Lcom/android/server/AppWidgetService;
    :goto_35
    :try_start_4e
    const-string v7, "SystemServer"

    const-string v9, "Recognition Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 763
    new-instance v119, Lcom/android/server/RecognitionManagerService;

    move-object/from16 v0, v119

    invoke-direct {v0, v5}, Lcom/android/server/RecognitionManagerService;-><init>(Landroid/content/Context;)V
    :try_end_4e
    .catch Ljava/lang/Throwable; {:try_start_4e .. :try_end_4e} :catch_2c

    .end local v118           #recognition:Lcom/android/server/RecognitionManagerService;
    .local v119, recognition:Lcom/android/server/RecognitionManagerService;
    move-object/from16 v118, v119

    .line 769
    .end local v119           #recognition:Lcom/android/server/RecognitionManagerService;
    .restart local v118       #recognition:Lcom/android/server/RecognitionManagerService;
    :goto_36
    :try_start_4f
    const-string v7, "SystemServer"

    const-string v9, "DiskStats Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 770
    const-string v7, "diskstats"

    new-instance v9, Lcom/android/server/DiskStatsService;

    invoke-direct {v9, v5}, Lcom/android/server/DiskStatsService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_4f
    .catch Ljava/lang/Throwable; {:try_start_4f .. :try_end_4f} :catch_2d

    .line 780
    :goto_37        
    move-object/from16 v0, p0

    move-object/from16 v1, v150

    invoke-direct {v0, v5, v1}, Lcom/android/server/ServerThread;->initOppoExService(Landroid/content/Context;Lcom/android/server/wm/WindowManagerService;)V

    :try_start_50
    const-string v7, "SystemServer"

    const-string v9, "SamplingProfiler Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 781
    const-string v7, "samplingprofiler"

    new-instance v9, Lcom/android/server/SamplingProfilerService;

    invoke-direct {v9, v5}, Lcom/android/server/SamplingProfilerService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_50
    .catch Ljava/lang/Throwable; {:try_start_50 .. :try_end_50} :catch_2e

    .line 788
    :goto_38
    :try_start_51
    const-string v7, "SystemServer"

    const-string v9, "NetworkTimeUpdateService"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 789
    new-instance v109, Lcom/android/server/NetworkTimeUpdateService;

    move-object/from16 v0, v109

    invoke-direct {v0, v5}, Lcom/android/server/NetworkTimeUpdateService;-><init>(Landroid/content/Context;)V
    :try_end_51
    .catch Ljava/lang/Throwable; {:try_start_51 .. :try_end_51} :catch_2f

    .end local v108           #networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    .local v109, networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    move-object/from16 v108, v109

    .line 795
    .end local v109           #networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    .restart local v108       #networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    :goto_39
    :try_start_52
    const-string v7, "SystemServer"

    const-string v9, "CommonTimeManagementService"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 796
    new-instance v71, Lcom/android/server/CommonTimeManagementService;

    move-object/from16 v0, v71

    invoke-direct {v0, v5}, Lcom/android/server/CommonTimeManagementService;-><init>(Landroid/content/Context;)V
    :try_end_52
    .catch Ljava/lang/Throwable; {:try_start_52 .. :try_end_52} :catch_30

    .line 797
    .end local v70           #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .local v71, commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    :try_start_53
    const-string v7, "commontime_management"

    move-object/from16 v0, v71

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_53
    .catch Ljava/lang/Throwable; {:try_start_53 .. :try_end_53} :catch_3e

    move-object/from16 v70, v71

    .line 803
    .end local v71           #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .restart local v70       #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    :goto_3a
    :try_start_54
    const-string v7, "SystemServer"

    const-string v9, "CertBlacklister"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 804
    new-instance v7, Lcom/android/server/CertBlacklister;

    invoke-direct {v7, v5}, Lcom/android/server/CertBlacklister;-><init>(Landroid/content/Context;)V
    :try_end_54
    .catch Ljava/lang/Throwable; {:try_start_54 .. :try_end_54} :catch_31

    .line 809
    :goto_3b
    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    const v9, 0x1110046

    invoke-virtual {v7, v9}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v7

    if-eqz v7, :cond_b

    .line 812
    :try_start_55
    const-string v7, "SystemServer"

    const-string v9, "Dreams Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 814
    new-instance v86, Lcom/android/server/dreams/DreamManagerService;

    move-object/from16 v0, v86

    move-object/from16 v1, v22

    invoke-direct {v0, v5, v1}, Lcom/android/server/dreams/DreamManagerService;-><init>(Landroid/content/Context;Landroid/os/Handler;)V
    :try_end_55
    .catch Ljava/lang/Throwable; {:try_start_55 .. :try_end_55} :catch_32

    .line 815
    .end local v85           #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .local v86, dreamy:Lcom/android/server/dreams/DreamManagerService;
    :try_start_56
    const-string v7, "dreams"

    move-object/from16 v0, v86

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_56
    .catch Ljava/lang/Throwable; {:try_start_56 .. :try_end_56} :catch_3d

    move-object/from16 v85, v86

    .line 822
    .end local v86           #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .restart local v85       #dreamy:Lcom/android/server/dreams/DreamManagerService;
    :cond_b
    :goto_3c
    :try_start_57
    const-string v7, "SystemServer"

    const-string v9, "AssetRedirectionManager Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 823
    const-string v7, "assetredirection"

    new-instance v9, Lcom/android/server/AssetRedirectionManagerService;

    invoke-direct {v9, v5}, Lcom/android/server/AssetRedirectionManagerService;-><init>(Landroid/content/Context;)V

    invoke-static {v7, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_57
    .catch Ljava/lang/Throwable; {:try_start_57 .. :try_end_57} :catch_33

    .line 830
    :goto_3d
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/android/server/ServerThread;->mContentResolver:Landroid/content/ContentResolver;

    const-string v9, "adb_port"

    const-string v11, "service.adb.tcp.port"

    const-string v12, "-1"

    invoke-static {v11, v12}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v11

    invoke-static {v7, v9, v11}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 834
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/android/server/ServerThread;->mContentResolver:Landroid/content/ContentResolver;

    const-string v9, "adb_port"

    invoke-static {v9}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v9

    const/4 v11, 0x0

    new-instance v12, Lcom/android/server/ServerThread$AdbPortObserver;

    move-object/from16 v0, p0

    invoke-direct {v12, v0}, Lcom/android/server/ServerThread$AdbPortObserver;-><init>(Lcom/android/server/ServerThread;)V

    invoke-virtual {v7, v9, v11, v12}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 840
    invoke-virtual/range {v150 .. v150}, Lcom/android/server/wm/WindowManagerService;->detectSafeMode()Z

    move-result v49

    .line 841
    .local v49, safeMode:Z
    if-eqz v49, :cond_1a

    .line 842
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v7

    invoke-virtual {v7}, Lcom/android/server/am/ActivityManagerService;->enterSafeMode()V

    .line 844
    const/4 v7, 0x1

    sput-boolean v7, Ldalvik/system/Zygote;->systemInSafeMode:Z

    .line 846
    invoke-static {}, Ldalvik/system/VMRuntime;->getRuntime()Ldalvik/system/VMRuntime;

    move-result-object v7

    invoke-virtual {v7}, Ldalvik/system/VMRuntime;->disableJitCompilation()V

    .line 855
    :goto_3e
    :try_start_58
    invoke-virtual/range {v141 .. v141}, Lcom/android/server/VibratorService;->systemReady()V
    :try_end_58
    .catch Ljava/lang/Throwable; {:try_start_58 .. :try_end_58} :catch_34

    .line 861
    :goto_3f
    :try_start_59
    invoke-virtual/range {v101 .. v101}, Lcom/android/internal/widget/LockSettingsService;->systemReady()V
    :try_end_59
    .catch Ljava/lang/Throwable; {:try_start_59 .. :try_end_59} :catch_35

    .line 866
    :goto_40
    if-eqz v80, :cond_c

    .line 868
    :try_start_5a
    invoke-virtual/range {v80 .. v80}, Lcom/android/server/DevicePolicyManagerService;->systemReady()V
    :try_end_5a
    .catch Ljava/lang/Throwable; {:try_start_5a .. :try_end_5a} :catch_36

    .line 874
    :cond_c
    :goto_41
    if-eqz v110, :cond_d

    .line 876
    :try_start_5b
    invoke-virtual/range {v110 .. v110}, Lcom/android/server/NotificationManagerService;->systemReady()V
    :try_end_5b
    .catch Ljava/lang/Throwable; {:try_start_5b .. :try_end_5b} :catch_37

    .line 883
    :cond_d
    :goto_42
    :try_start_5c
    invoke-virtual/range {v150 .. v150}, Lcom/android/server/wm/WindowManagerService;->systemReady()V
    :try_end_5c
    .catch Ljava/lang/Throwable; {:try_start_5c .. :try_end_5c} :catch_38

    .line 888
    :goto_43
    if-eqz v49, :cond_e

    .line 889
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v7

    invoke-virtual {v7}, Lcom/android/server/am/ActivityManagerService;->showSafeModeOverlay()V

    .line 895
    :cond_e
    invoke-virtual/range {v150 .. v150}, Lcom/android/server/wm/WindowManagerService;->computeNewConfiguration()Landroid/content/res/Configuration;

    move-result-object v72

    .line 896
    .local v72, config:Landroid/content/res/Configuration;
    new-instance v103, Landroid/util/DisplayMetrics;

    invoke-direct/range {v103 .. v103}, Landroid/util/DisplayMetrics;-><init>()V

    .line 897
    .local v103, metrics:Landroid/util/DisplayMetrics;
    const-string v7, "window"

    invoke-virtual {v5, v7}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v143

    check-cast v143, Landroid/view/WindowManager;

    .line 898
    .local v143, w:Landroid/view/WindowManager;
    invoke-interface/range {v143 .. v143}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v7

    move-object/from16 v0, v103

    invoke-virtual {v7, v0}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    .line 899
    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    move-object/from16 v0, v72

    move-object/from16 v1, v103

    invoke-virtual {v7, v0, v1}, Landroid/content/res/Resources;->updateConfiguration(Landroid/content/res/Configuration;Landroid/util/DisplayMetrics;)V

    .line 902
    :try_start_5d
    move-object/from16 v0, v134

    move-object/from16 v1, v85

    invoke-virtual {v4, v0, v1}, Lcom/android/server/power/PowerManagerService;->systemReady(Lcom/android/server/TwilightService;Lcom/android/server/dreams/DreamManagerService;)V
    :try_end_5d
    .catch Ljava/lang/Throwable; {:try_start_5d .. :try_end_5d} :catch_39

    .line 908
    :goto_44
    :try_start_5e
    invoke-interface/range {v112 .. v112}, Landroid/content/pm/IPackageManager;->systemReady()V
    :try_end_5e
    .catch Ljava/lang/Throwable; {:try_start_5e .. :try_end_5e} :catch_3a

    .line 914
    :goto_45
    :try_start_5f
    move/from16 v0, v49

    move/from16 v1, v25

    invoke-virtual {v10, v0, v1}, Lcom/android/server/display/DisplayManagerService;->systemReady(ZZ)V
    :try_end_5f
    .catch Ljava/lang/Throwable; {:try_start_5f .. :try_end_5f} :catch_3b

    .line 919
    :goto_46
    new-instance v90, Landroid/content/IntentFilter;

    invoke-direct/range {v90 .. v90}, Landroid/content/IntentFilter;-><init>()V

    .line 920
    .local v90, filter:Landroid/content/IntentFilter;
    const-string v7, "com.tmobile.intent.action.APP_LAUNCH_FAILURE"

    move-object/from16 v0, v90

    invoke-virtual {v0, v7}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 921
    const-string v7, "com.tmobile.intent.action.APP_LAUNCH_FAILURE_RESET"

    move-object/from16 v0, v90

    invoke-virtual {v0, v7}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 922
    const-string v7, "android.intent.action.PACKAGE_ADDED"

    move-object/from16 v0, v90

    invoke-virtual {v0, v7}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 923
    const-string v7, "android.intent.action.PACKAGE_REMOVED"

    move-object/from16 v0, v90

    invoke-virtual {v0, v7}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 924
    const-string v7, "com.tmobile.intent.category.THEME_PACKAGE_INSTALL_STATE_CHANGE"

    move-object/from16 v0, v90

    invoke-virtual {v0, v7}, Landroid/content/IntentFilter;->addCategory(Ljava/lang/String;)V

    .line 925
    const-string v7, "package"

    move-object/from16 v0, v90

    invoke-virtual {v0, v7}, Landroid/content/IntentFilter;->addDataScheme(Ljava/lang/String;)V

    .line 926
    new-instance v7, Lcom/android/server/AppsLaunchFailureReceiver;

    invoke-direct {v7}, Lcom/android/server/AppsLaunchFailureReceiver;-><init>()V

    move-object/from16 v0, v90

    invoke-virtual {v5, v7, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 929
    move-object/from16 v35, v5

    .line 930
    .local v35, contextF:Landroid/content/Context;
    move-object/from16 v36, v104

    .line 931
    .local v36, mountServiceF:Lcom/android/server/MountService;
    move-object/from16 v37, v8

    .line 932
    .local v37, batteryF:Lcom/android/server/BatteryService;
    move-object/from16 v38, v31

    .line 933
    .local v38, networkManagementF:Lcom/android/server/NetworkManagementService;
    move-object/from16 v39, v30

    .line 934
    .local v39, networkStatsF:Lcom/android/server/net/NetworkStatsService;
    move-object/from16 v40, v26

    .line 935
    .local v40, networkPolicyF:Lcom/android/server/net/NetworkPolicyManagerService;
    move-object/from16 v41, v73

    .line 936
    .local v41, connectivityF:Lcom/android/server/ConnectivityService;
    move-object/from16 v42, v83

    .line 937
    .local v42, dockF:Lcom/android/server/DockObserver;
    move-object/from16 v43, v120

    .line 938
    .local v43, rotateSwitchF:Lcom/android/server/RotationSwitchObserver;
    move-object/from16 v44, v139

    .line 939
    .local v44, usbF:Lcom/android/server/usb/UsbService;
    move-object/from16 v55, v130

    .line 940
    .local v55, throttleF:Lcom/android/server/ThrottleService;
    move-object/from16 v45, v134

    .line 941
    .local v45, twilightF:Lcom/android/server/TwilightService;
    move-object/from16 v46, v137

    .line 942
    .local v46, uiModeF:Lcom/android/server/UiModeManagerService;
    move-object/from16 v48, v65

    .line 943
    .local v48, appWidgetF:Lcom/android/server/AppWidgetService;
    move-object/from16 v50, v144

    .line 944
    .local v50, wallpaperF:Lcom/android/server/WallpaperManagerService;
    move-object/from16 v51, v93

    .line 945
    .local v51, immF:Lcom/android/server/InputMethodManagerService;
    move-object/from16 v47, v118

    .line 946
    .local v47, recognitionF:Lcom/android/server/RecognitionManagerService;
    move-object/from16 v53, v99

    .line 947
    .local v53, locationF:Lcom/android/server/LocationManagerService;
    move-object/from16 v54, v76

    .line 948
    .local v54, countryDetectorF:Lcom/android/server/CountryDetectorService;
    move-object/from16 v56, v108

    .line 949
    .local v56, networkTimeUpdaterF:Lcom/android/server/NetworkTimeUpdateService;
    move-object/from16 v57, v70

    .line 950
    .local v57, commonTimeMgmtServiceF:Lcom/android/server/CommonTimeManagementService;
    move-object/from16 v58, v132

    .line 951
    .local v58, textServiceManagerServiceF:Lcom/android/server/TextServicesManagerService;
    move-object/from16 v52, v126

    .line 952
    .local v52, statusBarF:Lcom/android/server/StatusBarManagerService;
    move-object/from16 v59, v85

    .line 953
    .local v59, dreamyF:Lcom/android/server/dreams/DreamManagerService;
    move-object/from16 v60, v19

    .line 954
    .local v60, inputManagerF:Lcom/android/server/input/InputManagerService;
    move-object/from16 v61, v128

    .line 961
    .local v61, telephonyRegistryF:Lcom/android/server/TelephonyRegistry;
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v7

    new-instance v32, Lcom/android/server/ServerThread$3;

    move-object/from16 v33, p0

    invoke-direct/range {v32 .. v61}, Lcom/android/server/ServerThread$3;-><init>(Lcom/android/server/ServerThread;ZLandroid/content/Context;Lcom/android/server/MountService;Lcom/android/server/BatteryService;Lcom/android/server/NetworkManagementService;Lcom/android/server/net/NetworkStatsService;Lcom/android/server/net/NetworkPolicyManagerService;Lcom/android/server/ConnectivityService;Lcom/android/server/DockObserver;Lcom/android/server/RotationSwitchObserver;Lcom/android/server/usb/UsbService;Lcom/android/server/TwilightService;Lcom/android/server/UiModeManagerService;Lcom/android/server/RecognitionManagerService;Lcom/android/server/AppWidgetService;ZLcom/android/server/WallpaperManagerService;Lcom/android/server/InputMethodManagerService;Lcom/android/server/StatusBarManagerService;Lcom/android/server/LocationManagerService;Lcom/android/server/CountryDetectorService;Lcom/android/server/ThrottleService;Lcom/android/server/NetworkTimeUpdateService;Lcom/android/server/CommonTimeManagementService;Lcom/android/server/TextServicesManagerService;Lcom/android/server/dreams/DreamManagerService;Lcom/android/server/input/InputManagerService;Lcom/android/server/TelephonyRegistry;)V

    move-object/from16 v0, v32

    invoke-virtual {v7, v0}, Lcom/android/server/am/ActivityManagerService;->systemReady(Ljava/lang/Runnable;)V

    .line 1096
    invoke-static {}, Landroid/os/StrictMode;->conditionallyEnableDebugLogging()Z

    move-result v7

    if-eqz v7, :cond_f

    .line 1097
    const-string v7, "SystemServer"

    const-string v9, "Enabled StrictMode for system server main thread."

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1100
    :cond_f
    invoke-static {}, Landroid/os/Looper;->loop()V

    .line 1101
    const-string v7, "SystemServer"

    const-string v9, "System ServerThread is exiting!"

    invoke-static {v7, v9}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1102
    return-void

    .line 131
    .end local v4           #power:Lcom/android/server/power/PowerManagerService;
    .end local v5           #context:Landroid/content/Context;
    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v10           #display:Lcom/android/server/display/DisplayManagerService;
    .end local v15           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v19           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v20           #device:Lcom/android/server/DeviceHandlerService;
    .end local v21           #uiHandler:Landroid/os/Handler;
    .end local v22           #wmHandler:Landroid/os/Handler;
    .end local v25           #onlyCore:Z
    .end local v26           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v30           #networkStats:Lcom/android/server/net/NetworkStatsService;
    .end local v31           #networkManagement:Lcom/android/server/NetworkManagementService;
    .end local v34           #headless:Z
    .end local v35           #contextF:Landroid/content/Context;
    .end local v36           #mountServiceF:Lcom/android/server/MountService;
    .end local v37           #batteryF:Lcom/android/server/BatteryService;
    .end local v38           #networkManagementF:Lcom/android/server/NetworkManagementService;
    .end local v39           #networkStatsF:Lcom/android/server/net/NetworkStatsService;
    .end local v40           #networkPolicyF:Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v41           #connectivityF:Lcom/android/server/ConnectivityService;
    .end local v42           #dockF:Lcom/android/server/DockObserver;
    .end local v43           #rotateSwitchF:Lcom/android/server/RotationSwitchObserver;
    .end local v44           #usbF:Lcom/android/server/usb/UsbService;
    .end local v45           #twilightF:Lcom/android/server/TwilightService;
    .end local v46           #uiModeF:Lcom/android/server/UiModeManagerService;
    .end local v47           #recognitionF:Lcom/android/server/RecognitionManagerService;
    .end local v48           #appWidgetF:Lcom/android/server/AppWidgetService;
    .end local v49           #safeMode:Z
    .end local v50           #wallpaperF:Lcom/android/server/WallpaperManagerService;
    .end local v51           #immF:Lcom/android/server/InputMethodManagerService;
    .end local v52           #statusBarF:Lcom/android/server/StatusBarManagerService;
    .end local v53           #locationF:Lcom/android/server/LocationManagerService;
    .end local v54           #countryDetectorF:Lcom/android/server/CountryDetectorService;
    .end local v55           #throttleF:Lcom/android/server/ThrottleService;
    .end local v56           #networkTimeUpdaterF:Lcom/android/server/NetworkTimeUpdateService;
    .end local v57           #commonTimeMgmtServiceF:Lcom/android/server/CommonTimeManagementService;
    .end local v58           #textServiceManagerServiceF:Lcom/android/server/TextServicesManagerService;
    .end local v59           #dreamyF:Lcom/android/server/dreams/DreamManagerService;
    .end local v60           #inputManagerF:Lcom/android/server/input/InputManagerService;
    .end local v61           #telephonyRegistryF:Lcom/android/server/TelephonyRegistry;
    .end local v62           #accountManager:Landroid/accounts/AccountManagerService;
    .end local v65           #appWidget:Lcom/android/server/AppWidgetService;
    .end local v68           #bluetooth:Lcom/android/server/BluetoothManagerService;
    .end local v70           #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .end local v72           #config:Landroid/content/res/Configuration;
    .end local v73           #connectivity:Lcom/android/server/ConnectivityService;
    .end local v75           #contentService:Landroid/content/ContentService;
    .end local v76           #countryDetector:Lcom/android/server/CountryDetectorService;
    .end local v80           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .end local v83           #dock:Lcom/android/server/DockObserver;
    .end local v85           #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .end local v88           #factoryTest:I
    .end local v89           #factoryTestStr:Ljava/lang/String;
    .end local v90           #filter:Landroid/content/IntentFilter;
    .end local v92           #hasRotationLock:Z
    .end local v93           #imm:Lcom/android/server/InputMethodManagerService;
    .end local v96           #installer:Lcom/android/server/pm/Installer;
    .end local v99           #location:Lcom/android/server/LocationManagerService;
    .end local v101           #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .end local v103           #metrics:Landroid/util/DisplayMetrics;
    .end local v104           #mountService:Lcom/android/server/MountService;
    .end local v108           #networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    .end local v110           #notification:Lcom/android/server/NotificationManagerService;
    .end local v112           #pm:Landroid/content/pm/IPackageManager;
    .end local v114           #profile:Lcom/android/server/ProfileManagerService;
    .end local v118           #recognition:Lcom/android/server/RecognitionManagerService;
    .end local v120           #rotateSwitch:Lcom/android/server/RotationSwitchObserver;
    .end local v122           #serial:Lcom/android/server/SerialService;
    .end local v124           #serviceDiscovery:Lcom/android/server/NsdService;
    .end local v126           #statusBar:Lcom/android/server/StatusBarManagerService;
    .end local v128           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .end local v130           #throttle:Lcom/android/server/ThrottleService;
    .end local v132           #tsms:Lcom/android/server/TextServicesManagerService;
    .end local v134           #twilight:Lcom/android/server/TwilightService;
    .end local v136           #uiHandlerThread:Landroid/os/HandlerThread;
    .end local v137           #uiMode:Lcom/android/server/UiModeManagerService;
    .end local v139           #usb:Lcom/android/server/usb/UsbService;
    .end local v141           #vibrator:Lcom/android/server/VibratorService;
    .end local v143           #w:Landroid/view/WindowManager;
    .end local v144           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .end local v146           #wifi:Lcom/android/server/WifiService;
    .end local v148           #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .end local v150           #wm:Lcom/android/server/wm/WindowManagerService;
    .end local v151           #wmHandlerThread:Landroid/os/HandlerThread;
    :cond_10
    const/16 v117, 0x0

    goto/16 :goto_0

    .line 137
    .restart local v117       #reboot:Z
    :cond_11
    const/16 v116, 0x0

    .restart local v116       #reason:Ljava/lang/String;
    goto/16 :goto_1

    .line 145
    .end local v116           #reason:Ljava/lang/String;
    .end local v117           #reboot:Z
    .restart local v89       #factoryTestStr:Ljava/lang/String;
    :cond_12
    invoke-static/range {v89 .. v89}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v88

    goto/16 :goto_2

    .line 273
    .restart local v4       #power:Lcom/android/server/power/PowerManagerService;
    .restart local v5       #context:Landroid/content/Context;
    .restart local v10       #display:Lcom/android/server/display/DisplayManagerService;
    .restart local v21       #uiHandler:Landroid/os/Handler;
    .restart local v22       #wmHandler:Landroid/os/Handler;
    .restart local v25       #onlyCore:Z
    .restart local v30       #networkStats:Lcom/android/server/net/NetworkStatsService;
    .restart local v31       #networkManagement:Lcom/android/server/NetworkManagementService;
    .restart local v34       #headless:Z
    .restart local v62       #accountManager:Landroid/accounts/AccountManagerService;
    .restart local v64       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v67       #battery:Lcom/android/server/BatteryService;
    .restart local v68       #bluetooth:Lcom/android/server/BluetoothManagerService;
    .restart local v70       #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .restart local v73       #connectivity:Lcom/android/server/ConnectivityService;
    .restart local v75       #contentService:Landroid/content/ContentService;
    .restart local v78       #cryptState:Ljava/lang/String;
    .restart local v79       #device:Lcom/android/server/DeviceHandlerService;
    .restart local v83       #dock:Lcom/android/server/DockObserver;
    .restart local v88       #factoryTest:I
    .restart local v95       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v97       #installer:Lcom/android/server/pm/Installer;
    .restart local v98       #lights:Lcom/android/server/LightsService;
    .restart local v104       #mountService:Lcom/android/server/MountService;
    .restart local v106       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v108       #networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    .restart local v112       #pm:Landroid/content/pm/IPackageManager;
    .restart local v118       #recognition:Lcom/android/server/RecognitionManagerService;
    .restart local v120       #rotateSwitch:Lcom/android/server/RotationSwitchObserver;
    .restart local v122       #serial:Lcom/android/server/SerialService;
    .restart local v124       #serviceDiscovery:Lcom/android/server/NsdService;
    .restart local v129       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v130       #throttle:Lcom/android/server/ThrottleService;
    .restart local v134       #twilight:Lcom/android/server/TwilightService;
    .restart local v136       #uiHandlerThread:Landroid/os/HandlerThread;
    .restart local v137       #uiMode:Lcom/android/server/UiModeManagerService;
    .restart local v139       #usb:Lcom/android/server/usb/UsbService;
    .restart local v141       #vibrator:Lcom/android/server/VibratorService;
    .restart local v146       #wifi:Lcom/android/server/WifiService;
    .restart local v148       #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .restart local v150       #wm:Lcom/android/server/wm/WindowManagerService;
    .restart local v151       #wmHandlerThread:Landroid/os/HandlerThread;
    :cond_13
    :try_start_60
    const-string v7, "1"

    move-object/from16 v0, v78

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_2

    .line 274
    const-string v7, "SystemServer"

    const-string v9, "Device encrypted - only parsing core apps"

    invoke-static {v7, v9}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 275
    const/16 v25, 0x1

    goto/16 :goto_3

    .line 278
    :cond_14
    const/4 v7, 0x0

    goto/16 :goto_4

    .line 301
    .restart local v91       #firstBoot:Z
    :catch_0
    move-exception v87

    .line 302
    .local v87, e:Ljava/lang/Throwable;
    :goto_47
    const-string v7, "SystemServer"

    const-string v9, "Failure starting Account Manager"

    move-object/from16 v0, v87

    invoke-static {v7, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_60
    .catch Ljava/lang/RuntimeException; {:try_start_60 .. :try_end_60} :catch_1

    goto/16 :goto_6

    .line 372
    .end local v78           #cryptState:Ljava/lang/String;
    .end local v87           #e:Ljava/lang/Throwable;
    .end local v91           #firstBoot:Z
    :catch_1
    move-exception v87

    move-object/from16 v128, v129

    .end local v129           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v128       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v19, v95

    .end local v95           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v19       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v15, v64

    .end local v64           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v15       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v8, v67

    .end local v67           #battery:Lcom/android/server/BatteryService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    move-object/from16 v20, v79

    .end local v79           #device:Lcom/android/server/DeviceHandlerService;
    .restart local v20       #device:Lcom/android/server/DeviceHandlerService;
    move-object/from16 v6, v98

    .end local v98           #lights:Lcom/android/server/LightsService;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    move-object/from16 v96, v97

    .line 373
    .end local v97           #installer:Lcom/android/server/pm/Installer;
    .local v87, e:Ljava/lang/RuntimeException;
    .restart local v96       #installer:Lcom/android/server/pm/Installer;
    :goto_48
    const-string v7, "System"

    const-string v9, "******************************************"

    invoke-static {v7, v9}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 374
    const-string v7, "System"

    const-string v9, "************ Failure starting core service"

    move-object/from16 v0, v87

    invoke-static {v7, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_b

    .line 306
    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v15           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v19           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v20           #device:Lcom/android/server/DeviceHandlerService;
    .end local v87           #e:Ljava/lang/RuntimeException;
    .end local v96           #installer:Lcom/android/server/pm/Installer;
    .end local v128           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v64       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v67       #battery:Lcom/android/server/BatteryService;
    .restart local v78       #cryptState:Ljava/lang/String;
    .restart local v79       #device:Lcom/android/server/DeviceHandlerService;
    .restart local v91       #firstBoot:Z
    .restart local v95       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v97       #installer:Lcom/android/server/pm/Installer;
    .restart local v98       #lights:Lcom/android/server/LightsService;
    .restart local v129       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :cond_15
    const/4 v7, 0x0

    goto/16 :goto_7

    .line 344
    .end local v64           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v67           #battery:Lcom/android/server/BatteryService;
    .end local v79           #device:Lcom/android/server/DeviceHandlerService;
    .end local v95           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v98           #lights:Lcom/android/server/LightsService;
    .end local v141           #vibrator:Lcom/android/server/VibratorService;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    .restart local v15       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v19       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v20       #device:Lcom/android/server/DeviceHandlerService;
    .restart local v142       #vibrator:Lcom/android/server/VibratorService;
    :cond_16
    const/16 v23, 0x0

    goto/16 :goto_8

    :cond_17
    const/16 v24, 0x0

    goto/16 :goto_9

    .line 364
    :cond_18
    const/4 v7, 0x1

    move/from16 v0, v88

    if-ne v0, v7, :cond_19

    .line 365
    :try_start_61
    const-string v7, "SystemServer"

    const-string v9, "No Bluetooth Service (factory test)"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_a

    .line 372
    :catch_2
    move-exception v87

    move-object/from16 v128, v129

    .end local v129           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v128       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v141, v142

    .end local v142           #vibrator:Lcom/android/server/VibratorService;
    .restart local v141       #vibrator:Lcom/android/server/VibratorService;
    move-object/from16 v96, v97

    .end local v97           #installer:Lcom/android/server/pm/Installer;
    .restart local v96       #installer:Lcom/android/server/pm/Installer;
    goto :goto_48

    .line 367
    .end local v96           #installer:Lcom/android/server/pm/Installer;
    .end local v128           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .end local v141           #vibrator:Lcom/android/server/VibratorService;
    .restart local v97       #installer:Lcom/android/server/pm/Installer;
    .restart local v129       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v142       #vibrator:Lcom/android/server/VibratorService;
    :cond_19
    const-string v7, "SystemServer"

    const-string v9, "Bluetooth Manager Service"

    invoke-static {v7, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 368
    new-instance v69, Lcom/android/server/BluetoothManagerService;

    move-object/from16 v0, v69

    invoke-direct {v0, v5}, Lcom/android/server/BluetoothManagerService;-><init>(Landroid/content/Context;)V
    :try_end_61
    .catch Ljava/lang/RuntimeException; {:try_start_61 .. :try_end_61} :catch_2

    .line 369
    .end local v68           #bluetooth:Lcom/android/server/BluetoothManagerService;
    .local v69, bluetooth:Lcom/android/server/BluetoothManagerService;
    :try_start_62
    const-string v7, "bluetooth_manager"

    move-object/from16 v0, v69

    invoke-static {v7, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_62
    .catch Ljava/lang/RuntimeException; {:try_start_62 .. :try_end_62} :catch_5e

    move-object/from16 v68, v69

    .end local v69           #bluetooth:Lcom/android/server/BluetoothManagerService;
    .restart local v68       #bluetooth:Lcom/android/server/BluetoothManagerService;
    goto/16 :goto_a

    .line 399
    .end local v78           #cryptState:Ljava/lang/String;
    .end local v91           #firstBoot:Z
    .end local v97           #installer:Lcom/android/server/pm/Installer;
    .end local v129           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .end local v142           #vibrator:Lcom/android/server/VibratorService;
    .restart local v65       #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v76       #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v80       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v85       #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .restart local v92       #hasRotationLock:Z
    .restart local v93       #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v96       #installer:Lcom/android/server/pm/Installer;
    .restart local v99       #location:Lcom/android/server/LocationManagerService;
    .restart local v101       #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .restart local v110       #notification:Lcom/android/server/NotificationManagerService;
    .restart local v114       #profile:Lcom/android/server/ProfileManagerService;
    .restart local v126       #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v128       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v132       #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v141       #vibrator:Lcom/android/server/VibratorService;
    .restart local v144       #wallpaper:Lcom/android/server/WallpaperManagerService;
    :catch_3
    move-exception v87

    .line 400
    .local v87, e:Ljava/lang/Throwable;
    :goto_49
    const-string v7, "starting Input Manager Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_c

    .line 407
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_4
    move-exception v87

    .line 408
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting Accessibility Manager"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_d

    .line 414
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_5
    move-exception v87

    .line 415
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "making display ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_e

    .line 420
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_6
    move-exception v87

    .line 421
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "performing boot dexopt"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_f

    .line 442
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_7
    move-exception v87

    .line 443
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_4a
    const-string v7, "starting Mount Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_11

    .line 451
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_8
    move-exception v87

    .line 452
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_4b
    const-string v7, "starting LockSettingsService service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_12

    .line 459
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_9
    move-exception v87

    .line 460
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_4c
    const-string v7, "starting DevicePolicyService"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_13

    .line 467
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_a
    move-exception v87

    .line 468
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_4d
    const-string v7, "starting StatusBarManagerService"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_14

    .line 475
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_b
    move-exception v87

    .line 476
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting Clipboard Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_15

    .line 483
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_c
    move-exception v87

    .line 484
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting NetworkManagement Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_16

    .line 491
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_d
    move-exception v87

    .line 492
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_4e
    const-string v7, "starting Text Service Manager Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_17

    .line 499
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_e
    move-exception v87

    .line 500
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_4f
    const-string v7, "starting NetworkStats Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_18

    .line 509
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_f
    move-exception v87

    move-object/from16 v26, v106

    .line 510
    .end local v106           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v26       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_50
    const-string v7, "starting NetworkPolicy Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_19

    .line 517
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_10
    move-exception v87

    .line 518
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_51
    const-string v7, "starting Wi-Fi P2pService"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1a

    .line 525
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_11
    move-exception v87

    .line 526
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_52
    const-string v7, "starting Wi-Fi Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1b

    .line 538
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_12
    move-exception v87

    .line 539
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_53
    const-string v7, "starting Connectivity Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1c

    .line 547
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_13
    move-exception v87

    .line 548
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting Service Discovery Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1d

    .line 556
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_14
    move-exception v87

    .line 557
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_54
    const-string v7, "starting ThrottleService"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1e

    .line 564
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_15
    move-exception v87

    .line 565
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "SystemServer"

    const-string v9, "Failure starting FM receiver Service"

    move-object/from16 v0, v87

    invoke-static {v7, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_1f

    .line 572
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_16
    move-exception v87

    .line 573
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "SystemServer"

    const-string v9, "Failure starting FM transmitter Service"

    move-object/from16 v0, v87

    invoke-static {v7, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_20

    .line 579
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_17
    move-exception v87

    .line 580
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting UpdateLockService"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_21

    .line 595
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_18
    move-exception v87

    .line 596
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "making Account Manager Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_22

    .line 602
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_19
    move-exception v87

    .line 603
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "making Content Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_23

    .line 610
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_1a
    move-exception v87

    .line 611
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_55
    const-string v7, "SystemServer"

    const-string v9, "Failure starting Profile Manager"

    move-object/from16 v0, v87

    invoke-static {v7, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_24

    .line 619
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_1b
    move-exception v87

    .line 620
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_56
    const-string v7, "starting Notification Manager"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_25

    .line 627
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_1c
    move-exception v87

    .line 628
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting DeviceStorageMonitor service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_26

    .line 635
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_1d
    move-exception v87

    .line 636
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_57
    const-string v7, "starting Location Manager"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_27

    .line 643
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_1e
    move-exception v87

    .line 644
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_58
    const-string v7, "starting Country Detector"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_28

    .line 651
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_1f
    move-exception v87

    .line 652
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting Search Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_29

    .line 659
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_20
    move-exception v87

    .line 660
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting DropBoxManagerService"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2a

    .line 671
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_21
    move-exception v87

    .line 672
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_59
    const-string v7, "starting Wallpaper Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2b

    .line 680
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_22
    move-exception v87

    .line 681
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting Audio Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2c

    .line 689
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_23
    move-exception v87

    .line 690
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting DockObserver"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2d

    .line 699
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_24
    move-exception v87

    .line 700
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting RotationSwitchObserver"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2e

    .line 708
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_25
    move-exception v87

    .line 709
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting WiredAccessoryManager"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2f

    .line 717
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_26
    move-exception v87

    .line 718
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_5a
    const-string v7, "starting UsbService"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_30

    .line 726
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_27
    move-exception v87

    .line 727
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_5b
    const-string v7, "SystemServer"

    const-string v9, "Failure starting SerialService"

    move-object/from16 v0, v87

    invoke-static {v7, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_31

    .line 733
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_28
    move-exception v87

    .line 734
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting TwilightService"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_32

    .line 741
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_29
    move-exception v87

    .line 742
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting UiModeManagerService"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_33

    .line 749
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_2a
    move-exception v87

    .line 750
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "SystemServer"

    const-string v9, "Failure starting Backup Service"

    move-object/from16 v0, v87

    invoke-static {v7, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_34

    .line 757
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_2b
    move-exception v87

    .line 758
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_5c
    const-string v7, "starting AppWidget Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_35

    .line 764
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_2c
    move-exception v87

    .line 765
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting Recognition Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_36

    .line 771
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_2d
    move-exception v87

    .line 772
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting DiskStats Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_37

    .line 783
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_2e
    move-exception v87

    .line 784
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting SamplingProfiler Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_38

    .line 790
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_2f
    move-exception v87

    .line 791
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting NetworkTimeUpdate service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_39

    .line 798
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_30
    move-exception v87

    .line 799
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_5d
    const-string v7, "starting CommonTimeManagementService service"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3a

    .line 805
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_31
    move-exception v87

    .line 806
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "starting CertBlacklister"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3b

    .line 816
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_32
    move-exception v87

    .line 817
    .restart local v87       #e:Ljava/lang/Throwable;
    :goto_5e
    const-string v7, "starting DreamManagerService"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3c

    .line 824
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_33
    move-exception v87

    .line 825
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "SystemServer"

    const-string v9, "Failure starting AssetRedirectionManager Service"

    move-object/from16 v0, v87

    invoke-static {v7, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_3d

    .line 849
    .end local v87           #e:Ljava/lang/Throwable;
    .restart local v49       #safeMode:Z
    :cond_1a
    invoke-static {}, Ldalvik/system/VMRuntime;->getRuntime()Ldalvik/system/VMRuntime;

    move-result-object v7

    invoke-virtual {v7}, Ldalvik/system/VMRuntime;->startJitCompilation()V

    goto/16 :goto_3e

    .line 856
    :catch_34
    move-exception v87

    .line 857
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "making Vibrator Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3f

    .line 862
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_35
    move-exception v87

    .line 863
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "making Lock Settings Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_40

    .line 869
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_36
    move-exception v87

    .line 870
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "making Device Policy Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_41

    .line 877
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_37
    move-exception v87

    .line 878
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "making Notification Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_42

    .line 884
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_38
    move-exception v87

    .line 885
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "making Window Manager Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_43

    .line 903
    .end local v87           #e:Ljava/lang/Throwable;
    .restart local v72       #config:Landroid/content/res/Configuration;
    .restart local v103       #metrics:Landroid/util/DisplayMetrics;
    .restart local v143       #w:Landroid/view/WindowManager;
    :catch_39
    move-exception v87

    .line 904
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "making Power Manager Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_44

    .line 909
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_3a
    move-exception v87

    .line 910
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "making Package Manager Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_45

    .line 915
    .end local v87           #e:Ljava/lang/Throwable;
    :catch_3b
    move-exception v87

    .line 916
    .restart local v87       #e:Ljava/lang/Throwable;
    const-string v7, "making Display Manager Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v87

    invoke-virtual {v0, v7, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_46

    .line 284
    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v15           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v19           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v20           #device:Lcom/android/server/DeviceHandlerService;
    .end local v26           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v49           #safeMode:Z
    .end local v65           #appWidget:Lcom/android/server/AppWidgetService;
    .end local v72           #config:Landroid/content/res/Configuration;
    .end local v76           #countryDetector:Lcom/android/server/CountryDetectorService;
    .end local v80           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .end local v85           #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .end local v87           #e:Ljava/lang/Throwable;
    .end local v92           #hasRotationLock:Z
    .end local v93           #imm:Lcom/android/server/InputMethodManagerService;
    .end local v96           #installer:Lcom/android/server/pm/Installer;
    .end local v99           #location:Lcom/android/server/LocationManagerService;
    .end local v101           #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .end local v103           #metrics:Landroid/util/DisplayMetrics;
    .end local v110           #notification:Lcom/android/server/NotificationManagerService;
    .end local v114           #profile:Lcom/android/server/ProfileManagerService;
    .end local v126           #statusBar:Lcom/android/server/StatusBarManagerService;
    .end local v128           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .end local v132           #tsms:Lcom/android/server/TextServicesManagerService;
    .end local v143           #w:Landroid/view/WindowManager;
    .end local v144           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .restart local v64       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v67       #battery:Lcom/android/server/BatteryService;
    .restart local v78       #cryptState:Ljava/lang/String;
    .restart local v79       #device:Lcom/android/server/DeviceHandlerService;
    .restart local v91       #firstBoot:Z
    .restart local v95       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v97       #installer:Lcom/android/server/pm/Installer;
    .restart local v98       #lights:Lcom/android/server/LightsService;
    .restart local v106       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v129       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :catch_3c
    move-exception v7

    goto/16 :goto_5

    .line 816
    .end local v64           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v67           #battery:Lcom/android/server/BatteryService;
    .end local v78           #cryptState:Ljava/lang/String;
    .end local v79           #device:Lcom/android/server/DeviceHandlerService;
    .end local v91           #firstBoot:Z
    .end local v95           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v97           #installer:Lcom/android/server/pm/Installer;
    .end local v98           #lights:Lcom/android/server/LightsService;
    .end local v106           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v129           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    .restart local v15       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v19       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v20       #device:Lcom/android/server/DeviceHandlerService;
    .restart local v26       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v65       #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v76       #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v80       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v86       #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .restart local v92       #hasRotationLock:Z
    .restart local v93       #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v96       #installer:Lcom/android/server/pm/Installer;
    .restart local v99       #location:Lcom/android/server/LocationManagerService;
    .restart local v101       #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .restart local v110       #notification:Lcom/android/server/NotificationManagerService;
    .restart local v114       #profile:Lcom/android/server/ProfileManagerService;
    .restart local v126       #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v128       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v132       #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v144       #wallpaper:Lcom/android/server/WallpaperManagerService;
    :catch_3d
    move-exception v87

    move-object/from16 v85, v86

    .end local v86           #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .restart local v85       #dreamy:Lcom/android/server/dreams/DreamManagerService;
    goto/16 :goto_5e

    .line 798
    .end local v70           #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .restart local v71       #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    :catch_3e
    move-exception v87

    move-object/from16 v70, v71

    .end local v71           #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .restart local v70       #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    goto/16 :goto_5d

    .line 757
    .end local v65           #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v66       #appWidget:Lcom/android/server/AppWidgetService;
    :catch_3f
    move-exception v87

    move-object/from16 v65, v66

    .end local v66           #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v65       #appWidget:Lcom/android/server/AppWidgetService;
    goto/16 :goto_5c

    .line 726
    .end local v122           #serial:Lcom/android/server/SerialService;
    .restart local v123       #serial:Lcom/android/server/SerialService;
    :catch_40
    move-exception v87

    move-object/from16 v122, v123

    .end local v123           #serial:Lcom/android/server/SerialService;
    .restart local v122       #serial:Lcom/android/server/SerialService;
    goto/16 :goto_5b

    .line 717
    .end local v139           #usb:Lcom/android/server/usb/UsbService;
    .restart local v140       #usb:Lcom/android/server/usb/UsbService;
    :catch_41
    move-exception v87

    move-object/from16 v139, v140

    .end local v140           #usb:Lcom/android/server/usb/UsbService;
    .restart local v139       #usb:Lcom/android/server/usb/UsbService;
    goto/16 :goto_5a

    .line 671
    .end local v144           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .restart local v145       #wallpaper:Lcom/android/server/WallpaperManagerService;
    :catch_42
    move-exception v87

    move-object/from16 v144, v145

    .end local v145           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .restart local v144       #wallpaper:Lcom/android/server/WallpaperManagerService;
    goto/16 :goto_59

    .line 643
    .end local v76           #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v77       #countryDetector:Lcom/android/server/CountryDetectorService;
    :catch_43
    move-exception v87

    move-object/from16 v76, v77

    .end local v77           #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v76       #countryDetector:Lcom/android/server/CountryDetectorService;
    goto/16 :goto_58

    .line 635
    .end local v99           #location:Lcom/android/server/LocationManagerService;
    .restart local v100       #location:Lcom/android/server/LocationManagerService;
    :catch_44
    move-exception v87

    move-object/from16 v99, v100

    .end local v100           #location:Lcom/android/server/LocationManagerService;
    .restart local v99       #location:Lcom/android/server/LocationManagerService;
    goto/16 :goto_57

    .line 619
    .end local v110           #notification:Lcom/android/server/NotificationManagerService;
    .restart local v111       #notification:Lcom/android/server/NotificationManagerService;
    :catch_45
    move-exception v87

    move-object/from16 v110, v111

    .end local v111           #notification:Lcom/android/server/NotificationManagerService;
    .restart local v110       #notification:Lcom/android/server/NotificationManagerService;
    goto/16 :goto_56

    .line 610
    .end local v114           #profile:Lcom/android/server/ProfileManagerService;
    .restart local v115       #profile:Lcom/android/server/ProfileManagerService;
    :catch_46
    move-exception v87

    move-object/from16 v114, v115

    .end local v115           #profile:Lcom/android/server/ProfileManagerService;
    .restart local v114       #profile:Lcom/android/server/ProfileManagerService;
    goto/16 :goto_55

    .line 556
    .end local v130           #throttle:Lcom/android/server/ThrottleService;
    .restart local v131       #throttle:Lcom/android/server/ThrottleService;
    :catch_47
    move-exception v87

    move-object/from16 v130, v131

    .end local v131           #throttle:Lcom/android/server/ThrottleService;
    .restart local v130       #throttle:Lcom/android/server/ThrottleService;
    goto/16 :goto_54

    .line 538
    .end local v73           #connectivity:Lcom/android/server/ConnectivityService;
    .restart local v74       #connectivity:Lcom/android/server/ConnectivityService;
    :catch_48
    move-exception v87

    move-object/from16 v73, v74

    .end local v74           #connectivity:Lcom/android/server/ConnectivityService;
    .restart local v73       #connectivity:Lcom/android/server/ConnectivityService;
    goto/16 :goto_53

    .line 525
    .end local v146           #wifi:Lcom/android/server/WifiService;
    .restart local v147       #wifi:Lcom/android/server/WifiService;
    :catch_49
    move-exception v87

    move-object/from16 v146, v147

    .end local v147           #wifi:Lcom/android/server/WifiService;
    .restart local v146       #wifi:Lcom/android/server/WifiService;
    goto/16 :goto_52

    .line 517
    .end local v148           #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .restart local v149       #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    :catch_4a
    move-exception v87

    move-object/from16 v148, v149

    .end local v149           #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .restart local v148       #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    goto/16 :goto_51

    .line 509
    :catch_4b
    move-exception v87

    goto/16 :goto_50

    .line 499
    .end local v26           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v30           #networkStats:Lcom/android/server/net/NetworkStatsService;
    .restart local v106       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v107       #networkStats:Lcom/android/server/net/NetworkStatsService;
    :catch_4c
    move-exception v87

    move-object/from16 v30, v107

    .end local v107           #networkStats:Lcom/android/server/net/NetworkStatsService;
    .restart local v30       #networkStats:Lcom/android/server/net/NetworkStatsService;
    goto/16 :goto_4f

    .line 491
    .end local v132           #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v133       #tsms:Lcom/android/server/TextServicesManagerService;
    :catch_4d
    move-exception v87

    move-object/from16 v132, v133

    .end local v133           #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v132       #tsms:Lcom/android/server/TextServicesManagerService;
    goto/16 :goto_4e

    .line 467
    .end local v126           #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v127       #statusBar:Lcom/android/server/StatusBarManagerService;
    :catch_4e
    move-exception v87

    move-object/from16 v126, v127

    .end local v127           #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v126       #statusBar:Lcom/android/server/StatusBarManagerService;
    goto/16 :goto_4d

    .line 459
    .end local v80           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v81       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    :catch_4f
    move-exception v87

    move-object/from16 v80, v81

    .end local v81           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v80       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    goto/16 :goto_4c

    .line 451
    .end local v101           #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .restart local v102       #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    :catch_50
    move-exception v87

    move-object/from16 v101, v102

    .end local v102           #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .restart local v101       #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    goto/16 :goto_4b

    .line 442
    .end local v104           #mountService:Lcom/android/server/MountService;
    .restart local v105       #mountService:Lcom/android/server/MountService;
    :catch_51
    move-exception v87

    move-object/from16 v104, v105

    .end local v105           #mountService:Lcom/android/server/MountService;
    .restart local v104       #mountService:Lcom/android/server/MountService;
    goto/16 :goto_4a

    .line 429
    :catch_52
    move-exception v7

    goto/16 :goto_10

    .line 399
    .end local v93           #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v94       #imm:Lcom/android/server/InputMethodManagerService;
    :catch_53
    move-exception v87

    move-object/from16 v93, v94

    .end local v94           #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v93       #imm:Lcom/android/server/InputMethodManagerService;
    goto/16 :goto_49

    .line 372
    .end local v4           #power:Lcom/android/server/power/PowerManagerService;
    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v10           #display:Lcom/android/server/display/DisplayManagerService;
    .end local v15           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v19           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v20           #device:Lcom/android/server/DeviceHandlerService;
    .end local v65           #appWidget:Lcom/android/server/AppWidgetService;
    .end local v76           #countryDetector:Lcom/android/server/CountryDetectorService;
    .end local v80           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .end local v85           #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .end local v92           #hasRotationLock:Z
    .end local v93           #imm:Lcom/android/server/InputMethodManagerService;
    .end local v99           #location:Lcom/android/server/LocationManagerService;
    .end local v101           #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .end local v110           #notification:Lcom/android/server/NotificationManagerService;
    .end local v114           #profile:Lcom/android/server/ProfileManagerService;
    .end local v126           #statusBar:Lcom/android/server/StatusBarManagerService;
    .end local v132           #tsms:Lcom/android/server/TextServicesManagerService;
    .end local v144           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .restart local v64       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v67       #battery:Lcom/android/server/BatteryService;
    .restart local v79       #device:Lcom/android/server/DeviceHandlerService;
    .restart local v82       #display:Lcom/android/server/display/DisplayManagerService;
    .restart local v95       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v98       #lights:Lcom/android/server/LightsService;
    .restart local v113       #power:Lcom/android/server/power/PowerManagerService;
    :catch_54
    move-exception v87

    move-object/from16 v19, v95

    .end local v95           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v19       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v15, v64

    .end local v64           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v15       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v8, v67

    .end local v67           #battery:Lcom/android/server/BatteryService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    move-object/from16 v20, v79

    .end local v79           #device:Lcom/android/server/DeviceHandlerService;
    .restart local v20       #device:Lcom/android/server/DeviceHandlerService;
    move-object/from16 v10, v82

    .end local v82           #display:Lcom/android/server/display/DisplayManagerService;
    .restart local v10       #display:Lcom/android/server/display/DisplayManagerService;
    move-object/from16 v4, v113

    .end local v113           #power:Lcom/android/server/power/PowerManagerService;
    .restart local v4       #power:Lcom/android/server/power/PowerManagerService;
    move-object/from16 v6, v98

    .end local v98           #lights:Lcom/android/server/LightsService;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    goto/16 :goto_48

    .end local v4           #power:Lcom/android/server/power/PowerManagerService;
    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v10           #display:Lcom/android/server/display/DisplayManagerService;
    .end local v15           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v19           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v20           #device:Lcom/android/server/DeviceHandlerService;
    .end local v96           #installer:Lcom/android/server/pm/Installer;
    .restart local v64       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v67       #battery:Lcom/android/server/BatteryService;
    .restart local v79       #device:Lcom/android/server/DeviceHandlerService;
    .restart local v82       #display:Lcom/android/server/display/DisplayManagerService;
    .restart local v95       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v97       #installer:Lcom/android/server/pm/Installer;
    .restart local v98       #lights:Lcom/android/server/LightsService;
    .restart local v113       #power:Lcom/android/server/power/PowerManagerService;
    :catch_55
    move-exception v87

    move-object/from16 v19, v95

    .end local v95           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v19       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v15, v64

    .end local v64           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v15       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v8, v67

    .end local v67           #battery:Lcom/android/server/BatteryService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    move-object/from16 v20, v79

    .end local v79           #device:Lcom/android/server/DeviceHandlerService;
    .restart local v20       #device:Lcom/android/server/DeviceHandlerService;
    move-object/from16 v10, v82

    .end local v82           #display:Lcom/android/server/display/DisplayManagerService;
    .restart local v10       #display:Lcom/android/server/display/DisplayManagerService;
    move-object/from16 v4, v113

    .end local v113           #power:Lcom/android/server/power/PowerManagerService;
    .restart local v4       #power:Lcom/android/server/power/PowerManagerService;
    move-object/from16 v6, v98

    .end local v98           #lights:Lcom/android/server/LightsService;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    move-object/from16 v96, v97

    .end local v97           #installer:Lcom/android/server/pm/Installer;
    .restart local v96       #installer:Lcom/android/server/pm/Installer;
    goto/16 :goto_48

    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v10           #display:Lcom/android/server/display/DisplayManagerService;
    .end local v15           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v19           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v20           #device:Lcom/android/server/DeviceHandlerService;
    .end local v96           #installer:Lcom/android/server/pm/Installer;
    .restart local v64       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v67       #battery:Lcom/android/server/BatteryService;
    .restart local v79       #device:Lcom/android/server/DeviceHandlerService;
    .restart local v82       #display:Lcom/android/server/display/DisplayManagerService;
    .restart local v95       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v97       #installer:Lcom/android/server/pm/Installer;
    .restart local v98       #lights:Lcom/android/server/LightsService;
    :catch_56
    move-exception v87

    move-object/from16 v19, v95

    .end local v95           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v19       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v15, v64

    .end local v64           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v15       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v8, v67

    .end local v67           #battery:Lcom/android/server/BatteryService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    move-object/from16 v20, v79

    .end local v79           #device:Lcom/android/server/DeviceHandlerService;
    .restart local v20       #device:Lcom/android/server/DeviceHandlerService;
    move-object/from16 v10, v82

    .end local v82           #display:Lcom/android/server/display/DisplayManagerService;
    .restart local v10       #display:Lcom/android/server/display/DisplayManagerService;
    move-object/from16 v6, v98

    .end local v98           #lights:Lcom/android/server/LightsService;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    move-object/from16 v96, v97

    .end local v97           #installer:Lcom/android/server/pm/Installer;
    .restart local v96       #installer:Lcom/android/server/pm/Installer;
    goto/16 :goto_48

    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v15           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v19           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v20           #device:Lcom/android/server/DeviceHandlerService;
    .end local v96           #installer:Lcom/android/server/pm/Installer;
    .restart local v64       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v67       #battery:Lcom/android/server/BatteryService;
    .restart local v79       #device:Lcom/android/server/DeviceHandlerService;
    .restart local v95       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v97       #installer:Lcom/android/server/pm/Installer;
    .restart local v98       #lights:Lcom/android/server/LightsService;
    :catch_57
    move-exception v87

    move-object/from16 v19, v95

    .end local v95           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v19       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v15, v64

    .end local v64           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v15       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v8, v67

    .end local v67           #battery:Lcom/android/server/BatteryService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    move-object/from16 v20, v79

    .end local v79           #device:Lcom/android/server/DeviceHandlerService;
    .restart local v20       #device:Lcom/android/server/DeviceHandlerService;
    move-object/from16 v6, v98

    .end local v98           #lights:Lcom/android/server/LightsService;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    move-object/from16 v96, v97

    .end local v97           #installer:Lcom/android/server/pm/Installer;
    .restart local v96       #installer:Lcom/android/server/pm/Installer;
    goto/16 :goto_48

    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v15           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v19           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v20           #device:Lcom/android/server/DeviceHandlerService;
    .end local v62           #accountManager:Landroid/accounts/AccountManagerService;
    .end local v96           #installer:Lcom/android/server/pm/Installer;
    .end local v128           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v63       #accountManager:Landroid/accounts/AccountManagerService;
    .restart local v64       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v67       #battery:Lcom/android/server/BatteryService;
    .restart local v78       #cryptState:Ljava/lang/String;
    .restart local v79       #device:Lcom/android/server/DeviceHandlerService;
    .restart local v91       #firstBoot:Z
    .restart local v95       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v97       #installer:Lcom/android/server/pm/Installer;
    .restart local v98       #lights:Lcom/android/server/LightsService;
    .restart local v129       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :catch_58
    move-exception v87

    move-object/from16 v128, v129

    .end local v129           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v128       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v19, v95

    .end local v95           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v19       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v15, v64

    .end local v64           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v15       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v8, v67

    .end local v67           #battery:Lcom/android/server/BatteryService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    move-object/from16 v20, v79

    .end local v79           #device:Lcom/android/server/DeviceHandlerService;
    .restart local v20       #device:Lcom/android/server/DeviceHandlerService;
    move-object/from16 v6, v98

    .end local v98           #lights:Lcom/android/server/LightsService;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    move-object/from16 v62, v63

    .end local v63           #accountManager:Landroid/accounts/AccountManagerService;
    .restart local v62       #accountManager:Landroid/accounts/AccountManagerService;
    move-object/from16 v96, v97

    .end local v97           #installer:Lcom/android/server/pm/Installer;
    .restart local v96       #installer:Lcom/android/server/pm/Installer;
    goto/16 :goto_48

    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v15           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v19           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v96           #installer:Lcom/android/server/pm/Installer;
    .end local v128           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v64       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v67       #battery:Lcom/android/server/BatteryService;
    .restart local v95       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v97       #installer:Lcom/android/server/pm/Installer;
    .restart local v98       #lights:Lcom/android/server/LightsService;
    .restart local v129       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :catch_59
    move-exception v87

    move-object/from16 v128, v129

    .end local v129           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v128       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v19, v95

    .end local v95           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v19       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v15, v64

    .end local v64           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v15       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v8, v67

    .end local v67           #battery:Lcom/android/server/BatteryService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    move-object/from16 v6, v98

    .end local v98           #lights:Lcom/android/server/LightsService;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    move-object/from16 v96, v97

    .end local v97           #installer:Lcom/android/server/pm/Installer;
    .restart local v96       #installer:Lcom/android/server/pm/Installer;
    goto/16 :goto_48

    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v15           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v19           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v96           #installer:Lcom/android/server/pm/Installer;
    .end local v128           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v64       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v67       #battery:Lcom/android/server/BatteryService;
    .restart local v95       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v97       #installer:Lcom/android/server/pm/Installer;
    .restart local v129       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :catch_5a
    move-exception v87

    move-object/from16 v128, v129

    .end local v129           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v128       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v19, v95

    .end local v95           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v19       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v15, v64

    .end local v64           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v15       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v8, v67

    .end local v67           #battery:Lcom/android/server/BatteryService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    move-object/from16 v96, v97

    .end local v97           #installer:Lcom/android/server/pm/Installer;
    .restart local v96       #installer:Lcom/android/server/pm/Installer;
    goto/16 :goto_48

    .end local v15           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v19           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v96           #installer:Lcom/android/server/pm/Installer;
    .end local v128           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v64       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v95       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v97       #installer:Lcom/android/server/pm/Installer;
    .restart local v129       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :catch_5b
    move-exception v87

    move-object/from16 v128, v129

    .end local v129           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v128       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v19, v95

    .end local v95           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v19       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v15, v64

    .end local v64           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v15       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v96, v97

    .end local v97           #installer:Lcom/android/server/pm/Installer;
    .restart local v96       #installer:Lcom/android/server/pm/Installer;
    goto/16 :goto_48

    .end local v15           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v19           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v96           #installer:Lcom/android/server/pm/Installer;
    .end local v128           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .end local v141           #vibrator:Lcom/android/server/VibratorService;
    .restart local v64       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v95       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v97       #installer:Lcom/android/server/pm/Installer;
    .restart local v129       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v142       #vibrator:Lcom/android/server/VibratorService;
    :catch_5c
    move-exception v87

    move-object/from16 v128, v129

    .end local v129           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v128       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v19, v95

    .end local v95           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v19       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v15, v64

    .end local v64           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v15       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v141, v142

    .end local v142           #vibrator:Lcom/android/server/VibratorService;
    .restart local v141       #vibrator:Lcom/android/server/VibratorService;
    move-object/from16 v96, v97

    .end local v97           #installer:Lcom/android/server/pm/Installer;
    .restart local v96       #installer:Lcom/android/server/pm/Installer;
    goto/16 :goto_48

    .end local v19           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v96           #installer:Lcom/android/server/pm/Installer;
    .end local v128           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .end local v141           #vibrator:Lcom/android/server/VibratorService;
    .restart local v95       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v97       #installer:Lcom/android/server/pm/Installer;
    .restart local v129       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v142       #vibrator:Lcom/android/server/VibratorService;
    :catch_5d
    move-exception v87

    move-object/from16 v128, v129

    .end local v129           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v128       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v19, v95

    .end local v95           #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v19       #inputManager:Lcom/android/server/input/InputManagerService;
    move-object/from16 v141, v142

    .end local v142           #vibrator:Lcom/android/server/VibratorService;
    .restart local v141       #vibrator:Lcom/android/server/VibratorService;
    move-object/from16 v96, v97

    .end local v97           #installer:Lcom/android/server/pm/Installer;
    .restart local v96       #installer:Lcom/android/server/pm/Installer;
    goto/16 :goto_48

    .end local v68           #bluetooth:Lcom/android/server/BluetoothManagerService;
    .end local v96           #installer:Lcom/android/server/pm/Installer;
    .end local v128           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .end local v141           #vibrator:Lcom/android/server/VibratorService;
    .restart local v69       #bluetooth:Lcom/android/server/BluetoothManagerService;
    .restart local v97       #installer:Lcom/android/server/pm/Installer;
    .restart local v129       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v142       #vibrator:Lcom/android/server/VibratorService;
    :catch_5e
    move-exception v87

    move-object/from16 v128, v129

    .end local v129           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v128       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    move-object/from16 v68, v69

    .end local v69           #bluetooth:Lcom/android/server/BluetoothManagerService;
    .restart local v68       #bluetooth:Lcom/android/server/BluetoothManagerService;
    move-object/from16 v141, v142

    .end local v142           #vibrator:Lcom/android/server/VibratorService;
    .restart local v141       #vibrator:Lcom/android/server/VibratorService;
    move-object/from16 v96, v97

    .end local v97           #installer:Lcom/android/server/pm/Installer;
    .restart local v96       #installer:Lcom/android/server/pm/Installer;
    goto/16 :goto_48

    .line 301
    .end local v6           #lights:Lcom/android/server/LightsService;
    .end local v8           #battery:Lcom/android/server/BatteryService;
    .end local v15           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v19           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v20           #device:Lcom/android/server/DeviceHandlerService;
    .end local v62           #accountManager:Landroid/accounts/AccountManagerService;
    .end local v96           #installer:Lcom/android/server/pm/Installer;
    .end local v128           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v63       #accountManager:Landroid/accounts/AccountManagerService;
    .restart local v64       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v67       #battery:Lcom/android/server/BatteryService;
    .restart local v79       #device:Lcom/android/server/DeviceHandlerService;
    .restart local v95       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v97       #installer:Lcom/android/server/pm/Installer;
    .restart local v98       #lights:Lcom/android/server/LightsService;
    .restart local v129       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    :catch_5f
    move-exception v87

    move-object/from16 v62, v63

    .end local v63           #accountManager:Landroid/accounts/AccountManagerService;
    .restart local v62       #accountManager:Landroid/accounts/AccountManagerService;
    goto/16 :goto_47

    .end local v64           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v67           #battery:Lcom/android/server/BatteryService;
    .end local v78           #cryptState:Ljava/lang/String;
    .end local v79           #device:Lcom/android/server/DeviceHandlerService;
    .end local v91           #firstBoot:Z
    .end local v95           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v97           #installer:Lcom/android/server/pm/Installer;
    .end local v98           #lights:Lcom/android/server/LightsService;
    .end local v129           #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v6       #lights:Lcom/android/server/LightsService;
    .restart local v8       #battery:Lcom/android/server/BatteryService;
    .restart local v15       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v19       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v20       #device:Lcom/android/server/DeviceHandlerService;
    .restart local v65       #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v76       #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v80       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v85       #dreamy:Lcom/android/server/dreams/DreamManagerService;
    .restart local v92       #hasRotationLock:Z
    .restart local v93       #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v96       #installer:Lcom/android/server/pm/Installer;
    .restart local v99       #location:Lcom/android/server/LocationManagerService;
    .restart local v101       #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .restart local v110       #notification:Lcom/android/server/NotificationManagerService;
    .restart local v114       #profile:Lcom/android/server/ProfileManagerService;
    .restart local v126       #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v128       #telephonyRegistry:Lcom/android/server/TelephonyRegistry;
    .restart local v132       #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v144       #wallpaper:Lcom/android/server/WallpaperManagerService;
    :cond_1b
    move-object/from16 v26, v106

    .end local v106           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v26       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    goto/16 :goto_3d
.end method

.method private initOppoExService(Landroid/content/Context;Lcom/android/server/wm/WindowManagerService;)V
    .locals 4
    .parameter "context"
    .parameter "wm"
    .annotation build Landroid/annotation/OppoHook;
        level = .enum Landroid/annotation/OppoHook$OppoHookType;->NEW_METHOD:Landroid/annotation/OppoHook$OppoHookType;
        note = "Jun.Zhang@Plf.Framework, for start oppo ex service, three pointers move shot screen, Wanglan add for smali"
        property = .enum Landroid/annotation/OppoHook$OppoRomType;->ROM:Landroid/annotation/OppoHook$OppoRomType;
    .end annotation

    .prologue
    :try_start_0
    const-string v2, "SystemServer"

    const-string v3, "Oppo Expand Service"

    invoke-static {v2, v3}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v1, Lcom/android/server/oppo/OppoExService;

    invoke-direct {v1, p1, p2}, Lcom/android/server/oppo/OppoExService;-><init>(Landroid/content/Context;Lcom/android/server/wm/WindowManagerService;)V

    .local v1, oppoExService:Lcom/android/server/oppo/OppoExService;
    const-string v2, "OPPOExService"

    invoke-static {v2, v1}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1           #oppoExService:Lcom/android/server/oppo/OppoExService;
    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, e:Ljava/lang/Throwable;
    const-string v2, "SystemServer"

    const-string v3, "Failure starting Oppo Service"

    invoke-static {v2, v3, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method
