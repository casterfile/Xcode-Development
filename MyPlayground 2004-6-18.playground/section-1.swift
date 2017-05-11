"this is for none constant"
for index in 1...5
{
    println(index)
}

"this is for constant output by using '_' "
for _ in 1...5
{
    println("Hi")
}

"this is the using contant _"
let base = 3
let power = 10
var answer = 1;
for _ in 1...power
{
    answer *= base
}

answer


"this is the conventional forloop using contant"
for var i = 0; i<10; i++
{
    println(i)
}

var x:Int
for x = 0; x < 10; x++
{
    x
}

if x < 20
{
    println("yes x less than 20")
}
else
{
    println("None of the above")
}


//this is the switch statement in swift without break
switch x
{
case 8:
    println("It was 8")
case 10:
    println("It was 10")
default:
    println("it was none if the above")

}

//multiple switch statement
switch x
    {
case 7,8,9,10:
    println("It was 7,8,9")
case 11,12,13:
    println("It was 11,12,13")
default:
    println("it was none if the above")
    
}


// using new number formating
let count = 3_000_000
println(count)


//switch using range statement

switch count
    {
case 7,8,9,10:
    println("It was 7,8,9")
case 11,12,13:
    println("It was 11,12,13")
case 2_000_000..4_000_000:
    println("it between 2M and 4M")
default:
    println("it was none if the above")
    
}
//this is tuple

let somePoint = (1,1)










































