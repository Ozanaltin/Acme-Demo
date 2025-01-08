trigger LeadVelocityTrigger on Lead (after update) {
    // Call the logger class to log Status changes
    LeadVelocityLogger.logLeadStatusChanges(Trigger.new);
}
