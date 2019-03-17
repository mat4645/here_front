//
//  ViewController.swift
//  here_projerct1
//
//  Created by mat4645 on 2019/03/16.
//  Copyright © 2019 MAT0622. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON

//func testtest() {
//
//    let alert:UIAlertController = UIAlertController(title:"action",
//                                                    message: "alertView",
//                                                    preferredStyle: UIAlertController.Style.alert)
//
//
//    let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel",
//                                                   style: UIAlertAction.Style.cancel,
//                                                   handler:{
//                                                    (action:UIAlertAction!) -> Void in
//                                                    print("Cancel")
//    })
//    let defaultAction:UIAlertAction = UIAlertAction(title: "OK",
//                                                    style: UIAlertAction.Style.default,
//                                                    handler:{
//                                                        (action:UIAlertAction!) -> Void in
//                                                        print("OK")
//                                                        mainMapView.addAnnotation(myPin)
//                                                        // ここにコールバック入れる
//                                                        // 更新処理
//    })
//    alert.addAction(cancelAction)
//    alert.addAction(defaultAction)
//
//    //現在の日付を取得
//    let date:Date = Date()
//    //日付のフォーマットを指定する。
//    let format = DateFormatter()
//    format.dateFormat = "HH:mm"
//    //日付をStringに変換する
//    let sDate = format.string(from: date)
//    print(sDate)
//
//    //textfiledの追加
//    alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
//        text.text        = sDate
//    })
//
//    present(alert, animated: true, completion: nil)
//
//}

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mainMapView: MKMapView!
    @IBOutlet weak var locatebutton: UIButton!
    var locationManager: CLLocationManager!
    
    let URL = "https://hereeee.herokuapp.com/event/index"
    let headers: HTTPHeaders = [
        "Contenttype": "application/json"
    ]
   
    //現在地移動処理
    func moveNowLocation(){
        var region:MKCoordinateRegion = mainMapView.region
        region.center = mainMapView.userLocation.coordinate
        region.span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)

        mainMapView.setRegion(region,animated:true)
    }
    
    func getEvent(){
        Alamofire.request(URL, method: .get)
            .responseJSON { response in
                let json = JSON(response.result.value!)// データをJSON型で取得
                
                for i in 0..<json.count {
                    print(json[i])
                    var json_temp = json[i]
                    print(json_temp["id"])
                    
//                    var latitude = json_temp.getForKey("latitude") as! NSNumber
//
//                    let start_time = json_temp["start_time"]
//                    let latitude = json_temp["latitude"]
////                    let latitude1!:Double = Double(latitude)
//                    let longtitude = json_temp["longitude"]
//                    let user_name = json_temp["user_name"]
                    
//                    print(latitude)
                    print("まつもt")
                    // ピンを生成.
                    let eventPin: MKPointAnnotation = MKPointAnnotation()
                    // 座標を設定.
//                    eventPin.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
                    // タイトルを設定.
                    eventPin.title = "Masakazu Matsumoto"
                    // サブタイトルを設定.
                    eventPin.subtitle = "19:00"
                    // MapViewにピンを追加.(いずれ消す)
                    self.mainMapView.addAnnotation(eventPin)
                }
                
//                for roop1 in json {
//                    print("hdsrusvi")
//                    print(roop1)
//                    print("nvdfsvonobnenoiu")
//                    let json_kobetsu = roop1 as! Dictionary<<#Key: Hashable#>, Any>; (Any).self

                

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        getEvent()
        
        Alamofire.request(URL, method: .get)
            .responseJSON { response in
                let json = JSON(response.result.value) // データをJSON型で取得
                print("json=")
                print(json)
                let json_kobetsu = json[0]
                print(json_kobetsu)
                let start_time = json_kobetsu["start_time"]
                let latitude = json_kobetsu["latitude"]
                let longtitude = json_kobetsu["longitude"]
                let id = json_kobetsu["id"]
                print(start_time)
                print(latitude)
                print(longtitude)
                print(id)
                
                
                
//                var dictionary = ["takashi":1, "yoshida":7, "sasaki":10]
//
//                for (when, latitude, longtitude, name) in json_kobetsu {
//                    println("dictionary key is \(when), value is \(latitude)")
//                }
                
                //let height = json["Height"].float! // 得られたデータをfloat型に変換
        }
        
        mainMapView.delegate = self
        //位置情報取得のユーザー認証
        if locationManager == nil {
            locationManager = CLLocationManager()
            if #available(iOS 8.0, *) {
                // NSLocationWhenInUseUsageDescriptionに設定したメッセージでユーザに確認
                locationManager.requestWhenInUseAuthorization()
                // NSLocationAlwaysAndWhenInUseUsageDescriptionに設定したメッセージでユーザに確認
                //locationManager.requestAlwaysAuthorization()
            }
        }
        print("viewDid")
        
        //デリゲート先に自分を設定する。
        locationManager.delegate = self
        //位置情報の取得を開始する。
        locationManager.startUpdatingLocation()
        // 表示タイプを地図に設定
        mainMapView.mapType = MKMapType.standard
        // 現在地に追従
        mainMapView.userTrackingMode = MKUserTrackingMode.follow
        // ピンを複数立てる
        let london = MKPointAnnotation()
        london.title = "London"
        london.coordinate = CLLocationCoordinate2D(latitude: 37.78965513559302, longitude: -122.41320477778802)
        mainMapView.addAnnotation(london)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // ボタン処理
    @IBAction func nowPlace(_ sender: Any) {
        moveNowLocation()
    }
    
    // ピンをタップした際に呼ばれるdelegate
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        // どのピンがタップされたかを取得
        let title = view.annotation?.title
                print("titie")
        if let point = title{   // "optional(横浜)"となるので、アンラップする http://qiita.com/maiki055/items/b24378a3707bd35a31a8
            let place = "hello " + point!
            print(place)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let anno = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "anno")
        anno.animatesWhenAdded = true
        anno.canShowCallout = true
        anno.rightCalloutAccessoryView = UIButton(type: .contactAdd)
        anno.animatesWhenAdded = true
        anno.displayPriority = .required
        guard annotation is MKPointAnnotation else { return nil }
        return anno
    }
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        

        
        // 長押しの最中に何度もピンを生成しないようにする.
        if (sender as AnyObject).state != UIGestureRecognizer.State.began {
            return
        }
        // 長押しした地点の座標を取得.
        let pushLocation = sender.location(in: mainMapView)
        // locationをCLLocationCoordinate2Dに変換.
        let myCoordinate: CLLocationCoordinate2D = mainMapView.convert(pushLocation, toCoordinateFrom: mainMapView)
        
        // ピンを生成.
        let myPin: MKPointAnnotation = MKPointAnnotation()
        // 座標を設定.
        myPin.coordinate = myCoordinate
        // タイトルを設定.
        myPin.title = "Masakazu Matsumoto"
        // サブタイトルを設定.
        myPin.subtitle = "19:00"
        
        let alert:UIAlertController = UIAlertController(title:"action",
                                                        message: "alertView",
                                                        preferredStyle: UIAlertController.Style.alert)
        
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel",
                                                       style: UIAlertAction.Style.cancel,
                                                       handler:{
                                                        (action:UIAlertAction!) -> Void in
                                                        print("Cancel")
        })
        let defaultAction:UIAlertAction = UIAlertAction(title: "OK",
                                                        style: UIAlertAction.Style.default,
                                                        handler:{
                                                            (action:UIAlertAction!) -> Void in
                                                            print("OK")
                                                            
                                                            self.mainMapView.addAnnotation(myPin)
                                                            // ここにコールバック入れる
                                                            // 更新処理
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        //現在の日付を取得
        let date:Date = Date()
        //日付のフォーマットを指定する。
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        //日付をStringに変換する
        let sDate = format.string(from: date)
        print(sDate)
        
        //textfiledの追加
        alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
            text.text        = sDate
            myPin.subtitle = text.text
        })
        
        present(alert, animated: true, completion: nil)
        
        
        // 経度、緯度を生成.
        let myLatitude: CLLocationDegrees = myCoordinate.latitude
        let myLongitude: CLLocationDegrees = myCoordinate.longitude
        
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLatitude, myLongitude)
        
        // MapViewに中心点を設定.
        mainMapView.setCenter(center, animated: true)
        
        print(myPin.title!)
        print(myPin.subtitle!)
        print(myCoordinate.latitude)
        print(myCoordinate.longitude)
        
    }
}




