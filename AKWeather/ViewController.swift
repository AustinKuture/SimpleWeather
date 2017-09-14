//
//  ViewController.swift
//  AKWeather
//
//  Created by 李亚坤 on 2017/9/7.
//  Copyright © 2017年 Kuture. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SnapKit
import Kingfisher


let CELL_WIDTH = SCREEN_WIDTH * 0.48
let CELL_LINE = SCREEN_WIDTH * 0.02

class ViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {

    //MARK:数据
    //currentTempreture
    fileprivate lazy var currentTPArray = [String]()
    //weatherState
    fileprivate lazy var weatherStaArray = [String]()
    //pm2.5
    fileprivate lazy var currentPMArray = [String]()
    //wind
    fileprivate lazy var weathWDArray = [String]()
    //tempretureScope
    fileprivate lazy var TPScopeArray = [String]()
    //date
    fileprivate lazy var dateSArray = [String]()
    
    //dayURL
    fileprivate lazy var dayPicUrlArray = [String]()
    //nightURL
    fileprivate lazy var nightPicUrlArray = [String]()
    
    //滑动视图
    fileprivate lazy var scrollView = UIScrollView()
    
    //天气视图
    var weatherView = AKWeatherView()
    
    //未来几天天气
    fileprivate var collectionView:UICollectionView {
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.itemSize = CGSize(width: CELL_WIDTH, height: CELL_WIDTH)
        flowlayout.minimumLineSpacing = CELL_LINE
        flowlayout.minimumInteritemSpacing = CELL_LINE - 7

        let rect = CGRect(x: 0, y: SCREEN_WIDTH * 0.4 + 114, width: SCREEN_WIDTH, height: CELL_WIDTH * 2 + 15)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: flowlayout)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.isScrollEnabled = false
        collectionView.contentInset = UIEdgeInsetsMake(5, 3, 5, 3)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        collectionView.register(AKFutureCell.self, forCellWithReuseIdentifier: "cellID")
        
        return collectionView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //获取天气数据
        setupWeatherDataFromNetWork()
        
        //天气布局
        setupWeatherView()
      
    }
    
    //MARK:天气布局
    func setupWeatherView(){
        
        //滑动视图
        scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT + 50)
        self.view.addSubview(scrollView)
        
        //天气视图
        weatherView = AKWeatherView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_WIDTH * 0.4 + 50))

        weatherView.backgroundColor = UIColor.clear
        
        scrollView.addSubview(weatherView)
    }
}

//网络数据的加载
extension ViewController{
    
  //获取天气数据
    func setupWeatherDataFromNetWork(){
        
        let url = "https://api.map.baidu.com/telematics/v3/weather"
        let parm = ["location":"北京","output":"json",
                    "ak":"11ffd27d38deda622f51c9d314d46b17"]
        
        Alamofire.request(url, method: .get, parameters: parm, encoding: URLEncoding.default, headers: nil).responseData { (responseData) in
            
            let json = JSON(responseData.result.value!)
            
            guard json["error"] == 0 else{
                
                return print("数据异常,错误原因:\(json["error"])")
            }
            
            print("=======JSON:\(json["results"][0])")
            
            for i in 0..<json["results"][0]["weather_data"].count{
                
                //当前温度
                self.currentTPArray.append(json["results"][0]["weather_data"][i]["date"].string ?? "")
                //天气状况
                self.weatherStaArray.append(json["results"][0]["weather_data"][i]["weather"].string ?? "")
                //空气指数
                self.currentPMArray.append(json["results"][0]["pm25"].string ?? "")
                //风向
                self.weathWDArray.append(json["results"][0]["weather_data"][i]["wind"].string ?? "")
                //温度范围
                self.TPScopeArray.append(json["results"][0]["weather_data"][i]["temperature"].string ?? "")
                //当前日期
                self.dateSArray.append(json["results"][0]["weather_data"][i]["date"].string ?? "")
                //白天图片
                self.dayPicUrlArray.append(json["results"][0]["weather_data"][i]["dayPictureUrl"].string ?? "")
                //晚上图片
                self.nightPicUrlArray.append(json["results"][0]["weather_data"][i]["nightPictureUrl"].string ?? "")
            }
            
            self.weatherView.currentTempreture.text = self.dateSArray.first
            self.weatherView.weatherState.text = self.weatherStaArray.first
            self.weatherView.currentPM.setTitle(" ".appending(self.currentPMArray.first!), for: UIControlState.normal)
            self.weatherView.weatherWind.setTitle(self.weathWDArray.first, for: UIControlState.normal)
            self.weatherView.tempretureScope.setTitle(self.TPScopeArray.first, for: UIControlState.normal)
            
//            self.weatherView.dayPicImg.kf.setImage(with:URL(string: self.dayPicUrlArray.first!))
//            self.weatherView.nightPicImg.kf.setImage(with:URL(string: self.nightPicUrlArray.first!))

            //未来天气
            self.scrollView.addSubview(self.collectionView)
            self.collectionView.reloadData()

        }
    }
}

//MARK:CollectionView
extension ViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("========TPCount:\(self.currentTPArray.count)")
        
        return self.currentTPArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! AKFutureCell
        
        cell.dateL.text = self.dateSArray[indexPath.row]
        cell.weatherL.text = self.weatherStaArray[indexPath.row]
        cell.picL.kf.setImage(with: URL(string: self.dayPicUrlArray[indexPath.row]))
        cell.windL.setTitle(self.weathWDArray[indexPath.row], for: UIControlState.normal)
        cell.tempreture.setTitle(self.TPScopeArray[indexPath.row], for: UIControlState.normal)

        //效果
        cell.backgroundColor = COLORS_RANDOM(0.2)
        cell.layer.cornerRadius = 5
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        //边框
        cell.layer.borderColor = COLORS_RANDOM(0.3).cgColor
        cell.layer.borderWidth = 1
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

//        UIView.beginAnimations("curlUp", context: nil)
//        UIView.setAnimationCurve(UIViewAnimationCurve.easeInOut)
//        UIView.setAnimationDuration(1)
//        UIView.setAnimationDelegate(self)
//        UIView.setAnimationTransition(UIViewAnimationTransition.curlUp, for: collectionView, cache: true)
//        UIView.commitAnimations()
        
     
        

    }
}



























