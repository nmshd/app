import { ILokiJsDatabaseFactory } from "@js-soft/docdb-access-loki";
import { ILoggerFactory } from "@js-soft/logging-abstractions";
import { SimpleLoggerFactory } from "@js-soft/simple-logger";
import { Result } from "@js-soft/ts-utils";
import { INativeBootstrapper, INativeEnvironment, INativeNotificationAccess } from "@nmshd/app-runtime";
import { LogLevel } from "typescript-logging";
import { DatabaseFactory } from "./DatabaseFactory";
import { FileAccess } from "./FileAccess";
import { NotificationAccess } from "./NotificationAccess";

export class NativeBootstrapper implements INativeBootstrapper {
  public readonly databaseFactory: ILokiJsDatabaseFactory;
  public readonly loggerFactory: ILoggerFactory;
  public readonly notificationAccess: INativeNotificationAccess;

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
    this.databaseFactory = new DatabaseFactory(this.fileAccess, this.loggerFactory.getLogger(DatabaseFactory));
    this.notificationAccess = new NotificationAccess(this.loggerFactory);
  }

  public async init(): Promise<Result<void>> {
    if (this.initialized) {
      throw new Error("BOOTSTRAP_ALREADY_INITIALIZED");
    }

    await this.notificationAccess.init();

    this.initialized = true;

    return Result.ok(undefined);
  }
}
