//
//  CupcakeViewModel.swift
//  CupcakeCorner-iOS
//
//  Created by Aaryan Kothari on 10/11/20.
//

import SwiftUI
import Combine

final class CupcakeViewModel: ObservableObject{
    
    var didChange = PassthroughSubject<CupcakeViewModel,Never>()
    
    @Published var cupcakes = [Cupcake](){
        didSet {
            self.didChange.send(self)
        }
    }
    
    init() {  fetchCupcakes()  }
}

extension CupcakeViewModel{
    func fetchCupcakes(){
        CupcakeAPI().fetchCupcakes { self.cupcakes = $0 }
    }
}

class CupcakeAPI: CupcakeService{
    
    private var cancellable: AnyCancellable?
    
    let urlSession: URLSession
    // local variable. Helpful in state preservation (used in catch operator)
    var cupcakes = [Cupcake]()
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchCupcakes(completion: @escaping ([Cupcake]) -> (Void)) {
        //api call
        cancellable = NetworkManager.callAPI(urlString: "http://localhost:8080/cupcakes", session: urlSession)
            .receive(on: RunLoop.main)
            .catch { _ in Just([Cupcake]()) }
            .sink { cupcakes in
                // update cupcakes model local variable.
                self.cupcakes = cupcakes
                // completion handler
                print(cupcakes)
                completion(cupcakes)
            }
    }
}

protocol CupcakeService {
    func fetchCupcakes(completion: @escaping ([Cupcake]) ->(Void))
}
