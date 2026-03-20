# Economic Value of Product Advertising with Video
### An A/B Testing Case Study in E-Commerce

----

## Business Problem
A mid-size U.S. women's fashion retailer (~$300M revenue, 300+ stores) 
wanted to measure the causal impact of product videos on e-commerce sales. 
The retailer's website hosts 571 products exclusive to the online channel. 

<img width="931" height="562" alt="image" src="https://github.com/user-attachments/assets/fbd3f0ef-c6d8-4fb0-a3eb-9de6e04630b8" />
----

## Experimental Design
A randomized field experiment was conducted over 28 weeks (January–July).

- **571 total products** across tops, dresses, bottoms, accessories, footwear
- **66 principal products** randomly assigned to receive 15–20 second videos
- Videos featured a human model in a 360° view alongside coordinating products
- Treatment rolled out in **3 staggered waves** to control for seasonal effects
- Two experiments run simultaneously:
  - **Experiment 1:** Effect of video on focal product sales
  - **Experiment 2:** Effect of video on coordinating product sales (spillover)
---

## Data
| Sheet | Description | Rows |
|-------|-------------|------|
| `Random Check` | Product-level data for randomization validation | 297 products |
| `FP Analysis data` | Weekly sales data for focal products | 6,828 product-weeks |
| `CP Analysis data` | Weekly sales data for coordinating products | 4,708 product-weeks |

-----

## 1. Experiment Validation — Was the Randomization Done Correctly?

### Approach
Two statistical tests were conducted to verify that the treatment 
and control groups were statistically equivalent **before** the 
experiment began:

| Test | What It Checks | Method |
|------|---------------|--------|
| Price Balance | Were similarly priced products equally distributed across groups? | Independent samples t-test |
| Category Balance | Did the treatment group mirror the full product mix (tops/dresses/bottoms)? | Chi-square goodness-of-fit |

-----

### Results

**Test 1 — Price Balance (t-test)**

| Group | N | Mean Price | Std Dev |
|-------|---|-----------|---------|
| Treatment (video) | 58 | $20.71 | $5.51 |
| Control (no video) | 239 | $20.42 | $4.68 |
```
t-statistic = 0.41 | p-value = 0.683
```
✅ No significant price difference between groups

**Test 2 — Category Balance (Chi-square)**

| Category | Overall % | Expected in Treatment | Observed in Treatment |
|----------|-----------|----------------------|----------------------|
| Tops | 65.3% | 37.89 | 40 |
| Dresses | 29.6% | 17.19 | 16 |
| Bottoms | 5.1% | 2.93 | 2 |
```
χ² = 0.49 | df = 2 | p-value = 0.781
```
✅ Category mix in treatment group mirrors the full product pool

### Conclusion
Both tests pass comfortably (p >> 0.05). The treatment and control 
groups are **statistically indistinguishable** on price and product 
category — confirming that the randomization was conducted correctly 
and the experiment results can be trusted as causal evidence.

------------------------------------------------------------------------------------------
## Business Question 1: Does putting a video on a product's page actually increase that product's own sales?

## Data: FP_Analysis data: The focal product analysis uses weekly sales data across all 

### Method 1 — Difference-in-Means (DiM)

**Approach:** Compare average weekly sales during video-on 
weeks directly against all other weeks.
---
DiM = Mean Sales (VidWk=1) − Mean Sales (VidWk=0)
    = 131.98 − 103.57
    = +28.41 units/week

The Hypotheses for the t-test in the DiM
H0: mean sales (VidWk=1)− mean sales(VidWk=0) =0
H1: mean sales (VidWk=1)− mean sales(VidWk=0) != 0

t-statistic = 3.803 | p-value < 0.001 → Reject H₀ 

### Method 2 - Regression based estimate

OLS Model: Sales ~ VidWk + PriceDiscWk + EmailWk + CatalogWk + HomePgWk + CatPgWk

<img width="721" height="553" alt="image" src="https://github.com/user-attachments/assets/0598a65f-1f5f-4a38-8a2f-1e928945307d" />
**Interpretation:** After controlling for all other promotional activities, a product video being live is associated with 
**26.29 additional units sold per week** (p < 0.001). This is the video's **pure, isolated effect** on sales.

### DiM vs Regression — Which Should the Business Trust?

Regression Controls for other promotions?** | ✅ Yes |
Recommended for decision-making? | ✅ Yes |
Some video-on weeks may have coincidentally overlapped with other promotional activities — catalog drops, email blasts, homepage features — that also boost sales independently. The regression mathematically 
separates the video's contribution from every other promotion.

-----------------------------------------------------------------------------------------

  ### Business Question 2: does a focal product's video also lift sales of the coordinating products shown in it — even though those products never got their own video?

  A coordinating product can appear alongside **multiple focal products** simultaneously. For example, a pair of sunglasses might be paired with:
- A top that **has** a video → sunglasses are "exposed"
- A dress that **has no** video → sunglasses are "not exposed"
This changes **week by week** depending on which focal product videos are live. A simple treated/control label isn't enough — we need to track exposure at the weekly level.

**Solution:** A variable `VidWk` was created at the coordinating product level:
`VidWk = 1` in any week where **at least one** associated focal product has its video switched on
`VidWk = 0` in all other weeks
Note: To isolate the spillover effect cleanly, 20 coordinating products that had **their own video** were removed (to avoid double-counting).

## Data: CP_Analysis data:

| Group | N | Description |
|-------|---|-------------|
| Treatment | 62 products | Associated focal product has a video |
| Control | 134 products | Associated focal product has no video |
| Dropped | 20 products | Have their own video — removed to avoid contamination |
| **Total** | **196 products** | **4,708 weekly observations** |

---
### Approach — OLS Regression
A regression model was used to isolate the video spillover effect 
while controlling for **two sets** of promotions simultaneously:
```
CpSales ~ VidWk 
        + FpPriceDiscWk + FpEmailWk + FpCatalogWk + FpHomePgWk + FpCatPgWk
        + CpPriceDiscWk + CpEmailWk + CpCatalogWk + CpHomePgWk + CpCatPgWk
```

**Why two sets of controls?**

| Control Set | Why Needed |
|-------------|-----------|
| Focal product promotions (Fp___) | A catalog drop on the focal product drives traffic that might spill over to the coordinating product |
| Coordinating product promotions (Cp___) | Direct promotions on the coordinating product itself must be separated from the video spillover |

## Results

<img width="975" height="747" alt="image" src="https://github.com/user-attachments/assets/85b1a51b-e002-4355-8f6e-5a6a29966cc5" />

Interpreting the CP Treatment Effect (+17.95): When a focal product video is live, its associated coordinating products sell 17.95 units per week more on average after controlling for all promotions on both the focal and coordinating products. This is statistically significant with p-value < 0.001.

### Key Takeaways from the Comparison

**1. Absolute effect is larger for focal products**
The video directly advertises the focal product — it gets a 
+26.29 unit lift vs +17.95 for coordinating products. This makes 
intuitive sense: the focal product is the star of the video.

**2. Relative effect is nearly identical (~25% for both)**
When expressed as a share of each product's typical weekly sales, 
the lift is virtually the same. A video is just as powerful, 
proportionally, at lifting a product it *indirectly* features as 
one it *directly* advertises.

**3. Every video delivers a free bonus**
The retailer pays to produce one video for the focal product but 
gets a significant sales boost on coordinating products at no 
extra cost. This dramatically increases the total ROI of each 
video produced.
