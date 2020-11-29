//
//  MovieDB.swift
//  test8200ac
//
//  Created by אילי זוברמן on 29/11/2020.
//

import SwiftUI
import Alamofire

final class MovieDB: ObservableObject{
    
    static let shared = MovieDB()
    
    private init(){}
    
    var popularMoviesPage = 1
    var topratedMoviesPage = 1
    
    final func getMovies(api: String, completion: (([Movie]) -> Void)? = nil){
        
        AF.request(api).responseJSON { (data) in
            
            guard let json = data.data else {return}
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(MovieList.self, from: json)
                
                completion?(result.results)
                
            } catch let err {
                print("Error:", err)
            }
        }
        
    }
}
