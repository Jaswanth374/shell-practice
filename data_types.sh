#!/bin/bash

Num1=100
Num2=200
Total=$(($Num1 + $Num2))
echo "Total value is :: $Total"

#Arrays
Fruits=("Apple" "Banana" "Mango")

echo "Fruits are: ${Fruits[@]}"
echo "First fruit is :: ${Fruits[0]}"
echo "Second Fruit is:: ${Fruits[1]}"
echo "Third Fruit is:: ${Fruits[2]}"