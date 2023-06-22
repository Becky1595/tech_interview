/**
* @description       : 
* @author            : Rebeca Vazquez
* @canal             : 
* @last modified on  : 21-06-2023
* @last modified by  : Rebeca Vazquez
**/

public class OpportunityMetrics {

    /**
  * @author Rebeca Vazquez
  * @date 21/06/2023
  * @description Metodo para el calculo de opportunidades
  * @param methodName calculateOpportunityWinRatesByStage
  * @param output winRateByStage
  * @param input winRateByStage
  * @param output winRateByStage
  * @param options winRateByStage
  * @return true
  */

    public static Map<String,Decimal> calculateOpportunityWinRatesByStage () {
        Map<String,Decimal> winRateByStage = new Map<String,Decimal>();

        list<String> stageCounts = new list<string>();
        for (OpportunityStage opp : [SELECT Id,ApiName, MasterLabel, IsClosed, IsWon, DefaultProbability FROM OpportunityStage WITH SECURITY_ENFORCED]) {
            String stageName = opp.ApiName;
            stageCounts.add(stageName);
        }
    
        List<Opportunity> opps = [SELECT Id,StageName,IsWon from Opportunity WITH SECURITY_ENFORCED];
        Map<String, Integer> oppsByStage = new Map<String, Integer>();  
        Map<String, Integer> oppsWonByStage = new Map<String, Integer>();  
        for (String s : stageCounts) {
            Integer d = 0;
            Integer w = 0;
            oppsByStage.put(s, d);
            oppsWonByStage.put(s, w);
            for (Opportunity o : opps) {        
                if (o.StageName == s) {
                oppsByStage.put(s, oppsByStage.get(s)+1);
                if (o.IsWon) {
                    oppsWonByStage.put(s, oppsWonByStage.get(s)+1);
                }
                } 
            }
        }
    
        for (String s : stageCounts) {
            Integer totalOpps = oppsByStage.get(s);
            Integer wonOpps = oppsWonByStage.get(s);
            Decimal winrate = 0;
            if (totalOpps>0) {
                winrate = Decimal.valueOf(wonOpps)/Decimal.valueOf(totalOpps);
            }
            winrate = winrate.setScale(2);
            winRateByStage.put(s, winrate);
        }
    
        return winRateByStage;
    }
}