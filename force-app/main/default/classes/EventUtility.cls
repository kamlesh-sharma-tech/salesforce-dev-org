public class EventUtility {
    public static String eventPriority(String eventStatus){
        String eventPri;
        if(String.isBlank(eventStatus) || eventStatus.length() > 2){
            return null;
        }
        if(eventStatus == 'CA'){
            eventPri = 'High';
        }else{
            eventPri = 'Medium';
        }
        return eventPri;
    }
}