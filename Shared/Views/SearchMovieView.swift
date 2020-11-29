//
//  SearchMovieView.swift
//  test8200ac
//
//  Created by אילי זוברמן on 29/11/2020.
//

import SwiftUI

struct SearchMovieView: View {
    
    @ObservedObject var moviesViewModel: MoviesViewModel
    
    @State private var searchDB = [Movie]()
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.horizontal)
            List {
                ForEach(searchDB.filter({
                    self.searchText.isEmpty ? false : $0.title.lowercased().contains(self.searchText.lowercased())
                })) { movie in
                    NavigationLink(destination: MovieDetails(movie: movie)) {
                        MovieCell(movie: movie)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .onAppear(perform: {
            searchDB = moviesViewModel.popularMovies + moviesViewModel.topratedMovies
        })
        .navigationTitle("Search")
        .background(Color(UIColor.systemGroupedBackground))
    }
}
