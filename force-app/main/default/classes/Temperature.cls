public class Temperature {
    public static Decimal FtoC(Decimal fh){
        Decimal result = (fh-32)*5/9;
        return result.setScale(2);
    }
}