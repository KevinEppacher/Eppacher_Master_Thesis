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

    This work contributes to the state of the art by introducing a hybrid semantic exploration framework that integrates zero-shot semantic frontier scoring with persistent 3D scene representation, enabling autonomous search guided by open-vocabulary text queries. The system combines real-time semantic reasoning during exploration with a long-term spatial memory, allowing the robot to dynamically balance between discovering new information and exploiting previously acquired knowledge.

    Unlike previous approaches that focus exclusively on either geometric frontiers or static semantic maps, the proposed framework continuously fuses information from multiple semantic sources to maintain a unified, confidence-based world model. Adaptive weighting enables the robot to adjust its behavior between exploration and exploitation according to the reliability of recent observations and the stability of stored semantic memory.

    The framework further investigates how the quality and granularity of the underlying semantic information influence task success, navigation efficiency, and robustness. By systematically varying the trust between exploration and memory components, this work provides new insights into how semantic reasoning and persistent mapping can be effectively combined for open-vocabulary, multi-object search in dynamic environments.

    To evaluate the contribution of the proposed system, the following research questions are formulated.
    - Research Question 1: 
        - How does integrating zero-shot semantic exploration and persistent 3D semantic mapping affect multi-object search performance and navigation efficiency compared to existing methods?
        - Metrics: Success Rate (SR) and Success weighted by Path Length (SPL), Multi-Object Success Rate (MSR)
    - Research Question 2: 
        - How does the interaction between live exploration and accumulated semantic memory influence overall system performance?
        - Metrics: Varying the weighting factor between exploration and memory during graph node fusion to assess impacts on SR and SPL, identifying optimal trade-offs between reactivity and exploitation.
    - Research Question 3: 
        - How does multi-source fusion of detection confidence, semantic similarity, and memory confidence impact detection robustness and false-positive suppression during exploration?
        - Metrics: Precision, Recall, F1-Score, Confusion Matrix, SR under different fusion weight configurations across COCO, open-vocab, and zero-shot classes.
    - Research Question 4: 
        - How does the granularity of semantic map retrieval affect map quality, and can dynamic weighting between exploration and memory compensate for potential noise?
        - Metrics: Varying the top-k retrieval depth in OpenFusion and adjusting exploration weight accordingly to evaluate effects on SR and SPL.
    - Research Question 5: 
        - What is the computational footprint and real-world robustness of the hybrid framework.
        - Metrics: FPS, GPU/CPU usage, inference latency, detection stability under sensor noise during physical deployment on a mobile robot.

    These research questions guide the design of the experimental evaluation, where each question is systematically addressed through targeted ablation studies, comparative benchmarks, and real-world validation presented in Chapter 4.

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
