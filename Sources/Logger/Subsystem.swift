import Foundation

public extension os.Logger {
    /// A subsytem of the host app.
    static var host = Bundle.main.bundleIdentifier!
}
