import Foundation

let semaphore = DispatchSemaphore(value: 0)

CRDownload.main()

semaphore.wait()
