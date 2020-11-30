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
            SearchBar(text: $searchText.animation(.spring()), onCancel: {
                searchText = ""
                searchDB.removeAll()
            })
                .padding(.horizontal)
                .onChange(of: searchText) { (output) in
                    moviesViewModel.searchMovie(searchText: output){ results in
                        searchDB.append(contentsOf: results)
                    }
                }
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
        .navigationTitle("Search")
        .background(Color(UIColor.systemGroupedBackground))
    }
}
