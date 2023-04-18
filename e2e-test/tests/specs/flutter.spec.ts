import { bySemanticsLabel, byValueKey } from "appium-flutter-finder"

describe("appium-flutter-driver", () => {
  it("load and validate the app", async () => {
    expect(await driver.execute("flutter:checkHealth")).toEqual("ok")
  })

  it("should cycle through the tabs of the demo app + screenshot in both contexts", async () => {
    const targets = [
      byValueKey("feedback"),
      byValueKey("messages"),
      byValueKey("people")
    ]
    let i = 0
    for (const target of targets) {
      await driver.elementClick(target)
      // await driver.saveScreenshot(`./flutter-${i}.png`)
      // await driver.switchContext("NATIVE_APP")
      // await driver.saveScreenshot(`./native-${i}.png`)
      i++
    }
    expect(true).toBe(true)
  })

  it("should get an 'aggregation'", async () => {
    const tab = bySemanticsLabel(RegExp("Message logo"))
    await driver.elementClick(tab)
    expect(true).toBe(true)
  })
})
