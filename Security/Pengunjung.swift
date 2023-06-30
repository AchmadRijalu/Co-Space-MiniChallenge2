//
//  Pengunjung.swift
//  Security
//
//  Created by Billy Agustian Dharmawan on 22/06/23.
//

import Foundation

struct Pengunjung {
    var nama: String?
    var kesabaranSecurity: Int?
    var ImageName: String?
}

class GuestDictionary {
    var guestList:[Pengunjung]=[]
    init() {
        guestList = [
            Pengunjung(nama:"Pengunjung1",kesabaranSecurity: 7,ImageName: "guest-1"),
            Pengunjung(nama:"Pengunjung2",kesabaranSecurity: 8,ImageName: "guest-2"),
            Pengunjung(nama:"Pengunjung3",kesabaranSecurity: 12,ImageName: "guest-3"),
            Pengunjung(nama:"Pengunjung4",kesabaranSecurity: 8,ImageName: "guest-4"),
            Pengunjung(nama:"Pengunjung5",kesabaranSecurity: 9,ImageName: "guest-5"),
            Pengunjung(nama:"Pengunjung6",kesabaranSecurity: 10,ImageName: "guest-6"),
            Pengunjung(nama:"Pengunjung7",kesabaranSecurity: 11,ImageName: "guest-7"),
            Pengunjung(nama:"Pengunjung8",kesabaranSecurity: 10,ImageName: "guest-8"),
        ]
    }
}
