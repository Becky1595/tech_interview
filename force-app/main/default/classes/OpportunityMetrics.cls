public class OpportunityMetrics {

    public static Map<String,Decimal> calculateOpportunityWinRatesByStage () {
        Map<String,Decimal> winRateByStage = new Map<String,Decimal>();

        List<Opportunity> listOpp =  [SELECT StageName FROM Opportunity  WITH SECURITY_ENFORCED];
        Map<String, Integer> stageCounts = new Map<String, Integer>();
        for (Opportunity opp : listOpp) {
            String stageName = opp.StageName;
            if (!stageCounts.containsKey(stageName)) {
                stageCounts.put(stageName, 0);
            }
            stageCounts.put(stageName, stageCounts.get(stageName) + 1);
        }

        Map<String, Integer> wonCounts = new Map<String, Integer>();
        List<Opportunity> listOppWon = [SELECT StageName, COUNT(Id) FROM Opportunity WHERE IsWon = true  WITH SECURITY_ENFORCED GROUP BY StageName];
        for (AggregateResult result : listOppWon) {
            String stageName = (String) result.get('StageName');
            Integer count = (Integer) result.get('expr0');
            wonCounts.put(stageName, count);
        }

        for (String stageName : stageCounts.keySet()) {
            Integer totalOpportunities = stageCounts.get(stageName);
            Integer wonOpportunities = wonCounts.containsKey(stageName) ? wonCounts.get(stageName) : 0;

            Decimal winRate = totalOpportunities > 0 ? Decimal.valueOf(wonOpportunities) / Decimal.valueOf(totalOpportunities) : 0;
            winRate = winRate.setScale(2);

            winRateByStage.put(stageName, winRate);
        }

        return winRateByStage;
    }
}