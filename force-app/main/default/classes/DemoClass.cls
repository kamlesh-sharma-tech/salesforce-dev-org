public class DemoClass {
    @TestVisible private static Integer multiply(Integer num1, Integer num2){
        return num1 * num2;
    }
    public static Integer addTwoNum(String operator, Integer num1, Integer num2){
        if(operator == 'Add'){
            return num1 + num2;
        }
        else{
            return num1 - num2;
        }
    }
}