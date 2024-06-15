public class MathCalculator {
    public static Integer add(Integer n1,Integer n2){
        Integer sum = n1 + n2;
        return sum;
    }
    public static Integer multiply(Integer n1,Integer n2){
        Integer product = n1 * n2;
        return product;
    }
    public static void printOutput(){
        Integer sum = add(5,5);
        System.debug('sum '+sum);
        Integer mul = multiply(5,6);
        System.debug('mul '+mul);
    }
}