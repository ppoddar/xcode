//
//  ImageLibrary.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/21/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import Foundation
import UIKit

enum ImageLoadingError:Error {
    case ImageNotFound(key:String)
}

/*
 * cache images by name fetching from remote server
 */
class ImageLibrary {
    static var cache:Dictionary<String,UIImage>
        = Dictionary<String,UIImage>()
    
    static let NO_IMAGE:UIImage = UIImage(named:"no_item_image")!
    
    /*
     * get image by name
     * return NO_IMAGE if not found or invalid name
     */
    func getItemImage(name:String?) -> UIImage  {
        guard let key = name else {
            return ImageLibrary.NO_IMAGE
        }
        let exists:Bool = ImageLibrary.cache[key] != nil
        var image:UIImage?
        if (exists) {
            print("image with key [\(key)] is cached")
            image = ImageLibrary.cache[key]!
        } else {
            print("loading image from server with key [\(key)] ")
            let imageURL = Server.newURL(key)
            let imageDataLoaded = DispatchSemaphore(value: 0)
            DispatchQueue.global().async { 
               do {
                    let imageData = try Data(contentsOf: imageURL)
                    print("loaded image data \(imageData)")
                    print("creating image from data \(imageData)")
                    image = UIImage(data: imageData)
                    ImageLibrary.cache[key] = image
                    //print("created image. releasing imageCreated semaphore")
                    imageDataLoaded.signal()
                } catch {
                    print(error)
                    imageDataLoaded.signal()
                }
            } // async
            //print("waiting on imageDataLoaded semaphore...")
            imageDataLoaded.wait()
        } // else
        //print("returning image")
        guard let i = image else {
            return ImageLibrary.NO_IMAGE}
        return i
     }
 }
