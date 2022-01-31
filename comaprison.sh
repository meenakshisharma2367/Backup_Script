str_a="UNIX"
str_b="GNU"

echo "are $str_a and $str_b equal? "
[ $str_a = $str_b ]
echo $?

n1=100
n2=100

echo "is $n1 equal to $n2 ?"
[ $n1 -eq $n2 ]
echo $?
