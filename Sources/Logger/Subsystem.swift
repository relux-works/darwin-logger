import Foundation

public extension os.Logger {
    /// A subsystem of the host app.
	static var host: String { Bundle.main.bundleIdentifier! }
}
