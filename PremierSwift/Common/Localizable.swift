//
//  Localizable.swift
//  PremierSwift
//
//  Created by Gabriela Pittari on 12/10/2017.
//

import Foundation
protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}

let defaultLocalizableTable = "Localizable"

extension String {
    func localized(bundle: Bundle = .main, tableName: String = defaultLocalizableTable) -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return rawValue.localized(tableName: tableName)
    }
}

enum LocalizableStrings: String, Localizable {
    case topMovies = "topMovies"
    case empty = "empty"
    case error = "error"
    case badRequest = "badRequest"
    case tryAgainLater = "tryAgainLater"
    case requestError = "requestError"
    case noResults = "noResults"
    case ok = "ok"
    
    // in a bigger version of the app, I could have many localizable string files separated by screen in this way its easier to find them and retrieve them faster when coding. Each one of this files will be a table.
    var tableName: String {
        return defaultLocalizableTable
    }
}
