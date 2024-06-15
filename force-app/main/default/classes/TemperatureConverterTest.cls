@isTest
public class TemperatureConverterTest {
    @isTest
    public static void testFahrenheitToCelsius() {
        Decimal fahrenheit = 68; // Test input value
        
        Decimal expectedCelsius = 20; // Expected output value
        
        Decimal actualCelsius = TemperatureConverter.FahrenheitToCelsius(fahrenheit);
        
        System.assertEquals(expectedCelsius, actualCelsius);
    }
    
    @isTest
    public static void testCelsiusToFahrenheit() {
        Decimal celsius = 20; // Test input value
        
        Decimal expectedFahrenheit = 68; // Expected output value
        
        Decimal actualFahrenheit = TemperatureConverter.CelciusToFahrenheit(celsius);
        
        System.assertEquals(expectedFahrenheit, actualFahrenheit);
    }
}