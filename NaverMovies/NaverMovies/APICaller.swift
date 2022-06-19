//
//  APICaller.swift
//  NaverMovies
//
//  Created by 현은백 on 2022/06/14.
//

import Foundation
import Alamofire
//Client ID
//Urb56VLFsg_h6NK_ePnV
//Client Secret
//cT31L7Xx3i

class APICaller {
    
    static let baseUrl: String = "https://openapi.naver.com/v1/search/movie.json"
    
}

extension APICaller {
    
    class func search(
        query: String,
        completion: @escaping (MovieResult?) -> Void
    ) {
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "Urb56VLFsg_h6NK_ePnV",
            "X-Naver-Client-Secret": "cT31L7Xx3i"
        ]
        
        AF.request(baseUrl,
                   method: .get,
                   parameters: ["query": query],
                   headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MovieResult.self) { result in
                completion(result.value)
            }
    }
}
