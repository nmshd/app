import { NativeEvent } from "@nmshd/app-runtime";

export class AppReadyEvent extends NativeEvent {
  public static namespace = "AppReadyEvent";
  public constructor() {
    super(AppReadyEvent.namespace);
  }
}
