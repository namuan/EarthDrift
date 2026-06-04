import Foundation
import OSLog

enum LogLevel: String, Comparable {
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"

    private var rank: Int {
        switch self {
        case .debug: return 0
        case .info: return 1
        case .warning: return 2
        case .error: return 3
        }
    }

    static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        lhs.rank < rhs.rank
    }
}

final class RollingFileLogger: @unchecked Sendable {
    static let shared = RollingFileLogger()

    private let logDirectory: URL
    private let maxFileSize: Int64 = 5 * 1024 * 1024
    private let maxLogFiles = 10
    private let queue = DispatchQueue(label: "com.earthdrift.logger", qos: .utility)
    private let dateFormatter: DateFormatter
    private let osLog = OSLog(subsystem: "com.earthdrift", category: "general")

    private var currentFileURL: URL?
    private var fileHandle: FileHandle?

    private init() {
        let libraryLogs = FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("Library/Logs/EarthDrift")

        self.logDirectory = libraryLogs

        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current

        createLogDirectory()
        openNewLogFile()
    }

    deinit {
        try? fileHandle?.close()
    }

    var logDirectoryPath: String {
        logDirectory.path
    }

    // MARK: - Public API

    func debug(_ message: String, source: String = #fileID) {
        log(level: .debug, message: message, source: source)
    }

    func info(_ message: String, source: String = #fileID) {
        log(level: .info, message: message, source: source)
    }

    func warning(_ message: String, source: String = #fileID) {
        log(level: .warning, message: message, source: source)
    }

    func error(_ message: String, source: String = #fileID) {
        log(level: .error, message: message, source: source)
    }

    // MARK: - Log Entry Formatting

    private func log(level: LogLevel, message: String, source: String) {
        let timestamp = dateFormatter.string(from: Date())
        let shortSource = source.replacingOccurrences(of: "EarthDrift/", with: "")
        let logLine = "[\(timestamp)] [\(level.rawValue)] [\(shortSource)] \(message)\n"

        os_log(level: level, message: message, source: source)

        queue.async { [weak self] in
            self?.writeToFile(logLine)
        }
    }

    // MARK: - File Management

    private func createLogDirectory() {
        do {
            try FileManager.default.createDirectory(at: logDirectory, withIntermediateDirectories: true)
        } catch {
            print("EarthDrift Logger: Failed to create log directory at \(logDirectory.path): \(error)")
        }
    }

    private func openNewLogFile() {
        let fileName = "EarthDrift-\(dateFileFormatter.string(from: Date())).log"
        let fileURL = logDirectory.appendingPathComponent(fileName)

        try? fileHandle?.close()

        if !FileManager.default.fileExists(atPath: fileURL.path) {
            FileManager.default.createFile(atPath: fileURL.path, contents: nil)
        }

        do {
            let handle = try FileHandle(forWritingTo: fileURL)
            handle.seekToEndOfFile()
            fileHandle = handle
            currentFileURL = fileURL
        } catch {
            print("EarthDrift Logger: Failed to open log file at \(fileURL.path): \(error)")
        }
    }

    private func writeToFile(_ line: String) {
        guard fileHandle != nil, currentFileURL != nil else { return }

        if shouldRotate() {
            try? fileHandle?.close()
            rotateLogFiles()
            openNewLogFile()
        }

        guard let newHandle = fileHandle else { return }

        do {
            if let data = line.data(using: .utf8) {
                try newHandle.write(contentsOf: data)
            }
        } catch {
            print("EarthDrift Logger: Failed to write to log file: \(error)")
        }
    }

    private func shouldRotate() -> Bool {
        guard let currentFileURL else { return false }
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: currentFileURL.path)
            let size = attributes[.size] as? Int64 ?? 0
            return size >= maxFileSize
        } catch {
            return false
        }
    }

    private func rotateLogFiles() {
        guard let files = try? FileManager.default.contentsOfDirectory(
            at: logDirectory,
            includingPropertiesForKeys: [.contentModificationDateKey],
            options: .skipsHiddenFiles
        ) else { return }

        let logFiles = files
            .filter { $0.pathExtension == "log" }
            .sorted { a, b in
                let dateA = (try? a.resourceValues(forKeys: [.contentModificationDateKey]).contentModificationDate) ?? Date.distantPast
                let dateB = (try? b.resourceValues(forKeys: [.contentModificationDateKey]).contentModificationDate) ?? Date.distantPast
                return dateA < dateB
            }

        if logFiles.count >= maxLogFiles {
            for file in logFiles.prefix(logFiles.count - maxLogFiles + 1) {
                try? FileManager.default.removeItem(at: file)
            }
        }
    }

    private var dateFileFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd-HH"
        df.locale = Locale(identifier: "en_US_POSIX")
        return df
    }()
}

// MARK: - OSLog bridge

private func os_log(level: LogLevel, message: String, source: String) {
    let log = OSLog(subsystem: "com.earthdrift", category: "general")
    let type: OSLogType
    switch level {
    case .debug: type = .debug
    case .info: type = .info
    case .warning: type = .default
    case .error: type = .error
    }
    os_log(type, log: log, "%{public}@: %{public}@", source, message)
}

// MARK: - Convenience global functions

func logDebug(_ message: String, source: String = #fileID) {
    RollingFileLogger.shared.debug(message, source: source)
}

func logInfo(_ message: String, source: String = #fileID) {
    RollingFileLogger.shared.info(message, source: source)
}

func logWarning(_ message: String, source: String = #fileID) {
    RollingFileLogger.shared.warning(message, source: source)
}

func logError(_ message: String, source: String = #fileID) {
    RollingFileLogger.shared.error(message, source: source)
}
