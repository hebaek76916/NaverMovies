//
//  Extensions.swift
//  NaverMovies
//
//  Created by 현은백 on 2022/06/15.
//

import UIKit
import Kingfisher

extension String {
   func removeHTMLTag() -> String {
       return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
}

extension UIImageView {
    func setImage(with source: String?) {
        guard let source = source else { return }
        guard let url = URL(string: source) else { return }
        DispatchQueue.main.async {
            self.kf.setImage(with: url,
                             placeholder: nil,
                             options: [
                                 .loadDiskFileSynchronously,
                                 .cacheOriginalImage,
                                 .transition(.fade(0.25))
                             ],
                             completionHandler: { result in
                
                
            })
        }
    }
}
