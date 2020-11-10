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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cake = cupcakes[indexPath.row]
        let ac = UIAlertController(title: "Order a \(cake.name)?", message: "Please enter your name", preferredStyle: .alert)
        ac.addTextField()
        let orderAction = UIAlertAction(title: "Order it!", style: .default) { _ in
            guard let name = ac.textFields?.first?.text else { return }
            self.order(cake, name:name)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        ac.addAction(orderAction)
        ac.addAction(cancelAction)
        self.present(ac, animated: true, completion: nil)
    }
    
    func order(_ cake: Cupcake,name:String){
        let order = Order(cakeName: cake.name, buyerName: name)
        let url = URL(string: "http://localhost:8080/order")!
        
        let data = try?  JSONEncoder().encode(order)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data{
                let decoder = JSONDecoder()
                if let item = try? decoder.decode(Order.self, from: data){
                    print(item.buyerName)
                } else {
                    print("BAD JSON OBJECT")
                }
            }
        }.resume()
        
    }
}

