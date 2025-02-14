@inlinable
@inline(__always)
/// Logs a message to console with specified log type, category and privacy level.
public func log(
    _ message: String,
    logType: OSLogType = .default,
    category: os.Logger = .default,
    privacy: _OSLogPrivacy = .private,
    includeCallerLocation: Bool = true,
    fileID: String = #fileID,
    functionName: String = #function,
    lineNumber: Int = #line
) {
    var message = message
    if includeCallerLocation {
        let moduleAndFileName = fileID.hasSuffix(".swift") ? String(fileID.dropLast(6)) : fileID
        let moduleName = String(fileID.prefix(while: { $0 != "/" }))
        let fileName = moduleAndFileName
            .split(separator: "/")
            .suffix(1)
            .description
            .trimmingBrackets()
        let logLocationDescription = "\(lineNumber):\(moduleName).\(fileName).\(functionName)"
        message = "\(message) \n> location: \(logLocationDescription)"
    }
    
    switch privacy {
    case .private:
        category.log(level: logType, "\(message, align: .left(columns: 30), privacy: .private)")
    case .public:
        category.log(level: logType, "\(message, align: .left(columns: 30), privacy: .public)")
    case .auto:
        category.log(level: logType, "\(message, align: .left(columns: 30), privacy: .auto)")
    case .sensitive:
        category.log(level: logType, "\(message, align: .left(columns: 30), privacy: .sensitive)")
    }
}


@inlinable
@inline(__always)
/// Logs an error to console using predefined error-logger category.
public func log<E: Error>(
    _ error: E,
    privacy: _OSLogPrivacy = .private,
    fileID: String = #fileID,
    functionName: String = #function,
    lineNumber: Int = #line
) where E: CustomStringConvertible {
    
    // its important to pass magic ids to log, otherwise location is not forwarded
    log(
        error.description,
        logType: .error,
        category: .error,
        privacy: privacy,
        includeCallerLocation: true,
        fileID: fileID,
        functionName: functionName,
        lineNumber: lineNumber
    )
}


@inlinable
@inline(__always)
/// Logs an error to console using predefined error-logger category.
public func log(
        _ error: Error,
        privacy: _OSLogPrivacy = .private,
        fileID: String = #fileID,
        functionName: String = #function,
        lineNumber: Int = #line
) {

    // its important to pass magic ids to log, otherwise location is not forwarded
    log(
            "\(error.localizedDescription): \(error)",
            logType: .error,
            category: .error,
            privacy: privacy,
            includeCallerLocation: true,
            fileID: fileID,
            functionName: functionName,
            lineNumber: lineNumber
    )
}

@inlinable
@inline(__always)
public func debugEarlyExit(
    _ message: String,
    fileID: String = #fileID,
    functionName: String = #function,
    lineNumber: Int = #line
) {
    #if DEBUG
    let guardMessage = "early exit from \(functionName)\n> \(message)"

    // its important to pass magic ids to log, otherwise location is not forwarded
    log(
        guardMessage,
        logType: .debug,
        category: .debug,
        includeCallerLocation: true,
        fileID: fileID,
        functionName: functionName,
        lineNumber: lineNumber
    )
    #endif
}

@inlinable
@inline(__always)
/// Logs a debug message to console; Works only in DEBUG build configuration.
public func debug(
    _ message: String,
    fileID: String = #fileID,
    functionName: String = #function,
    lineNumber: Int = #line
) {
    #if DEBUG
    log(
        message,
        logType: .debug,
        category: .debug,
        includeCallerLocation: true,
        fileID: fileID,
        functionName: functionName,
        lineNumber: lineNumber
    )
    #endif
}

extension String {
    @usableFromInline
    func trimmingBrackets() -> String {
        let bracketsAndQuotes: Set<Character> = ["[", "]", "\""]
        var result = self
        while !result.isEmpty && bracketsAndQuotes.contains(result.first!) {
            result.removeFirst()
        }
        while !result.isEmpty && bracketsAndQuotes.contains(result.last!) {
            result.removeLast()
        }
        return result
    }
}
