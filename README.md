
# Salesforce Project: Lead Routing and Velocity Tracking

## **Table of Contents**

1. [Overview](#overview)
2. [Key Features](#key-features)
3. [Implementation Details](#implementation-details)
4. [Reports](#reports)
5. [Dashboards](#dashboards)
6. [Conclusion](#conclusion)

---

## **Overview**

This project provides an end-to-end solution for managing lead routing and tracking lead velocity within Salesforce. By leveraging Salesforce Flows, Apex Code, and custom objects, the system ensures accurate lead distribution and detailed pipeline performance insights.

**Presentation**: [Watch the Loom Presentation](https://www.loom.com/share/55864cb2a5dc487aa708e5862679b183?sid=70353eff-9013-4a94-9529-3840f0f6379c)

---

## **Key Features**

1. **Automated Lead Routing**

   - Assign leads to specific queues based on country and budget criteria.
   - Supports dynamic toggling between Apex and Salesforce Flow solutions.

2. **Lead Velocity Tracking**

   - Monitor the time leads spend in each stage using the `Days in Status` formula field.
   - Maintain detailed records in the custom `Lead Status History` object.

3. **Detailed Reports and Dashboards**

   - Gain insights into lead distribution and pipeline performance through customizable reports and dashboards.

---

## **Implementation Details**

### **1. Custom Object: Lead Status History**

- **Purpose**: Stores data about lead status changes.
- **Fields**:
  - **Lead** (Lookup → Lead)
  - **Status** (Picklist)
  - **Timestamp** (Date/Time)
  - **Days in Status** (Formula Field)
```apex
ROUND(DATEVALUE(NOW()) - DATEVALUE(Timestamp__c), 2)
```
- **Screenshot**:
  ![Lead Status History and Fields](Screenshots/Lead%20Status%20History%20and%20Fields.png)

---

### **2. Lead Routing Flow**

**Purpose**: Routes leads based on country and budget criteria.

**Logic**:

- Leads with `Country = Spain` and `Budget > 50,000` → **Account Executive Queue**.
- Leads with `Country = Spain` and `Budget <= 50,000` → **BDR Queue**.
- All other leads → **Default Queue**.
- **Screenshot References**:
![Lead Routing Flow](Screenshots/Lead%20Routing%20Flow.png)

---

### **3. Lead Velocity Tracking Flow**

**Purpose**: Logs lead status changes into the `Lead Status History` custom object.

**Logic**:

- Triggered whenever a lead’s status changes.
- Records details such as Lead ID, Status, Timestamp, and Days in Status.
- **Screenshot References**:
![Lead Velocity Tracking Flow](Screenshots/Lead%20Velocity%20Tracking%20Flow.png);

---

### **4. Apex Code for Lead Routing**

#### **LeadRoutingHandler.cls**
<details>
<summary>View Code</summary>

```apex
public class LeadRoutingHandler {
    public static void assignLead(Lead newLead) {
        if (newLead.Country == 'Spain' && newLead.Budget__c > 50000) {
            newLead.OwnerId = getQueueId('Account Executive Queue');
        } else if (newLead.Country == 'Spain') {
            newLead.OwnerId = getQueueId('BDR Queue');
        } else {
            newLead.OwnerId = getQueueId('Default Queue');
        }
    }

    private static Id getQueueId(String queueName) {
        return [SELECT Id FROM Group WHERE Name = :queueName AND Type = 'Queue' LIMIT 1].Id;
    }
}
```

</details>

#### **LeadVelocityLogger.cls**

<details>
<summary>View Code</summary>

```apex
public class LeadVelocityLogger {
    public static void logStatusChange(Lead oldLead, Lead newLead) {
        if (oldLead.Status != newLead.Status) {
            Lead_Status_History__c history = new Lead_Status_History__c(
                Lead__c = newLead.Id,
                Status__c = newLead.Status,
                Timestamp__c = System.now()
            );
            insert history;
        }
    }
}
```

</details>

---

## **Reports**

### **Lead Assignment by Queue**

- Owner Type = Queue

**Table**:

<details>
<summary>View Full Table (5 rows)</summary>

| First Name          | Last Name    | Company / Account     | Budget | Lead Owner               |
|:--------------------|:------------|:----------------------|:-------|:------------------------|
| Henry               | Moore       | Skyline Tech          | 88890  | Account Executive Queue |
| Olivia              | Williams    | MegaSys               | 66677  | Account Executive Queue |
| Sophia              | Taylor      | CloudNova             | 98789  | Account Executive Queue |
| Liam                | Rodriguez   | Greenfield Systems    | 90123  | Account Executive Queue |
| Luna                | Davis       | FusionWorks           | 67890  | Account Executive Queue |
<!-- Add remaining 45 rows here -->

</details>

---

### **Lead Velocity Report**

- Created Date = Current and Previous Calendar Year.

**Table**:

<details>
<summary>View Full Table (5 rows)</summary>

| Lead                | Timestamp        | Days in Status | Status              |
|:--------------------|:----------------|:---------------|:-------------------|
| Ethan Taylor        | 11.12.2024 00:00| 28             | Open - Not Contacted|
| Liam Smith          | 10.12.2024 00:00| 29             | Open - Not Contacted|
| Harper Moore        | 10.12.2024 00:00| 29             | Open - Not Contacted|
| Sophia Martinez     | 5.12.2024 00:00 | 34             | Open - Not Contacted|
| Mason Taylor        | 1.12.2024 00:00 | 38             | Open - Not Contacted|

**File**: [Lead Velocity Report.csv](Reports%20and%20Dashboards/Lead%20Velocity%20Report.csv)

</details>

---

## **Dashboards**

### **Lead Velocity Insights**

**Image**:

![Lead Velocity Insights Dashboard](Reports%20and%20Dashboards/Lead%20Velocity%20Insights%20Dashboard.png)

**Components**:

1. **Lead Distribution** (Bar Chart)
2. **Time Spent in Stages** (Line Chart)
3. **Pipeline Health** (Donut Chart)

---

## **Conclusion**

This project enhances lead management within Salesforce by automating assignment processes, tracking lead velocity, and providing actionable insights. With its customizable design and robust implementation, it serves as a scalable solution for optimizing sales operations.
