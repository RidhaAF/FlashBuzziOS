//
//  NewsView.swift
//  FlashBuzziOS
//
//  Created by Ridha Ahmad Firdaus on 11/12/23.
//

import SwiftUI

struct NewsView: View {
    @StateObject var newsViewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(newsViewModel.news, id: \.id) { news in
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: news.imageURL)) { Image in
                            Image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 350, height: 200)
                                .cornerRadius(16)
                        } placeholder: {
                            ProgressView()
                        }
                        VStack(alignment: .leading, spacing: 16) {
                            Image(news.newsSite)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 30)
                            Text(news.title)
                                .font(.title3)
                                .fontWeight(.bold)
                            Text(news.summary)
                                .foregroundColor(.gray)
                                .font(.callout)
                                .fontWeight(.bold)
                            Link(destination: URL(string: news.url)!, label: {
                                Text("")
                            })
                        }
                    }
                }
            }
            .listStyle(InsetListStyle())
            .task {
                newsViewModel.getNews()
            }
        }
    }
}

#Preview {
    NewsView()
}
