//
//  MarketDataModel.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 2/2/23.
//

import Foundation

//JSON Data
/*
 URL: https://api.coingecko.com/api/v3/global
 
 Rexponse:
 {
   "data": {
     "active_cryptocurrencies": 12360,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 650,
     "total_market_cap": {
       "btc": 47386619.725845404,
       "eth": 674914713.9070696,
       "ltc": 11244687243.12258,
       "bch": 8169644652.278648,
       "bnb": 3423921780.9890766,
       "eos": 1041384365767.5859,
       "xrp": 2718984092199.667,
       "xlm": 12124664757903.232,
       "link": 155032206541.18738,
       "dot": 172232530995.0893,
       "yfi": 146078628.90875268,
       "usd": 1129148807866.8564,
       "aed": 4147380508527.0806,
       "ars": 211466286406746.06,
       "aud": 1584347083377.4507,
       "bdt": 119776312727670.38,
       "bhd": 425712812690.7698,
       "bmd": 1129148807866.8564,
       "brl": 5708073053528.5205,
       "cad": 1500305666756.7314,
       "chf": 1026004451714.6431,
       "clp": 888131994827677,
       "cny": 7591606179931.215,
       "czk": 24418068799882.32,
       "dkk": 7640622529680.717,
       "eur": 1027041010320.2637,
       "gbp": 915408842579.3169,
       "hkd": 8857319890365.568,
       "huf": 398508244012619.4,
       "idr": 16830057845563438,
       "ils": 3860616231537.175,
       "inr": 92839186332109.66,
       "jpy": 145569017448589.16,
       "krw": 1380877496576949.5,
       "kwd": 344224401524.63446,
       "lkr": 413234130780616.94,
       "mmk": 2371026323594103,
       "mxn": 20931131945671.812,
       "myr": 4794365838202.675,
       "ngn": 519995608998846.4,
       "nok": 11231995486279.658,
       "nzd": 1732517377392.1658,
       "php": 60806922730394.836,
       "pkr": 300149267932395.1,
       "pln": 4835237637601.024,
       "rub": 79000908763041.33,
       "sar": 4237477550204.392,
       "sek": 11658935683724.582,
       "sgd": 1475024024948.5898,
       "thb": 37033137207090.766,
       "try": 21246628543226.676,
       "twd": 33578401418582.96,
       "uah": 41700233295712.33,
       "vef": 113061670131.70808,
       "vnd": 26477871342441990,
       "zar": 19291563839845.62,
       "xdr": 837355302086.7129,
       "xag": 46481376801.3749,
       "xau": 577198287.6053776,
       "bits": 47386619725845.41,
       "sats": 4738661972584540
     },
     "total_volume": {
       "btc": 3704200.551127678,
       "eth": 52757919.21184866,
       "ltc": 878994469.8358608,
       "bch": 638619137.6082157,
       "bnb": 267647133.75916004,
       "eos": 81404762861.95406,
       "xrp": 212542325895.00687,
       "xlm": 947782098370.8546,
       "link": 12118829919.391575,
       "dot": 13463375103.039019,
       "yfi": 11418930.931185419,
       "usd": 88265287977.99684,
       "aed": 324199726722.50195,
       "ars": 16530268231510.1,
       "aud": 123848026581.71837,
       "bdt": 9362885265603.576,
       "bhd": 33277867138.75232,
       "bmd": 88265287977.99684,
       "brl": 446198683786.3686,
       "cad": 117278529462.80428,
       "chf": 80202518717.07079,
       "clp": 69425062259093.5,
       "cny": 593434010662.4645,
       "czk": 1908754505581.7754,
       "dkk": 597265606813.5895,
       "eur": 80283546251.4345,
       "gbp": 71557286820.77798,
       "hkd": 692374543894.9633,
       "huf": 31151292614681.902,
       "idr": 1315601532831946.8,
       "ils": 301783432861.17004,
       "inr": 7257216639786.611,
       "jpy": 11379094727157.361,
       "krw": 107942858415585.98,
       "kwd": 26907937835.95624,
       "lkr": 32302411605600.543,
       "mmk": 185342551661376.6,
       "mxn": 1636181498858.7568,
       "myr": 374774412754.57477,
       "ngn": 40647930419627.234,
       "nok": 878002358286.9823,
       "nzd": 135430462466.05525,
       "php": 4753262376456.379,
       "pkr": 23462595351348.66,
       "pln": 377969351383.51373,
       "rub": 6175481844298.703,
       "sar": 331242590580.8422,
       "sek": 911376169793.767,
       "sgd": 115302269664.97673,
       "thb": 2894871338072.536,
       "try": 1660843791237.9753,
       "twd": 2624815480832.071,
       "uah": 3259697105423.2456,
       "vef": 8838003285.236803,
       "vnd": 2069768769893231.2,
       "zar": 1508016858368.4736,
       "xdr": 65455860524.011,
       "xag": 3633437931.6556,
       "xau": 45119449.908592254,
       "bits": 3704200551127.6777,
       "sats": 370420055112767.75
     },
     "market_cap_percentage": {
       "btc": 40.68545532798297,
       "eth": 17.856270707796103,
       "usdt": 6.008247727154531,
       "bnb": 3.9396770698554358,
       "usdc": 3.748333016503685,
       "xrp": 1.8684951879100993,
       "busd": 1.427323502817133,
       "ada": 1.2559560434242412,
       "doge": 1.153679558491696,
       "matic": 0.9791632810056328
     },
     "market_cap_change_percentage_24h_usd": 4.589924823639983,
     "updated_at": 1675333147
   }
 }

 */

// used https://app.quicktype.io/

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
//        if let item = totalMarketCap.first(where: { key, value in
//            return key == "usd"
//        }) {
//            return "\(item.value)"
//        }
        
        if let item = totalMarketCap.first(where: { $0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
}
