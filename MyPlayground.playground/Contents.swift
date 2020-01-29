import UIKit

/*
 100 Days of SwiftUI
 Day 1
 */

var str = "Hello, playground"
str = "Goodbye"

var age = 38
var population = 8_000_000

var str1 = """
This goes
over multiple
lines
"""

var strs = """
This goes \
over multiple \
lines
"""

var pi = 3.141
var awesome = true

var score = 85
str = "Your score was \(score)"
var results = "The test results are here: \(str)"

let taylor = "swift"

let str3 = "Hello, playground"
let album: String = "Reputation"
let year: Int = 1989
let height: Double = 1.78
let taylorRocks: Bool = true

/*
 100 Days of SwiftUI
 Day 2
 */

let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]
beatles[1]

let colors = Set(["red", "green", "blue"])
let colors2 = Set(["red", "green", "blue", "green", "blue"])

var name = (first: "Taylor", last: "Swift")
name.0
name.first

let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")
let set = Set(["aardvark", "astronaut", "azalea"])
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]

let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]
heights["Taylor Swift"]

let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

favoriteIceCream["Paul"]
favoriteIceCream["Charlotte", default: "Unknown"]

var teams = [String: String]()
teams["Paul"] = "Red"

var results2 = [Int]()

var words = Set<String>()
var numbers = Set<Int>()

var scores = Dictionary<String, Int>()
var results3 = Array<Int>()

let result2 = "failure"
let result3 = "failed"
let result4 = "fail"

enum Result {
    case success
    case failure
}

let result5 = Result.failure

enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "football")

enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}

let earth = Planet(rawValue: 2)

/*
 100 Days of SwiftUI
 Day 1
 */

let firstScore = 12
let secondScore = 4

let total = firstScore + secondScore
let difference = firstScore - secondScore

let product = firstScore * secondScore
let divided = firstScore / secondScore
let remainder = 13 % secondScore

let meaningOfLife = 42
let doubleMeaning = 42 + 42

let fakers = "Fakers gonna "
let action = fakers + "fake"

let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles2 = firstHalf + secondHalf

var score2 = 95
score2 -= 5

var quote = "The rain in Spain falls mainly on the "
quote += "Spaniards"

let firstScore2 = 6
let secondScore2 = 4

firstScore2 == secondScore2
firstScore2 != secondScore2

firstScore2 < secondScore2
firstScore2 >= secondScore2

"Taylor" <= "Swift"


let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 2 {
    print("Aces - lucky!")
} else if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}

let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

if age1 > 18 || age2 > 18 {
    print("One of them is over 18")
}

print(firstCard == secondCard ? "Cards are the same" : "Cards are different")

if firstCard == secondCard {
    print("Cards are the same")
} else {
    print("Cards are different")
}

let weather = "sunny"

switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day!")
}

let score3 = 85

switch score3 {
case 0..<50:
    print("You failed badly.")
case 50..<85:
    print("You did OK.")
default:
    print("You did great!")
}

/*
 100 Days of SwiftUI
 Day 4
 */

let count = 1...10
for number in count {
    print("Number is \(number)")
}

let albums = ["Red", "1989", "Reputation"]

for album in albums {
    print("\(album) is on Apple Music")
}

print("Players gonna ")

for _ in 1...5 {
    print("play")
}

var number = 1

while number <= 20 {
    print(number)
    number += 1
}

print("Ready or not, here I come!")

var number2 = 1

repeat {
    print(number2)
    number2 += 1
} while number2 <= 20

print("Ready or not, here I come!")

while false {
    print("This is false")
}

repeat {
    print("This is false")
} while false

var countDown = 10

while countDown >= 0 {
    print(countDown)
    
    if countDown == 4 {
        print("I'm bored. Let's go now!")
        break
    }
    
    countDown -= 1
}

print("Blast off!")

outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print("\(i) * \(j) is \(product)")
        
        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}

for i in 1...10 {
    if i % 2 == 1 {
        continue
    }
    
    print(i)
}

var counter = 0

while true {
    print(" ")
    counter += 1
    
    if counter == 273 {
        break
    }
}

/*
 100 Days of SwiftUI
 Day 5
 */

func printHelp() {
    let message = """
    Welcome to MyApp!

    Run this app inside a directory of images and
    MyApp will resize them all into thumbnails
    """
    
    print(message)
}

printHelp()

print("Hello, world!")

func square(number: Int) {
    print(number * number)
}

square(number: 8)

func squareWithResult(number: Int) -> Int {
    return number * number
}

let result = squareWithResult(number: 8)
print(result)

func sayHello(to name: String) {
    print("Hello, \(name)!")
}

sayHello(to: "Taylor")

func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}

greet("Taylor")
greet("Taylor", nicely: false)

print("Haters", "gonna", "hate")

func variaticSquare(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}

variaticSquare(numbers: 1, 2, 3, 4, 5)

enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum)

/*
 100 Days of SwiftUI
 Day 6
 */

let driving = {
    print("I'm driving a car")
}

driving()

let driving2 = { (place: String) in
    print("I'm going to \(place) in my car")
}

driving2("London")

let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

let message = drivingWithReturn("London")
print(message)

func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel(action: driving)

travel {
    print("I'm driving in my car")
}

/*
 100 Days of SwiftUI
 Day 7
 */

func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

travel { (place: String) in
    print("I'm going to \(place) in my car")
}

func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

travel { place in
    "I'm going to \(place) in my car"
}

travel {
    "I'm going to \($0) in my car"
}

func travel(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}

travel {
    "I'm going to \($0) at \($1) miles per hour"
}

func travel() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

let result6 = travel()
result6("London")

let result7 = travel()("London")

func travel2() -> (String) -> Void {
    var counter = 1
    
    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}

let result8 = travel2()
result8("London")
result8("London")
result8("London")

/*
 100 Days of SwiftUI
 Day 8
 */

struct Sport {
    var name: String
}

var tennis = Sport(name: "Tennis")
print(tennis.name)

tennis.name = "Lawn tennis"

struct Sport2 {
    var name: String
    var isOlympicSport: Bool
    
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

let chessBoxing = Sport2(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)

struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100

struct City {
    var population: Int
    
    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
london.collectTaxes()

struct Person {
    var name: String
    
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()

let string = "Do or do not, there is no try."

print(string.count)
print(string.hasPrefix("Do"))
print(string.uppercased())
print(string.sorted())

var toys = ["Woody"]

print(toys.count)

toys.append("Buzz")

toys.firstIndex(of: "Buzz")

print(toys.sorted())

toys.remove(at: 0)

/*
 100 Days of SwiftUI
 Day 9
 */

struct User {
    var username: String
    
    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}

var user = User()
user.username = "twostraws"

struct Person2 {
    var name: String
    
    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}

struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct Person3 {
    var name: String
    lazy var familyTree = FamilyTree()
    
    init(name: String) {
        self.name = name
    }
}

var ed = Person3(name: "Ed")
ed.familyTree

struct Student {
    static var classSize = 0
    var name: String
    
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

let ed2 = Student(name: "Ed")
let taylor2 = Student(name: "Taylor")
print(Student.classSize)

struct Person4 {
    private var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
        return "My social security number is \(id)"
    }
}

let ed3 = Person4(id: "12345")

/*
 100 Days of SwiftUI
 Day 10
 */

class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

let poppy = Dog(name: "Poppy", breed: "Poodle")

class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}

class Dog2 {
    func makeNoise() {
        print("Woof!")
    }
}

class Poodle2: Dog2 {
    override func makeNoise() {
        print("Yip!")
    }
}

let poppy2 = Poodle2()
poppy2.makeNoise()

final class Dog3 {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

class Singer {
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)

var singerCopy = singer
singerCopy.name = "Justin Bieber"

print(singer.name)

class Person5 {
    var name = "John Doe"
    
    init() {
        print("\(name) is alive!")
    }
    
    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    
    deinit {
        print("\(name) is no more!")
    }
}

for _ in 1...3 {
    let person = Person5()
    person.printGreeting()
}


class Singer2 {
    let name = "Taylor Swift"
}

let taylor3 = Singer2()
print(taylor3.name)

/*
 100 Days of SwiftUI
 Day 11
 */

protocol Identifiable2 {
    var id: String { get set }
    func identify()
}

extension Identifiable2 {
    func identify() {
        print("My ID is \(id).")
    }
}

struct User2: Identifiable2 {
    var id: String
}

func displayID(thing: Identifiable2) {
    print("My ID is \(thing.id)")
}

protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

protocol Employee: Payable, NeedsTraining, HasVacation { }

extension Int {
    func squared() -> Int {
        return self * self
    }
}

let number3 = 8
number3.squared()

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

let pythons2 = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles3 = Set(["John", "Paul", "George", "Ringo"])

extension Collection {
    func summarize() {
        print("There are \(count) of us:")
        
        for name in self {
            print(name)
        }
    }
}

pythons2.summarize()
beatles3.summarize()

let twostraws = User2(id: "twostraws")
twostraws.identify()

/*
 100 Days of SwiftUI
 Day 12
 */

var age3: Int? = nil

age3 = 38

var name2: String? = nil

if let unwrapped = name2 {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}

func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }
    
    print("Hello, \(unwrapped)!")
}

let str2 = "5"
let num = Int(str2)!

let age4: Int! = nil

func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

let user2 = username(for: 15) ?? "Anonymous"

let names = ["John", "Paul", "George", "Ringo"]

let beatle = names.first?.uppercased()

if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}

try! checkPassword("sekrit")
print("OK!")

struct Person6 {
    var id: String
    
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

class Animal { }
class Fish: Animal { }

class Dog4: Animal {
    func makeNoise() {
        print("Woof!")
    }
}

let pets = [Fish(), Dog4(), Fish(), Dog4()]

for pet in pets {
    if let dog = pet as? Dog4 {
        dog.makeNoise()
    }
}

/*
 100 Days of SwiftUI
 Day 13
 */

var name3 = "Tim McGraw"
name3 = "Romeo"

let name4 = "Billy Joel"
// Error: name4 = "Mark Twain"
// Error: var name4 = "Romeo"

var name5: String
name5 = "Tim McGraw"

var age5: Int
age5 = 25

// Error: name5 = 25
// Error: age5 = "Tim McGraw"

var latitude: Double
latitude = 36.166667

var longitude: Float
longitude = -1234586.783333

var stayOutTooLate: Bool
stayOutTooLate = true

var nothingInBrain: Bool
nothingInBrain = true

var missABeat = false

var a = 10
a = a + 1
a = a - 1
a = a * a

var b = 10
b += 10
b -= 10

var a2 = 1.1
var b2 = 2.2
var c = a2 + b2

var name6 = "Romeo"
var both = name5 + " and " + name6

c > 3
c >= 3
c > 4
c < 4

name5 == "Tim McGraw"
name5 != "Tim McGraw"

stayOutTooLate
!stayOutTooLate

"Your name is \(name5)"
"Your name is " + name5

"Your name is \(name5), your age is \(age5), and your latitude is \(latitude)"

"You are \(age5) years old. In another \(age5) years you will be \(age5 * 2)."

var evenNumbers = [2, 4, 6, 8]
var songs: [Any] = ["Shake it Off", "You Belong with Me", "Back to December", 3]
songs[0]
songs[1]
songs[2]

type(of: songs)

var songs2: [String]
// Error: songs2[0] = "Shake it off"

var songs3: [String] = []
var songs4 = [String]()

var songs5 = ["Shake it Off", "You Belong with Me", "Love Story"]
var songs6 = ["Today was a Fairytale", "Welcome to New York", "Fifteen"]
var both2 = songs5 + songs6

print(both2)

both2 += ["Everything has Changed"]

var person2 = ["Taylor", "Alison", "Swift", "December", "taylorswift.com"]
person2[1]
person2[3]

var person3 = [
                "first": "Taylor",
                "middle": "Alison",
                "last": "Swift",
                "month": "December",
                "website": "taylorswift.com"
            ]

person3["middle"]
person3["month"]

var action2: String
var person4 = "hater"

if person4 == "hater" {
    action2 = "hate"
} else if person4 == "player" {
    action2 = "play"
} else {
    action2 = "cruise"
}

stayOutTooLate = true
nothingInBrain = true

if stayOutTooLate && nothingInBrain {
    action2 = "cruise"
}

if !stayOutTooLate && !nothingInBrain {
    action2 = "cruise"
}

print("1 x 10 is \(1 * 10)")
print("2 x 10 is \(2 * 10)")
print("3 x 10 is \(3 * 10)")
print("4 x 10 is \(4 * 10)")
print("5 x 10 is \(5 * 10)")
print("6 x 10 is \(6 * 10)")
print("7 x 10 is \(7 * 10)")
print("8 x 10 is \(8 * 10)")
print("9 x 10 is \(9 * 10)")
print("10 x 10 is \(10 * 10)")

for i in 1...10 {
    print("\(i) x 10 is \(i * 10)")
}

var str4 = "Fakers gonna"

for _ in 1...5 {
    str4 += " fake"
}

print(str4)

var songs7 = ["Shake it Off", "You Belong with Me", "Look What You Made Me Do"]

for song in songs7 {
    print("My favorite song is \(song)")
}

var people = ["players", "haters", "heart-breakers", "fakers"]
var actions = ["play", "hate", "break", "fake"]

for i in 0...3 {
    print("\(people[i]) gonna \(actions[i])")
}

for i in 0..<people.count {
    var str = ("\(people[i]) gonna")
    
    for _ in 1...5 {
        str += (" \(actions[i])")
    }
    
    print(str)
}

var counter2 = 0

while true {
    print("Counter is now \(counter2)")
    
    counter2 += 1
    
    if counter2 == 5 {
        break
    }
}

for song in songs7 {
    if song == "You Belong with Me" {
        continue
    }
    
    print("My favorite song is \(song)")
}

let liveAlbums = 2

switch liveAlbums {
case 0:
    print("You're just starting out")
case 1:
    print("You just released iTunes Live From SoHo")
case 2:
    print("You just released Speak Now World Tour")
default:
    print("Have you done something new?")
}

let studioAlbums = 5

switch studioAlbums {
case 0...1:
    print("You're just starting out")
case 2...3:
    print("You're a rising star")
case 4...5:
    print("You're world famous!")
default:
    print("Have you done something new?")
}

/*
 100 Days of SwiftUI
 Day 14
 */

func favoriteAlbum(name: String) {
    print("My favorite is \(name)")
}

favoriteAlbum(name: "Fearless")

func printAlbumRelease(name: String, year: Int) {
    print("\(name) was released in \(year)")
}

printAlbumRelease(name: "Fearless", year: 2008)
printAlbumRelease(name: "Speak Now", year: 2010)
printAlbumRelease(name: "Red", year: 2012)

func countLettersInString(_ str: String) {
    print("The string \(str) has \(str.count) letters.")
}

countLettersInString("Hello")

func countLetters(in string: String) {
    print("The string \(string) has \(string.count) letters.")
}

countLetters(in: "Hello")

func albumIsTaylors(name: String) -> Bool {
    if name == "Taylor Swift" {
        return true
    }
    
    if name == "Fearless" {
        return true
    }
    
    return false
}

if albumIsTaylors(name: "Taylor Swift") {
    print("That's one of hers!")
} else {
    print("Who made that?")
}

if albumIsTaylors(name: "The White Album") {
    print("That's one of hers!")
} else {
    print("Who made that?")
}

func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}

var status = getHaterStatus(weather: "rainy")

func takeHaterAction(status: String) {
    if status == "Hate" {
        print("Hating")
    }
}

if let unwrappedStatus = status {
    // ...
} else {
    // ...
}

if let hatersStatus = getHaterStatus(weather: "rainy") {
    takeHaterAction(status: hatersStatus)
}

func yearAlbumReleased(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    
    return nil
}

var items = ["James", "John", "Sally"]

func position(of string: String, in array: [String]) -> Int? {
    //return items.firstIndex(of: string)
    
    for i in 0..<items.count {
        if array[i] == string {
            return i
        }
    }
    
    return nil
}

let jamesPosition = position(of: "James", in: items)
let johnPosition = position(of: "John", in: items)
let sallyPosition = position(of: "Sally", in: items)
let bobPosition = position(of: "Bob", in: items)

var year2 = yearAlbumReleased(name: "Taylor Swift")
if year2 == nil {
    print("There was an error")
} else {
    print("It was released in \(year2!)")
}

var name7: String = "Paul"
var name8: String? = "Paul"
var name9: String! = "Sophie"

func albumReleased(year: Int) -> String? {
    switch year {
    case 2006: return "Taylor Swift"
    case 2008: return "Fearless"
    case 2010: return "Speak Now"
    case 2012: return "Red"
    case 2014: return "1989"
    default: return nil
    }
}

let album2 = albumReleased(year: 2006)?.uppercased() // .someOptionalValue?....
print("The album is \(album2)")

let str5 = "Hello world"
print(str5.uppercased())

let album3 = albumReleased(year: 2006) ?? "unknown"
print("The album is \(album3)")

enum WeatherType {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}

func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "meh"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "Hate"
    }
}

getHaterStatus(weather: .cloud)

struct Person7 {
    var clothes: String
    var shoes: String
    
    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}

let taylor4 = Person7(clothes: "T-shirts", shoes: "sneakers")
let other = Person7(clothes: "short skirts", shoes: "high heels")

print(taylor4.clothes)
print(other.shoes)

var taylorCopy = taylor4
taylorCopy.shoes = "flip flops"

print(taylor4)
print(taylorCopy)

class Person9 {
    var clothes: String
    var shoes: String
    
    init(clothes: String, shoes: String) {
        self.clothes = clothes
        self.shoes = shoes
    }
}

class Singer3 {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func sing() {
        print("La la la la")
    }
}

class CountrySinger: Singer3 {
    override func sing() {
        print("Trucks, guitars, and liquor")
    }
}

var taylor5 = CountrySinger(name: "Taylor", age: 25)
taylor5.name
taylor5.age
taylor5.sing()

class HeavyMetalSinger: Singer3 {
    var noiseLevel: Int
    
    init(name: String, age: Int, noiseLevel: Int) {
        self.noiseLevel = noiseLevel
        super.init(name: name, age: age)
    }
    
    override func sing() {
        print("Grrrr rargh rargh rarrrgh!")
    }
}

// @objc method
// @objcMethods class

/*
 100 Days of SwiftUI
 Day 15
 */

taylor4.describe()
other.describe()

func updateUI(msg: String) {
    print(msg)
}

struct Person8 {
    var clothes: String {
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }

        didSet {
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
        }
    }
}

var taylor6 = Person8(clothes: "T-shirts")
taylor6.clothes = "short skirts"

struct Person10 {
    var age: Int
    
    var ageInDogYears: Int {
        return age * 7
    }
}

var fan = Person10(age: 25)
print(fan.ageInDogYears)

struct TaylorFan {
    static var favoriteSong = "Look What You Made Me Do"
    
    var name: String
    var age: Int
}

let fan2 = TaylorFan(name: "James", age: 25)
print(TaylorFan.favoriteSong)

class TaylorFan2 {
    private var name: String?
}

class Album {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}

class StudioAlbum: Album {
    var studio: String
    
    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class LiveAlbum: Album {
    var location: String
    
    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studio")
var fearless = StudioAlbum(name: "Fearless", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

for album in allAlbums {
    print(album.getPerformance())
    
    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
}

for album in allAlbums[0...1] {
    print(album.getPerformance())
    
    let studioAlbum = album as! StudioAlbum
    print(studioAlbum.studio)
}

for album in Array(allAlbums[0...1]) as! [StudioAlbum] {
    print(album.getPerformance())
    print(album.studio)
}

for album in allAlbums as? [LiveAlbum] ?? [LiveAlbum]() {
    print(album.getPerformance())
    print(album.location)
}

let number4 = 5
let text = String(number4)
print(text)

let vw = UIView()

UIView.animate(withDuration: 0.5) {
    vw.alpha = 0
}
