CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

if [[ -e ./student-submission/ListExamples.java ]]
then
    echo "ListExamples.java found"
else
    echo "ListExamples.java not found"
    exit 1
fi

mkdir ./test-environment
cp ./student-submission/ListExamples.java ./test-environment/ListExamples.java
cp ./TestListExamples.java ./test-environment/TestListExamples.java

javac -cp $CPATH ./test-environment/*.java 2> ./test-environment/compile.txt

if [[ `cat ./test-environment/compile.txt` == "" ]]
then
    echo "Compiled successfully"
else
    echo "Compile errors"
    exit 1
fi

java -cp $CPATH org.junit.runner.JUnitCore ./test-environment/TestListExamples > ./test-environment/test-output.txt