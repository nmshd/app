import { NativeEvent } from "@js-soft/native-abstractions";

export class AppReadyEvent extends NativeEvent {
  public static namespace = "AppReadyEvent";
  public constructor() {
    super(AppReadyEvent.namespace);
  }
}
