//
//  MovieDB.swift
//  test8200ac
//
//  Created by אילי זוברמן on 29/11/2020.
//

import SwiftUI
import Alamofire

final class MovieDB{
    
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
    
    func searchMovie(searchText: String, completion: (([Movie]) -> Void)? = nil){
        let api = "https://api.themoviedb.org/3/search/movie?api_key=390640f9df4b7a5213316eb01d83afd7&language=en-US&query=\(searchText)"
        
        AF.request(api).responseJSON { (response) in
            
            guard let data = response.data else {return}
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(MovieList.self, from: data)
                
                completion?(result.results)
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
}
