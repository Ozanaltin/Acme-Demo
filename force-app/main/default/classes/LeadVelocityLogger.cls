public class LeadVelocityLogger {
    /**
     * Logs lead Status changes into the Lead Status History custom object.
     * @param leads List of Lead records being processed.
     */
    public static void logLeadStatusChanges(List<Lead> leads) {
        List<Lead_Status_History__c> StatusHistoryRecords = new List<Lead_Status_History__c>();
        
        for (Lead lead : leads) {
            // Ensure Trigger.oldMap has a corresponding old record for the current lead
            if (Trigger.isUpdate && Trigger.oldMap.containsKey(lead.Id)) {
                // Cast the SObject returned by Trigger.oldMap.get() to a Lead object
                Lead oldLead = (Lead) Trigger.oldMap.get(lead.Id);

                // Check if the Status field has changed
                if (lead.Status != oldLead.Status) {
                    // Create a new Lead Status History record
                    Lead_Status_History__c history = new Lead_Status_History__c();
                    history.Lead__c = lead.Id; // Reference to the Lead
                    history.Status__c = lead.Status; // Current Status
                    history.Timestamp__c = System.now(); // Time of Status Change

                    StatusHistoryRecords.add(history);
                }
            }
        }

        // Insert the records into the Lead Status History object
        if (!StatusHistoryRecords.isEmpty()) {
            insert StatusHistoryRecords;
        }
    }
}
