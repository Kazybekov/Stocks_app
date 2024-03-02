////
////  Networking.swift
////  Stock_app
////
////  Created by Yersin Kazybekov on 10.01.2024.
////
//
//import UIKit
//
//class Networking{
//    
//    func downloadImage(from url: URL) async -> UIImage? {
//      do {
//          let (data, response) = try await URLSession.shared.data(from: url)
//          if let httpResponse = response as? HTTPURLResponse,
//             httpResponse.statusCode >= 200 &&  httpResponse.statusCode <= 300 {
//              return UIImage(data: data)
//          }
//          return nil
//      } catch {
//          return nil
//      }
//    }
////
//
//    func download() async -> [UIImage] {
//      let urls = [
//          URL(string: "https://images.unsplash.com/photo-1575936123452-b67c3203c357")!,
//          URL(string: "https://images.unsplash.com/photo-1575936123452-b67c3203c357")!,
//          URL(string: "https://images.unsplash.com/photo-1575936123452-b67c3203c357")!,
//          URL(string: "https://images.unsplash.com/photo-1575936123452-b67c3203c357")!,
//          URL(string: "https://images.unsplash.com/photo-1575936123452-b67c3203c357")!,
//          URL(string: "https://images.unsplash.com/photo-1575936123452-b67c3203c357")!,
//          URL(string: "https://images.unsplash.com/photo-1575936123452-b67c3203c357")!,
//          URL(string: "https://images.unsplash.com/photo-1575936123452-b67c3203c357")!,
//          URL(string: "https://images.unsplash.com/photo-1575936123452-b67c3203c357")!,
//          URL(string: "https://images.unsplash.com/photo-1575936123452-b67c3203c357")!,
//          URL(string: "https://images.unsplash.com/photo-1575936123452-b67c3203c357")!,
//          URL(string: "https://images.unsplash.com/photo-1575936123452-b67c3203c357")!,
//          URL(string: "https://images.unsplash.com/photo-1575936123452-b67c3203c357")!,
//          URL(string: "https://images.unsplash.com/photo-1575936123452-b67c3203c357")!,
//     ]
//     
//      return await withTaskGroup(of: UIImage.self) { group in
//          for url in urls {
//              group.addTask {
//                  await self.downloadImage(from: url)!
//              }
//          }
//          defer {
//              group.cancelAll()
//          }
//          return await group.reduce(into: [UIImage]()) {
//              $0.append($1)
//          }
//      }
//    }
//    
//    
//    //func for image
//    
//    //func for data
//    
//    //func for urlsession
//}
