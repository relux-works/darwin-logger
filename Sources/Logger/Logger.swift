@inlinable
@inline(__always)
/// Logs a message to console with specified log type, category and privacy level.
public func log(_ message: String, logType: OSLogType = .default, category: os.Logger = .default, privacy: _OSLogPrivacy = .private) {
    // privacy argument must be resolved on compile time, hence ugly workaround
    // more info:
    // https://stackoverflow.com/questions/62675874/xcode-12-and-oslog-os-log-wrapping-oslogmessage-causes-compile-error-argumen#63036815
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
public func log<E: Error>(_ error: E, privacy: _OSLogPrivacy = .private) where E: CustomStringConvertible {
    log(error.description, logType: .error, category: .error, privacy: privacy)
}


@inlinable
@inline(__always)
/// Logs an enum case with its assosiated value to console with private privacy level by default.
public func log<Case>(_ case: Case, category: os.Logger = .default, privacy: _OSLogPrivacy = .private) where Case: EnumReflectable  {
    let sender = "\(`case`.caseName) \(`case`.associatedValues)"
    log(sender, logType: .info, category: category, privacy: privacy)
}


@inlinable
@inline(__always)
/// Logs a debug message to console; Works only in DEBUG build configuration.
public func debug(_ message: String) {
    #if DEBUG
    log(message, logType: .debug, category: .debug)
    #endif
}




