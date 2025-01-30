//
//  ContentView.swift
//  Flickr
//
//  Created by David Mottle on 1/28/25.
//

import SwiftUI

struct FlickrView: View {
    @EnvironmentObject var fetcher: FlickrFetcher
    @Environment(\.horizontalSizeClass) private var horizantalSizeClass
    @State private var tags = ""
    // Decided that if the device is held horizantally to use 3 grids and horizantally to use 8.
    var columnLayout: [GridItem] {
        horizantalSizeClass == .compact ?
        Array(repeating: GridItem(),count: 3) : Array(repeating: GridItem(),count: 8)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField(Common.constants.searchName,
                          text: $tags,
                          prompt: Text(Common.constants.searchName)
                            .foregroundColor(.white)
                )
                    .padding(10)
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .onChange(of: tags, { _, _ in
                        Task {try? await fetcher.fetchData(tags: tags)}
                    })
                ScrollView {
                    LazyVGrid(columns: columnLayout) {
                        ForEach(fetcher.imageData.items ?? [], id: \.self) { imageData in
                            GeometryReader { geo in
                                NavigationLink {
                                    FlickrImageDetailView(image: imageData)
                                } label: {
                                    AsyncImage(url: URL(string: imageData.media[Common.constants.mKey] ?? "")) { phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .transition(.opacity.animation(.easeInOut(duration: 0.5)))
                                        } else {
                                            ProgressView()
                                        }
                                    }
                                }
                            }
                            .aspectRatio(contentMode: .fit)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    FlickrView()
}
