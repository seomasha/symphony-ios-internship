//
//  FlightList.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 3. 9. 2024..
//

import Foundation

struct FlightList {
    var flights: [FlightModel] = [
        FlightModel(town: "Mostar",
                    airportCode: "MST",
                    airportFullName: "Mostar International Airport",
                    possibleAirports: ["MUC", "IST"],
                    latitude: 43.2901,
                    longitude: 17.8362),
        
        FlightModel(town: "Sarajevo",
                    airportCode: "SJJ",
                    airportFullName: "Sarajevo International Airport",
                    possibleAirports: ["LGA", "IST"],
                    latitude: 43.8262,
                    longitude: 18.3368),
        
        FlightModel(town: "New York",
                    airportCode: "LGA",
                    airportFullName: "LaGuardia Airport",
                    possibleAirports: ["SJJ", "MST", "ZRH", "LOS", "FCO", "MUC"],
                    latitude: 40.7766,
                    longitude: -73.8742),
        
        FlightModel(town: "Istanbul",
                    airportCode: "IST",
                    airportFullName: "Istanbul Airport",
                    possibleAirports: ["SJJ", "MST"],
                    latitude: 41.2768,
                    longitude: 28.7301),
        
        FlightModel(town: "Munchen",
                    airportCode: "MUC",
                    airportFullName: "Munich International Airport",
                    possibleAirports: ["LGA", "IST", "SJJ", "MST"],
                    latitude: 48.3540,
                    longitude: 11.7884),
        
        FlightModel(town: "Zurich",
                    airportCode: "ZRH",
                    airportFullName: "Zurich Airport",
                    possibleAirports: ["SJJ", "LGA", "MUC"],
                    latitude: 47.4597,
                    longitude: 8.5510),
        
        FlightModel(town: "Lagos",
                    airportCode: "LOS",
                    airportFullName: "Murtala Muhammed International Airport",
                    possibleAirports: ["ZRH"],
                    latitude: 6.5790,
                    longitude: 6.5790),
        
        FlightModel(town: "Rome",
                    airportCode: "FCO",
                    airportFullName: "Leonardo da Vinci–Fiumicino Airport",
                    possibleAirports: ["MUC", "LGA", "ZRH", "SJJ"],
                    latitude: 41.8035,
                    longitude: 12.2519)
    ]
    
    var flightOffers: [FlightOfferModel] = [
        FlightOfferModel(departureCode: "MST",
                         departureTown: "Mostar",
                         arrivalCode: "IST",
                         arrivalTown: "Istanbul",
                         flightDuration: "12:45",
                         time: "09:30 AM",
                         date: Date(),
                         airCompany: "Qatar Airways",
                         price: 250,
                         url: "https://lh3.googleusercontent.com/p/AF1QipNbAq0AF2I5K4t5jlZSQkQXEi30iav_2eMqLewH=s1360-w1360-h1020"),
        
        FlightOfferModel(departureCode: "SJJ",
                         departureTown: "Sarajevo",
                         arrivalCode: "IST",
                         arrivalTown: "Istanbul",
                         flightDuration: "2:15",
                         time: "01:20 PM",
                         date: Date(),
                         airCompany: "Turkish Airlines",
                         price: 190,
                         url: "https://lh3.googleusercontent.com/p/AF1QipNc4RBeiZed0bYR6KrI0QOk7vV8QJxZYI8CkIYX=s1360-w1360-h1020"),
        
        FlightOfferModel(departureCode: "MUC",
                         departureTown: "Munchen",
                         arrivalCode: "SJJ",
                         arrivalTown: "Sarajevo",
                         flightDuration: "1:50",
                         time: "10:00 AM",
                         date: Date(),
                         airCompany: "Lufthansa",
                         price: 220,
                         url: "https://lh3.googleusercontent.com/p/AF1QipN9hsZG34HwFFoUEK1lxWJFLKFA3EAG55TzAj8t=s1360-w1360-h1020"),
        
        FlightOfferModel(departureCode: "LGA",
                         departureTown: "New York",
                         arrivalCode: "ZRH",
                         arrivalTown: "Zurich",
                         flightDuration: "8:30",
                         time: "07:00 AM",
                         date: Date(),
                         airCompany: "Ryanair",
                         price: 350,
                         url: "https://lh3.googleusercontent.com/p/AF1QipN-8QSrnaOiXeBrQdliJkXm50s_2fu5wh_YicOY=s1360-w1360-h1020"),
        
        FlightOfferModel(departureCode: "LGA",
                         departureTown: "New York",
                         arrivalCode: "ZRH",
                         arrivalTown: "Zurich",
                         flightDuration: "8:30",
                         time: "07:00 AM",
                         date: Date(),
                         airCompany: "Swiss Air",
                         price: 450,
                         url: "https://lh3.googleusercontent.com/p/AF1QipN-8QSrnaOiXeBrQdliJkXm50s_2fu5wh_YicOY=s1360-w1360-h1020"),
        
        FlightOfferModel(departureCode: "FCO",
                         departureTown: "Rome",
                         arrivalCode: "LGA",
                         arrivalTown: "New York",
                         flightDuration: "9:15",
                         time: "11:00 AM",
                         date: Date(),
                         airCompany: "Alitalia",
                         price: 380,
                         url: "https://lh3.googleusercontent.com/p/AF1QipOvNpjnSbLyBGlG9Xzp4m4K-pjh-hy3ihWwNTYG=s1360-w1360-h1020"),
        
        FlightOfferModel(departureCode: "MUC",
                         departureTown: "Munchen",
                         arrivalCode: "IST",
                         arrivalTown: "Istanbul",
                         flightDuration: "2:00",
                         time: "06:00 AM",
                         date: Date(),
                         airCompany: "Turkish Airlines",
                         price: 200,
                         url: "https://lh3.googleusercontent.com/p/AF1QipN9hsZG34HwFFoUEK1lxWJFLKFA3EAG55TzAj8t=s1360-w1360-h1020"),
        
        FlightOfferModel(departureCode: "MUC",
                         departureTown: "Munchen",
                         arrivalCode: "IST",
                         arrivalTown: "Istanbul",
                         flightDuration: "2:10",
                         time: "09:00 AM",
                         date: Date(),
                         airCompany: "Lufthansa",
                         price: 230,
                         url: "https://lh3.googleusercontent.com/p/AF1QipN9hsZG34HwFFoUEK1lxWJFLKFA3EAG55TzAj8t=s1360-w1360-h1020"),
        
        FlightOfferModel(departureCode: "ZRH",
                         departureTown: "Zurich",
                         arrivalCode: "SJJ",
                         arrivalTown: "Sarajevo",
                         flightDuration: "2:00",
                         time: "08:00 AM",
                         date: Date(),
                         airCompany: "Swiss Air",
                         price: 210,
                         url: "https://lh3.googleusercontent.com/p/AF1QipMGyj1RKqaGf7JkgI59c7bYF4ny9nSPAZ1kRoMe=s1360-w1360-h1020"),
        
        FlightOfferModel(departureCode: "ZRH",
                         departureTown: "Zurich",
                         arrivalCode: "LGA",
                         arrivalTown: "New York",
                         flightDuration: "8:45",
                         time: "05:00 AM",
                         date: Date(),
                         airCompany: "Swiss Air",
                         price: 400,
                         url: "https://lh3.googleusercontent.com/p/AF1QipMGyj1RKqaGf7JkgI59c7bYF4ny9nSPAZ1kRoMe=s1360-w1360-h1020"),
        
        FlightOfferModel(departureCode: "LGA",
                         departureTown: "New York",
                         arrivalCode: "FCO",
                         arrivalTown: "Rome",
                         flightDuration: "9:00",
                         time: "10:00 PM",
                         date: Date(),
                         airCompany: "Alitalia",
                         price: 360,
                         url: "https://lh3.googleusercontent.com/p/AF1QipN-8QSrnaOiXeBrQdliJkXm50s_2fu5wh_YicOY=s1360-w1360-h1020"),
        
        FlightOfferModel(departureCode: "LGA",
                         departureTown: "New York",
                         arrivalCode: "FCO",
                         arrivalTown: "Rome",
                         flightDuration: "9:30",
                         time: "02:00 PM",
                         date: Date(),
                         airCompany: "Delta Airlines",
                         price: 400,
                         url: "https://lh3.googleusercontent.com/p/AF1QipN-8QSrnaOiXeBrQdliJkXm50s_2fu5wh_YicOY=s1360-w1360-h1020"),
        
        FlightOfferModel(departureCode: "SJJ",
                         departureTown: "Sarajevo",
                         arrivalCode: "ZRH",
                         arrivalTown: "Zurich",
                         flightDuration: "1:45",
                         time: "04:00 PM",
                         date: Date(),
                         airCompany: "Lufthansa",
                         price: 180,
                         url: "https://lh3.googleusercontent.com/p/AF1QipNc4RBeiZed0bYR6KrI0QOk7vV8QJxZYI8CkIYX=s1360-w1360-h1020"),
        
        FlightOfferModel(departureCode: "FCO",
                         departureTown: "Rome",
                         arrivalCode: "ZRH",
                         arrivalTown: "Zurich",
                         flightDuration: "1:20",
                         time: "06:00 AM",
                         date: Date(),
                         airCompany: "Swiss Air",
                         price: 170,
                         url: "https://lh3.googleusercontent.com/p/AF1QipOvNpjnSbLyBGlG9Xzp4m4K-pjh-hy3ihWwNTYG=s1360-w1360-h1020"),
        
        FlightOfferModel(departureCode: "MUC",
                         departureTown: "Munchen",
                         arrivalCode: "LGA",
                         arrivalTown: "New York",
                         flightDuration: "8:55",
                         time: "11:00 AM",
                         date: Date(),
                         airCompany: "Lufthansa",
                         price: 450,
                         url: "https://lh3.googleusercontent.com/p/AF1QipN9hsZG34HwFFoUEK1lxWJFLKFA3EAG55TzAj8t=s1360-w1360-h1020"),
        
        FlightOfferModel(departureCode: "LOS",
                         departureTown: "Lagos",
                         arrivalCode: "ZRH",
                         arrivalTown: "Zurich",
                         flightDuration: "7:30",
                         time: "08:00 AM",
                         date: Date(),
                         airCompany: "Swiss Air",
                         price: 500,
                         url: "https://lh3.googleusercontent.com/p/AF1QipMl9FKMRlJqBWrx4LCOxxKp54s3DsYeUcJ7rArV=s1360-w1360-h1020"),
        
        FlightOfferModel(departureCode: "LOS",
                         departureTown: "Lagos",
                         arrivalCode: "ZRH",
                         arrivalTown: "Zurich",
                         flightDuration: "7:45",
                         time: "06:00 PM",
                         date: Date(),
                         airCompany: "Ryanair",
                         price: 470,
                         url: "https://lh3.googleusercontent.com/p/AF1QipMl9FKMRlJqBWrx4LCOxxKp54s3DsYeUcJ7rArV=s1360-w1360-h1020"),
        
        FlightOfferModel(departureCode: "IST",
                         departureTown: "Istanbul",
                         arrivalCode: "SJJ",
                         arrivalTown: "Sarajevo",
                         flightDuration: "7:45",
                         time: "06:00 PM",
                         date: Date(),
                         airCompany: "Ryanair",
                         price: 470,
                         url: "https://lh3.googleusercontent.com/p/AF1QipPQXQ2wjVuzKhAQd1TvwndrYBgWyng84NzuJtdW=s1360-w1360-h1020")
    ]
}
