# Salesforce Project: Lead Routing and Velocity Tracking

## **Overview**

- **Presentation**: [Loom Presentation](https://www.loom.com/share/55864cb2a5dc487aa708e5862679b183?sid=70353eff-9013-4a94-9529-3840f0f6379c)

## **Assessment Replies**

1. **Lead Routing**
   - To address lead routing, I have implemented solutions using Lead Assignment Rules, Salesforce Flow, and Apex Code. All implementations are documented in this ReadMe file.

2. **Salesforce Flow Design**
   - Both Flow-based and Apex code solutions are available and described in this ReadMe file.

3. **Report Creation**
   - Reports are referenced and explained within this file.

4. **Dashboard Creation**
   - Dashboards are detailed and referenced in this file.

#### *This Salesforce project delivers a comprehensive solution for lead routing and velocity tracking. It incorporates Lead Assignment Rules, Flows, and Apex Code, though only the Apex Code solution is currently active. These components can be toggled as needed. The project automates lead assignment to queues based on predefined criteria and monitors lead status changes to provide actionable insights into pipeline performance. Randomly generated data is used to populate reports, and this data is available in the project's GitHub repository.*
**Assignment Diagram**:
  ![Acme Demo Diagram](Screenshots/Acme%20Demo%20Diagram.png)
---

## **Features**

1. **Lead Routing Flow**:

   - Automates lead assignment to queues based on country and budget criteria.
   - Ensures efficient distribution of leads among the Account Executive and BDR queues.

2. **Lead Velocity Tracking Flow**:

   - Logs lead status changes into the custom object `Lead Status History`.
   - Tracks the time spent in each status using the formula field `Days in Status`.

3. **Custom Object: Lead Status History**:

   - Stores details about status changes, including:
     - **Lead ID**
     - **Status**
     - **Timestamp**
     - **Days in Status** (calculated dynamically via a formula field).

4. **Reports**:

   - **Lead Assignment by Queue**: Visualizes lead distribution across queues.
   - **Lead Velocity Report**: Tracks time spent in stages, filtered by current and previous calendar years.

5. **Dashboards**:

   - **Lead Velocity Insights**: Displays key performance metrics, including lead velocity, pipeline health, and team distribution.

---

## **Implementation Details**

### **1. Formula Field: Days in Status**

- **Purpose**: Calculates the time a lead spends in each status.
- **Formula**:
  ```
  ROUND(DATEVALUE(NOW()) - DATEVALUE(Timestamp__c), 2)
  ```
- **Screenshot**:
  ![Days in Status Formula Field](Screenshots/Days%20in%20Status%20Formula%20Field.png)

---

### **2. Lead Routing Flow**

- **Purpose**: Automates the routing of leads based on country and budget.
- **Logic**:
  - Leads with `Country = Spain` and `Budget > 50,000` are routed to the Account Executive Queue.
  - Leads with `Country = Spain` and `Budget <= 50,000` are routed to the BDR Queue.
  - Leads from other countries are routed to a default queue.
- **Screenshot**:
  ![Lead Routing Flow](Screenshots/Lead%20Routing%20Flow.png)

---

### **3. Lead Velocity Tracking Flow**

- **Purpose**: Logs status changes into the `Lead Status History` object.
- **Logic**:
  - Triggered on lead status changes.
  - Logs details such as lead ID, new status, and timestamp.
- **Screenshot**:
  ![Lead Velocity Tracking Flow](Screenshots/Lead%20Velocity%20Tracking%20Flow.png)

---

### **4. Custom Object: Lead Status History**

- **Purpose**: Stores data about lead status changes.
- **Fields**:
  - **Lead** (Lookup → Lead)
  - **Status** (Picklist)
  - **Timestamp** (Date/Time)
  - **Days in Status** (Formula Field)
- **Screenshot**:
  ![Lead Status History and Fields](Screenshots/Lead%20Status%20History%20and%20Fields.png)

---

### **5. Lead Assignment Rules (Inactive)**

- **Purpose**: As an alternative solution, Lead Assignment Rules were configured to handle lead routing. However, these rules are currently inactive, as the Apex-based routing approach is used instead.
- **Details**:
  - Rules assign leads based on country and budget criteria.
- **Screenshot**:
  ![Lead Assignment Rule](Screenshots/Lead%20Assignment%20Rule.png)
  ![Lead Queues](Screenshots/Lead%20Queues.png)

---

### **6. Flows (Inactive)**

- **Purpose**: Flows for Lead Routing and Velocity Tracking were created to demonstrate process automation capabilities. However, these flows are currently inactive, as the active implementation relies on Apex code.
- **Details**:
  - **Lead Routing Flow**: Automates lead assignment to queues.
  - **Lead Velocity Tracking Flow**: Logs lead status changes into the custom object.
- **Screenshot References**:
   ![Lead Routing Flow](Screenshots/Lead%20Routing%20Flow.png)
   ![Lead Velocity Tracking Flow](Screenshots/Lead%20Velocity%20Tracking%20Flow.png)

---

### **7. Apex Code**

#### **Lead Velocity**

- **References**:
  - `LeadVelocityLogger.cls`: Contains the logic to log lead status changes into the `Lead Status History` object.
  - `LeadVelocityTrigger.trigger`: Ensures the `LeadVelocityLogger` is triggered whenever a lead's status changes.

#### **Lead Routing**

- **References**:
  - `LeadRoutingHandler.cls`: Contains the logic to route leads based on country and budget criteria.
  - `LeadRoutingTrigger.trigger`: Ensures the `LeadRoutingHandler` is triggered whenever a lead is created or updated.

---

### **8. Reports**

#### **Lead Assignment by Queue**

- **Purpose**: Analyzes the distribution of leads across queues.
- **Filters**:
  - Owner Type = Queue.
- **Link**: [Lead Assignment by Queue](https://saascendassesmentozanaltin-dev-ed.trailblaze.lightning.force.com/lightning/r/Report/00OWU000008zWzG2AU/view?queryScope=userFolders) 

#### **Lead Velocity Report**

- **Purpose**: Tracks time spent in each stage.
- **Filters**:
  - Created Date = Current and Previous Calendar Year.
- **Link**: [Lead Velocity Report](https://saascendassesmentozanaltin-dev-ed.trailblaze.lightning.force.com/lightning/r/Report/00OWU00000908Bh2AI/view?queryScope=userFolders)

---

### **9. Dashboard: Lead Velocity Insights**

- **Purpose**: Provides high-level insights into lead velocity and pipeline performance.
- **Link**: [Dashboard Reference](https://saascendassesmentozanaltin-dev-ed.trailblaze.lightning.force.com/lightning/r/Dashboard/01ZWU000001zB1B2AU/view?queryScope=userFolders)

- **Components**:
  1. **Lead Distribution**:
     - Visualization: Bar Chart.
     - Source: Lead Assignment by Queue Report.
  2. **Time Spent in Stages**:
     - Visualization: Line Chart.
     - Source: Lead Velocity Report.
  3. **Pipeline Health**:
     - Visualization: Donut Chart.
     - Source: Lead Assignment by Queue Report.
---

## **Conclusion**

This project streamlines lead routing and tracking while providing actionable insights into sales pipeline performance. It leverages flows, Apex, reports, and dashboards to enhance efficiency and enable data-driven decisions.