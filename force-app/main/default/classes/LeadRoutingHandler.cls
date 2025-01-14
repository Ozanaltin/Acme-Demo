public class LeadRoutingHandler {
    // Queue IDs (Replace with your actual Queue IDs from Salesforce)
    private static final Id ACCOUNT_EXECUTIVE_QUEUE_ID = '00GQy00000A7CMr'; // Replace with Account Executive Queue ID
    private static final Id BDR_QUEUE_ID = '00GQy00000A7COT'; // Replace with BDR Queue ID

    /**
     * Routes leads based on their country and budget.
     * @param leads List of Lead records to process.
     */
    public static void routeLeads(List<Lead> leads) {
        for (Lead lead : leads) {
            // Check if the Country and Budget fields are populated
            if (String.isNotBlank(lead.Country) && lead.Budget__c != null) {
                if (lead.Country == 'Spain') {
                    // Assign to appropriate queue based on budget
                    if (lead.Budget__c > 50000) {
                        lead.OwnerId = ACCOUNT_EXECUTIVE_QUEUE_ID; // High-budget leads to Account Executive Queue
                    } else {
                        lead.OwnerId = BDR_QUEUE_ID; // Low-budget leads to BDR Queue
                    }
                }
                // Default behavior: Leave OwnerId unchanged for other countries
            }
        }
    }
}
