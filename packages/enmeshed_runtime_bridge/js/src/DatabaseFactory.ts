import { ILokiJsDatabaseFactory } from "@js-soft/docdb-access-loki";
import loki from "lokijs";
import { FileAccess } from "./FileAccess";

export class DatabaseFactory implements ILokiJsDatabaseFactory {
  public constructor(private fileAccess: FileAccess) {}

  public create(
    name: string,
    options?: Partial<LokiConstructorOptions> & Partial<LokiConfigOptions> & Partial<ThrottledSaveDrainOptions>
  ): Loki {
    return new loki(name, {
      adapter: new DBPersitenceAdapter(this.fileAccess),
      autosave: true,
      autoload: true,
      autosaveInterval: 1000,
      ...options
    });
  }
}

export class DBPersitenceAdapter implements LokiPersistenceAdapter {
  public constructor(private readonly fileAccess: FileAccess) {}

  public loadDatabase(dbname: string, callback: (value: any) => void): void {
    this.loadDatabaseAsync(dbname).then((res) => callback(res));
  }

  private async loadDatabaseAsync(dbname: string): Promise<any> {
    const res = await this.fileAccess.readFileAsText(dbname);
    if (!res.isSuccess) return new Error(res.error.message);

    return res.value;
  }

  public deleteDatabase(dbname: string, callback: (err?: Error | null, data?: any) => void): void {
    this.fileAccess.deleteFile(dbname).then((res) => {
      if (res.isSuccess) {
        callback();
      } else {
        callback(new Error(res.error.message));
      }
    });
  }

  public saveDatabase(dbname: string, dbstring: any, callback: (err?: Error | null) => void): void {
    this.fileAccess.writeFile(dbname, dbstring).then((res) => {
      if (res.isSuccess) {
        callback();
      } else {
        callback(new Error(res.error.message));
      }
    });
  }
}
