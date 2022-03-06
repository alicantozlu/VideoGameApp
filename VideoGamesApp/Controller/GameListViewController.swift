//
//  GameListViewController.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 5.03.2022.
//

import UIKit

class GameListViewController: UIViewController {
    
    @IBOutlet var topCollectionView: UICollectionView!
    @IBOutlet var bottomTableView: UITableView!
    
    var topGameList = [TopCellModel]()
    var bottomGameList = [BottomCellModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarConfig()
        
        topCollectionView.register(UINib(nibName: "TopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "topCellIdentity")
        
        bottomTableView.register(UINib(nibName: "BottomTableViewCell", bundle: nil), forCellReuseIdentifier: "bottomCell")
        self.bottomTableView.rowHeight = 223
        /*
         let urlStr = "https://api.rawg.io/api/games?key=58d924b9ce4441f48c690d746949c01c&page=1"
         guard let gameURL = URL(string: urlStr) else { return }
         let gameList = try? JSONDecoder().decode([TopCellModel].self, from: Data(contentsOf: gameURL))
         guard let videoGameList = gameList else { return }
         self.topGameList = videoGameList*/
        
        
        
        /*var url : String = "https://api.rawg.io/api/games?key=58d924b9ce4441f48c690d746949c01c&page=1"
         var request : NSMutableURLRequest = NSMutableURLRequest()
         request.URL = NSURL(string: url) as URL?
         request.httpMethod = "GET"
         
         NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
         var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
         let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
         
         if (jsonResult != nil) {
         // process jsonResult
         } else {
         // couldn't load JSON, look at error
         }
         })*/
        
        
        /*let bottomList = try? JSONDecoder().decode([BottomCellModel].self, from: Data(contentsOf: travelURL))
         bottomGameList = bottomList!*/
        
        /*
         for i in 0...travels.count-1{
         destinations.append(DestinationModel(destination1: destination1, destination2: destination2, date: date, travelModel: travels[i]))
         }*/
        
        /*let urlString = "https://api.rawg.io/api/games?key=58d924b9ce4441f48c690d746949c01c&page=1"
         
         let url = URL(string: urlString)
         var request = URLRequest(url: url!)
         request.httpMethod = "GET"
         
         URLSession.shared.dataTask(with:request) { (data, response, error) in
         if error != nil {
         print(error as Any)
         } else {
         do {
         
         let gameList = try JSONSerialization.jsonObject(with: data!) as! [TopCellModel]
         //guard let videoGameList = gameList else { return }
         self.topGameList = gameList
         
         let parsedDictionaryArray = try JSONSerialization.jsonObject(with: data!) as! [String:AnyObject]
         print(parsedDictionaryArray)
         
         if let arry = parsedDictionaryArray["data"] as? [[String:AnyObject]] {
         for dic in arry {
         print("\(dic)\n")
         //let imageLink = dic[results["background_image"]]
         //let descriptionData = dic["description"]
         //self.topGameList.append(TopCellModel(results: [Results(background_image: "\(imageLink)")]))
         //self.modelReference.append(TopCellModel(name: name as! String, descriptionStr: descriptionData as! String))
         //print(name!)
         }
         }
         } catch let error as NSError {
         print(error)
         }
         }
         
         }.resume()
         
         print("\(self.topGameList)")*/
        
        /*let url : String = "https://api.rawg.io/api/games?key=58d924b9ce4441f48c690d746949c01c&page=1"
         
         URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { data, response, error in
         // Handle result
         
         /*let response = String (data: data!, encoding: String.Encoding.utf8)
          print("response is \(response ?? "dfg")")*/
         
         let gameList = try? JSONDecoder().decode([TopCellModel].self, from: data!)
         guard let videoGameList = gameList else { return }
         self.topGameList = videoGameList
         
         /*do {
          let getResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
          let countryArray = getResponse as! NSArray
          let country1 = countryArray[0] as! [String:Any]
          let name = country1["name"] as! String
          } catch {
          print("error serializing JSON: \(error)")
          }*/
         }.resume()*/
        
        
        
        /* var request = URLRequest(url: URL(string: "https://api.rawg.io/api/games?key=58d924b9ce4441f48c690d746949c01c&page=1")!)
         request.httpMethod = "GET"
         
         URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
         
         let gameList = try? JSONDecoder().decode([TopCellModel].self, from: data!)
         guard let videoGameList = gameList else { return }
         self.topGameList = videoGameList
         
         /*let jsonDecoder = JSONDecoder()
          let responseModel = try jsonDecoder.decode(CustomDtoClass.self, from: data!)
          print(responseModel)*/
         
         }).resume()*/
        
        
        
        
        
        
        
        
        if let baseGETURL = URL(string:"https://postman-echo.com/get?foo1=bar1&foo2=bar2"){
            self.fetch(requestURL: baseGETURL, requestType: "GET", parameter: nil) { (result) in
                switch result{
                case .success(let response) :
                    print("Hello World \(response)")
                case .failure(let error) :
                    print("Hello World \(error)")
                    
                }
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        print("\(self.topGameList)")
        
    }
    
    
    
    
    
    //Send Request with ResultType<Success, Error>
    func fetch(requestURL:URL,requestType:String,parameter:[String:AnyObject]?,completion:@escaping (Result<Any>) -> () ){
        //Check internet connection as per your convenience
        //Check URL whitespace validation as per your convenience
        //Show Hud
        var urlRequest = URLRequest.init(url: requestURL)
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        urlRequest.timeoutInterval = 60
        urlRequest.httpMethod = String(describing: requestType)
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        //Post URL parameters set as URL body
        if let params = parameter{
            do{
                let parameterData = try JSONSerialization.data(withJSONObject:params, options:.prettyPrinted)
                urlRequest.httpBody = parameterData
            }catch{
                //Hide hude and return error
                completion(error)
            }
        }
        //URL Task to get data
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            //Hide Hud
            //fail completion for Error
            if let objError = error{
                completion(objError)
            }
            //Validate for blank data and URL response status code
            if let objData = data,let objURLResponse = response as? HTTPURLResponse{
                //We have data validate for JSON and convert in JSON
                do{
                    let objResposeJSON = try JSONSerialization.jsonObject(with: objData, options: .mutableContainers)
                    //Check for valid status code 200 else fail with error
                    if objURLResponse.statusCode == 200{
                        completion(objResposeJSON)
                    }
                }catch{
                    completion(error)
                }
            }
        }.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // TabBar ozellestirmeleri
    private func tabbarConfig() {
        guard let tabBar = tabBarController?.tabBar else { return }
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage() // add this if you want remove tabBar separator
        tabBar.barTintColor = .clear
        tabBar.backgroundColor = .clear // here is your tabBar color
        tabBar.layer.backgroundColor = UIColor.clear.cgColor
        let blurEffect = UIBlurEffect(style: .light) // here you can change blur style
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = tabBar.bounds
        blurView.autoresizingMask = .flexibleWidth
        tabBar.insertSubview(blurView, at: 0)
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .darkGray
    }
}

extension GameListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCellIdentity", for: indexPath) as! TopCollectionViewCell
        return cell
    }
}

extension GameListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bottomCell") as! BottomTableViewCell
        return cell
    }
}
