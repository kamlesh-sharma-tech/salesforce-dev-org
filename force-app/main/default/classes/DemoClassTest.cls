@isTest
private class DemoClassTest {
    @isTest 
    static void testMultiply(){
        Test.startTest();
        Integer result = DemoClass.multiply(2,10);
        Test.stopTest();
        Assert.areEqual(20, result);
    }
    @isTest
    static void testAddTwoNum1(){
        Test.startTest();
        Integer result = DemoClass.addTwoNum('Add', 1,2);
        Test.stopTest();
        System.assertEquals(3, result);
    }
    @isTest
    static void testAddTwoNum2(){
        Test.startTest();
        Integer result = DemoClass.addTwoNum('Sub', 1,2);
        Test.stopTest();
        System.assertEquals(-1, result);
    }
}