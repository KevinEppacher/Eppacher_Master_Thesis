# Introduction (2 S.)
## Problem Statement
- Domain and relevance:
    - Service Robotics --> Vaucuum Robot searching for fridge in the Kitchen with semantic Input Prompt
    - Search and Rescue (SAR)--> using one or mutliple robots to search persons, with the hint, that they may be in the bathroom
    - Inspection --> Robot needs to autonomously explore unteleoperational areas with semantic input
    - warehouse automation --> Large warehouses require robots to locate items, pallets, or storage units that may not be consistently labeled or may be partially occluded.

- Problem --> Classic geometric Exploration --> ineffiecient search, mainly used for mapping unexplored environemts
    - Solution --> Incorporating semantics into exploration by using camera rgb images
    - Current solutions:

    | **Approach** | **Training Required** | **Real-Time** | **Semantic Reasoning Model** |
    |:--------------|:--------------------:|:--------------:|:-----------------------------|
    | **VLFM** | ✗ (zero-shot) | ✓ | BLIP-2 + GroundingDINO + SAM |
    | **SemUtil** | ✗ (training-free) | ✓ | Mask R-CNN + CLIP + BERT |
    | **ESC** | ✗ (zero-shot) | ✓ | GLIP + DeBERTa/ChatGPT reasoning |
    | **LGX** | ✗ (zero-shot) | ✓ | GPT-3 + GLIP + BLIP |
    | **CoW** | ✗ (zero-shot) | ✓ | CLIP similarity scoring |
    | **ZSON** | ✓ (RL pretraining) | ✗ | CLIP-based RL policy |
    | **PONI** | ✓ (supervised) | ✗ | Learned potential-field network |
    | **PIRLNav** | ✓ (BC + RL) | ✗ | DINO-based CNN-RNN policy |

    None of them support semantic persistent memory for more efficient navigation or are computationally gpu hungry

    - Problem --> DRL training needed, computational expensive, no persistent memory for effective multi-object goal
        - Current solutions:

        | **Approach** | **Training Required** | **Real-Time** | **Memory Representation** | **Exploration Integration** |
        |:--------------|:--------------------:|:--------------:|:---------------------------|:-----------------------------|
        | **OneMap** | ✗ (zero-shot) | ✓ | 2D probabilistic feature field | ✓ (frontier-based) |
        | **ConceptGraphs** | ✗ (pretrained models) | ✗ | 3D scene graph | ✓ (LLM-planner) |
        | **SemExp** | ✓ (RL + supervised) | ✗ | 2D semantic occupancy map | ✓ (learned policy) |
        | **GeFF** | ✓ (ScanNet pretrain) | ✓ | Implicit 3D feature field | ✗ (passive) |
        | **RayFronts** | ✗ (foundation model) | ✓ | Hybrid voxel + ray field | ✓ (semantic frontier) |
        | **VLMaps** | ✗ (pretrained LSeg/CLIP) | ✗ | 2.5D open-vocab grid | ✓ (frontier-compatible) |
        | **Pigeon** | ✓ (RLVR fine-tune) | ✓ | Point-of-Interest snapshot memory | ✓ (reasoning-aware) |

        - Problem --> heavy GPU usage, offline training (no on the fly exploration), noisy maps hence ineffective navigation and search. some works solely rely on object detector which can lead to easy false-positive detections


Core Gaps:

| **Limitation** | **Example Works** | **Implication** |
| :---------------------------------- | :---------------------------- | :--------------------------------------------- |
| **No persistent memory** | VLFM, CoW, LGX, ESC | No long-term fusion or recall; repeated exploration of known areas. |
| **Offline training required** | ZSON, PONI, PIRLNav, SemExp | Heavy RL/supervised training; poor adaptability to new scenes. |
| **No balance between exploration and memory** | OneMap, RayFronts, VLMaps | Either passive mapping or short-term exploration; inefficient search. |
| **No Zero-shot exploration** | VLFM, CoW, LGX | Detect novel objects but fail to explore unseen regions strategically. |
| **Premapping needed** | ConceptGraphs, VLMaps, GeFF | Depend on pre-recorded data; not suited for online autonomy. |
| **Limited robustness** | PONI, SemExp, PIRLNav | Closed-set categories; fragile under real-world variation. |
| **Low real-world applicability** | ConceptGraphs, VLMaps | High GPU cost or simulation-only; not deployable on mobile robots. |

- Scientific Contribution:
    This work contributes to the state-of-the-art by introducing a hybrid semantic exploration framework that combines zero-shot frontier scoring~\cite{yokoyama2024vlfm} with global semantic 3D scene representation~\cite{kashu2023openfusion}, enabling multi-object search with open-vocabulary text queries during autonomous exploration. The proposed method is evaluated for improvements in multi-object \ac{SR} as well as path efficiency measured by \ac{SPL}.This is achieved by streamlining existing frontier scoring systems that selectively choose expert models based on the current tasks into a singular vision-language model based on \ac{SEEM}~\cite{zou2023seem}, substantially reducing GPU memory requirements compared to traditional semantic exploration pipelines using multiple separate models. Exploration is complemented by a sensor-based fusion strategy that integrates semantic detections from \ac{SEEM}~\cite{zou2023seem} with clustered relevance fields from semantic 3D mapping~\cite{kashu2023openfusion}, applying spatial confidence weighting to enhance robustness against false positives in zero-shot object detection. Experimental validation of the proposed system on a real mobile robot, focusing on practical aspects such as real-time performance and robustness to sensor noise including depth inaccuracies and changing lighting conditions.
    
    To evaluate the contribution of the proposed system, the following research questions are formulated.
    ### **RQ1 – Overall Performance Benchmarking**

    > **How does the proposed hybrid framework compare to existing semantic exploration and mapping systems in search success and navigation efficiency?**

    * **RQ1a:** How does **Success Rate (SR)** and **Success per Path Length (SPL)** compare with state-of-the-art systems such as **OneMap**, **VLFM**, and **Pigeon**?
    * **RQ1b:** Does the hybrid system maintain real-time performance on embedded hardware (Jetson Orin)?

    **Purpose:**
    To quantify baseline performance gains of the hybrid fusion approach relative to known methods.

    ### **RQ2 – Exploration–Memory Fusion Weighting**

    > **How does varying the weight between exploration and memory affect performance and stability?**

    * **Parameter:** λₑₓₚₗₒᵣₐₜᵢₒₙ ∈ [0,1] controlling the influence of live exploration versus persistent memory in the **graph node fusion**.
    * **RQ2a:** How do **SR** and **SPL** change when shifting trust from exploration to memory?
    * **RQ2b:** What weighting yields the best trade-off local exploration and memory?

    ### **RQ3 – Multi-Source Detection Fusion**

    > **How does combining instance detection (YOLO-E), semantic similarity (BLIP-2), and memory confidence (OpenFusion) influence detection robustness and false-positive suppression?**

    * Each source contributes a score:
    ( S_\text{fusion} = w_d S_\text{det} + w_c S_\text{cosine} + w_m S_\text{memory} )
    * **RQ3a:** How does SR change with different ( w_d, w_c, w_m ) configurations?
    * **RQ3b:** How do detection precision and recall vary across **COCO**, **open-vocab**, and **zero-shot** classes?
    * **RQ3c:** Which drawbacks arise from increasing the detection threshold and applying strong fusion weighting (e.g., missed low-confidence valid objects)?

    **Purpose:**
    To measure how multi-score fusion affects robustness and error behavior in mixed-vocabulary conditions.

    ### **RQ4 – Sensitivity of Semantic Map Granularity**

    > **How does increasing the semantic retrieval depth (*top-k*) in OpenFusion affect map quality, and how can dynamic weighting compensate for resulting noise?**

    * **Top-k** controls the number of semantic candidates fused per voxel or grid cell.
    * At each *top-k* step, **increase the exploration weight λₑₓₚₗₒᵣₐₜᵢₒₙ** proportionally, shifting trust away from the noisier memory.
    * **RQ4a:** How do **SR** and **SPL** degrade when *top-k* grows while trusting only memory?
    * **RQ4b:** Can gradual balancing toward exploration restore stable performance at higher *top-k* levels?

    **Purpose:**
    To understand the coupling between semantic map granularity and fusion weighting stability.

    ### **RQ5 – System Efficiency and Real-World Performance**

    > **What is the computational footprint and real-world robustness of the hybrid system?**

    * **Metrics:** FPS, GPU/CPU usage, inference latency, detection stability under sensor noise.
    * **Scenario:** Physical deployment with RGB-D camera and odometry on mobile robot.

    **Purpose:**
    To verify deployability and robustness in real-world conditions.


## Thesis Structure


# State of the Art (8 S.)
## Geometric Exploration
## Semantic Multi-Object Search Approaches
## Map Reconstruction and Persistent Semantic Mapping
## Object Detection and Promptable Models

# Methods (22 S.)
## System Overview
## Semantic Frontier Exploration
### Frontier Detection and Calculation
### Value Map Generation using Vision-Language Models
### Navigation to High-Value Frontiers
## Persistent Semantic 3D Mapping
### Global Map Construction with Open-Fusion
### Semantic Clustering and Graph Node Generation
## Promptable Zero-Shot Detection
## Fusion Strategy
## Behavior Tree for Semantic-Guided Exploration

# Implementation (9 S.)
## Simulation Environment
## Dataset
## Used Software
## Used Hardware
## Evaluation Metrics

# Discussion and Results (30 S.)
## Results on Semantic Multi-Object Search Tasks
### Experiment 1: Single-Object Success Rate (SR)
### Experiment 2: Navigation Efficiency (SPL)
### Experiment 3: Multi-Object Success Rate (MSR)
### Experiment 4: Ablation of Exploitation (OpenFusion)
## Experiment 5: Improving Detection Robustness via Semantic Fusion
## Experiment 6: Real-World Deployment

# Summary and Outlook (1. S)
