/// Provides caseName and associatedValues custom mirros for enumerations.
public protocol EnumReflectable: CaseNameReflectable, AssociatedValuesReflectable {
	var logCategory: os.Logger { get }
}

public extension EnumReflectable {
    @inlinable @inline(__always)
	var logCategory: os.Logger {
		.init(subsystem: os.Logger.host, category: "\(type(of: self))")
	}
}

// reflicting enum cases
public protocol CaseNameReflectable {
    var caseName: String { get }
}

public extension CaseNameReflectable {
    var caseName: String {
        let mirror = Mirror(reflecting: self)
        guard let caseName = mirror.children.first?.label else {
            return "\(mirror.subjectType).\(self)"
        }
        return "\(mirror.subjectType).\(caseName)"
    }
}

// reflicting enum associated values
public protocol AssociatedValuesReflectable {
    var associatedValues: [String: String] { get }
}
public extension AssociatedValuesReflectable {
    var associatedValues: [String] {
        var values = [String]()
        guard let associated = Mirror(reflecting: self).children.first else {
            return values
        }
        
        let valueMirror = Mirror(reflecting: associated.value)
        switch valueMirror.displayStyle {
        case .tuple:
            // Handle tuples (multiple parameters) with labels (e.g., ".0" → "0")
            for child in valueMirror.children {
                let label = child.label?.replacingOccurrences(
                    of: "^\\.",
                    with: "",
                    options: .regularExpression
                )
                let value = String(describing: child.value)
                values.append(label != nil ? "\(label!): \(value)" : value)
            }
        default:
            // For single values, append the value WITHOUT any label
            let value = String(describing: associated.value)
            values.append(value)
        }
        return values
    }
}
