//
//  DownloadResponseData.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 11/9/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//



import Foundation

                
        
                
                struct DownloadResponseData: Codable {
                    let name: String
                    let uri: String
                    let categories: [String]?
                    let contentRating: [String]?
                    let contentRatingClass: String
                    let createdTime: String
                    let description: String
                    let downloads: [Download]
                    let duration: Int
                    let embed: Embed
                }

                // Define the download model
                struct Download: Codable {
                    let createdTime: String
                    let expires: String
                    let fps: Int
                    let height: Int
                    let link: String
                    let md5: String?
                    let publicName: String
                    let quality: String
                    let rendition: String
                    let size: Int
                    let sizeShort: String
                    let type: String
                    let width: Int
                    
                    enum CodingKeys: String, CodingKey {
                        case createdTime = "created_time"
                        case expires
                        case fps
                        case height
                        case link
                        case md5
                        case publicName = "public_name"
                        case quality
                        case rendition
                        case size
                        case sizeShort = "size_short"
                        case type
                        case width
                    }
                }

                // Define the embed model
                struct Embed: Codable {
                    let airplay: Int
                    let askAi: Int
                    let audioTracks: Int
                    let autopip: Int
                    let badges: Badges
                    let buttons: Buttons
                    let cards: [String]?
                    let chapters: Int
                    let chromecast: Int
                    let closedCaptions: Int
                    let color: String
                    let colors: Colors
                    let emailCaptureForm: String?
                    let endScreen: EndScreen
                    
                    enum CodingKeys: String, CodingKey {
                        case airplay
                        case askAi = "ask_ai"
                        case audioTracks = "audio_tracks"
                        case autopip
                        case badges
                        case buttons
                        case cards
                        case chapters
                        case chromecast
                        case closedCaptions = "closed_captions"
                        case color
                        case colors
                        case emailCaptureForm = "email_capture_form"
                        case endScreen = "end_screen"
                    }
                }

                // Define the badges model
                struct Badges: Codable {
                    let hdr: Int
                    let live: Live
                    let staffPick: StaffPick
                    let vod: Int
                    let weekendChallenge: Int
                    
                    enum CodingKeys: String, CodingKey {
                        case hdr
                        case live
                        case staffPick = "staff_pick"
                        case vod
                        case weekendChallenge = "weekend_challenge"
                    }
                }

                // Define the live model
                struct Live: Codable {
                    let archived: Int
                    let streaming: Int
                }

                // Define the staff pick model
                struct StaffPick: Codable {
                    let bestOfTheMonth: Int
                    let bestOfTheYear: Int
                    let normal: Int
                    let premiere: Int
                    
                    enum CodingKeys: String, CodingKey {
                        case bestOfTheMonth = "best_of_the_month"
                        case bestOfTheYear = "best_of_the_year"
                        case normal
                        case premiere
                    }
                }

                // Define the buttons model
                struct Buttons: Codable {
                    let embed: Int
                    let fullscreen: Int
                    let hd: Int
                    let like: Int
                    let scaling: Int
                    let share: Int
                    let watchLater: Int
                    
                    enum CodingKeys: String, CodingKey {
                        case embed
                        case fullscreen
                        case hd
                        case like
                        case scaling
                        case share
                        case watchLater = "watchlater"
                    }
                }

                // Define the colors model
                struct Colors: Codable {
                    let colorOne: String
                    let colorTwo: String
                    let colorThree: String
                    let colorFour: String
                    
                    enum CodingKeys: String, CodingKey {
                        case colorOne = "color_one"
                        case colorTwo = "color_two"
                        case colorThree = "color_three"
                        case colorFour = "color_four"
                    }
                }

                // Define the end screen model
                struct EndScreen: Codable {
                    let type: String
                }
