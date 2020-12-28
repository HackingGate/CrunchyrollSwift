import Foundation

let semaphore = DispatchSemaphore(value: 0)

CRDownload.main(["https://www.crunchyroll.com/rezero-starting-life-in-another-world-"])

semaphore.wait()
