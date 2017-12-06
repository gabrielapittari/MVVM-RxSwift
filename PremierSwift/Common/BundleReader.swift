//
//  BundleReader.swift
//  PremierSwift
//
//  Created by Gabriela Pittari on 13/10/2017.
//

import Foundation

// This class is going to help me retrieving the strings from the plist file. For a bigger project, I will put all this strings in a separate plist instead of the Info plist. Constants like the base URL and API keys are important to keep them in a plist, for example, it would be helpful when having multiple environments
class BundleReader: NSObject {

    private let baseUrl = "BaseURL"
    private let posterBaseUrl = "PosterBaseURL"
    private let APIKey = "APIKey"
    private let movieSample = "MovieSample"
    
    func getStringForKey( key: String) -> String {
        let path = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let plist = NSDictionary(contentsOfFile:path)
        let value = plist?.object(forKey: key) as! String
        return value
    }
    
    func valueForAPIKey() -> String {
        return getStringForKey(key: APIKey)
    }
    
    func valueForBaseURL() -> String {
        return getStringForKey(key: baseUrl)
    }
    
    func valueForPosterBaseURL() -> String {
        return getStringForKey(key: posterBaseUrl)
    }
    
    // This one goes coleado
    func valueForMovieSample() -> String {
        return getStringForKey(key: movieSample)
    }
}
