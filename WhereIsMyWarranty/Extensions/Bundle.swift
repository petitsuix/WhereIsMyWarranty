//
//  Bundle.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 10/02/2022.
//

import Foundation

public extension Bundle {

    var executable: String? {
        return infoDictionary?[kCFBundleExecutableKey as String] as? String
    }

    var bundle: String? {
        return infoDictionary?[kCFBundleIdentifierKey as String] as? String
    }

    var bundleName: String {
        return infoDictionary?["CFBundleName"] as? String ?? "App"
    }

    var versionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }

    var prettyVersionString: String {
        guard let versionNumber = versionNumber,
            let build = buildNumber else {
                return "-"
        }
        return "Version \(versionNumber) (\(build))"
    }
}
