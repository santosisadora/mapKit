//
//  ViewController.swift
//  Isadora-Santos_COMP2125-Sec001_Lab4_ex2
//
//  Created by user202443 on 11/19/21.
//

import UIKit
import MapKit

class ViewController: UIViewController,UISearchBarDelegate {

    //action for search button
    @IBAction func searchAddressButton(_ sender: Any) {
    let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated:true, completion:nil)
     }
    
    //outlet for map view
    @IBOutlet weak var myMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //function for when search address button is clicked
    func searchAddressButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start{
            (response, error) in
            activityIndicator.stopAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            if response == nil {
                print("error!")
            }
            else{
          
                
                let latitude = response!.boundingRegion.center.latitude
                let longitude = response!.boundingRegion.center.longitude
                
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                self.myMapView.addAnnotation(annotation)
                
                
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span:span)
                
                self.myMapView.setRegion(region, animated: true)
                
            }
        }
    }

}

