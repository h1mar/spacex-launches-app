//
//  Api.swift
//  Proyecto Final
//
//  Created by Himar Muñoz García on 20/3/22.
//

import Foundation

struct ApiRoot: Codable {
    let docs: [Launch]
    let totalDocs, offset, limit, totalPages: Int
    let page, pagingCounter: Int
    let hasPrevPage, hasNextPage: Bool
    let prevPage: Int?
    let nextPage: Int
}

struct Launch: Codable {
    let links: Links
    let static_fire_date_utc: String?
    let static_fire_date_unix: Int?
    let net: Bool
    let window: Int
    let rocket: String
    let success: Bool
    let details: String?
    let payloads: [String]
    let launchpad: String
    let flight_number: Int
    let name, date_utc: String
    let date_unix: Int
    let date_local: String
    let date_precision: String
    let upcoming: Bool
    let auto_update, tbd: Bool
    let id: String

}

struct Links: Codable {
    let patch: Patch
    let flickr: Flickr
    let webcast: String
    let article: String
    let wikipedia: String
}

struct Flickr: Codable {
    let small, original: [String]
}

struct Patch: Codable {
    let small, large: String
}
