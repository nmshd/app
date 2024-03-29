import { ILokiJsDatabaseFactory } from "@js-soft/docdb-access-loki";
import {
  INativeDeviceInfoAccess,
  INativeEventBus,
  INativeLoggerFactory,
  INativeNotificationAccess,
  NativeErrorCodes
} from "@js-soft/native-abstractions";
import { Result } from "@js-soft/ts-utils";
import { RuntimeNativeBootstrapper, RuntimeNativeEnvironment } from "@nmshd/app-runtime";
import { ConfigAccess } from "./ConfigAccess";
import { DatabaseFactory } from "./DatabaseFactory";
import { DeviceInfoAccess } from "./DeviceInfoAccess";
import { EventBus } from "./EventBus";
import { FileAccess } from "./FileAccess";
import { LoggerFactory } from "./LoggerFactory";
import { NotificationAccess } from "./NotificationAccess";

export class NativeBootstrapper implements RuntimeNativeBootstrapper {
  public readonly databaseFactory: ILokiJsDatabaseFactory;
  public readonly configAccess: ConfigAccess;
  public readonly loggerFactory: INativeLoggerFactory;
  public readonly notificationAccess: INativeNotificationAccess;
  public readonly eventBus: INativeEventBus;
  public readonly deviceInfoAccess: INativeDeviceInfoAccess;

  private readonly fileAccess: FileAccess;

  private initialized = false;
  public get isInitialized(): boolean {
    return this.initialized;
  }

  public get nativeEnvironment(): RuntimeNativeEnvironment {
    if (!this.initialized) {
      throw new Error(NativeErrorCodes.BOOTSTRAP_NOT_INITIALIZED);
    }

    return this as RuntimeNativeEnvironment;
  }

  public constructor() {
    this.eventBus = new EventBus();
    this.fileAccess = new FileAccess();
    this.loggerFactory = new LoggerFactory();
    this.configAccess = new ConfigAccess(this.fileAccess, this.loggerFactory.getLogger(ConfigAccess), "config.json");
    this.databaseFactory = new DatabaseFactory(this.fileAccess, this.loggerFactory.getLogger(DatabaseFactory));
    this.deviceInfoAccess = new DeviceInfoAccess();
    this.notificationAccess = new NotificationAccess(this.loggerFactory, this.configAccess);
  }

  public async init(): Promise<Result<void>> {
    if (this.initialized) {
      throw new Error(NativeErrorCodes.BOOTSTRAP_ALREADY_INITIALIZED);
    }

    await this.eventBus.init();

    await this.configAccess.initDefaultConfig();
    await this.configAccess.initRuntimeConfig();
    await this.configAccess.save();

    await this.deviceInfoAccess.init();
    await this.notificationAccess.init();

    this.initialized = true;

    return Result.ok(undefined);
  }
}
