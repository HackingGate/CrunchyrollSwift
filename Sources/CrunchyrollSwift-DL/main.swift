import Foundation

let semaphore = DispatchSemaphore(value: 0)

CRDownload.main(["hello"])

semaphore.wait()
