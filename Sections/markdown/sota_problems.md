Excellent — here’s a **precise synthesis** of the **main issues and limitations** identified across *all the reviewed methods* (semantic exploration + persistent memory approaches).

This summary is structured to reflect the logical evolution of the field and clearly motivate your thesis contribution.

---

## **Main Issues Identified Across Existing Works**

### **1. Lack of Persistent Semantic Memory**

* Most exploration frameworks (**VLFM, CoW, ESC, LGX, SemUtil, ZSON**) reason over **the current image only**, discarding prior semantic context.
* No accumulated knowledge or memory structure enables efficient **multi-object search** — the robot reprocesses already-seen regions.
* Methods that do maintain a map (**SemExp**) encode only **category masks or binary occupancy**, not high-dimensional semantic embeddings.
* Persistent mapping methods (**VLMaps, OneMap, RayFronts, ConceptGraphs**) exist but are **decoupled from exploration** — they build maps *after* data collection rather than *during* autonomous exploration.

---

### **2. Heavy Dependence on Offline or Supervised Training**

* Learning-based approaches (**ZSON, PONI, PIRLNav, SemExp**) rely on **expensive supervised or RL training**, often requiring **millions of simulation frames** and **high compute clusters**.
* This hinders deployment in open-world, zero-shot settings and makes **adaptation to new domains slow or impossible**.
* By contrast, zero-shot models (**VLFM, CoW, LGX, ESC**) leverage pretrained VLMs but suffer from **inconsistent performance** in dynamic or cluttered scenes without fine-tuning.

---

### **3. Lack of True Real-Time Capability**

* Only a few recent works (**VLFM, OneMap, RayFronts, Pigeon**) demonstrate genuine **real-time performance** (≥2–8 Hz) on embedded GPUs.
* Others (**ConceptGraphs, VLMaps**) are **offline or batch-based**, requiring **>20 GB VRAM** for feature fusion or LLM inference.
* Even “interactive” systems (e.g., LGX, SemUtil) depend on high-end GPUs or pre-mapped environments.
* Consequently, most frameworks are unsuitable for **onboard inference in mobile platforms** (Jetson, Xavier, Orin-class hardware).

---

### **4. Weak Integration Between Semantics and Exploration**

* Traditional frontier-based methods (**CoW, SemUtil, ESC**) use *semantic cues* for frontier scoring but do not update a **shared spatial-semantic belief**.
* Persistent mappers (**OneMap, VLMaps, RayFronts**) maintain semantic memory but lack **goal-driven exploration logic** — they passively map without semantic prioritization.
* The two paradigms remain **disconnected**: one focuses on *where to explore*, the other on *what is known*.
* This separation leads to **redundant mapping, poor search efficiency**, and no ability to strategically plan based on semantic uncertainty.

---

### **5. High Computational and Memory Demand**

* State-of-the-art open-vocab methods (**ConceptGraphs, VLMaps, RayFronts, Pigeon**) require **8–24 GB VRAM**, with model ensembles (CLIP + SAM + LLM) consuming significant GPU cycles per frame.
* Multi-modal fusion (image, depth, text, LLM reasoning) introduces **latency** and **energy cost**, limiting use in resource-constrained field robots.
* Feature-field approaches (**GeFF**) achieve compactness but still need pretraining on large datasets (e.g., ScanNet), and implicit NeRF decoders are computationally heavy.

---

### **6. Limited Generalization and Robustness**

* RL- and policy-based models (**PONI, PIRLNav, SemExp**) are bound to **closed-set object categories** and **simulator-specific textures**.
* CLIP-based zero-shot systems (**CoW, VLFM**) generalize better but still fail in **textureless or occluded** scenes.
* LLM reasoning (ESC, LGX, ConceptGraphs) improves interpretability but adds **semantic hallucination** risks — producing false spatial relations or incorrect object associations.

---

### **7. No Unified Representation for Geometry and Semantics**

* Classical mapping separates geometry (occupancy grids) from semantics (object IDs).
* Newer frameworks (e.g., **GeFF, RayFronts**) attempt to fuse both into a **joint feature field**, but trade-offs remain between **accuracy, update rate, and scalability**.
* Most systems cannot dynamically **refine** their semantic understanding with new evidence (no confidence weighting or belief update).

---

### **8. Incomplete Multi-Object Search Capability**

* None of the reviewed systems explicitly tackle **multi-object or sequential search** tasks under open-vocabulary conditions.
* Existing pipelines can find a *single queried object* but not reason about **sets of objects**, **object relations**, or **search order**.
* Without persistent semantic memory and history, multi-object reasoning is impossible.

---

### **9. Dependency on Large Language Models (LLMs) Without Structural Memory**

* Systems such as **ESC, LGX, ConceptGraphs, Pigeon** integrate GPT-family models for reasoning, but rely on **episodic text-based prompts**, not a structured spatial-semantic database.
* This leads to **context loss** and redundant reasoning when re-encountering known areas.
* LLM reasoning is high-level but non-spatial — it cannot be efficiently grounded into robot maps without an explicit memory layer.

---

### **10. Summary of Core Gaps**

| Limitation                                       | Example Works                   | Implication                                    |
| :----------------------------------------------- | :------------------------------ | :--------------------------------------------- |
| No persistent semantic memory                    | VLFM, CoW, LGX, ESC             | Inefficient multi-object search                |
| Offline or GPU-heavy mapping                     | VLMaps, ConceptGraphs           | Not deployable on mobile robots                |
| RL training requirement                          | ZSON, PIRLNav, SemExp           | Poor domain transfer                           |
| Missing semantic-exploration coupling            | OneMap, GeFF, RayFronts         | Passive mapping only                           |
| Incomplete 3D reasoning                          | OneMap, Pigeon                  | Limited to 2D projection                       |
| Lack of open-vocab and robustness                | SemExp, PONI                    | Closed-set labels                              |
| Heavy reliance on LLMs without structural memory | ESC, LGX, ConceptGraphs, Pigeon | Semantic hallucination, no temporal continuity |

---

### **→ Overall Conclusion**

Despite rapid progress in integrating vision-language models into robotic exploration, **no current system simultaneously achieves**:

* **Persistent, real-time semantic memory** that updates incrementally,
* **Open-vocabulary zero-shot reasoning**, and
* **Autonomous exploration guided by semantic uncertainty**.

This technological and conceptual gap directly motivates your thesis contribution:
**a unified, memory-persistent framework for open-vocabulary, multi-object semantic exploration**, combining frontier-based navigation with continuous semantic fusion and compact, dynamically updatable representations.

---

Would you like me to condense this into a 2–3 paragraph **“Problem Summary”** suitable for the *Introduction → Problem Statement* section (formatted in academic thesis style)?
