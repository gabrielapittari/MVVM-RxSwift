//
//  PaginatedResults.swift
//  PremierSwift
//
//  Created by Gabriela Pittari on 17/10/2017.
//
import Foundation
import ObjectMapper

class PaginatedResults<T: Mappable>: Mappable {
    var page: Int = 0
    var totalResults: Int = 0
    var totalPages: Int = 0
    var results: Array<T> = []
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        page <- map["page"]
        totalResults <- map["total_results"]
        totalPages <- map["total_pages"]
        results <- map["results"]
    }
}
