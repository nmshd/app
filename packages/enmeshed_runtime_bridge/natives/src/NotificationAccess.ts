import { ILogger } from "@js-soft/logging-abstractions";
import {
  INativeConfigAccess,
  INativeNotificationAccess,
  INativeNotificationScheduleOptions
} from "@js-soft/native-abstractions";
import { Result } from "@js-soft/ts-utils";

export class NotificationAccess implements INativeNotificationAccess {
  // Store scheduled notifications in memory => resets after restart
  private readonly notifications: number[] = [];

  public constructor(private readonly logger: ILogger, private readonly config: INativeConfigAccess) {}

  public init(): Promise<Result<void>> {
    return Promise.resolve(Result.ok(undefined));
  }

  public schedule(title: string, body: string, options?: INativeNotificationScheduleOptions): Promise<Result<number>> {
    if (options?.textInput) this.logger.warn("Notification text input actions not supported on this platform");

    const id = options?.id ? options.id : Math.round(Math.random() * 1000);

    // PushNotification.localNotification({
    //   channelId: 'your-channel-id', // (required) channelId, if the channel doesn't exist, notification will not trigger.
    //   actions: [], // (Android only) See the doc for notification actions to know more
    //   id,
    //   title,
    //   message: body,
    // });

    this.notifications.push(id);

    return Promise.resolve(Result.ok(id));
  }

  public async update(
    id: number,
    title: string,
    body: string,
    options?: INativeNotificationScheduleOptions
  ): Promise<Result<void>> {
    await this.schedule(title, body, { ...options, id });
    return Result.ok(undefined);
  }

  public clear(id: number): Promise<Result<void>> {
    // PushNotification.cancelLocalNotification(id.toString());
    return Promise.resolve(Result.ok(undefined));
  }

  public clearAll(): Promise<Result<void>> {
    this.notifications.forEach((id) => this.clear(id));
    return Promise.resolve(Result.ok(undefined));
  }

  public getAll(): Promise<Result<number[]>> {
    return Promise.resolve(Result.ok(this.notifications));
  }
}
