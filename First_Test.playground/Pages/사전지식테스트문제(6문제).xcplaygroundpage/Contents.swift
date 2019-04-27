//: [Previous](@previous)

/***************************************************
 "Hello, World!" 문자열을 출력하기 위한 코드 작성
 ***************************************************/
print("Hello, World")



/***************************************************
 2개의 정수를 입력 받아서 그 숫자들을 더한 뒤 결과를 정수로 반환하는 함수 작성
 ***************************************************/
func addFuntion (firstNum: Int, secondNum: Int) -> Int {
    return firstNum + secondNum
    
}
print(addFuntion(firstNum: 10, secondNum: 5))


/***************************************************
 2개의 정수를 입력 받아 그 숫자들을 곱한 뒤 결과값을 문자열로 반환하는 함수 작성
 ***************************************************/

func multiply (_ someNum1: Int, _ someNum2: Int) -> String {
    
    return String(someNum1 * someNum2)
}
print(multiply(2, 3))



/***************************************************
 주어진 숫자가 짝수인지 홀수인지 판단하는 함수 작성 (switch 문으로 해결)
 ***************************************************/

func isEven(num: Int) -> Bool {

    switch num % 2 {
    case 0:
        return true
    default:
        return false
    }
}

print(isEven(num: 4))
print(isEven(num: 7))

5.isMultiple(of: 2)  // 2의 배수 판별 swift 5 에서 도입
4.isMultiple(of: 2)







/***************************************************
 Swift 3가지 다른 반복문 방식별로 각각 1부터 10까지 값을 더한 결과를 출력하는 코드 작성
 ***************************************************/
//for in
func addSumForIn () -> Int {
    var count = 0
    for i in 1...10 {
        count += i
    }
    return count
}
print(addSumForIn())

//repeat while
func addSumWhile (max: Int) -> Int {
    var num = 1
    var sum = 0
    repeat {
        sum += num
        num += 1
    } while num <= max
    
    return sum
}

print(addSumWhile(max: 10))

//while
var num = 0
var sum = 0

while num <= 10 {
    sum += num
    num += 1
}

print(sum)


/***************************************************
 Swift 에서 사용하는 네이밍 컨벤션의 종류를 나열하고 그것이 언제 사용되는지, 그리고 그 특징에 대해 설명
 ***************************************************/

/*
 [ Pascal Case (upper camel case) ]
 - 파일명, 프로젝트명과 클래스명, 프로토콜명 같이 각 타입 이름 등에 사용
 - 첫 알파벳을 대문자로 시작하고 이후 각 단어의 첫 알파벳만을 대문자로 하여 구분
 e.g. ViewController, Int, String
 
 [ Camel Case (lower camel case) ]
 - 변수명, 메서드명, enum 의 각 케이스 네이밍 등에 사용
 - 첫 알파벳을 소문자로 시작하고 이후 각 단어의 첫 알파벳만을 대문자로 하여 구분
 e.g. viewWillAppear(), viewDidLoad()
 */


/***************************************************
 사전 지식 테스트 때 위 내용들을 푸신 분들은 거의 없다시피 했는데
 지금은 대부분 많이 쉬우시죠?
 그만큼 많이 발전하셨습니다. :)
 ***************************************************/

//: [Next](@next)
