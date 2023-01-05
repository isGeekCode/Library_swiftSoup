//
//  ViewController.swift
//  CrawlingPractice
//
//  Created by bang_hyeonseok on 2023/01/04.
//
import SwiftSoup
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startCrawling()
    }

    func startCrawling() {
        let urlString = "https://www.serveq.co.kr/recipe/BAK/recipe_view?R_IDX=1417&PAGESIZE=12&SORTCOL=&SORTDIR=&SEL_R_CATE_CODE=BAK001&SEARCH_COL=&SEARCH_KEYWORD="
        guard let url = URL(string: urlString) else { return }
//        loadWebView(urlString: urlString)
        
        do {
            let webString = try String(contentsOf: url)
            let document = try SwiftSoup.parse(webString)
            // 해당 id값을 Element로 가져온다.
            let element = try document.getElementById("make")
            print("element: \(String(describing: element))")
            
            // 타이틀 크롤링
            // 가져온 element에서 원하는 태그값을 지정해 array에 담는다. select()만으로는 내용을 볼 수 없다. array에 담거나 text()로 String으로 전환시켜야 확인가능하다.
            guard let titles = try element?.select("h4").array() else { return }
            print("titles: \(titles)")
            var titleArray = [String]()
            print("titleArray: \(titleArray)")
            // &nbsp;가 포함된 경우가 있어 문자열 앞뒤 공백을 제거하는 trimmingCharacters함수를 사용한다.
            for i in titles {
                let t = try i.select("h4").first()?.text().trimmingCharacters(in: .whitespaces)
                titleArray.append(t!)
            }
//            print("titleArray: \(titleArray)")
//            let div = try element?.select("div")
//            let ol = try div?.select("ol").array()
//            print("ol: \(ol)")
            guard let olArray = try element?.select("div").select("ol").array() else { return }
            print("contents: \(String(describing: olArray))")
            var fullArray = [[String]]()
            var contentArray = [String]()
            var contentArray2 = [String]()
            
//            for i in 0 ..< olArray.count {
//                let liArray = try olArray[i].select("li").array()
//                for j in 0 ..< liArray.count {
//                    let liElement = try liArray[j].select("li").text()
//                }
//            }
            
            
            print("contents[0]: \(String(describing: olArray[0]))")
            let olFirst = [olArray[0]]
            print("contes: \(olFirst)")
            for i in olFirst {
                let liArray = try i.select("li").array()
                for j in liArray {
                    let liElement = try j.select("li").text()
                    contentArray.append(liElement)
                }
            }
            
            let olSecond = [olArray[1]]
            print("contes: \(olSecond)")
            for i in olSecond {
                let liArray = try i.select("li").array()
                for j in liArray {
                    let liElement = try j.select("li").text()
                    contentArray2.append(liElement)
                }
            }
             
            print("contentArray: \(contentArray)")
            print("contentArray2: \(contentArray2)")
            
            fullArray.append(contentArray)
            fullArray.append(contentArray2)
            print("fullArray: \(fullArray)")
                    
            // 이미지 찾기
            let imgElements = try document.getElementsByClass("img")
            print("imgElements: \(String(describing: imgElements))")
            
            guard let images = try element?.select("img").text() else { return }
            print("images: \(images)")


            

        } catch {
            print("error: \(error.localizedDescription)")
        }
    }

}

