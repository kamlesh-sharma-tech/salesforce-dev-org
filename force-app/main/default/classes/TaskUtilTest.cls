@IsTest
public class TaskUtilTest {
    @IsTest
    public static void testGetTaskPriority() {
        // Test case 1: Valid lead state
        String leadState1 = 'CA';
        String expectedPriority1 = 'High';
        String actualPriority1 = TaskUtil.getTaskPriority(leadState1);
        System.assertEquals(expectedPriority1, actualPriority1, 'Expected priority should be High');

        // Test case 2: Invalid lead state
        String leadState2 = 'BA';
        String expectedPriority2 = 'Normal';
        String actualPriority2 = TaskUtil.getTaskPriority(leadState2);
        System.assertEquals(expectedPriority2, actualPriority2, 'Expected priority should be Normal');

        // Test case 3: Blank lead state
        String leadState3 = '';
        String expectedPriority3 = null;
        String actualPriority3 = TaskUtil.getTaskPriority(leadState3);
        System.assertEquals(expectedPriority3, actualPriority3, 'Expected priority should be null');

        // Test case 4: Long lead state
        String leadState4 = 'ABC';
        String expectedPriority4 = null;
        String actualPriority4 = TaskUtil.getTaskPriority(leadState4);
        System.assertEquals(expectedPriority4, actualPriority4, 'Expected priority should be null');
    }
}