Excellent question — this is exactly the kind of clarity that makes a thesis evaluation section feel structured and scientific.

Let’s go through your **five experiments (E1–E5)** and identify precisely what can and should be measured **quantitatively** (numerical metrics, statistical comparisons) and **qualitatively** (visual, behavioral, or descriptive outcomes).

---

## **Overview: Quantitative vs. Qualitative Results**

| **Experiment**                                | **Quantitative Results (Measurable)**                                                                                                                                                                               | **Qualitative Results (Descriptive / Visual)**                                                                                                                                                                       |
| :-------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **E1 – Baseline Comparison**                  | - **Success Rate (SR)** per method  <br> - **Success weighted by Path Length (SPL)** <br> - Runtime / FPS per system <br> - Mean exploration coverage (%)                                                           | - Visual comparison of exploration paths and visited frontiers <br> - Example semantic maps (ours vs. VLFM / OneMap / Pigeon) <br> - Qualitative differences in target localization (e.g., fewer redundant revisits) |
| **E2 – Fusion Weight Ablation**               | - SR, SPL across λₑₓₚₗₒᵣₐₜᵢₒₙ values <br> - Average detection stability (cosine variance, FP rate) <br> - Optimal λ from curve fitting                                                                              | - Behavioral visualization of robot paths at different λ values <br> - Map overlays showing when memory dominates vs. exploration dominates <br> - Temporal plots of confidence evolution                            |
| **E3 – Multi-Source Detection Fusion**        | - SR, Precision, Recall, F1-score for detection <br> - False Positive (FP) / False Negative (FN) rate <br> - Detection confidence distribution <br> - Mean score correlation between YOLO-E, BLIP-2, and OpenFusion | - Example detections for COCO / open-vocab / zero-shot classes <br> - Visual demonstration of fusion improving object boundary stability <br> - Comparative images showing suppressed false positives                |
| **E4 – Semantic Map Granularity Sensitivity** | - SR, SPL vs. top-k <br> - Noise ratio (percentage of incorrect semantic labels) <br> - Map entropy (uncertainty metric) <br> - Fusion performance recovery when adaptive λ applied                                 | - Side-by-side visualization of maps at different top-k (1, 5, 10, 20) <br> - Qualitative “noisy map” examples <br> - Sequence showing how exploration weighting restores semantic clarity                           |
| **E5 – Distributed Real-World Evaluation**    | - Frame rate (FPS) <br> - Network latency (ms) <br> - GPU/CPU utilization per process <br> - SR and SPL on real robot <br> - Jitter and message delay histogram                                                     | - Visual demonstration video (real-world search scenario) <br> - Qualitative assessment of perception lag and map responsiveness <br> - Behavior under lighting or depth noise variations                            |

---

### **1. Quantitative Results**

These are **numerical** and reproducible — they form your *core performance evaluation*.

* **SR** (Success Rate): proportion of completed search tasks.
* **SPL** (Success per Path Length): path efficiency relative to optimal distance.
* **Precision / Recall / F1:** for detection accuracy of semantic fusion.
* **Noise ratio / Entropy:** how clean or confident the semantic memory is.
* **FPS, latency, GPU%, CPU%:** computational metrics for real-time operation.
* **λ and top-k curves:** analytical evaluation of hyperparameter influence.

---

### **2. Qualitative Results**

These provide *insight into behavior and explainability* — they make your results section more readable and intuitive.

* **Visualization of maps:** show how semantic fusion affects map clarity.
* **Exploration trajectories:** illustrate behavioral differences (e.g., shorter, more goal-directed paths).
* **Detection overlays:** show effect of confidence fusion on object boundaries.
* **Comparison figures:** side-by-side visuals for ours vs. baselines.
* **Real-world demo screenshots:** convey robustness in dynamic conditions.
* **Cosine similarity or confidence-over-time plots:** illustrate internal dynamics.

---

### **3. Example Structuring in Thesis**

You can summarize this inside your *Results and Discussion* chapter as:

> Quantitative evaluation focuses on success-related metrics (SR, SPL, precision, recall) and system efficiency (FPS, latency, GPU utilization), while qualitative analysis illustrates the system’s behavior through exploration maps, confidence trajectories, and detection visualizations. The combination of both perspectives provides a holistic assessment of how the hybrid semantic exploration framework balances real-time performance, semantic reasoning, and robustness.

---

### **4. Suggested Figure Types per Experiment**

| Experiment | Figure / Plot Type                                            |
| ---------- | ------------------------------------------------------------- |
| E1         | Bar chart (SR, SPL per baseline), qualitative path overlays   |
| E2         | Line plot (SR/SPL vs. λ), heatmap of confidence vs. weighting |
| E3         | Precision-Recall curves, detection overlay images             |
| E4         | Line chart (SR vs. top-k), qualitative map comparison         |
| E5         | Latency histogram, FPS timeline, robot demo screenshots       |

---

### **Summary**

* **Quantitative:** answers *how well* the system performs — objective, comparable, statistically valid.
* **Qualitative:** explains *why* it behaves that way — intuitive, interpretive, and crucial for robotics.

Combining both gives you strong internal validity (measurable effects) **and interpretability** (visual confirmation of reasoning).

---

Would you like me to produce a **LaTeX “Evaluation Metrics” subsection** that summarizes this distinction formally (like how many robotics theses phrase it: “Quantitative Metrics” vs. “Qualitative Analysis”)?
