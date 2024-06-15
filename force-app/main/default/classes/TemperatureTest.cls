@isTest
public class TemperatureTest {
	@isTest
    public static void warmTempTest(){
        Decimal res = Temperature.FtoC(70);
        System.assertEquals(21.11, res);
    }
    @isTest
    public static void coldTempTest(){
        Decimal res = Temperature.FtoC(30);
        System.assertEquals(-1.11,res);
    }
}