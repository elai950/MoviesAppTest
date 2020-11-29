//
//  MoviesViewModel.swift
//  test8200ac
//
//  Created by אילי זוברמן on 29/11/2020.
//

import Foundation
import Alamofire

final class MoviesViewModel: ObservableObject{
    
    @Published var popularMovies: [Movie] = []
    @Published var topratedMovies: [Movie] = []
    
    private var db = MovieDB.shared
    
    private let popularMoviesApi = "https://api.themoviedb.org/3/movie/popular?api_key=390640f9df4b7a5213316eb01d83afd7&language=en-US&page=1"
    private let trMoviesApi = "https://api.themoviedb.org/3/movie/top_rated?api_key=390640f9df4b7a5213316eb01d83afd7&language=en-US&page=1"
    
    init(){
        db.getMovies(api: "\(popularMoviesApi)"){ result in
            DispatchQueue.main.async {
                self.popularMovies = result
            }
        }
        
        db.getMovies(api: "\(trMoviesApi)") { (result) in
            DispatchQueue.main.async {
                self.topratedMovies = result
            }
        }
    }
    
    func loadMoreMovies(segment: Int){
        if segment == 0 {
            db.popularMoviesPage += 1
            db.getMovies(api: "\(popularMoviesApi)&page=\(MovieDB.shared.popularMoviesPage)") { (result) in
                self.popularMovies += result
            }
        }else{
            db.topratedMoviesPage += 1
            db.getMovies(api: "\(trMoviesApi)&page=\(MovieDB.shared.topratedMoviesPage)") { (result) in
                self.topratedMovies += result
            }
        }
    }
}

