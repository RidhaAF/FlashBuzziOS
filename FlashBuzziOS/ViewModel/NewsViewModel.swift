//
//  NewsViewModel.swift
//  FlashBuzziOS
//
//  Created by Ridha Ahmad Firdaus on 11/12/23.
//

import Foundation
class NewsViewModel: ObservableObject {
    @Published var news: [Result] = []
    @Published var url = "https://api.spaceflightnewsapi.net/v4/articles/"
    
    func getNews() {
        guard let url = URL(string: url) else {
            return print("Invalid URL")
        }
        let task = URLSession.shared.dataTask(with: url) {[weak self] data,_,error in
            guard let data = data,  error == nil else{return}
            do {
                let news = try JSONDecoder().decode(NewsModel.self, from: data)
                DispatchQueue.main.async {
                    self?.news = news.results
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
