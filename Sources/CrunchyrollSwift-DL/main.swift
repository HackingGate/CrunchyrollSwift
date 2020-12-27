import Foundation

let semaphore = DispatchSemaphore(value: 0)

CRDownload.main(["https://www.crunchyroll.com/konosuba-gods-blessing-on-this-wonderful-world/konosuba-gods-blessing-on-this-wonderful-world-legend-of-crimson-konosuba-gods-blessing-on-this-wonderful-world-legend-of-crimson-794436"])

semaphore.wait()
