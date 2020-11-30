//
//  ImageLoader.swift
//  test8200ac
//
//  Created by אילי זוברמן on 30/11/2020.
//

import SwiftUI
import struct Kingfisher.DownsamplingImageProcessor
import struct Kingfisher.KFImage

struct ImageLoader: View{
    
    let url: URL?
    var size: Double
    
    @State private var isLoading = true
    
    var body: some View{
        Group{
            if url != nil{
                KFImage(url, options: [
                            .transition(.fade(0.5)),
                            .cacheOriginalImage,
                            .processor(DownsamplingImageProcessor(size: CGSize(width: size, height: size*1.5)))])
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
                        VStack(alignment: .center){
                            Spacer()
                            ProgressView()
                            Spacer()
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
