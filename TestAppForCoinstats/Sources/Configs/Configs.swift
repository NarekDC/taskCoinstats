//
//  Configs.swift
//  TestAppForCoinstats
//
//  Created by Narek Ektubaryan on 22.12.21.
//
import Foundation

//MARK: URL EndPoints
var feedUrl = URLComponents(string: "https://coinstats.getsandbox.com/feed")

func topHeadlines() -> URL?  {
    return feedUrl?.url
}
