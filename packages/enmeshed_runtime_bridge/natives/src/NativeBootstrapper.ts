import { ILokiJsDatabaseFactory } from "@js-soft/docdb-access-loki";
import { ILoggerFactory } from "@js-soft/logging-abstractions";
import { SimpleLoggerFactory } from "@js-soft/simple-logger";
import { EventBus, Result } from "@js-soft/ts-utils";
import { INativeBootstrapper, INativeEnvironment, INativeNotificationAccess } from "@nmshd/app-runtime";
import { LogLevel } from "typescript-logging";
import { ConfigAccess } from "./ConfigAccess";
import { DatabaseFactory } from "./DatabaseFactory";
import { FileAccess } from "./FileAccess";
import { NotificationAccess } from "./NotificationAccess";

export class NativeBootstrapper implements INativeBootstrapper {
  public readonly databaseFactory: ILokiJsDatabaseFactory;
  public readonly configAccess: ConfigAccess;
  public readonly loggerFactory: ILoggerFactory;
  public readonly notificationAccess: INativeNotificationAccess;
  public readonly eventBus: EventBus;

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
    this.loggerFactory = new SimpleLoggerFactory(LogLevel.Info);
    this.configAccess = new ConfigAccess(this.fileAccess, this.loggerFactory.getLogger(ConfigAccess), "config.json");
    this.databaseFactory = new DatabaseFactory(this.fileAccess, this.loggerFactory.getLogger(DatabaseFactory));
    this.notificationAccess = new NotificationAccess(this.loggerFactory, this.configAccess);
  }

  public async init(): Promise<Result<void>> {
    if (this.initialized) {
      throw new Error("BOOTSTRAP_ALREADY_INITIALIZED");
    }

    await this.configAccess.init();
    await this.notificationAccess.init();

    this.initialized = true;

    return Result.ok(undefined);
  }
}
