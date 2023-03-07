import { ILogger } from "@js-soft/logging-abstractions";
import { INativeLoggerFactory } from "@js-soft/native-abstractions";
import { Result } from "@js-soft/ts-utils";
import Logger from "js-logger";

export class LoggerFactory implements INativeLoggerFactory {
  public constructor() {
    Logger.useDefaults({ defaultLevel: Logger.INFO });

    const consoleHandler = Logger.createDefaultHandler({
      formatter: function (messages, context) {
        messages.unshift(
          `${new Date().toISOString()} [${
            context.name === undefined ? "default" : context.name
          }]`
        );
      },
    });

    Logger.setHandler(consoleHandler);
  }

  public init(): Promise<Result<void>> {
    return Promise.resolve(Result.ok(undefined));
  }

  public getLogger(oName: string | Function): ILogger {
    let sName = oName instanceof Function ? oName.name : oName;
    if (oName instanceof Function) {
      sName = oName.name;
    } else if (typeof oName === "string") {
      sName = oName;
    } else {
      sName = "default";
    }
    return Logger.get(sName) as unknown as ILogger;
  }
}
