public class MySampleApexClass2 {
	public static Double myValue;
    public static String myString;
    public MySampleApexClass2(){
        myValue=100;
    }
    public static Double getCalculatedValue(){
        myValue=myValue+10;
        return myValue;
    }
    public static Double getCalculatedValueViaPrice(Decimal price){
        myValue = myValue+price;
        return myValue;
    }
}