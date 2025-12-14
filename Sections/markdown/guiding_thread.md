# 1. Introduction (2 S.)
- Domain and relevance:
    - Service Robotics --> Vaucuum Robot searching for fridge in the Kitchen with semantic Input Prompt
    - Search and Rescue (SAR)--> using one or mutliple robots to search persons, with the hint, that they may be in the bathroom
    - Inspection --> Robot needs to autonomously explore unteleoperational areas with semantic input
    - warehouse automation --> Large warehouses require robots to locate items, pallets, or storage units that may not be consistently labeled or may be partially occluded.
## 1.1 Problem Statement

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

Derivative what is needed from the state of the art:
- zero shot frontier exploration framework
- persistent 3D semantic mapping with confidence-based fusion
- uses pretrtained models only, no further training needed
- hybrid fusion strategy to balance exploration and memory
- multi-source detection fusion for robust object identification
- GPU efficient design for real-time deployment on mobile robots
- Modular architecture for easy adaptation and extension
- Not limited to fix trained set of object categories

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
        - Metrics: Performance is quantified in terms of task success and path efficiency, measured through Success Rate (SR), Success per Path Length (SPL), and Multi-Object Success Rate (MSR) relative to representative state-of-the-art systems such as OneMap, VLFM, and Pigeon.
    - Research Question 2: 
        - How does the interaction between live exploration and accumulated semantic memory influence overall system performance?
        - Metrics: Varying the weighting factor between exploration and memory during graph node fusion to assess impacts on SR and SPL, identifying optimal trade-offs between reactivity and exploitation.
    - Research Question 3: 
        - How does the granularity of semantic map retrieval affect map quality, and can dynamic weighting between exploration and memory compensate for potential noise?
        - Metrics: Varying the semantic granularity in the 3D semantic Mapper and adjusting exploration weight accordingly to evaluate effects on SR and SPL.
    - Research Question 4: 
        - How does multi-source fusion of detection confidence, semantic similarity, and memory confidence impact detection robustness and false-positive suppression during exploration?
        - Metrics: Precision, Recall, F1-Score, Confusion Matrix, SR under different fusion weight configurations across COCO, open-vocab, and zero-shot classes.
    - Research Question 5: 
        - What is the computational footprint and real-world robustness of the hybrid framework.
        - Metrics: FPS, GPU/CPU usage, inference latency, detection stability under sensor noise during physical deployment on a mobile robot.

    These research questions guide the design of the experimental evaluation, where each question is systematically addressed through targeted ablation studies, comparative benchmarks, and real-world validation presented in Chapter 4.
## 1.2 Thesis Structure


# 2. State of the Art (8 S.)
## 2.1 Geometric Exploration
## 2.2 Vision-Language-Guided Exploration

- Aim of VL-guided Exploration: Searching for objects minimizing path lenght, time and total map coverage.

- How is this done?

- Using RGB images from onboard camera to semantically reason about the environment and guide exploration towards likely object locations

- 1. Method - Reinforcement Learning-based Approaches
    - Train an agent to learn exploration policies that maximize expected rewards for locating target objects based on visual inputs.
    - Examples: ZSON, PONI, PIRLNav
    - ZSON:
        - Projects CLIP Image and Text embeddings into a shared space, while training a reinforcement learning policy to navigate towards target objects.
        - Policy is trained on ImageNav, meaning policy learns to go back to places where target objects were similar to the CLIP embedding of the target text query.
        - During inference, the agent replaces the image embedding with the CLIP embedding of the target text query to guide navigation --> zero-shot object search.
        - How does ZSON know when to stop? The agent only learns when to press STOP from RL training.
        - Action Space: Forward, Turn Left, Turn Right, Stop --> discrete action space
        - Observation Space: RGB image + Semantic Goal Embedding + Previous Action (LSTM)
        - Disadvantages: No exploration in unknown areas, only goes back to places where it has seen similar objects during training (only intuition based on CLIP similarity and previously seen areas), Limited interpretability and no explicit semantic memory, retraining needed if environment changes significantly in visual style and sensor characteristics.
    - PIRLNav:
        - Combines behavior cloning with reinforcement learning to train a navigation policy.
        - Stage 1: 
            - Behavior Cloning from expert demonstrations to learn basic navigation skills on large human demonstration datasets.
            - Observation Space:
                - RGB image
                - Pose (GPS + Compass from HM3D)
                - One-hot encoded target object category
                - Implicit memory via a recurrent network (GRU)
            - Action Space (discrete):
                - Forward, Turn Left, Turn Right, Stop, Look Up, Look Down
            BC objective:
                - $\theta^{*} = \arg\min_{\theta} \sum_{(o_t, a_t)} -\log \pi_{\theta}(a_t \mid o_t)$
                - where $\pi_{\theta}$ is the policy network parameterized by $\theta$, and $(o_t, a_t)$ are observation-action pairs from expert demonstrations.
                - $\theta^{*}$ are the learned parameters after minimizing the negative log-likelihood of expert actions given observations.
                - This stage teaches human like navigation behavior.
                - Output is a pretrained navigation policy which maps observations to actions with human like behavior.
        - Stage 2:
            - Contribution is that instead of training purely via RL, they fine-tune the BC pretrained policy using RL to adapt to the object-goal navigation task.
            - The actor policy is initialized with the BC pretrained weights
            - The value function critic network is trained first, while keeping the actor policy frozen.
            - Both actor and critic are then jointly fine-tuned using PPO.
            - $\pi^{*} = \arg\max_{\pi} \mathbb{E}_{\tau \sim \pi} \left[ \sum_{t=1}^{T} \gamma^{t-1} r_t \right]$
            - Reward function:
                - Sparse reward: 1 if stop is executed within 1m of target object and fov, else 0
            - Object Detection:
                - DINO is used as a image encoder, which converts RGB into feature vector
                - Used as a backbone
                - These features are then fed into the navigation policy network along with pose, target category and previous action.
                - The DINO layer helps to extract semantic features from the RGB and provide the navigation policy with relevant information about the environment.
        - Disadvantages:
            - Limited interpretability due to end-to-end learning.
            - No explicit semantic memory, retraining needed if environment changes significantly in visual style and sensor characteristics.
            - Generalization depends on similarity between training and test environments

    - PONI:
        - Learns a potential-field network that predicts attractive and repulsive forces based on visual inputs to guide exploration towards target objects.
        - The potential-field network takes as input ...  and outputs ... during training.
        - How dos training work? ...
        - The potential-field network takes as input ...  and outputs ... during inference.
        - This potential field is then used score frontiers ...
        - Hyperparameter alpha determines if agent should explore or exploit more
            [
            U_t(f) = \alpha , U_t^a(f) + (1 - \alpha), U_t^o(f)
            ]
        - Object detection is done via ...
        - Zero shot or Object-category based?
        - Disadvantages: ...  


Limitations of RL-based or supervised learning approaches:
    - Require extensive training on large datasets, limiting adaptability to new environments.
    - Computationally intensive, hindering real-time deployment on resource-constrained robots.
    - Often rely on closed-set object categories, reducing effectiveness in open-world scenarios.

- 2. Method - Zero-Shot and Training-Free Approaches
    - Leverage pretrained vision-language models or LLMs to perform semantic reasoning without additional training.
    - Examples: VLFM, SemUtil, ESC, LGX, CoW

How are pre-trained models used for zero-shot exploration?
- 1. ESC:
    - Utilizes GLIP for open-vocabulary object detection and DeBERTa/ChatGPT for reasoning about object locations.
    - Scores frontiers based on detected objects and their semantic relevance to the target query.
    - ESC selects its frontiers by evaluating the presence and relevance of detected objects in the environment using GLIP, an open-vocabulary object detector. It then employs DeBERTa or ChatGPT to reason about the spatial relationships and contextual relevance of these objects to the target query, allowing it to prioritize exploration frontiers that are more likely to lead to the desired object.
    - Perception and detection Backbone: GLIP --> 2D bounding boxes with class labels and confidence scores for zero shot object categories --> confidence-threshold dependent
    - Probabilistic Soft Logic: proximity, co-occurrence, and spatial relationships between detected objects to reason about likely locations of target objects.

    $$
    P(F) = P(F \mid d_i^{t}, o^{t}, r^{t})
    $$

- 2. LGX:
    - Integrates GPT-3 for language understanding, GLIP for detection, and BLIP for image captioning.
    - Ranks exploration frontiers by combining visual and linguistic cues to guide navigation.
- 3. CoW:
    - Employs CLIP similarity scoring to evaluate the relevance of visual observations to the target object.
    - Directs exploration towards regions with high semantic similarity to the input query.
- 4. SemUtil:
    - Combines Mask R-CNN for object detection, CLIP for semantic similarity, and BERT for reasoning about object relationships.
    - Generates value maps to prioritize exploration towards areas likely to contain target objects.
- 5. VLFM:
    - Uses BLIP-2 for captioning, GroundingDINO for detection, and SAM for segmentation to identify and localize objects in the environment.
    - Scores frontiers based on the likelihood of containing target objects derived from visual cues.

These zero-shot and training-free approaches enable real-time semantic exploration without the need for extensive retraining, making them more adaptable to diverse environments. However, they often lack persistent memory mechanisms to retain knowledge of previously explored areas, which can limit their efficiency in multi-object search tasks.

## 2.3 Map Reconstruction and Persistent Semantic Mapping

# 3. Methods (22 S.)
## 3.1 System Overview
## 3.2 Semantic Frontier Exploration
**Exploration 2D Occupancy Map**
**Frontier Detection and Calculation**
**Value Map Generation using Vision-Language Models**

## 3.3 Persistent Semantic 3D Mapping
**Global Map Construction with Open-Fusion**
**Semantic Clustering and Graph Node Generation**

## 3.4 Promptable Zero-Shot Detection
**Open-Vocabulary Object Detection with YOLO-E**
**Depth-Based 3D Localization**

## 3.5 Fusion Strategy
**Exploration–Memory Weighting**
**Multi-Source Detection Fusion**
**Relevance Filtering and Node Suppression**

## 3.6 Behavior Tree for Semantic-Guided Exploration
**High-Level Task Structure**
**Integration with Navigation Stack**
**Action and Condition Nodes**

# 4. Implementation (9 S.)
## 4.1 Simulation Environment
## 4.2 Dataset
## 4.3 Used Software
## 4.4 Used Hardware
## 4.5 Evaluation Metrics

# 5. Discussion and Results (30 S.)
## 5.1 Experiment 1: Benchmarking on Matterport Scenes
Evaluates baseline performance in multi-object search compared to state-of-the-art frameworks (OneMap, VLFM, Pigeon) using SR, SPL, and MSR.

## 5.2 Experiment 2: Impact of Exploration–Memory Weighting
Analyzes how varying the balance between live exploration and persistent memory influences navigation efficiency and task success.

## 5.3 Experiment 3: Sensitivity to Semantic Map Granularity
Investigates how varying the semantic retrieval depth affects mapping robustness and overall navigation stability.

## 5.4 Experiment 4: Effect of Multi-Source Semantic Fusion
Examines how combining detection confidence, semantic similarity, and memory reliability improves detection robustness and reduces false positives.

## 5.5 Experiment 5: System Efficiency and Real-World Validation
Assesses runtime performance, resource utilization, and stability under real-world sensor noise during physical deployment.

# 6. Summary and Outlook (1. S)
