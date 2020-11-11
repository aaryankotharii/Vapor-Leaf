//
//  NetworkManager.swift
//  CupcakeCorner-iOS
//
//  Created by Aaryan Kothari on 10/11/20.
//

import Foundation
import Combine

struct NetworkManager {
    static var responseCode: Int = 0

    static func callAPI<T: Decodable>(
        urlString: String,
        httpMethod: String = "GET",
        uploadData: Data = Data(),
        session: URLSession = .shared
    ) -> AnyPublisher<T, Error> {
        //set response code to 0
        responseCode = 0

        //convert url string to url
        let url = URL(string: urlString)!

        //setup url request
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod
        request.httpBody = uploadData

        //make the call using the url request
        return session
            .dataTaskPublisher(for: request)
            .tryMap {
                print($0.response.description)
                if let response = $0.response as? HTTPURLResponse {
                    print(response.statusCode)
                    self.responseCode = response.statusCode
                }
                return $0.data
        }
        .decode(type: T.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
}
