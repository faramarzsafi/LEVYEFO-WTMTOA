
# LEVYEFO-WTMTOA: A Hybrid Optimization Algorithm

This repository provides the official implementation of **LEVYEFO-WTMTOA**, a novel hybrid metaheuristic for solving complex engineering and global optimization problems. It combines the strengths of:

- 🧭 **Multi-Tracker Optimization Algorithm (MTOA)**
- 🌐 **Electromagnetic Field Optimization (EFO)**
- 🔀 **Levy Flights** for stochastic jumps
- 📉 **Morlet Wavelet Transform** for adaptive search radius control

---

## 📄 Publication

📘 *The Journal of Supercomputing*, Springer Nature, 2025  
📝 DOI: [10.1007/s11227-024-06856-6](https://doi.org/10.1007/s11227-024-06856-6)  
📤 Volume 81, Article 432

---

## 🧠 Algorithm Summary

**LEVYEFO-WTMTOA** overcomes challenges in high-dimensional optimization by:

- Escaping local optima with **Levy flights**
- Dynamically balancing **exploration and exploitation**
- Refining local solutions through **GT–LT** structure in MTOA
- Adjusting search space using **Morlet wavelets**

It is benchmarked on the CEC2018 functions and tested on **spring design** and **welded beam** engineering problems.

---

## 📦 Repository Contents

```bash
LEVYEFO-WTMTOA/
├── IMTOA_DP3.m         # Core MTOA implementation
├── EFO.m               # Electromagnetic field optimization logic
├── initialization.m    # Initializes population
├── New_GT.m            # Generates new global trackers
├── insert_in_pop.m     # Population update strategy
├── cec17_func.cpp      # CEC benchmark function (requires MEX)
├── diagram.png         # Algorithm schematic diagram
├── README.md
```

---

## ⚙️ Requirements

- MATLAB R2020b or later
- Compiler for MEX files (Windows: Visual Studio, Linux/macOS: GCC)
- CEC2018 Benchmark Suite setup (included: `cec17_func.cpp`)

---

## ▶️ How to Run

1. Open `IMTOA_DP3.m` or `EFO.m` in MATLAB.
2. Ensure MEX files are compiled:
   ```matlab
   mex cec17_func.cpp
   ```
3. Run the hybrid optimization:
   ```matlab
   LEVYEFO_WTMTOA()
   ```

4. To test on:
   - **CEC2018 functions**: execute `IMTOA_DP3.m`
   - **Engineering problems**: modify target function in `EFO.m`

---

## 📊 Benchmark & Case Study Results

- 🚀 **CEC2018**: Avg. 20–34% mean error improvement over EFO, MTOA, GSA, COA, MEFO, and MVOLevy
- 🛠️ **Spring Design**: Max. cost reduction of 31.03%
- 🏗️ **Welded Beam**: Cost improvement of 32.15%

---

## 🧾 Citation

If you use this code or algorithm in your work, please cite:

```bibtex
@article{SafiEsfahani2025LEVYEFO,
  title={LEVYEFO-WTMTOA: the hybrid of the multi-tracker optimization algorithm and the electromagnetic field optimization},
  author={Safi-Esfahani, Faramarz and Mohammadhoseini, Leili and Larian, Habib and Mirjalili, Seyedali},
  journal={The Journal of Supercomputing},
  volume={81},
  number={432},
  year={2025},
  publisher={Springer},
  doi={10.1007/s11227-024-06856-6}
}
```

---

## 👨‍🔬 Authors

- **Faramarz Safi-Esfahani** — University of Technology Sydney (Corresponding Author)  
- **Leili Mohammadhoseini**, **Habib Larian** — Islamic Azad University, Iran  
- **Seyedali Mirjalili** — Torrens University Australia

---

## 📬 Contact

For questions, please contact:  
📧 faramarz.safi@yahoo.com

---

## 📘 License

This project is released for academic research purposes. Please cite the paper if used in any publication or project.
