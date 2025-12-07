Perfect — this clarification really helps.
You’re converging on a **very coherent and experimentally solid structure**, but let’s now **refactor the research questions and experiments** to reflect your current pipeline (YOLO-E, BLIP-2, OpenFusion) and your weighting logic (fusion weights, detection thresholds, top-k, etc.).

Below is your corrected and optimized structure — still compact, but fully consistent with your real system.

---

## **Updated Research Goal**

To evaluate how combining **zero-shot semantic exploration** (BLIP-2) with **persistent 3D semantic memory** (OpenFusion) and **instance-level detection** (YOLO-E) affects multi-object search performance, path efficiency, and robustness under different fusion and confidence configurations.

---

## **Revised Research Questions**

### **RQ1 – Overall Performance Benchmarking**

> **How does the proposed hybrid framework compare to existing semantic exploration and mapping systems in search success and navigation efficiency?**

* **RQ1a:** How does **Success Rate (SR)** and **Success per Path Length (SPL)** compare with state-of-the-art systems such as **OneMap**, **VLFM**, and **Pigeon**?
* **RQ1b:** Does the hybrid system maintain real-time performance on embedded hardware (Jetson Orin)?

**Purpose:**
To quantify baseline performance gains of the hybrid fusion approach relative to known methods.

---

### **RQ2 – Exploration–Memory Fusion Weighting**

> **How does varying the weight between exploration and memory affect performance and stability?**

* **Parameter:** λₑₓₚₗₒᵣₐₜᵢₒₙ ∈ [0,1] controlling the influence of live exploration versus persistent memory in the **graph node fusion**.
* **RQ2a:** How do **SR** and **SPL** change when shifting trust from exploration to memory?
* **RQ2b:** What weighting yields the best trade-off between reactivity (fast adaptation) and stability (robust localization)?

---

### **RQ3 – Multi-Source Detection Fusion**

> **How does combining instance detection (YOLO-E), semantic similarity (BLIP-2), and memory confidence (OpenFusion) influence detection robustness and false-positive suppression?**

* Each source contributes a score:
  ( S_\text{fusion} = w_d S_\text{det} + w_c S_\text{cosine} + w_m S_\text{memory} )
* **RQ3a:** How does SR change with different ( w_d, w_c, w_m ) configurations?
* **RQ3b:** How do detection precision and recall vary across **COCO**, **open-vocab**, and **zero-shot** classes?
* **RQ3c:** Which drawbacks arise from increasing the detection threshold and applying strong fusion weighting (e.g., missed low-confidence valid objects)?

**Purpose:**
To measure how multi-score fusion affects robustness and error behavior in mixed-vocabulary conditions.

---

### **RQ4 – Sensitivity of Semantic Map Granularity**

> **How does increasing the semantic retrieval depth (*top-k*) in OpenFusion affect map quality, and how can dynamic weighting compensate for resulting noise?**

* **Top-k** controls the number of semantic candidates fused per voxel or grid cell.
* At each *top-k* step, **increase the exploration weight λₑₓₚₗₒᵣₐₜᵢₒₙ** proportionally, shifting trust away from the noisier memory.
* **RQ4a:** How do **SR** and **SPL** degrade when *top-k* grows while trusting only memory?
* **RQ4b:** Can gradual balancing toward exploration restore stable performance at higher *top-k* levels?

**Purpose:**
To understand the coupling between semantic map granularity and fusion weighting stability.

---

### **RQ5 – System Efficiency and Real-World Performance**

> **What is the computational footprint and real-world robustness of the hybrid system?**

* **Metrics:** FPS, GPU/CPU usage, inference latency, detection stability under sensor noise.
* **Scenario:** Physical deployment with RGB-D camera and odometry on mobile robot.

**Purpose:**
To verify deployability and robustness in real-world conditions.

---

## **Experimental Overview**

| **Experiment**                                | **Purpose**                                      | **Metrics**              | **Independent Variables**                      |
| :-------------------------------------------- | :----------------------------------------------- | :----------------------- | :--------------------------------------------- |
| **E1 – Baseline Comparison**                  | Compare with VLFM, OneMap, Pigeon                | SR, SPL                  | System type (ours / baselines)                 |
| **E2 – Fusion Weight Ablation**               | Explore trade-off between exploration and memory | SR, SPL                  | λₑₓₚₗₒᵣₐₜᵢₒₙ ∈ [0,1]                           |
| **E3 – Multi-Source Detection Fusion**        | Assess robustness and FP suppression             | SR, Precision, Recall    | w_d, w_c, w_m; detection threshold; class type |
| **E4 – Semantic Map Granularity Sensitivity** | Study top-k influence and adaptive weighting     | SR, SPL, Map Noise Ratio | top-k ∈ {1,3,5,10,20}, λₑₓₚₗₒᵣₐₜᵢₒₙ adapted    |
| **E5 – Real-World Evaluation**                | Measure resource use and robustness              | FPS, GPU %, SR, SPL      | Hardware setup, environment variation          |

---

### **Optional Diagnostic Additions**

* **Cosine-similarity stability plot** (from BLIP-2) can optionally appear in **E3** to visualize how fused confidence stabilizes detections over time.
* **Top-k noise vs. SR curve** (for E4) could show where memory noise begins to dominate.

---

### **Summary**

Your final structure now clearly examines:

1. **Performance vs. SOTA** (E1 / RQ1)
2. **Behavior of internal weighting parameters** (E2, E4)
3. **Detection and fusion robustness** (E3)
4. **Practical real-world deployability** (E5)

Each experiment directly answers a measurable sub-question tied to **SR**, **SPL**, **stability**, and **resource usage** — making your thesis cohesive and empirically grounded.

---

Would you like me to rewrite these into a concise **LaTeX-ready “Research Questions and Experimental Design” subsection** (with numbered questions and short academic phrasing)?
