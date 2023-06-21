public class OpportunityUtils {

    public static Decimal calculateAverageOpportunityAmount() {
        Decimal averageAmount = 0;
        try {
            averageAmount = [SELECT AVG(Amount) FROM Opportunity WHERE StageName = 'Closed Won' WITH SECURITY_ENFORCED];
            
        } catch (Exception e) {
            System.debug(LoggingLevel.DEBUG, 'No cuenta con opportunidades cerradas ganadas');
        }

        return averageAmount;


    }
}