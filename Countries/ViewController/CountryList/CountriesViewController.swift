//
//  CountriesViewController.swift
//  Countries
//
//  Created by Excell Nicolas on 1/9/22.
//

import UIKit

struct CountriesViewModel {
    var countries: Observable<[Country]> = Observable([])
    
    var currentCountry: Country?
    var currentCountryImage: UIImage?
}

class CountriesViewController: UIViewController {
    
    @IBOutlet weak var countriesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = CountriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabel()
        setTableView()
        
        viewModel.countries.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        fetchCountries()
    }
}

// MARK: - Private Functions
private extension CountriesViewController {
    
    // separate label setup for future use
    func setLabel() {
        countriesLabel.text = "Countries"
    }
    
    func setTableView() {
        tableView.register(UINib(nibName: CountriesTableViewCell.identifier,
                                 bundle: nil),
                           forCellReuseIdentifier: CountriesTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

// MARK: - API
extension CountriesViewController {
    func fetchCountries() {
        let str = "https://restcountries.com/v3.1/all"
        let url = URL(string: str)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil {
                let response = try! JSONDecoder().decode([Country].self, from: data!)
                
                self.viewModel.countries.value = response.sorted { $0.name.common < $1.name.common }
            }
        }.resume()
    }
}

// MARK: - UITableView
extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.countries.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CountriesTableViewCell.identifier, for: indexPath) as? CountriesTableViewCell {
            cell.setCountryCell(country: viewModel.countries.value?[indexPath.row] ?? nil)
            
            return cell
        } else { return UITableViewCell() }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.currentCountry = viewModel.countries.value?[indexPath.row]
        
        let vc = CountryDetailsViewController()
        vc.viewModel = self.viewModel
        self.present(vc, animated: true, completion: nil)
    }
}
