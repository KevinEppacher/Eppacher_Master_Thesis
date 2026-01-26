According to your current thesis draft (SAGE.pdf), the overall narrative is coherent (problem → gap → hybrid method → experimental evidence → deployability), but there are a few places where the logic is slightly overstated, the evaluation comparability needs tighter framing, and a handful of claims would benefit from either additional citation or more precise wording.

## 1) Logical/technical issues and potential misunderstandings

### A. “Comparability” vs. “different evaluator”

You state that the evaluation pipeline is designed “to ensure comparability” with VLFM/OneMap-style metrics, but then you necessarily deviate from Habitat’s geodesic computation because you are in IsaacSim and cannot use HabitatSim’s planner, so you compute shortest paths based on a reconstructed map instead. This is fine, but it means **metric values are not strictly comparable to reported Habitat numbers**, because SPL is sensitive to the geodesic definition and map reconstruction artifacts. You already acknowledge simulator/evaluator differences in the results chapter, but the conclusion currently still reads close to a direct benchmark claim. I would tighten language everywhere you compare against “prior work” to “indicative comparison under a different simulator/evaluator.”

Concrete fix pattern:

* Replace “demonstrate that SAGE achieves competitive and often superior performance compared to existing frameworks” with “suggest that SAGE achieves competitive performance under the IsaacSim-based evaluation pipeline, and shows strong gains relative to reported baselines (noting differences in simulator and geodesic computation).”

### B. Overgeneralization about what “existing methods” do

The statement “existing methods either rely exclusively on semantic maps for decision-making or omit persistent mapping entirely” is directionally consistent with your stated research gap, but it reads like a hard dichotomy. Since you already have a nuanced taxonomy in the SOTA chapter, you can soften this to “many” and reference your gap analysis table/paragraph, which already supports the claim that the **combination** of (i) zero-shot exploration, (ii) persistent memory, and (iii) explicit exploration–exploitation control is not jointly addressed.

### C. Multi-source fusion claim: “suppress false positives” vs. “reduce false negatives”

Your conclusion emphasizes that multi-source fusion improves robustness; in your Experiment 4 narrative you explicitly emphasize **reducing false negatives** with a moderate FP increase. That is coherent, but be careful with wording like “suppress false positives” (which implies FPR improves). In the Experiment 4 definitions you also introduce an unusual convention: TN includes “neutral episodes” where no decision is evaluated, which makes FPR interpretation less standard. That is defensible, but then you should avoid broad claims like “suppresses false positives” unless you directly qualify how FPR is computed in your setup.

### D. “Adaptive weighting” vs. “fixed hyperparameter”

In Chapter 1/Methods you describe adaptive modulation based on reliability/stability; later you describe a fixed hyperparameter and suggest adaptivity as future work. Make sure the thesis uses one consistent claim:

* If the deployed system uses a fixed (\lambda) per experiment, call it **“tunable”** rather than “adaptive.”
* If you truly adjust online based on confidence, you should state the actual rule and point to where it is implemented.
  Right now, the conclusion reads “adaptive weighting enables the robot to adjust…” while future work says adaptivity is missing. That can be read as inconsistent unless clarified.

## 2) Where you should cite more (or rephrase to avoid needing citations)

### A. VLFM “>16 GB VRAM” claim

You currently cite VLFM while stating that VLFM “utilizes four different VLM and detectors” and “exceed 16 GB of GPU memory” and then compare to SAGE’s 3.5 GB exploration footprint.
This is a **measurement/engineering claim**, not necessarily stated in the VLFM paper. Options:

1. If this is from your reproduction: write “In our reproduction of VLFM…” and cite an **appendix figure/table** (your own measurement), not the VLFM paper.
2. If it is stated by authors elsewhere: cite that primary source (issue, doc, etc.).
   Otherwise, it can look like an unsubstantiated jab.

### B. Claims about “costmap inflation reduces failures”

This is plausible, but in the conclusion it reads like a general causal claim. It should be tied explicitly to your Experiment 3/ablation evidence (internal cross-reference) rather than left as an uncited general statement.

### C. “RL generalization is limited / high training cost”

You do cite representative RL works, which is good, but this is a general claim. If you want it to read as a field-level statement rather than “in these three papers,” consider adding a survey-style citation (or keep it explicitly scoped to your cited works). Your current conclusion text already mirrors the framing in your chapter draft, so this is not “wrong,” just a question of rhetorical strength.

## 3) Redundancy and readability

### A. Reduce repeated contrast structures

Several paragraphs repeat “In contrast…” and restate the same triad (RL vs zero-shot vs mapping). In the conclusion, you can compress:

* One paragraph for “two dominant families + mapping trend”
* One paragraph for “gap: missing unified exploration–memory control + multi-source evidence fusion”
* One paragraph for “what SAGE contributes + what experiments show”
  Your current conclusion in the PDF is already tighter than your earlier draft, but you can still remove one layer of repetition around “persistent maps reduce redundancy.”

### B. Tighten phrasing of contributions

This sentence is doing too much at once: “combines frontier-based exploration with persistent semantic memory and vision-language reasoning…” Consider listing contributions as parallel noun phrases:

* Hybrid exploration–memory integration (frontiers + persistent map)
* Unified graph-node abstraction for multi-source hypotheses
* Noisy-Or multi-source fusion for detection robustness
* ROS2 multi-rate deployment characterization (VRAM + loop frequencies)
  This also helps reviewers quickly extract novelty.

## 4) Coherence check across chapters (important)

Two internal coherence points to address explicitly:

1. **Benchmark framing**: Your results chapter already states the setup differs (IsaacSim vs HabitatSim). Keep that disclaimer close to any “outperforms” language, including in the conclusion and abstract-level statements.

2. **Fusion semantics**: You position OpenFusion as “semantic memory” and also discuss noisy maps / false positives. Make sure the reader understands *where* false positives originate (open-vocab perception and thresholding) vs. *where* fusion happens (TSDF fusion + your graph node fusion). Otherwise, “noisy due to imperfect fusion” can be read as blaming the mapping backend rather than the upstream semantic signal quality.

## 5) Small but material presentation issues

* In the results chapter excerpt, you still have `Table ??` near Experiment 1. That will get flagged immediately in review. Fix all unresolved refs early.
* Be consistent with naming: “SAGE” vs “the proposed framework,” “semantic map” vs “semantic memory,” “VLM similarity” vs “ValueMap score.” In the conclusion, pick one term per concept.

If you want, paste your *current* “Summary and Outlook” LaTeX (the version you will submit), and I’ll mark up sentence-level edits (what to delete, what to soften, and where to add explicit cross-references to your own experiments/appendix).
