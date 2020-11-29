//
//  ContentView.swift
//  Shared
//
//  Created by אילי זוברמן on 29/11/2020.
//

import SwiftUI
import struct Kingfisher.DownsamplingImageProcessor
import struct Kingfisher.KFImage

struct ContentView: View {
    
    @StateObject var moviesViewModel = MoviesViewModel()
    
    @State private var selectedSegment = 0
    
    var body: some View {
        
        List(selectedSegment == 0 ? moviesViewModel.popularMovies : moviesViewModel.topratedMovies){ movie in
            
            NavigationLink(destination: MovieDetails(movie: movie)) {
                MovieCell(movie: movie)
                    .onAppear {
                        if movie.id == moviesViewModel.popularMovies.last?.id{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation(.spring()){
                                    moviesViewModel.loadMoreMovies(segment: selectedSegment)
                                }
                            }
                        }
                    }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Movies")
        .toolbar(content: {
            ToolbarItem(placement: .principal, content: {
                Picker("", selection: $selectedSegment, content: {
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

struct MovieCell: View{
    
    let movie: Movie
    
    var body: some View{
        HStack(spacing: 16){
            ImageLoader(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")"))
                .frame(width: 100, height: 150)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(10)
                .padding(.vertical, 8)
                .compositingGroup()
            VStack(alignment: .leading, spacing: 8){
                VStack(alignment: .leading){
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.releaseDate)
                        .foregroundColor(.secondary)
                        .font(.footnote)
                }
                
                HStack{
                    Text("Vote average:")
                    Text(String(format: "%.1f", movie.voteAverage))
                }
                .font(.subheadline)
            }
        }
    }
}

struct ImageLoader: View{
    
    let url: URL?
    
    @State private var isLoading = true
    
    var body: some View{
        Group{
            if url != nil{
                KFImage(url, options: [
                            .transition(.fade(0.2)),
                            .cacheOriginalImage,
                            .processor(DownsamplingImageProcessor(size: CGSize(width: 100, height: 150)))])
                    .renderingMode(.original)
                    .resizable()
                    .cancelOnDisappear(true)
                    .onSuccess(perform: { (imageResult) in
                        isLoading = false
                    })
                    .onFailure(perform: { (error) in
                        isLoading = false
                        print(error.localizedDescription)
                    })
                    .placeholder({
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(UIColor.systemGray6))
                            ProgressView()
                        }
                    })
            }else{
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(UIColor.systemGray5))
                    Image(systemName: "photo")
                        .renderingMode(.template)
                        .imageScale(.large)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
