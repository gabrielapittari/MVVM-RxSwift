//
//  Movie.swift
//  PremierSwift
//
//  Created by Gabriela Pittari on 12/10/2017.
//
import ObjectMapper

class Movie: Mappable {
    var voteCount: Int = 0
    var id: Int = 0
    var video: Bool = false
    var voteAverage: Int = 0
    var title: String = LocalizableStrings.empty.localized
    var popularity: Float = 0.0
    var posterPath: String = LocalizableStrings.empty.localized
    var originalLanguage: String = LocalizableStrings.empty.localized
    var originalTitle: String = LocalizableStrings.empty.localized
    var genreIds: NSArray!
    var backdropPath: String = LocalizableStrings.empty.localized
    var adult: Bool = false
    var overview: String = LocalizableStrings.empty.localized
    var releaseDate: Date!
    var posterImage: UIImage = UIImage(named: "default_movie")! 
    
    required convenience init?(map: Map) {
        self.init()
    }
    // mapping all attributes of the movie object, i'm not gonna use all of them in this small project though
    func mapping(map: Map) {
        voteCount <- map["vote_count"]
        id <- map["id"]
        video <- map["video"]
        voteAverage <- map["vote_average"]
        title <- map["title"]
        popularity <- map["popularity"]
        posterPath <- map["poster_path"]
        originalLanguage <- map["original_language"]
        originalTitle <- map["original_title"]
        genreIds <- map["genre_ids"]
        backdropPath <- map["backdrop_path"]
        adult <- map["adult"]
        overview <- map["overview"]
        releaseDate <- map["release_date"]
    }
}
