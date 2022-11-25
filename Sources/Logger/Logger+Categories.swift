public extension os.Logger {
    /// A logger instance that logs to '❗️Error' category within host app subsystem.
    static let error = os.Logger(subsystem: host, category: "❗️Error")
    
    /// A logger instance that logs to '⚠️Warning' category within host app subsystem.
    static let warning = os.Logger(subsystem: host, category: "⚠️Warning")
    
    /// A logger instance that logs to '♦️Debug' category within host app subsystem.
    static let debug = os.Logger(subsystem: host, category: "♦️Debug")
    
    /// A logger instance that logs to '🔤Default' category within host app subsystem.
    static let `default` = os.Logger(subsystem: host, category: "🔤Default")

    static let performance = os.Logger(subsystem: host, category: "🎭 Performance")
}
