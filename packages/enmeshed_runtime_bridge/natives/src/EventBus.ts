import { AppReadyEvent, INativeEventBus } from "@js-soft/native-abstractions";
import { Event, EventEmitter2EventBus, Result, EventBus as UtilsEventBus } from "@js-soft/ts-utils";

export class EventBus implements INativeEventBus {
  private eventBus!: UtilsEventBus;
  private locked = true;
  private queue: Event[] = [];

  public init(errorCallback?: (error: unknown, namespace: string) => void): Promise<Result<void>> {
    this.eventBus = new EventEmitter2EventBus(
      errorCallback ??
        ((error: unknown, namespace: string) => {
          // eslint-disable-next-line no-console
          console.error(`Error in EventBus for namespace '${namespace}':`, error);
        })
    );

    // this.eventBus.subscribe("**", async (event) => {
    //   await window.flutter_inappwebview.callHandler("publishEvent", event);
    // });

    return Promise.resolve(Result.ok(undefined));
  }

  public subscribe(event: Event, handler: (event: any) => void): Result<number> {
    const id = this.eventBus.subscribe(event.namespace, handler);
    return Result.ok(id);
  }

  public subscribeOnce(event: Event, handler: (event: any) => void): Result<number> {
    const id = this.eventBus.subscribeOnce(event.namespace, handler);
    return Result.ok(id);
  }

  public unsubscribe(id: number): Result<void> {
    this.eventBus.unsubscribe(id);
    return Result.ok(undefined);
  }

  public publish(event: Event): Result<void> {
    if (this.locked) {
      // check for namespace to avoid problems with version differences
      if (event.namespace === AppReadyEvent.namespace) {
        this.locked = false;
        // eslint-disable-next-line no-console
        console.log("Unlocked EventBus."); // No js-soft logger available at this stage
        this.queue.forEach((event: Event) => this.publish(event));
        this.queue = [];
        // eslint-disable-next-line no-console
        console.log("All queued events have been published."); // No js-soft logger available at this stage
      } else {
        this.queue.push(event);
        // eslint-disable-next-line no-console
        console.warn("EventBus is locked. Queued the following event:", event); // No js-soft logger available at this stage
      }
      return Result.ok(undefined);
    }

    this.eventBus.publish(event);
    return Result.ok(undefined);
  }
}
