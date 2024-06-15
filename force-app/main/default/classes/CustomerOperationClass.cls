public class CustomerOperationClass {
	static final Double regularCustomerDiscount = 0.1;
    static Double finalPrice = 0;
    public static Double providedDiscount(Integer price){
        finalPrice = price - price * regularCustomerDiscount;
        return finalPrice;
    }
}