import ArgumentParser

struct CRDownload: ParsableCommand {
    @Argument(help: "The URLs to download.")
    var urls: [String]

    mutating func run() throws {
        for url in urls {
            print("Downloading... \(url)")
        }
    }
}
