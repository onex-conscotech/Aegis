# Monte Carlo Pricing System

## **Sequence Diagram**

```mermaid
sequenceDiagram
    participant SchedulerAPI
    participant BookPricingKeeper
    participant DB as Database (BOOK & TRADE_DETAILS)
    participant PreprocessingQueue as Preprocessing Queue (PREPROCESS)
    participant PreprocessorNodes as Preprocessor Nodes
    participant ExecutionQueue as Execution Queue (EXECUTE PRICING)
    participant ExecutionNodes as Execution Nodes (C++ pods)
    participant Aggregator

    SchedulerAPI->>BookPricingKeeper: 1. Submit Book Pricing Request (Thousands of Trades)
    BookPricingKeeper->>DB: 2. Create DB Entry (Status: Posted for Preprocessing)
    BookPricingKeeper->>PreprocessingQueue: 3. Add Book to PREPROCESS Queue

    loop Preprocessing Stage
        PreprocessorNodes->>PreprocessingQueue: 4. Fetch Book for Preprocessing
        PreprocessorNodes->>DB: 5. Fetch & Store Complete Book Data
    end

    PreprocessorNodes->>DB: 6. Update Preprocessing Status
    BookPricingKeeper->>DB: 7. Poll for Preprocessing Status
    BookPricingKeeper->>ExecutionQueue: 8. Add Individual Trades to EXECUTE PRICING Queue

    loop Execution Stage
        ExecutionNodes->>ExecutionQueue: 9. Poll for Individual Trade Jobs
        ExecutionNodes->>ExecutionNodes: 10. Run Monte Carlo Simulation
        ExecutionNodes->>DB: 11. Store Computed Results & Update Status
    end

    BookPricingKeeper->>DB: 12. Poll for Trade Completion Status
    BookPricingKeeper->>Aggregator: 13. Notify Aggregator when All Trades in a Book are Done
```

## **Block Diagram**

```mermaid
graph TD;
    A[Scheduler API] -->|Submit Book Request| B[BookPricingKeeper]
    B -->|Insert DB Entry| C[Database]
    B -->|Add to Queue| D[Preprocessing Queue]
    D -->|Fetch Book Data| E[Preprocessor Nodes]
    E -->|Store in DB| C
    B -->|Poll Status| C
    B -->|Add Trades to Queue| F[Execution Queue]
    F -->|Poll Jobs| G[Execution Nodes C++]
    G -->|Monte Carlo Simulation| G
    G -->|Store Results| C
    B -->|Poll Status| C
    B -->|Notify Batch Completion| H[Aggregator]
```

## **Module Breakdown**

### **1️⃣ Scheduler API**
- Accepts book pricing requests.
- Sends book details to **BookPricingKeeper**.

### **2️⃣ BookPricingKeeper**
- Manages the workflow.
- Stores book metadata and trades in the **DB**.
- Sends tasks to preprocessing and execution queues.
- Notifies **Aggregator** on completion.

### **3️⃣ Database (BOOK & TRADE_DETAILS)**
- Stores book metadata and individual trade details.

### **4️⃣ Preprocessing Queue (PREPROCESS)**
- Holds books waiting for preprocessing.

### **5️⃣ Preprocessor Nodes**
- Fetch complete book data and save it to **DB**.

### **6️⃣ Execution Queue (EXECUTE PRICING)**
- Holds individual trade pricing tasks.

### **7️⃣ Execution Nodes (C++ Pods on Kubernetes)**
- Poll for trade pricing jobs.
- Run **Monte Carlo simulations**.
- Store results in **DB**.

### **8️⃣ Aggregator Module**
- Listens for batch completion notifications.
- Aggregates results for reporting.

---

## **🚀 Kubernetes Auto-Scaling**
- Scales pods **based on queue length** (if many jobs are waiting, more pods are spawned).

---

## **🛠️ Tech Stack**

| **Component**    | **Technology Choices**                                |
| ---------------- | ----------------------------------------------------- |
| **Job Queues**   | Redis Queue                         |
| **Orchestrator** | Kubernetes (K8s)                                      |
| **Worker Nodes** | C++ Monte Carlo Programs (Running in Kubernetes Pods) |
| **Database**     | PostgreSQL                           |
| **Monitoring**   | Prometheus + Grafana                                  |
| **Logging**      | ELK Stack (Elasticsearch, Logstash, Kibana)           |

---
