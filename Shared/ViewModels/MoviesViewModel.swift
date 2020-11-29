//
//  MoviesViewModel.swift
//  test8200ac
//
//  Created by אילי זוברמן on 29/11/2020.
//

import Foundation
import Alamofire

class MoviesViewModel: ObservableObject{
    
    @Published var popularMovies: [Movie] = []
    @Published var topratedMovies: [Movie] = []
    
    var page = 1
    
    private let popularMoviesApi = "https://api.themoviedb.org/3/movie/popular?api_key=390640f9df4b7a5213316eb01d83afd7&language=en-US"
    private let trMoviesApi = "https://api.themoviedb.org/3/movie/top_rated?api_key=390640f9df4b7a5213316eb01d83afd7&language=en-US"
    
    init(){
        getMovies(api: "\(popularMoviesApi)&page=\(page)"){ result in
            DispatchQueue.main.async {
                self.popularMovies = result
            }
        }
        
        getMovies(api: "\(trMoviesApi)&page=\(page)") { (result) in
            DispatchQueue.main.async {
                self.topratedMovies = result
            }
        }
    }
    
    func loadMoreMovies(segment: Int){
        page += 1
        if segment == 0 {
            getMovies(api: "\(popularMoviesApi)&page=\(page)") { (result) in
                self.popularMovies += result
            }
        }else{
            getMovies(api: "\(trMoviesApi)&page=\(page)") { (result) in
                self.topratedMovies += result
            }
        }
    }
    
    func getMovies(api: String, completion: (([Movie]) -> Void)? = nil){
        
        AF.request(api).responseJSON { (data) in
            
            guard let json = data.data else {return}
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(MovieList.self, from: json)
                
                completion?(result.results)
                
            } catch let err {
                print("Err", err)
            }
        }
        
    }
}

