#!/bin/bash

Num1=100
Num2=200
Total=$(($Num1 + $Num2))
echo "Total value is :: $Total"

#Arrays
Furits=("Apple" "Banana" "Mango")

echo "Fruits are: ${Fruits[@]}"
echo "First fruit is :: ${Fruits[1]}"
echo "Second Fruit is:: ${Fruit[2]}"
echo "Third Fruit is:: ${Fruit[3]}"