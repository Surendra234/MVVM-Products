//
//  ProductListViewController.swift
//  MVVM Products
//
//  Created by XP India on 18/10/23.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var productTabelView: UITableView!
    var viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()
    }
}

extension ProductListViewController {
    
    func configuration() {
        productTabelView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        observeEvent()
        initViewModel()
    }
    
    func initViewModel() {
        viewModel.fetchProducts()
    }
    
    // Data binding event observe karega - communication
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self = self else { return}
            switch event {
            case .loading: 
                print("DEBUG :- \(1)")
                break
            case .stopLoading: 
                print("DEBUG :- \(2)")
                break
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.productTabelView.reloadData()
                }
            case .error(let error):
                print("DEBUG :- \(String(describing: error))")
            }
        }
    }
}

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
}
