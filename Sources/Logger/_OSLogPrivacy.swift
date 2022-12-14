/// A proxy type to work around apple os log [limitations](https://stackoverflow.com/questions/62675874/xcode-12-and-oslog-os-log-wrapping-oslogmessage-causes-compile-error-argumen#63036815).
///
///
public enum _OSLogPrivacy: Equatable {
    case  auto, `public`, `private`, sensitive
}
