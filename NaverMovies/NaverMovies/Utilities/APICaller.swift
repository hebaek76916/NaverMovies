//
//  APICaller.swift
//  NaverMovies
//
//  Created by 현은백 on 2022/06/14.
//

import Foundation
import Alamofire

class APICaller {
    
    static let shared = APICaller()
    
    static let baseUrl: String = "https://openapi.naver.com/v1/search/movie.json"
    
    var isPaginating = false
    
    private var start = 1
    
    private static var params: Parameters = [:]
    
    private let fetchedDataEachCallNum: Int = 20
}

extension APICaller {
    
    private func request<T: Codable>(
        query: [String: Any],
        expecting: T.Type,
        completion: @escaping (Result<T, AFError>) -> Void
    ) {
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "Urb56VLFsg_h6NK_ePnV",
            "X-Naver-Client-Secret": "cT31L7Xx3i"
        ]
        
        AF.request(APICaller.baseUrl,
                   method: .get,
                   parameters: query,
                   headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { res in
                completion(res.result)
            }
    }
    
    
    public func search(
        query: String,
        completion: @escaping (MovieResult?) -> Void
    ) {
        APICaller.params = ["query": query,
                            "display": fetchedDataEachCallNum,
                            "start": 1]
        self.isPaginating = false
        request(query: APICaller.params,
                expecting: MovieResult.self) { res in
            switch res {
            case .success(let res):
                completion(res)
            case .failure:
                completion(nil)
            }
        }
    }
    
    public func fetchData(
        pagination: Bool = false,
        completion: @escaping ([MovieInfo]) -> Void
    ) {
        guard pagination else { return }
        isPaginating = true
        
        DispatchQueue.global().async {
            guard let temp = APICaller.params["start"] as? Int else { return }
            let start = temp + self.fetchedDataEachCallNum
            APICaller.params["start"] = start
            
            self.request(query: APICaller.params,
                    expecting: MovieResult.self) { res in
                switch res {
                case .success(let res):
                    if res.start != start {
                        return
                    } else {
                        completion(res.items ?? [])
                    }
                case .failure:
                    return //MARK: Throw Error 처리해야하나?..
                }
                
                if self.isPaginating {
                    self.isPaginating = false
                }
            }
        }
    }
    
}
