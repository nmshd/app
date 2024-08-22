import { ILokiJsDatabaseFactory } from "@js-soft/docdb-access-loki";
import { ILoggerFactory } from "@js-soft/logging-abstractions";
import { EventBus, EventEmitter2EventBus, Result } from "@js-soft/ts-utils";
import { WebLoggerFactory } from "@js-soft/web-logger";
import {
  INativeBootstrapper,
  INativeDeviceInfoAccess,
  INativeEnvironment,
  INativeNotificationAccess
} from "@nmshd/app-runtime";
import { ConfigAccess } from "./ConfigAccess";
import { DatabaseFactory } from "./DatabaseFactory";
import { DeviceInfoAccess } from "./DeviceInfoAccess";
import { FileAccess } from "./FileAccess";
import { NotificationAccess } from "./NotificationAccess";

export class NativeBootstrapper implements INativeBootstrapper {
  public readonly databaseFactory: ILokiJsDatabaseFactory;
  public readonly configAccess: ConfigAccess;
  public readonly loggerFactory: ILoggerFactory;
  public readonly notificationAccess: INativeNotificationAccess;
  public readonly eventBus: EventBus;
  public readonly deviceInfoAccess: INativeDeviceInfoAccess;

  private readonly fileAccess: FileAccess;

  private initialized = false;
  public get isInitialized(): boolean {
    return this.initialized;
  }

  public get nativeEnvironment(): INativeEnvironment {
    if (!this.initialized) {
      throw new Error("BOOTSTRAP_NOT_INITIALIZED");
    }

    return this as INativeEnvironment;
  }

  public constructor() {
    this.fileAccess = new FileAccess();
    this.loggerFactory = new WebLoggerFactory();
    this.configAccess = new ConfigAccess(this.fileAccess, this.loggerFactory.getLogger(ConfigAccess), "config.json");
    this.databaseFactory = new DatabaseFactory(this.fileAccess, this.loggerFactory.getLogger(DatabaseFactory));
    this.notificationAccess = new NotificationAccess(this.loggerFactory, this.configAccess);

    const eventBusLogger = this.loggerFactory.getLogger("EventBus");
    this.eventBus = new EventEmitter2EventBus((error, namespace) => {
      eventBusLogger.error(
        `An error was thrown in an event handler of the transport event bus (namespace: '${namespace}'). Root error: ${error}`
      );
    });
    this.deviceInfoAccess = new DeviceInfoAccess();
  }

  public async init(): Promise<Result<void>> {
    if (this.initialized) {
      throw new Error("BOOTSTRAP_ALREADY_INITIALIZED");
    }

    await this.configAccess.initDefaultConfig();
    await this.configAccess.initRuntimeConfig();
    await this.configAccess.save();

    await this.deviceInfoAccess.init();
    await this.notificationAccess.init();

    this.initialized = true;

    return Result.ok(undefined);
  }
}
