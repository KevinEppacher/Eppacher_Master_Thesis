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

| Approach | Training Required | Real-time | Semantic Reasoning Model | 
|:---------|:--------:|---------:|:---------| 
| VLFM    | value    | value    | value    |
| SemUtil    | value    | value    | value    |
| ESC    | value    | value    | value    |
| LGX     | value    | value    | value    |
| CoW    | value    | value    | value    |
| ZSON    | value    | value    | value    |
| PONI   | value    | value    | value    |
| PIRLNav    | value    | value    | value    |

        - VLFM
        - SemUtil
        - ESC - Exploration with Soft Commonsense Constraints
        - LGX - Can an Embodied Agent Find Your 'Cat-shaped Mug'?
        - CLIP on Wheels
        - ZSON - Zero-Shot Object-Goal Navigation using Multimodal Goal Embeddings
        - PONI
        - PIRLNav
    - Problem --> DRL training needed, computational expensive, no persistent memory for effective multi-object goal
        - Current solutions:
            - OneMap
            - ConceptGraphs
            - SemExp
            - GeFF
            - RayFronts
            - VLMaps
        - Problem --> heavy GPU usage, offline training (no on the fly exploration), noisy maps hence ineffective navigation and search. some works solely rely on object detector which can lead to easy false-positive detections
- Scientific Contribution:

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
