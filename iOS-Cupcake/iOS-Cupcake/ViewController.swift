//
//  ViewController.swift
//  iOS-Cupcake
//
//  Created by Aaryan Kothari on 10/11/20.
//

import UIKit

class ViewController: UITableViewController {

    var cupcakes = [Cupcake]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    func fetchData(){
        let url = URL(string: "http://localhost:8080/cupcakes")!
        URLSession.shared.dataTask(with: URLRequest(url: url)){data, response, error in
            guard let data = data else {
                print(error?.localizedDescription)
                return
            }
            let decoder = JSONDecoder()
            if let cupcakes = try? decoder.decode([Cupcake].self, from: data){
                DispatchQueue.main.async {
                    self.cupcakes = cupcakes
                    self.tableView.reloadData()
                }
            } else {
                print("JSON ERROR")
            }
        }.resume()
    }

}

extension ViewController {    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cupcakes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        let cake = cupcakes[indexPath.row]
        cell.textLabel?.text = "\(cake.name) - $\(cake.price)"
        cell.detailTextLabel?.text = cake.description
        
        return cell
    }
}

