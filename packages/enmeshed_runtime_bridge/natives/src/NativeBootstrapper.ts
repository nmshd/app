import { ILokiJsDatabaseFactory } from "@js-soft/docdb-access-loki";
import { ILogger } from "@js-soft/logging-abstractions";
import {
  INativeAuthenticationAccess,
  INativeBootstrapper,
  INativeConfigAccess,
  INativeDeviceInfoAccess,
  INativeEnvironment,
  INativeEventBus,
  INativeFileAccess,
  INativeKeychainAccess,
  INativeLaunchOptions,
  INativeLoggerFactory,
  INativeNotificationAccess,
  INativePushNotificationAccess,
  INativeScannerAccess,
  NativeErrorCodes,
  NativePlatform,
  ThemeEvent,
} from "@js-soft/native-abstractions";
import { Result } from "@js-soft/ts-utils";
import { AuthenticationAccess } from "./AuthenticationAccess";
import { ConfigAccess } from "./ConfigAccess";
import { DatabaseFactory } from "./DatabaseFactory";
import { DeviceInfoAccess } from "./DeviceInfoAccess";
import { EventBus } from "./EventBus";
import { FileAccess } from "./FileAccess";
import { KeychainAccess } from "./KeychainAccess";
import { LaunchOptions } from "./LaunchOptions";
import { LoggerFactory } from "./LoggerFactory";
import { NotificationAccess } from "./NotificationAccess";
import { PushNotificationAccess } from "./PushNotificationAccess";
import { ScannerAccess } from "./ScannerAccess";

export class NativeBootstrapper implements INativeBootstrapper {
  private logger!: ILogger;
  private nativeAuthenticationAccess!: INativeAuthenticationAccess;
  private nativeConfigAccess!: INativeConfigAccess;
  private nativeDatabaseFactory!: ILokiJsDatabaseFactory;
  private nativeDeviceInfoAccess!: INativeDeviceInfoAccess;
  private nativeEventBus!: INativeEventBus;
  private nativeFileAccess!: INativeFileAccess;
  private nativeKeychainAccess!: INativeKeychainAccess;
  private nativeLoggerFactory!: INativeLoggerFactory;
  private nativeNotificationAccess!: INativeNotificationAccess;
  private nativeScannerAccess!: INativeScannerAccess;
  private nativePushNotificationAccess!: INativePushNotificationAccess;
  private nativeLaunchOptions!: INativeLaunchOptions;

  private initialized = false;
  public get isInitialized(): boolean {
    return this.initialized;
  }

  public get nativeEnvironment(): INativeEnvironment {
    if (!this.initialized) {
      throw new Error(NativeErrorCodes.BOOTSTRAP_NOT_INITIALIZED);
    }

    return {
      platform: NativePlatform.Node,
      eventBus: this.nativeEventBus,
      authenticationAccess: this.nativeAuthenticationAccess,
      configAccess: this.nativeConfigAccess,
      databaseFactory: this.nativeDatabaseFactory,
      deviceInfoAccess: this.nativeDeviceInfoAccess,
      fileAccess: this.nativeFileAccess,
      keychainAccess: this.nativeKeychainAccess,
      loggerFactory: this.nativeLoggerFactory,
      notificationAccess: this.nativeNotificationAccess,
      pushNotificationAccess: this.nativePushNotificationAccess,
      scannerAccess: this.nativeScannerAccess,
    };
  }

  public async init(): Promise<Result<void>> {
    if (this.initialized) {
      throw new Error(NativeErrorCodes.BOOTSTRAP_ALREADY_INITIALIZED);
    }

    this.nativeEventBus = new EventBus();
    await this.nativeEventBus.init();

    // window.addEventListener("beforeunload", () => {
    //     this.nativeEventBus.publish(new AppCloseEvent());
    // });

    const configAccess = new ConfigAccess();
    this.nativeConfigAccess = configAccess;
    const fileAccess = new FileAccess();
    await fileAccess.init();
    this.nativeFileAccess = fileAccess;
    // if (!(await this.nativeFileAccess.existsDirectory("logs")).value) {
    //     await this.nativeFileAccess.createDirectory("logs");
    // }
    // if (!(await this.nativeFileAccess.existsDirectory("data")).value) {
    //     await this.nativeFileAccess.createDirectory("data");
    // }
    this.nativeLoggerFactory = new LoggerFactory();
    await this.nativeLoggerFactory.init();
    this.logger = this.nativeLoggerFactory.getLogger(NativeBootstrapper);
    this.nativeLaunchOptions = new LaunchOptions(
      this.logger,
      this.nativeEventBus,
      this.nativeConfigAccess
    );
    await this.nativeLaunchOptions.init();
    this.nativeAuthenticationAccess = new AuthenticationAccess(this.logger);
    this.nativeDatabaseFactory = new DatabaseFactory(fileAccess);
    this.nativeDeviceInfoAccess = new DeviceInfoAccess();
    await this.nativeDeviceInfoAccess.init();
    const keychainAccess = new KeychainAccess(
      this.logger,
      this.nativeConfigAccess
    );
    await keychainAccess.init();
    this.nativeKeychainAccess = keychainAccess;
    this.nativeNotificationAccess = new NotificationAccess(
      this.logger,
      this.nativeConfigAccess
    );
    await this.nativeNotificationAccess.init();
    this.nativeScannerAccess = new ScannerAccess(this.logger);
    this.nativePushNotificationAccess = new PushNotificationAccess(
      this.logger,
      this.nativeConfigAccess,
      this.nativeEventBus
    );
    await this.nativePushNotificationAccess.init();
    this.initialized = true;

    this.nativeEventBus.subscribe(ThemeEvent, this.handleThemeEvent.bind(this));

    return Result.ok(undefined);
  }

  private handleThemeEvent(event: ThemeEvent): void {
    this.logger.trace("Received ThemeEvent", event);
  }
}
