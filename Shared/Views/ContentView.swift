//
//  ContentView.swift
//  Shared
//
//  Created by אילי זוברמן on 29/11/2020.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var moviesViewModel = MoviesViewModel()
    
    @State private var selectedSegment = 0
    
    let column = [
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200))
    ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: column, alignment: .center, spacing: 16, content: {
                
                ForEach(selectedSegment == 0 ? moviesViewModel.popularMovies : moviesViewModel.topratedMovies){ movie in
                    
                    NavigationLink(destination: MovieDetails(movie: movie)) {
                        PosterCell(movie: movie)
                            .onAppear {
                                
                                if movie.id == moviesViewModel.popularMovies.last?.id || movie.id == moviesViewModel.topratedMovies.last?.id{
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        moviesViewModel.loadMoreMovies(segment: selectedSegment)
                                    }
                                }
                            }
                    }
                }
                
                VStack(spacing: 16){
                    ProgressView()
                    Text("Load more")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .isEmpty(moviesViewModel.isFetching)
                
            })
            .padding(.top)
        }
        .padding(.bottom, 32)
        .background(Color(UIColor.systemGroupedBackground))
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("Movies")
        .toolbar(content: {
            ToolbarItem(placement: .principal, content: {
                Picker("", selection: $selectedSegment.animation(.spring()), content: {
                    Text("Popular")
                        .tag(0)
                    Text("Most Rated")
                        .tag(1)
                })
                .labelsHidden()
            })
            
            ToolbarItem(placement: .navigationBarTrailing, content: {
                NavigationLink(destination: SearchMovieView(moviesViewModel: moviesViewModel), label: {
                    Image(systemName: "magnifyingglass")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 25)
                })
            })
        })
    }
}
