@isTest
public class EventUtilityTest {
	@isTest
    public static void testEventStatusLength(){
        String res = EventUtility.eventPriority('IND');
        System.assertEquals(null, res); 
    }
    @isTest
    public static void testHightPri(){
        String res = EventUtility.eventPriority('CA');
        System.assertEquals('High', res);  
    }
    @isTest
    public static void testMediumPri(){
        String res = EventUtility.eventPriority('NA');
        System.assertEquals('Medium', res);  
    }
}