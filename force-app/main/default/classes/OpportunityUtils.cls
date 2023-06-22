/**
* @description       : 
* @author            : Rebeca Vazquez
* @canal             : 
* @last modified on  : 21-06-2023
* @last modified by  : Rebeca Vazquez
**/
public class OpportunityUtils {
    /**
  * @author Rebeca Vazquez
  * @date 21/06/2023
  * @description Metodo para el calculo de opportunidades
  * @param methodName calculateAverageOpportunityAmount
  * @param averageAmount description
  * @return true
  */

    public static Decimal calculateAverageOpportunityAmount() {
        Decimal averageAmount = 0;
        try {
            averageAmount = [SELECT AVG(Amount) FROM Opportunity WHERE StageName = 'Closed Won' WITH SECURITY_ENFORCED];
            
        } catch (Exception e) {
            System.debug(LoggingLevel.DEBUG, 'No se encontraron opportunidades cerradas ganadas');
        }

        return averageAmount;


    }
}