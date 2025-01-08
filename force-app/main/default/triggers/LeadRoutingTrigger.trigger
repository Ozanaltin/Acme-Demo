trigger LeadRoutingTrigger on Lead (before insert, before update) {
    // Use the LeadRoutingHandler to process leads
    LeadRoutingHandler.routeLeads(Trigger.new);
}
