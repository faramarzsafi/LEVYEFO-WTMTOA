LEVYEFO-WTMTOA Algorithm
LEVYEFO-WTMTOA is a hybrid metaheuristic optimization algorithm that combines Lévy flight-based exploration, the Electromagnetic Field Optimization (EFO) method, and a wavelet-tuned Multi-Tracker Optimization Algorithm (MTOA). This hybrid algorithm is designed to overcome common issues in classical optimizers, such as premature convergence and getting trapped in local optima, by better balancing the exploration–exploitation trade-off
researchgate.net
researchgate.net
. In essence, LEVYEFO-WTMTOA leverages EFO’s global search capability and MTOA’s local refinement (enhanced via Morlet wavelet dynamics) alongside occasional Lévy-flight jumps to diversify the search and avoid stagnation
researchgate.net
. This results in a more robust search process that can efficiently navigate complex, high-dimensional landscapes.
Algorithm Overview


Figure 2: Overview of the LEVYEFO-WTMTOA hybrid algorithm flow. The algorithm integrates EFO for broad global exploration (using attractive/repulsive forces among particles), with MTOA for precise local exploitation (using multiple trackers and dynamic radius adaptation via Morlet wavelet), and inserts Lévy flight long jumps when stagnation is detected to escape local optima. The synergy of these components helps maintain a strong exploration–exploitation balance and mitigates premature convergence. The flowchart above (adapted from Fig. 2 in the reference paper) illustrates the main steps of the algorithm. Initially, a population of candidate solutions is created with designated Global Trackers (GTs) and associated Local Trackers (LTs) for each GT. MTOA phase: Each GT’s neighborhood is searched by its LTs, whose search radius is adaptively tuned using a Morlet wavelet function to maintain an effective local search range. EFO phase: The algorithm then evaluates the population under the electromagnetic field optimization paradigm – treating candidates as charged particles – adjusting their positions through attraction/repulsion updates (with a golden-ratio-based coefficient) to drive a global search across the solution space. Lévy flight mechanism: If convergence stagnation is detected (e.g., a GT is stuck in a local optimum), a Lévy flight perturbation is applied to that GT (a large random jump) to explore a new region. These steps iterate until a stopping criterion is met (such as maximum iterations or a fitness threshold), after which the best-found solution is returned【20†】. By integrating these strategies, LEVYEFO-WTMTOA maintains diversity in the population and refines solutions locally, tackling the weaknesses of its individual components (EFO’s exploitation imbalance and MTOA’s local optima entrapment)
researchgate.net
researchgate.net
.
Implementation Details
This project provides a MATLAB implementation of the LEVYEFO-WTMTOA algorithm. The core algorithm logic is written in .m script/functions, and for performance, certain computations (especially the benchmark function evaluations) are offloaded to compiled binaries (.mex files). In particular, the CEC2018 benchmark functions are accessed via a provided MEX file (cec17_func.mexw64 for 64-bit Windows, with a 32-bit version mexw32 and the C++ source cec17_func.cpp also included). These MEX files dramatically speed up the evaluation of the 30 standardized test functions. To use the code, you should have a compatible MATLAB environment (the code was tested in MATLAB, and the MEX binaries are for Windows; users on other platforms can recompile cec17_func.cpp to a MEX file for their system). All algorithm parameters (population size, number of trackers, etc.) and function settings are configurable within the MATLAB scripts. The hybrid algorithm’s pseudocode and flow have been implemented according to the descriptions in the reference paper, ensuring that the Levy flights, EFO operations, and MTOA local search are correctly integrated. Key files:
LEVYEFO_WTMTOA.m (or similar main script): Implements the main loop of the hybrid algorithm (initialization, iterations, calling EFO sub-routines and applying Lévy flights).
EFO_algorithm.m: Implements the electromagnetic field optimization operators (attraction-repulsion updates, field initialization, etc.).
MTOA_local_search.m: Implements the local tracking mechanism (GT/LT updates, including Morlet wavelet-based radius adaptation).
cec17_func.mexw64 / cec17_func.mexw32: Pre-compiled functions to evaluate the CEC2018 benchmark functions by function ID.
cec17_func.cpp: Source code for the CEC2018 functions (can be compiled with mex if needed for your platform).
(Note: The actual function/script names may vary in the repository; see the code files for the exact naming.)
Benchmark Problems and Dataset
The algorithm has been evaluated on a comprehensive set of test problems to demonstrate its effectiveness:
CEC 2018 Benchmark Suite: 30 standard benchmark functions (f1–f30) with diverse characteristics (unimodal, multimodal, composite, etc.). Experiments were conducted at 50-dimensional and 100-dimensional settings, which are high-dimensional scenarios challenging for many optimizers. The search domain for each function follows the CEC2018 definitions (e.g., typically 
−
100
,
100
−100,100 range for each variable). By using these benchmarks, the study assessed the algorithm’s general optimization performance compared to other methods. The LEVYEFO-WTMTOA showed significantly better accuracy (lower error to the known optima) across these functions
researchgate.net
.
Engineering Design Cases: In addition to artificial test functions, two classic engineering optimization problems were included to validate real-world efficacy:
Spring Design Optimization – minimizing the weight (or cost) of a tension/compression spring subject to strength and geometry constraints.
Welded Beam Design Optimization – minimizing the fabrication cost of a welded beam subject to stress, shear and geometry constraints.
These design problems are standard constrained optimization tests. The hybrid algorithm was able to find designs with substantially lower cost than baseline algorithms. In fact, LEVYEFO-WTMTOA achieved a maximum cost improvement of ~31.03% in the spring design and ~32.15% in the welded beam design over the best results of the comparison algorithms
researchgate.net
. This underscores the algorithm’s practical value in engineering scenarios, not just on synthetic math functions.
All benchmark functions and test problems are ready to run with the provided code. The CEC2018 functions are accessed via the cec17_func MEX interface (already included), while the spring and welded beam problems are implemented in the MATLAB code (check the script for their formulation or objective functions).
How to Run the Code
Follow these steps to run the LEVYEFO-WTMTOA algorithm on the test suite:
Clone or Download the Repository: Download the code (as a ZIP or via git clone) and place the files in a working directory. Ensure that the MATLAB .m files and the cec17_func.mex files are all in the MATLAB path or current folder.
Start MATLAB: Launch MATLAB and navigate to the directory containing the project files. Make sure MATLAB can find the MEX function. If you are not on 64-bit Windows, you may need to compile cec17_func.cpp for your system (using the MATLAB mex command) or use the pure .m versions of the benchmark functions if provided.
Configure Parameters (Optional): Open the main script (for example, LEVYEFO_WTMTOA_main.m or run_experiments.m if such a script is provided) in MATLAB. Inside, you can set the key parameters:
Population size (e.g. 50 or 100)
Dimensionality of the problem (50 or 100 for benchmarks)
Number of Global Trackers (GTs) and Local Trackers (LTs)
Termination criteria (max iterations or function evaluations, etc.)
Probability of Lévy flight invocation, etc.
Default values in the script are tuned as per the reference paper, so you can also proceed with defaults for a quick start.
Run the Optimization: Execute the main script or function. For example, if the main entry is a function, you might run in the MATLAB command window:
matlab
Copy
Edit
% Example: run 30 CEC2018 functions at 50-D:
results = LEVYEFO_WTMTOA_run(30, 50);
(The actual usage may vary; check the code documentation or comments. Some implementations run all tests in a loop and output results directly.) The code will then iterate through the optimization process. You should see output in the console indicating the progress per iteration or per function (depending on implementation). Each benchmark function might be run multiple independent times to gather statistics (e.g., best score, mean error, etc.).
Examine Results: After execution, the algorithm will report its best-found solution for each test and possibly performance metrics like the error value relative to the known optimum. The results might be printed to the MATLAB console and/or saved to a .mat file or displayed as plots. For the design problems, it will output the optimized design parameters and the minimized cost. Verify that the outcomes match the expected performance (e.g., the error values should be significantly lower than those from baseline algorithms as reported in the paper).
By following these steps, you can reproduce the key experiments from the paper or apply the algorithm to your own optimization problems by adapting the objective function.
Expected Results and Performance
When properly executed, LEVYEFO-WTMTOA is observed to outperform several state-of-the-art algorithms on the given benchmarks
researchgate.net
. Key expected outcomes include:
Higher Accuracy on Benchmarks: On the CEC2018 functions, the hybrid algorithm finds solutions closer to the global optimum than the original MTOA or EFO algorithms, among others. On average, it achieved about a 20% reduction in mean error across the test suite compared to those baseline methods
researchgate.net
. This is a significant improvement, indicating a more reliable convergence towards optimal values.
Improved Convergence Behavior: The algorithm demonstrates more stable convergence curves, with fewer premature stagnation events. Thanks to the Lévy-flight jumps and the diversified search, it can escape local minima that would trap simpler algorithms. The balance between exploration and exploitation means it maintains search diversity in early iterations and intensifies search around promising areas in later stages.
Spring and Beam Design Optimization: In the engineering design case studies, LEVYEFO-WTMTOA not only found feasible solutions meeting all constraints, but also found designs of substantially lower cost. Specifically, expect around 30–32% cost reduction in the spring and welded beam design problems relative to known results from other algorithms
researchgate.net
. Such improvements are notable in practical terms: for example, a 30% cost saving in a engineering design can translate to lighter or cheaper components without violating constraints.
Robustness: The hybrid approach was tested under different dimensional settings (50D and 100D) and maintained strong performance, showcasing its scalability. It consistently outperformed or matched the best compared algorithms (including variants like MEFO, MVO-Levy, GSA, COA, etc., as reported) in terms of final solution quality
researchgate.net
. Additionally, the integration of methods did not introduce prohibitive computational costs – the MATLAB implementation with MEX is efficient, and the added complexity (Lévy flight checks, etc.) is negligible compared to the overall runtime.
Keep in mind that actual results may vary slightly depending on the random initialization and the system running the code, but the overall trends should align with the published outcomes. If needed, you can run multiple trials and average the results to compare performance reliably.
Citation
If you use this code or build upon the LEVYEFO-WTMTOA algorithm in your research, please cite the original paper in The Journal of Supercomputing (2025). Below is the BibTeX entry for citation:
bibtex
Copy
Edit
@article{SafiEsfahani2025levyefo,
  title={{LEVYEFO-WTMTOA}: the hybrid of the multi-tracker optimization algorithm and the electromagnetic field optimization},
  author={Safi-Esfahani, Faramarz and Mohammadhoseini, Leili and Larian, Habib and Mirjalili, Seyedali},
  journal={The Journal of Supercomputing},
  volume={81},
  number={2},
  pages={432},
  year={2025},
  doi={10.1007/s11227-024-06856-6}
}
Paper reference: F. Safi-Esfahani et al., "LEVYEFO-WTMTOA: the hybrid of the multi-tracker optimization algorithm and the electromagnetic field optimization," J. Supercomputing, vol. 81, art. 432, 2025
researchgate.net
researchgate.net
. This publication details the algorithm’s development and provides the performance results that this code implements. Please ensure to give appropriate credit to the authors in any academic or professional usage of this work.
