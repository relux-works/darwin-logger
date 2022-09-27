/// Provides caseName and associatedValues custom mirros for enumerations.
public protocol EnumReflectable: CaseNameReflectable, AssociatedValuesReflectable {
	var logCategory: os.Logger { get }
}

public extension EnumReflectable {
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
    var associatedValues: [String: String] {
        var values = [String: String]()
        guard let associated = Mirror(reflecting: self).children.first else {
            return values
        }

        let children = Mirror(reflecting: associated.value).children
        for case let item in children {
            if let label = item.label {
                values[label] = String(describing: item.value)
            }
        }
        return values
    }
}
